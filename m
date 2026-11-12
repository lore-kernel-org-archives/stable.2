Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451409;
	b=gZAfzkUPg0f82BYDurfWEV6OxnVgbvUz+vbT0D0Z+HFn3hZJf6XIrCsQBw7VGOSJVyZv
	 5ouWFPU7/kFu9mEbautbaoGX+vK8UdZTrRA+wwOH522byehaC/v4EUgbMU/0DmX5EYW7q
	 gnefc6Tfp75qAEekJmtlDSkYFcJCUY/lfZ7Vb9hJ9ADE6E8WEJ2GQZyFKcDQmrutof4Az
	 8otsSM4ciz3zOztfC0EuoSRdV0OvIrjgyju5q7hZ1y4C6Hx8MqufYLL7q3n7/T7bmg93C
	 sWNX2EifFB75dpJe+at2+eVmFatImizn6HjlZY34PVIJnvt67zOVvpY4kqFaQyq51uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=EnKxfKMM75zbHlTd8AHjSG6CLtQjvzztcUz3K1JFb/I=;
	b=cv4xuHLy2PjzdTt8TmICgKwNuqxt9yGZxYlVfc3QPY7/Lfy4Lt215rd2u/wkUnFiYKBT
	 2vyPn7PHhsI+Jpt1eW22LcY+lN7Tb7Xj5YDefvnBZJGFq6dpvI2vT1n/sqvEmX+yh8iE5
	 dIqWSBNn8uJmYxu0kM8E5BONzrcm17A+ZabyJ2Ylb67uCRqhLfMtKS9ShLWh3CWkMkDoZ
	 IS1H89paoNLxuWCJa0OiSjL8KUbRlDaSl0ECjzdoW01MdyEd9msDqWD9eBiHMTCYk3/Xq
	 +hR3JiiMrkHwwoKRVs6/pHX8/EWkph4daH8ZFBYssmc0Jh+o7iMbkkER+/tj3JZSTpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Atd2G7HG;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB3606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBFB3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Atd2G7HG
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so6329741c88.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794451408; x=1795056208; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EnKxfKMM75zbHlTd8AHjSG6CLtQjvzztcUz3K1JFb/I=;
        b=Atd2G7HGc1dDm1yQQ9+xuk/PpSfMsuvDXIRfhf836OVm3a7dfl5vJVGJ4TWAebw8D3
         nSS7QWzsQ3GdyumATRR5Jlp9jrKQhT+2QiodpNg/Qz5GKJOPvo0bXZW2MMncw7UVkLDp
         sT2pRf9gZgBuadYimpW9F8l7TfG1AN6IQ9ThrmKr8pKgmCzZvG/t420sJCmAMAC3Vpku
         45zLlLLqEl+2YFDvLfFFDys3P/rqFeWWcvWMah4VQ+NQC/g81D7gMKTmYcjNTXkxpNqq
         IjI9az3ilKV3xofq4iq11J62RDc0Ycy/HoigOMBDceIvhDJehH1v9Mym6Xqx90ikGca2
         aCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794451408; x=1795056208;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EnKxfKMM75zbHlTd8AHjSG6CLtQjvzztcUz3K1JFb/I=;
        b=NrhwilrecJmW22liLCSweEPr2j3/Hxa/eakioylfuViFPv0RQyVbwJg8rkgx7fl4dD
         SNzGJjqjwubNODYznaEKmmjbazfgcLAwc4xk4tYCtOi1VXoJIDNjtx1oN9zuNxLSK0m3
         1ScSEywvjDFpavUXw3iHP+YKHpnqboyxTnB2XfVwr8zQTl95wMX5f40+ZcPMvAopCeL5
         oior0zt5MRBnpNtUHyxwnuogmC596PiPfwZOfDsYcoYWEGgMt2U3002RZ8t7fg2Br+nN
         AIHmOYkI3zUkUdUy4JXB8R/rrPeWAJ4RCTxc2VHAze91zmsqL+tt8atB2rzr5qV1xrod
         3eMg==
X-Forwarded-Encrypted: i=1; AL+hErHhB8wpdl9LVuUMQSty1bcWhpkfz08rifINwYuWw5c5y/K1Ldwg42k6OsGhRaTo6Q49XIRijzY=@vger.kernel.org
X-Gm-Message-State: APuU4Z933YdfX3Xi/h8f8YlRytDg015eIDD5zT4MDwPDrd/X5EtnMJwE
	uj2U5+OZsTjr5BzXMrdxiYqGlAHUK7f30WRWHtxn0aAn8MVe+64R5hFP
