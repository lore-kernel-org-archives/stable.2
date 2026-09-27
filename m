Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F13B1EE2
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790523023; cv=none; b=tDK13bkoRP1iPvy5zUbyeea4yxPBMtdViJwdu1E/GyhEw5chdA6rEOxWfb+NsKHyOfT9mVOaH66iSpLqn2TWSPGiw0io29fXO3/7XPIiya1OQVbCVwokbe4/1GlVCYAc0z4WOl93ztYtLgU5ZydHI3QNTTYJI5RJz3h7njvRQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790523023; c=relaxed/simple;
	bh=a0rewO12vdtnPhBBS/nIg+3RPM7hKRWtmasS1tiBbUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6Kkg/61zQIbMVOn3FXsCeY+7/x8XHZ3QzBgaxzF1JjwLPeI96mpH81VeAk4JI5i4JmMmWHh+O9v7O39dKDnAN//h2PbL6dl+Zwbpd8j8TTDR0N3kycQKNz7xHm3xArtIh/pZouK+//0G4hHdu88f0WanE84IVxXyv9xiwMVdjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmZyox2N; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmZyox2N"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0135fso14905565ad.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790523021; x=1791127821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mjhaILwxKgFt49EiWkQN7M/n6MN/CEKyFnK5lZJ/n7U=;
        b=DmZyox2NU3Yyz8znjAW7WTerIVEzDDHVS+0fB5Z8qiDGC4xJfhTqMXRM5PdAFWmN83
         0q+aZmoJmoIChZyDitjpR4X9jHY8eYuCEzeSwY7QntCw1GEZvBgBWNrJtkHcRllnDW5m
         uqo01dZAA/M8L/1q1KTZydQ9STXAc531ciL3L0qPWo3RcLehDQFn5LAxDtIGQw1TF0a5
         mex4zMgOQCkaLXC80+rFnHp1kjA8FQlyl6i+k7VeZ4QQC5O2aFWZKFT6PpEgtVGvIZR2
         c0Dqnd85okZhVmQQdHjCGk1UQrH9eUdMTp6VfpkV0Ro4vHphsFtTzp0t5ZEkYtE4bQ2b
         DEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790523021; x=1791127821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjhaILwxKgFt49EiWkQN7M/n6MN/CEKyFnK5lZJ/n7U=;
        b=alyEi3IqvR1UFrt7h7eU1kNKY2x1W0wRqOIKK59oGXlOj6VGVZf5t5GQce2ukK7bKW
         /SwNQtWHpVVxW5JGgpiTDfNA74dd8UvLkYTcdVyiqowS7V2e94P3vUEKl5UCRSz8Gf/4
         QiNk1n4HluPjcoQGc/KeI2E3gIhoMFzC5gMZg6kJP2GctIQPr3SQ0d+khuaJuTdQFhft
         r0i2ODuw27/R/D4Jh95azDFAAE+ucpolxsgEn9wzOZ2Fxw6Qtji8w4SzA6rMHBhTq4qF
         IFpS+SwSpXIBtrbc3KqdTr8MUHs9AAofWOCZR64iHmkzJ4cs1SqA+O+iR+s3MKJ4eqKo
         SbCA==
X-Forwarded-Encrypted: i=1; AKwUvBzkfb7DM7gqD+swzhJEYz1hFEAREGA2X+jiL73kZaLH3sYM3kOJCTSDcBSWy/qEWnPjUn22hgA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN602KhkNudbXZG7skm33wo2SGQZTGibqaUpWChxDxA4kvseuI
	p9nLKLtNo8BPeSvzXmVsWGglrzwHPhCeyCIJL4M6Gz7hn+d0AsIMyec3
X-Gm-Gg: AYBFou1TunnSj2CyHwnOFvjq0deimjAfcSevpTvL+CozZbJErYLl1u0aHGHoKzoMuev
	V2Qb2bm8rX6Oy16ozWbydSiO+Z+k8obNBaR1fA3+87K1avRVCRaM5lmpTcwFxoVhlggBngk3WBj
	5UJSLmpvhy51wcMceFFMJEGg1jqxAgTRxFvG4J5RocSe/8dzBt2MONgx1Mda9o7abfYrxkvUvUx
	Yc+C0YUa3dQDLa/ArlUpMKZV7JwA2gVIw6aDmWfnLmqpXlkKgBVutZiqzRfFZgrzoo35g8CXVbf
	2p1Oq7rjLGkyxu/DlwNhq0E1K6BnzILBHcX3Ipy7bcyHi/nkaHM0cYM7CVUZ7h6lcV0tGcKYwnX
	ChWvd580uCMTllX3igpj6zOPDPyfM1FDj7ca3zeQhBewwxknqR2TqO7Sj8o3uYbuy/tIOj9LC5D
	zaa3O3sR8nhXOGU//rOVxcsafMz3PLw1durL9rGaec2UbGVT1kBnAO0DiJZCbi2V+9x/uWtPPGu
	/ET9RMgd9Hh4oLBTs0ifYw=
