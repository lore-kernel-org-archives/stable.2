Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795684827;
	b=dkbAQn9uwYJ0vrTg9ehmrjfZFc5RIqJsKFPIz/mfGkNJy2EKdSKuWKkwxXXybTG+e6mJ
	 pQHIyvDCd4aqAQSDYyEdEzBYRg8qmjajyHiClsxXO0ZAF7TUs3mU1OKBcjSE7M/5wFy/u
	 QbJYHTl9haciinnLBoZq36ge0R1VLWtjxp3/71zS3ytAdznKOrewrRHNLpLuSi8rz9vg3
	 9ja07+mQMuxdVYOJRMo4tbZz9Py4d9hNfcbSclY8hj/Up8PAQODSfXQOhDAhMSPQSx3G6
	 oCN64A1yWutbVhoB+V5nFaADu6L5NNLAJzsbx+u2NzQv5pQoJM0gqna+IyHFwX30ByA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nuUnQGTcueHhJHJcO2OAzRxkKWcLAW2OBLKsq3wXXVY=;
	b=5tzRLvLt4qXBM8RfkLbjhBj2NBpr1LeiT5jx9sutsFG1x99trNtD3jAPgeeflOC97mzF
	 eV7EDT3QOj5u26jUYJ9XXYivLadlsGi35S0/Q4FgvDMV7O54MPsdMyiDQljfk6w0NZ1cc
	 yRPhpW1Mhlf0NDVd04b8P+RcmL6vzg6iPwy9Zq/C6GmkKJNG3qw5s05eMNWZ3YXWfxCQK
	 /CPVUJnQ/1NnK0oIhqT/GzMxlc2B46IcO59Rxit7iDD4Fov/PC2kUsntgKG813v60OoJb
	 BLQoc+eUG+eyJnW/tfuKLgbyM84ZEjjV1mw7wlwHplSvfi2HrYJmkpfsvV8DgJU1kgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSNW7z1i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B019606A31C;
	Thu, 26 Nov 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSNW7z1i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795684826;
	b=gpXPwCqz9UMLOgMQz9+1YsNkZ/70IiPjuKy0Nzin4vddV8vZgendhMZMFIhc/dunu7Mj
	 u8JgBr+4GkC4r016jISNH5S6f8EzrwEalJi/uxmCmvKNpLOBo2czWe/gCUAI51zrBppUE
	 6VuxwBG+w0w/4ybkvm4fJMr+fXnUToAd4nkD/hev4H7IGVz8Ot9QAmAZXzq+ichssYx4e
	 g7j/ItirgL5T945HW/ZfKESKzBXjuYN849sh517wytXHkD3rOEdXaqiE/0Q68C7xXjv5H
	 9i/tavP6PDXX7Zr65nNBMfeGqiHxFOnAvFCCjdtmBO3i8wryRcs3nwFkvdSD40+joEg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795684826;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nuUnQGTcueHhJHJcO2OAzRxkKWcLAW2OBLKsq3wXXVY=;
	b=KAGOv2qtLJgdwaoxVsiXQ+dsod2TxeqIhNN7e+KcN6Irqkeo6012FwhnNH7BBWlWcbSl
	 lL3rxX0UVIUOcq5OgqgZ1UFzyyF0X0Lx12yMwaPLRykPWiDB8upSLI2OcUYDtkAKMYVcZ
	 i9zuVbk1QsUVLWJnOvfA/CAIP1pJrEkS7ArAdOSHDzPns/TKWk63ajVd3k/ITVavrXyVG
	 kNg7Is57Hz5ysMW1P1SjWEtH6w5otxjFf55YFC7fZlzKw0S86469oYpaHr7nx5G0L4q3T
	 1O2aTXDCYHZFw5qYnKfTjY07DdHbUjhSTDEpwzhiey/rsykWXqPMDJtTElO/1hJOENw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17FEE1F000C0;
	Thu, 26 Nov 2026 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684826;
	bh=nuUnQGTcueHhJHJcO2OAzRxkKWcLAW2OBLKsq3wXXVY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KSNW7z1igKbI7+2p/8k/J/gNYDzuALXsruMCzEcCcqOHf10sR52NwqzPJJTeggPeg
	 kchu73HsNq6sl2pBZnc813UMD3KRydO3IpxlM2jedjqvoCSFRAXYKXIBsS4JmSPgvQ
	 ySHswAqKWg2GdQltfOMwpU4TqQ9cADCTD8ps8xQrZO61fAO1a+l/4NJWJYEDzoqJSu
	 vYQo8XCzXh1CIHI891LvRxNWgMWjFAximoFQsgvaLf8JkLECLRpl+Af47PsaItqFXP
	 q6pbLrrSgTFerSUOyTidoOoOAr6FaSqbtE/OS1RRmDqqYI0aRzrfjc41HSfay9aL66
	 hwd/WzZh+BHWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9899C4D326;
	Thu, 26 Nov 2026 09:20:20 +0000 (UTC)
