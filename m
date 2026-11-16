Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794860182;
	b=WgyUVv1EYrYmwx8X/0QAVRTuJJznYW+rdBVkslb6Hr07hQCtBL0zfdNmE0Zn/r484Gb0
	 CisEMIBbWWyEvIjOmakcdl+IiDgzf3qouWjV40Y6upCP4HaoCriQFT9GOYzEU6UVFEIwO
	 PLSRTJ+lcBUgQnjBHx5aQm9HM3TBucaANupZJ9dUYGZA8jdkLHWTo1vK2vZ0KBVaV0LrI
	 Y/Y3Ii/l0jpSqP1pxeRv5G4+s0vAyePKugbt0NGiNNA4TSO2I52eW6vZE6BUbkgp48QTd
	 x1Db+kGuHetjgZS5zBz284t6SnhxtHyv/BjjlkSUl7Evn1UZeeR3UgaiXpHGVBTtsYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860182;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nd2eb2QOUSPK2s+VnCW8v7afFssjFHHWVuJ7ySgyViU=;
	b=h/p8QkZ5BdYYitPu+ExP5zvSvt7y2jLZD09GrfsiJCPcLd17xc7qEzYzenh2ULC1Jrqi
	 vG8xSRd1cxUI2t6qxYhS1z0SSy5zDqMgpQ01oqJ8aZQLRXZCOZBpTqSlgQjsKa8+8fCeY
	 ye9ZINzIzZ+IYmuppJuJleZwM/oXCCli1UqF6zVOdB3+b6hsEYluf/tFnOUP3q2pJ3PFG
	 OrVkpisdQXDg3pWBjpGblmq5hNJYgl4FK34XRMHZwDvF6mhl1cF5lroUgy+/ia7q6r1Jc
	 kauP/ur6m4DTPEnIlml/MRE1JJPu5CPVxWe9XX8nBJAG+OG+gt7piFeb5T8dFmCsrig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+r1zyuA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8D606A322;
	Mon, 16 Nov 2026 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+r1zyuA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794860181;
	b=NVJMY2HMSfwkNs3NS27Rn1OwPDrkZRTQhAd11kNXDSxCNC6QT5M1fut0hkFnrV4oS4zo
	 RJlQQf8+8OZKyOAh3VrrLVhIj2VAvmhE6GxA4fsCvF+nbeOceAiHx0wxIPNRKr2BLjPXM
	 dcS57L/TUldX0xrM8Jubms2Ut5sl0go+851KNfqsOe+NIyPegq/AsgAA4UgZdVucO/37o
	 TabtdX4IAy/lNN3YUZlDpNLhd5O420n/QWVlME6W5Sool5GiS+DobViNmD6t3rycBKg4q
	 tJnAzXBwsu41QNfrg/euXSx5GpBfd0n23cXR3pCYSXv3x/7GonWU0e1vJqJUGF5SgIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860181;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nd2eb2QOUSPK2s+VnCW8v7afFssjFHHWVuJ7ySgyViU=;
	b=3LEd0NQKCevb7e+T8zzTOpQ4nkTOpR7GTNm+COL1xDVEAmRvHcB+akXpKd1Ttrd7rdMn
	 TjaeSAb7aWx2fOdhdtJ5OxIxMClpyDu/pqptSpvBdhCTLPwA/Zit+sNbrt7jb28aNsvmu
	 qTtKUMkqAoHfnq9u1Zf9G5CF1ORAbxpJBnUifoToygOMcX7hbfCEjXsmF9We1Iejua1O3
	 9zQwjBntFGFSmsEmL2o+2vUxYmt6AfnZdQPLA/rTdotZb8Q/0ukh2a6zFVvaKFI9jddA3
	 hdz2WvtSjKcAYMju7CDkxXhRESlase9zOmpegn/2dUlca6qS/bfoIIDxABs2nWSD2iQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 67A4D1F000C5;
	Mon, 16 Nov 2026 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794860181;
	bh=nd2eb2QOUSPK2s+VnCW8v7afFssjFHHWVuJ7ySgyViU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=c+r1zyuAg3zChCakS9eFLeH3EEESQI1N05a+o1HyEeW9ztyo60WwvqwRgzCyEKdoM
	 epLyQhAz0JTpLrnKrARL2FP0BVrNfDvUogzFwuUNheqEiKk8ThiaLMIfH4H+fo9MHz
	 C5njJFf9PULJqWASe0JPiYQD38qIDcghqbDwg1Ac4jwd8xGnH1EIBArAUvDIqfyIiR
	 1e7g9If3Lh5Hswq9H5I0+sdqbV1wfy3wBsMK7/E63bWO9cQrlJrBU7caG0eItv99T+
	 pSfWFOTGaYPLKtg8t7NHTfT3hdmkxOPWHQEUZFxENTKgVN0Il1oZHAALkgSCnIunzk
	 k1kYLsxOvn/rg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DF4FE4A5B5;
	Mon, 16 Nov 2026 20:16:20 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Date: Mon, 16 Nov 2026 20:16:20 +0000
Subject: [PATCH v2 1/2] ASoC: qcom: audioreach: use a 32-bit container for
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
Message-Id: <20261116-q6apm-fixes-v2-1-ea89fb43316a@proton.me>
References: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
In-Reply-To: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794860180; l=3033;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=Z5RD52GcSCFqyovob0M2rUs9F/Magv4CJIHWMKjM0rk=;
 b=yH2v4uHtdKhNILLqgB2qEtBUKD2UHQKGXvuuwc1Q/8gvPPVm7b/YSsf5+Cet6IKvcMZ323gp9
 rJeRMfSj3azCiJqQHVp1jjYSk/KrHrlqEsTbXBmLLXB60yFvI5JCx9Y
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
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Marc Herrero <marcht@proton.me>
---
 sound/soc/qcom/qdsp6/audioreach.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index d2dc5d37bccf..aa1f4e296764 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1216,7 +1216,12 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
 	media_cfg->interleaved = module->interleave_type;
 	media_cfg->num_channels = mcfg->num_channels;
 	media_cfg->q_factor = mcfg->bit_width - 1;
-	media_cfg->bits_per_sample = mcfg->bit_width;
+	/*
+	 * bit_width is the number of valid bits in a sample, bits_per_sample
+	 * the size of the container it is stored in. S24_LE keeps 24 valid
+	 * bits in a 32-bit container, so it is 24/32, not packed 24/24.
+	 */
+	media_cfg->bits_per_sample = mcfg->bit_width == 24 ? 32 : mcfg->bit_width;
 	/* Convert the physical mapping to a logical mapping of the channels */
 	for (i = 0, j = 0; i < AR_PCM_MAX_NUM_CHANNEL && j < mcfg->num_channels; i++) {
 		if (!mcfg->channel_map[i])
@@ -1308,7 +1313,8 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 		cfg->sample_rate = mcfg->sample_rate;
 		cfg->bit_width = mcfg->bit_width;
 		cfg->alignment = PCM_LSB_ALIGNED;
-		cfg->bits_per_sample = mcfg->bit_width;
+		/* S24_LE: 24 valid bits in a 32-bit container, see above */
+		cfg->bits_per_sample = mcfg->bit_width == 24 ? 32 : mcfg->bit_width;
 		cfg->q_factor = mcfg->bit_width - 1;
 		cfg->endianness = PCM_LITTLE_ENDIAN;
 		cfg->num_channels = mcfg->num_channels;

-- 
2.53.0


