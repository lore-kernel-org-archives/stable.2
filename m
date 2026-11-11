Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794394462;
	b=BkmxNxklSkR4VNeYzWE/xNU456n+4WXB+e3EDIbsFGm0EH6+hA4piGqKtN8aMdxw0Pwu
	 NZvT/wjmj1WSRO4PaJwUDjzU2h5Ojsgzeg4nthZr85vSVkcSbSextw2KqTErZg1IW6Dnc
	 Mx8qBcCnpIN7GkbaWUg2JMS695vCewTGRrXpQNegZHQtbrX5TEGmMIDgMwQWizfU4BzGp
	 fxkDf8FLsX2B4vzSvI+EKb0hZ9QKVopzmpPsy8D/+MGWE3gAIVOyALvRD/Y9c/R5WkZFU
	 vu190uZ+g4yMYGifmvn9l99pvkh5sZSQs4/NdJ/tf50NE+2L1ZnJ1KCHaCmPC5uRI7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394462;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OX7IpMmXUp0KPJ3z8EWnOu2drVlPXmpVczD5dg0rV7o=;
	b=1I9ggcDYljdgHpOCiuaS+4mDDVQVq8QM/51EF29+TFCDRIbqAhiAWyZhrRNxJ827yjfB
	 OOQ7fJjfl/tACjE4RscfVmjveV1iUXmvvFfMd4PtB1wXP+MWVJSkGAxkHiJOMyEoQ2OEW
	 ZcdFgA0DzfZvMSKRvKW1pT13USqdILWz5MwIX8rPo8h0NMMxzRiapDAagERWU+X+rayli
	 SEGNP6sXrf/WI3aGxAQU3kZAAB1w6SzsGUfTLCFQNYRp7BJMGMB6RZi/n1l02rqxjCPuA
	 YwuWcj7+TmVj74IsCcwt8Hvt65LAovjnPWLusNSU+I8+g7VxcTWJhgRm0gZxB1Zm3rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMbiL2mA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2D606A326;
	Wed, 11 Nov 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMbiL2mA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794394462;
	b=DoyfVsXmWR6rtb5DQe+rTEgzmQsgIvylVlJKyoKNUmiyTWrf0J74VVVK7AkggDUjtbe4
	 /tVBcYeoEBCvNH9pT7IcEYm9zQcjiVMB+rPoI9EkjJlavIifiVU6ZPOg6BssOhCPMfZwS
	 0uzKGu8BMC4XgduWYutgCNI9CWyb2Mt+4kult75eEslota1kQMBXQaiBZWGL7tmRNhPbV
	 rTVcDHVxBL4eRATgc811xGTjMZ7UlOvTVgkZiIQtp5kJjEoysP0H6DaWDA4o19PuBo9Xr
	 PMGvD+yYwowHP7cmRKhsbHbLnx9dmwGgCVcr7yeByqNnpbAAeRlylvJG0J5syihnhfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394462;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OX7IpMmXUp0KPJ3z8EWnOu2drVlPXmpVczD5dg0rV7o=;
	b=r4nMX4eNs8C7LZVRRXsDngv7kcAbyI7xDn2o09/BsefiPD/ZvuC7IhkrqWdJoQ4g+RIC
	 EpQw7KpEmK/1uRv80W14tHsxitQsq1AaJ8tH58RBUuhs53ivh5XxIvTNH4baiDmvo3iHF
	 SjL/d+yj1FKUk33+U1i4YpqonPP4iANoan9R1clvX8gVMHzjRqVEpkBQ+UJ2SF0PrnXsX
	 ghVZk7hZwcwXFIcsd7nUa7g44vSJrBpvzk+gs6WoZSDPsYUeD4xu1IEDakHDJ5w+BeUsY
	 pAFoGrtJBH0t1rBc1ArQAWK3HQjXUi0j3vbtt6w06IOklvF3XdozIQCVuUoMxSqz6EQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 906161F00A06;
	Wed, 11 Nov 2026 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394462;
	bh=OX7IpMmXUp0KPJ3z8EWnOu2drVlPXmpVczD5dg0rV7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PMbiL2mAFWk9Pr8RHLczrJSxI7iNEuwSwbHfIQ3usuytLL+Akms9Cd2K2TFukLRsk
	 tDqiUZ3AZmoHOKd1lYn2i/5+xSS7SYs8JdtZHPim/EEDpBURy+QKeRknPqmaPXqxN2
	 cIotzePBfW657gZHgsaRglr5NQLEe1j4FOpC/H1UJrerEG542r+MhYQbsdbhYVtQnD
	 aIaC4l6JdCvN2ihs68pCof41ZhKjVzC+Xb/laGmEVRLf7S+wsVmHiaLuWghvUTOU9P
	 yukECJ3n/mekx6AxptWYjduk3lGvYx+c538O36IACwKfwBGPDpw1RHyAsNqIz6K9JF
	 Ai0xGaxDzFM6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1B8C448F37;
	Wed, 11 Nov 2026 10:54:21 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Date: Wed, 11 Nov 2026 10:54:17 +0000
