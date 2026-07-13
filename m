Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C584189D9
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948329; cv=none; b=Fq+3p5gMer9SpQqyUt47AQT3CtT+DislOlWz3QauU5bXSftaTVNFii47NR8cJfKxen4+TBYva+DEniTBGZf+BLsj+LnKBhMQ8dIXlvwuobiCwfACPpgv4TOGlY6MohnWtfD/0hHtRgkHQX3PNVBWFjKXiaQZb97E/hcGPRm0k04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948329; c=relaxed/simple;
	bh=rFsqt5uEaLx3Ru5saqP6EgfRxrisDP9tdmtmML2SuGw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=arrGM+yqDTO3spY4Wd1PtTbAOEBm5tQ6QV/p6mW2IvdQZLVFstGaMahihj4+/ch6D2hf8nxi1MCkkDGcNXw9EJ0DgcxayrPFRdG7m4cs/PLbaCRosw2H4xw/6ggk6ynPh8+Ki2Ui9pbS/x2kzGN21uJ4TnLJPxH1ITjJtzJlw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XJUItoB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XJUItoB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3401F000E9;
	Mon, 13 Jul 2026 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948328;
	bh=FkNVtA1fojUeNwfvU5XizFj5f7eJ0/IgT1CF8O0BxrU=;
	h=Subject:To:Cc:From:Date;
	b=XJUItoB5aqkLWd0mG3eaBiswyUnnqgQLt6GDgnd6sY+wHx6n+6GsWM5AOrMUDN990
	 Qb+jAtMTj6geqekViDXddMkPKrGODRUtcDjuEOKbxjx6QVdVlT5V1oFbGGa5+thSwR
	 B0wjM3jB93PCgrTfGF1F5YcNH8bmgMof2wIYV8KY=
Subject: FAILED: patch "[PATCH] ALSA: aoa: check snd_ctl_new1() return value" failed to apply to 6.6-stable tree
To: zhaodongdong@kylinos.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:58:59 +0200
Message-ID: <2026071359-swung-cycle-429d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8df560fefe6fed6a20b7e06720eeaeccec349ac0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071359-swung-cycle-429d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8df560fefe6fed6a20b7e06720eeaeccec349ac0 Mon Sep 17 00:00:00 2001
From: Zhao Dongdong <zhaodongdong@kylinos.cn>
Date: Wed, 27 May 2026 20:09:14 +0800
Subject: [PATCH] ALSA: aoa: check snd_ctl_new1() return value

snd_ctl_new1() can return NULL when memory allocation fails. In
layout.c, the function does not check the return value before
dereferencing ctl->id.name or passing to aoa_snd_ctl_add(), which can
lead to a NULL pointer dereference.

Add NULL checks after snd_ctl_new1() calls and return early if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
Link: https://patch.msgid.link/tencent_35F3A25FEEBF190A2E15ED787754C57E3708@qq.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index c3ebb6de4789..7bb541577a26 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -948,6 +948,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (lineout == 1)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (!ctl)
+				return;
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 				strscpy(ctl->id.name, "Headphone Switch");
 			ldev->lineout_ctrl = ctl;
@@ -961,12 +963,16 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (ldev->have_lineout_detect) {
 				ctl = snd_ctl_new1(&lineout_detect_choice,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detect Autoswitch");
 				aoa_snd_ctl_add(ctl);
 				ctl = snd_ctl_new1(&lineout_detected,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detected");

