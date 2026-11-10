Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320214;
	b=G8J5d3xU8rToWdT20L8YqaWiGguTTBd8OsLy56UA0F/qsOVhQ33MKK4XHXedIKirjARl
	 sYLMs+/1SEyjp+bl6Mxp6e5Oi7JfnkaKbtCcuVMXfVJXTUdwjmT6L+hu8+ja9Q9LE3ov6
	 8msPSn1xgajeh6ZP5sOiUK8FFp9FQTyc2qk1iR5nat0UXPN3MDIqXaIBmORQqd5VmHWE0
	 oojF86yQV/LZip8Ng4/+cLNAv7MKEa+R3rBMu4+zkS4r30Id8O9FAfiY1N+6DWn43LRf9
	 Susfr2anWJ/Zocpo50SdW7dDOfeRdGoHMZ8Ey5YeKGITJgQaco0Y0ARCJaz2yKop5RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7dGSXfbXUpYpDpS99EfKWMMwBLElHh4239/iMOsZbJk=;
	b=j/wJyb5Pit7xHnufwNcNjxABUXcA4RwURhOyBBFJY2U0GkUq2P+ZjRBgMiBbFBVwxx+4
	 l+b4p/0AImjGJiCZQ+K8qKs1wvqLbmSwWDH/dyKe7PzSbCz6Z7VNeqU/XGe3CONpi/me7
	 04fgbQYYnh6RGKzGUPE0q4XnQTwMpn7vSvTBpJhNLOkhusb4PH4GZVh1Uk1s/30+EU6W/
	 M5sPIu1M4nhNyrN1ikD9TvKtVoI1X3O2+vOFoRAVsaGfYJAvIju8jRsPjLn9uSpwRG5cW
	 nsYWGX5Z/3w9bfkIN934yM+RZBniWYXGQFd/xNx4UDmNAyA7W/zt0IFzFkhX8DDsq0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4GCzinu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E77606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4GCzinu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CF81F0089F;
	Tue, 10 Nov 2026 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320214;
	bh=7dGSXfbXUpYpDpS99EfKWMMwBLElHh4239/iMOsZbJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I4GCzinu1xZZwlHuC2RH3EJlrtCLPB1gAU9YzXXVOEb+Eq1V6a0hY9oxKJGo7fvO8
	 KKMk9sH7kmQNI33chxJ6Sj6+nY99y5FXm0d4UUoo1TivLutgQPweq0fU0oRloE6Ros
	 xFVn6oCgE/LSicYWU9+WKocyLoiCHksh0gwwPr16BkMjz2XmtvZDnJ6JSTXcjOTfAi
	 4uxnnIFybiusnfzQoHFg9JoIy58sAT9x9yX0U39w8s22PsKi0j4O8URGiBNMrsZSpf
	 MJ9bV9QpcJSe9X91EJno+QyDaBxWoIIN+MaEj41PWxW+jTD96JPDVlxxVVDnHPBJNe
	 IQi7czUMRmHFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] ALSA: control - introduce snd_ctl_notify_one() helper
Date: Tue, 10 Nov 2026 09:16:48 -0500
Message-ID: <20261110141408.1841234-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061731-failed-5.10-ad63c5b62843@kernel.org>
References: <20261107061731-failed-5.10-ad63c5b62843@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaroslav Kysela <perex@perex.cz>

[ Upstream commit 1fa4445f9adf19a3028ce0e8f375bac75214fc10 ]

This helper is required for the following generic LED mute
patch. The helper also simplifies some other functions.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20210317172945.842280-2-perex@perex.cz
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: ad63c5b62843 ("ALSA: core: Check shutdown flag at D0 power-state, too")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/control.h |  4 +--
 sound/core/control.c    | 68 +++++++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 41bd72ffd2322..46402a3109892 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -115,6 +115,7 @@ typedef int (*snd_kctl_ioctl_func_t) (struct snd_card * card,
 				      unsigned int cmd, unsigned long arg);
 
 void snd_ctl_notify(struct snd_card * card, unsigned int mask, struct snd_ctl_elem_id * id);
+void snd_ctl_notify_one(struct snd_card * card, unsigned int mask, struct snd_kcontrol * kctl, unsigned int ioff);
 
 struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new * kcontrolnew, void * private_data);
 void snd_ctl_free_one(struct snd_kcontrol * kcontrol);
@@ -123,8 +124,7 @@ int snd_ctl_remove(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol, bool add_on_replace);
 int snd_ctl_remove_id(struct snd_card * card, struct snd_ctl_elem_id *id);
 int snd_ctl_rename_id(struct snd_card * card, struct snd_ctl_elem_id *src_id, struct snd_ctl_elem_id *dst_id);
-int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
-			int active);
+int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id, int active);
 struct snd_kcontrol *snd_ctl_find_numid(struct snd_card * card, unsigned int numid);
 struct snd_kcontrol *snd_ctl_find_id(struct snd_card * card, struct snd_ctl_elem_id *id);
 
