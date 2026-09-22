Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685ED42C51C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080483; cv=none; b=pZ4axiC0Xi789zUsCIMIZg+PO5N1/cyc02cBkCKeiBmvJ9U4kFV7/tb5tdiC+D61iYNeUJBOZ49Vx/bWHnHSLBqjbQBLsAeZmJ8G9vpBXucJO6Y25hcrli72UoG0mKbWnslH9oGOafAt5X3sFj9xzwFwpRRpcHjfDVfpioDK09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080483; c=relaxed/simple;
	bh=1wiliW0Isxh/e8+urgxAa4Oi4TtrDbKZ7J1e4oD2ZgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOwJeEUpj0048u+V+SDGVR84dLmKa6YC9oCY+tfhkwikEa1o1CwuaD1YxNd4Lb5TsSZc35xR47S3mbRkl0BA8Cc0X6AFsxDq86S2X/ot8iyzz+Hydbn7ZSraWU+/8TplrhlCD7q6g6jVYdyOV0cNTiNjFZx/OoZjC8et8ryC+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oob2c4uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oob2c4uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89021F000FF;
	Tue, 22 Sep 2026 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080482;
	bh=5DpkGbqJml1Q+OH8veE0Z5oRC3YfhcL3fRnPb0ub1Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oob2c4uoSAA5l+Pi7JjQJfRi8U88xdVVl9dEPOgXHV0JtZIEcsgbdeH5BYrCsDg0y
	 VsOK9qvEj81rwq3lzOclJcSfHhyFSHaZgu/jipHGOV7e0XTVV+PO/UZrPRJc5hj1QZ
	 aQeGqO0VjpLv/pqdgWQ1wkyP5Jlcg+gfeRxk44lo6q2zjidLHxxzoSaEeN4FCj8mjo
	 ot3ETXqGI4TusPL75vPtP+vGb0oBUnStvMcoC2IVKdD3OUtyK1amwoXkVkME/fCQwk
	 INO9VSrQHTy2alHXdoEAIXTN29g0g9YTt9R2EBR1XJGptqF0SF/3tpdXs+b7RZ9yeZ
	 zAtO0VjxgR5MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ALSA: usb-audio: Optimize the copy of packet sizes for implicit fb handling
Date: Tue, 22 Sep 2026 08:34:39 -0400
Message-ID: <20260922123440.2257183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092246-smasher-unpleased-5c4c@gregkh>
References: <2026092246-smasher-unpleased-5c4c@gregkh>
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
index c573d74641d42..77e2887e81ae2 100644
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

