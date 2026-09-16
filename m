Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FC4D7943
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573751; cv=none; b=JzaTiP+wkcV61NULFit9/BiGq/c1xpsSYV97WkFmuAH7onlkn/7duhpzPQ6bCE2i6pOhxTPZ2EJAAv43YGEfoJjeE9GGkApNmfPSEvAXOeWYYokha3vmyOmiMGl9+QeefYMFYbSehmXLOLaKSwnWygxCUIIXpUR92GijO4fzCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573751; c=relaxed/simple;
	bh=TaUR6Z6fNAX2YTHoZsCehvSP2WL/6/0rBy5QjHZbuBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEVSwxVm0hYx97OxRZaW4S8+D9AABGgDb226uPD9DdTheSYk/vIyaaHQ7Z3szkeDQiqRqndmN+dP3kxk94jRmCu9MOs/urCSWETPWZN2VDcEppH+4fYVgftQUE/micbAywMw6lbTPTMCywOAqnrPBSfg86MrmfephecyYndW5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob4EtN/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob4EtN/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBA31F000FF;
	Wed, 16 Sep 2026 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573750;
	bh=LtMy3yqRJMTq84OGw0c6Ap5GVBliZ3xj+PI78UE3cbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ob4EtN/SpaBwS9GhFMnp4wTVKYX+NixHPiXiORL3q4/SvRIRLpsPrejxrk85iy+5Y
	 1t94iFJlw3b6+J3sKomiLCuGF3NFOaCYXHdYHgq8r7OvIT4KhbmfGUkRoSh/W/Eiq6
	 QHSiXAIr64boo2MNWrKew3JC0DPfR5zmKq9fac3qtGXsN4VUE24fTcSnZNBu0zvOGa
	 OqxVVRQhMsrn3/xVvHtvjlYCwiRyhfvu43+RxhRRwr5ONf0L6+g2TSju++B7j4Z+yJ
	 aIQUzjcGFiy+ujqqWDZnLMZzc9joFqj6UH4T373qsnFoX9rlaY2O/z6xMG62OK+U3m
	 wIyAX3uuczx3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ALSA: usx2y: Fix potential memory leaks
Date: Wed, 16 Sep 2026 11:49:07 -0400
Message-ID: <20260916154908.4167359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091636-ultimatum-procurer-683f@gregkh>
References: <2026091636-ultimatum-procurer-683f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 02d382af1c4e321acbea1c25b97ee13f52b9ac7d ]

Theoretically the initialization functions in usx2y drivers may be
called multiple times as the driver gets initialized via hwpdep
ioctl.  Meanwhile, those functions including memory allocations don't
check whether they are called twice, and they forget the old
resources, which would lead to memory leaks.

This patch adds the sanity checks about the doubly initializations to
give kernel WARNING, and returns an error in such a case.  Also, each
allocation assures to release the resources at its error path
properly.

Link: https://lore.kernel.org/r/20210517131545.27252-7-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 861111a14740 ("ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usbusx2y.c | 39 ++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index ac584795606c6..4d05f1997362d 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -150,6 +150,7 @@ MODULE_PARM_DESC(enable, "Enable "NAME_ALLCAPS".");
 static int snd_usx2y_card_used[SNDRV_CARDS];
 
 static void snd_usx2y_card_private_free(struct snd_card *card);
+static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
 
 #ifdef USX2Y_NRPACKS_VARIABLE
 int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
@@ -258,6 +259,9 @@ int usx2y_async_seq04_init(struct usx2ydev *usx2y)
 {
 	int	err = 0, i;
 
+	if (WARN_ON(usx2y->as04.buffer))
+		return -EBUSY;
+
 	usx2y->as04.buffer = kmalloc_array(URBS_ASYNC_SEQ,
 					   URB_DATA_LEN_ASYNC_SEQ, GFP_KERNEL);
 	if (!usx2y->as04.buffer) {
@@ -278,27 +282,47 @@ int usx2y_async_seq04_init(struct usx2ydev *usx2y)
 				break;
 		}
 	}
+	if (err)
+		usx2y_unlinkseq(&usx2y->as04);
 	return err;
 }
 
 int usx2y_in04_init(struct usx2ydev *usx2y)
 {
+	int err;
+
+	if (WARN_ON(usx2y->in04_urb))
+		return -EBUSY;
+
 	usx2y->in04_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!usx2y->in04_urb)
-		return -ENOMEM;
+	if (!usx2y->in04_urb) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	usx2y->in04_buf = kmalloc(21, GFP_KERNEL);
-	if (!usx2y->in04_buf)
-		return -ENOMEM;
+	if (!usx2y->in04_buf) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	init_waitqueue_head(&usx2y->in04_wait_queue);
 	usb_fill_int_urb(usx2y->in04_urb, usx2y->dev, usb_rcvintpipe(usx2y->dev, 0x4),
 			 usx2y->in04_buf, 21,
 			 i_usx2y_in04_int, usx2y,
 			 10);
-	if (usb_urb_ep_type_check(usx2y->in04_urb))
-		return -EINVAL;
+	if (usb_urb_ep_type_check(usx2y->in04_urb)) {
+		err = -EINVAL;
+		goto error;
+	}
 	return usb_submit_urb(usx2y->in04_urb, GFP_KERNEL);
+
+ error:
+	kfree(usx2y->in04_buf);
+	usb_free_urb(usx2y->in04_urb);
+	usx2y->in04_buf = NULL;
+	usx2y->in04_urb = NULL;
+	return err;
 }
 
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s)
@@ -306,11 +330,14 @@ static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s)
 	int	i;
 
 	for (i = 0; i < URBS_ASYNC_SEQ; ++i) {
+		if (!s->urb[i])
+			continue;
 		usb_kill_urb(s->urb[i]);
 		usb_free_urb(s->urb[i]);
 		s->urb[i] = NULL;
 	}
 	kfree(s->buffer);
+	s->buffer = NULL;
 }
 
 static const struct usb_device_id snd_usx2y_usb_id_table[] = {
-- 
2.53.0

