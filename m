Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670304;
	b=RHfpNCcqh20OC99HlhtoCRuW/kW+/L2hSE1g3OZKnrhDTIX2ptkaKKtH2n0omQIwGktc
	 CngfRB+Yi1FNcmdoUeOqyoQc2Rzs1IETWGtAiNNAtvSXxHjGtYaAp9fOuOx9cObInvp9E
	 4Jan9lxqEq18Szxmfn9JEAoLuI/1zfuLBrJft8tr9LyHapkZzfVLNCCbZXUQaGsO0XUQE
	 epmeQLl/B9fDKNOXHuGKq1RTiURHTIGUyCz9s/CzHkYdKgOyLyd5iejnC8G1bZrNPrLMl
	 eAKdFanj6HnI2dFCwYLfNI1odnUYk/HQa4xra0sLwi12QWYHCmhfbflf5ki7m3rfR8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zsv+xoIslAlTljqBg12NU+Wygtm3YAvMHqbGgsgpyzQ=;
	b=zE8U/SL2qW+2AGihh/xciXCWcbnupagFvurTPZQUX4vAougoFpcKtL6mzYzXkv+i0u28
	 Fg39BPVDe6n6MHJDbqlZOxm2zKAXPPm60uVatg6lDPIYWe6W0tt4WmNNpxkeGWJ/pBv/l
	 NynKAauUUhSKb4vSJ6q8500+DbyWyy7Rn/nn7SNesC4BYgpBi7luO4CKaZeNyFrNwvDos
	 wPNBrh8Onwb2Od98fe6q64fh3GfN317UCI2u6dincS5c/PN+VfplWKGxyu864Sad8Q+/D
	 bTp2qjyaYjD41fnWZfnUFpSHWyFPjwHExE32oHl95RzGeNH+xRkO+Sx9/ivKSyfwkJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eavWJLn7;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECE606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58ECE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eavWJLn7
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso14056515eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670303; x=1796275103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zsv+xoIslAlTljqBg12NU+Wygtm3YAvMHqbGgsgpyzQ=;
        b=eavWJLn729s79Wc2z8ut8r+vSxgpeCNFtIrwFIuqebEMAo51j3fYefHUoPdYa2JDNV
         MR16m50EiyKX4yv3e+JnyJP2mpwZGvJ2BjbxUVuKqtHqI3VTRsOYLmUiGTUsRNpjPzxU
         KE4k/DSy0TyPtnz2v09XGAR9L15fqWjqlTX1PGTZTxq1qeRyryUYyblyneusgODYCko0
         kgTQm8zZoa5dE1HBnZZ6xUEFja6VKZkLiUeB4VKnTHd6B6pVnxZxOjun0dJ4eXX/Z8Mq
         tX3rGup2pjBITvKem26XnDDowqL4klwsGxd2vc+bIufB+dzX++rS9sElJBAMs3ySVwwL
         GraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670303; x=1796275103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zsv+xoIslAlTljqBg12NU+Wygtm3YAvMHqbGgsgpyzQ=;
        b=MiYPmVSM/l1A7Iovns0QdiYD2iaHEVlrwnG+CTMo0qT0FF33C/AcV2/47p67bze5yS
         kQsQ2EjEyr15LReeWdMKODfuz6IGxmXSgZDY14pxTYWtVwQNAWWHsNunGXHBxpcS4Pu2
         3s53+Fj5I8vCfd4+kxotM14IelbwVIc4jPeg4Bad9R5mMCOChKZ21iBjZrArIhrmFP3m
         4TTd8O4CYRPXhg7iY8tWY2OV7lVEraW5K5beo9CcGIhb4h3ivTIiMMYS+d6OIMso79TC
         Q9+e8Z7QDfWfmQqt88qGWRcQ+cJWGaZ4efFVfZAy3Hr79Q0HTS7O51I5DkbWmx117YHn
         H4SQ==
X-Forwarded-Encrypted: i=1; AL+hErE0TTHLvQnBWWxzjyUCjrZ5V8+Uv/zemsMdoaX26z+u1cldYM3m6gLhpD9Gs+2I78B5n/sGR04=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GJw3TVlvDa/busa0UJB9vE5xiP5VTw5DNewHF/h0HIapYbuX5
	QRFkSz/ZqOn0oyEzky0iq8TCnp7vSyytqqiPEBTkWEBgM6milc8lbo4=
