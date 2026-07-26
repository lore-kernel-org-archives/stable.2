Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E03A7826
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067260; cv=none; b=YVMqVlxvNDxC75aBLIZ5ydOIQY0yNhCneVaHfLjQNhUBFVBFrIbelr6duSS+nJt/eyIj6Vym2F7QMqEyAYJ3Wb90LgnPyHzHdb+ynXM25ZTE4mh3hmNO91PXVSPIE6xCTDAwDryY5+Mt+3te319KbHA9y18T7vgSk9YAW4PwL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067260; c=relaxed/simple;
	bh=xh4eYJbMdwPgXWImngq/F1AcClPph/c3cjZhtvfnlgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXW12oVrFF5g+9o6W3mwVASv14uPg+GgGxRiDVowxYdAqknNLujfHRCffLqFul0nsoz0E3qFRjkjqql5KpCgxCcO+WY+03Af93SuW3EGITLUYz4Xtser8Q2SFuKDdD0Kt3Ddpsi0TDHjoa/tpiUCUC0CLUQPMiQVfFX8dj5CT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcYwWO3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcYwWO3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2431F00A3A;
	Sun, 26 Jul 2026 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067259;
	bh=E2qLCb84r0lVujemOI4bLoChKBdrsWXlmmlT3e+84TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XcYwWO3c1GsS4lZoUnRHtbdyGZpYGvdBKagAf4JzneNYJ2Wg9SEwEcccRA/0qzdoN
	 V+hlRJ6wVmiq6dD7Pc3kjdQjBleSfPVHXlhsNXvOC47sM8CZrrwfvF/DNZwLCvfNw4
	 EmsA/aWv++ZU8ZJCS3Xn8/Mje5SkhCTFSRWeO7aK56dacPWPJpSl1uL+Q9YPwpq/GX
	 rVHk8kgwTJID6LuzYmrQcIJeZ1hDFdCXrvWgLiguudiozQSXnK+hoiaGzru82BpKrU
	 PK5gYyMc4xaT5AjRgEK4NHGmWQNYfFyF5cGbscYVGXEe2BqCNaRJaOSQxfOGnDDMZk
	 Wa5h7WXRAmmSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: thunderbolt: Fix frags[] overflow by bounding frame_count
Date: Sun, 26 Jul 2026 08:00:57 -0400
Message-ID: <20260726120057.4138446-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072027-emoticon-broadways-586a@gregkh>
References: <2026072027-emoticon-broadways-586a@gregkh>
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
index e05bcf86306cff..d2457d799759a5 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -724,8 +724,12 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
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

