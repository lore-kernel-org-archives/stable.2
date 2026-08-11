Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787773DB311
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474591; cv=none; b=LCadocSDLwHPsuiEwuVD7xrm3+NL+PsJZX9Ccmh1pPIELrfZcPC6fVC9OLvMtiSxGB7TIbI5pLCLkn/tH+3EQV2KMVDr5kS2PtIAW113iO58D3tnTfO/Qegrd3FvOlcwbIdwsV4I9EoqgRNtN95S/JovJr0X4QnYs0honnmAP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474591; c=relaxed/simple;
	bh=j/lEWhoCS2GQEF0hRb8wVELL8MVd99pWEpg4Qe/P1GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzRBmij0QxUA+lCVeEY2Bw9OxWfDAErRFg8KEJoa9CrdLQ4hmwKFYvIcckK/+phqgejuP0XEyQu/ldbw24IyPD7R+a4LlVewFOX76cy1/G3ii2HfzsUpmYdZ23Lpw9aXbKUYLL9OEFimTIZE7xzU0gdkb8tB9XZSo8+k3AxKtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcbzHUDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcbzHUDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01011F000E9;
	Tue, 11 Aug 2026 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474589;
	bh=4qHKdJAWhulgmP6Zv1Ja2x8xOFo8qYo10xwpfsq+IV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WcbzHUDHZ81pu4D4UefOjkfGZi+Qlvx3PuLt91oaDDLgLoydtRlsQ9ASVZe5UqgCX
	 Q26zCOwKCBF3T4edX1oAHEjA0ccnfebM/X1c/VSnRzE/cSasv82B++8UWUR8MO6XTI
	 Yiv2oLwcpgAystq6828lmzc6s8Xbl45k9u53gpI8HOf61lSjYGBmbb7a1/wVESjviL
	 17J1z8qJuDnHw1n3F+siQ7B7kJMbyXiNDZLRlngZlROoPpv1GLib9eEuv+o6VORWW0
	 glNffhTKB7QwzzaZfalCXxhgWWDpxv09hV6rxhd156H0VF6018mkf1e5EAVTTR6M+L
	 yZqRy2Dwqj/XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Fleming <mfleming@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] veth: convert frag_list skbs before running XDP
Date: Tue, 11 Aug 2026 14:56:26 -0400
Message-ID: <20260811185626.3387187-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080507-delighted-scouring-7597@gregkh>
References: <2026080507-delighted-scouring-7597@gregkh>
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
index d85a11e9477f0..27fa5a0cfd9d2 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -731,7 +731,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
+	    skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		u32 size, len, max_head_size, off;
 		struct sk_buff *nskb;
@@ -808,7 +808,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
 
-	if (skb_is_nonlinear(skb)) {
+	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
 	} else {
-- 
2.53.0

