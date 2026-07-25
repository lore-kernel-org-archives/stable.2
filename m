Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BC32E72F
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992963; cv=none; b=H0aNTswWhX00xVOZaC3q7e8W6O7YdvsAiD4uiiSq2wKJ2KL9PvEfw7j+jL/4GsbHDCuHKrlTO6KtTXSmb7MAz24RshPCTh8PN5t6dbTYtW0NT9OP9K6Xg225Q+7JlWD/MtYSn5i+VmAw9glnq6U0Itx9vR7TAWY5EFCyjpiM2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992963; c=relaxed/simple;
	bh=rnIkIXShOOPtoTNnZWCwHm5mYVgvh1+zT22xFBgJoyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAVtF7wwbF0uJfnVGEeR6UFKDo9hNvz++CVoS/N/DSe7JU8/cCIRVhmHc44/6wKYFXXfNz52KOJLjZc0Iyb7MeGBpCPwVrR5z7m4i86iWsNlfv2ttSiIWrHomRWhk3S6qNYeJHSqRndoAcZuniior0AlfemdHTpXA36LGZkRN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtuFvAJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtuFvAJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CC11F000E9;
	Sat, 25 Jul 2026 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992954;
	bh=tnCIGRidywhKVV2Vw/UCpeoIVO0Pj7ycRIfB9pNrrfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtuFvAJASBA7Ou6ifC2vydWixeHP1osB6PvvqGqGYQ5tRHJiHC3d7KSqR1lqieWpi
	 HZyL8QYNhMCKf4YYp3NIbN+Ctr56DURIB1uELOCn8ctS5LCW6nCn/YygyPJJCFTZUq
	 Isal9VTKuL3lSIe91gmsFlyiyXR7Et3gFJI96QjtETe5BkfCQ5TLhzvQAIqdSCnJbN
	 61zTqgQD8KH2nmNQOXxuVYmMDSB8O4zKetlTdt9j/jk5CQFn1vbwgHN/j7aC+bONnd
	 byEqhFL7NyQf/i8jDp4FCjCrMratJnZatuJ4fcATpedZsGWSUbhBC2A56nTI76A121
	 do9M8QRyKuFDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: thunderbolt: Fix frags[] overflow by bounding frame_count
Date: Sat, 25 Jul 2026 11:22:31 -0400
Message-ID: <20260725152231.3857257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072027-siding-engraving-011b@gregkh>
References: <2026072027-siding-engraving-011b@gregkh>
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
index ba9f7062f5a7d4..649477b97b0584 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -746,8 +746,12 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
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

