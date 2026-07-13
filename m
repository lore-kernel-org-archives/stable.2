Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005F36F8FE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948334; cv=none; b=ZyKDj6MtlqPU1oyXVWIwp527lEmmlYG2x6D/E0sLEgNeaTIbefdyO5q/mu+TUGS+2MgFk6V9W5EviY7k4sf3sF/i3NrVQztdHzKX5I89gKfPt6IsPagWYfOZcNKdNQo8SNXEWiGQuK0LbFeUiEgIA1cM2+wUbPTsnU0XiRmgtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948334; c=relaxed/simple;
	bh=WneZhRfSOd14XRhBv+05I6uVDHN6umnumeEoCjxDB04=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sl68VmVRd8cETJOPi52TDQP8RL4Y5XKpucxtOO0X2geTcpYvpLrLJJyN7Bp2NiaX1kB24C04PBQewEl9HLCnSUGQts+wWzFsh/reUgs2Unlny4MITuuBuc8J+esSh7obROZk83ateMSCYbRJeVG9EP7VkdIG7d8v/tHFAELHLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2q7ZYcIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2q7ZYcIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADC1F000E9;
	Mon, 13 Jul 2026 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948333;
	bh=oosyjs69N82kAYlMFGB72FjzkqzLjjGsf1nc3RoV8Mw=;
	h=Subject:To:Cc:From:Date;
	b=2q7ZYcIkfKrKPhhOwkbhsNaJG30g5cW6qksF8pynlA8aOS6SHLZDYdcfuiWqrnYBT
	 4FiOc2YkAFeuferst7jf0RpKnoLmMy2bfvYofm87uMJnI4kcocQ1AV4JTdy2lJ6UxN
	 X/E20d1YCWz1IFe2aROi6DMS1bQswVIN/sfUAQ3g=
Subject: FAILED: patch "[PATCH] ALSA: aoa: check snd_ctl_new1() return value" failed to apply to 5.15-stable tree
To: zhaodongdong@kylinos.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:59:00 +0200
Message-ID: <2026071300-ripping-haunt-9cde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8df560fefe6fed6a20b7e06720eeaeccec349ac0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071300-ripping-haunt-9cde@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

