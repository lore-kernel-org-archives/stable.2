Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A24EF15B
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570181; cv=none; b=WFCxv2aqC1wUQFPS7e64xhzKEAqan29hQxbrQCo01E1lvXq9BDb56EJ+vopDHARJsrAFu7lVfgHqZCilY/3gAr4vL/y6APs1EBY/QZFIwrd5jQAt1KU5Va5ZezraXBGODOeI8LzqTc9sVRQEpU/pnalZakN8/Ce44ZDACSnCptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570181; c=relaxed/simple;
	bh=9vAeSVMgChu8sFTGFbATOHJawdCKY56GlNC/6/iSWKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=poLNbEQMDb+OetEaSUPy718GzOI1DXFWe/UBOgPrnC7SME/wEKA/OhzBvxJYS6oeYNM8pg5O+pTqWNoJQMNePQ8yo+BPPH4Jm8nTmXPlnJWIWdoeWhqFpNqfJrr9tCtAZa77OldOojMQbOggEoc5c8lyISvc9WyYlT0wiIw+kIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmkJYlAq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmkJYlAq"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e7ad9f78dso503057985a.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570177; x=1792174977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5DZyu/rgS+ubvoCBVhk1B0P03cm+osmdOmBLE1t3Jk=;
        b=OmkJYlAq3bV0AxUnYf4O1rDYClb5B3/Inv4F4kv5L8R7z+UpAtYiD38Qy+Ngt9bDzu
         lD6AYAZIIx6wRw3AmEVc1ydy5okCbKlIRH4+GwMtgkEjerPbtkVd9b7w7czLvMFXN4mG
         wmp6nMweEXhqRXl7lqSarkG7qwqlrXDSb2QmogITSrHD4utNykNBVRYPlK1LIKPamWBb
         RFz4RcmGiFtarkyNmJwfnGuM5CQ7qx8ifCoKQTG2duMQTR9etKa/njYSodEgwCsLxd/u
         5JVA4O8DQU3/tdHfIfr2NvMkiYMoXTPNxN8ub5O6WYNmFKjcXfb0J3MUJILUEAhSjc5W
         OAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570177; x=1792174977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5DZyu/rgS+ubvoCBVhk1B0P03cm+osmdOmBLE1t3Jk=;
        b=hrPJFQjJfDKPewI+S5TawGPF2TGKzu8V9faDqfR5I1jPZ5tTWOTo2htuB3ou4jUoyP
         uOGPgMn9OQZv35CuJl7o6TSuhmlYCKtw5geubXmg3MSy4wZY8ti3My5WocV87qGDDKFr
         nRT8FkOUo4SWgghQUZJVG/7n9dcfI+SkXN6TMY7jHzXv0yoHNfLzq9Kj6rGjpZ196lDj
         66PdqGwdB28axhycS6Zq3Qg7KK/LDhALqdS/H5FXGpXHaqZDbwuvLey36f21TTVKa5ON
         1msbhwPH08PO7D9PpfY50Tu+Dj3PgBn8AfyYrx/YKXBF+GyvV/yVaw83rcrkZSL4aYFv
         +qRA==
X-Forwarded-Encrypted: i=1; AKwUvBxKqEbSElFmRdXu0FF19jN1NGdI7sbDlwjocsJtq/Us9MV2fzJ+DD+yiJEZb1AJPB1LLu50tbI=@vger.kernel.org
X-Gm-Message-State: AFuF++mKH2u9/TV26zgqcvrEi0wsfpfq7d+tAIdVlNzgBZ+Gq/gZuMS9
	J9kfLop0OPbZI7VXTsJmAkkv2NM4/4z3W+C//mxV7HWWEzJuQMfWTAs2
