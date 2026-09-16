Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2B4A385B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550213; cv=none; b=efkHI5Fg1aKHkglaVGJWHkCam/zpOvM0yP/nk2PXnd+Gzoo1UW4WczcddzPBnOUzLJ0i+fRpxlby5Tr/wgsb0VpQ9j0k5/0Hcw4T08yUIypEALrhsTT6J4M8ktV9+RlZhiX80env0KoODQogd7xQLqqFLKj/lCjZ/nPXEWTnt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550213; c=relaxed/simple;
	bh=9RNM0EYktO40e+kgFeSoLXy7k2kM8AzmPVEqDMCM6lc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IZ1cV9wmp4vuA29GN5qtqFd5/uU3U+KNIDpXF2p4piBG89pNrSti8WiOZWT304y11rnJMob7s76fMDUBPwJjDST+ALk7CaJy4M+oy1C1w1HBQWZFtN1PIKzLCAEqYoq315qRKRNv1UO3s/3VsCV6vifRdhZ/UvJh+fb4PoTpS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TMiNk2DW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TMiNk2DW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3041F000FF;
	Wed, 16 Sep 2026 09:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550195;
	bh=SkuXjryvuqupBA3kdw7Z7uO34BcGr0+1pbKWA71JPLo=;
	h=Subject:To:Cc:From:Date;
	b=TMiNk2DW71lkmPnVOWFNFuc+m9kINifU3BLu9fQKCk5yGN0G0a14W1btLfQNl3bsb
	 YuljT6vYFEHSkAYaREFPEQiYYbm1SoKzl2iQN3GBMr8B3JTOsJCDvPQzIfMo1sv+ov
	 FbuX3guXlqvv9EZ5tUxAWOnr6s4bpfq42+Te8R5o=
Subject: FAILED: patch "[PATCH] ALSA: usbusx2y: fix in04_last array size mismatch with" failed to apply to 5.10-stable tree
To: tristan@talencesecurity.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:14:36 +0100
Message-ID: <2026091636-ultimatum-procurer-683f@gregkh>
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
git cherry-pick -x 861111a14740e12c36d363e9830f8daa734279c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091636-ultimatum-procurer-683f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 861111a14740e12c36d363e9830f8daa734279c9 Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Fri, 4 Sep 2026 20:58:25 +0000
Subject: [PATCH] ALSA: usbusx2y: fix in04_last array size mismatch with
 in04_buf

The in04_last array in struct usx2ydev is declared as char[24], but
in04_buf is allocated as sizeof(struct us428_ctls) which is 21 bytes.
In i_usx2y_in04_int(), when ctl_snapshot_last == -2 (initialization
path):

    memcpy(usx2y->in04_last, usx2y->in04_buf, sizeof(usx2y->in04_last));

This copies 24 bytes from a 21-byte slab allocation, reading 3 bytes
past the end of the source object.

Introduce a USX2Y_IN04_SIZE constant defined as sizeof(struct
us428_ctls) and use it consistently for the in04_last array, the
in04_buf allocation, the URB transfer length, and the comparison loop,
replacing the bare 24 and 21 literals throughout.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Link: https://patch.msgid.link/20260904205826.4071119-1-tristmd@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 4190227c5a2a..200b708aacd6 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -196,7 +196,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 			memcpy(usx2y->in04_last, usx2y->in04_buf, sizeof(usx2y->in04_last));
 			us428ctls->ctl_snapshot_last = -1;
 		} else {
-			for (i = 0; i < 21; i++) {
+			for (i = 0; i < USX2Y_IN04_SIZE; i++) {
 				if (usx2y->in04_last[i] != ((char *)usx2y->in04_buf)[i]) {
 					if (diff < 0)
 						diff = i;
@@ -305,7 +305,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(21, GFP_KERNEL);
+	usx2y->in04_buf = kmalloc(USX2Y_IN04_SIZE, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;
@@ -313,7 +313,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 
 	init_waitqueue_head(&usx2y->in04_wait_queue);
 	usb_fill_int_urb(usx2y->in04_urb, usx2y->dev, usb_rcvintpipe(usx2y->dev, 0x4),
-			 usx2y->in04_buf, 21,
+			 usx2y->in04_buf, USX2Y_IN04_SIZE,
 			 i_usx2y_in04_int, usx2y,
 			 10);
 	if (usb_urb_ep_type_check(usx2y->in04_urb)) {
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 6a76d04bf1c7..7b6deed17d4b 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -5,6 +5,8 @@
 #include "../midi.h"
 #include "usbus428ctldefs.h"
 
+#define USX2Y_IN04_SIZE	sizeof(struct us428_ctls)
+
 #define NRURBS	        2
 
 /* Default value used for nr of packs per urb.
@@ -55,7 +57,7 @@ struct usx2ydev {
 	int			stride;
 	struct urb		*in04_urb;
 	void			*in04_buf;
-	char			in04_last[24];
+	char			in04_last[USX2Y_IN04_SIZE];
 	unsigned int		in04_int_calls;
 	struct snd_usx2y_urb_seq	*us04;
 	wait_queue_head_t	in04_wait_queue;

