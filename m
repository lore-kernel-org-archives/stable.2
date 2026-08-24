Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD23803C5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615041; cv=none; b=WlQUz60WBfl9EDh/HZ64jLJufdnjqsOGjvPuPOGmbxr0EPPlb9m3q0ERjYn1nsY9yHbuiCgp3RHV+ZOISNO/45Y3Lud3rjEPabDK98o/i7QSObK3TBiV3EDbykprK6WIEUVAYUr04o9SiHgpFhy37QFiCw2VQdfaERcel8wWMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615041; c=relaxed/simple;
	bh=OCMbUUoBG5vPYMqd1ch68Bv85BClXKAbQsrX0fm4IxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEN1FUhKm59DSzg5SkQPA5UJwglGGv9A/XTDi/eok/ZPEiREore58T7QhJDGjVSik3CHcp7tAJmNkSjXJfe3wIRxwXddw6A0+RH9BUDmIBdBvyIHhwNHhmR2D/LOloN+rDudubVyN3inWLZipGdeCUiFGRCrMzgtMcHnlzp7zoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWhnQ+i+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWhnQ+i+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2F21F000E9;
	Mon, 24 Aug 2026 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787615039;
	bh=ejHLEzcLg9VwHRKI3tyRFudpW+sopcThi4CFAaquutQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oWhnQ+i+QJX7S0T8gfr8WMSrQc3Md2QZutQS2x6j4Cky9o4P4C/v78voJ1aGZtiK8
	 8VKQnIMjvb0iwyY2Qsa7Qtolkhrk2/C4vmoiPskTSGLbxM0gRbW9izhb6ojW4KUfQK
	 FmjxfmwOxoaQICI8oqkijGtEGu70ePd2QsMgj9V64VbF94IAmSTXzagt4QeIf6DwWe
	 q/n/ckeiJMCK2h3B8xWjAhO8PRsRP1HRvfUvF6Cgry9mcAhbF48ihEDwSTeKvHRIOf
	 wQD9txEJK6C+yZfuAiBtwd0TQOzgqeUZ3oMpXC7UP4r/dOQaWXNqVO0SYwf3voJbL7
	 CaedNyBUrRSiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Dawid=20Wro=CC=81bel?= <me@dawidwrobel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
Date: Mon, 24 Aug 2026 19:43:57 -0400
Message-ID: <20260824234357.685026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082034-fragrance-goal-64e1@gregkh>
References: <2026082034-fragrance-goal-64e1@gregkh>
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
index 095c6dc564465..f32db1eda631d 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1013,7 +1013,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1022,7 +1022,7 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
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

