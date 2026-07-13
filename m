Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53A4192FE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948340; cv=none; b=FnW2tR1U/BPo1hTo91cfMEMgq02eNRigPaon4WEI8iOYdoH7oQUbMIFW6lJqQqAxWJFnedxxV5iB9dGcsXLpXC0UazgisceGS2iS+343kwQrhqXiF2+xSHf2/rgvYx/GDMcfQ/82d9l+IVyEkMquPtlniPHNTCWLuGghlodkD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948340; c=relaxed/simple;
	bh=ByuePtdnBAmQG6znKMWCYJ/3wT1TvZV833EIWOaIhoc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H7X67CHBVZ/UwB8nLXSbrsl7NccOLRI1Asl8uJTfFDBuZ7464iZSuxPSQ6OBrouKSGmtU1lpk/9dwFbZQoj/lhvyfrQfMjDO0kIjurvX1YFxbeoWMbQrjNix8RBBKk/b9hETZBkMrumfS4owBcDWa0D/MdYy4dALpLcqvG9IWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K9Zw0gWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K9Zw0gWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F14B1F000E9;
	Mon, 13 Jul 2026 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948339;
	bh=+E2Vsh1LDgqdert0VXgEiUNXRf9s63ZPnOG+UI5K+08=;
	h=Subject:To:Cc:From:Date;
	b=K9Zw0gWp/ZKVz8GF6dzbYUNH9Kw+m1SC1QVB06Ct4iDbgevZu06/XVpaDYUh+EPBC
	 3fMsPB21JZxsgZYDItMzg7XN3cSb8EYfcRWl3v4sINBKYPCsVxIDYou8+WrWTtfpIU
	 pGTRNYMBIdb2rhn77+S1n+ZJCJouyPNAsMqNs0P4=
Subject: FAILED: patch "[PATCH] ALSA: aoa: check snd_ctl_new1() return value" failed to apply to 6.1-stable tree
To: zhaodongdong@kylinos.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:59:00 +0200
Message-ID: <2026071300-unstitch-evident-5dde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8df560fefe6fed6a20b7e06720eeaeccec349ac0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071300-unstitch-evident-5dde@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

