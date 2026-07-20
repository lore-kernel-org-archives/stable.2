Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F83D5237
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540849; cv=none; b=o/ghYNZMiO5QJoq8eBp+mGL9Dr9GC8d8x67FP/k3zsUcySnzbTukWz975QTdXWmt4L2+zg+fH50zN60PmPyb+W62BQXlV3yeuHnicT/xQS5ZZCyFVJXH10XyRtlKUQ9L52f9+8mF91Rk9hp308R/mZVRTCAalloRhu6nf5YBdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540849; c=relaxed/simple;
	bh=Oanklt+vcc8VwzaZoCPYWdgGnMBuxhMiSzeZBTxhlTw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P5jCZmOzvIFd1T4D/mG+hSWUTns7vD0luCn9krtjX9U8XGapCmz73rnzG3dzxMKREBCBQ5tL/4HSMSKuybnFhM/oDPsFhngHS/yqd7vYgaHICqeORwTivBx5sC55uF0tKaA1PAj8oUeFkh3ckKH1NrfiLg2a6OzNBSV45K1bcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrbkKy+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrbkKy+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4F91F000E9;
	Mon, 20 Jul 2026 09:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784540847;
	bh=7hQRHwyekPSTTPzTY59wpHI53jfSY8+67rq9hrNvbCw=;
	h=Subject:To:Cc:From:Date;
	b=RrbkKy+VJJ1gZYXknKE7ZLm+8V82M1DsgXYkW7nHGWQmrNS3ZtFO0KFy6fvcZQ1eN
	 Xb16whirF9tJGjVFY4MWTEleIsChSAeSESYXN/jkQZVhzQCqRguofniCaDoLLuEECL
	 5o9l3Kl3gd0XceT9iseyudx816OI33LXg1nfbxWM=
Subject: FAILED: patch "[PATCH] ALSA: hda: Fix cached processing coefficient verbs" failed to apply to 6.12-stable tree
To: raoxu@uniontech.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:47:10 +0200
Message-ID: <2026072010-denial-election-d397@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f67be28fdf8b5d31ac1cc1152bb17250f9f8f513
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072010-denial-election-d397@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f67be28fdf8b5d31ac1cc1152bb17250f9f8f513 Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Tue, 7 Jul 2026 21:24:19 +0800
Subject: [PATCH] ALSA: hda: Fix cached processing coefficient verbs

Intel HD Audio defines Coefficient Index and Processing Coefficient as
separate audio widget controls in the Audio Widget Verb Definitions:
Coefficient Index selects the coefficient slot, while Processing
Coefficient accesses the value at the selected slot.

hda_reg_read_coef() selects the slot with AC_VERB_SET_COEF_INDEX, but
then uses AC_VERB_GET_COEF_INDEX for the value read.  That reads back the
selected index instead of the coefficient value.  hda_reg_write_coef()
has the same issue and builds the value write from AC_VERB_GET_COEF_INDEX
instead of AC_VERB_SET_PROC_COEF.

This only affects the regmap coefficient cache path used by codecs that
set codec->cache_coef.  Direct coefficient helpers already use the normal
SET_COEF_INDEX followed by GET_PROC_COEF or SET_PROC_COEF sequence, which
is likely why this has not been noticed widely.

Use AC_VERB_GET_PROC_COEF for cached coefficient reads and
AC_VERB_SET_PROC_COEF for cached coefficient writes.

Fixes: 40ba66a702b8 ("ALSA: hda - Add cache support for COEF read/write")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/DB9023BF2920BA99+20260707132419.1731342-1-raoxu@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/core/regmap.c b/sound/hda/core/regmap.c
index e7b866fc52c1..d6eb17aa9e08 100644
--- a/sound/hda/core/regmap.c
+++ b/sound/hda/core/regmap.c
@@ -214,7 +214,7 @@ static int hda_reg_read_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8);
+	verb = (reg & ~0xfffff) | (AC_VERB_GET_PROC_COEF << 8);
 	return snd_hdac_exec_verb(codec, verb, 0, val);
 }
 
@@ -232,7 +232,7 @@ static int hda_reg_write_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8) |
+	verb = (reg & ~0xfffff) | (AC_VERB_SET_PROC_COEF << 8) |
 		(val & 0xffff);
 	return snd_hdac_exec_verb(codec, verb, 0, NULL);
 }

