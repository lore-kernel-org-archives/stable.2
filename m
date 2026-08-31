Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A3399036;
	Mon, 31 Aug 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202649; cv=pass; b=m9fimNzuYK1xLpPsmNZYtx8AHMPqBfMWXIzWuZE02BHnCByIvJHTNIpob3psO0uOmg3IzNWTUl8QqFZUfpzZ+lZM4YxPsDSoA5go8YxGM3r5K6XIOmFKTH+gpNtIAQMVwsMGa7c/YspaPOXnVcdjwsZqrdRN92wG9+XjhtIgcWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202649; c=relaxed/simple;
	bh=f3Vov1yrELMaB5NjQEgxe4ObbSF9XDS50zy016awYfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UFwWvWlqGuyA25/rjuCX4NfHgRVJixiy7Ku75bcyCP50Yr9Dbg3zwBPwzZMErcwn9H7tDM7m/WY1w4ggq55M6umzRakvhj5HF40dg51pQ1jXSpbFoO2YZ88m2Lk4+YubcWPsQ6ZgvBlrIDtSJ8RgAUSPIyO7CFmfIKsbytjoHI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gL01OWXQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I5+PGKIr; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gL01OWXQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I5+PGKIr"
ARC-Seal: i=1; a=rsa-sha256; t=1788202638; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DduHMcnQRURMmf+gXwEHiKM4gyPtd6TjfPUES60fSjd3CslSWigk0RJ05Mir8YNWMr
    aiqGVrVHBaUxt1QgOAuqM2lj5cqeSRLoTKUsTNwHRuWsJ/qIKRlt79s11YBNS59rus8w
    ilu4B1TdP2Xc/wV/YQOAfcVoXeP5sBVTtVQsK6sGxuwMO1vWUtPZT2djYkpUDV/ZNU6c
    pgP3ObBSGuZABvmDxW1CuUcJYkvxHv18kMsUXptu14iXNbQq+9HfgwsewYiagQaENY+d
    HqnW8G3NtSIR1GErGNCVkPd0UsvfeSkH84LDGWP7Eub0K82pALNXXl5BwOW11yKTPZAa
    9W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788202638;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aTwqB4hj2CT83EeNEBwcKj+q7VZdfe2AHFxuZuF4PaQ=;
    b=hE1Q/47uQXconIZeaUJsaLbO3ANLeRbwXLyYSdwf8bBzQSLo5BDLqtygxAF2MJi+Bh
    JAZRfhIqf+upC7NN+xK76lsjvTj0gEccxLtxhDYaNQYlybWFDtoTFx6yMOCsglUBCNJN
    YO2HmwjVj632SjykFlxhjVRGA8dOGtdtat9opM+qafwXBJ2pxtUIS8N+s1kvKSy/Z3qG
    WTReqW2oZ2OOjnHYTLbC6uCndNnfqawI+CSxgl2XqMwvVCa+nEGKquFMa2BwpswhHZSO
    MIhF9MCjFT0Zo6dqlq9EL5mSiqHjV2fg8/r0GmtOJk3bWvUNfZSiuVKyiU8pLlxXRqva
    lQ4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788202638;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aTwqB4hj2CT83EeNEBwcKj+q7VZdfe2AHFxuZuF4PaQ=;
    b=gL01OWXQ1jgx+OAiNa2gvgxEDG0Ehc4ggkCuMIRsdF8V2LDKhaMv/L0GtPrOA/gdRi
    A9gKRB1jGE+yE2+wcFbRlhonww314St0jdsdL5bz8c2tckDpNe34oLpyVnqAD5iER98l
    L6HCStKaTlWuTWRE+nAIBOOwEARoNio0B/XDIKCLRq+cJNIN19fFSSvDf29A9cXu+INt
    FCwe1oW85cmjv5XjaMLsGtiUgsp+hjieUTy/Ihg+anOB8DsSwhmv+yMnqbtN1jtUqd/o
    yooeiNtqkxocHzAcFwiMJlG2oUyUH9aEhgTP3BeqXhA37k++Q/+FZFOb2HcqtEvUd5uC
    ni1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788202638;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aTwqB4hj2CT83EeNEBwcKj+q7VZdfe2AHFxuZuF4PaQ=;
    b=I5+PGKIrXCpbTF4MGx29NoC3IRmsnZrtX7a1Dnn7z8Oq0EGKmrP2gDzPmWLOyftI5M
    cducE+XeQ67WbBAFr0CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727VIvIN60
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 31 Aug 2026 20:57:18 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: notifiers: remove CAN filters independent from namespace
Date: Mon, 31 Aug 2026 20:56:53 +0200
Message-ID: <20260831185654.16701-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Remove the namespace equality check in the netdev notifiers for BCM,
ISOTP, and RAW sockets.

When the devices namespace is changed the socket namespace and the device
namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check
therefore skipped the removal of the CAN filters from the (ns changed)
CAN device.

Since the `struct net_device` pointer is globally unique, the notifier
should always process the unregister event and remove the CAN filters if
it matches the socket's bound device, regardless of the device's current
network namespace.

Change all can_rx_unregister() calling sites to use dev_net(dev) instead
of sock_net(sk) to retrieve the namespace (only missing in isotp.c).

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: Norbert Szetei <norbert@doyensec.com>
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c   | 3 ---
 net/can/isotp.c | 7 ++-----
 net/can/raw.c   | 3 ---
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..aaa5163c46cc 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1792,13 +1792,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 {
 	struct sock *sk = &bo->sk;
 	struct bcm_op *op;
 	int notify_enodev = 0;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	switch (msg) {
 
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 155530aedce2..0835a4758a72 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1490,15 +1490,15 @@ static int isotp_release(struct socket *sock)
 	/* remove current filters & unregister
 	 * tracked reference so->dev is taken at bind() time with rtnl_lock
 	 */
 	if (so->bound && so->dev) {
 		if (isotp_register_rxid(so))
-			can_rx_unregister(net, so->dev, so->rxid,
+			can_rx_unregister(dev_net(so->dev), so->dev, so->rxid,
 					  SINGLE_MASK(so->rxid),
 					  isotp_rcv, sk);
 
-		can_rx_unregister(net, so->dev, so->txid,
+		can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
 				  SINGLE_MASK(so->txid),
 				  isotp_rcv_echo, sk);
 		netdev_put(so->dev, &so->dev_tracker);
 	}
 
@@ -1846,13 +1846,10 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
 static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 			 struct net_device *dev)
 {
 	struct sock *sk = &so->sk;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	if (so->dev != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
diff --git a/net/can/raw.c b/net/can/raw.c
index 82d9c0499c95..c5596fc9aac5 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -300,13 +300,10 @@ static int raw_enable_allfilters(struct net *net, struct net_device *dev,
 static void raw_notify(struct raw_sock *ro, unsigned long msg,
 		       struct net_device *dev)
 {
 	struct sock *sk = &ro->sk;
 
-	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return;
-
 	if (ro->dev != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
-- 
2.53.0

