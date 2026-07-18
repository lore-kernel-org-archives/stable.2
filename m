Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408A2C86D
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784392276; cv=none; b=oEX5Ez/yQLwWfZe5uEpYhsVO8hjdf9NlZcZK1BTKAJ63bEt/oJr4V9mGaoHUiNNr/tnNW9S4eKPeXVll/cq5M/4nCHYF5KvZ1isj3/qBURkqy1+iOKfKY9Ig9Qs5ZPa/3krzVcATy4AETVaLtsNp5LMbk85W8Ts139KOlS5jA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784392276; c=relaxed/simple;
	bh=1lo0mlXKu1wiOzmpo5Jx4V6jgYxJS50ff53s0bIdpp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qglmXvJS5aQGN9Y/3CqMc6roFW+FKW3NpOo9vQ6RAFiUNzj0kaVYsEMf1OFAyvxuCWwtgCZT7Bp3Tif2jrbDO0YZgBH6Vj6RJFlD6YgIzN0WTjIpv4lBDmESyFDSxNY+X/MwlkWm1clXEu62fWjmDKW+HqMNoq5U6Dh59H6m670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8/udjfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8/udjfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE61F000E9;
	Sat, 18 Jul 2026 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784392274;
	bh=gWoIGqhdCZ33FgW3i3jwHcSypK2wkaNR5uLHzlCXS6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n8/udjfw9gTM2hjMSoa6/ZJSMjcqxU7KtLh8LRPzfpYNF3V5EzuJmsFAtEQfnjSYm
	 9osdGMuN/4b/Pmo4lTmHuf5zVc1A2xJxrFEn/l8jwDcYvztFRN9tcO3jReB80Wg/SK
	 81zIV6UVBMgYyGGFdqzk4dBTTUUDYTl6DmaV78GJdTwDLB9lEKZbd1uAW8pPj1Y/Kf
	 x9zU/n5l7nFbio3rF0pVtH/irqW96RwXlS/4J1AFEMoLQhzf7VfXs5GgYmi3fsqM5b
	 imYdwXmHJFvBzaLnPhbOmtaCf/AHUI4zsrDu7BVmmp+QtoUtO4kBAy+X+i1eaGBUeL
	 cIiiemesJM5Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] xdp: introduce flags field in xdp_buff/xdp_frame
Date: Sat, 18 Jul 2026 12:31:11 -0400
Message-ID: <20260718163112.3339166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071421-video-bucket-8e49@gregkh>
References: <2026071421-video-bucket-8e49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 2e88d4ff03013937028f5397268b21e10cf68713 ]

Introduce flags field in xdp_frame and xdp_buffer data structures
to define additional buffer features. At the moment the only
supported buffer feature is frags bit (XDP_FLAGS_HAS_FRAGS).
frags bit is used to specify if this is a linear buffer
(XDP_FLAGS_HAS_FRAGS not set) or a frags frame (XDP_FLAGS_HAS_FRAGS
set). In the latter case the driver is expected to initialize the
skb_shared_info structure at the end of the first buffer to link together
subsequent buffers belonging to the same frame.

Acked-by: Toke Hoiland-Jorgensen <toke@redhat.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://lore.kernel.org/r/e389f14f3a162c0a5bc6a2e1aa8dd01a90be117d.1642758637.git.lorenzo@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: aa496720618f ("bpf: Reject fragmented frames in devmap")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xdp.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b2ac69cb30b3d7..aa0c1249ed98ef 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -66,6 +66,10 @@ struct xdp_txq_info {
 	struct net_device *dev;
 };
 
+enum xdp_buff_flags {
+	XDP_FLAGS_HAS_FRAGS	= BIT(0), /* non-linear xdp buff */
+};
+
 struct xdp_buff {
 	void *data;
 	void *data_end;
@@ -74,13 +78,30 @@ struct xdp_buff {
 	struct xdp_rxq_info *rxq;
 	struct xdp_txq_info *txq;
 	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
+	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
+static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);
+}
+
+static __always_inline void xdp_buff_set_frags_flag(struct xdp_buff *xdp)
+{
+	xdp->flags |= XDP_FLAGS_HAS_FRAGS;
+}
+
+static __always_inline void xdp_buff_clear_frags_flag(struct xdp_buff *xdp)
+{
+	xdp->flags &= ~XDP_FLAGS_HAS_FRAGS;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
 	xdp->frame_sz = frame_sz;
 	xdp->rxq = rxq;
+	xdp->flags = 0;
 }
 
 static __always_inline void
@@ -122,8 +143,14 @@ struct xdp_frame {
 	 */
 	struct xdp_mem_info mem;
 	struct net_device *dev_rx; /* used by cpumap */
+	u32 flags; /* supported values defined in xdp_buff_flags */
 };
 
+static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
@@ -180,6 +207,7 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
 	xdp->data_end = frame->data + frame->len;
 	xdp->data_meta = frame->data - frame->metasize;
 	xdp->frame_sz = frame->frame_sz;
+	xdp->flags = frame->flags;
 }
 
 static inline
@@ -206,6 +234,7 @@ int xdp_update_frame_from_buff(struct xdp_buff *xdp,
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
+	xdp_frame->flags = xdp->flags;
 
 	return 0;
 }
-- 
2.53.0