Subject: [PATCH 1/2] ASoC: qcom: audioreach: use a 32-bit container for
 S24_LE PCM
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-q6apm-fixes-v1-1-1beb5702b372@proton.me>
References: <20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me>
In-Reply-To: <20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794394460; l=2662;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=9fJzhmYUq3LyiOGxgqaMh+RyxTe6x0FH/AqCa9i1ZJM=;
 b=NtdgL1f71BjOhvSO6cGEs3Y0JCeTj7nkuY/GfIZ8t79gXECCYHSjzYDo0uZRZv7MAS9Tw2yc3
 9Lyi4UzXau6AZvA0ybFKjLsuIRUx4d8yHM9uan0px5Qi7g04YJJFc84
X-Developer-Key: i=marcht@proton.me; a=ed25519;
 pk=pIPy6L+INgiuJt7L7umVilPgpzy/Ni3QS77ToLj/H9c=
X-Endpoint-Received: by B4 Relay for marcht@proton.me/20261111 with
 auth_id=1490
X-Original-From: Marc Herrero <marcht@proton.me>
Reply-To: marcht@proton.me
Content-Transfer-Encoding: 7bit

From: Marc Herrero <marcht@proton.me>

SNDRV_PCM_FORMAT_S24_LE carries 24 valid bits in a 32-bit container, but
audioreach_shmem_set_media_format() and audioreach_pcm_set_media_format()
set bits_per_sample = bit_width = 24 in PARAM_ID_MEDIA_FORMAT and
PARAM_ID_PCM_OUTPUT_FORMAT_CFG, which tells the DSP that the samples are
packed 3-byte words.

q6apm-dai advertises S24_LE, so with a topology that allows it on a
playback front end the DSP walks the buffer with the wrong stride. On
QCS6490 (Radxa Dragon Q6A) this crashes the ADSP audio_process:

  PDM: service 'audio_process' crash: 'EX:audio_process:0x2:...'
  q6apm-lpass-dais ...: Failed to start APM port 113
  remoteproc remoteproc0: crash detected in adsp: type fatal error

Use the container size (32) for 24-bit data and keep bit_width = 24,
alignment = PCM_LSB_ALIGNED and q_factor = 23. With this change S24_LE
playback works on the headphone path (codec DMA RX -> LPASS RX macro ->
WCD9385), tested with the back end at S16_LE, S24_LE and S32_LE and at
48, 96 and 192 kHz.

The DSP then reads each 32-bit word as Q23, so S24_LE samples must be
sign-extended into the top byte, as alsa-lib's conversions do.

Fixes: 25ab80db6b13 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Herrero <marcht@proton.me>
---
 sound/soc/qcom/qdsp6/audioreach.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index d2dc5d37bccf..937506edf34a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1216,7 +1216,7 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
 	media_cfg->interleaved = module->interleave_type;
 	media_cfg->num_channels = mcfg->num_channels;
 	media_cfg->q_factor = mcfg->bit_width - 1;
-	media_cfg->bits_per_sample = mcfg->bit_width;
+	media_cfg->bits_per_sample = mcfg->bit_width == 24 ? 32 : mcfg->bit_width;
 	/* Convert the physical mapping to a logical mapping of the channels */
 	for (i = 0, j = 0; i < AR_PCM_MAX_NUM_CHANNEL && j < mcfg->num_channels; i++) {
 		if (!mcfg->channel_map[i])
@@ -1308,7 +1308,7 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 		cfg->sample_rate = mcfg->sample_rate;
 		cfg->bit_width = mcfg->bit_width;
 		cfg->alignment = PCM_LSB_ALIGNED;
-		cfg->bits_per_sample = mcfg->bit_width;
+		cfg->bits_per_sample = mcfg->bit_width == 24 ? 32 : mcfg->bit_width;
 		cfg->q_factor = mcfg->bit_width - 1;
 		cfg->endianness = PCM_LITTLE_ENDIAN;
 		cfg->num_channels = mcfg->num_channels;

-- 
2.53.0


