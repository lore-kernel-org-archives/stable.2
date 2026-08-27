Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443644684B
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837319; cv=none; b=KGW2qhg/j77ZvRIDjAmCOg6AvqfQp42HEBhkuC7Kvz0CtbOFCwLWMSkji0rbryJbPRS4ZIg9c10/JAmUzFFM4QP/3C7H04HjCo+UCEdrzDSEk558R1ch6dChluii3NcecWA0kdypmg5X2fYsIAgeA8dikVEqU4VBU/141JEkLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837319; c=relaxed/simple;
	bh=cBDjBsRPvFafrLzK8QKceBIFqQhgWO51ewcm1BJQqZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyDA5yLNtLB+YuRVFLPU4nYNBpWGExATJ8E7sdaaeG1nA8TxZL0rTlTKmZHVqmiASpQ/Dhq7dtMG/D4qpVx1WjBn2rXv7fdYv+FVa6UvuO0YSdVkrzlNHT2wDnztbzUUFecTYqtcTRQ8yPSMpPGsSZBMKDfSaYy3xChmh3+C8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc3UXhfe; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc3UXhfe"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836cb2fa1bcso35590507b3.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787837306; x=1788442106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2JnHZVVZ9o5Z6lh0/e0hb8IIjiL4gIL7y0yXaE1Cb1o=;
        b=Kc3UXhfeFYmhKMldB7V98mT6ZaCd61Q308mheXin25diScdp+l3pJWLomAKGhWYwr2
         AjOPrCRa1M+vyaa3UGYqWk4wNQuGcwb6+ElQReusluhve2d0JG4JhZh5NiL/XznDHf/t
         zOw8ylUT93Fi+QRDuy1dBGbTYXZlJOgfXFHtU7phq9Bt6fbxLmzGwpfLGjbFXV7oDiXH
         5Y9I6GUCR9RmYj0Gjr3KYsS2iM1c2clvPcj2+HhDFfd7Xk0S/4mVkwctYOwt7VLARRZY
         P3HFNb2LzHB1qr1J+9JRUh618TKZGBbGU1ZZwihJioa58pTrzNVMgjKnQ2y7rBVrRoP4
         ZyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837306; x=1788442106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2JnHZVVZ9o5Z6lh0/e0hb8IIjiL4gIL7y0yXaE1Cb1o=;
        b=b0VOJtWOUZdZDofg3M0s8XU6+/jx6dDqvrTBkgf+vVB29+sHdTtXkzBLUdwCoUa2PO
         OyHGcRvKB5vINNtPu49ssrDU9s5GlGWkahSYppzMksbSzpKx7MoihAs1D22lHEMkpToY
         CSEbEEIa28eUeMLtSf5jkTr0C1wqzb7sSEweuoBVrvkGxf82tMp6bxAMAOiVVS90/zph
         O3MMsNt492DpK2rHbXlTrr7DkfQJ+aaVdCzAkkuPPUYRCLh/CTJdvbehHdhDuIb8F3Rb
         BBosbrPRM9ICk96GeKsVqzR6qmkJKpBD4OQRrKjGGbrTwSYX0wtxX7klkpM+CiDzP2ks
         iqrg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7mOipmPkSR4+U8QGI/Fu9XLoWSRcMK4Z0AwwHo/Ljm3EhCBkayl7Meh0oar5Smb930P3bb2A=@vger.kernel.org
X-Gm-Message-State: AFuF++n7vfh/8AyP97J11mM4lViBoPh32B/twh1uDc3tlLlfnNwB3yyL
	cS8R0euKjt0NycdAF+ucsQJoyePFgNh2FadLefBKkO76bOJB2UyXNUN+
