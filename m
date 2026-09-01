Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2A3A2549
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295224; cv=none; b=std5nxLGG7Kj/+Ncyv8z2QHI1t/Qb854oed9ZtmXHX2YAqdlt4PvQeBkkNm+T3wtOQwn9oz8GvDseDP2lG4h4rvHMpY6QMtbRAQu+n+8D4frGB9CNmo9JrwHSilHoylLNRZjtl7jAyzJBpZPSemIZbmIGRLqYhb5qGepYW4vu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295224; c=relaxed/simple;
	bh=5Bk2m2mZIxySqVeoUPpntthjXX2NumyVpEwoInP1OfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXCfCEwpGzlSm5CB/m7hN1OiHTevIBg74qmv5+5t7gMg/Q7uVoeaQ0hEyV4M8czGCJIy63xx3gsV6CyrjRAQMV3KQlGwOARA/OdGCCi/xdE+NEXVHj9Dz/rB+s6xPRvVwWAvwNkRTj3JKoi4gVHxjeexkDwhzEmG845CKeH7cT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLsbAirs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLsbAirs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B561F00A3A;
	Tue,  1 Sep 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788295222;
	bh=L+JvAB5fPAhhJCZ8Tur3Qaw4trfZHA3JIlTG6oepglE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLsbAirsQ88yVFG1RegPqh876zWCGGtmDik97hRxeURdg3iG2nvQqBKu2m0tiSAuR
	 g8lG/HEqsNE09FDA5A7kkrvWx3TTCDfB2T+y1FgCgFl3ZH1o5KHwNSRIFDeOS+yvI9
	 l8gcGX8GNS/DFhPaWbzJ7Xe2GfarA73u1oYCljEkx+3qFeoMEZs9NHLxofxEeESr3q
	 7hJoND8V0zmpJbtgvYa8nKcbEvVfCU6M95DHrQq7oFEapP5A8lWNoaC6jtfQRORIRs
	 93ofY45dt6pgCeTTe9/WQGpAe5h4ZXHST9DlH6eNX+/QDJDVa5buS4vp7hunQ4BH9Q
	 tpgZkZjvlva1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] ALSA: usb-audio: Avoid unnecessary or invalid connector selection at resume
Date: Tue,  1 Sep 2026 16:40:16 -0400
Message-ID: <20260901204018.1548593-3-sashal@kernel.org>
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

[ Upstream commit 8dde723fcde4479f256441da03793e37181d9f21 ]

The recent fix for the resume on Lenovo machines seems causing a
regression on others.  It's because the change always triggers the
connector selection no matter which widget node type is.

This patch addresses the regression by setting the resume callback
selectively only for the connector widget.

Fixes: 44609fc01f28 ("ALSA: usb-audio: Check connector value on resume")
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213897
Link: https://lore.kernel.org/r/20210729185126.24432-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 1739a976312e ("ALSA: usb-audio: Complete cleanup after system-resume errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 918f6980de3d7..7b860380ec7a3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1824,6 +1824,15 @@ static void get_connector_control_name(struct usb_mixer_interface *mixer,
 		strlcat(name, " - Output Jack", name_size);
 }
 
+/* get connector value to "wake up" the USB audio */
+static int connector_mixer_resume(struct usb_mixer_elem_list *list)
+{
+	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
+
+	get_connector_value(cval, NULL, NULL);
+	return 0;
+}
+
 /* Build a mixer control for a UAC connector control (jack-detect) */
 static void build_connector_control(struct usb_mixer_interface *mixer,
 				    const struct usbmix_name_map *imap,
@@ -1841,6 +1850,10 @@ static void build_connector_control(struct usb_mixer_interface *mixer,
 	if (!cval)
 		return;
 	snd_usb_mixer_elem_init_std(&cval->head, mixer, term->id);
+
+	/* set up a specific resume callback */
+	cval->head.resume = connector_mixer_resume;
+
 	/*
 	 * UAC2: The first byte from reading the UAC2_TE_CONNECTOR control returns the
 	 * number of channels connected.
@@ -3719,23 +3732,15 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
-static int default_mixer_resume(struct usb_mixer_elem_list *list)
-{
-	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
-
-	/* get connector value to "wake up" the USB audio */
-	if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
-		get_connector_value(cval, NULL, NULL);
-
-	return 0;
-}
-
 static int default_mixer_reset_resume(struct usb_mixer_elem_list *list)
 {
-	int err = default_mixer_resume(list);
+	int err;
 
-	if (err < 0)
-		return err;
+	if (list->resume) {
+		err = list->resume(list);
+		if (err < 0)
+			return err;
+	}
 	return restore_mixer_value(list);
 }
 
@@ -3774,7 +3779,7 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = default_mixer_resume;
+	list->resume = NULL;
 	list->reset_resume = default_mixer_reset_resume;
 #endif
 }
-- 
2.53.0