From: Rongen Wang via B4 Relay <devnull+security.nitrohex.com@kernel.org>
Date: Thu, 26 Nov 2026 18:18:33 +0900
Subject: [PATCH v2] ALSA: timer: Protect the slave instance flags with the
 timer lock
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-alsa-timer-slave-flags-v2-1-8e07a536fea3@nitrohex.com>
X-B4-Tracking: v=1; b=H4sIAGj5B2sC/yXMQQ6CMBBG4auQWTsJbRTUqxgXY/kLYyqaDhITw
 t0tuvwW7y1kyAqjc7VQxqymz7HA7yoKg4w9WLti8rVvnPMNSzLhSR/IbElmcEzSGyMc29MhxNr
 thUr8yoj6+Y0v17/tfbsjTNuN1vULH/pCKHoAAAA=
X-Change-ID: 20261126-alsa-timer-slave-flags-ec8795cf014a
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Rongen Wang <security@nitrohex.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795684819; l=6877;
 i=security@nitrohex.com; s=nitrohex; h=from:subject:message-id;
 bh=yPrdezwwo28a566FRr26Hq6P3SlpjEX7jPV2dsOauKM=;
 b=iak98uCKAJp1x/gG1Q/6LT0ZmT/atU7v6w5UlszLA7fFfM4FRQ+rn8BG2/qyPWwfvSOpOYYBb
 R//hX3dZLRIAHEqm6pUDjMSURl7TLwTpdn+B42l8iHTc4VholkmtpTv
X-Developer-Key: i=security@nitrohex.com; a=ed25519;
 pk=Jk5NuTVJdxr1CTP4RuYaG31zSgsNlyFzVo9sphZTqt0=
X-Endpoint-Received: by B4 Relay for security@nitrohex.com/nitrohex with
 auth_id=1652
X-Original-From: Rongen Wang <security@nitrohex.com>
Reply-To: security@nitrohex.com
Content-Transfer-Encoding: 7bit

From: Rongen Wang <security@nitrohex.com>

snd_timer_start_slave() and snd_timer_stop_slave() set and clear
SNDRV_TIMER_IFLG_RUNNING in timeri->flags while holding only
timeri_lock.  For a slave that is linked to a master, the interrupt
path updates the same word under timer->lock:
snd_timer_process_callbacks() sets SNDRV_TIMER_IFLG_CALLBACK before it
calls the instance callback and clears it afterwards.  Both sides do a
plain read-modify-write, so when they overlap one of the two updates is
lost.

If the set of SNDRV_TIMER_IFLG_CALLBACK is lost,
snd_timer_close_locked() does not wait for the callback that is still
running, the owner frees the instance, and the interrupt path clears
the flag in the freed object:

  BUG: KASAN: slab-use-after-free in snd_timer_process_callbacks+0x269/0x2b0
  Read of size 4 at addr ffff888007e5cc10 by task poc/90
   snd_timer_process_callbacks+0x269/0x2b0
   snd_timer_interrupt+0x7b8/0x1100
   snd_utimer_ioctl+0x7c/0xb0
  Freed by task 91:
   kfree+0x127/0x3b0
   __snd_timer_user_ioctl.isra.0+0xe93/0x28f0

If the clear is lost instead, the flag stays set: the instance gets no
further callbacks, and closing it spins in the drain loop of
snd_timer_close_locked() with register_mutex held, which blocks every
other open and close of an ALSA timer.

Take timer->lock around the whole flag update of a linked slave, as
snd_timer_start1() and snd_timer_stop1() do for master instances.  The
callers hold timeri_lock, so timeri->timer is stable, and the lock
order is the one these functions already use.  A slave that is not
linked to a master cannot be reached from any timer and needs no
additional protection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Rongen Wang <security@nitrohex.com>
---
Changes in v2:
- Resend only, no code change. v1 was damaged by my mail setup (a line
  break was inserted every 1000 bytes) and did not apply. This version
  goes out through the kernel.org web submission endpoint, and the
  generated mail was checked with git am before sending.
