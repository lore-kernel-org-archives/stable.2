Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3F2EA75E
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608363; cv=none; b=i8lLTSJQ68cRPbOJrFi58J6WLCEcw5D9sAcY0Zc7zcJBK82LyhigIEkUKO2qX6PVTHd42wyFro8OuN77SYJ0YcUfQEbzsMxSkNZq8TdlSdxR6zyHmMo8mszyXT/euxLRqyjIZjqq/RPjQV5ieHddTuOta+XNMzEDvOsk04b06tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608363; c=relaxed/simple;
	bh=WWOVjaEsOe46DVclho86R/4sAuJiPaOHlp92XiZMY00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaSpxmNbDsAqXJ36f7Os/hiCKPJw83BQP/2vwjD9cbZvD5SViwgoMv1gk152D/BdZgW0x63qfAVA3yuyeW9CTlcUxz0uurUqH8LitLcRp+MTwhnuHToT5KlJPZ7vQ2iB62AOePJsaB3IhMcMOfA5Fe8D4eATyz1cQpJ8QGr+ZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhdD1CDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhdD1CDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A546A1F000E9;
	Mon, 24 Aug 2026 21:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608362;
	bh=5B0/TVuHEjYvTCvrEEd0eeTPEG0juzxIcvx1UF/FkmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AhdD1CDurkWkLJKpvK9Z40J9RP7MjEDewKDkyL0mVgUiOhjI0SgONiZJQDbpT8i9/
	 L69zady/I3swiDK7pjptCzKUGdhrTO0PfaBpJbBKPqkaWMLtJWcZXUZlk9UMTwF2PF
	 pnqJ9mSYaqXqdImhJG1/832+4ggF5sg1utffUpCiXgG+5wLx+ysTbKM52LCgL7nvsZ
	 juJ+ouhPrj8QUCEFC88trGxCDtIqsTWQZs9+FqkrGY62ZqGru7SwBKQKkImNizPzaz
	 AEw/q2EBTOi795uOHoKrd09x7NKffWC6BgCQiG51eTO7/CjmzCB8pAW2BO0hfB4Axz
	 cCyiD/R7QUw4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Dawid=20Wro=CC=81bel?= <me@dawidwrobel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
Date: Mon, 24 Aug 2026 17:52:40 -0400
Message-ID: <20260824215240.429752-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082032-chlorine-handful-d6b4@gregkh>
References: <2026082032-chlorine-handful-d6b4@gregkh>
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
index c7d4dc553e6aa..8cf8a9b687961 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1075,7 +1075,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1084,7 +1084,7 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
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

