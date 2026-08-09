Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61133D1A97
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786277705; cv=none; b=l1oVLEXvEi8Xivotd2G/PqPxdksUmxfBCURsC6OomHSrU+zTMchW9jLOxUmKPlQ23eET9fZlDKlOOUJE9Izcwe4wlbrgURZWdyBRv10gYiN9tSE2pEzbg4P9aASmg+CxYbQQWTmXCgGAwk58s0hO6KDJP8DyF/snaQikwK4vslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786277705; c=relaxed/simple;
	bh=v2IOzHAE8P7e7RPtUYejuCgStYNSB6rjJrtbYCdnJjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pedESjpDHIfYUyLIvlyQLf3eklMNsN4JlCpypKLbxPGUuOuR6IkEdsIgjPxtXiWgeeWoUAJVsNGCR31kK0wpJhwTkVWceZO8xBnpAvYualme/0HcBkRrR34Sm+0enHpICOfX1cYCm9aB1KEarT7cGwD74RDwmYrvWIMDr9jgiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaxRpvxp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaxRpvxp"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f6981d244so31918f8f.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786277701; x=1786882501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tK5etVjV8isZ+EPgOl8b6oOCjBS1RkzIoG5Pe4Znpcs=;
        b=jaxRpvxp0+bYmTbQuUsag8eEDCxNEzgqanm0XvuzVSn+sTWBP88Jkh4FXmNy5t7mz8
         KbYNwlorwXWySIDuVP4MMWVZfPlXD5sh8HtbWO0mCWdmOGKSmCeVVjfheZbihHL7svER
         Ga8eHizLOtzHO+RR3sNQwqbU6RQ+EIEny/XTeqMsi4FFsfrFq6y1RtLlyeWDXORQ8uQk
         Ya7ea/dQ88bbES/bHkRqRIk2S3QOf0BSjaWRuzICqxSxeXM2vbYdAHNH0paz9N70T6Cw
         q2ekAFuPzcB3JOp/eu7fGtOnPolB1lBb1DS8R1o7a8Jz8zXP52YvLA0nbJgNkar4Ujgr
         Rdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786277701; x=1786882501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tK5etVjV8isZ+EPgOl8b6oOCjBS1RkzIoG5Pe4Znpcs=;
        b=YFWKqm78IFQZVLI6SO6/g702JPgfG6ZXejzUc/5jb6AqYo8XqsYvQXs6emM35CRj+b
         rH+SW6MrLn/qcqGNorL2hm71OH0QDqHn484bOmzjY8B1V5uLvfXpaDnv61uTYvYISktF
         sdB2N5Z2JLlOwuEX3F/7nufaehNmRmvlttOEWGnj1vwt23uptu5Rxr6cjvaB+un+3vlr
         dMiVvOfHWCOsjx8rnUZAt0VC0E21oOcpBeFfNMfaC9fUlJQIXAIeVtSIk/jRsWDdTQ4J
         YCXqS48eM7tA9vDYr7+1c5JdKuUR0bj8M5YRs89/4j5Zld04QOIFHn+4eK3K1gmPgMVo
         cYUw==
X-Forwarded-Encrypted: i=1; AHgh+RqO5gLjjzlTkXFyWr6ajU+F4BBVDPBG1v+jJS0CTwDrGVIkhZx0ajqj1G/cEb+zekw/1FMlIfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywvt2x4EP9ZMgQUjor3dZipiWqHKTjXVA4f0/7DzqvByvI8hsa
	Mqcf4kZCotqo8HtRE8Ew8uw7Zgw7ABD9tQMd6P6z8vPUfCKVZ58J6c4B
X-Gm-Gg: AR+sD131uVnkatwPiQiTGL8y/hPhSnHPwfMkeDqyYXUeC7Kpp8EDoz34uGC6khyrQs3
	9fYmrShV1bgbkVMLhbkMteGWArpB1k26c5OFhVU083PLqS26ThmI1CjZMdnId15F5/tU1gGSzqE
	k9hebn64AwWR6RvLADBtNMNdzHdB+FnJUhuk/b++fexDFmYBeGF9c6qprrQTHK/4b+F3el2KbIV
	FDUinF/qLSUkzuCodtM6OTeAWInPEjoexSMBR2lhqKSabyQRs2Vv6eKrwV9qpCsgMp+Hgj3zXlL
	KFl9a+hIlJKMsQ3Un6lGo9+GOTyMXbu4oTwyaNeG0OHec72FfNZU6YGCioewOPy4zKg4xBHuZvD
	JjenOJNvIbIjb+iVB+qYLFZEIWzrmosUe5i6upLwOyEP3MQe7JlTgYo4UKJv1zz0U3K3TebjbnP
	35AviflXBQ75GzqRiIMjtJL1LIoFw0iQ7ICmr58xqvF2hALAweXuHyadf18SU8jBlE2AxjLXnRj
	x2YO66gZbVCAnE/69skHU73/C0pSZQNOBU2qOW8eA36VKRaGIUNWXZo/RCY6zRYvf3NI1zEyT8a
	sTM9EXCsF/blowAgLa2gs/2fjf0nrtQ=
