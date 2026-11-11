Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414134;
	b=5dptryFhXApwxQ+MXY7B1EHzcJzbWIGktJ3XIkEaGaNpqS9gyPj3M44CyZFxac+nRrWG
	 d+Y8T7QR1rPflkC6iAQqitZ1COcUHJdKY55wlPiIg+EU1dTw44IAqa3vR92fRCM7Tt0Mk
	 lZtoNZw1RAN7+XK+xyNMsCHMapIErypxEWsXpFNlx5AMe3AnoYvfGNl/0eYOvOarPJcwb
	 Lxz1XXLyxgK1aeC+qbRHFvOQ+bUw90oH5sK6BJimipgQEBGz4/nx8075bTVCiGwSkcRxa
	 5oWL+J6pqi+F/cHZgs4DSHkHHidmgBfbQyPGXXQ0TP4D0BPD0m0WiFQgX0WF8DhUqkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uc+XbsyDv1Lbk4nCqSnicF7bVtJ2iFuUUXg5zFQrTCk=;
	b=4gnGDhEI0s+RMSj6G1ehsakicJ3tpoOHBlU6JMl2X2ck/nDXLNCmuXAgmzt5m+6KHczP
	 R/nkQcm/yo9qsRcW+fG36DMHQcYdEXYPZp0JfjFpFsGn60zLutueuY6j5L3APoRSEabZ4
	 pyHkpvYWfguHKmuk9NB4VV/Lx2MKekoW2hO1IRHtiK1wiqjFQFr5GPdtWqvzDzhfR21Vf
	 3PHcDvH8rLzfs6ngrtWhqhKhC/IcjxO0ikCgj8lQYm/J389IC+/LwaQ9rkI8/HRhJ6306
	 DreNbD/ufzx0KoHn0YtYoyxFRaOcC/u+U8v7NNM/jb4hng6YogUg0HlSL3rNVvFXMsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amKfau5A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098C606A881
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amKfau5A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1BE1F00A05;
	Wed, 11 Nov 2026 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414134;
	bh=uc+XbsyDv1Lbk4nCqSnicF7bVtJ2iFuUUXg5zFQrTCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=amKfau5AS+5cBhpc50RnrZkx06AD09H6F40gJ+uSCO3/YBTiFXiNsZLc3FSufRpuV
	 0yiBn3IagPi4Ylj+9z6vuAcE0MT5kyqr7pR38IF6+Im4OZsewcteUO52cwG8BpWZUG
	 vhdaZKN5JwiomZ1xk4LAiO1NioyKV00dRcYS7R1YwVh+Jcy8X7eo0WIaW6y5fv5R66
	 knP5q6eWVKjHvbQiSzz4eLYSedUdQfzuMxJ9YsQN8HIC4CpJI9wO5GNNN32u1jFpDz
	 XwnDVHwLrCZs8AAk0p0Qo4nHnrTxOa+jgeb0y72nWKeoXzCwFTO8q2re6rVd/hX23Y
	 l+zZcXszT5s0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
Date: Wed, 11 Nov 2026 11:22:12 -0500
Message-ID: <20261111162146.3266882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060049-failed-5.15-d4febca239be@kernel.org>
References: <20261107060049-failed-5.15-d4febca239be@kernel.org>
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
[ sashal: adapted the direct error return to set err and goto unlock for explicit rwsem locking ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/control.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index bce311cd5326b..3c06f426dadd0 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1534,6 +1534,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
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

