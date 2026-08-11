Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5833A9E2
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475853; cv=none; b=mHd0P/JzSSflXpaQFHeuFwp5YfP99deoEM69qLLW+5xOteM64ZSsDZKptj9VoH7nNE29JY38TgsTLH9Ulcc6J93q/f07xt5FPofVaIAbZGhEGTliVmzPKDmaV52ErP1ZdnLnINhk6XwG9cf6BiHokPQO0MbCsAfSd6ErCXLqGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475853; c=relaxed/simple;
	bh=Mm01KlFYbA2wf3H6qgw9aiTDGbBhmFb4zBcY4Ku0/xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oS0GFi5GaxaQ3L/uiSTqfeg1KAGoYLrTNF+3sTbNmv97aOPkJGGrJdB9C9MAnR2btK3A/9lQTwFXgpYe5Fun4qcCjXsRSi8dvxkszTJTPhleiY9Hh/7UVXdhNES3TKJ5K5ZdsBQEwnj2Gwup2EJtbCvL1BI+G5tMxXixRIJmm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCqnVI2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCqnVI2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE5B1F000E9;
	Tue, 11 Aug 2026 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786475851;
	bh=rn4E1VlyXm16DDeU6q5M2crpatCpoGJVPqNoXwA3lOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCqnVI2cL/uSsYLfUIk+gu5DdRW99E/wbdrFLtKjjopl+irI9PM9daMgRDfZMmGn8
	 v17cVlgW+Dl4vutc5b70w+OY+k1HI1pbMtYYUB6kc4v0saEj1mKV85/aarA+KsXbGP
	 82ZBQ0j6St4z1ECqqFiStRrTn7X4WMQttTX08VJLit4SQwar/jOqJ3wFkXfqrX6QSO
	 lGvJ3kHZKTBFvSSPDNOWivVji5LwAqa5NKA/bu0gsKZlw9LbzJuS4SFtd1x1CDBz2A
	 5XrsYwjZRm8HCMMQtxjp6fu5c2g5MieLpIAr4Cd17EPRtWgw16rcovy25iJ8XR+u/5
	 oxjLsba5Q1fRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Fleming <mfleming@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] veth: convert frag_list skbs before running XDP
Date: Tue, 11 Aug 2026 15:17:29 -0400
Message-ID: <20260811191729.3462088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080508-marbling-excuse-5244@gregkh>
References: <2026080508-marbling-excuse-5244@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

[ Upstream commit d0d6415963040c401e7a7e4e482a698ba52448cb ]

A frag_list skb can reach veth with data_len set but nr_frags zero.
veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
locked, have frags[], or do not have enough headroom. It later uses
skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
xdp_frags_size.

That exposes frag_list data to XDP as if it were stored in frags[], but
frags[] is empty. AF_XDP copy mode can then trust the bogus XDP fragment
metadata, walk an empty fragment entry, and crash in memcpy() from
__xsk_rcv().

Route non-linear skbs through skb_pp_cow_data() before exposing them to
XDP, and only advertise XDP frags when the resulting skb has frags[].
skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
builds frags[] output with skb_add_rx_frag(), which is the
representation XDP multi-buffer expects.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@toke.dk>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260722191925.2192070-1-matt@readmodwrite.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index da9a0a9cd1b13..30b7da69a9422 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -695,7 +695,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
+	    skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		u32 size, len, max_head_size, off;
 		struct sk_buff *nskb;
@@ -770,7 +770,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
 
-	if (skb_is_nonlinear(skb)) {
+	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
 	} else {
-- 
2.53.0

