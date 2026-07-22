Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5B4F7995
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740726; cv=none; b=a3VHXrfghDTy+1G/Mr40IOUL2VqJnLbGrkUFseD6tNuidnJ+DcLoZYd9Jn72fCtzC6ywGTSrdVwgpII1v5ZV80YgTM6hwsvkAo5Uvn8STsgni/aWxUdYu4E7B16lH221f3ZbKcCa1sjeXfcPl/2EUKt807kNamFtG8VTc1KWo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740726; c=relaxed/simple;
	bh=o/Bu15sDhEOsKHR4CQblrys7TkwgkSC18uEGHD2BjAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kieljL/XZrmpVjFgXSSZQasCXn0yXoXLBHN73rl9yRqCar8OgNEZJvt7SlPrQYRvFuB/JuvZofpr0C4LslwICoSlirewff5r8p57WehWSfL0t8CJFdZFhXKeNDhPcrCj9s9uDx+DgeXwXWmOvayE9hdcepdBKqV3KZUZ026sAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMDqjuAx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMDqjuAx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495502852d1so101945e9.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740723; x=1785345523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bgp1uL2zdCSwtHxWPjmVsr5a9ctDEumlGTtccTCWom4=;
        b=dMDqjuAxJvWvIZ7JSGFL7ZOA621OxDc/HgzQm5UVxJl3/TTnfzzdC6CXniY45fMsyE
         8l1X3cYnB2ydjPu8gk3Ixlpd5+N8XM+1g2jD+bvKoETcwI6fCvNhohe3x5q7bnK6rrgM
         xpEwqAysgz2ZEhviGR2a+vZosOXCXKPszaqHru8xn/YH9F4yXPeU3G3ZyprIpdO3Rdzx
         dmRJGirqQkR/5xGFRV0MbsIGveS3RC8KacGRfdcEDlC5LtEQJccGbwp5LFKR18o/8p+x
         7sypXEHo9xuSmxrdCpp2p7etbCf+RrMRQIPLH68Og2KvDVZtapILo/7Hlu192Lh4E/jU
         pYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740723; x=1785345523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bgp1uL2zdCSwtHxWPjmVsr5a9ctDEumlGTtccTCWom4=;
        b=mDFRHRmvXkT34ZNI2JSXVX1dSwLDOIAvXjC4SYxhsWoq2qoE5R1sv/qsYHso9CN7/q
         EC1n/lKfWQ6EMSHk6eehLTKRHW7uFvtLgdFvJwxdFfetAU8F1pWqK8poXSfSx3cAttGU
         C+Oj1hJ/NY/kAnf4Pu3Z7q1D9jSau3CJ5UbIHEDbxcF3gHg7+t4LA+cOczBJ2RTYkLGF
         /3YULkveppXOT2s+tC7TZep1xusLON5Kicyf3G2bIMIBEd+1Yqi+TD69lDW6O5PNeVFV
         gA5P98qezDy4wky/ROeu4cUD59DSULCkkhofM3mBLJX5pJ6iy/YXcQpa1CKaY+fKp2tU
         74/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoHmMzLOZhG3gnUiaePv1ZMNHSmZgW1LgH45h1DmlAFjKYWmH9hkwYWzQuDi/x7TvSur7n5KG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZA4GnAZv9mDIk9Y/FddQDjcXG9zocPcocoMnAiU2bpqxEnA2
	/ejxrCzJwf4midNE5LZ4Cxh0iPRcXbf9BxRERi1BtIHMij4z0CerhIt0
X-Gm-Gg: AR+sD120WL1Fd0luZtgpySrB5EGvE/vonsqK4yhfK1pmfJWNy1dIYVqDrYcSv+4ru6q
	HqFY5ZUlzW+WOGO8NyfWXzK3k3gwVgrY+TxrB0uRdZBf5XS4kAcIi5NobSWRJWxuws1Bb7UsZfV
	hztlPLUmObsQi1U0+22SwujycMaDsqc/QwRU9019GFnbrqzwq+nJcVbqCjI1ChuPCQ9uH3hLwSV
	KDacSAE7A5AhuMP6BEiNQFTT/S6KSWjsxbqTBhtz2M4xVP7AUI+uFQkI9Ztho1HD5yr3hSgKzM3
	1kZMwS6XiasjJvm3UttvWpaxstHjH5LYODERq1DVzqtvhUwdrYhvQphvA5RJUgmUjnDHK08jd4p
	faVoyMYPiQlqD7d2S7Cb5Rl++dYAxxo33FiFCnYzjq1I+5+03zaCCUaUhpbnU11Qy5ZP32OopN2
	xwJ+Y9CE/oyy/pRkx7Qkg+L6TLSbm5iy2by3E5GmuwExdY0hINR6aPGbeNKMcpzsYR0SpydFAu/
	f5IjyEHg022OBZcqgAJxQ2coiTFI5EQjQIBW2vY9Bd6R3gL
