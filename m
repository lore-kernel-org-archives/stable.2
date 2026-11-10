Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319423;
	b=j3aNs53qQ3WVL15SVfnjKTXgWUfCvWMxbEtAae2GHUsHOvx/2PmH1ChmY1QYpzskV3BW
	 ArhzZQXRkGb4bwwh4UJVMGXseXy/T2wK+vAAPBOH9ljg5QbK53tL1+DSKpnaNfHVJfpg4
	 negRWEhBeVGhym6ODJt9JYEbSgEd277345hCNX7BJTrmWlbioOrZpeMg6qbnMl1SXIMyP
	 zOLkQhczEyqSCnTQiDbWZOKK07MjUoNShP4Xn59bLBKn+MYD99uufvn0+kfom9hxo7vV3
	 vUkitwt+XG/YA+eIeR+1vwGDRcqKBaanLletZa6n9cEAtpJRizh5mZ4Ymy2amAT43yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7hOMnB/VbWg/0xXq5zwBqhYcBW9E8nf2GYQFTSGcv2k=;
	b=IIa/rBgBbehzK9Xithj0G7YJ1BpKMg7Z27mZhtGhFufiTY4xL/m8/OSZ8Xq6VKawVlt5
	 Yxo5bA2Sfs9N/S6iO1ZJ3zbD1Sz6w5ibXNboW1gimr5MmFUkCMs5cJo9cD1PP3qBiuWOm
	 /ARzRXuoTIM96Ob3m3LcWFaGNu5tf9C22Z7f7cd8jkcvoslyBnwXiiuaRziaGkhIBIm+f
	 Sfliiycy7nCL6eAMGvkMPe7DIShtX6wZVddNW/EI81U2LzoQSBgW5KngFaNlw0agB65SB
	 ApNJnS9jJTHsgNj6duaCxQoUZxZnIq7tGVeRkapsjZ+pOz+D4uv/hHP+XhZ6E5QC4hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPVcyn59;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6760A2633
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPVcyn59
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F210B1F008A3;
	Tue, 10 Nov 2026 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319423;
	bh=7hOMnB/VbWg/0xXq5zwBqhYcBW9E8nf2GYQFTSGcv2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZPVcyn59aThPDx+IWrEM7lxOyZbpbL0HRpEk2S+KhvXbNeS/Htn2SElq7Tr4nhMqf
	 2VUEfkJ28RcXdOZEXB8rbegLRM34wsESUI/+x9BgiDc0P/eQvZMiY2BAUawd9nmQ3W
	 bEzl38bs1mY4RCJpGoLmXKgPjsLY9n/795cnd9Oc5wc+6ZNH6uonaQJDfDxemUfi4V
	 3+UrZqMg3GmMDV0BX59roZTHvlCioAflacy2PVOEDPocBSu0/ti9qLrBidJC47BboT
	 Zelxlxdv1p/8UnNNZTV0S7/28w+glG+sgpbnRjUzXXBGcZk1HX3GoNL4OD++yC1CS9
	 OlEFKjeRtbtIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ALSA: core: Check shutdown flag at D0 power-state, too
Date: Tue, 10 Nov 2026 09:03:40 -0500
Message-ID: <20261110140334.1822546-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110140334.1822546-1-sashal@kernel.org>
References: <20261107060043-failed-5.15-ad63c5b62843@kernel.org>
 <20261110140334.1822546-1-sashal@kernel.org>
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

[ Upstream commit ad63c5b62843895e8c3cd7291ed07cc659df0355 ]

The snd_power_ref_and_wait() skips the card->shutdown check when the
card is already in D0 state and immediately returns as successful, by
assuming the all-green in D0.  This assumption makes the code after
this sync point behaving as if all power is up and ready, even though
actually it might have been already at the disconnected state.

Add the missing check of shutdown flag there for the more consistent
behavior.

Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260929125346.1478631-2-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 0cd775e913bb7..be04e64490ebc 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1155,12 +1155,12 @@ EXPORT_SYMBOL(snd_card_file_remove);
 int snd_power_ref_and_wait(struct snd_card *card)
 {
 	snd_power_ref(card);
-	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
-		return 0;
-	wait_event_cmd(card->power_sleep,
-		       card->shutdown ||
-		       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
-		       snd_power_unref(card), snd_power_ref(card));
+	if (snd_power_get_state(card) != SNDRV_CTL_POWER_D0) {
+		wait_event_cmd(card->power_sleep,
+			       card->shutdown ||
+			       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
+			       snd_power_unref(card), snd_power_ref(card));
+	}
 	if (card->shutdown) {
 		snd_power_unref(card);
 		return  -ENODEV;
-- 
2.53.0