X-Gm-Gg: AYBFou38NG9yutQJWGlHqagI5ZX/eRcVghTLED241Y8q5K/vi80ysD8UIOKrTZSsIf0
	PH8a0Dv7xUyT9WOAjftAFCiVFejQEtLsl7AV4dFtoCvwyn9DCeTEyiCVQFolaxnlLm56hByZYzW
	wW0nlRnH/Elv4l+ZXI39loj4N+EbQZQKxvRRhTcVsFtrob7bszxvRdqhQE41cAVrti9B8+I5D8n
	js0qQq2ddXXCwHfpAOkgIz4pJuoWsB3+hWAQuRHke+oJJdLB/ii3sLDo4zTLj2dZjjTiFrbZG9d
	uXuVSymYHpz95HAL4lZ3tUqXmXQjh/oYnkNl0oDaGUQK+OgfhkxNz9ib5WRbrRedqXcv05gApPh
	ihu9GX1G7Z0i0UgIwgItqOQR9Fmir8IR90h94C3BYE8wFltjR2d6Af4/wD8KTumb3oUoOLePWUu
	zvTDMZJZV+WheYGuI9g62lD5CwkyIZ0XcC0+Af79SgfeLyPcQKakFBBsTptDKak3qiSafMikgSr
	ZODfoKsIC73KaGPfDV8jQ8wh/6TbSGMi6Z4NmP1wWdZuftVmwLfmcb1zhvyHQTwZqSvAFZfSSVW
	nypa4iLOTegFQjmhDYRr8mb67sBOP2MV3kWl6/bxo5IIa1Jx0XDUXUhzh0Y1nYAKd+XX2i/269h
	uzrhWC17nYsam/4HWqFBXFtPaCZ+UX8hcijbuCIJX9xAVxmpjg5mJS9fQ2FnkZWrS9KWDHMaa+T
	l/McZbVS3n3GT0ojJzIAoqtFWnT+SO
X-Received: by 2002:a05:620a:660a:b0:93c:7955:afd9 with SMTP id af79cd13be357-93ebd27ab42mr401270885a.52.1791570177349;
        Fri, 09 Oct 2026 11:22:57 -0700 (PDT)
