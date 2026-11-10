Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274076;
	b=PjNjgLPRng/HITrKtZHxhjg7YR6ZI821q85vBrt3ctGmN+BFEQq0wxs5KfM5xfLRQ83b
	 0ZH3x3oAVyLKL+8E+dGum1yS7At67yvGOP/OV9Dk7/oXtmhrnbOlZBEii3/7F2QT4Zl1H
	 beHFsnZcbNfQi712ggxjyUPuvZoFBZbnCTkEpaH/ZjHJPAy7Lp0XtEkthVvLt/0z/5OZt
	 UF19WnkSAKnTfrj9qB+qa6jfxU8ZR+LouVX6mhWvmSqxtP7ZsC0thSjnUf0vCQIFAYoM7
	 1OvwNVAzjKRpGmWwoUEVEv3cSAA+oNIVjG3qA1R/6RBRyzhH/gT1CkeHezopLrhAaFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xChn+LZ8rC3m6hktjQsHUtwumxY/SBihWlXx9xuz1yI=;
	b=UM4FvngN9M9V9sdpJjyPnsyCxIw2OBFeH5B1vDNr5nhK92Hayr0IS9jr71pG9464LRrv
	 bEXdaBjQKx5jvEcCQhU+0cwHHQWtkJ97qknyAFwUw17s1dTQfksxD/czZ3vm1ILThTjAE
	 eDmxXTmAs0k4TbIMdQeJiy8xBnf8oKbHD9Uo9KfwwPofqNNo+qC8P/5AshlzHV7mCmvkn
	 2vTZAExnbm84xHv70qcpNu3sLrcN6RxH1mdgUBFNAZTTozMdy9iqX8WtkRPQ0Q3xvoKMa
	 cMvWhDtPM3NAUEOt6aanaAa1dO5fvn7wl7wQGJZr/pD4hw0fyZDB8dq+x0SrLJymoUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA51qWdF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE5606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA51qWdF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3551F0089F;
	Tue, 10 Nov 2026 01:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274075;
	bh=xChn+LZ8rC3m6hktjQsHUtwumxY/SBihWlXx9xuz1yI=;
	h=From:To:Cc:Subject:Date;
	b=kA51qWdFUDQK5y7/ryc+2p8K84ZjFvN1CqgvgBL9jhsc7hSja7ZoHLWGio8r+p+7T
	 pIKvWZxRbndjJ5vffrC3u1Zxe1Xk8Ve70AOVBJNlWL1m/TS7la/LJHQYOQxGnt2cCS
	 4XvvU8JONxL6b05GNLhDKJxGSpkSrKrBGUr55FEssHBTxxr4IKf/ABp5A66hxlejY4
	 HkqSPOeh+D0wdZ1MAwD/cgDYjZZmOpE1pDOB7K+8RQmrEMPpzCleOoA3WjJBKTvR3t
	 /6yOoMpsFwu4WRIxmtkXYbjRmvii/Q2G105Kzj0s/i1maMTtfvJAtThyYmkZ/llV/q
	 +PRWH+SR9Nj0A==
From: Sasha Levin <sashal@kernel.org>
To: 1579567540@qq.com,
	mkl@pengutronix.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] can: skb: make echo skb freeing safe in any IRQ context" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:53 -0500
Message-ID: <20261109202753-failed-5.10-d74307196492@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d743071964920c92af598c87a9e6f4369263ee09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202753-failed-5.10-d74307196492@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d743071964920c92af598c87a9e6f4369263ee09 Mon Sep 17 00:00:00 2001
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 17:45:00 +0800
Subject: [PATCH] can: skb: make echo skb freeing safe in any IRQ context

can_put_echo_skb() can be called with hardware interrupts disabled. Its
direct drop paths use kfree_skb(), while can_create_echo_skb() uses
kfree_skb() when cloning fails and consume_skb() after a successful clone.
None of these helpers is safe in every IRQ context.

Use dev_kfree_skb_any() for all drop paths and dev_consume_skb_any() when
consuming a successfully cloned skb. This preserves the respective skb drop
and consumed semantics regardless of the caller IRQ context.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_E84809CF236D0137885E7E4E4D58340B3208@qq.com
Cc: stable@kernel.org
Fixes: ae64438be192 ("can: dev: fix skb drop check")
Fixes: 0ae89beb283a ("can: add destructor for self generated skbs")
Fixes: 3ccd4c6167d3 ("can: Unify droping of invalid tx skbs and netdev stats")
Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
[mkl: also convert can_dropped_invalid_skb(), can_dev_dropped_skb()]
[mkl: add stable on Cc + add Fixes tags]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

---

FAQ:

Q: What about the comment in drivers/net/can/virtio_can.c
   virtio_can_start_xmit()? The error handling for virtqueue_add_sgs()
   mentions that can_put_echo_skb() consumes the skb via consume_skb().

A: The comment in virtio_can.c will be updated in a separate series, to
   ease backporting of this patch.

[mkl: add FAQ section]
---
 drivers/net/can/dev/skb.c | 6 +++---
 include/linux/can/dev.h   | 2 +-
 include/linux/can/skb.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index bc0787535b524..46c151eece8f7 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -63,7 +63,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	    (skb->protocol != htons(ETH_P_CAN) &&
 	     skb->protocol != htons(ETH_P_CANFD) &&
 	     skb->protocol != htons(ETH_P_CANXL))) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return 0;
 	}
 
@@ -91,7 +91,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		/* locking problem with netif_stop_queue() ?? */
 		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return -EBUSY;
 	}
 
@@ -403,7 +403,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 	return false;
 
 inval_skb:
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return true;
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6d0710d6f571d..346faddee02eb 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -176,7 +176,7 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return true;
 }
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 5d27843862fca..87ace09c0d8bd 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -78,12 +78,12 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (unlikely(!nskb)) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NULL;
 	}
 
 	can_skb_set_owner(nskb, skb->sk);
-	consume_skb(skb);
+	dev_consume_skb_any(skb);
 	return nskb;
 }
 
-- 
2.53.0




