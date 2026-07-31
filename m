Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F31346FD2
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488553; cv=none; b=axjElY6UkoPetW/6AlWfdvk4yjgwBo97xyW90W4xpv6CR786rnrdF9mU7phahKuOQWxYMYrBOFDrN6oyLr3w4ilRgAhoxWS//v9dSsc/zRpJ5RVRg+6jeSkZstRPD63LZQXUAyYW4AR0OyTTu2klIWThhAvzkVAR9ni1sdeijF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488553; c=relaxed/simple;
	bh=Gvo7dvsXJnKYRwaxoElTc0qa0PZfiQSj25oZnrC2+wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/LsTVRNy1d7Cy+UK6i4Lk97B6NW2Lh2TwcJ8TBJaj2ZIbgiWFqGj9QI9Oq61vgTke/cfDo8vJh7xTqUXQCET9CkREgbN9aKeln4yOkJRnTIm/BeJBQRn1Qk9U1BEd8ZnJrfqfzQYttxqCL49mnvnMsY2UVCdlYh3Z4ejntD9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzqJhvjN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzqJhvjN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f25e3fe44so67360f8f.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785488550; x=1786093350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuWU9LZrmF4Dt9/ovolj0itekaMNh8PVn0wC7NLE19M=;
        b=HzqJhvjNJk3ll97EBG8FOXtKAYUKNB7KEqD5Dq4ckYwAmFZzp7nqSBzHbtiW5v+Qpu
         zfvh7Da65+9JYQ3GGvfkabiHpVaQJvEc20PBi4Z7+z8tzQ8RxQ/7oD6odBL0tKyjnh23
         5Wwn1OVI33Y4rPk75xQFlFJcbCCIbcr1DtzWcjiMqFxJw6gHEyW+6uhZKlkLHmjHP7ft
         /xBwNd3eEx09mv4ZfMqIFO1a+66FqCfdmoc3zHmA0pJT5yrhqz0HyRBvouNTRYPgqrz6
         xsiGxInEam8ggpdTxNaZml4ukd4zh2Gubk/HIKnnzIBG5JvGUMDqX9BplWfrKjGWUyYt
         pTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785488550; x=1786093350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xuWU9LZrmF4Dt9/ovolj0itekaMNh8PVn0wC7NLE19M=;
        b=bWLD1oD1GwPnz2IoSySVSLxY1+uDg25k0KBW59lb6nxY2MA6EguDTz6KZOx0tXRLhq
         d8YSAkd3wymbv3euw7CDqgE0511+HVxVyrCVokhT4Qun7iK+LOplMp+uRIyYsQKLgspl
         JVdKKza2XUYbk2w3TKYhvINnc0eb2G0NpXQkkFHwwyK3O8pzL2rDLSjmzRS2j3OW8PvL
         66riPBFEm7eor5HoR0xFdzWZ2xbrjGNSQg0JBySFxexCmFabiMVvFen8tmLq/haoaLuK
         s6MB30fSsOh5jmiBJptAHhNgFMwJUqznvtse8u4jgADQkmyFYHrODVsjMkaV22OMCeQL
         hRYw==
X-Forwarded-Encrypted: i=1; AHgh+RrteS6wcFe4/BoB8VowpMoKgEc1XzvFk0vI2hImWsFiWV9fCah9JYyFjFIfMLZXztyImYqybMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOg/jsiHU4VgPRnby1qIsFWTG+ThujEgTy6y/qq5um7Db5Wve
	qOHi8qAOLEjEOAXC0wvJq7zCmAdcJJkxyCH4qWKjEmAAu3Usr+DiYhRj
X-Gm-Gg: AR+sD12uDXMAkbSuNLTNyMSOeV9XNHKYGjSAYjc3Ah87CeUHkJgLUR+UflUSlg0ahQR
	yNN9hVdJzyrb8+NJLTa8s2ioZX+4metfKTvw4WLMxE64ycOiZkbOseiMXkeAw2R4TQSlVa7ekJH
	IukGg+O8bDjKkYJm8ae0yYwknto4fFWGvTStK+jx2tatd4yAJBDaCjkhx06WTOIHYkW7kBBOCCl
	/ll9R4vSKzKiHw27x9HrKtPbj3bGdE0/F5R+sz8t1PVI2pbc89D+fZ32IXkDHN7gbZjLbaTlSm9
	kSxwVIocTgmyBf3xTbkmdB2mwYHIR7KYCpfTV/lFGU5gMY56DBIi4Y+Cq8RHvmXQBCe4ZSFUbc0
	RazbBTSNx49bl5iM7U1Y2ETEao9F/lkVRKpZpceZHitrykYwq9/cbVDT35wjtwAa1kas6KTq0UZ
	ExsbPEFsLGjPvbIzeZUGwxqecS/4Q188b9633LmQtxI7iZCzv3b8bSWm8ig4taiOSZpo7l+s/fS
	7KkikDubDtT04xHZaKxC3wVJiVJ7cDsxmNGCXhfpO+3bpNt5g+tO+4QlPhUzYd6GcsntlxCyhJy
	pX4awzKixToUK1/ouqpw9A0QjW6VbkxA
X-Received: by 2002:a05:6000:430b:b0:47f:9256:52c0 with SMTP id ffacd0b85a97d-47fd2b5498amr3276372f8f.3.1785488550061;
        Fri, 31 Jul 2026 02:02:30 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-184-219-058.77.184.pool.telefonica.de. [77.184.219.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm2965051f8f.7.2026.07.31.02.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:02:29 -0700 (PDT)
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
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v3 3/4] net: hsr: unfold GSO super-packets at the forward entry
Date: Fri, 31 Jul 2026 11:02:22 +0200
Message-ID: <20260731090224.18-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731090224.18-1-xiexinet@gmail.com>
References: <20260731090224.18-1-xiexinet@gmail.com>
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
index 8e4158a9b57c..3fcdbac49c59 100644
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

