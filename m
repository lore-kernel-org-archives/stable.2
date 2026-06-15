Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AB21990C7;
	Mon, 15 Jun 2026 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519999; cv=none; b=jlc82U6UXLkiFnEDxYzDGj2l8VEEglWAf/IOcmsCkprniqq2LIcnkLs1PEEU94CEVrTwABICWlGDvSr1Rk6Hdyh2IbG0qgc+tRe7nF7pMHzpiPDVUrt5+3IcHNXGIOjyMNAfYajsNhYefXmJR70q0z0IVIHWaAFZOeNGHH7urJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519999; c=relaxed/simple;
	bh=pjPunVM0Lju5iCYpWfHWOCfJjBSSKWp+2Ebpbpdwyzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+rHAceLbIsU6uqFH0x+Llm8PcwvzB2KKU2g6cnt6ayNf6bNukkxnQzu0zWhBYANIhLppB/WWn1avt1tiqYTCeCRFYC/oVy1sa1LuNpxbsQdy+Bz7gRvup7wwh2cTmIZwF0cY3WCXJhyPlOLEXEFKgQ+28PL4yqfhSH2KxJ75AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=iPDF9ezI; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="iPDF9ezI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=GFlRp
	zpDSFpH2nXPFhy658PC3HdI4pPCMhyiMaEt5+o=; b=iPDF9ezIPMCnyryfxg9vi
	Ab68Jc4ez7nJR6APfcaSS8CI116I7wnPwRo88mtTam3AkwukvXafC6fewza0OifO
	P/E/LVtUszh85noQoKe2zuTMcVjAMl9UWVQBccph/Vz4nZYaj3Pnn0A+ziowFsge
	Qx2TFqTLuLZDc5Z3V/2l/s=
Received: from DESKTOP-35NLEVI (unknown [166.111.239.35])
	by web5 (Coremail) with SMTP id zAQGZQDXYLtp1i9qZENxAg--.8653S2;
	Mon, 15 Jun 2026 18:39:37 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kito Xu <veritas501@foxmail.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] appletalk: fix use-after-free in atalk_find_primary()
Date: Mon, 15 Jun 2026 18:39:28 +0800
Message-ID: <20260615103930.1484-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zAQGZQDXYLtp1i9qZENxAg--.8653S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfKFy7Ary5ur48Ar1UKFg_yoWrXF4xpF
	W7urWqka4DX34Ygr4DJrW7AF15Cry8K3y3Cr1rG3W0yrn0gr9a9a40yryavFnIkr97GrZ5
	JryxK3s7ZF4UCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOv38UUUU
	U
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQETAWovr0JGUAAAss

atalk_find_primary() walks the global AppleTalk interface list under=0D
atalk_interfaces_lock, but returns a pointer to iface->address after=0D
dropping that lock.  Both atalk_autobind() and atalk_bind() then=0D
dereference the returned pointer without any lifetime protection.=0D
=0D
The interface can be removed concurrently through the normal AppleTalk=0D
interface ioctl path.  SIOCATALKDIFADDR calls atalk_dev_down(), which=0D
eventually reaches atif_drop_device() and frees the same struct=0D
atalk_iface that owns the returned address field.  A racing bind can=0D
therefore read from freed memory.=0D
=0D
This is reachable with a configured AppleTalk interface; reproducing the=0D
race does not require a malicious device or driver.  The configuration=0D
ioctls require CAP_NET_ADMIN in the initial user namespace, and=0D
AF_APPLETALK sockets are limited to init_net.=0D
=0D
Fix the lifetime issue without changing the returned address pointer=0D
type.  Rename the helper to atalk_find_primary_locked() and keep=0D
atalk_interfaces_lock held across the return.  The callers now copy=0D
s_net and s_node while the lock is still held, then immediately release=0D
the lock before doing any further work.=0D
=0D
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")=0D
Cc: stable@vger.kernel.org=0D
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>=0D
Reported-by: Ao Wang <wangao@seu.edu.cn>=0D
Reported-by: Xuewei Feng <fengxw06@126.com>=0D
Reported-by: Qi Li <qli01@tsinghua.edu.cn>=0D
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>=0D
Assisted-by: GLM:GLM-5.1=0D
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
---=0D
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c=0D
index 30a6dc06291c..4d6576cd0ae8 100644=0D
--- a/net/appletalk/ddp.c=0D
+++ b/net/appletalk/ddp.c=0D
@@ -351,7 +351,7 @@ struct atalk_addr *atalk_find_dev_addr(struct net_devic=
e *dev)=0D
 	return iface ? &iface->address : NULL;=0D
 }=0D
 =0D
