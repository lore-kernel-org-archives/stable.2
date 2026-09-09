Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78318468C2A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947218; cv=none; b=NVtWZLS+RvYmU0HXyTn92YDh5b/UG+81vKOXlLru7ZWpn5Mtf6AkVOPSN1f6FXIQWlReNZGMGy7S6NJx87gAQn4LfVWMjVetz733Pk2pTApJQ5DP69rv2AycJBXrl7/2Ky9R+FxQsK+WC8OswPAC2R0G43d1Q1ALi6xguH/gNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947218; c=relaxed/simple;
	bh=SID+DdiRaZmFGp1JAtcS/Kgpy3sBTqZqXmwbQ+bSrz8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G7aMgBBn80hJDLWplr6YaHjKfzCLFOMF8lNSwxAT9gnFNQwO5quL+TrOZhKoEu/Qq0S4QnFWOnnhjpYfjKRUU10F3nF/FFNH2MeXKZ0yaU9MaJAxSP+LJ8l854F3JM8aptoyKlL4yxn7iMw4BMtal8jp8eOSxxPl78L55lfI7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LMhF8ieH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LMhF8ieH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F79B1F00A3A;
	Wed,  9 Sep 2026 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947216;
	bh=yIyomHY+GaTvcU+1b4mOzZst4PsHTk+eN6T5ByCpYCE=;
	h=Subject:To:Cc:From:Date;
	b=LMhF8ieHWAMv7iTcOvWsaPiyOO7kGy/C39qzqXmm5bWac8aFFa/wcjzrllAh4y9vU
	 5gqdJrl2jVxS8kFvPOvMp0MHER0c1ma2gQ1pCoFLPaG8YzZHKfxgOXx3mfiG3U+x1V
	 uLIwFFtxvxWQyO3XeLzaQ3chIMSvx2JVrLeljmC8=
Subject: FAILED: patch "[PATCH] ALSA: harmony: initialize locks before requesting IRQ" failed to apply to 5.10-stable tree
To: runyu.xiao@seu.edu.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:42:15 +0200
Message-ID: <2026090915-crucial-humpback-b546@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 33abb7491e89285a41565670945293dda841afc4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090915-crucial-humpback-b546@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33abb7491e89285a41565670945293dda841afc4 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sun, 30 Aug 2026 14:34:11 +0800
Subject: [PATCH] ALSA: harmony: initialize locks before requesting IRQ

snd_harmony_create() registers the IRQ before initializing h->lock and
h->mixer_lock. A pending interrupt can invoke the handler while these
locks are uninitialized.

Initialize both locks before requesting the IRQ so the handler always
sees valid lock state.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260830063411.2215691-1-runyu.xiao@seu.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index fb40476c6c91..a9625aedf2a4 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -868,6 +868,9 @@ snd_harmony_create(struct snd_card *card,
 		goto free_and_ret;
 	}
 		
+	spin_lock_init(&h->mixer_lock);
+	spin_lock_init(&h->lock);
+
 	err = request_irq(padev->irq, snd_harmony_interrupt, 0,
 			  "harmony", h);
 	if (err) {
@@ -877,9 +880,6 @@ snd_harmony_create(struct snd_card *card,
 	}
 	h->irq = padev->irq;
 
-	spin_lock_init(&h->mixer_lock);
-	spin_lock_init(&h->lock);
-
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, h, &ops);
 	if (err < 0)
 		goto free_and_ret;

