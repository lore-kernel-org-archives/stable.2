Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3B4252AB
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295225; cv=none; b=c5qzYviulYeMg2BuJW34gngsAtJVCCGFulmq3OQoXBe8NWhrFn7vE0m4Q0PHxnWmkJ9Dfc+V9epPsFz+6Bq1Rfi0jYgjCh9S8IZbjXEtoz969gLIhyt0ZyxcXV6OoYTHfrGDuc0Qzr/wKoIrERbD2GiHTyh3ctAVsgF7Q4d7CmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295225; c=relaxed/simple;
	bh=TxzOsW6JrtjztjMtNEboeTCh+WJFlFkS00UA/2MABrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGYOqR6O9OKx+R1ckDuN+lpsjVRneeaIAc9GNMRmd50UKY5f5nr+ynNOQ9LNXODeqsKxFIGLBNgCT4Vcfnju0mSHO4nup210Wu9kVQ0d8M3mnn3gRAV8BdRdZDP9ecmYYGMtJNg3WGc9coQL5u+c5YiAcrJIwDbauNZRW+p1sAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f48kbGvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f48kbGvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79861F00A3F;
	Tue,  1 Sep 2026 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788295223;
	bh=U6ss4WMoY3T0G9g0RDXjhcorQylz4y2NcYwzEaSSqgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f48kbGvk4dbYqJ8IL2ssUAcosKtuNFPlJnnCB8NIp60rHcJanQ10CiSTJiwkF7Frt
	 WTXGGwJXS7lsWEcN9o0KlSlKLi/Fx2hmkFZE9Y/sJ28ZXooykJrKJRW/tm6kPaY/l6
	 PfoIdXoRQImjy/4bXMl2RrDdIABge7bwZu2CgTRo3jNaAEXp1JOYO1O6oy9MJR+VbE
	 h9Sj+V68mO24bsNjHAnYmhWup47fPkigCEHotoNLOzcAdW7IY//5ZzUNPdz6xSjgZW
	 SzfcerFlQsDNTXnxCugouCaGOC5kh0jq2sNvM/OsfQFovJ+uF9VVLgxzWgu9f5dO31
	 OPMpQKYIbexQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	En-Shuo Hsu <enshuo@chromium.org>,
	Yu-Hsuan Hsu <yuhsuan@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] ALSA: usb-audio: Unify mixer resume and reset_resume procedure
Date: Tue,  1 Sep 2026 16:40:17 -0400
Message-ID: <20260901204018.1548593-4-sashal@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7b9cf9036609428e845dc300aec13822ba2c4ab3 ]

USB-audio driver assumes that the normal resume would preserve the
device configuration while reset_resume wouldn't, and tries to restore
the mixer elements only at reset_resume callback.  However, this seems
too naive, and some devices do behave differently, resetting the
volume at the normal resume; this resulted in the inconsistent volume
that surprised users.

This patch changes the mixer resume code to handle both the normal and
reset resume in the same way, always restoring the original mixer
element values.  This allows us to unify the both callbacks as well as
dropping the no longer used reset_resume field, which ends up with a
good code reduction.

A slight behavior change by this patch is that now we assign
restore_mixer_value() as the default resume callback, and the function
is no longer called at reset-resume when the resume callback is
overridden by the quirk function.  That is, if needed, the quirk
resume function would have to handle similarly as
restore_mixer_value() by itself.

Reported-by: En-Shuo Hsu <enshuo@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Link: https://lore.kernel.org/r/CADDZ45UPsbpAAqP6=ZkTT8BE-yLii4Y7xSDnjK550G2DhQsMew@mail.gmail.com
Link: https://lore.kernel.org/r/20210910105155.12862-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 1739a976312e ("ALSA: usb-audio: Complete cleanup after system-resume errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.c         | 18 ++++--------------
 sound/usb/mixer.c        | 26 ++++----------------------
 sound/usb/mixer.h        |  3 +--
 sound/usb/mixer_quirks.c |  2 +-
 4 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 476694ffc393d..293a3e9f586ce 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1030,7 +1030,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
-static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
+static int usb_audio_resume(struct usb_interface *intf)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct snd_usb_stream *as;
@@ -1056,7 +1056,7 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 	 * we just notify and restart the mixers
 	 */
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		err = snd_usb_mixer_resume(mixer, reset_resume);
+		err = snd_usb_mixer_resume(mixer);
 		if (err < 0)
 			goto err_out;
 	}
@@ -1076,20 +1076,10 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 	atomic_dec(&chip->active); /* allow autopm after this point */
 	return err;
 }
-
-static int usb_audio_resume(struct usb_interface *intf)
-{
-	return __usb_audio_resume(intf, false);
-}
-
-static int usb_audio_reset_resume(struct usb_interface *intf)
-{
-	return __usb_audio_resume(intf, true);
-}
 #else
 #define usb_audio_suspend	NULL
 #define usb_audio_resume	NULL
-#define usb_audio_reset_resume	NULL
+#define usb_audio_resume	NULL
 #endif		/* CONFIG_PM */
 
 static const struct usb_device_id usb_audio_ids [] = {
@@ -1111,7 +1101,7 @@ static struct usb_driver usb_audio_driver = {
 	.disconnect =	usb_audio_disconnect,
 	.suspend =	usb_audio_suspend,
 	.resume =	usb_audio_resume,
-	.reset_resume =	usb_audio_reset_resume,
+	.reset_resume =	usb_audio_resume,
 	.id_table =	usb_audio_ids,
 	.supports_autosuspend = 1,
 };
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7b860380ec7a3..9365f9f9430e2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3732,33 +3732,16 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
-static int default_mixer_reset_resume(struct usb_mixer_elem_list *list)
-{
-	int err;
-
-	if (list->resume) {
-		err = list->resume(list);
-		if (err < 0)
-			return err;
-	}
-	return restore_mixer_value(list);
-}
-
-int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer)
 {
 	struct usb_mixer_elem_list *list;
-	usb_mixer_elem_resume_func_t f;
 	int id, err;
 
 	/* restore cached mixer values */
 	for (id = 0; id < MAX_ID_ELEMS; id++) {
 		for_each_mixer_elem(list, mixer, id) {
-			if (reset_resume)
-				f = list->reset_resume;
-			else
-				f = list->resume;
-			if (f) {
-				err = f(list);
+			if (list->resume) {
+				err = list->resume(list);
 				if (err < 0)
 					return err;
 			}
@@ -3779,7 +3762,6 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = NULL;
-	list->reset_resume = default_mixer_reset_resume;
+	list->resume = restore_mixer_value;
 #endif
 }
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index ea41e7a1f7bf2..16567912b998e 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -70,7 +70,6 @@ struct usb_mixer_elem_list {
 	bool is_std_info;
 	usb_mixer_elem_dump_func_t dump;
 	usb_mixer_elem_resume_func_t resume;
-	usb_mixer_elem_resume_func_t reset_resume;
 };
 
 /* iterate over mixer element list of the given unit id */
@@ -122,7 +121,7 @@ int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 
 #ifdef CONFIG_PM
 int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer);
-int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume);
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer);
 #endif
 
 int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 24d2618c37896..f1012c1b99fb2 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -154,7 +154,7 @@ static int add_single_ctl_with_resume(struct usb_mixer_interface *mixer,
 		*listp = list;
 	list->mixer = mixer;
 	list->id = id;
-	list->reset_resume = resume;
+	list->resume = resume;
 	kctl = snd_ctl_new1(knew, list);
 	if (!kctl) {
 		kfree(list);
-- 
2.53.0

