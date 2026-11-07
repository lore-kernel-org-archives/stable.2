Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049252;
	b=S3sVYpZHWk6eaB2976fnEdoHeoI28EQiIrDI3Y+OQpBZ6Xpv95iFO8SpvGNQjQbtzrSU
	 +2pmIqR2FOFMrxDDYVUzJwdZdXQpKE4b1krhZ9rXZnF2V1BS2Qbo/D1xO6cU+hzyp+PV9
	 OpvsEiE9sJlNhpnXWcvy0UV8i3lizjDgBlJ24X/wya/kiqiMozO3b6ZUSclLH8W8/DyU2
	 sxpHkSA73u9QFpBqT7RRtQ/29n7WejrXXapPnvU/aKVVaJLBgPc0Nxt1+TYF3hnBaotHr
	 DduV95+YcQ1/Xhdkas7gJpG/TvS7GrGg7AbCEeasax17pHQAdhz3Qdprv06fmzaUFRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nB7nfcG/43CamqBDsQmkONWkznQFFP5uuY4oSeaP+Pc=;
	b=AvpTg3zm6v4CSKc2PqAd9AdXzwlhEiHOlitX+sxgdxXhN44luCItw+plK2AqAh2Rcx2S
	 h8TWnSUyhQUix+X9DZiPZnGm6jRJuWKXV0vlSYGITYIXgyUqp1Hy0zoNHNpmTGAxIzXcA
	 1fIbQWRuZzPSUbQQvq8QcilrwAFCaLnBX7xHstcD6/UQLxA6sO763+FK76p7Os1DrqoQW
	 UhISncomqMKeMyW6hrTK+UnMn4kXcGxZcou7QlSeWazBtDu/PuJGRgWbzoTZxFk78sS3/
	 6XVdpif8xutRfusenMSLpeLtX8e1HIQjUn44mOmoyF10C9RPmAUe+lXPJ5HXN4BVQdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3uIsDhF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3uIsDhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B9B1F0089F;
	Sat,  7 Nov 2026 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049251;
	bh=nB7nfcG/43CamqBDsQmkONWkznQFFP5uuY4oSeaP+Pc=;
	h=From:To:Cc:Subject:Date;
	b=Y3uIsDhFwHTwMGkxhvC3bsgQWrNjjs+sjgJjU1xiqt+k8GlitsZy+XLGXwQdzRfLM
	 jrYTqe7hf1T0h38x9tvhBFyP9mf4CkD8khgqxxA9mp9ZW6JYnFBLncWD3eGAM5/Z39
	 a0ji9fc5gb9ndt5oON9aSECenjViavVhXCBkIo7MX+uW8NbCjefAVOaRnlNp8G23oV
	 UKDxCON7P0m/V/OvgZci2Yvs5ynuKOZfLkoXNUrY7MTGD+0lMTJKEgqDdZK1lUYPVi
	 F8PdugsHbOUFkeGGOjjuMsWWyDmgF8sQTBfX2h0q3t1FmLqjU934AkVLE4zY8SnLft
	 Y0H6H4Pt00h9A==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	farhad.alemi@berkeley.edu
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:50 -0500
Message-ID: <20261107060049-failed-5.15-d4febca239be@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d4febca239be3c91498762dd0535a87d4af1eabc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060049-failed-5.15-d4febca239be@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d4febca239be3c91498762dd0535a87d4af1eabc Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 29 Sep 2026 14:53:42 +0200
Subject: [PATCH] ALSA: control: Fix UAF in snd_ctl_elem_add() on card
 disconnect

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
---
 sound/core/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 4199342d4ffe0..535ceba294acf 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1802,6 +1802,8 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	alloc_size = compute_user_elem_size(private_size, count);
 
 	guard(rwsem_write)(&card->controls_rwsem);
+	if (card->shutdown)
+		return -ENODEV;
 	if (check_user_elem_overflow(card, alloc_size))
 		return -ENOMEM;
 
-- 
2.53.0




