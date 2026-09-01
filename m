Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD714A0F12
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295226; cv=none; b=qS3zyxdW8JuZ5uLZ0yG6wpqFDIBR4M64foEd04BBzPXuadoQBxzTBykDkYmG0t1s+g7k1P2sCBmrNV5+qdXdCVNGwQqDowaMPmfDKBnin0tkexZl86K5y66kI2q3R30XJVdSZvp3BCXgdFiAx/Zz2GNpIf1lv6dk27JPele50k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295226; c=relaxed/simple;
	bh=p2kk+CZ5aGM9fQghJzzgN87ekhcHROgBJcdAYUKeIJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7iUlPXRUBiyN9arRRpi90pW3/L4I6gbFn1Ooy8lTYrpCk96iW3cuDM/F4hcdzn+WKMeuTc43RMxNYOpHXmPhC/B3dRNnBYmdG3buLYG25NrFJgrsjGGwDt/WIzxFAWbGM0bcqXP8EuH6dbj5taUFumVImqHCY9tzHzuBC+h7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4k0YnKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4k0YnKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F221F00A3E;
	Tue,  1 Sep 2026 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788295224;
	bh=cCjq+q2qbON0ZQ00RfDl0ZzeSXsUs30aSYYwCXmvC4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4k0YnKq3nTZN04TjnBLQ7QDEO3DBqZIqIZ1HB4E3KcgQdWKgBoUDSkHqDENSwO0a
	 BqAFVWF5DF329asvIV+Sy+pfOLGdCZQ3feH+l7q4SUvesmjrRVIFR/PNbZueytMIvV
	 5V3qLxT7qpej5ADiXsH1vuyxcO1vT3V20x2GcR/mNe+M41WmEx23D7FFz0Wloxu4r8
	 8Dj1CKcq7Bcwlbpd1O/6vg5NqBAeIei59pimB6VRf0oQcp6lbyYCfeV8w8XhFBhUDD
	 umxvyyLrbUZHFn0rbEZbh0a+ZENPbHyRjz1LuivzU1pUO3KKGsDRQLfFpiVphDy5A/
	 Ij1wylG4kJqbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Will Porter <mrwillporter@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] ALSA: usb-audio: Complete cleanup after system-resume errors
Date: Tue,  1 Sep 2026 16:40:18 -0400
Message-ID: <20260901204018.1548593-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901204018.1548593-1-sashal@kernel.org>
References: <2026083119-straddle-squeegee-5817@gregkh>
 <20260901204018.1548593-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Will Porter <mrwillporter@gmail.com>

[ Upstream commit 1739a976312e110c93a8dee66a1cdf893a1b187e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 293a3e9f586ce..bd19f528ced18 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1047,8 +1047,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 
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
@@ -1057,8 +1060,11 @@ static int usb_audio_resume(struct usb_interface *intf)
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
-- 
2.53.0

