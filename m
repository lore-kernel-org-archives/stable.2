Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC9284B37
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083845; cv=none; b=nDBpWtDv9tXnzqwWjT5FWNZt/HdJbAxpWz86uoiRP83LOeBkXFnToX7oFxnFZx+6WkSHzJIsr6YbZmw+LHqZYBnI0LY/sMDY1QJ7OpZWqg/qjlrqQBDHalxP8AAEFSqnmjf8uKY7/yZFgoQZKLOTNs2aQSHJhF6F8wrEocceLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083845; c=relaxed/simple;
	bh=abLruzda8igCqK+mSXKeI0Q8tXwy0KVr2h7q8u0b2Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1KaRPc7AJ2b1/91LPGTHAZK6qmp0v3wqSxwEAp418nJpxlzz06Ss/avXB7kzqqk3FQVy0sO/HMgAQh8cM6hHYp+AfVVmCKxPfECtl1ZCG5Ub2SM2DEJSNA1s9+qGR86KnWjgyCXbbmF8CGGzNVth3v0+eEzOZU9SfgC4q//5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btYToAZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btYToAZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E21F000FF;
	Tue, 22 Sep 2026 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083843;
	bh=cV/yHPkwExBdB+CpPdjP4ZpVAHIvMjw1oX6FW/t62ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=btYToAZknXfD5QRx+5XluXYoUMh1fHRVbG0B/wCJvCcYEaofOjGGEO4kt6jLa1/Ww
	 Uci2oxO8TRQTiMV7YU2HpGIc91faN/YxTn+BjXEzmHQJz2LcNCY/4NhssALegl5H+o
	 KFyi0Nj+ZifoP4CP2Te9DZuHQLOFTFpq3ZySHHriiNxH5FpDR3U1+M+mvNXhrxeOn5
	 yzUmaFmdpX/9CzGjLOM4MtBXIir8vdFh/ujXHGGoJj4rXSwAoRnKUCSJ0mNDCEAhKO
	 Yp3ufy4JIGdghAQ/eO0VDvVazAbmnl38zERHbQteKAVj7rtFw3D8j/zLix3Ws9FL+z
	 vuxj/ki9drZLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling
Date: Tue, 22 Sep 2026 09:30:40 -0400
Message-ID: <20260922133041.2479161-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092250-strudel-coastal-4db3@gregkh>
References: <2026092250-strudel-coastal-4db3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 36adb51ac0b19edb32ffeea3fe66b174bad25ead ]

We did manual copies over loop for the packet data update of the
implicit feedback, but this can be optimized with a simple memcpy().

Along with it, change the data type of snd_usb_packet_info struct to
align with other (from uint32_t to int).

No functional changes but only code optimizations.

Link: https://patch.msgid.link/20260216141209.1849200-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 76a986c980bb ("ALSA: usb-audio: Clamp implicit feedback packet count to URB capacity")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.h     | 2 +-
 sound/usb/endpoint.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 6ec95b2edf863..ac5505ce046de 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -89,7 +89,7 @@ struct snd_usb_endpoint {
 	struct snd_urb_ctx urb[MAX_URBS];
 
 	struct snd_usb_packet_info {
-		uint32_t packet_size[MAX_PACKS_HS];
+		int packet_size[MAX_PACKS_HS];
 		int packets;
 	} next_packet[MAX_URBS];
 	unsigned int next_packet_head;	/* ring buffer offset to read */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e995b7ab88b19..aab0ea614f4a8 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -477,7 +477,7 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 		unsigned long flags;
 		struct snd_usb_packet_info *packet;
 		struct snd_urb_ctx *ctx = NULL;
-		int err, i;
+		int err;
 
 		spin_lock_irqsave(&ep->lock, flags);
 		if ((!implicit_fb || ep->next_packet_queued > 0) &&
@@ -497,8 +497,8 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 		/* copy over the length information */
 		if (implicit_fb) {
 			ctx->packets = packet->packets;
-			for (i = 0; i < packet->packets; i++)
-				ctx->packet_size[i] = packet->packet_size[i];
+			memcpy(ctx->packet_size, packet->packet_size,
+			       packet->packets * sizeof(packet->packet_size[0]));
 		}
 
 		/* call the data handler to fill in playback data */
-- 
2.53.0