-static struct atalk_addr *atalk_find_primary(void)=0D
+static struct atalk_addr *atalk_find_primary_locked(void)=0D
 {=0D
 	struct atalk_iface *fiface =3D NULL;=0D
 	struct atalk_addr *retval;=0D
@@ -378,7 +378,6 @@ static struct atalk_addr *atalk_find_primary(void)=0D
 	else=0D
 		retval =3D NULL;=0D
 out:=0D
-	read_unlock_bh(&atalk_interfaces_lock);=0D
 	return retval;=0D
 }=0D
 =0D
@@ -1132,20 +1131,24 @@ static int atalk_autobind(struct sock *sk)=0D
 {=0D
 	struct atalk_sock *at =3D at_sk(sk);=0D
 	struct sockaddr_at sat;=0D
-	struct atalk_addr *ap =3D atalk_find_primary();=0D
+	struct atalk_addr *ap =3D atalk_find_primary_locked();=0D
 	int n =3D -EADDRNOTAVAIL;=0D
 =0D
 	if (!ap || ap->s_net =3D=3D htons(ATADDR_ANYNET))=0D
-		goto out;=0D
+		goto unlock_and_out;=0D
 =0D
 	at->src_net  =3D sat.sat_addr.s_net  =3D ap->s_net;=0D
 	at->src_node =3D sat.sat_addr.s_node =3D ap->s_node;=0D
+	read_unlock_bh(&atalk_interfaces_lock);=0D
 =0D
 	n =3D atalk_pick_and_bind_port(sk, &sat);=0D
 	if (!n)=0D
 		sock_reset_flag(sk, SOCK_ZAPPED);=0D
 out:=0D
 	return n;=0D
+unlock_and_out:=0D
+	read_unlock_bh(&atalk_interfaces_lock);=0D
+	goto out;=0D
 }=0D
 =0D
 /* Set the address 'our end' of the connection */=0D
@@ -1165,14 +1168,15 @@ static int atalk_bind(struct socket *sock, struct s=
ockaddr_unsized *uaddr, int a=0D
 =0D
 	lock_sock(sk);=0D
 	if (addr->sat_addr.s_net =3D=3D htons(ATADDR_ANYNET)) {=0D
-		struct atalk_addr *ap =3D atalk_find_primary();=0D
+		struct atalk_addr *ap =3D atalk_find_primary_locked();=0D
 =0D
 		err =3D -EADDRNOTAVAIL;=0D
 		if (!ap)=0D
-			goto out;=0D
+			goto unlock_and_out;=0D
 =0D
 		at->src_net  =3D addr->sat_addr.s_net =3D ap->s_net;=0D
 		at->src_node =3D addr->sat_addr.s_node =3D ap->s_node;=0D
+		read_unlock_bh(&atalk_interfaces_lock);=0D
 	} else {=0D
 		err =3D -EADDRNOTAVAIL;=0D
 		if (!atalk_find_interface(addr->sat_addr.s_net,=0D
@@ -1201,6 +1205,9 @@ static int atalk_bind(struct socket *sock, struct soc=
kaddr_unsized *uaddr, int a=0D
 out:=0D
 	release_sock(sk);=0D
 	return err;=0D
+unlock_and_out:=0D
+	read_unlock_bh(&atalk_interfaces_lock);=0D
+	goto out;=0D
 }=0D
 =0D
 /* Set the address we talk to */=0D
=0D
--=0D
2.43.0=

