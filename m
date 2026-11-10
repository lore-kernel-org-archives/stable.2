Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333927;
	b=0x/1PNYV/Pb4RLBhc9xR3uePi49dzvNf4CrWAGY7lbDiTCJnTT+Kwb0zSrCk5eN54V/j
	 +mMu0XTDab69NJtmP/NLTJ3oBt4DOZhSESTW9O5coih9zm4jw//sgYBkaqRGJdw7E/D+M
	 /zmzvse9JxBwyevXEK5TmNBQKq7MemzcjNCY74+OOWV0yHPISYSenGN+xTcK5KFdfYE+C
	 KObjlQZo5YXS8MFgPHepd2YcI8TTfGqyF9PtxtpbB9vY1IfTZ1vpoYEIGEWyXqOyhVjfv
	 mYfG+Nfxb4xPV+NxtIz4pUEWlZw6vEXvbD4EGzxQ/FWa9WCHEDHiQ1BiUA3P8TOFSDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333927;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=j6ZjtT5Y3Xo+aoA1MTfUEI5cTfZSflXChpID1Sy9ET4=;
	b=Ij/UwsgcfVO5KBJg84mjFPJYyssn8DvuzMCrU6tF//oBG9CHrDEWMQRR7YJI1mioZP7l
	 slnLcI+UIbKyWO9MiX0SUvg/CfTMQcSCc9Y7BJu4dyca/8gyDC787tOkJ/yJ3pPAVTSNl
	 vHmctb9Fqh7pfzKvoGQymnzspaNBkQdyeVXvpFxQqVestpv/v2mKm5iLckny73+27Shgz
	 rByrnMHkzhF2Km70ZdR4sf7Zfgb8y+ULdc718uOBJXskn7ffB7AIq+yWXriIaaAVD0ORf
	 PurQFkpFJer7PoxNQoPM22UalJVdsJuOK/bJswH21DVKV/q9SZkhYDZAC1VB6QC10Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cQRbAYAp;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RdXBPSpU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B933606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B933606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cQRbAYAp;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RdXBPSpU
ARC-Seal: i=1; a=rsa-sha256; t=1794333910; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fW6OoiPIWojh0oXLi+Jbi0FyUCjYSOyXtFCP71uErvORFfaLAqidILjM8EScQkbuom
    hiRR2w+mQfqxaL4wCXDWADq4Ah0+1zsGonx5iSQPl0W2TZ/jjBVJyLdbTdpn5kS9r1iN
    O3OsQ/wgkp94y1AdjcRvyic2wPtPSZCLpuVGxizN494N6NU9ayH+0XNERZtoD8P6VH+7
    TYdnMPZgrc67JwrwJmZCuY/4N/PZsRLc1QpNn+tj9mwxWLy2DRQx4GqDM6/geXgLtAG+
    UZzsleOZYEuhs9j1ot3sPtJEBvqH2/cCQgawQ+kVOXt3XDpyurCBORTp3MfFsszQj8YI
    YYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j6ZjtT5Y3Xo+aoA1MTfUEI5cTfZSflXChpID1Sy9ET4=;
    b=IAaFg++Al5Osnlcyd+1z6wggBRJ/hv1+RS5nZ54idhNH08ZB73Mw9j7nDRZHCWa2Um
    xxL35ApWBnniIN3K3GplmL8PgY/s88nkk6/Vu1ql8Nl5dTLdNYNliBISGz3HzJMtG14q
    b4kSRPEypPDQ7252nURm6EK6Xipo+rZ9THIe4fP2sfYS/hZt68fp12X3+uFbKTgHxCkP
    ov82kMpbAsKGwY98FqFn9B3ZcLE5BhZ0md0QRMsdjcp+pkrj9clWR/n5OFFdHviOYIYp
    R7ARAmQ7t73TaS3CADIDWcABnmj0miWnV170cby64dpu5wYcUY0o8W2qdumub1BFrmPe
    XYAg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j6ZjtT5Y3Xo+aoA1MTfUEI5cTfZSflXChpID1Sy9ET4=;
    b=cQRbAYApXOTweUlBNzhOBYDOCGrPQ0FAJf9gXQpKOFOz4ASTQisykxYlb6wDQbyxAk
    vjZbLPBCQtOmTmrmJvW3V0oqp9wwuV0TqBih2L+8+ctdfv7QAIeukTOShm/pwGkMJ6Uz
    3KqY7Ujuvmi9FWFxzVw4/IlhkjrfrHqQ429YD5wIestFsVZwf67oIg+HW570b75nn52s
    6K+I/d1MAyMNfZEE8P3Xta11q1PhRfswLqVuLU1wJzKQTatyE9qZPfIR56Dl2A7KHkXU
    NwbVaHC1aAJ4TRkP3GnNNF+Jse3G9oPugfj6k3ubwgw15VyeeHQJwCuqkDsLu9bzRo0M
    W0Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=j6ZjtT5Y3Xo+aoA1MTfUEI5cTfZSflXChpID1Sy9ET4=;
    b=RdXBPSpUhMMYJ8qCR6AFak4T/EByrKBKGbLj2AcbYG5GHAqUxL+CSmgO5MiZCU6FEx
    07jIm2vQGVc+rvRaC/CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI5A1da
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:05:10 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.10.y 1/4] can: raw: fix receiver memory leak
Date: Tue, 10 Nov 2026 19:04:53 +0100
Message-ID: <20261110180456.792270-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202741-failed-5.10-962947b69589@kernel.org>
References: <20261109202741-failed-5.10-962947b69589@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Ziyang Xuan <william.xuanziyang@huawei.com>

