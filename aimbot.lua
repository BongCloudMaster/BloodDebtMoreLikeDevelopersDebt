-- Decompiled with the Synapse X Luau Decompiler.
-- get it?
local a=game:GetService'Players'local b=game:GetService'RunService'local c=game:
GetService'UserInputService'local d=game:GetService'Workspace'local e=false
local f=a.LocalPlayer local g=os local h=g.clock local i=task local j=i.cancel
local k=i.defer local l=i.delay local m=i.spawn local n=math local o=n.abs local
p=n.atan2 local q=n.cos local r=n.clamp local s=n.max local t=n.pi local u=n.rad
local v=n.sin local w=n.sqrt local x=5e-3 local y,z,A,B=2*t,t/2,t/3,t/4 local C,
D=Vector3.new(1,0,1),Vector3.zero do Vector3.new(0,1,0)Vector3.new(1,0,0)Vector3
.new(0,0,1)end local E do E=setmetatable({},{__tostring=function()return
'Connection'end})E.__index=E function E.new(...)local F=setmetatable({},E)return
F:constructor(...)or F end function E.constructor(F,G,H)if H==nil then H=true
end F.disconnect=G F.Connected=H end function E.Disconnect(F)F.disconnect()F.
Connected=false end end local F do F=setmetatable({},{__tostring=function()
return'Bin'end})F.__index=F function F.new(...)local G=setmetatable({},F)return
G:constructor(...)or G end function F.constructor(G)end function F.add(G,H)local
I={item=H}if G.head==nil then G.head=I end if G.tail then G.tail.next=I end G.
tail=I return H end function F.destroy(G)while G.head do local H=G.head.item if
type(H)=='function'then H()elseif typeof(H)=='RBXScriptConnection'then H:
Disconnect()elseif type(H)=='thread'then task.cancel(H)elseif isrenderobj(H)then
H:Destroy()elseif H.destroy~=nil then H:destroy()elseif H.Destroy~=nil then H:
Destroy()elseif H.disconnect~=nil then H:disconnect()elseif H.Disconnect~=nil
then H:Disconnect()elseif H.cancel~=nil then H:cancel()end G.head=G.head.next
end G.tail=nil end function F.isEmpty(G)return G.head==nil end end
local function expectChild(G,H,I)if I==nil then I=1e4 end local J=H local K=J[1]
local L=J[2]local M=if L==nil then function(M)return M:IsA(K)end else function(M
)return M.Name==L and M:IsA(K)end for N,O in G:GetChildren()do if M(O)then
return O end end local N local O=coroutine.running()local P,Q=G.ChildAdded:
Connect(function(P)if M(P)then N=P m(O)end end),l(I,function()return m(O)end)
coroutine.yield()if N then j(Q)end if P.Connected then P:Disconnect()end return
N end local function forChildThen(G,H,I,J)if J==nil then J=9e9 end local K=H
local L=K[1]local M=K[2]local N=if M==nil then function(N)return N:IsA(L)end
else function(N)return N.Name==M and N:IsA(L)end for O,P in G:GetChildren()do if
N(P)then m(I,P)J-=1 if J==0 then return E.new(function()end)end end end local O
O=G.ChildAdded:Connect(function(P)if N(P)then m(I,P)J-=1 if J==0 then O:
Disconnect()end end end)return E.new(function()if O.Connected then O:Disconnect(
)end end)end local G do G=setmetatable({},{__tostring=function()return
'BaseComponent'end})G.__index=G function G.new(...)local H=setmetatable({},G)
return H:constructor(...)or H end function G.constructor(H,I)H.instance=I H.bin=
F.new()H.bin:add(I.Destroying:Connect(function()return H:destroy()end))end
function G.destroy(H)H.bin:destroy()end end local H do local I=G H=setmetatable(
{},{__tostring=function()return'CharacterRig'end,__index=I})H.__index=H function
H.new(...)local J=setmetatable({},H)return J:constructor(...)or J end function H
.constructor(J,K)I.constructor(J,K)J.health=100 J._subHealth={}local L=
expectChild(K,{'BasePart','HumanoidRootPart'},30)if not L then error(`[CharacterRig]: {
K} is missing HumanoidRootPart`)end local M=expectChild(K,{'BasePart','Head'},30
)if not M then error(`[CharacterRig]: {K} is missing Head`)end local N=
expectChild(K,{'Humanoid','Humanoid'},30)if not N then error(`[CharacterRig]: {K
} is missing Humanoid`)end J.root=L J.head=M J.humanoid=N J.health=N.Health
local O=J local P=O.bin P:add(N:GetPropertyChangedSignal'Health':Connect(
function()return J:onHumanoidHealthChanged()end))m(function()return J:
onHumanoidHealthChanged()end)end function H.onHumanoidHealthChanged(J)local K=J.
humanoid.Health if K==0 then return J:destroy()end J.health=K local L=J.
_subHealth local M=function(M)return m(M,K)end for N,O in L do M(O,N,L)end end
function H.subscribeHealth(J,K)local L={}local M=J local N=M._subHealth local O=
M.bin local P=M.health local Q=K N[L]=Q m(K,P)return O:add(E.new(function()local
R=N[L]~=nil N[L]=nil return R end))end function H.getRoot(J)return J.root end
function H.getHead(J)return J.head end function H.getHumanoid(J)return J.
humanoid end function H.getHealth(J)return J.health end function H.getPivot(J)
return J.instance:GetPivot()end function H.getPosition(J)return J.root.Position
end end local I do local J=G I=setmetatable({},{__tostring=function()return
'PlayerComponent'end,__index=J})I.__index=I function I.new(...)local K=
setmetatable({},I)return K:constructor(...)or K end function I.constructor(K,L)J
.constructor(K,L)local M=I.players local N=L local O=K M[N]=O local P=L.
Character if P then k(function()return K:onCharacter(P)end)end local Q=K local R
=Q.bin R:add(L.CharacterAdded:Connect(function(S)return K:onCharacter(S)end))R:
add(L.CharacterRemoving:Connect(function()local S=K.character if S~=nil then S=S
:destroy()end return S end))R:add(a.PlayerRemoving:Connect(function(S)return L==
S and K:destroy()end))R:add(function()local S=I.players local T=L local U=S[T]~=
nil S[T]=nil return U end)end function I.onCharacter(K,L)K.character=H.new(L)end
I.players={}end local J={}do local K=J local L local M=function(M)local N=L if N
~=nil then N:destroy()end L=H.new(M)end local N=function()local N=L if N~=nil
then N:destroy()end L=nil end local function __init__()f.CharacterAdded:Connect(
M)f.CharacterRemoving:Connect(N)local O=f.Character if O then m(M,O)end end K.
__init__=__init__ local function getRoot()local O=L if O~=nil then O=O:getRoot()
end return O end K.getRoot=getRoot local function getHumanoid()local O=L if O~=
nil then O=O:getHumanoid()end return O end K.getHumanoid=getHumanoid
local function getHealth()local O=L if O~=nil then O=O:getHealth()end return O
end K.getHealth=getHealth local function getPosition()local O=L if O~=nil then O
=O:getPosition()end local P=O if P==nil then P=D end return P end K.getPosition=
getPosition local function getPivot()local O=L if O~=nil then O=O:getPivot()end
local P=O if P==nil then P=CFrame.new()end return P end K.getPivot=getPivot end
local K={}do local L=K local M=function(M)return I.new(M)end local function
__init()forChildThen(a,{'Player'},function(N)return M(N)end)end L.__init=__init
end local L local M={}do local N=M local O local P local Q=false local aa=
function()local R=I.players local S=c:GetMouseLocation()local T local U=-math.
huge local aa=function(V)local W=V.character if W==nil then return nil end local
X=W if X==nil then return nil end local Y=W:getPosition()local Z=L.
worldToViewportPoint(Y)if Z.Z<0 then return nil end if e then local _=L.
getPivot().Position P.FilterDescendantsInstances={W.instance,f.Character}local
aa=d:Raycast(_,Y-_,P)if aa then return nil end end local aa=(Vector2.new(Z.X,Z.Y
)-S).Magnitude if aa>300 then return nil end local _=1e3-aa if _>U then T=W U=_
end end for V,W in R do aa(W,V,R)end return T end local function __init()P=
RaycastParams.new()P.FilterType=Enum.RaycastFilterType.Exclude P.IgnoreWater=
true c.InputBegan:Connect(function(R,S)if S then return nil end if R.
UserInputType==Enum.UserInputType.MouseButton2 then O=nil Q=true end end)c.
InputEnded:Connect(function(R,S)if S then return nil end if R.UserInputType==
Enum.UserInputType.MouseButton2 then Q=false end end)b.RenderStepped:Connect(
function()O=aa()if O~=nil then if Q then local R=O:getHead().Position if R then
warn'result found!'local S=c:GetMouseLocation()local T,U=L.worldToViewportPoint(
R)mousemoverel(T.X-S.X/2,T.Y-S.Y/2)end end end end)end N.__init=__init end L={}
do local aa=L local N local O local P local function worldToViewportPoint(Q)
return N:WorldToViewportPoint(Q)end aa.worldToViewportPoint=worldToViewportPoint
local function safeWorldToViewportPoint(Q)local R=N.CFrame local S=R:
PointToObjectSpace(Q)local T=p(S.Y,S.X)+t local U=CFrame.new(0,0,0)local V=
CFrame.Angles(0,0,T)local W=CFrame.Angles(0,z-x,0)local X=(U*V*W).LookVector
local Y=R:PointToWorldSpace(X)local Z=worldToViewportPoint(Y)local _=Vector2.
new(Z.X,Z.Y)local ab=P local ac=(_-ab).Unit local ad=P local ae=ac*1e5 return ad
+ae end aa.safeWorldToViewportPoint=safeWorldToViewportPoint local function
getPivot()return N.CFrame end aa.getPivot=getPivot local function getScreenSize(
)return O end aa.getScreenSize=getScreenSize local function getCamera()return N
end aa.getCamera=getCamera local ab=function()O=N.ViewportSize P=O/2 end local
ac=function()local ac=d.CurrentCamera N=ac N:GetPropertyChangedSignal
'ViewportSize':Connect(ab)ab()end local function __init()d:
GetPropertyChangedSignal'CurrentCamera':Connect(ac)ac()end aa.__init=__init end
J.__init__()K.__init()M.__init()L.__init()return nil
