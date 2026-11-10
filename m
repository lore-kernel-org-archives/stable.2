Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273486;
	b=G0rfx1hkhXqD/41WHmp2h5YSPo7i7IPKPkUltFu2ZSzPLdpHxFw0nIgKMwxIu1eJjWBh
	 vpfFpDOHEzWdMbDN11ucUfE56sMu2olHxkMfxBPhBhc3dxfM+vH8cqjBYqqgL843EkYk6
	 GlWisp00Ewoa2L2PIRPNgS/9EOm9Dt1gkLWZtMu0vm2AtdFEFMHy/R3PesDpA7rxSRX3J
	 VE4WHRwoLPCy20+SrznOxYMGwvGvEmqtQ3FGXDMzD6Zrwan5SwqlWgyAZvjLGIHN1ql2P
	 EfvEP1KbFIdgN/uh9QQJFB4eFXBCecHMs40tWzigvYaypgajmvZsw2ymRhttV3FUaBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5U5uioDvwpSEDTr7JdvAUlQ2RMYhL83DL4M4UEQaV7I=;
	b=dg+ySwPBP6LyMADbWpwI5zuLgCSKTUrzg+puA9UryJerCHfqZitH6l2E/of7G02o2CI5
	 l7YYz0yMA5xvfW3v0m+0wvT3ReUhiiuXVtcMw2GgGAgRzp0QQ62sWmLBexE6C8GE9LN45
	 MJasmNfy7XJCDx56XDNO+V+IbILFkyG+TC3IBgNtwuecJg+JKZLrJY/MXCnzTjGEaD4Fh
	 E7US9ON20Y4Tm0PKrBv/aVu8AFJZkEaDbD3s1s//+2BV9UPbInjIu+uSGnYoibCtEXAHf
	 ShiWq6M5uU4QAH5jtwhh16Ecbcy/XA6aq591fyzHHkz6z9Sgi0/80Doq5cPRFSHxbJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjhUDgye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjhUDgye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1983F1F0089F;
	Tue, 10 Nov 2026 01:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273485;
	bh=5U5uioDvwpSEDTr7JdvAUlQ2RMYhL83DL4M4UEQaV7I=;
	h=From:To:Cc:Subject:Date;
	b=PjhUDgyeFIKX2ClHdv9LyeutOP2cHTg7i5wXcCC6UWrp36BvcWMffQTQfpIEGc3bG
	 aT6192tegjRaJurunTRfOW+8mQZdHQ5R+6+8YC2x9mwOZaxau/MTqiq0HT1yJP1cZi
	 ZYj7u3EqcHMnubYLRHABwbvTH93S4BBpzw3KSZrwPmf44GDhugK08Gr0+7DwF+01Vu
	 cMVUcbw6nQhPrcjjSNBYw2CZzAVvWc47ByUOt7ECrntAXTJxkiwscmrLcL4dYZUrSo
	 MAeDSKUuDnjMI8bECkZOV6IMpyG1PYT9jS0xJgxW68GOV7hWQuuJdL3h9M8Sw9I0F5
	 drx/rAuCzsktw==
From: Sasha Levin <sashal@kernel.org>
To: 1579567540@qq.com,
	mkl@pengutronix.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] can: skb: make echo skb freeing safe in any IRQ context" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:03 -0500
Message-ID: <20261109201803-failed-6.1-d74307196492@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d743071964920c92af598c87a9e6f4369263ee09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201803-failed-6.1-d74307196492@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