X-Received: by 2002:a17:903:1a43:b0:2df:ab36:f15f with SMTP id d9443c01a7336-2dfab36f4femr28967115ad.43.1790523020553;
        Sun, 27 Sep 2026 08:30:20 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142b00dsm30373515ad.49.2026.09.27.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:30:18 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: david@readahead.eu,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: wiimote: initialise rumble_worker once per device
Date: Mon, 28 Sep 2026 00:30:14 +0900
Message-ID: <20260927153014.1395106-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wdata->rumble_worker is a single work_struct in struct wiimote_data, but
two different modules called INIT_WORK() on it:

  wiimod_rumble_probe()  devtype module, once per device
  wiimod_pro_probe()     extension module, once per extension hotplug

These have independent lifetimes.  The devtype module is loaded once by
wiimote_modules_load() and stays until wiimote_destroy(), while the
extension module is loaded and unloaded any number of times by
wiimote_ext_load() / wiimote_ext_unload().  wiimote_ext_load() calls the
extension probe with no lock and no cancel_work_sync(), and for the
common EXT_NONE -> EXT_PRO_CONTROLLER transition the preceding
wiimote_ext_unload() is a no-op because wiimod_ext_table[] maps both
EXT_NONE and EXT_UNKNOWN to wiimod_dummy, which has no .remove.

So nothing stops the force-feedback path, which is still live in the
base module, from having queued the work already:

	/* wiimod_rumble_play() */
	wdata->state.cache_rumble = value;
	schedule_work(&wdata->rumble_worker);

INIT_WORK() on a queued work item is memory corruption.  __INIT_WORK()
does

	(_work)->data = (atomic_long_t) WORK_DATA_INIT();
	INIT_LIST_HEAD(&(_work)->entry);

which clears the pool reference and the PENDING bit, and re-points
->entry at itself while the item is still linked into the worker pool
list, leaving its neighbours pointing at a node that has left the list.

Note that CONFIG_DEBUG_OBJECTS_WORK hides the impact rather than just
reporting it: work_fixup_init() calls cancel_work_sync() for the caller,
so a debug kernel prints a warning and then repairs the state.  That is
the kernel stating what the driver should have done.  Production kernels
have no such repair.

Initialise the work once in wiimote_create(), which is where the object
that contains it is created and which already initialises
wdata->queue.worker, wdata->init_worker and wdata->timer, and drop both
module-level INIT_WORK() calls.  wiimote_create() runs as the first
statement of wiimote_hid_probe(), before hid_parse() and hid_hw_start(),
so it strictly precedes the existence of any input device and therefore
of any path that could queue the work.

