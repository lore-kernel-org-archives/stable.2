Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274150;
	b=dkXkd56QpMo/1ITF1Z/iW4QNdSw9kqqoCIcpz64rYb0VePG15PMC8Zyw0JTstcWSgMYN
	 aisrhoSGyVDMqNZYuJ5CE6KsadDgtDheXdvZrV5TZe5AFCy6h8CATnx/UE7q/GQaaecdb
	 stailaoi1SZyiXXcrd/snwpaFEi5sSIFlbj7hWV0SOYo7Kq8jMudVQZrj//2Mt2J50Ffq
	 ddq7Pnrv5zuEblTEw2tRSE5tVUFC/2RbYVD42T9YCAAP8IjT3oL6hCuNxAHXjz13r8NdI
	 uty9EkXKyT8M7tcbzQwBBJ8gDanxwekw/ThtGUdMiAPOa1aK0HBRZoOhgIplUocSD5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274150;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3d7l2b+sPn55e9i8TFfLXbThZBPqdOZxqByt0nfM0Dc=;
	b=u3QxBA4YERLv6HdJs5BrRovCJlrJD0jXtbTnTnboZNY9pCgHTpXUGiOiTvzywd3b6Rod
	 LVaR6WEI+isWf8/vzNi1aDMrkcFfeDXEKtKD9771eTbf8qUuJPAb2UC7Y4CbErVQDzzXs
	 yOqUjeKnKxDR4qXLm1AN8JpOGZKZGTKo0gbyKhdkAx4UANTZUmnUSBpmNHO6+VFdZM92r
	 03aEeapvIlQLweY8PLagaHpOH2sJkiZr9Dkka1H8KAJ+RMuFRIEOmBbfR6n1Zf0jm0zuA
	 tCqmAVYlEv6+ndldcHp7VirTVbFNAvg98Tj94yVe0yfDQ3ExUBWHp8prxyd+1z91+Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dnz31CER;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03D606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dnz31CER
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8851F0089F;
	Tue, 10 Nov 2026 01:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274149;
	bh=3d7l2b+sPn55e9i8TFfLXbThZBPqdOZxqByt0nfM0Dc=;
	h=From:To:Cc:Subject:Date;
	b=Dnz31CERowmXSAcbHZNriBR74K4mg3P4aKV9j1HhV9r+GMV8gtPe1gAW8ikliv1tM
	 H1dmbLez3CCM19XFkYcaE/Xl6PT2tYaOW5TbDZWFd4yio4SBjOhkJinW1pCqgRIUmu
	 32C61VMqR2l9OTeLwfFVbVyIOAt0CCIOY76oquMs+DsTuB7cqcuzAuGrttf8x2HuPC
	 ij3Xg2liDS9q+sE0SEin6kwvISQeFtEKO3PUFHmGlG1fTbewFiiPPLwPuBNEK5zzCv
	 FgdmqiqVAsDNZ9zd70BfDcF4Sd6LFfOu7SjTdaNSvTa7XE+LNdy0r7J1TLVxs/PlVH
	 q3rE19siR/yrQ==
From: Sasha Levin <sashal@kernel.org>
To: 25031212351@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	wencheng@xidian.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: usx2y: Refuse a retried DSP load after a failure" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:29:07 -0500
Message-ID: <20261109202907-failed-5.10-1f8101b6adc8@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1f8101b6adc87a3ddbd51fcb6609251591758026
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202907-failed-5.10-1f8101b6adc8@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1f8101b6adc87a3ddbd51fcb6609251591758026 Mon Sep 17 00:00:00 2001
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Date: Sun, 1 Nov 2026 03:15:57 +0800
Subject: [PATCH] ALSA: usx2y: Refuse a retried DSP load after a failure

snd_usx2y_hwdep_dsp_load() sets up the asynchronous sequence URBs and
the interrupt URB when the FPGA firmware image with index 1 is loaded,
and then creates the ALSA devices.  If usx2y_in04_init() or
usx2y_create_alsa_devices() fails, the URBs that were already set up
are left in place.

The core keeps the index unloaded when the callback fails, so user
space may issue the same request again.  The second attempt then enters
usx2y_async_seq04_init() or usx2y_in04_init() with the URBs still
allocated and trips WARN_ON(usx2y->as04.buffer) or
WARN_ON(usx2y->in04_urb).

The URBs cannot be released at this point: the card may already have
registered PCM devices that user space can still open, and the
disconnect handler accesses the URBs without holding the DSP lock.
Mark the chip as hung instead, so that a retried request is refused
with -ENODEV and the assertions keep their meaning.  The URBs are
released by snd_usx2y_card_private_free() when the card is freed.

A failing usx2y_async_seq04_init() still releases its own URBs, so that
path remains retryable.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20261031191557.8460-1-25031212351@stu.xidian.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usX2Yhwdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 7f153a2fcdd81..3800c5b5887c8 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -179,6 +179,9 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 	int lret, err;
 	char *buf;
 
+	if (priv->chip_status & USX2Y_STAT_CHIP_HUP)
+		return -ENODEV;
+
 	buf = memdup_user(dsp->image, dsp->length);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
@@ -201,11 +204,13 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 		err = usx2y_in04_init(priv);
 		if (err) {
 			dev_err(&dev->dev, "usx2y_in04_init error\n");
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
 			return err;
 		}
 		err = usx2y_create_alsa_devices(hw->card);
 		if (err) {
 			dev_err(&dev->dev, "usx2y_create_alsa_devices error %i\n", err);
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
 			return err;
 		}
 		priv->chip_status |= USX2Y_STAT_CHIP_INIT;
-- 
2.53.0




