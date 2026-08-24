Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77F23EAB3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608827; cv=none; b=vBD4T98qubb78P49O9vliaZH2L8Ut1ApWl2KAOtzElcij7zQsvWGaG/e9zguqLMTS7yz+Arybom9iYQtkYlBMzrEPvtEXGfGSC+6nNMxTuGSdXcKidu0Zv0k+rAwt/Dg1V/yijDbtOcays3GIVZ2CU1VUFzx1/aPqCb6+QeFMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608827; c=relaxed/simple;
	bh=r9dfZQfmkbmIoqkC9G4kTvE8y34Z/3Kwek8LEoScRAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDd5Uh+Iywywn7aqlhljN3JlFQ3ts254OvmuDEY72oHoIUYJDhLahK/7mF79vLL0seNJ6BjQB0BWzKsQgYPQHqJVwmSnAZ2arPPGGbsKqDt5duQnhEo43d5jD2jY7zsGkZ0a+v6bvFmBrZpjvM4VogkTs/JuBB1EFvbyLGs508U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvSYk2OX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvSYk2OX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189E41F00A3E;
	Mon, 24 Aug 2026 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608826;
	bh=9+d+Okn2MfJYMQcoDuByIXIVhqv1n6lMPoCOv0a43ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KvSYk2OX45RgffziRmOQNWVXtNP1iFqlofdVDxhFVmRtSNFPvsE1BXSYATNfJzHNe
	 sdl74keKNrnoDbZvSuH+5sQDfKnfx641jbJNwB38gBCSxDcyjPittZ6sInTnmRmD75
	 5AIHmg7PDv1DUvEuraCw6zQCA3NiT2dlB7Dj5zhjFxUJ0y+DBvo8lzFF5E3/Vyr68m
	 E8/yv2l7EzXX3f2nLWWlBTDrWjy6BPEaGuJfwQjU3s5FpvWuAkMydro8xHKQ1RBkWe
	 iGQ9LRqNv5+PhN4gds0gRHcTHoiVihK1zw2ssn5E9/MsEa3lD+s/T5lKv9e/0QKsLI
	 xojM19ubpGkWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Dawid=20Wro=CC=81bel?= <me@dawidwrobel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
Date: Mon, 24 Aug 2026 18:00:24 -0400
Message-ID: <20260824220024.436002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082033-conductor-script-8c45@gregkh>
References: <2026082033-conductor-script-8c45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dawid Wróbel <me@dawidwrobel.com>

[ Upstream commit 1ba381759e45d5d0442452cfa5c42e836191a568 ]

The "DEC0 MODE" to "DEC7 MODE" controls are enumerated, but
tx_macro_dec_mode_get() and tx_macro_dec_mode_put() access their
value through ucontrol->value.integer.value[0] (a long) instead of
ucontrol->value.enumerated.item[0] (an unsigned int).

This same pattern was fixed in the sibling drivers by
commit bcfe5f76cc40 ("ASoC: codecs: rx-macro: fix accessing array
out of bounds for enum type") and
commit 0ea5eff7c606 ("ASoC: codecs: va-macro: fix accessing array
out of bounds for enum type"), but tx-macro was missed.

On 64-bit kernels built with CONFIG_SND_CTL_DEBUG, the elem value
sanity check catches the 4 bytes written past the enumerated item
and every read of these controls fails with -EINVAL:

  snd-sm8250 sound: control 2:0:0:DEC0 MODE:0: access overflow

Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Assisted-by: Claude:claude-fable-5
Cc: stable@vger.kernel.org
Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260730-worktree-lpass-tx-macro-enum-fix-v2-1-6d091c736116@dawidwrobel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ kept `snd_soc_kcontrol_component()` context line instead of upstream's renamed `snd_kcontrol_chip()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 150ed10c8377a..4f40eace3a0ee 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1019,7 +1019,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1028,7 +1028,7 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
-- 
2.53.0

