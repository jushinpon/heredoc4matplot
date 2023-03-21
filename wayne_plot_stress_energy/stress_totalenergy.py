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
