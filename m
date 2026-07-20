Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5683AFB0C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559585; cv=none; b=fbwWBQZGBE3BwWbpkFo/oBTOjWxlnefRtvcGqMEsqXBTryhpA5Nlv2vSPptyr6JQANt2F73Y8TH8OJH6dXdZyoc4F4wWKWuanx5pnzry9N6BpDbuxCqcmFLXbEjgh2LmviNFQ1P2J9nzZaeKRmaZbTuLVGTu/FeZQppO9ontjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559585; c=relaxed/simple;
	bh=3rqWnrySLmbg0rjz/5MZgnb/pOsGus2Euy5mM6CZOr0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p6os8cRkM9BGRJzOqtz3+XLID3ST90kh9ifBCrHzNp279O25+l5IXbPhbEfc9EaMeADctvI8eBdUixuzU21Jp2NeL48B1u/CEYDebROgQTGhLCrvzQJFVnM55GnBlMetn/CFNrL6MUEYvkqRL9h1HFb9fBWVJVOiqLvB5FqlDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xaaD2u2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xaaD2u2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26131F00A3A;
	Mon, 20 Jul 2026 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559584;
	bh=DgRroCCmRAIbU5NHwz/YPGc10mHhFEjQSCxh+sGODv4=;
	h=Subject:To:Cc:From:Date;
	b=xaaD2u2nP/pktPVAEPgnpxCj1RXHvaH/Akl/DGYJhaP+ye2TnN0BGRrC2H3uqMGco
	 eWEUrnvNhQUmTFkBHjADuONt3EyhQEQIRP0AQyyuKt/1J26ErO3MTfQ3rHyD1UyC6G
	 dI/dMx1LwknnqGkVrKyeONliXRj1j/t1ulddu1vQ=
Subject: FAILED: patch "[PATCH] net: thunderbolt: Fix frags[] overflow by bounding" failed to apply to 5.10-stable tree
To: maoyixie.tju@gmail.com,kuba@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:59:27 +0200
Message-ID: <2026072027-emoticon-broadways-586a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 55d9895f89970501fe126d1026b586b04a224c27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072027-emoticon-broadways-586a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55d9895f89970501fe126d1026b586b04a224c27 Mon Sep 17 00:00:00 2001
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 17 Jun 2026 01:38:41 +0800
Subject: [PATCH] net: thunderbolt: Fix frags[] overflow by bounding
 frame_count

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

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 7aae5d915a1e..ac016890646c 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -787,8 +787,12 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
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

