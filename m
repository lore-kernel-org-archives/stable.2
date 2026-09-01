Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941C4252AB
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295223; cv=none; b=iYJAhy7A017aq3+gdZDONq+NUVF5tE2VVfEjczWFuon/OL0MWsPt4hclDMGoQLdsobFjGgNtVUFkOhghHxENy5QomSyUUkFFzdY4EKfaj5Wg67V1Fm7dZAjdZjazKt82VCIZgprCEl7mdu0H5sxUkeIQc87LGuOXkqaeR3qkZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295223; c=relaxed/simple;
	bh=+LknmKi2MteZ4SFHO3+of3GuUQXzfZnZw2lc6Q7P52E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKUhVxQ9DdY5ANLU+Gz84ktg7STNAVPbjJrFj5Es+FefQo6C+ZAPjGf5wGYIGKyBclv5l8wTvKAPWjVp5aVcHxZPBMHrvNxhqqSeGQgO5DnxD1f/Fh9dv43e9BAyLTYlt4RLUfovkRRHIfNGdmCwPavsfmIbPfPbk4dvLRxZiZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFBYw2pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFBYw2pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E7F1F000E9;
	Tue,  1 Sep 2026 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788295221;
	bh=CFT201BrQ7tYN3ebn8SWYmUaJUFeFzNqTQP7jSLHxB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZFBYw2ptieNCt13qjK337bGz916pgfvJIJhg5Hlbz/KjVbihWXRgOh25ZiXLlOo9n
	 nu9IpDPY4v+YliQ1E/+6X1xtBqJ/YpSVnC1MSSCWLxIlT4A8XsE8qnNDO1ii+T/AVe
	 lXtFQCcLFbKNNdFpAAJ7AG5gtC17WTVhfVBMI9AxjzOI11WcPNyZGhiyQQIzhsD1YQ
	 u80DN8kg4YIBUDHSGoalzXocLNs/oixaGzmsPgIgTSbY4vSrxc4CAe0x/ckAL4mb0S
	 g6SLMikU8CmCxpmONE7+8rijsd9fDuAMrWGhVwUqS+9XH9mSb2bjI66XQD6xx6AA2T
	 LP8BqbcvsqWwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] ALSA: usb-audio: Carve out connector value checking into a helper
Date: Tue,  1 Sep 2026 16:40:14 -0400
Message-ID: <20260901204018.1548593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083119-straddle-squeegee-5817@gregkh>
References: <2026083119-straddle-squeegee-5817@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 69644fca2716699cc6896aff51d37b1e886c94d2 ]

This is preparation for next patch, no functional change intended.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20210325165918.22593-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 1739a976312e ("ALSA: usb-audio: Complete cleanup after system-resume errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7f64199139d31..f1a20c196d849 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1454,13 +1454,11 @@ static int mixer_ctl_master_bool_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-/* get the connectors status and report it as boolean type */
-static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_value *ucontrol)
+static int get_connector_value(struct usb_mixer_elem_info *cval,
+			       char *name, int *val)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
 	struct snd_usb_audio *chip = cval->head.mixer->chip;
-	int idx = 0, validx, ret, val;
+	int idx = 0, validx, ret;
 
 	validx = cval->control << 8 | 0;
 
@@ -1475,21 +1473,24 @@ static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
 		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), UAC2_CS_CUR,
 				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				      validx, idx, &uac2_conn, sizeof(uac2_conn));
-		val = !!uac2_conn.bNrChannels;
+		if (val)
+			*val = !!uac2_conn.bNrChannels;
 	} else { /* UAC_VERSION_3 */
 		struct uac3_insertion_ctl_blk uac3_conn;
 
 		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), UAC2_CS_CUR,
 				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				      validx, idx, &uac3_conn, sizeof(uac3_conn));
-		val = !!uac3_conn.bmConInserted;
+		if (val)
+			*val = !!uac3_conn.bmConInserted;
 	}
 
 	snd_usb_unlock_shutdown(chip);
 
 	if (ret < 0) {
-		if (strstr(kcontrol->id.name, "Speaker")) {
-			ucontrol->value.integer.value[0] = 1;
+		if (name && strstr(name, "Speaker")) {
+			if (val)
+				*val = 1;
 			return 0;
 		}
 error:
@@ -1499,6 +1500,21 @@ static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
 		return filter_error(cval, ret);
 	}
 
+	return ret;
+}
+
+/* get the connectors status and report it as boolean type */
+static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	int ret, val;
+
+	ret = get_connector_value(cval, kcontrol->id.name, &val);
+
+	if (ret < 0)
+		return ret;
+
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
-- 
2.53.0

