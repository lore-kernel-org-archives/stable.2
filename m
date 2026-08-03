Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F0350A35
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795747; cv=none; b=Q8pBD0qGgnG4hv2n+rEM11tqYDAO71ZF6lUzbEUR8rx0PcUNL43LFiAbMuz1Y341q0ofplbBXkuR1igCONP1bHpsALO8LojcBQcelrMBDuh832pacFj9P7nF0ah1j35t3A9I5+Ky3bJ+1t1XR+WW3zxDLQmGOQ1nOcK1/+N9o/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795747; c=relaxed/simple;
	bh=KOrzoFMc/M42D9OEiprV8gaUX5Hexkl9nZf5de3PolE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFPAtRb6ofeniZ8IkLl4VY26B8fVG2O3yWGLVCZXViAzssCy+PuevG6L2SxDO1eZu2FAmlz3tKSYxBR+J8Rk3LMb37uFA+7ck7IsKoQeeR7ckV73IwAeSsi2mhUU4p+VrLwdZudRcaWuZdUxoR1KfV83ryAatdcYWL0Kz0x4TDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGx0s4UG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGx0s4UG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490791a3e92so2746425e9.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785795740; x=1786400540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=taQYtKaGJ1AUPlJREC2nCfE3DkYRBYSu2aGQCYa2qxg=;
        b=mGx0s4UG2X6cR0A4l6cFeUXoZWdWeh0eQJJfnpicRiGw7zkq72mpaEnUD/DkcZFPzN
         hPM3udOD14VS4VQkfE3s3P0kKhlwAGKaUg3oIIYTJtC+kFrIo007cqTLuT7nqNY90rEn
         e1fg5xZxsUe9woTzb7OkvEXvFe5vFZWZTUGx20Y/RZOI1k9oU0NHIe4bR2coJP1buawI
         vaE6dsH6CwYxfJjJUUsFmJtTYX63IzLiJpSXfQVKmshd950fmZpJmopIfYAdjYWW+O43
         3Cpo5ZBlwHJHwwI4jCG7yuwA8ItSP/vjrSivKlFykkPKYD3pZdWoBVZTmBHCR4r4JYU2
         8gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785795740; x=1786400540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=taQYtKaGJ1AUPlJREC2nCfE3DkYRBYSu2aGQCYa2qxg=;
        b=BptqyJyRf0l4Goi+WEg+IJRxCr4XLdulx6NBDyInD9mFQUJqT7wlqjIihthwDNTOfc
         5Rj056kzhB/SYPhtGQB75KCAGL6I02mG4irzxrnC7h69XPgBQ9QXO4ynpmW609a8EM1V
         LVccqaS4/tVL1Rwo9buznPp8vFIz74iW5L2ypv1HwwK5jErRQIJ09R2HQ0vE4DiKxgli
         XvQpQl0wwTyRzBtfmkmeHX4NYgu103v7jriCjNSSEuwaLYZbeNrJ8cAl0T2jDaAH7B9r
         FwUlM11lsyRtZEJKV5w+TPnhkltFrPRkiGTLX8edvnPRz6GFnCZ9f9lUNnOFKOvARsXU
         bb0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpqhJo3LQJVHTPnnhyxr8PfFYxMtfmOJCpN2DGcj0ORlESutYGqtG5eTBw4RqM94S5dx1Hv3vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwkLptJuYQQ2snLTVPAQs6pZCxSOGquKNaSGAGjM95SYMwmt6
	1AYD5XlJbW0OnuqJTa4WtIirlCI0Wzvfz1+dcLAsYGqh4M9Bzr/d+Pak
X-Gm-Gg: AR+sD13HUG+umZFFtIeSVIN5BE/vFdAKHFG56CzJAiC2lGBGg8Aykx34Ed1pzOTRQAq
	uXs7o2ex/fPX+uOPC2WtHk9QJx8xUeHsjdef5Dlk5RVm6y5Oi1w5ltD84GMWb4zxsVUM8PSgCjv
	VhzDyG63k04b83riPCRhYAFGNKYsZMEFJ54R4ASdGIcmGbMzp6xwGzmL9BRw0JJBBVdAqMTeuvd
	8vvaiZ+Wme9U2t7KSsHY/thQnvlW5L7wn6d01fAZAoOct8p9oT1xPts5hekr/ALFBYaCYKBDxW3
	Rq2u6y8hdvroqF23BnLzH2ix7pv6of0ZRBgl1jSS2doCppoDAmFKCf1rp2it8UOtgPVQwlnAn1C
	nAuFxcRuYdC+2TdhxZIVq4aWLVMHujOstTDJmpfvt8WyYK9pAO0yFLlNn9Hm41cb4VNTgkQnxCX
	3v0xC0hiIiDk/XnWOzBf2f/oSvUGGYh0rjL5xYBoy4RhVc9NbFWHcxfJWT5GeuPv0OIz+han6GA
	LfSlpKL8cCRHV99AMwTK8GPfdYM7WYd8AeVJYFunwzuUYGO8pzbGBkNIFUqFcgmXeknVv0aT3Tm
	zuvbcsMy+Z9tGwWHcnIPuqLpBtkPWA==
X-Received: by 2002:a05:600c:a01:b0:493:bea7:6b67 with SMTP id 5b1f17b1804b1-4980c6a1082mr130474085e9.3.1785795739723;
        Mon, 03 Aug 2026 15:22:19 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-012-149-099.77.12.pool.telefonica.de. [77.12.149.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2da2sm31668145e9.3.2026.08.03.15.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:22:18 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v4 3/4] net: hsr: unfold GSO super-packets at the forward entry
Date: Tue,  4 Aug 2026 00:22:10 +0200
Message-ID: <20260803222211.877-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803222211.877-1-xiexinet@gmail.com>
References: <20260803222211.877-1-xiexinet@gmail.com>
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

Patch 2 (seqnr_lock shrink) is a latency/critical-section
prerequisite for this change; their automatic stable selection is
limited to 7.0 and newer. Older stable branches require an adapted
backport.

The GSO-drop accounting uses the same atomic legacy-stat helper
because the forwarding entry is concurrently callable.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  |  2 +-
 net/hsr/hsr_forward.c | 50 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 3fd1762d8916..248cbb142e21 100644
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
index 87cd72a1dc65..b1b75a25a01a 100644
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
 	DEV_STATS_INC(port->dev, tx_dropped);
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
+	DEV_STATS_INC(port->dev, tx_dropped);
+	kfree_skb(skb);
+}
-- 
2.43.0

