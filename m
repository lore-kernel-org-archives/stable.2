Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3614CE677
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770373; cv=none; b=lQD/RT2FnIE3b95uxVDbYIssYvVRqHyH/l/0vRx4h40Tm1iPkosLHI+0xlfCRo7r6UNlfOs56P9f7Z2ghcKM/YpbhGj/IM7GXtYW4xskCM82zJGf6vamh+LgNtfF8zkO1UXk2lS+gNarkdG/wMIeduf06/zF6Q48snQOkAhIMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770373; c=relaxed/simple;
	bh=kmsRXEkPa63NKWplHhHbqQFtCM0iDb0zKHYfUp0DrdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDPp1QDnKXNqSy8DI33gj2Doh+yP/tvcdmDps00Fo6Hs2o3YBS9dX+sua4srGpV1AKWcKTws9RsipJHgIz70rD5wI72u7fs8aPB0alKj4YNNcGzhAYelzWeDJUFHVbW0NkUAAUYxsfcvtPiL6KW5ewWODWvswAta6YvIWFXvd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=iUSIEwKz; arc=none smtp.client-ip=62.149.156.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="iUSIEwKz"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id Bt83xwntuxUh5Bt83xVwqA; Wed, 30 Sep 2026 14:09:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790770183; bh=kmsRXEkPa63NKWplHhHbqQFtCM0iDb0zKHYfUp0DrdU=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=iUSIEwKzI4O7IuwZPIrqB8YXoH1Y4RTrIGDclZqsCJEmiUThnUu6AJ8FMMKoNdwa7
	 X4K9bhphN89sKFEo5zlWAxqAoUhvpUi7BWqkfsp5c9UCWqYB1N+RvOc91AF0cy4DtF
	 1oRyfHMUyHYnZRIJ2iW9NNzTZo7fYkLqODd7PyL+AimrB8ZQfJlyqWngrzrUhewNLh
	 9Xiipxqtp5CdiD8OLQxW9OZs8skYSEiA9i8Gbq526Z3jP5F+tF94RR3YZCoisTjmL0
	 uqcH5xymfGcjsy17OW8MvlEMyFnZBYg+2IFhiACYoaOobqMVL3P1OOedscyQzkcvqT
	 Iix12rpmd6szw==
Message-ID: <c0eb3082-62f6-4864-81fd-ed5b799909ef@enneenne.com>
Date: Wed, 30 Sep 2026 14:09:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pps: generators: don't use the driver's info after
 unregister
Content-Language: en-US
To: Danish Khateeb <danishkhateeb03@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Calvin Owens <calvin@wbinvd.org>, Yibo Tan <lhfff@tju.edu.cn>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260929124937.51114-1-danishkhateeb03@gmail.com>
 <20260929124937.51114-3-danishkhateeb03@gmail.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260929124937.51114-3-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBtuFnGS2ef9J/I9aWTwCUbItK1sZ23nm9jc4/R1bRgRT8neY9c64R5mUQ/MPbUWREz3A7uqX24LJANLoMC49IFroagQG/Oz2ld6XmDsJBIe7DAFATun
 H1+WE+MKV4sv0Q9850Ki8LpZ3uvupKLxzHNvmWs0JjcCnZYXrW19K3eu4ViWoQaVsPXt3qL7+hyrfCjb+rXXR/9iqjhMVtv+daIPhRNJfCzH/Q2VJFAtN/Sx
 Bu/C1YUI5XyxyC7vWTE5zVk8HD0V5TfV/CWKtqXApKZsv1LVtGPGtDHGDALL1y2OkzoDCNdgliGdeeckB9GG9/1V2om45ErzlcP0bW51pthMMncEQZ2/PmIk
 lDGhy/t+XxpD/R9q5hrxNyWv3PQ5tnn8cX8/BoYQvsPANdPu6EKo/zBaUaHLGiELEN+6kaSx