X-Gm-Gg: AYBFou3FUhlDNweCICZwwOfN6jGrWPrf0H7/kbLUDLjgcUyd5i0Og6EQmC1+SZX+bjd
	vB70O1kPEJq2q1rQIjm34b9V9IHfsGQ5o/VwvTzLA8orOhY2KiTh0Su2gL35FHfIzZ8w7wOPMGH
	vcBdk53PjcgIZUFQkAOkNbQa5pJ865fuoUAj75WYHs+7O2BK61Huck/i6m2y8nRb8FqGME2WLqR
	UeXwQFZpqXxU63X2/LghDtOTU4+brpSUchGdl9H/PHE/JPMpz7qslseu5Mwsy6B7SW01lelCTnF
	IZnSSbmfAyCjpJxeq+FsgRU29tRjnAHHf7hGr5UyoRSFoSOm2dGe/GaAg3O9t9adfLrE+4rdAAK
	ylCRJHGSNFRieHQbCZ++gDkra3L3yD672KibTMr5sHywd9W9bLzefRMj661EhL1waI//nqIE6UL
	nloIZ1XYvyI/XW2FtDVjqq9DXOeZ0PUjD3Fu3DesDBDDYLFaqkztbNu0nqFeR7b8Z4SVllw4QN1
	k8DSdA7SX6t/R3CuYFXbiFExafXVcWU/cBuvI9y5pRoVL1ZmgSRAeY9eESOPUQnDsJP52cETEIY
	56Bzd7AH/EFv6ygQpiTXlNZCLEcg0RYyDoEgRZwi7Vh2FplbJ3Uh1QCOlvymH0HYQuak
X-Received: by 2002:a05:7022:3c03:b0:195:76af:b810 with SMTP id a92af1059eb24-1b3c08751d4mr3095428c88.25.1794451407665;
        Wed, 11 Nov 2026 18:43:27 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm20259757eec.11.2026.11.11.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:43:26 -0800 (PST)
Date: Wed, 11 Nov 2026 18:43:26 -0800
Message-ID: <2f722967b6db0692d4dd4164aff39b62@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gideon Heinz <gideonheinz02@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes, rework, and cleanups
In-Reply-To: <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gideon,

On Thu, Nov 12, 2026 at 02:30:39AM +0100, Gideon Heinz wrote:
> Hi Dmitry,
>
> I tested v2 of the series on my G920 (046d:c262). Everything on my
> list works except one scenario that takes the whole machine down, with
> and without your series (last item).
...
>  - rmmod with fftest holding the device open: rmmod returned after
>    2.99 s with "Unloading HID++ force feedback" and nothing else in
>    dmesg. When I then exited fftest (entering -1), the machine went
>    down: the first time with a garbled panic screen that I couldn't
>    read, and on later attempts as a total hang with no output. The
>    same sequence on stock Arch 7.2.11-arch1-1 with the unpatched
>    driver also hangs the whole system, so this predates the series.
>
>    To reproduce: with the module loaded and the G920 plugged in, start
>    fftest on its event node and leave it at the effect prompt, run
>    "rmmod hid_logitech_hidpp" from another terminal, then enter -1 in
>    fftest.
>
>    I could not recover a trace yet and will send one if I manage to.
>
>    My guess, from reading the code and not verified by a trace:
>    hidpp_ff_create() stores hidpp_ff_destroy() and the other FF
>    callbacks in the ff_device as pointers into the module. With fftest
>    holding the evdev open, the input_dev outlives the driver, so when
>    fftest closes, the final input_dev release calls ff->destroy in
>    module code that rmmod has already freed.

Thank you very much for the thorough testing!

Your diagnosis is spot on. Opening /dev/input/eventX pins the evdev cdev
(and through it input_dev), but does not hold a module reference on the
underlying HID driver. When rmmod unloads hid_logitech_hidpp while fftest
still has the file descriptor open, __input_unregister_device() disconnects
evdev (flushing effects, closing the device, and marking evdev dead so all
subsequent ioctls and writes return -ENODEV) and runs ff->stop(), after
which rmmod frees the module text. When fftest finally exits and closes the
file descriptor, input_dev_release() calls input_ff_destroy(), which
invokes ff->destroy() pointing into the already-unmapped module text.

Rather than working around this in individual drivers with a separate
ff->stop() callback, input core should call input_ff_destroy() directly in
__input_unregister_device() once all handlers are disconnected and the
device is removed from sysfs. At that point nothing touches dev->ff
anymore, and calling input_ff_destroy() there guarantees ff->destroy()
always runs while the driver and its module are still loaded (while the
second input_ff_destroy() call in input_dev_release() becomes a no-op once
dev->ff is NULL).

Could you try the input core patch below (with patch 22/33 "HID:
logitech-hidpp: shut down G920 force feedback on input unregister" dropped
from the hid-logitech-hidpp series, since ff->stop is removed and
hidpp_ff_destroy() will now run on input unregistration)?