X-Received: by 2002:a05:600c:4584:b0:495:6713:9ae2 with SMTP id 5b1f17b1804b1-4956713a250mr56348975e9.1.1784740722310;
        Wed, 22 Jul 2026 10:18:42 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-078-051-150-230.78.51.pool.telefonica.de. [78.51.150.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a634cf9sm92427615e9.9.2026.07.22.10.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:18:41 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	qingfang.deng@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/4] net: hsr: unfold GSO super-packets at the forward entry
Date: Wed, 22 Jul 2026 19:18:35 +0200
Message-ID: <20260722171836.196-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722171836.196-1-xiexinet@gmail.com>
References: <20260722171836.196-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP forward frames one by one: each wire frame gets its own tag
and sequence number, and duplicate discard is per frame. A GSO
super-packet reaching hsr_forward_skb() breaks that per-frame
semantics: it would be tagged and forwarded as a single frame.

Unfold such super-packets at the forward entry with the top-level GSO
dispatch: __skb_gso_segment() initializes SKB_GSO_CB() and performs
the L2->L3->L4 protocol dispatch (calling the low-level skb_segment()
helper directly is not allowed here -- it reads SKB_GSO_CB(skb) state
that only __skb_gso_segment() sets up). features = 0 requests full
software segmentation; tx_path is selected by ingress port (master =
locally generated TX, interlink = RX) to get the right checksum
semantics. Each segment then runs through the existing per-frame
path, which is split out as hsr_forward_skb_one() so that no GSO skb
can reach it.

Segmentation is only offered for the ingress roles whose frames are
known to be plain Ethernet: the master (locally generated) and the
interlink (SAN side, untagged). A super-packet received from a LAN
slave may carry per-frame HSR tags or PRP RCT trailers that software
segmentation cannot recover, and an already-tagged HSR/PRP
super-packet violates per-frame wire semantics; both are rejected by
ingress-port policy. (ETH_P_PRP identifies supervision traffic only;
a PRP data frame keeps its payload EtherType, so RCT carriage cannot
be tested by protocol.)

Also drop NETIF_F_GSO_MASK from the HSR master's hw_features so
locally generated traffic is segmented before reaching the forward
path whenever possible.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Cc: stable@vger.kernel.org
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  |  2 +-
 net/hsr/hsr_forward.c | 50 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 3fd1762d8..248cbb142 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -652,7 +652,7 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
-			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
+			   NETIF_F_HW_CSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 8e4158a9b..3fcdbac49 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <net/gso.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
@@ -732,7 +733,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 }
 
 /* Must be called holding rcu read lock (because of the port parameter) */
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+static void hsr_forward_skb_one(struct sk_buff *skb, struct hsr_port *port)
 {
 	struct hsr_frame_info frame;
 
@@ -761,3 +762,50 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	port->dev->stats.tx_dropped++;
 	kfree_skb(skb);
 }
+
+/* GSO fan-out funnel: unfold super-packets before per-frame processing so
+ * each wire frame gets its own HSR/PRP tag and sequence number.
+ */
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+{
+	struct sk_buff *segs, *next;
+
+	if (likely(!skb_is_gso(skb))) {
+		hsr_forward_skb_one(skb, port);
+		return;
+	}
+
+	/* Unfold only plain-Ethernet GSO super-packets: locally generated
+	 * on the master, or arriving untagged from the SAN side on the
+	 * interlink. A super-packet from a LAN slave may carry per-frame
+	 * HSR tags / PRP RCT trailers that software segmentation cannot
+	 * recover; an already-tagged HSR/PRP super-packet violates
+	 * per-frame wire semantics. Drop both.
+	 */
+	if (port->type != HSR_PT_MASTER && port->type != HSR_PT_INTERLINK)
+		goto drop_gso;
+	if (skb->protocol == htons(ETH_P_HSR) ||
+	    skb->protocol == htons(ETH_P_PRP))
+		goto drop_gso;
+
+	/* features = 0: request full software segmentation. tx_path is true
+	 * only for locally generated traffic on the master; ingress from
+	 * the interlink follows RX checksum semantics.
+	 */
+	segs = __skb_gso_segment(skb, 0, port->type == HSR_PT_MASTER);
+	if (IS_ERR(segs) || unlikely(!segs))
+		goto drop_gso;
+
+	consume_skb(skb);
+	while (segs) {
+		next = segs->next;
+		segs->next = NULL;
+		hsr_forward_skb_one(segs, port);
+		segs = next;
+	}
+	return;
+
+drop_gso:
+	port->dev->stats.tx_dropped++;
+	kfree_skb(skb);
+}
-- 
2.43.0

