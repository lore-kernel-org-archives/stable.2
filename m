Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6F545296
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082038; cv=none; b=IbnT7R+u8tmKBzk722z03jWWDG4YNJ5G1q+aHZcxWwC70RtLrFzAQZ69utu6Z1SKrf81DY3qsTF/abek1pjh+cH+/iqA1cGtVtRBvyjQEbfJL4m3u/Niq4TrkfA53lAAXTnZK9NAHRShdimAYodbpuGK1aOdkeKqLcxV16wl4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082038; c=relaxed/simple;
	bh=2nkHm5WOvheEADT+mHLuH+65xUQmmYnVoGICgbKcB50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMhTtFNJs6ZT9bX8dtrUw3fQJeC66oRhAhQ+zEWv/a3wMUmHYYgl7CxGBQ6Yyeb5CvFez2pzutKXLvDzAQZthho5JDqmtwLTZ3eJMxHQaYfo5jiyM9ewZ1robG1qL72bwGp9te4gGRIF641tWjIm5tzYl3LV9XDh5fDZIj1zCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkVzHxSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkVzHxSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28DB1F000FF;
	Tue, 22 Sep 2026 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082037;
	bh=5sX5HKgim78qFJZiSrhgP6nu43GVyt7XIx1WccpK8Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IkVzHxSPOlEdPu/9+/5uEYaGUVVH7A6C5I5qBKoK4/eag1e3do3scobWTJprQBW3D
	 xVTE3eaZc/6R6knXknHbnnQ9+EzFDmS2IMoXiTnTG+d4iu4WzHedG26aH1txtpyLAs
	 nMrpW+CBKlXH6fT2tOgM6IvTIcUqi8BztZCVI0oVGZJhwyqI9F/9koLusndWmKBmAO
	 mBLDXIwGZA8oMGJJGQEgfYAJavZkzIHC6yqMtRwXkRcOcCgxY4klnp/81er95nziea
	 1a31XOkU66TVLvn9ZTYKozI43AaEijt6V7ZJ0cyb043pLqePsIAKiOoLdz6sEovnPM
	 ht+9aQvvd7npA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling
Date: Tue, 22 Sep 2026 09:00:34 -0400
Message-ID: <20260922130035.2357842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092247-repacking-synopses-6931@gregkh>
References: <2026092247-repacking-synopses-6931@gregkh>
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
index c393a9125b9b3..ade43bd97b991 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -478,7 +478,7 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 		unsigned long flags;
 		struct snd_usb_packet_info *packet;
 		struct snd_urb_ctx *ctx = NULL;
-		int err, i;
+		int err;
 
 		spin_lock_irqsave(&ep->lock, flags);
 		if ((!implicit_fb || ep->next_packet_queued > 0) &&
@@ -498,8 +498,8 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
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

