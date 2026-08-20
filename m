Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D413DB312
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222627; cv=none; b=fJiVz5eM0+YnH6yIO6lYUuNN5Ssk15vcNyMk5uXcR9yHh2TRn4LzLracSU+s53UZeX0BkK47jZGDZKfl5g+p1F9h0TpL1EdjMbm8eC2B87AogNagu2TadYujA4X2UKKnhgW6FZ2F9QzNItfM7ikurIE1IzDLQFQMoJIuMkF0Kw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222627; c=relaxed/simple;
	bh=QLoJ2H4/7t3t8NYWZdFllncmj4jeGoHjowYO7WGp1qs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r2+BA0kdh45dfckiozSKCixkHWa+a/Bu8U3zVqVj1sK1Sl2H4Z+5doYQ9yLxQYd4p8aXZgsbvtMuBnqRKTzE6XLRIhdxFdDhVC1VwlTvO9qn/A6k8Z2AUV7LpvffODy4MLq6l03ToNWqlRka7AgVUkUPprLfrQDp6tjKE9Ahihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yVftdIJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVftdIJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6C31F000E9;
	Thu, 20 Aug 2026 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222626;
	bh=GyY6zYxfW5O/Bk3IJtvaiY8G50cjl3Q/z7DO8ufo2Gw=;
	h=Subject:To:Cc:From:Date;
	b=yVftdIJboUFOhk9KTOT/VHiFpbmwF1HirjE+kewR8aEWtgmDShbClDADvxihrrM6o
	 dETeFoZszxZBVgcXfpp3hx2qB1g93cIfXrkZ7qMB5Iz5/c3cdDqdKhNzTxvIrn7USd
	 iY5/SZlv1+xAIoF9pfT/5aVn67TSQsLkMFNbAJbA=
Subject: FAILED: patch "[PATCH] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses" failed to apply to 6.6-stable tree
To: me@dawidwrobel.com,broonie@kernel.org,srinivas.kandagatla@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:43:33 +0200
Message-ID: <2026082033-conductor-script-8c45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1ba381759e45d5d0442452cfa5c42e836191a568
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082033-conductor-script-8c45@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ba381759e45d5d0442452cfa5c42e836191a568 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Dawid=20Wro=CC=81bel?= <me@dawidwrobel.com>
Date: Thu, 30 Jul 2026 12:58:12 +0200
Subject: [PATCH] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index f7d168f557dd..0cbf50647ff5 100644
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
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);

