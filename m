Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320216;
	b=5pFZuRd/Q/k80+d3bwELlu24W4qIV3F4KUi6FVTLmdRpv51mF9H8zvsM/E2OPT2GDjPd
	 5iMegz6/CotkAqSRfnMaxRtYmhtPHAlZ7YcOPYfJmXxBJwFtR5ef4sz1Kb1myYdroiWKq
	 SahhC0QdFOzqFbVHb6T8rk1EfpHWhRlc72M7MpNGdBjWX2ym/oU3P4QKewIYfmaAkEzPr
	 lI6pQ4AWMxUbIpDljHLqaPPL7uvmduFxTEhgi+T0C4qFNwWcqryXS94gy0C/g0ND4/vvg
	 i8WZ6F0fUFwMIDzAHkRVeKkpO6oPqgtvS9cXkBjExUroetd/I8uAxesssTTByXQ7qJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nKFgHCYaKOZ0pDwMLAKGXcAzsTDFR6KfRvkdKP7vBtk=;
	b=BgDpxqT6NnS2NRCInxphp37ExhfmUea82Vnx7/L98q0EHFcb58Ybi1W363okegtMzDyM
	 uses9+7P/Uny9e712eZ5trODXE4tynKUgYlZOdBKS7DRDEJYVtvm22DkQ9/F2KZQyxeU8
	 R3HawiPBPHHE8JL5aMDiQQ283OaBoXPxiSTjM0DvsCjVAxfXK3BRvTnc1s9M0WbfFO15m
	 iym5WoH4HtI8GWFU4VF6mfsPkyQ/87kYgLheWIzRtTBG9nblMBpnISXqScR0tPKIlIICv
	 qoMSZlcAVSymIOi8wPjwVie9wQFxfIMMB73oZ9LYyix2rJ+NI8R8pzS7bqIfmbVmqhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQAd2tJA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C460A2608
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQAd2tJA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C571F008A2;
	Tue, 10 Nov 2026 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320215;
	bh=nKFgHCYaKOZ0pDwMLAKGXcAzsTDFR6KfRvkdKP7vBtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQAd2tJAtXsl72cyruIUIA1NxGrMs7C04pf/CIpqSd7JbzUXyZDrQ7gafhL9hfgV4
	 o/yPnFX1b2nK+0D781ETM+/VX5M3J6moTeN98bbqlqVkbjt/UNEJGIM5j6kVAp7NMj
	 8TjaxdBagIidgrDjrpVAaSEe31JC7LuZKUBXrgP7nnhB9P61j2CGnG1TkUbHr5CXTh
	 z9gzlHx8Bd23BvFbVLQ85x9gLadxYRUVv9muPuRh+W67PSnVxdPBx9hXjGn03NpegB
	 hYCdpEibOLCDcDxgdmEkrHx8oiZ+UIJAxAo9etq0OGheQWB5NfKfnpFmYD7DEKQ4G3
	 3x4Qfrh7QOiMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] ALSA: core: Simplify snd_power_ref_and_wait() with the standard macro
Date: Tue, 10 Nov 2026 09:16:50 -0500
Message-ID: <20261110141408.1841234-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141408.1841234-1-sashal@kernel.org>
References: <20261107061731-failed-5.10-ad63c5b62843@kernel.org>
 <20261110141408.1841234-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 8c0ae778e2874f3742bd619000b791d178c187e2 ]

Use wait_event_cmd() macro and simplify snd_power_ref_wait()
implementation.  This may also cover possible races in the current
open code, too.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20220119091050.30125-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: ad63c5b62843 ("ALSA: core: Check shutdown flag at D0 power-state, too")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/init.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index f5b97ebba1c18..279c630438882 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1014,29 +1014,14 @@ EXPORT_SYMBOL(snd_card_file_remove);
  */
 int snd_power_ref_and_wait(struct snd_card *card)
 {
-	wait_queue_entry_t wait;
-	int result = 0;
-
 	snd_power_ref(card);
-	/* fastpath */
 	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
 		return 0;
-	init_waitqueue_entry(&wait, current);
-	add_wait_queue(&card->power_sleep, &wait);
-	while (1) {
-		if (card->shutdown) {
-			result = -ENODEV;
-			break;
-		}
-		if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
-			break;
-		snd_power_unref(card);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(30 * HZ);
-		snd_power_ref(card);
-	}
-	remove_wait_queue(&card->power_sleep, &wait);
-	return result;
+	wait_event_cmd(card->power_sleep,
+		       card->shutdown ||
+		       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
+		       snd_power_unref(card), snd_power_ref(card));
+	return card->shutdown ? -ENODEV : 0;
 }
 EXPORT_SYMBOL_GPL(snd_power_ref_and_wait);
 
-- 
2.53.0

