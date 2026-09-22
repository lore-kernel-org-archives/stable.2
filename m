Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B6542809
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079559; cv=none; b=dVtsrgxJvhKp0wtyfcYuasuVv7fbwRMsGBmM9BQWoZOhp7B2X6Qf2ns+QLQWxgzxz9mY3LDSvBK+TMaf0N+CSbyJsDsWxgwIg+c2G7VknxVdJNiA6RNWXnoj8spkC3qLU7kGL3xZTrIgoHB+hvtOtzS7oNp8l17QGwVGpXXIldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079559; c=relaxed/simple;
	bh=CX5oUVuN8qssSU5rS+knkqdOyl8P7Vp/oqzWrlJmyV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv1e9e9kQm//WPJQTazKbt2WVSUokLeGKgReMz4Egaztlz9/mO/wWVWS1ccW74wO501nFAO7Oj6BN7d2vbYpeGjENGpcKCrCwu3CXnxXB/7XJbX4gZ/5nDRCmara0JkO/IBA2T/Toihmo6qQX3bk8rjss9umxfKcVYNWP7seyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+qRe+l7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+qRe+l7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632131F00893;
	Tue, 22 Sep 2026 12:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079557;
	bh=E544rzttkM0A4PMMSv1gowZ4+M8RJrn6IQuTZbRq/8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G+qRe+l7HQ0bZyKtNhatizYPtVLUJz52T15+BIQoCGSQoI4rJFq/V0AD5EY+Dnn/b
	 sNw6c5TyUyhNwAOIja7CF4BXkIMIdnc3Fe6Md2hy64YUN68WYA9S8xlrgKRCf9oG7T
	 P2MtwsAaKXePM20AD0q95kPgSIXKK8EbCqGqwSHPlRcVpNmmALmAhdAI/tkn2/QGIj
	 f6yyz6fcJSSk3LT+92hHKhedJr9HJAWtWOoAU8qH55iD1hzyBrFqIUvwOrz9eAytht
	 FqJ9T5lh7yWftKJ3J+0A4okaEYTFid699NURBJPLaB6mNmkqw7cH/piAP6agWuG6Ab
	 rXbxazgtrG8Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling
Date: Tue, 22 Sep 2026 08:19:14 -0400
Message-ID: <20260922121915.2213648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092245-renewably-elevate-ca0d@gregkh>
References: <2026092245-renewably-elevate-ca0d@gregkh>
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
index 94404c24d240d..e34d92d576a27 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -90,7 +90,7 @@ struct snd_usb_endpoint {
 	struct snd_urb_ctx urb[MAX_URBS];
 
 	struct snd_usb_packet_info {
-		uint32_t packet_size[MAX_PACKS_HS];
+		int packet_size[MAX_PACKS_HS];
 		int packets;
 	} next_packet[MAX_URBS];
 	unsigned int next_packet_head;	/* ring buffer offset to read */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index bdf0e724d4187..3f46b82561966 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -470,7 +470,7 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 	while (ep_state_running(ep)) {
 		struct snd_usb_packet_info *packet;
 		struct snd_urb_ctx *ctx = NULL;
-		int err, i;
+		int err;
 
 		scoped_guard(spinlock_irqsave, &ep->lock) {
 			if ((!implicit_fb || ep->next_packet_queued > 0) &&
@@ -490,8 +490,8 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
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

