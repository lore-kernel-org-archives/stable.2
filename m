Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273196;
	b=INx1jlwbX0Uf24OSwMy6ChF1fqqj5mZZEt5hAA5wn8tPZKAcQowOYc9J0tRFkMZzML7s
	 gogRL2ly6jbMcmE9m8SEpfWI4dNEgkXshF1qifbQzp5U6/v03hx+FJk1S4mx2Jr4z0gdz
	 Ufj1IDmKoMVLbjemuh8GXnqH/IdfKPZhPTbGLv+0L1LSmNGK120pe9qFXqgNhY9h2i+OZ
	 x4sVGBNcHivatPBrwliZvZXtKY7UtNLXZ4u4wmMbRoj6hW4e1TH5ge/NoITK5Bsn8/cTG
	 71zGtQCVRsCqa3oneb3Kd9UQoEbHSqJrBmu8srGTqJyCPbRaIVJa/e1jY2VYdp5A6Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WY4rDOpVu9vhFPjRr23e0MsM1xwu6+LY4mvEkCx+p+c=;
	b=TcUxN43X6F5hRZUsr7z5ARIWkrmGEGD5wrl4Zwac2Ij0wuLG2wDeE2TbAlZRz162mnSI
	 TX6Yub1LxtG2snucTwZfiFtQE06JDEy/Y6/klWhs72ob23xoyCpN2v+0br1tdWWKfbYxU
	 ldyuj/8mUtLSUFB3wqmTIVMNoNHL/t+BIy3ELrQUoH0WNKb0VUwZlMPCAdfwgli5028oE
	 vbMjDtdJwF9uyyPAOT3zz6tJBhSJMGbKsCkLzSGK4KELwQDQl4paVywckYkMraN3J0TU6
	 SU5/DqmrgnZU6nuMJh4Scap/8o1HE3j/bJqWPZgTlM8myAmBFaTLT7R9jsl2YAm7BnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPif2tOa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC8606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPif2tOa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462BC1F0089F;
	Tue, 10 Nov 2026 01:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273195;
	bh=WY4rDOpVu9vhFPjRr23e0MsM1xwu6+LY4mvEkCx+p+c=;
	h=From:To:Cc:Subject:Date;
	b=CPif2tOa0fZniT/QJqKgocPiT/nWRXUnDKArWHWY1kbFipSplt0TPA+BWu45rQVUr
	 t+pexsxVPZpceqe4sd8mAsz9AJc4PB7zpKioDkbJiyNV+LbrwHzUtKXwhAyoPZ6Elt
	 yOQd1JSPeZ0UgjHQ+aAbSntIFT9pIZogyNxxkyxmN4BSsZzpJpvAgC/dMbRrNyhCx2
	 E4x/GXXt18fKatHAjQpKeOL2CPugVvTjxlBeDSWKDNkv8eNmtnQN6+X1H8MwFXFitl
	 fDJlrDyQ1b6mqoDzgQzCK0nFYm02qlgUp17J56bDdMkSuDRwtwGoVgeqjZFCmn+mMW
	 A+Xx5Uj+5gYAw==
From: Sasha Levin <sashal@kernel.org>
To: 1579567540@qq.com,
	mkl@pengutronix.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] can: skb: make echo skb freeing safe in any IRQ context" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:14 -0500
Message-ID: <20261109201314-failed-6.6-d74307196492@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d743071964920c92af598c87a9e6f4369263ee09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201314-failed-6.6-d74307196492@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




