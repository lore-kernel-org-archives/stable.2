Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344644;
	b=MSyTBhCpPWHplq3GZLQVI772HN6EYnBAJNXMvjGZQW0KgsKNsPIcGKMPj+OrGl/Mnllr
	 JgyNL3UVSXxBurWAKlXvQ/qfVnnEUBq3LaTjZgfKs2cdiFVV0nCfjNILoNcRaFCdsetFS
	 kayKr2KTG3/NeURjpayf4ENxLT2NY1EeDbMubMMDdWcmFOpDUu4s6BNZaZT6aOaWv4ZcK
	 JSGiTSeMdEn1X6D2PgmdJablfLQl6tRRjUT8ZzzR/1IsUbBmhZsLthZ+Dc4sMIaj0hrBU
	 uZWo0PkV5BIJ32JqVXDP6KJYYvIbZv6ipU06Ydl2Z/ntj0WeD2PGOrOg73nSQxjYFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344644;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent;
	bh=AJaM8FShqYOfjiXuKYEbwlZHQ9kyAvg8ftbRyekTCCU=;
	b=XVp/AjTsKQP6k1eowG15mlqyedwgx7Tpisxaw/spjadq7gaLFhRMImstgrxnNhD9OJxL
	 IRRPXtC7Fzuf+hT2x69HHuuf052nmWK0w/ac48J4ZlSRlk93aBHSnWxtgu8MysLJhieh/
	 c3+TfjPLlbotENRsXE8fw/vhEgj89MbORhDyu3RtIPxBI3Ey/lVRKnK2XpXqRXYilDFGN
	 CVEAAnshSOh+6GXbFQAnkDHgOBCFe5k+YIuz5gGqztAlZPx9I7EOnqznn7FGbBfPyNGOn
	 +dUB35x8XiZYmv/pUU9OI6LoDeH2mLaq4EQkXrkiIGKVUSLII29IGgrw/nfN0/PwvZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hEg/9b3s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CF606A31C;
	Tue, 10 Nov 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEg/9b3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD0D1F0089F;
	Tue, 10 Nov 2026 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344643;
	bh=AJaM8FShqYOfjiXuKYEbwlZHQ9kyAvg8ftbRyekTCCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEg/9b3sd8epTX3sYG00r3EvzYWGbzw2bYMF9PfB3PNBHAZUQybBHaZWBoxpohSRe
	 CHGsYkxB2LwHUmI4xfS1F8yyYUGZZw/ifTsXZHcL94w+XBb4mnafYiwUvvsbnoft1M
	 ziraWFWM8xkoOojiXgHfcGHQBxWgx07tWBi8FNBiypfl9HZbisjitqi42EKTM2fhDf
	 INRISDC9paQ8mQurj3P5ZmXe4FxcfVgP1J3TXbzzzQ8hST2rP8rlPt1GVjcn++h/FK
	 VtOVevEXg6EupY0qMV65dc5de0OV7SvIaS8+SPwGka4P6z3P8TBJYSyqijfQtWrJly
	 cdLOc0ldX6DEg==
Received: by pali.im (Postfix)
	id 9FB295E0; Tue, 10 Nov 2026 22:03:59 +0100 (CET)
Date: Tue, 10 Nov 2026 22:03:59 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chad Aldreda <ca@modelmiser.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-smo8800: keep the state until the
 last file is closed
Message-ID: <20261110210359.upmeyc4b4xksfva2@pali>
References: <20261107204950.88952-2-ca@modelmiser.com>
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
Content-Disposition: inline
In-Reply-To: <20261107204950.88952-2-ca@modelmiser.com>
User-Agent: NeoMutt/20180716

Hello, I have not checked this patch too deeply, but I have feeling that
something is probably wrong if we need to add a new manual refcounter
around a whole device. Anyway, this freefall logic was originally copied
from the lis3lv02d.c driver, which now lives in the file:
linux/drivers/misc/lis3lv02d/lis3lv02d.c
So if in the freefall device of dell-smo8800.c is some error then
probably the same issue would be in the freefall device of lis3lv02d.c.