This does not affect the deadlock fix in commit f50f9aabf32d ("HID:
wiimote: fix FF deadlock").  That fix is the offload itself - caching
the value and deferring to a worker instead of taking state.lock inside
the FF callback - and this patch leaves wiimod_rumble_play(),
wiimod_rumble_worker() and state.cache_rumble untouched.  Only the
placement of the initialisation changes.

The two halves come from different actors, and both are available on a
stock Android phone without root.  The extension hotplug half needs only
/dev/uhid, which is group 3011 and held by the shell.  The shell cannot
write to an evdev node - SELinux grants it read access only - so the
force-feedback half comes from an ordinary app calling
InputDevice.getVibrator().vibrate(), which reaches EVIOCSFF through
system_server; VIBRATE is a normal permission and is granted
automatically.  A paired Bluetooth HID device can supply the hotplug
half instead of /dev/uhid.

The ordering matters: the device has to be created without an extension
so that the devtype resolves to a GEN10/GEN20 that includes
WIIMOD_RUMBLE, because WIIMOTE_DEV_PRO_CONTROLLER does not, and the
extension has to be plugged afterwards.

Measured before the change:

  Pixel 11, stock Android 17 user build, SELinux enforcing, no KASAN and
  no DEBUG_OBJECTS at runtime, kernel 6.12.81: reboots with
  ro.boot.bootreason=kernel_panic one to two seconds after the two paths
  start overlapping.

    Unable to handle kernel NULL pointer dereference at virtual address
      0000000000000008
    CPU: 5 Comm: kworker/5:4
    Workqueue:  wiimod_rumble_worker (events)
    pc : process_scheduled_works+0xd4/0x810
    Kernel panic - not syncing: Oops: Fatal exception

  The empty workqueue name in that line is itself the corruption:
  print_worker_info() reads wq->name with copy_from_kernel_nofault() and
  it failed, while another CPU in the same dump shows the normal form,
  "Workqueue: events wiimote_init_worker" - the task that called
  wiimod_pro_probe().

  x86_64 with CONFIG_KASAN_GENERIC and CONFIG_DEBUG_OBJECTS_WORK both
  enabled, 15 s in: KASAN says nothing, because INIT_WORK() writes to a
  valid field of a live object, and DEBUG_OBJECTS_WORK reports

    ODEBUG: init active (active state 0) object type: work_struct
      hint: wiimod_rumble_worker+0x0/0x70
    WARNING: lib/debugobjects.c:629 at debug_print_object
    Workqueue: events wiimote_init_worker
     __debug_object_init+0x1ff/0x3b0
     __init_work+0x51/0x60
     wiimod_pro_probe+0x28/0xba0
     wiimote_init_worker.cold+0xb6a/0xe88

After the change the same reproducer drives 36774 extension hotplugs and
612156 force-feedback plays in 60 s on that x86_64 kernel with no ODEBUG,
WARNING or KASAN output, and the rumble reports still arrive, so the
force-feedback path is unaffected.

Fixes: f50f9aabf32d ("HID: wiimote: fix FF deadlock")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
Notes for reviewers, not for the commit message:

 - base-commit below is the public next-20260925 tag, but the three files
   touched are byte-identical in linux-next, hid/for-next, hid/master and
   hid/for-7.4/*, and the patch applies to all of them unchanged, so pick
   whichever tree suits.

 - It conflicts textually with the pending series "[PATCH v4 0/4] HID:
   wiimote: new LED behavior on connect + scoped_guards" from Rafael Passos
   (<20260817213840.1053216-1-rafael@rcpassos.me>), whose 4/4 rewrites
   wiimote_create() and drops the call. Happy to rebase on top of that if it
   goes in first; I kept this one standalone because it is a stable
   candidate and that series is a refactor.

 - The reproducer is a reactive /dev/uhid wiimote emulator, plus a
   reflection-only dex run through app_process to drive the force-feedback
   half on Android. I can post either if that would help.

 drivers/hid/hid-wiimote-core.c    | 1 +
 drivers/hid/hid-wiimote-modules.c | 5 +----
 drivers/hid/hid-wiimote.h         | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 63c4fa8fbb9b..1946c23867c8 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1754,6 +1754,7 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->state.cmd_battery = 0xff;
 
 	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
+	INIT_WORK(&wdata->rumble_worker, wiimod_rumble_worker);
 	timer_setup(&wdata->timer, wiimote_init_timeout, 0);
 
 	return wdata;
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index dccb78bb3afd..c5b48065638e 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -117,7 +117,7 @@ static const struct wiimod_ops wiimod_keys = {
  */
 
 /* used by wiimod_rumble and wiipro_rumble */
-static void wiimod_rumble_worker(struct work_struct *work)
+void wiimod_rumble_worker(struct work_struct *work)
 {
 	struct wiimote_data *wdata = container_of(work, struct wiimote_data,
 						  rumble_worker);
@@ -155,8 +155,6 @@ static int wiimod_rumble_play(struct input_dev *dev, void *data,
 static int wiimod_rumble_probe(const struct wiimod_ops *ops,
 			       struct wiimote_data *wdata)
 {
-	INIT_WORK(&wdata->rumble_worker, wiimod_rumble_worker);
-
 	set_bit(FF_RUMBLE, wdata->input->ffbit);
 	if (input_ff_create_memless(wdata->input, NULL, wiimod_rumble_play))
 		return -ENOMEM;
@@ -1865,7 +1863,6 @@ static int wiimod_pro_probe(const struct wiimod_ops *ops,
 	int ret, i;
 	unsigned long flags;
 
-	INIT_WORK(&wdata->rumble_worker, wiimod_rumble_worker);
 	wdata->state.calib_pro_sticks[0] = 0;
 	wdata->state.calib_pro_sticks[1] = 0;
 	wdata->state.calib_pro_sticks[2] = 0;
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 9c12f63f6dd2..c63cd0a68e0c 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -262,6 +262,7 @@ enum wiiproto_reqs {
 #define dev_to_wii(pdev) hid_get_drvdata(to_hid_device(pdev))
 
 void __wiimote_schedule(struct wiimote_data *wdata);
+void wiimod_rumble_worker(struct work_struct *work);
 
 extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
 extern void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble);

base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
-- 
2.53.0

