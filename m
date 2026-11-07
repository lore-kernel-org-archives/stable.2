Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050260;
	b=KnwokpoIs/o/Jv/BQ4EnpKgS5TwhkaEA0DxTiPM/fsvIo4fIdyRJaCLiSEqxYTrJnL7H
	 LjHQ1m0g0lKoVijvv31yCGnqwV9OD6Bg8rI6lnmEjnC8CuFH9JsB5CXLu4XPSJPTUUKmt
	 Cmj1JjEtbycL5e3ySYrFhO0npwoqRS9leuXQioxAimjmhn+UWG3DpEIpN2RC6dPmbAu7C
	 Tl4fldJx9/SNkWFfsjFcS/tJpu+g1MjEqFqblXNNb/ZPWsVCdQ0QHUQTG3z/ToCXbuh8H
	 jAXG1pAUAzHqi+fT5qNPQx1R8qCIySrgwyBIuqmPad+LdalO3sjOecyVQbe6CiTkWyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lsvkBHqczs2PBx7oQQ7XZUfZIIUTj0OM6jGae6NQo/A=;
	b=5LGzwFrPQpIzFh6P72+YTbwni+lSNjLEhN3h0jnowX7jxDdaAjmxj7LVpSdyp5d29SdS
	 0HMTZZMXoYueiu+aZEiwO8UL9iqWXwdDNaMcVUtVtdF0HnniOcMPXQjXDlDAbsKwcl4j6
	 eYLNz0lIGlNOUroNHAldnC8bORM7zrp33u2H1G75zA2r++0P7Dk9FXmizvzwRO9z86lOd
	 Z0SjL9ebSKINPUgv3dNCXa0lxJDGEaWfITJfKZ/SJMxDHoBtYUT07D0w2d9NhUbLdy4Bb
	 ZzhzLHENPmh8nMZMjk9QL4Vu8WRO+qMqVkhhUSGGzX/s96CPpTMcJiwNgyn7CY5C/9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzMfYLw3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C7606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzMfYLw3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA6F1F008A1;
	Sat,  7 Nov 2026 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050259;
	bh=lsvkBHqczs2PBx7oQQ7XZUfZIIUTj0OM6jGae6NQo/A=;
	h=From:To:Cc:Subject:Date;
	b=VzMfYLw3OXfwK8i1qT3dlos6m3e4ruG5xVBOnsapkvOIvivX5T3KcIvhhifsCVbEb
	 wP2pFjzWq3JxO/G2D5vh896OdEJellYBQQPrMxZY9s62u/6o1Iidi7umeSh8TiChuS
	 kB+Jw2RhGM3stC9DiCMCRmc2U6oERqeRlwUQIy3hlOUxdkwrsVYf6gdNSrCJp4Z7MI
	 gBDGDl6p5TT/ZyRx9ZD2LGK/F/nHAnLD23DaxB8Bl4u0MtWG5nrXZ5Sgj0xe5Uzawo
	 QhsriM80osYzJimVR1CaM3vaZkmxTfrrG0jwUZ+dQSkMbjBSjoMfLfAWzNIom5evUq
	 dSi83CEO5FEww==
From: Sasha Levin <sashal@kernel.org>
To: tiwai@suse.de,
	farhad.alemi@berkeley.edu
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: control: Fix UAF in snd_ctl_elem_add() on card disconnect" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:38 -0500
Message-ID: <20261107061738-failed-5.10-d4febca239be@kernel.org>
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
git cherry-pick -x d4febca239be3c91498762dd0535a87d4af1eabc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061738-failed-5.10-d4febca239be@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




