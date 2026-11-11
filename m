Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415503;
	b=Ypgu8CI9ve0JVSRNHW+aiNufI6HpngIZMoDyVcjg6FS7vt6wqmd4y8C6xtcNnsn/32wW
	 U7t9zHP7iII6sXDg82vTC05m51coGvyolBka/dpz9tbMQuGtymclhQY8jgvhQGZWaDQ2x
	 lZFr0XZh0p1xZ4wz4KgZH126ea4r2vruonuym2Ww8AuN/2sORZNhHl3Cm7NyhAXDhSzW5
	 T7gBZnnN2QWyBoGH80JT5BkfyM5s9VbLvDOiZv7zO9MtehNBZ1POZQnXqITLyxvToPyZy
	 D0dGntSvqO94P9bQ1epoP0gnDQ/AVMSjTdO8eNXjvdmcci30Gme2hX7esuzdvRaKreg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415503;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uBBMJmtCZN4R7tOY2IN25gNsEDwQ/ARsx44GubqIh+c=;
	b=PzYVq+p//VduOKtRUg9S9Z5w11JBR8y58aErlwBR0U9Yew4AWSuCNs7+KzrDBfnbMAfd
	 ge8A0xNpVtAbX4RBStvtZKDupfn5I0dKdjlzvQ/lpSGPbKsfU6GUmA9moFQiDP0EOFkHw
	 uQEWn+tbn7Kq+NVIlFhyOZNGMLWZ4CRome1MTgCo6FkP2BdmllYkphsLOIAi+lw0SYHYz
	 B5DJsgxYOPeLUfj1RljNV9+FzNXBEU71osHcHClmKgOWqv5fTMX+deFPqLKje5cj68cae
	 I97ALZh4plkT0ulEv08qh9u4dhQCPAPMV6ql+BixnE04UtiEk/lcMw/7OrpKTE3fqfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fA8EqKtZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1B7606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fA8EqKtZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8971F00A05;
	Wed, 11 Nov 2026 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415502;
	bh=uBBMJmtCZN4R7tOY2IN25gNsEDwQ/ARsx44GubqIh+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fA8EqKtZXyDpHKIDDBPcGnAc09vtTbnlKgZrg4xOJ3Wk+qv87JmH3eNb5DcSVf5DB
	 JoGHRc8ji416MKRxLa0qvxhzS15nO58pkMCDVRFj+tLn7kDMFVidfDIl63WgVDf3ka
	 SwsgqWgjJIX0SI6XkD4Eub//gLyD0/oCU2Lw6s2y1FS230Rb1SUuhGSpNXSY28uiR+
	 UPQfphDxzzcNCZ2AibnqIZNK5UfwBkARNxZA/hN5FAYkNMYEe2Ih0/uKNQfF3bFR2d
	 X0NgBmWo7HSM628A5W/sWW5dTTOz8g60LQe4QOOuoeUWMEid6Z0062kzpHuOoBStaX
	 Z83VKpKlfQIOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect
Date: Wed, 11 Nov 2026 11:45:00 -0500
Message-ID: <20261111164432.3291514-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061738-failed-5.10-d4febca239be@kernel.org>
References: <20261107061738-failed-5.10-d4febca239be@kernel.org>
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
[ sashal: Adapted the early return to use the existing error path that frees the preallocated control and explicitly releases the lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/control.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 640bafb6605a5..4a9d13086f0b6 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1525,7 +1525,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 
 	/* This function manage to free the instance on failure. */
 	down_write(&card->controls_rwsem);
-	err = __snd_ctl_add_replace(card, kctl, CTL_ADD_EXCLUSIVE);
+	if (card->shutdown)
+		err = -ENODEV;
+	else
+		err = __snd_ctl_add_replace(card, kctl, CTL_ADD_EXCLUSIVE);
 	if (err < 0) {
 		snd_ctl_free_one(kctl);
 		goto unlock;
-- 
2.53.0

