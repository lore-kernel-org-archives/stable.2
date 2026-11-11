Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413483;
	b=Zarzhjx9OnecfdgmF/JgZOla0fYbU2gI1JrQ7D2H6XNjFuHyx5lsMxd/GcdVvjyhf+BS
	 3EUdp6gw1CgcQBHWqIrlpH5g8COcsZRv4rboUZvFiYqA6m28SFrskyuEfKW3psdk5QgFM
	 u38eDV0JaDCKyk+Cm4Nu/Sr7ucs1KNQfd6W6S6WVOtPz3hbrARSa7KfTizwF/ssqJAfMB
	 ZaoKjkOLi09hdeBo2ajC8GeejIMZK3AzBr0l2tVTPOSB2+Q2jtf53lX1c4NSpI9FO9XNN
	 +Q31Dya2iBJRnAPgGq0gBVoeItbkc8xtgqHMbGfnC5z3bRhKj6bgz9kF4AfRIQvl5rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xlvV0oJnpfp92jsdKnTXV6yDsmJaVlYE/Oh6GK8H2ns=;
	b=yQCTYkGQBu2ULKcW9DUgy0Qq7z1QM0ui4Fs+sU5COQrE+FIgb4bvPSLDVR86lC9C8vTu
	 lsbeAp5iM9eFera62+VdbOAvVTwiU1No+1du1jMhAnLYETLROm0fpwZbWOgBGAPR/C2OL
	 /VAmv15h51KCLt0gIMjL6PeJNS2RwmfP0XR1Jh2lbI/UgGG2af6ns+1H2zSgP6wpr5MfI
	 JvkM7PE34u0ovFfaGVgl3XmWXNn9Qy5ZVEA6oU3udfMzQAZ7dpWQp8EGBLpKyvCL9BQlj
	 JeWJO2wWNJ9Mf5M6rqvy4cb6kwn6emSy/aI7zZl2PJ/g6Mh4hGqwHMHEqOLQ7otPa3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8t2ib29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45513606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8t2ib29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519A11F00A05;
	Wed, 11 Nov 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413482;
	bh=xlvV0oJnpfp92jsdKnTXV6yDsmJaVlYE/Oh6GK8H2ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8t2ib29cmNPoaatgTIwWpD0sYq5nHm7KFe+UbmFh+qqBo9ve+WCKB6/D+0lpZ4Tx
	 SHiIZIEu4iDreN38fshS/pCr40Q1scT1bdk0l76sx8bijBq6syxcCKj4R1jbGE3yXU
	 aEOzcOQVTJylSA4AIFjRBPYeSHU3WDsrPFR636r69DNJKoPiesIlBg4SgiwiPD7s9c
	 LQLwUWBPZcQjgvbjj4gJUyG/pDsqEcQkUKfSruoWQkKIp+MSscyIog9PnP1nMNlodl
	 YQoyR2m7SlbWehwHhqvScJ4jFCEnXQ9BQxPF5voNUNr+mJo1uwI+d3u+Ir8p10pDo1
	 ugdcqXCwU4RNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
Date: Wed, 11 Nov 2026 11:11:20 -0500
Message-ID: <20261111161050.3106179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054318-failed-6.1-d4febca239be@kernel.org>
References: <20261107054318-failed-6.1-d4febca239be@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d4febca239be3c91498762dd0535a87d4af1eabc ]

A use-after-free can be triggered via SNDRV_CTL_IOCTL_ELEM_ADD when a
USB audio card is disconnected while an ELEM_ADD ioctl is in flight.

The reproducer parks the ioctl thread inside copy_from_user() using
userfaultfd, then tears down the USB device.  Unlike every other
ALSA control _user handler (ELEM_INFO, ELEM_READ, ELEM_WRITE, TLV_*),
snd_ctl_elem_add_user() never calls snd_power_ref_and_wait(), so the
parked thread holds no power reference.  snd_card_disconnect() therefore
cannot observe it via snd_power_sync_ref() and proceeds unimpeded:

  1. card->shutdown is set to 1
  2. device_del(&card->card_dev) drops the kobject reference on the
     parent USB interface device (card->dev = &intf->dev)
  3. The USB core drops its own reference and calls device_release(),
     freeing the struct usb_interface, including the embedded struct
     device that card->dev points to

When the userfaultfd is resolved and the thread resumes,
snd_ctl_elem_add() acquires controls_rwsem without checking
card->shutdown and calls __snd_ctl_add_replace().  Because the
reproducer pre-registered the same control, the CTL_ADD_EXCLUSIVE
path calls dev_err(card->dev, ...) on the freed USB interface:

  KASAN: slab-use-after-free Read in __dev_printk

Add a card->shutdown guard immediately after acquiring controls_rwsem
in snd_ctl_elem_add().  At that point card->shutdown is guaranteed to
be stable: snd_card_disconnect() sets it before freeing the parent
device, and it never transitions back to 0.  A thread that acquired
the lock before disconnect sees shutdown=0 and holds the write lock
through the rest of the operation, preventing concurrent disconnect
from proceeding past its own controls_rwsem-less shutdown=1 store
(which happened earlier, outside the lock) from racing with dev_err().

Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260929125346.1478631-3-tiwai@suse.de
[ sashal: Adapted the error return to use err = -ENODEV and goto unlock for explicit semaphore release. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/control.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 9b739a515fdfa..6eece0d0afda2 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1723,6 +1723,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	alloc_size = compute_user_elem_size(private_size, count);
 
 	down_write(&card->controls_rwsem);
+	if (card->shutdown) {
+		err = -ENODEV;
+		goto unlock;
+	}
 	if (check_user_elem_overflow(card, alloc_size)) {
 		err = -ENOMEM;
 		goto unlock;
-- 
2.53.0