X-Received: by 2002:a5d:5c82:0:b0:481:3db3:8eb with SMTP id ffacd0b85a97d-4813db3093fmr3525985f8f.1.1786277700954;
        Sun, 09 Aug 2026 05:15:00 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-012-133-135.77.12.pool.telefonica.de. [77.12.133.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b3fsm25158434f8f.20.2026.08.09.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:15:00 -0700 (PDT)
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
	liuhangbin@gmail.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward entry
Date: Sun,  9 Aug 2026 14:14:53 +0200
Message-ID: <20260809121455.1745-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260809121455.1745-1-xiexinet@gmail.com>
References: <20260809121455.1745-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP require per-wire-frame tags and sequence numbers; treating a
GSO skb as one frame breaks those semantics.

Classify GSO skbs at the forward entry by effective protocol rather
than ingress port. Segment plain aggregates and process each segment
normally, preserving local delivery and forwarding. Drop ETH_P_HSR and
ETH_P_PRP aggregates (per-frame metadata cannot be rebuilt),
classification failures (unreadable header, stacked or S-tag tagging),
and aggregates with unreadable net_iov (device-memory) fragments:
their payload is not host-readable, and segmentation would leave the
segment payload uninitialized, silently dropped at transmit or exposed
where netmem transmit is enabled.

In-tree software GRO does not merge PRP RCT frames (its IPv4/IPv6
length checks reject trailing bytes); fixed-on GRO_HW output is
outside this guarantee.

Also remove the GSO_MASK member types from the HSR master's
hw_features: local traffic is segmented by the core before the forward
path, so the master funnel branch sees single frames, and TSO and the
other GSO_MASK offloads can no longer be enabled on the master;
generic-segmentation-offload stays changeable and is cleared at
runtime.

This patch depends on patch 2 ("net: hsr: shrink seqnr_lock to
sequence counter updates") and the sparse-bitmap duplicate discard
introduced by commit aae9d6b616b5 ("hsr: Implement more robust
duplicate discard for HSR"); older trees require an adapted backport.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  |   2 +-
 net/hsr/hsr_forward.c | 106 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 2 deletions(-)

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
index 8e4158a9b57c..ae49c2d74ace 100644
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
 
@@ -761,3 +762,106 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	port->dev->stats.tx_dropped++;
 	kfree_skb(skb);
 }
+
+/* GSO fan-out funnel: unfold super-packets before per-frame processing so
+ * each wire frame gets its own HSR/PRP tag and sequence number.
+ */
+/* Effective frame protocol of a (possibly VLAN-tagged) skb, or 0 when
+ * it cannot be determined or the tagging exceeds what HSR supports.
+ * HSR supports one 802.1Q C-tag only: an accelerated tag must be a
+ * C-tag with a non-VLAN inner protocol; an in-band tag is unwrapped
+ * exactly once and a residual VLAN EtherType is rejected. Read-only;
+ * no state is kept beyond the immediate protocol value.
+ */
+static __be16 hsr_gso_effective_proto(const struct sk_buff *skb)
+{
+	struct ethhdr eh;
+	struct vlan_hdr vh;
+	const struct ethhdr *eth;
+	const struct vlan_hdr *vhdr;
+	__be16 proto;
+
+	if (skb_vlan_tag_present(skb)) {
+		/* HSR supports one 802.1Q C-tag only. */
+		if (skb->vlan_proto != htons(ETH_P_8021Q))
+			return 0;
+		if (eth_type_vlan(skb->protocol))
+			return 0;
+		return skb->protocol;
+	}
+
+	eth = skb_header_pointer(skb, 0, sizeof(eh), &eh);
+	if (!eth)
+		return 0;
+
+	proto = eth->h_proto;
+	if (!eth_type_vlan(proto))
+		return proto;
+	if (proto != htons(ETH_P_8021Q))
+		return 0;
+
+	vhdr = skb_header_pointer(skb, ETH_HLEN, sizeof(vh), &vh);
+	if (!vhdr)
+		return 0;
+
+	proto = vhdr->h_vlan_encapsulated_proto;
+	if (eth_type_vlan(proto))
+		return 0;
+
+	return proto;
+}
+
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+{
+	struct sk_buff *segs, *next;
+	__be16 proto;
+
+	if (likely(!skb_is_gso(skb))) {
+		hsr_forward_skb_one(skb, port);
+		return;
+	}
+
+	/* Conforming plain-protocol GSO super-packets carry trailer-free
+	 * sender payload and are segmented here: each segment is delivered
+	 * or forwarded as its own wire frame, on any ingress role.
+	 *
+	 * The gate is content-based, not port-based. An aggregate whose
+	 * effective protocol is ETH_P_HSR or ETH_P_PRP cannot be safely
+	 * segmented and is dropped, as is any skb whose header cannot be
+	 * read, whose tagging exceeds the single 802.1Q C-tag HSR
+	 * supports, or whose fragments are unreadable net_iov
+	 * (device-memory) pages: software segmentation cannot read their
+	 * payload, so each segment would inherit the unreadable flag and
+	 * carry uninitialized data. With NETIF_F_HW_HSR_TAG_RM the lower
+	 * has already stripped the tag, so such aggregates arrive plain
+	 * and are segmented.
+	 */
+	proto = hsr_gso_effective_proto(skb);
+	if (!proto)
+		goto drop_gso; /* classification failure, fail-safe */
+	if (proto == htons(ETH_P_HSR) || proto == htons(ETH_P_PRP))
+		goto drop_gso;
+	if (!skb_frags_readable(skb))
+		goto drop_gso; /* net_iov (device-memory) frags are not host-readable */
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

