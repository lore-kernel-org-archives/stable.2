Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333926;
	b=p6JIZzKgKdRCjUDVNvx9kNbDkTRrWv5urNTHvlgqmv590tqY40Ny5mfaq2jvrpuU6vWi
	 sby/mQ5Gd/1zPYvqdO7tCkzflGZS1yYABSi27bL6whpHGrFdTIZiVAjRsamasQtfUALuD
	 /M7CavyTprNP3SpV1XTfxd3OuBHwv7gNkpcu+Ghw/5Wt8hKxxbeRoLdM08WyEKrwLESl9
	 62dqqe86UlUO/u+Z6+QozWCrO/IdU7B3Y/2YSFZ62SrlCNma4v6Euj6ekTgx9qCAT6C8Y
	 Sc0LvGKLi28itY07j9PyTXDN3CUd0QBv1EhowVKC61Pk00OY61umZ08/arE2XU5isgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333926;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=FL/l/i1VqqwtE5JIUB/0bjjuyLhj4DgF6DRypo1J1BI=;
	b=3x8TXCclz1TRDvhznV6I83Oe+uowqOZS3mtvpIN8Fs+TaDP6rjnWWsheEKudycIxQO+B
	 bWhSkOfDynTTqvTBKex5Z1vurL902X8fyaM7tobw4ZwsbsszvtBafx4wjkmLcbm5K/1Sd
	 HmIii4STXveO7KDxGYLi40itY7oHtLYI+UCWdQmNvDDJhEbKs8HvpGx4QT4GDi7mGnL6H
	 kQRBU3KduWRqRcuQN02ro4uYDlc6Ja1I6ByT4GO5ggHdZBpFd5iEPDyAWkaW7yqQ2NNQ9
	 Ij85QR6oNtwLB90uBYv/6R2fVax2CT0SlDzRM0iTFUSe6w7moqtw0t4UANPeBt3iDYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="PPWBT/vF";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cTi6W81F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF81C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=PPWBT/vF;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cTi6W81F
ARC-Seal: i=1; a=rsa-sha256; t=1794333910; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rvk4wrfn1of+l3OghGusmsHFLh3bk5gDNQcrQZzTm+TbwMgw7OcT5+eB8vjWaewYk+
    u8JTeQnXbVO8EIu5fWiw8OVVyHQziwfsyMsDLkzmTbVyw0etO0b5XPtgVpPrg65GWI5+
    LRjIv5sZ0x9N91V6C6K/gryiME6pS5bE3vSV8c5Ly7LOKqNyhnglMaNgzL07DT4tYMQx
    ilBD4Z+uNFKvOjNOBjas+SRYdp+SSwCBO7jZHVyuNQ5i9hXaMzencwZmN788r76gILVp
    KFOsd74y/45BqbEP5oDpyl/sXeXnX0r/mKlljUDZZdR3cDg0lN2S44Pdb8noxFeTjZEC
    CY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FL/l/i1VqqwtE5JIUB/0bjjuyLhj4DgF6DRypo1J1BI=;
    b=EBbSv6IMwnX0NJEAN12OcDhsCyzkwXUGJMR/PfhUJujS3b3JugzlU3VoeEbOW6RUZn
    Jk65uVigM39wnOhhJEHGIMZLCRIR/1YGYcBGEnQsepVfG9N2Gsde43FZF1H+RoPbHXv7
    yKYltMRTpPree6AoJ9fD5ryTUSbqyCh/76C7UUQxLTWJImE6YQJWxadYH6iHONLVjrTH
    PmZzfI4KMW8qjnfsa0ftUdYvEiFd2owlBch2I//FVYMItKakSHtV/uOuxesSdYuxDxNz
    mWYC0/p/q8olSoMdtmxp70qGT9bdiky1mGulJOk7kpb370FI6c+hLpXayJ6Cy5284/az
    z3oQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FL/l/i1VqqwtE5JIUB/0bjjuyLhj4DgF6DRypo1J1BI=;
    b=PPWBT/vFcfUgWtTDnL6L91jIUisR8R3Xdq+Mq+nJBFbL13DZL1uX0gFjpKigzpqmRd
    BYKD7S2LE47ynsbcKhnOrPI7OQDa4MPNdmq72B5TlAPj0llifjZIC48Mf7IBsQhwCw1/
    9L9F47jOoIOJUzF/wf06/G/5X7Ke6ej4EDoBLxCTmH4zvg1YZvNL12Lp2qP5oBhBr21+
    3dOQK79V2Bh09OHQsEp4ppLn0sAPuR0FrC2Adhb0Mcvs4AtkZ7GiycRN9/YySJcw/vqR
    +dWerDzTm0pBGZz2NUPCsqq5MTvpUirRty6GjWE+MmsICXEhdUaFlTAg0NQRy+Covtal
    WwUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794333910;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FL/l/i1VqqwtE5JIUB/0bjjuyLhj4DgF6DRypo1J1BI=;
    b=cTi6W81FuHbA0J1hzny29yq1DMNb0GzUtjpbm2ZPBeNE+FJF4daOeCA6/RnflCefAE
    fFnrQTX40yms52trLWBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AAI5A1dc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 19:05:10 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.10.y 3/4] can: raw: add missing refcount for memory leak fix
