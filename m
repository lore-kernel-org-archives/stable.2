Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.43.8.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322744;
	b=j6frWxu+QCPkLOUBXJI/KMFJr0e5YBkKrRP/xGj3AlbxVCHNCyDVYom4GTgvI8Fc4RFf
	 paP8ZdHmhqwjlTC1mvBsEKN7SPOhUjLkLS62TM00aGjcm9VhJg/G77wiqPoSJG0pbF2+r
	 YlfxQ6LnY4siEhqwjp1dHY/eZc1hRL1MgYHif1SwUMbcX9egku+B0/W275VoMn55Z5DCH
	 /vH/+nEGb2janM32C/wQHkBEitBvhAHP6cPuqHxW+vmyr6vKb6Jsl0djmD+iIWBY/7AzD
	 aOYj4QdaReyd6IGd2+cfAvaI8y1Pxb4Sfrpnb+ixKF7w3M296MWdCAHMTAOXBBV2x6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322744;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cLZUGeoAwmd0IfGwar4yPQmtf9nguQDhh2qpHIE6Lsw=;
	b=URjVfd5oGnDcW1H102R8McfE8EIVj4yp4M4ryqZaQlAsdrLh6MsBFq+dEUz7fg4Kwl/1
	 e06RZvIfjuFf2wdHHRStoGhWAjDOtM6PKO/N02/+ZhOSZM9o3AbUC/5z4iOPzd4ef176t
	 H6aXtIpFaXpRxoh1SqFkPGPI3xd01t6tzEqTEZ/MszRwHF4NrDXC2cgqEl5xJy8+2G2qk
	 8gmh8H1DcOewz1w3upfTpP9UAa3dEShZmZ3krlsgIhXRxZkD7SCxolLY5dpLjlpRp9PEw
	 yhKrS66HD4ivvcTH4oh5AbNvylsuJbdgsOMqPNANVwtCe4tjd1AOAfkFpa0sGpesONA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=altlinux.org;
	spf=pass smtp.mailfrom=altlinux.org;
	arc=none smtp.remote-ip=193.43.8.18
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70160A2621;
	Tue, 10 Nov 2026 14:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E70160A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mininpc.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: muhamadeevir)
	by air.basealt.ru (Postfix) with ESMTPSA id AD607233FA;
	Tue, 10 Nov 2026 17:58:54 +0300 (MSK)
From: Ilya Muhamadeev <nicourced@altlinux.org>
To: linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Ilya Muhamadeev <nicourced@altlinux.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: es8316: Allow more time for headset mic bias to settle
Date: Tue, 10 Nov 2026 17:58:35 +0300
Message-ID: <20261110145835.106381-1-nicourced@altlinux.org>
X-Mailer: git-send-email 2.56.0
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

On the 3Logic Group Graviton N15i-K2, a TRRS headset is detected as
headphones, leaving its microphone unavailable. The driver waits 20 ms
after enabling microphone bias before reading GPIO_FLAG to distinguish
a headset from headphones.

Register reads on this machine show that GM_NOT_SHORTED remains clear
through 40 ms and becomes set at approximately 60 ms after enabling
microphone bias. Reading the bit after only 20 ms therefore incorrectly
identifies the headset microphone as shorted to ground.

Increase the settling delay to 100 ms to cover the observed settling
time with some margin. This adds 80 ms to the microphone bias enable
sequence used for jack detection.

Fixes: 822257661031 ("ASoC: es8316: Add jack-detect support")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Muhamadeev <nicourced@altlinux.org>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 334ac9119c18f34d51d79fb357c3d82096935c7f..470c503010fc1c02fba9d8e9aaf0ea61b4be3637 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -616,7 +616,7 @@ static void es8316_enable_micbias_for_mic_gnd_short_detect(
 	snd_soc_dapm_sync_unlocked(dapm);
 	snd_soc_dapm_mutex_unlock(dapm);
 
-	msleep(20);
+	msleep(100);
 }
 
 static void es8316_disable_micbias_for_mic_gnd_short_detect(

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