X-Gm-Gg: AZFdTZfOrLK7AIGC/zOUgySnbH/0g21hmh4rbc9mH5lMz67M3rBOhJ1z++Qgclx4N9C
	5atRAYfqYxsIGBA0J+TY6UXjAmSCzgf5xPZ6Wu2vZqbYWsREhq/+LVRgNA2WiyTLtC58/8tQd3H
	fQUWVysVBb8LWDWesx40/JOBDXvwBsLiIl6JDtmRL0WynzDErVHn3hcyQhDZpsQjQlrZUkLt2Nt
	arooiRryh/iPCbv6hDVD6WjyRygci/aX2p2VnSGHOUIZuTxizTTDy+RnwP68moXMcgY5/t8AqZy
	7l0GohBy1xuhmkqmssA10ioVNucXs0/IJFnCaV+J4zMaLp9h8Pgik2LPyJKOcMcySX/bFLGHjPv
	fpCOQhEf1HeKbrn5SK5NJ+/AHdVB+JYeMhfd2lOuoHj1y0wtLdx0d3R3bI3sezGSUkEF8y1GoPN
	ldXS1TSTJGdx5Fiq/WGBd9Uv8OMteDGnHphlHc5qZmBNFSYlCSomsXATPTUr2FMXOnzpOh4CW4X
	cf9fKrOB12PokyBg9S463A+KKapk1pH7zqaOiehr/ImSimqMf+fEid/AKnoQVPOD2Kjh51eTWri
	decUo8tjFi7i8WYBNL6UqoGCn2Y8U4xybYjY7fs+LuU8EwEIXD4GhBn5H1IG7uSgG68=
X-Received: by 2002:a05:7300:8811:b0:386:d86d:d445 with SMTP id 5a478bee46e88-386d86dd49amr3135963eec.36.1795670303265;
        Wed, 25 Nov 2026 21:18:23 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm17282954eec.17.2026.11.25.21.18.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 21:18:22 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	bo liu <bo.liu@senarytech.com>,
	"qianghua.wang" <qianghua.wang@senarytech.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: sdw_utils: Drop rt_sdca_jack codec device reference on exit
Date: Thu, 26 Nov 2026 13:18:17 +0800
Message-ID: <rc-b1-20261110-vc-07a-7c635620fec1@gmail.com>
X-Mailer: git-send-email 2.50.1
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

asoc_sdw_rt_sdca_jack_init() takes a reference on the SoundWire codec
device with bus_find_device_by_name() and stores it in
ctx->headset_codec_dev, whatever the jack source quirk is. But
asoc_sdw_rt_sdca_jack_exit() returns early when SOC_SDW_JACK_JDSRC() is
zero, so then the reference is never dropped. One reference on the
codec device leaks each time the card fails to register (including
-EPROBE_DEFER) or the machine driver is removed, when the quirk has no
jack source (DMI quirk entries without one, or the quirk module
parameter).

The jack source check in the exit path is only needed because
rt_sdca_jack_add_codec_device_props() adds no software node when the
jack source is not set. Use it to skip device_remove_software_node()
only, and always drop the reference and clear the pointer, as
asoc_sdw_rt711_exit() does.

Fixes: 526a1876fc48 ("ASoC: Intel: sof_sdw_rt_sdca_jack_common: test SOF_JACK_JDSRC in _exit")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, COMPILE_TEST=y, SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=y, SND_SOC_SDW_UTILS=y; soc_sdw_rt_sdca_jack_common.o built before and after, no new warnings.
No hardware or runtime test was performed.
The path needs an rt_sdca jack codec and a quirk with no jack source; it runs on card registration failure (including -EPROBE_DEFER) and on machine driver removal.

 sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c b/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
index b4e427d55130..7902d423c8b9 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
@@ -188,10 +188,9 @@ int asoc_sdw_rt_sdca_jack_exit(struct snd_soc_card *card, struct snd_soc_dai_lin
 	if (!ctx->headset_codec_dev)
 		return 0;
 
-	if (!SOC_SDW_JACK_JDSRC(ctx->mc_quirk))
-		return 0;
+	if (SOC_SDW_JACK_JDSRC(ctx->mc_quirk))
+		device_remove_software_node(ctx->headset_codec_dev);
 
-	device_remove_software_node(ctx->headset_codec_dev);
 	put_device(ctx->headset_codec_dev);
 	ctx->headset_codec_dev = NULL;
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
