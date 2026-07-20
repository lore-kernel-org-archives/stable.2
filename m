Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BF42D745
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559588; cv=none; b=RkOERdi9GbzZPvhfBQnngohJz9MzGVoAl1ZyMnAykCTweL8giPZWZjr21M0JPBF/L2ivQhM1ooc3siDTHJkgBx3TcisvcBb8H+uVtobZeajAWWnIvnhPIp/VOf4Kk8sHB8a2TMLLEvQyySraAH+WMUF+Cnq29Fr/kemEF2cJ03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559588; c=relaxed/simple;
	bh=RIClXi8Fn49rmqxRNOIn5PMxmudIG2asdS1Oj0TbXTM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rAkPcF+buVe6eCAP86EQPadEe+y1vVUfOOLKJC29fU+7aeCTLh5UdsIk4Wdd/hFkH5LNsdOmOJ/pj21G/QHJo8t3ynV3TzfmF+i+OYW3bvDmiwnYXWeK6IxkRgoD2jmJjNY0wRFVxBSvAFpcqo6ykgk9b5yZX4zg80XWTPvTGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/r204ck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/r204ck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8521F000E9;
	Mon, 20 Jul 2026 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559586;
	bh=EhJ6iDq4DI2Dbbkn6aYT4V68zceY7B45bhX8EcDOl1U=;
	h=Subject:To:Cc:From:Date;
	b=e/r204ckhgLJMl0XFwc43y5No6iZ4mFImIh/H5KreK1k+53qWBYjoiOlA81TL+s68
	 U3YClvI+NMmQNJnmyESiqiec3gA50GLIARZwwimAUYkoCTyG/0WUGvY7N6CogauWs/
	 r93NmYtx0HG46PRWKPJ1UKaaXGgPk/EpiD5T9UL8=
Subject: FAILED: patch "[PATCH] net: thunderbolt: Fix frags[] overflow by bounding" failed to apply to 5.15-stable tree
To: maoyixie.tju@gmail.com,kuba@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:59:27 +0200
Message-ID: <2026072027-siding-engraving-011b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 55d9895f89970501fe126d1026b586b04a224c27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072027-siding-engraving-011b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