X-Gm-Gg: AR+sD11BYkFyBjXxF/RYXB83j1TtUZKFujsDFyRMyl2Qq/C1d1cMHwAaBdzrSvkVK4l
	WUNksUD7fa0CRTOZhhF/LwoewMfPLZhrpl+CpL5EqWNOZRWB2eB5QQaeRfrAMeD1zWLFiAuxC4j
	soQoTsSKn+9HRtmPwP6AQJUwjj7vKwLTsxHQvXPiIUVE2jRcczDBwqwAQj9lpCAoFzREM0xFjvA
	CwoqF8wlqg44I1cATyXilm/yxFy9pAgDa+uYp6WjUq+xgn+EfvJZzhz4xwi6IlLuC5t2Qf619+s
	yn/xUpY+VGwbiL+WQjHOd5TJlvh4uYNacFtWizgVHvAE2EQ2mlOxhM9Afp6vmEcJ3bE+xWaMdTa
	yc+NCbFewjeocGqCbxAkTwl6Klk7A8RBJ7L/wlRr+JTLIszX4S4wb5cEEqL6DMTjBdgmjpvkXuS
	dWA6qXdLRH7be2VFztaQ05puk4+YDShVFJ7pY2kG29cEWTWHMO2+gNwDVpUFRblrCK6w==
X-Received: by 2002:a05:690c:a7d5:b0:81f:238a:1709 with SMTP id 00721157ae682-85749dcca8amr53133527b3.34.1787837305439;
        Thu, 27 Aug 2026 06:28:25 -0700 (PDT)
Received: from 2045L.localdomain ([99.153.3.24])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b5c7f3d7fsm9586367b3.17.2026.08.27.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:28:24 -0700 (PDT)
From: Guidong Han <2045gemini@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shmulik Ladkani <shmulik@metanetworks.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Guidong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: gso: always scan dodgy frag_list for linear heads
Date: Thu, 27 Aug 2026 21:28:20 +0800
Message-ID: <20260827132820.11815-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_segment() moves frag_list data into the segments either by sharing
page frags (zero-copy, requires the source memory to be page backed)
or by copying. Sharing into a linear kmalloc head is invalid, so for
SKB_GSO_DODGY skbs (untrusted GSO metadata, e.g. from a virtio net
header supplied by a VM guest or an AF_PACKET/TUN user) the frag_list
gets a defensive scan: if any member has a linear head without
head_frag set, NETIF_F_SG is cleared to force the copying fallback.
Without it, segmentation dies at BUG_ON(!list_skb->head_frag).

The scan is skipped when mss == skb_headlen(head_skb), on the
assumption that the frag_list members then terminate on exact mss
boundaries, so segments never cut into the middle of a member and
page sharing stays safe. That assumption comes from GRO-built lists,
where every member holds exactly one received segment. It does not
hold in general: the first segment also contains head_skb's paged
frags, so even with mss == skb_headlen(head_skb) a frag_list member
need not start on an mss boundary.

Such a layout is reachable from a guest: it sends two IPv4 fragments
through virtio-net, the first with a forged gso_size equal to the
reassembled linear head length, and conntrack defrag appends the
second, kmalloc-backed fragment to the frag_list. Forwarding then
forces software GSO (gso_size > egress MTU, or the egress lacks
NETIF_F_FRAGLIST) and panics the host: an unprivileged guest can take
down the host and all co-located VMs. The same layout is reachable
from host userspace via AF_PACKET PACKET_VNET_HDR or TUN with
IFF_VNET_HDR, given any conntrack user.

Drop the mss != skb_headlen(head_skb) test so the scan runs for all
dodgy frag_list skbs.

Fixes: 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_size mangled skb having linear-headed frag_list")
Cc: stable@vger.kernel.org
Co-developed-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Guidong Han <2045gemini@gmail.com>
---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb4..e97b27ec13fd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4796,7 +4796,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    mss != GSO_BY_FRAGS) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4804,11 +4804,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				/* gso_size is untrusted, and we have a frag_list with
 				 * a linear non head_frag item.
 				 *
-				 * If head_skb's headlen does not fit requested gso_size,
-				 * it means that the frag_list members do NOT terminate
-				 * on exact gso_size boundaries. Hence we cannot perform
-				 * skb_frag_t page sharing. Therefore we must fallback to
-				 * copying the frag_list skbs; we do so by disabling SG.
+				 * The frag_list members cannot be trusted to terminate
+				 * on exact gso_size boundaries: head_skb's paged frags
+				 * take part in the first segment, so even
+				 * mss == skb_headlen(head_skb) does not guarantee the
+				 * alignment. Hence we cannot perform skb_frag_t page
+				 * sharing. Therefore we must fallback to copying the
+				 * frag_list skbs; we do so by disabling SG.
 				 */
 				features &= ~NETIF_F_SG;
 				break;
