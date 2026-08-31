Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B464137A2
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182425; cv=none; b=E/6V5sf8IiJmMrl3WEx3vCHHsAFCwbRUNVQyrXvgsv5MCKjJcF4tf6RRwWTBUjbDKm8e0G+Iun9C1pVivd+5/xhgu+wpcdn9ROLMouazCCJQm9xtZvlfRpOasOFsFMjJr4j5E0ja2rjG403iRxbMXoPExyX/lsNCmlFKD3bx7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182425; c=relaxed/simple;
	bh=BtkzmEgbwsAs5bB2adCexGFVw7FNhbdHrGnB72UUHU4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iFl6IRWEIAuwAytM4+SOsEmxThwcqtCpoYjK6TXcznZ9sG7E42jG+/pKT1cMBAaejOzJvCyNdR81RgQ/FCA5TpaV8C9bTwg69LRH3u4Aij0NkZiI6OlwGmILZJLnPIztaR/60JzjnbhjsBxfO7YarspfSVLJhQzBKFEmWzgm2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H9C0zU0D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H9C0zU0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE69A1F000E9;
	Mon, 31 Aug 2026 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788182423;
	bh=ZiQIxHLJFFCkLKBFUYUIXH/DFpY0XNfRX2bzVmJFTEY=;
	h=Subject:To:Cc:From:Date;
	b=H9C0zU0D3hUqHjwj27gCzZc4YB/zUz14lSZyii/4XdZE8vXCIdQtzJg7Qk/yJlqss
	 Aq+PscUCWVfejs/e0vtn/k8aRZP0W65L3UBegwDH/WqPFHVj4evWG+5FcjxpcUQiWj
	 m282SrgKO35wpT2Q/p+M8sWRCRHlC9EgppzdEVU8=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Complete cleanup after system-resume errors" failed to apply to 5.10-stable tree
To: mrwillporter@gmail.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:20:19 +0200
Message-ID: <2026083119-straddle-squeegee-5817@gregkh>
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
git cherry-pick -x 1739a976312e110c93a8dee66a1cdf893a1b187e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083119-straddle-squeegee-5817@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1739a976312e110c93a8dee66a1cdf893a1b187e Mon Sep 17 00:00:00 2001
From: Will Porter <mrwillporter@gmail.com>
Date: Mon, 24 Aug 2026 17:57:57 -0500
Subject: [PATCH] ALSA: usb-audio: Complete cleanup after system-resume errors

A failed system resume can leave the card unusable until reboot.
usb_audio_resume() jumps to err_out when snd_usb_pcm_resume() or
snd_usb_mixer_resume() fails. The error path skips the out: block, which
restores D0 and decrements chip->num_suspended_intf.

The card stays in SNDRV_CTL_POWER_D3hot, so later control access blocks in
snd_power_ref_and_wait(). USB core logs an interface resume callback error.
It does not retry that callback, so a later callback cannot complete the
skipped cleanup.

usb_audio_suspend() increments num_suspended_intf before returning success.
A system-resume callback must consume the system-suspend count even if a
component resume fails. Otherwise, the stranded count skews later suspend
and resume cycles.

Do not apply this cleanup to runtime-resume errors. Runtime PM can retry
-EAGAIN or -EBUSY without another suspend callback. The count must continue
to describe that suspended interface. Other runtime-resume errors latch
runtime_error in the PM core and do not cause an immediate callback retry.

Both parts of the system-resume error path are longstanding. Commit
88a8516a2128a ("ALSA: usbaudio: implement USB autosuspend") introduced
err_out past the D0 restore. Commit 862b2509d157c ("ALSA: usb-audio: Fix
inconsistent card PM state after resume") later moved
num_suspended_intf-- into the out: block. The error path now skips both
operations.

No third-party code is needed to reach the error path.
snd_usb_mixer_resume() ends in snd_usb_mixer_activate(), which returns the
result of usb_submit_urb() for devices that have a mixer status URB. Its
mixer->private_resume hook can also fail through scarlett2_init_notify().
snd_usb_pcm_resume() issues a SET_CUR request to a UAC3 power domain. It
can return -EPIPE or -EIO when the device stalls the request.

Route a component error through out: only when system_suspend is nonzero.
Continue to return runtime-resume errors through err_out. Later component
resume stages remain skipped. The original error still reaches USB core.
A later transfer can fail if the device did not recover.

I reproduced the system-resume failure on an Audient iD14 MkI with an
out-of-tree diagnostic mixer resume hook. An injected -EIO on the unpatched
core left control readers in uninterruptible sleep in
snd_power_ref_and_wait() until a reboot. With this patch, the same failure
restored control access. A second system suspend and resume also succeeded
after I disabled fault injection.

Assisted-by: Claude:claude-opus-5
Assisted-by: Antigravity:gemini-3.1-pro-high
Assisted-by: Codex:gpt-5.6-sol
Fixes: 88a8516a2128a ("ALSA: usbaudio: implement USB autosuspend")
Fixes: 862b2509d157c ("ALSA: usb-audio: Fix inconsistent card PM state after resume")
Cc: <stable@vger.kernel.org>
Signed-off-by: Will Porter <mrwillporter@gmail.com>
Link: https://patch.msgid.link/20260824225757.26749-1-mrwillporter@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 24112e491779..9307da95efbe 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1282,8 +1282,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 
 	list_for_each_entry(as, &chip->pcm_list, list) {
 		err = snd_usb_pcm_resume(as);
-		if (err < 0)
-			goto err_out;
+		if (err < 0) {
+			if (!chip->system_suspend)
+				goto err_out;
+			goto out;
+		}
 	}
 
 	/*
@@ -1292,8 +1295,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 	 */
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
 		err = snd_usb_mixer_resume(mixer);
-		if (err < 0)
-			goto err_out;
+		if (err < 0) {
+			if (!chip->system_suspend)
+				goto err_out;
+			goto out;
+		}
 	}
 
 	list_for_each(p, &chip->midi_list) {