commit ee8b94c8510ce64afe0b87ef548d23e00915fb10 upstream.

Got kmemleak errors with the following ltp can_filter testcase:

for ((i=1; i<=100; i++))
do
        ./can_filter &
        sleep 0.1
done

==============================================================
[<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
[<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
[<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
[<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
[<00000000fd468496>] do_syscall_64+0x33/0x40
[<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

It's a bug in the concurrent scenario of unregister_netdevice_many()
and raw_release() as following:

             cpu0                                        cpu1
unregister_netdevice_many(can_dev)
  unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
  net_set_todo(can_dev)
						raw_release(can_socket)
						  dev = dev_get_by_index(, ro->ifindex); // dev == NULL
						  if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
						    raw_disable_allfilters(, dev, );
						    dev_put(dev);
						  }
						  ...
						  ro->bound = 0;
						  ...

call_netdevice_notifiers(NETDEV_UNREGISTER, )
  raw_notify(, NETDEV_UNREGISTER, )
    if (ro->bound) // invalid because ro->bound has been set 0
      raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed

Add a net_device pointer member in struct raw_sock to record bound
can_dev, and use rtnl_lock to serialize raw_socket members between
raw_bind(), raw_release(), raw_setsockopt() and raw_notify(). Use
ro->dev to decide whether to free receivers in dev_rcv_lists.

Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Link: https://lore.kernel.org/all/20230711011737.1969582-1-william.xuanziyang@huawei.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: 962947b69589 ("can: replace ARPHRD_CAN type checks with can_get_ml_priv()")
[ backport to 5.10: Adapt the raw_release() context as
  free_percpu(ro->uniq) has already been moved out of raw_release() in
  this tree. ]
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 57 ++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 8bbbd9092e3a..7df3086e9f91 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -83,6 +83,7 @@ struct raw_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
@@ -275,7 +276,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (ro->ifindex != dev->ifindex)
+	if (ro->dev != dev)
 		return;
 
 	switch (msg) {
@@ -290,6 +291,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 		ro->ifindex = 0;
 		ro->bound = 0;
+		ro->dev = NULL;
 		ro->count = 0;
 		release_sock(sk);
 
@@ -343,6 +345,7 @@ static int raw_init(struct sock *sk)
 
 	ro->bound            = 0;
 	ro->ifindex          = 0;
+	ro->dev              = NULL;
 
 	/* set default filter to single entry dfilter */
 	ro->dfilter.can_id   = 0;
@@ -392,19 +395,13 @@ static int raw_release(struct socket *sock)
 
 	lock_sock(sk);
 
+	rtnl_lock();
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->ifindex) {
-			struct net_device *dev;
-
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (dev) {
-				raw_disable_allfilters(dev_net(dev), dev, sk);
-				dev_put(dev);
-			}
-		} else {
+		if (ro->dev)
+			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
+		else
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
-		}
 	}
 
 	if (ro->count > 1)
@@ -412,7 +409,9 @@ static int raw_release(struct socket *sock)
 
 	ro->ifindex = 0;
 	ro->bound = 0;
+	ro->dev = NULL;
 	ro->count = 0;
+	rtnl_unlock();
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -428,6 +427,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct net_device *dev = NULL;
 	int ifindex;
 	int err = 0;
 	int notify_enetdown = 0;
@@ -437,14 +437,13 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	if (ro->bound && addr->can_ifindex == ro->ifindex)
 		goto out;
 
 	if (addr->can_ifindex) {
-		struct net_device *dev;
-
 		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
 		if (!dev) {
 			err = -ENODEV;
@@ -473,26 +472,20 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
-			if (ro->ifindex) {
-				struct net_device *dev;
-
-				dev = dev_get_by_index(sock_net(sk),
-						       ro->ifindex);
-				if (dev) {
-					raw_disable_allfilters(dev_net(dev),
-							       dev, sk);
-					dev_put(dev);
-				}
-			} else {
+			if (ro->dev)
+				raw_disable_allfilters(dev_net(ro->dev),
+						       ro->dev, sk);
+			else
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
-			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		ro->dev = dev;
 	}
 
  out:
 	release_sock(sk);
+	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
@@ -558,9 +551,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		rtnl_lock();
 		lock_sock(sk);
 
-		if (ro->bound && ro->ifindex) {
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (!dev) {
+		dev = ro->dev;
+		if (ro->bound && dev) {
+			if (dev->reg_state != NETREG_REGISTERED) {
 				if (count > 1)
 					kfree(filter);
 				err = -ENODEV;
@@ -601,7 +594,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->count  = count;
 
  out_fil:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
@@ -619,9 +611,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		rtnl_lock();
 		lock_sock(sk);
 
-		if (ro->bound && ro->ifindex) {
-			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
-			if (!dev) {
+		dev = ro->dev;
+		if (ro->bound && dev) {
+			if (dev->reg_state != NETREG_REGISTERED) {
 				err = -ENODEV;
 				goto out_err;
 			}
@@ -645,7 +637,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->err_mask = err_mask;
 
  out_err:
-		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