diff --git a/sound/core/control.c b/sound/core/control.c
index 640bafb6605a5..7b76518e862ec 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -182,6 +182,27 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 }
 EXPORT_SYMBOL(snd_ctl_notify);
 
+/**
+ * snd_ctl_notify_one - Send notification to user-space for a control change
+ * @card: the card to send notification
+ * @mask: the event mask, SNDRV_CTL_EVENT_*
+ * @kctl: the pointer with the control instance
+ * @ioff: the additional offset to the control index
+ *
+ * This function calls snd_ctl_notify() and does additional jobs
+ * like LED state changes.
+ */
+void snd_ctl_notify_one(struct snd_card *card, unsigned int mask,
+			struct snd_kcontrol *kctl, unsigned int ioff)
+{
+	struct snd_ctl_elem_id id = kctl->id;
+
+	id.index += ioff;
+	id.numid += ioff;
+	snd_ctl_notify(card, mask, &id);
+}
+EXPORT_SYMBOL(snd_ctl_notify_one);
+
 /**
  * snd_ctl_new - create a new control instance with some elements
  * @kctl: the pointer to store new control instance
@@ -343,7 +364,6 @@ static int __snd_ctl_add_replace(struct snd_card *card,
 {
 	struct snd_ctl_elem_id id;
 	unsigned int idx;
-	unsigned int count;
 	struct snd_kcontrol *old;
 	int err;
 
@@ -377,10 +397,8 @@ static int __snd_ctl_add_replace(struct snd_card *card,
 	kcontrol->id.numid = card->last_numid + 1;
 	card->last_numid += kcontrol->count;
 
-	id = kcontrol->id;
-	count = kcontrol->count;
-	for (idx = 0; idx < count; idx++, id.index++, id.numid++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
+	for (idx = 0; idx < kcontrol->count; idx++)
+		snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_ADD, kcontrol, idx);
 
 	return 0;
 }
@@ -463,16 +481,14 @@ EXPORT_SYMBOL(snd_ctl_replace);
  */
 int snd_ctl_remove(struct snd_card *card, struct snd_kcontrol *kcontrol)
 {
-	struct snd_ctl_elem_id id;
 	unsigned int idx;
 
 	if (snd_BUG_ON(!card || !kcontrol))
 		return -EINVAL;
 	list_del(&kcontrol->list);
 	card->controls_count -= kcontrol->count;
-	id = kcontrol->id;
-	for (idx = 0; idx < kcontrol->count; idx++, id.index++, id.numid++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_REMOVE, &id);
+	for (idx = 0; idx < kcontrol->count; idx++)
+		snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_REMOVE, kcontrol, idx);
 	snd_ctl_free_one(kcontrol);
 	return 0;
 }
@@ -585,11 +601,13 @@ int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
 		vd->access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
 	}
 	snd_ctl_build_ioff(id, kctl, index_offset);
-	ret = 1;
+	downgrade_write(&card->controls_rwsem);
+	snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_INFO, kctl, index_offset);
+	up_read(&card->controls_rwsem);
+	return 1;
+
  unlock:
 	up_write(&card->controls_rwsem);
-	if (ret > 0)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_ctl_activate_id);
@@ -1111,25 +1129,34 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	unsigned int index_offset;
 	int result;
 
+	down_write(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL)
+	if (kctl == NULL) {
+		up_write(&card->controls_rwsem);
 		return -ENOENT;
+	}
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
 	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) || kctl->put == NULL ||
 	    (file && vd->owner && vd->owner != file)) {
+		up_write(&card->controls_rwsem);
 		return -EPERM;
 	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
 	result = kctl->put(kctl, control);
-	if (result < 0)
+	if (result < 0) {
+		up_write(&card->controls_rwsem);
 		return result;
+	}
 
 	if (result > 0) {
-		struct snd_ctl_elem_id id = control->id;
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
+		downgrade_write(&card->controls_rwsem);
+		snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_VALUE, kctl, index_offset);
+		up_read(&card->controls_rwsem);
+	} else {
+		up_write(&card->controls_rwsem);
 	}
 
 	return 0;
@@ -1151,9 +1178,7 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 	if (result < 0)
 		goto error;
 
-	down_write(&card->controls_rwsem);
 	result = snd_ctl_elem_write(card, file, control);
-	up_write(&card->controls_rwsem);
 	if (result < 0)
 		goto error;
 
@@ -1302,7 +1327,6 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 {
 	struct user_element *ue = kctl->private_data;
 	unsigned int *container;
-	struct snd_ctl_elem_id id;
 	unsigned int mask = 0;
 	int i;
 	int change;
@@ -1334,10 +1358,8 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 	ue->tlv_data_size = size;
 
 	mask |= SNDRV_CTL_EVENT_MASK_TLV;
-	for (i = 0; i < kctl->count; ++i) {
-		snd_ctl_build_ioff(&id, kctl, i);
-		snd_ctl_notify(ue->card, mask, &id);
-	}
+	for (i = 0; i < kctl->count; ++i)
+		snd_ctl_notify_one(ue->card, mask, kctl, i);
 
 	return change;
 }
-- 
2.53.0