On Tue, 29 Sep 2026 07:49:35 -0500, Danish Khateeb wrote:
> A file that was opened before pps_gen_unregister_source() keeps
> pps_gen, and with it the pointer to the driver's pps_gen_source_info.
> PPS_GEN_SETENABLE and PPS_GEN_USESYSTEMCLOCK keep using that pointer
> after the driver has gone:
>
>  - pps_gen_tio allocates its info with devm_kzalloc(), so after an
>    unbind both ioctls read freed memory, and SETENABLE calls the
>    driver's enable() with its freed private data.
>
>  - pps_gen-dummy does not set info->owner, so it can be unloaded while
>    the file is open, and the ioctls then read the unloaded module's
>    data and call its code.
>
> TIO can't probe in a VM, as it needs ART. A test driver that registers
> its info in devm memory like TIO does, unbound while /dev/pps-gen0 is
> open, gives:
>
>   BUG: KASAN: slab-use-after-free in pps_gen_cdev_ioctl+0x4c1/0x580
>   Read of size 1 at addr ffff88800e647f38 by task ppsgen64/145
>   ...
>   Freed by task 146:
>    kfree+0x25a/0x6d0
>    release_nodes+0xd1/0x140
>    devres_release_all+0x10e/0x1a0
>    device_unbind_cleanup+0x71/0x250
>    device_release_driver_internal+0x41b/0x570
>    unbind_store+0xd9/0x100
>
> and unloading pps_gen-dummy while its file is open oopses:
>
>   BUG: unable to handle page fault for address: ffffffffa0203040
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:pps_gen_cdev_ioctl+0x372/0x580
>
> Protect info in the ioctl handler with a mutex, and clear it under the
> mutex on unregister, so that unregister waits for the ioctls using it
> and later ones fail with -ENODEV. PPS_KC_BIND does the same for a
> removed PPS device since commit 3649f9a6b897 ("pps: don't allow
> PPS_KC_BIND on removed devices"). The sysfs attributes need nothing
> new: they are removed, and their callbacks drained, before info is
> cleared.
>
> Fixes: 86b525bed275 ("drivers pps: add PPS generators support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
>
> Notes:
>     Tested in the same setup, with patch 1/4 applied. After an unbind, and
>     after unloading pps_gen-dummy with its file open, both ioctls return
>     -ENODEV with no KASAN report, and closing the file is clean. Normal use
>     of pps_gen-dummy is unchanged.
>
>  drivers/pps/generators/pps_gen.c | 31 ++++++++++++++++++++++++++-----
>  include/linux/pps_gen_kernel.h   |  2 ++
>  2 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
> index 059f4fe6c9b4..d80e28dc31dc 100644
> --- a/drivers/pps/generators/pps_gen.c
> +++ b/drivers/pps/generators/pps_gen.c
> @@ -69,17 +69,28 @@ static long pps_gen_cdev_ioctl(struct file *file,
>  		if (ret)
>  			return -EFAULT;
>  
> -		ret = pps_gen->info->enable(pps_gen, status);
> -		if (ret)
> -			return ret;
> -		pps_gen->enabled = status;
> +		scoped_guard(mutex, &pps_gen->info_lock) {
> +			if (!pps_gen->info)
> +				return -ENODEV;
> +
> +			ret = pps_gen->info->enable(pps_gen, status);
> +			if (ret)
> +				return ret;
> +			pps_gen->enabled = status;
> +		}
>  
>  		break;
>  
>  	case PPS_GEN_USESYSTEMCLOCK:
>  		dev_dbg(&pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
>  
> -		ret = put_user(pps_gen->info->use_system_clock, uiuarg);
> +		scoped_guard(mutex, &pps_gen->info_lock) {
> +			if (!pps_gen->info)
> +				return -ENODEV;
> +			status = pps_gen->info->use_system_clock;
> +		}
> +
> +		ret = put_user(status, uiuarg);
>  		if (ret)
>  			return -EFAULT;
>  
> @@ -212,6 +223,15 @@ static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
>  {
>  	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
>  	cdev_device_del(&pps_gen->cdev, &pps_gen->dev);
> +
> +	/*
> +	 * An open file keeps pps_gen around, but the driver may free info as
> +	 * soon as we return. The sysfs files are gone now, so wait for the
> +	 * ioctls using info and make later ones fail.
> +	 */
> +	scoped_guard(mutex, &pps_gen->info_lock)
> +		pps_gen->info = NULL;
> +
>  	put_device(&pps_gen->dev);
>  }
>  
> @@ -243,6 +263,7 @@ struct pps_gen_device *pps_gen_register_source(const struct pps_gen_source_info
>  	pps_gen->info = info;
>  	pps_gen->enabled = false;
>  
> +	mutex_init(&pps_gen->info_lock);
>  	init_waitqueue_head(&pps_gen->queue);
>  	spin_lock_init(&pps_gen->lock);
>  
> diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
> index f26f6aac000d..c4d22b1af118 100644
> --- a/include/linux/pps_gen_kernel.h
> +++ b/include/linux/pps_gen_kernel.h
> @@ -11,6 +11,7 @@
>  #include <linux/pps_gen.h>
>  #include <linux/cdev.h>
>  #include <linux/device.h>
> +#include <linux/mutex.h>
>  
>  /*
>   * Global defines
> @@ -44,6 +45,7 @@ struct pps_gen_source_info {
>  /* The main struct */
>  struct pps_gen_device {
>  	const struct pps_gen_source_info *info;	/* PSS generator info */
> +	struct mutex info_lock;			/* protects info */
>  	bool enabled;				/* PSS generator status */
>  
>  	unsigned int event;

Acked-by: Rodolfo Giometti <giometti@enneenne.com>