Received: from node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us ([128.105.144.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0c4sm247937685a.18.2026.10.09.11.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:22:56 -0700 (PDT)
From: mosafer <mohsafer@gmail.com>
X-Google-Original-From: mosafer <mosafer@node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us>
To: dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mohsafer@gmail.com,
	rafael@kernel.org,
	stable@vger.kernel.org,
	syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com,
	khiemtranzo532001@gmail.com
Subject: [PATCH v2] driver core: complete deferred binds when drivers_autoprobe is off
Date: Fri,  9 Oct 2026 13:22:39 -0500
Message-Id: <20261009182239.283329-1-mosafer@node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DM06HWVAFSOW.2F050J0BT27TK@kernel.org>
References: <DM06HWVAFSOW.2F050J0BT27TK@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Mosafer <mohsafer@gmail.com>

device_add() registers a device and then runs the bus's initial probe
via bus_probe_device() -> device_initial_probe().  With
drivers_autoprobe disabled for the bus, device_initial_probe() skipped
__device_attach() entirely.

That is correct for automatic *matching* against the bus's driver list,
but __device_attach() also doubles as "complete a bind that a driver
already initiated": when dev->driver has been pre-assigned outside the
normal match/probe path, it finishes the bind by calling
device_bind_driver() under the device lock, bypassing probe().

With autoprobe off, that second duty was skipped too.  USB depends on
it: usb_driver_claim_interface() pre-sets dev->driver on an interface
that is not yet registered, documenting "let the future device_add()
bind it, bypassing probe()".  Composite drivers (cdc-acm, cdc_ncm,
cdc_mbim, ...) rely on it to bind their sibling data interfaces.  If
drivers_autoprobe is written with 0 while such an interface is between
the claim and its device_add(), the interface ends up registered, with
dev->driver set and iface->condition == USB_INTERFACE_BOUND, but never
bound: its knode_driver is never attached to the driver's
klist_devices.

Teardown then trusts those flags: usb_driver_release_interface() ->
device_release_driver() -> __device_release_driver() runs a full
release and calls klist_remove(&dev->p->knode_driver) on a
never-attached node whose knode_klist() is NULL, which klist_put()
dereferences:

  Oops: general protection fault
  KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
  klist_put <- klist_remove <- device_release_driver_internal <-
  usb_driver_release_interface <- acm_disconnect / cdc_ncm_unbind

Keep device_initial_probe() always calling __device_attach(), but pass
whether automatic matching is allowed (sp->drivers_autoprobe) down to
it, and evaluate that flag inside __device_attach() under the device
lock, where dev->driver is read anyway:  a device with a pre-assigned
driver completes its bind regardless of autoprobe, and only a device
without one is subject to the matching policy.  Evaluating the two
conditions inside the locked branch (rather than as
"autoprobe || dev->driver" in the caller) also closes a TOCTOU: a
concurrent detach can no longer turn the completion of a pre-assigned
bind into bus-wide matching behind an "autoprobe off" policy.

Other subsystems that preset dev->driver before device_add() (w1,
tegra xusb, zynqmp-ipi-mailbox) get the same correctness back; for
devices with no pre-assigned driver and autoprobe off, behavior is
unchanged.

Reproduced with syzkaller's C reproducer on a 7.3.0-rc6 tree:
instrumentation shows the doomed interface's device_add() racing an
autoprobe=0 write; the bind-completion branch never runs for it; later
teardown hits klist_remove() with a pristine node.  With this patch the
same instrumented race completes the bind inside the window (3 VMs,
5 min per run: window hit 3 times, bind completed 3 times, and 802
devices with no pre-assigned driver correctly skipped matching despite
__device_attach() now always running): zero KLIST-REMOVE-BAD, zero
Oops.

Reported-by: syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=863936f50214e843ae0c
Fixes: b8c5cec23d5c ("Driver core: udev triggered device-<>driver binding")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammad Mosafer <mohsafer@gmail.com>
---
On Fri Oct 9, Danilo Krummrich wrote:
> We've recently had another patch to fix up cases where dev->driver is
> pre-assigned. Please see [1] and the corresponding thread.
>
> IIRC, there was no reasons the remaining users can't just use a proper
> match() callback instead, so we don't have to worry about those edge
> cases in the future.

Thanks for the pointer.

I had not seen Kien's series; looking at it now, we are attacking the
same half-claimed state from opposite ends: his patch makes the release
path tolerant of it (skip klist_remove() when the device is not bound),
while mine makes the deferred bind that usb_driver_claim_interface()
promises actually complete when drivers_autoprobe is off, so the
half-claimed state never arises.  If the direction is to remove the
pre-assigned dev->driver users entirely via proper match() callbacks,
I'm happy for that to supersede this fix -- I'd be glad to help with
the USB side of that conversion, as I now know the claim/bind/teardown
paths in detail.

Until such a conversion lands, though, the window is still open in
current releases (syzbot hits it, and any userspace writing
drivers_autoprobe races it), and pre-assignment is not only USB:
drivers/w1/, drivers/phy/tegra/xusb.c and
drivers/mailbox/zynqmp-ipi-mailbox.c pre-assign dev->driver the same
way today.

So please treat this as: whichever of Kien's guard, this bind-side
fix, or the match() conversion you want as the canonical answer, this
patch is yours to drop or pick -- but happy to have your steer before
it evolves further.

While the v1 was on the list the review bot found a real defect (the
dev->driver test was open-coded in device_initial_probe() lockless, a
TOCTOU against a concurrent detach).  v2 below fixes it the way the
bot suggested: __device_attach() takes an allow_match flag and the
decision is evaluated under device_lock.  Evidence unchanged in kind:
same reproducer, instrumented patched boots show the deferred bind
completing in the previously-crashing window, 0 crashes (v1: 6/9 on
the unpatched control), plus a clean bare soak.

 drivers/base/dd.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..4c1bb1979519 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1065,7 +1065,8 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int __device_attach(struct device *dev, bool allow_async)
+static int __device_attach(struct device *dev, bool allow_async,
+			   bool allow_match)
 {
 	int ret = 0;
 	bool async = false;
@@ -1085,6 +1086,17 @@ static int __device_attach(struct device *dev, bool allow_async)
 			device_set_driver(dev, NULL);
 			ret = 0;
 		}
+	} else if (!allow_match) {
+		/*
+		 * Automatic driver matching is suppressed for this device
+		 * (drivers_autoprobe is off), and no driver has been
+		 * assigned to it: do not run bus_for_each_drv() matching
+		 * for it.  Deciding this here, under device_lock, means a
+		 * concurrent driver detach between the caller picking
+		 * allow_match=false and reaching here cannot turn the
+		 * completion of a pre-assigned bind into bus-wide matching.
+		 */
+		goto out_unlock;
 	} else {
 		struct device_attach_data data = {
 			.dev = dev,
@@ -1138,7 +1150,7 @@ static int __device_attach(struct device *dev, bool allow_async)
  */
 int device_attach(struct device *dev)
 {
-	return __device_attach(dev, false);
+	return __device_attach(dev, false, true);
 }
 EXPORT_SYMBOL_GPL(device_attach);
 
@@ -1149,8 +1161,18 @@ void device_initial_probe(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
-		__device_attach(dev, true);
+	/*
+	 * Always run the attach, but tell it whether automatic matching is
+	 * allowed.  Completing a bind that a driver already initiated (e.g.
+	 * usb_driver_claim_interface() pre-setting dev->driver for an
+	 * unregistered interface, expecting device_add() to bind it) is not
+	 * automatic matching and must happen even with drivers_autoprobe
+	 * off; matching is evaluated in __device_attach() under the device
+	 * lock.  Skipping the call entirely used to leave such devices
+	 * registered-but-unbound, and teardown then oopsed klist_removing
+	 * the never-attached knode_driver.
+	 */
+	__device_attach(dev, true, sp->drivers_autoprobe);
 
 	subsys_put(sp);
 }
-- 
2.34.1

