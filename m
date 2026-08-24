Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7C3812EF
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608536; cv=none; b=PXG7yatdI1R5Re5+sIEXNkY4NnnTgGSKxQbFjc3zLDNZXp98SEpo4MprrYql6Y52J1+HzP0gEcQSg5/lxyDncWKOw8eOwFIpPmB6o5LwrgjU2qdSJttmgXcaAdne/Pg33O8rZQan6gVXISmrX7/GsI6wvMzw2WfNEA2LS2XQac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608536; c=relaxed/simple;
	bh=tbfxa1MbLOvcoVXdTdzy2Tg440BspMHTfhS0DtzVp0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2QO7EwLeP3JuKxdRFDNFXnccPb+tB2VHFdBMUJ6MmkP41fIMeQ/Z9fcqYFI6kDmZyNC2NdD5JajAqr30IekvcllyTZLNByGNF00hKi2z3qAZ0GKJbNtk51C2BrJSUruIR7Eo1YJMZbj2ZP6kAqxey6i3frbyf8fFf476cSijos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW9OST6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW9OST6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580671F000E9;
	Mon, 24 Aug 2026 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608534;
	bh=eoK+j8LnT2CqJwCF1q7J61/rxtioAbnf3JYjVZ8uxtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XW9OST6F0RQ4TbzyzWEnp+8F3EWABd2upY6dDOLs/Z8Kr7a1bu4YMzfHzT+GOB99s
	 l4pXh9hsokmlranexyP8T1KQIYRVojTNO2OkwH0aycwuRdesWAvZ6+b4jiyfsKlZPU
	 dza36EViaNMsZP5A2rzChXSfoh4dX9g7AZ/KkKqBxxsZhzypxsg4krA7xJXeqxp0wB
	 EsZQFTzce9S2eqqK65MUSKoAjYWxhusi+blKVl6tlKVz/T3nX/UUvzfPXFWucEWFwb
	 F6GPHhR94PxfbdsC/luA+agiiur4GMAjp5eqoroBCnzlvorBtvW/ZnP9OwsJmqXtRn
	 cRUChJ/9IROnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Dawid=20Wro=CC=81bel?= <me@dawidwrobel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
Date: Mon, 24 Aug 2026 17:55:32 -0400
Message-ID: <20260824215532.431365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082033-cardigan-abide-dec1@gregkh>
References: <2026082033-cardigan-abide-dec1@gregkh>
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
index ae1a3be268372..e28d7274fb0b4 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1076,7 +1076,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1085,7 +1085,7 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
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

