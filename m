Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFB3A960F;
	Thu, 30 Jul 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409110; cv=none; b=tXYMZcBiPYYUkNcn5jf9ZO02fXm0Lnsj9bZeUEZg2WePzfpvDbZ6K/mRwpoK5vcT8tc3qSpjWekckm3dCKxkN5oxDhgAoLgAIKoW4mFgRDtbKMbAomJpYc7/Qsh1mCcwe8qy8PuEMwDeQdzUUE3SpUnomCxtfrkZVGFXlPf+qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409110; c=relaxed/simple;
	bh=wUEcUXpCYlCJRNDgaYclYBMuu/5hFVfiEnB0KIEoees=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgznVVIAo8YbJulWVAFNg3Wryn70sKicmyw0miViwuHada3H0q879HJMBYOg+T49hO8Cp15T/6GO400M1QF8fQx2ScvZy/qU0lQAorFiiSCLlEXDJ2OVNkbUFU478Vd/xwc1152WuBDHEkC3oUj1LrdXRCfOjqugecsdxW2fv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQemJSRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQemJSRm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78B01C2BCB3;
	Thu, 30 Jul 2026 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785409110;
	bh=wUEcUXpCYlCJRNDgaYclYBMuu/5hFVfiEnB0KIEoees=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HQemJSRmFkDlE65/gyM2zjc0y7nJKU6jBCpfwWVwwQjQ58wyNRAyJReAfkOIKwwbJ
	 P8q8+MjsLMdBmBaYqBWx0jS2bVfHK96HmpNbmGXMugWrlgTZ1S8penMfMskBzoMJJY
	 qhf9s1FRZR2xoPMYbpg8wiyB4NYsCfkATYq/ZUqImRe8KZTsN1y1HhjvH/lFWqwnsC
	 dnvj4H1lPW6DiBK993N0esLlTUOcrXXe27+szZ3jXAIdDOApBeRQzWfOjQAuoniBKO
	 k/XAAfkYKo3sRpEYoHK+8Rber16kHEkaO3KuvMfCIBEtW/4qxeJkWGlHvM9SUJnDQd
	 /QQk1Qdt2tC3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A27AC55165;
	Thu, 30 Jul 2026 10:58:30 +0000 (UTC)
From: =?utf-8?q?Dawid_Wro=CC=81bel_via_B4_Relay?= <devnull+me.dawidwrobel.com@kernel.org>
Date: Thu, 30 Jul 2026 12:58:13 +0200
Subject: [PATCH v2 2/2] ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol
 accesses
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-worktree-lpass-tx-macro-enum-fix-v2-2-6d091c736116@dawidwrobel.com>
References: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com>
In-Reply-To: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Dawid_Wro=CC=81bel?= <me@dawidwrobel.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2792; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=8YiX6eyJpS5QlREPI4VEoPgAt7wgKMetE6Ezxh6uvYg=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWRl64WaP134tO167QqxVecjCxak3XeeZv5S2mXBMYZfq
 69etNAq7ChlYRDjYpAVU2TRSwvaYxX88vu7F7/DYeawMoEMYeDiFICJXL7G8L/u4MXLHN8X39uy
 Y/6yDZFS+5mbtCKdE8q+CMmsX9y4rUWIkeEix5Sfb5Ycnn7J9vC0SdM1D+q23XQ5LhM57c1tpmf
 l8p2cAA==
X-Developer-Key: i=me@dawidwrobel.com; a=openpgp;
 fpr=B64A778E0E64049A70C831C8B7B81FA12B282A92
X-Endpoint-Received: by B4 Relay for me@dawidwrobel.com/default with
 auth_id=901
X-Original-From: =?utf-8?q?Dawid_Wro=CC=81bel?= <me@dawidwrobel.com>
Reply-To: me@dawidwrobel.com

From: Dawid Wróbel <me@dawidwrobel.com>

EAR SPKR PA Gain" and the four "WSA RX* Mux" controls are enumerated,
but their get and put callbacks access the value through
ucontrol->value.integer.value[0] (a long) instead of
ucontrol->value.enumerated.item[0] (an unsigned int).

This same pattern was fixed in the sibling drivers by
commit bcfe5f76cc40 ("ASoC: codecs: rx-macro: fix accessing array
out of bounds for enum type") and
commit 0ea5eff7c606 ("ASoC: codecs: va-macro: fix accessing array
out of bounds for enum type"), but wsa-macro was missed.

On 64-bit kernels with CONFIG_SND_CTL_DEBUG this trips the elem value
sanity check and every read of these controls fails with -EINVAL.

Fixes: 809bcbcecebf ("ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro")
Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Assisted-by: Claude:claude-fable-5
Cc: stable@vger.kernel.org
Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
---
 sound/soc/codecs/lpass-wsa-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 5ad0448af649..af521e0988db 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2064,7 +2064,7 @@ static int wsa_macro_ear_spkr_pa_gain_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = wsa->ear_spkr_gain;
+	ucontrol->value.enumerated.item[0] = wsa->ear_spkr_gain;
 
 	return 0;
 }
@@ -2075,7 +2075,7 @@ static int wsa_macro_ear_spkr_pa_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	wsa->ear_spkr_gain =  ucontrol->value.integer.value[0];
+	wsa->ear_spkr_gain =  ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -2088,7 +2088,7 @@ static int wsa_macro_rx_mux_get(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			wsa->rx_port_value[widget->shift];
 	return 0;
 }
@@ -2101,7 +2101,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 bit_input;
 	u32 aif_rst;
 	unsigned int dai_id;

-- 
2.55.0