On Saturday 07 November 2026 20:49:58 Chad Aldreda wrote:
> struct smo8800_device is allocated with devm_kzalloc(), so it is freed
> when the driver is unbound, but a /dev/freefall file opened before the
> unbind still reaches it through file->private_data. release() then
> clears misc_opened in freed memory, and a read() blocked in
> wait_event_interruptible() is not woken by remove(). It sleeps on a wait
> queue inside the freed structure until a signal arrives, and then uses
> it. Unbinding the driver needs root. With KASAN, closing the file after
> an unbind gives a slab-use-after-free in smo8800_misc_release(), and a
> blocked reader interrupted after the unbind gives further reports in
> smo8800_misc_read() and prepare_to_wait_event().
> 
> Allocate the structure with kzalloc() and give it a kref. open() takes a
> reference and release() drops it. The device's own reference is dropped
> by a devm action, which runs after smo8800_remove() on unbind and when
> probe fails. misc_open() calls ->open with misc_mtx held and
> misc_deregister() takes misc_mtx, so the device reference is held
> whenever ->open runs. Once the misc device is deregistered, by remove()
> or by the probe error path, a removed flag is set and the wait queue
> woken. A read() blocked at that point returns -ENODEV unless an event
> arrived first, and a later read() returns -ENODEV.
> 
> The problem was found with a Coccinelle script that reports device nodes
> in devm memory [1]. The fix, the reproducer and this message were
> written with an AI assistant (Claude) and checked by hand. The fix was
> tested in QEMU, with KASAN enabled, using a test-only module that
> registers an "smo8800" platform device with a simulated interrupt, not
> on Dell hardware.
> 
> Link: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com [1]
> Fixes: 4738d8aabe89 ("platform: x86: dell-smo8800: Dell Latitude freefall driver (ACPI SMO8800/SMO8810)")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> ---
> The Coccinelle script reports a devm_k*() allocation when it, or an
> address inside it, is passed to misc_register(), cdev_add(),
> cdev_device_add(), video_register_device() or v4l2_device_register()
> in the same function, or when the allocated struct embeds one of those
> objects. It reports dell-smo8800 for the misc_register() of
> &smo8800->miscdev.
> 
> Reproduced in QEMU 10.2.4 (q35, KASAN, booted with kasan_multi_shot). A
> test-only module registers a platform device named "smo8800" with an
> interrupt from an irq_sim domain, so the driver binds without the ACPI
> device, and a module parameter raises the interrupt. A process opens
> /dev/freefall and the driver is unbound through sysfs. Without this
> patch:
> 
>   close after the unbind:                  1 KASAN report (release)
>   read() blocked across the unbind:        not woken; after a signal,
>                                            7 reports (read, wait queue,
>                                            release)
>   unbind, bind, then close the old file:   1 report
>   close before the unbind (control):       0
> 
> With it there are none: the blocked read() returns -ENODEV when the
> driver is unbound, a bind after the unbind works, and an interrupt
> still wakes a reader with a count. Not tested on Dell hardware.
> 
> An interrupt that arrives while remove() runs, between the reader's
> count check and its removed check, is dropped and the read returns
> -ENODEV. remove() frees the IRQ before setting removed, so no event can
> be lost after that.
> 
> kzalloc() rather than kzalloc_obj(), which first appears in v7.0: the
> patch then applies as is from v6.14. On v6.6 to v6.13 only the include
> hunk needs adjusting (those trees have no dell-smo8800-ids.h); v5.15 and
> v6.1 need a manual backport (remove() returns int there), and before
> v5.15 the driver was an ACPI driver.
> 
>  drivers/platform/x86/dell/dell-smo8800.c | 35 ++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
> index 8872f9b57fce..8880bf39f895 100644
> --- a/drivers/platform/x86/dell/dell-smo8800.c
> +++ b/drivers/platform/x86/dell/dell-smo8800.c
> @@ -13,9 +13,11 @@
>  #include <linux/fs.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include "dell-smo8800-ids.h"
>  
> @@ -26,8 +28,22 @@ struct smo8800_device {
>  	unsigned long misc_opened;   /* whether the device is open */
>  	wait_queue_head_t misc_wait; /* Wait queue for the misc dev */
>  	struct device *dev;          /* acpi device */
> +	struct kref kref;            /* device + open file */
> +	bool removed;                /* the device has been removed */
>  };
>  
> +static void smo8800_free(struct kref *kref)
> +{
> +	kfree(container_of(kref, struct smo8800_device, kref));
> +}
> +
> +static void smo8800_put(void *data)
> +{
> +	struct smo8800_device *smo8800 = data;
> +
> +	kref_put(&smo8800->kref, smo8800_free);
> +}
> +
>  static irqreturn_t smo8800_interrupt_quick(int irq, void *data)
>  {
>  	struct smo8800_device *smo8800 = data;
> @@ -60,11 +76,15 @@ static ssize_t smo8800_misc_read(struct file *file, char __user *buf,
>  
>  	atomic_set(&smo8800->counter, 0);
>  	retval = wait_event_interruptible(smo8800->misc_wait,
> -				(data = atomic_xchg(&smo8800->counter, 0)));
> +				(data = atomic_xchg(&smo8800->counter, 0)) ||
> +				READ_ONCE(smo8800->removed));
>  
>  	if (retval)
>  		return retval;
>  
> +	if (!data)
> +		return -ENODEV;
> +
>  	retval = 1;
>  
>  	byte_data = min_t(u32, data, 255);
> @@ -84,6 +104,7 @@ static int smo8800_misc_open(struct inode *inode, struct file *file)
>  		return -EBUSY; /* already open */
>  
>  	atomic_set(&smo8800->counter, 0);
> +	kref_get(&smo8800->kref);
>  	return 0;
>  }
>  
> @@ -93,6 +114,7 @@ static int smo8800_misc_release(struct inode *inode, struct file *file)
>  					 struct smo8800_device, miscdev);
>  
>  	clear_bit(0, &smo8800->misc_opened); /* release the device */
> +	smo8800_put(smo8800);
>  	return 0;
>  }
>  
> @@ -108,11 +130,16 @@ static int smo8800_probe(struct platform_device *device)
>  	int err;
>  	struct smo8800_device *smo8800;
>  
> -	smo8800 = devm_kzalloc(&device->dev, sizeof(*smo8800), GFP_KERNEL);
> +	/* An open file can outlive the device, so it holds a reference. */
> +	smo8800 = kzalloc(sizeof(*smo8800), GFP_KERNEL);
>  	if (!smo8800) {
>  		dev_err(&device->dev, "failed to allocate device data\n");
>  		return -ENOMEM;
>  	}
> +	kref_init(&smo8800->kref);
> +	err = devm_add_action_or_reset(&device->dev, smo8800_put, smo8800);
> +	if (err)
> +		return err;
>  
>  	smo8800->dev = &device->dev;
>  	smo8800->miscdev.minor = MISC_DYNAMIC_MINOR;
> @@ -151,6 +178,8 @@ static int smo8800_probe(struct platform_device *device)
>  
>  error:
>  	misc_deregister(&smo8800->miscdev);
> +	WRITE_ONCE(smo8800->removed, true);
> +	wake_up_interruptible(&smo8800->misc_wait);
>  	return err;
>  }
>  
> @@ -160,6 +189,8 @@ static void smo8800_remove(struct platform_device *device)
>  
>  	free_irq(smo8800->irq, smo8800);
>  	misc_deregister(&smo8800->miscdev);
> +	WRITE_ONCE(smo8800->removed, true);
> +	wake_up_interruptible(&smo8800->misc_wait);
>  	dev_dbg(&device->dev, "device /dev/freefall unregistered\n");
>  }
>  
> -- 
> 2.43.0
> 
> 