Alternatively, if you prefer to test with your out-of-tree module build
without rebuilding the kernel, you can test the equivalent effect by
setting:

	ff->destroy = NULL;

inside hidpp_ff_stop() in hid-logitech-hidpp.c.

Thanks.

---
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: destroy force-feedback device on input unregistration

When an input device is unregistered while userspace holds an open file
descriptor to its event node, input_dev_release() is deferred until the
last file descriptor is closed. Because input_ff_destroy() was only
called from input_dev_release(), force-feedback teardown (ff->destroy
and freeing ff->private) could run after the parent driver had already
unbound, freed its device state, or even been unloaded via rmmod,
causing use-after-free errors or page faults in unmapped module text.

Commit ef166ce08801 ("Input: stop force-feedback timer when
unregistering input devices") added a separate ff->stop callback for
ff-memless, but left ff->destroy invoked from input_dev_release().

Once __input_unregister_device() has disconnected all input handlers
(which flushes effects, closes the device, and marks evdev dead) and
deleted the device from sysfs, nothing accesses dev->ff anymore. Call
input_ff_destroy() directly in __input_unregister_device() so that
ff->destroy() always runs synchronously while the driver and its module
are still active, and remove the now-redundant ff->stop callback. Keep
input_ff_destroy() in input_dev_release() (where it is a no-op once
dev->ff is NULL) to handle input_free_device() on devices that were
never registered.

Fixes: 509ca1a93836 ("Input: implement new force feedback interface")
Cc: stable@vger.kernel.org
Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/ff-core.c    |  2 +-
 drivers/input/ff-memless.c | 23 -----------------------
 drivers/input/input.c      |  5 ++---
 include/linux/input.h      |  3 ---
 4 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 0e5d1d1ceb46..133b4622dc49 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(input_ff_create);
  *
  * This function is only needed in error path as input core will
  * automatically free force feedback structures when device is
- * destroyed.
+ * unregistered or destroyed.
  */
 void input_ff_destroy(struct input_dev *dev)
 {
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index d1fefd1dfc0d..3069436148ec 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -483,32 +483,10 @@ static void ml_ff_destroy(struct ff_device *ff)
 {
 	struct ml_device *ml = ff->private;
 
-	/*
-	 * The timer is normally shut down in ml_ff_stop() when the device
-	 * is unregistered. However, we still shut it down here as a safety
-	 * net and for cases where the device was never registered (e.g.
-	 * error paths during probe).
-	 */
 	timer_shutdown_sync(&ml->timer);
-
 	kfree(ml->private);
 }
 
-static void ml_ff_stop(struct ff_device *ff)
-{
-	struct ml_device *ml = ff->private;
-
-	/*
-	 * Even though we stop all playing effects when tearing down an
-	 * input device (by the way of evdev calling input_flush_device()
-	 * that calls into input_ff_flush() that stops and erases all
-	 * effects), we do not actually shutdown the timer, and therefore
-	 * we should do it here to prevent it firing after the input
-	 * device is unregistered and its associated resources are freed.
-	 */
-	timer_shutdown_sync(&ml->timer);
-}
-
 /**
  * input_ff_create_memless() - create memoryless force-feedback device
  * @dev: input device supporting force-feedback
@@ -543,7 +521,6 @@ int input_ff_create_memless(struct input_dev *dev, void *data,
 	ff->playback = ml_ff_playback;
 	ff->set_gain = ml_ff_set_gain;
 	ff->destroy = ml_ff_destroy;
-	ff->stop = ml_ff_stop;
 
 	/* we can emulate periodic effects with RUMBLE */
 	if (test_bit(FF_RUMBLE, ff->ffbit)) {
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 210635ef147e..7be69deed8eb 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2286,10 +2286,9 @@ static void __input_unregister_device(struct input_dev *dev)
 		input_wakeup_procfs_readers();
 	}
 
-	if (dev->ff && dev->ff->stop)
-		dev->ff->stop(dev->ff);
-
 	device_del(&dev->dev);
+
+	input_ff_destroy(dev);
 }
 
 static void devm_input_device_unregister(struct device *dev, void *res)
diff --git a/include/linux/input.h b/include/linux/input.h
index 3381608127f7..02047cc45d04 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -549,8 +549,6 @@ extern const struct class input_class;
  * @set_autocenter: Called to auto-center device
  * @destroy: called by input core when parent input device is being
  *	destroyed
- * @stop: called by input core when parent input device is being
- *	unregistered
  * @private: driver-specific data, will be freed automatically
  * @ffbit: bitmap of force feedback capabilities truly supported by
  *	device (not emulated like ones in input_dev->ffbit)
@@ -579,7 +577,6 @@ struct ff_device {
 	void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
 
 	void (*destroy)(struct ff_device *);
-	void (*stop)(struct ff_device *);
 
 	void *private;
 

-- 
Dmitry