Date: Tue, 10 Nov 2026 19:04:55 +0100
Message-ID: <20261110180456.792270-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180456.792270-1-socketcan@hartkopp.net>
References: <20261109202741-failed-5.10-962947b69589@kernel.org>
 <20261110180456.792270-1-socketcan@hartkopp.net>
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

commit c275a176e4b69868576e543409927ae75e3a3288 upstream.

Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
a new reference to the CAN netdevice that has assigned CAN filters.
But this new ro->dev reference did not maintain its own refcount which
lead to another KASAN use-after-free splat found by Eric Dumazet.

This patch ensures a proper refcount for the CAN nedevice.

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Reported-by: Eric Dumazet <edumazet@google.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/r/20230821144547.6658-3-socketcan@hartkopp.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 962947b69589 ("can: replace ARPHRD_CAN type checks with can_get_ml_priv()")
[ backport to 5.10: Use dev_hold()/dev_put() as in the 5.15-stable
  backport, as this tree has no netdevice reference tracker. ]
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index c9513dca8fc9..3e2822707ed8 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -283,8 +283,10 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (ro->bound)
+		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
+			dev_put(dev);
+		}
 
 		if (ro->count > 1)
 			kfree(ro->filter);
@@ -398,10 +400,12 @@ static int raw_release(struct socket *sock)
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->dev)
+		if (ro->dev) {
 			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
-		else
+			dev_put(ro->dev);
+		} else {
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
+		}
 	}
 
 	if (ro->count > 1)
@@ -451,10 +455,10 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			goto out;
 		}
 		if (dev->type != ARPHRD_CAN) {
-			dev_put(dev);
 			err = -ENODEV;
-			goto out;
+			goto out_put_dev;
 		}
+
 		if (!(dev->flags & IFF_UP))
 			notify_enetdown = 1;
 
@@ -462,7 +466,9 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
-		dev_put(dev);
+		if (err)
+			goto out_put_dev;
+
 	} else {
 		ifindex = 0;
 
@@ -473,18 +479,28 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
-			if (ro->dev)
+			if (ro->dev) {
 				raw_disable_allfilters(dev_net(ro->dev),
 						       ro->dev, sk);
-			else
+				/* drop reference to old ro->dev */
+				dev_put(ro->dev);
+			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
+			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		/* bind() ok -> hold a reference for new ro->dev */
 		ro->dev = dev;
+		if (ro->dev)
+			dev_hold(ro->dev);
 	}
 
- out:
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	if (dev)
+		dev_put(dev);
+out:
 	release_sock(sk);
 	rtnl_unlock();
 
