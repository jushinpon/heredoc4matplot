use POSIX;
use Math::Trig;
use  Cwd;
my $currentpath = getcwd();
my $out_file = `cat *.sout`;
my @P= `grep "P=" *.sout | awk '{print \$6}'`;
my @ERy= `grep "!" *.sout | awk '{print \$5}'`;
chomp (@P);
chomp (@E);
# chomp (@D);
open my $type_data ,"> ./stress.raw";
for(0..$#P){  
    my $a=$_+1;
    my $EkeV=$ERy[$_]*0.013605684958731;
    # print $type_data "$a\n ";
    # print $type_data "$P[$_]\n";
    print $type_data "$a\t  $P[$_]\t $EkeV\n";
}
my $output_file_name= "stress_totalenergy.py";
my %plot_png_para = (
    output_file => $output_file_name,
);
&plot_png(\%plot_png_para);

sub plot_png
{
my ($plot_png_hr) = @_;
my $plot_png = <<"END_MESSAGE";
import matplotlib.pyplot as plt
import numpy as np

f=np.loadtxt("./stress.raw")
X=f[:,:1]
P=f[:,1:2]
E=f[:,2:3]
fig, ax1 = plt.subplots()
ax1.set_xlabel('Strain',fontweight='bold')
ax1.set_ylabel('Stress (kbar)',color='black',fontweight='bold')
lns1=ax1.plot(X,P,label='Stres',color='black',marker='o',markevery=5)
ax2 = ax1.twinx()
ax2.set_ylabel('total energy (keV)',color='black',fontweight='bold') 
ax2.ticklabel_format(useOffset=False, style='plain')
lns2=ax2.plot(X,E,label='total energy',color='blue',marker='v',markevery=5)
ax2.tick_params(axis='y')
lns=lns1+lns2
labs=[l.get_label() for l in lns]
plt.legend(lns, labs, loc='upper right',fontsize=9)
plt.savefig("stress.png") 
plt.show()
END_MESSAGE

    open(FH, '>', $plot_png_hr->{output_file}) or die $!;
    print FH $plot_png;
    close(FH);
    chdir("$currentPath");
    system("python $plot_png_hr->{output_file}");
}