- v1: https://lore.kernel.org/r/20261125192053.5664-1-security@nitrohex.com

The bug was found and this patch drafted with the help of an AI tool;
I reviewed the patch and ran the tests below. The report went privately
to the maintainers and security@kernel.org.

Tested on v7.4-rc3 with KASAN under QEMU TCG (4 vCPUs). Without the
patch the reproducer hits the use-after-free within seconds and the
close hang within a minute. With it, 778621 rounds (userspace-driven
timer) and 1310178 rounds (hrtimer) gave no report and no hang. A
master/slave start, stop, pause, continue and relink test passes with
and without the patch. checkpatch --strict clean, no new W=1 warnings
in sound/core/.

Not covered: snd_timer_user_params() changes the instance flags under
the lock of a timer it looked up earlier, so a slave relinked to
another master in between would be updated under the wrong lock.
Much narrower; not reproduced.

Trees before 100407f548ca ("ALSA: timer: Fix racy timeri->timer
changes with rwlock") need a backport on top of slave_active_lock; one
for 6.18.y and 6.12.y applies cleanly but has not been built or tested.
---
 sound/core/timer.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 905176bf694..50e31827d9f 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -657,9 +657,12 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 	return result;
 }
 
-/* start/continue a slave timer */
-static int snd_timer_start_slave(struct snd_timer_instance *timeri,
-				 bool start)
+/*
+ * start/continue a slave timer;
+ * called with timer->lock held when the slave is linked to a master
+ */
+static int __snd_timer_start_slave(struct snd_timer_instance *timeri,
+				   bool start)
 {
 	if (timeri->flags & SNDRV_TIMER_IFLG_DEAD)
 		return -EINVAL;
@@ -667,7 +670,6 @@ static int snd_timer_start_slave(struct snd_timer_instance *timeri,
 		return -EBUSY;
 	timeri->flags |= SNDRV_TIMER_IFLG_RUNNING;
 	if (timeri->master && timeri->timer) {
-		guard(spinlock)(&timeri->timer->lock);
 		list_add_tail(&timeri->active_list,
 			      &timeri->master->slave_active_head);
 		snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
@@ -676,6 +678,27 @@ static int snd_timer_start_slave(struct snd_timer_instance *timeri,
 	return 1; /* delayed start */
 }
 
+/*
+ * start/continue a slave timer
+ *
+ * The flags of a slave linked to a master are updated also from the timer
+ * interrupt (SNDRV_TIMER_IFLG_CALLBACK in snd_timer_process_callbacks())
+ * under timer->lock.  Change them only under the same lock, otherwise one
+ * of the two read-modify-write updates may get lost.  The caller holds
+ * timeri_lock, hence timeri->timer can't change here; an unlinked slave is
+ * not reachable from any timer and needs no further protection.
+ */
+static int snd_timer_start_slave(struct snd_timer_instance *timeri,
+				 bool start)
+{
+	struct snd_timer *timer = timeri->timer;
+
+	if (!timer)
+		return __snd_timer_start_slave(timeri, start);
+	guard(spinlock)(&timer->lock);
+	return __snd_timer_start_slave(timeri, start);
+}
+
 /* stop/pause a master timer */
 static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 {
@@ -718,15 +741,17 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 	return 0;
 }
 
-/* stop/pause a slave timer */
-static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
+/*
+ * stop/pause a slave timer;
+ * called with timer->lock held when the slave is linked to a master
+ */
+static int __snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
 {
 	bool running;
 
 	running = timeri->flags & SNDRV_TIMER_IFLG_RUNNING;
 	timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
 	if (timeri->timer) {
-		guard(spinlock)(&timeri->timer->lock);
 		list_del_init(&timeri->ack_list);
 		list_del_init(&timeri->active_list);
 		if (running)
@@ -736,6 +761,17 @@ static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
 	return running ? 0 : -EBUSY;
 }
 
+/* stop/pause a slave timer; see snd_timer_start_slave() for the locking */
+static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
+{
+	struct snd_timer *timer = timeri->timer;
+
+	if (!timer)
+		return __snd_timer_stop_slave(timeri, stop);
+	guard(spinlock)(&timer->lock);
+	return __snd_timer_stop_slave(timeri, stop);
+}
+
 /*
  *  start the timer instance
  */

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261126-alsa-timer-slave-flags-ec8795cf014a

Best regards,
--  
Rongen Wang <security@nitrohex.com>


