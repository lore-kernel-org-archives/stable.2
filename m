Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD43286D4D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295224; cv=none; b=g3zEPY8lnQ5rml4knzlJP93N1JWRFA/iav5UiOiZ13MHars9ezMwop8qQrp9PZ1YLxOp6osERmhylXKUYNCICYiRqrss0gOSfSkTZQVfiSlqfKGNoMxnyWQt7EWviGx1kTEiT71uQ3nTyX0OJ0e8FznBfyreh76j0a52SoNwxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295224; c=relaxed/simple;
	bh=8D2o8wLgIUjtg8sd6jK9mGj/oPSIFp1XNJ5+QO4udvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mexyhlrocOVV/UMVWR7hELHVRcFMqc+l+QCp3cIXT30t2TdNfMA0OAVMIK7U5yc4bxY6oWZR+nyANGw8kPXM2+WlovSsgp6G2ov9jwmvnWsSP0Jxu4eSA8ChkgR1lXbpxpOR30DsQJBL80tdvLAoVzNgsjIvFciZifdQ5IyFtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imkLd96X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imkLd96X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6A71F00A3D;
	Tue,  1 Sep 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788295221;
	bh=Ng9ugze6O8CIVQgUXSaSIZgHXtoHtLwdsim4HNzc/bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=imkLd96Xkq0N4hofkp1WurRJH0rOes/qka1tHRXWiqk8U5UN0rcHY3R/7G6LqU0EA
	 r04o+PnZH3pMatob5EE05Rg7a2miqxh4CfyWslz5t0R6WXw1WAqFMkLqLih1J3Pd4l
	 3LavwH9PM2m+kP1kXStrXS1tkWQCu3HiZ45Gitm4RWq30h3o3i+BKnJfBcHn5EfHg2
	 MZPmZO9Fk7oDt+CJciRDm0sVbF6xUMUPHMdWaLosgvqfep4md8YJ/L1y44cFv3lblZ
	 A87V3fuxmu/ps2QYCnDd+ldjma80nct8fvl5SRI7LejnN3HHNEiX+2EIeAd5+aGlPt
	 a30pVUBf8Atgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] ALSA: usb-audio: Check connector value on resume
Date: Tue,  1 Sep 2026 16:40:15 -0400
Message-ID: <20260901204018.1548593-2-sashal@kernel.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 44609fc01f280d6b4067262ecbb00e3128d718ae ]

Rear Mic on Lenovo P620 cannot record after S3, despite that there's no
error and the other two functions of the USB audio, Line In and Line
Out, work just fine.

The mic starts to work again after running userspace app like "alsactl
store". Following the lead, the evidence shows that as soon as connector
status is queried, the mic can work again.

So also check connector value on resume to "wake up" the USB audio to
make it functional.

This can be device specific, however I think this generic approach may
benefit more than one device.

Now the resume callback checks connector, and a new callback,
reset_resume, to also restore switches and volumes.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20210325165918.22593-2-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 1739a976312e ("ALSA: usb-audio: Complete cleanup after system-resume errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c        | 44 +++++++++++++++++++++++++++++++---------
 sound/usb/mixer.h        |  1 +
 sound/usb/mixer_quirks.c |  2 +-
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index f1a20c196d849..918f6980de3d7 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3719,20 +3719,43 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
+static int default_mixer_resume(struct usb_mixer_elem_list *list)
+{
+	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
+
+	/* get connector value to "wake up" the USB audio */
+	if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
+		get_connector_value(cval, NULL, NULL);
+
+	return 0;
+}
+
+static int default_mixer_reset_resume(struct usb_mixer_elem_list *list)
+{
+	int err = default_mixer_resume(list);
+
+	if (err < 0)
+		return err;
+	return restore_mixer_value(list);
+}
+
 int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
 {
 	struct usb_mixer_elem_list *list;
+	usb_mixer_elem_resume_func_t f;
 	int id, err;
 
-	if (reset_resume) {
-		/* restore cached mixer values */
-		for (id = 0; id < MAX_ID_ELEMS; id++) {
-			for_each_mixer_elem(list, mixer, id) {
-				if (list->resume) {
-					err = list->resume(list);
-					if (err < 0)
-						return err;
-				}
+	/* restore cached mixer values */
+	for (id = 0; id < MAX_ID_ELEMS; id++) {
+		for_each_mixer_elem(list, mixer, id) {
+			if (reset_resume)
+				f = list->reset_resume;
+			else
+				f = list->resume;
+			if (f) {
+				err = f(list);
+				if (err < 0)
+					return err;
 			}
 		}
 	}
@@ -3751,6 +3774,7 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = restore_mixer_value;
+	list->resume = default_mixer_resume;
+	list->reset_resume = default_mixer_reset_resume;
 #endif
 }
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 6d20ba7ee88fd..ea41e7a1f7bf2 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -70,6 +70,7 @@ struct usb_mixer_elem_list {
 	bool is_std_info;
 	usb_mixer_elem_dump_func_t dump;
 	usb_mixer_elem_resume_func_t resume;
+	usb_mixer_elem_resume_func_t reset_resume;
 };
 
 /* iterate over mixer element list of the given unit id */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f1012c1b99fb2..24d2618c37896 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -154,7 +154,7 @@ static int add_single_ctl_with_resume(struct usb_mixer_interface *mixer,
 		*listp = list;
 	list->mixer = mixer;
 	list->id = id;
-	list->resume = resume;
+	list->reset_resume = resume;
 	kctl = snd_ctl_new1(knew, list);
 	if (!kctl) {
 		kfree(list);
-- 
2.53.0

