Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138E544D44
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082640; cv=none; b=UE8Zs83Q49q7AAN3ONTgsdVHfMgo4rtocMXslvtwbhN8TyldfFDa6xavbRNNWfDbm4gRntUNXtW3VGcKDxc8GmjiACHHRaH+08V3GD0hQ0JNtgccdYjYzo11DVjORamKCmYlJBPGQgbvQOM1mlLya2N1mH/WPjFA9/IiCfwd/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082640; c=relaxed/simple;
	bh=1kh6L6tcUH6tQA0Qs+5lip2V9BBsWk/H0PQ3gRv2VfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh7pcIdJKrWt/WZmZgOFVEGeIOwumfHYuz7q7NtxGSW/pvYHaJFnx4N37cdgyu7HOlt8oaWt8j499cUXvFqtqGW3/Xq7jfiiHQsz5cRdbnE2CneSzDLrG5hKHqwsHRm2aAETyM85JrmZi8A7Kz/PbXM23hmnS1BlVvOJPSgQ5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it0qjHjj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it0qjHjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538651F000FF;
	Tue, 22 Sep 2026 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082638;
	bh=20OciHeCo1/Tmwnm8JerisLcJ+q+brVd5unya++f9Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=it0qjHjj/viNlMmhvzW0ypRnF1b+ina02sVIyNWhInAV0UY38NyUXuhsmIKPsexpe
	 4ffQJXp1MuhUWOndMj7mQJkA2K0S6NxUQ3+Y3xA4N36dH5G/k1vtZEMqBkULOS8yd8
	 v8BG1UzQojaJtbwAyXqZrZ/fU8zHnHYj/24ZsGQiZ7uAy0cvTVWExeElVwdJIHT9fv
	 nUFe44ivAxSLDniBduNlgKclQAk05tFUauobl+g1idgVN4m/67ImLqCFSuCv6akFUP
	 pQEl88qwj/3OljICrIiIXmE5me00Ila8zQ/SC6j24jiBTRHRhALsA6LRUGkXmpNlZc
	 3B98LyInbVJMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling
Date: Tue, 22 Sep 2026 09:10:35 -0400
Message-ID: <20260922131036.2409076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092248-grouped-ebony-750a@gregkh>
References: <2026092248-grouped-ebony-750a@gregkh>
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
index 778466624f030..6cde8455da37b 100644
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

