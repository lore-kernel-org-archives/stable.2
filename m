Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634479;
	b=iEmdOYtjwiRMWNY+4vBTJivTY+1NF81dwVBR1OmJtJn0IMrRcUA+8oXzSaqB/gA88oFF
	 DH+eQFC9jJ8b9Q5UCXIxu71BL5mY2zmP/5L3yTljNwuKgrPuyqNZa8zFSnuS07ORymRJc
	 KAkVpoMXfGh0KOUWjyrBLCa361RsfhkgT6zqrMHiUG4zCfE8eIrGo20Su4ZZ6Je209jIs
	 OkTHRsRM/gnq+5BetCzW7+beFwNs3tvK9zpknoKMjXT8vlEX3Vfi2kenekbZcu+q/X5FE
	 ghm14q+8ahSTskv7xIwCclEepbID8iZqSIpqfjqXTK/DwuCtxl5ibnv2Eq3lStNx64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634479;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=4k7ohsPxej6L59b5Tjp/2AFI7B43mGDw/TdGi88o2gY=;
	b=b50bgqCfodOCknhguTdF+BPEK8Thcpt6jj2i6H58gcdvOLVl8rKWs6BTjpW7t14NFhTG
	 ZiJOHBRSUDyoPKJaTsSu5pIcGjER+r52QGB0yMo6OThrV63HjMazF5NFAN47uUEeX6Q/y
	 981PF3GC5Tatxmn8WQ/8v+cSufN2L/EGfvq0uyi8oJjFLT4g0+9s+5v1KAodVAQU2ltqP
	 5lm28+ZeFy7to8hO3UUDU95/U/8Vgwj+pP19rTqjpkglyPTHQx+mkcgl25zs8Zct1OUX4
	 kCwI6rmMOgP9ZXTgR676x7Snd2Lis1sEgUbcZWp4EYTU70wzGqP73U3z2hf6JskFBJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nitrohex.com;
	spf=pass smtp.mailfrom=nitrohex.com;
	dkim=pass header.d=nitrohex.com header.i=@nitrohex.com header.a=rsa-sha256 header.s=protonmail header.b=xOucXI9Q;
	arc=none smtp.remote-ip=185.70.43.17
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E69606A31E;
	Wed, 25 Nov 2026 19:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2E69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nitrohex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nitrohex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nitrohex.com header.i=@nitrohex.com header.a=rsa-sha256 header.s=protonmail header.b=xOucXI9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nitrohex.com;
	s=protonmail; t=1795634476; x=1795893676;
	bh=4k7ohsPxej6L59b5Tjp/2AFI7B43mGDw/TdGi88o2gY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=xOucXI9QJIrXG0Vs7IYfM6CzCJ9ha0pOJOVyem9qgw+vit6zyOHxOUE+OQYbQVsn9
	 lbhlfdumAEaMedRBMv21+1G5TwwvC4Id2pjcBWzUkUysrwcdpbWHMVOBA2EMALIcQI
	 Px3rNzN9bj+AGQP/k8t+xsHUynbyDc4X+ejA5+/Ga2xs+P6GyaQrhYFLVwvxnQLwRc
	 ExK2UvGHaM9QNkKThoep+lPeGTgzwXVjDYsh1YKBtDWcUlxO639xptBgWe+ojHs+g5
	 c7nWqALscZ5O23lOgw1YWgczRxD+RQwZHF3YGyg5qzgugivXxIWymHWxTRJQbKRqQl
	 Vb5iB3JGpGBxA==
Date: Wed, 25 Nov 2026 19:21:12 +0000
To: perex@perex.cz, tiwai@suse.com
From: Rongen Wang <security@nitrohex.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] ALSA: timer: Protect the slave instance flags with the timer lock
Message-ID: <20261125192053.5664-1-security@nitrohex.com>
Feedback-ID: 235154292:user:proton
X-Pm-Message-ID: 91ebf654dc522a684de742c5013fe2bc638d227c
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------614efbd2c3e3428e932d58df87f8c2d4af8a75bbdd06252af9d82974bb81ff2e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------614efbd2c3e3428e932d58df87f8c2d4af8a75bbdd06252af9d82974bb81ff2e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Rongen Wang <security@nitrohex.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: timer: Protect the slave instance flags with the timer lock
Date: Thu, 26 Nov 2026 04:20:53 +0900
Message-ID: <20261125192053.5664-1-security@nitrohex.com>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0

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
   __snd_timer_
user_ioctl.isra.0+0xe93/0x28f0

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
The bug was found and this patch drafted with the help of an AI tool;
I reviewed the patch and ran the tests below. The report itself went to
the maintainers and security@kernel.org; a reproducer is available on
request.


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

 sound/core/timer.c | 50 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 d
eletions(-)

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
 			      &timeri->master->slave_active_head)
;
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
 /* sto
p/pause a master timer */
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
 
+/* stop/pause a slave timer; see snd_time
r_start_slave() for the locking */
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

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3

--------614efbd2c3e3428e932d58df87f8c2d4af8a75bbdd06252af9d82974bb81ff2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wqsEARYIAF0FgmsHNSYJEEViQ3yWCW7tNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcXDlZ5kM4ufzChNfQ9w1NlFiEEfxPrtnS1hdMk
TNpkRWJDfJYJbu0AAB5AAQDoWCxbm6g0M8US1HCYvwygdxFMmkQiQBdLt3if
/HegEQEAwYRSShdIDvQS3Mw37hEWaiB1K1wEfv0XrLw7lI6gqwU=
=9I2y
-----END PGP SIGNATURE-----


--------614efbd2c3e3428e932d58df87f8c2d4af8a75bbdd06252af9d82974bb81ff2e--

