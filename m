Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F082F9D85
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988751; cv=none; b=mQAUaOx2h0guzw8SrdbKtwolvaomsksO2WPdmZ/X/g/xc5RaWP4Vqw1Xl2E52XasG8Myns4AlrDMSnENXtesfa0KWjGNNg7llyZEy3KjIRykLH1KqMWHE3ugkILvEMGu0ieHsJvaTb2qy2iBQbaeYzk9lZenmnJjpa5GQjoMpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988751; c=relaxed/simple;
	bh=Uu8ZhWkql1E7KIV8WcKB4/qcF1Z4veDGhP7GVB65vsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIpUp6bg+QtC1RVYlxWzkzIRl5v7jMY9vjoMWekmNP/Vz4h4MrzpB/ah0EukreFIyXmuVqUWdhfIonqm7+aH65mbOjYgj0O6/q4iP/j+pn/bLRFGP3IjBceUa3SMI6dXzxOfZ6MMTUkXE750kOXOuGQw1lEuP9U22x0/cxeLZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWzKvwhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWzKvwhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB571F000E9;
	Sat, 25 Jul 2026 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784988749;
	bh=pboQenDQ2Kak8lB0Yccbzlq9T+XBFuNDC2o2oS348os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XWzKvwhV1NPrcHGwkd2VOeXIs52tT5w5SXVC58hNiisORKppfuotgBD9on6D6W7Ky
	 F1PmAr4xisScqMSFwlUkkqN2mGCx1Cm80znOhH9BJ8BglfrGZwueGF3B1p8pdjVXqO
	 nvQ5AH1k9+XfwPGiuxhN9k/1jCHoTXe5exYKth4Ftkt3+2LbsbJ3dmh2Jry4ENhTEy
	 p2JkQGV7d5oi4IRH9rufQIvv1Xx1MC9fzq5QzlWNgZMwwkqL/CcL/zbDOnDAgXou8W
	 BLvQuVJLyRnggOIaJkY1eRwyNwlCePXF8jvRgabrppSxRZq7Yvju3ASQZd6nSetItI
	 PT812f+S/N9iA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: thunderbolt: Fix frags[] overflow by bounding frame_count
Date: Sat, 25 Jul 2026 10:12:26 -0400
Message-ID: <20260725141226.3814823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072026-jab-puzzling-567e@gregkh>
References: <2026072026-jab-puzzling-567e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit 55d9895f89970501fe126d1026b586b04a224c27 ]

tbnet_poll() assembles a multi-frame ThunderboltIP packet into one skb. The
first frame goes into the skb linear area and every further frame is added as
a page fragment.

	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
			page, hdr_size, frame_size,
			TBNET_RX_PAGE_SIZE - hdr_size);

A packet of frame_count frames therefore ends up with frame_count - 1
fragments. tbnet_check_frame() only bounds the peer supplied frame_count to
TBNET_RING_SIZE / 4 (64), which is far above MAX_SKB_FRAGS (17 by default). A
peer that sends a packet of 19 or more small frames pushes nr_frags past
MAX_SKB_FRAGS, so skb_add_rx_frag() writes past skb_shinfo()->frags[] and
corrupts memory after the shared info.

Tighten the start of packet bound to MAX_SKB_FRAGS + 1 so a packet can never
produce more fragments than frags[] can hold. This matches the recent skb
frags overflow fixes in other receive paths, for example f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path") and 600dc40554dc
("net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()").

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://patch.msgid.link/178163152194.2486768.14724194232649760778@maoyixie.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/thunderbolt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index ef13aa36e55e8d..50ac4bdb10adce 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -752,8 +752,12 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
 		return true;
 	}
 
-	/* Start of packet, validate the frame header */
-	if (frame_count == 0 || frame_count > TBNET_RING_SIZE / 4) {
+	/* Start of packet, validate the frame header. tbnet_poll() puts the
+	 * first frame in the skb linear area and every further frame in a page
+	 * fragment, so a packet may not span more than MAX_SKB_FRAGS + 1 frames
+	 * without overflowing skb_shinfo()->frags[].
+	 */
+	if (frame_count == 0 || frame_count > MAX_SKB_FRAGS + 1) {
 		net->stats.rx_length_errors++;
 		return false;
 	}
-- 
2.53.0

