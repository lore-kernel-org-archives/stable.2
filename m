Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592754;
	b=02T5B/L8StGfO7QvxIZtBF8B9gaPyL+ASr4v3yqCNU5jvw0CxN/ssfCtmc9Ii3qtk536
	 OggJZUBUXjuVmCRDimLUr4dSnVtgUtJ4vWwdFtxC+cxLFneyk5IFBebgi8AwlQ9Q/LVRd
	 iehghYplBwcYEdRUDx+szLBRofDUg81i7q4xrQih5/2DnjfGrR9ZKdDTlmmgqYc7BCYou
	 f+3hKcSWhrDIbAvLdiB90pfw0aLNwcSt59twvA0jlRmEP1BOzpw41uNXU90lDze+WuPjJ
	 kcvin5VrMwcDHfYpMfXx4D6OdAardxMJWvY08tmIsTTlu19pjkyyk6HmU9wypGXNjrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592754;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pCh73/AankLvFfu279FREelHFGxRQOaIIEdv4L4ZOkQ=;
	b=fGjEPHxf7i0X3G/xiK74a4bITt92R29oIIVwG53SAY0lbAE4H4RIYn8I7vW5o2r/zVNc
	 bj0n5TNXuclTmmJ2PhWZmmXuMRPHmMFRIFvfGSDphYoi9q7bqpjD1GbWtoWfGiAM/S0z7
	 g1x0n47zkf7XmSrR/a8/KCGGdVcPG/B4Kx2TKy7dtZqbjzC2Kt8ilR1oNLvi1YKaSzVfd
	 icR6r4G7kaPU/XTMfF8jC+JXQjuH313ToZQrM7YCucjtgdnGDD7yqaNaPanyWAgbRdpyB
	 ex8reZ7KxifehvnkY4XPWaLbLVWYw3vBXAy3ezyeyC16/COMbsUwIoPlCstRLEcsTsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwttOTUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242A606A8AB
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwttOTUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA1A1F000C5
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592753;
	bh=pCh73/AankLvFfu279FREelHFGxRQOaIIEdv4L4ZOkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NwttOTUmck2eSDKuAQa9fTmq97RDDe5W+iNCmpE0PSESNJUqtR+WrRWL/WNXOASrO
	 mXzIdsZfa2i5C6MAs/+nc3u8f7xoGsEo9eqOruyH1EfQgzEenDPqL+b+11BhbHtgTY
	 E8M+F6KnA4Zw5dAc1Uv1fwEkSdDdfHjARyZWu5VphuC3ooootGUs+xKoKVeUsHirkH
	 B0aAqoLRXYVaBi3jaw3StcIclvEqSH1KDg3UooW0JUJ/LAoC+3x+arMArfX2bL2hDP
	 YHEw1O9UYeJ2oubZUIpd6hEi2EfkUYSMg+Smg6S4FHkTiAtPUqbu8VajoSwZMN76sn
	 Hd4NXjUAtwssQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ae1fd4252fso16072711fa.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE+3GYACxbpSqc7TXKRWiI5yJTt7gvackBpygLtq6hu/LpxlnkBzD1P/kIAi0kK1JtChnzjKew=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wS4O6lDGSIUr+H8dKbo3jCxA45WEk6dac123ve/Zuh6xo+ICj
	m/pUQ6gZglwGj9DGOrp7jAdam9j5FF7RAyqZVHkgDAf+AKoo/8PYfvFDgV77BOUENp7NlBuWu46
	m5vA1FSw5G6085WCpOCUcmjwuB5aJ8BY=
X-Received: by 2002:a05:651c:907:b0:3a9:811d:3a58 with SMTP id
 38308e7fff4ca-3ae2b4efe24mr10269581fa.14.1794592751829; Fri, 13 Nov 2026
 09:59:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110144436.1529000-2-ca@modelmiser.com>
In-Reply-To: <20261110144436.1529000-2-ca@modelmiser.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 18:58:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTHbr2KD3PXMdcOCs+QUrGrjGGuxOH7cbOe4kEF77d-A@mail.gmail.com>
X-Gm-Features: AclHuK8jaHGf-qx8UBko-VJj1ALkgDJ0YCbq_IA-4T8aFhwIIej3H6tkxEBgYDI
Message-ID: <CAJZ5v0jTHbr2KD3PXMdcOCs+QUrGrjGGuxOH7cbOe4kEF77d-A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pfr_telemetry: keep the state until the last
 file is closed
To: Chad Aldreda <ca@modelmiser.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 3:44=E2=80=AFPM Chad Aldreda <ca@modelmiser.com> wr=
ote:
>
> struct pfrt_log_device is allocated with devm_kzalloc_obj() and embeds
> the miscdevice, so it is freed when the driver unbinds. A file that is
> open on the node outlives the unbind and nothing holds a reference for
> it: the next ioctl() or mmap() on that file uses freed memory.
> Unbinding the driver needs root.
>
> Allocate the structure with kzalloc_obj() and reference count it:
> open() takes a reference, under misc_mtx, which misc_deregister() also
> takes, release() drops it, and a devm action drops the driver's own.
> The structure also holds a reference on the parent device it uses.
>
> Also make remove() wait for calls already running. The firmware calls
> in ioctl() and mmap() run under a mutex, and remove() sets a flag under
> it that makes any later call that would reach the firmware fail with
> -ENODEV. Without that, a call that started before remove() can
> evaluate _DSM after remove() has returned, while device_del() unbinds
> the parent's ACPI companion. The mutex also serializes the updates to
> the log settings, which concurrent ioctl() calls could interleave.
> ioctl() copies to and from user memory outside the lock, because mmap()
> is called with mmap_lock held.
>
> The problem was found with a Coccinelle script that reports device
> nodes in devm memory [1]. The fix, the reproducers and this message
> were written with an AI assistant (Claude) and checked by hand. The bug
> was reproduced and the fix tested in QEMU with KASAN and lockdep, using
> an SSDT whose _DSM stands in for the firmware. Hardware with this
> firmware interface was not tested.
>
> Link: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.co=
m [1]
> Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry=
 driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> ---
> Changes in v2:
> - remove() now waits for calls already running, under a new mutex, which
>   also serializes the log settings. Sashiko's review of v1, which Rafael
>   asked me to address, showed that a call that passed the removed check
>   can evaluate _DSM after remove() returns, while device_del() unbinds
>   the ACPI companion. The v1 notes said such a call finishes against
>   state that is still valid; that was wrong.
> - kzalloc_obj(), on top of the devm_kzalloc_obj() conversion in
>   linux-pm.
> v1: https://lore.kernel.org/r/20261108233900.4043941-3-ca@modelmiser.com
>
> Tested in QEMU 10.2.4 (q35, KASAN with kasan_multi_shot, lockdep) with
> the SSDT from v1, which adds a device with _HID INTC1081 and a _DSM that
> returns valid packages. With a file held open across a sysfs unbind,
> SET_INFO, GET_INFO, GET_DATA_INFO and mmap() all work before the unbind
> and fail with -ENODEV after it, a mapping made before the unbind stays
> readable, the same holds after a bind, and there are no KASAN or lockdep
> reports.
>
> For the race, a test-only msleep(2000) was put before the SET_INFO
> firmware call and the driver unbound 0.5 s into the call. With v1 the
> unbind returned at once and the firmware call completed 1.5 s after
> remove() returned. With v2 the unbind returned 2.0 s in, after the call
> completed. The test used a sysfs unbind, which keeps the ACPI companion
> bound; removal of the device itself was not tested.
>
> A test variant that calls copy_to_user() inside the lock makes lockdep
> report a cycle between the new lock, taken in pfrt_log_mmap(), and
> mmap_lock, which is why the user copies stay outside it.
>
> Mainline and stable still allocate with devm_kzalloc(), so a backport
> needs kzalloc(sizeof(*pfrt_log_dev), GFP_KERNEL) in that hunk.
>
> The same race exists in pfr_update; a matching patch on top of the one
> you applied will follow once that is in your tree.
>
> The code, changelog and reproducers were written with an AI assistant
> (Claude Opus 5.5), and the assistant ran the tests above. I ran the
> final version myself and got the same results.
>
>  drivers/acpi/pfr_telemetry.c | 102 +++++++++++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> index 458cb99ae216..53d5e25497e9 100644
> --- a/drivers/acpi/pfr_telemetry.c
> +++ b/drivers/acpi/pfr_telemetry.c
> @@ -15,10 +15,13 @@
>  #include <linux/errno.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/kref.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/mm.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> @@ -62,6 +65,14 @@ struct pfrt_log_device {
>         struct pfrt_log_info info;
>         struct device *parent_dev;
>         struct miscdevice miscdev;
> +       struct kref kref;
> +       /*
> +        * Serializes the firmware calls and info of the file operations,=
 and
> +        * remove(), which sets removed under it and so waits for calls
> +        * already running.
> +        */
> +       struct mutex lock;
> +       bool removed;
>  };
>
>  /* pfrt_guid is the parameter for _DSM method */
> @@ -254,33 +265,49 @@ static long pfrt_log_ioctl(struct file *file, unsig=
ned int cmd, unsigned long ar
>                 if (copy_from_user(&info, p, sizeof(info)))
>                         return -EFAULT;
>
> -               if (valid_log_revid(info.log_revid))
> -                       pfrt_log_dev->info.log_revid =3D info.log_revid;
> +               scoped_guard(mutex, &pfrt_log_dev->lock) {
> +                       if (pfrt_log_dev->removed)
> +                               return -ENODEV;
>
> -               if (valid_log_level(info.log_level)) {
> -                       ret =3D set_pfrt_log_level(info.log_level, pfrt_l=
og_dev);
> -                       if (ret < 0)
> -                               return ret;
> +                       if (valid_log_revid(info.log_revid))
> +                               pfrt_log_dev->info.log_revid =3D info.log=
_revid;
>
> -                       pfrt_log_dev->info.log_level =3D info.log_level;
> -               }
> +                       if (valid_log_level(info.log_level)) {
> +                               ret =3D set_pfrt_log_level(info.log_level=
, pfrt_log_dev);
> +                               if (ret < 0)
> +                                       return ret;
> +
> +                               pfrt_log_dev->info.log_level =3D info.log=
_level;
> +                       }
>
> -               if (valid_log_type(info.log_type))
> -                       pfrt_log_dev->info.log_type =3D info.log_type;
> +                       if (valid_log_type(info.log_type))
> +                               pfrt_log_dev->info.log_type =3D info.log_=
type;
> +               }
>
>                 return 0;
>
>         case PFRT_LOG_IOC_GET_INFO:
> -               info.log_level =3D get_pfrt_log_level(pfrt_log_dev);
> -               info.log_type =3D pfrt_log_dev->info.log_type;
> -               info.log_revid =3D pfrt_log_dev->info.log_revid;
> +               scoped_guard(mutex, &pfrt_log_dev->lock) {
> +                       if (pfrt_log_dev->removed)
> +                               return -ENODEV;
> +
> +                       info.log_level =3D get_pfrt_log_level(pfrt_log_de=
v);
> +                       info.log_type =3D pfrt_log_dev->info.log_type;
> +                       info.log_revid =3D pfrt_log_dev->info.log_revid;
> +               }
> +
>                 if (copy_to_user(p, &info, sizeof(info)))
>                         return -EFAULT;
>
>                 return 0;
>
>         case PFRT_LOG_IOC_GET_DATA_INFO:
> -               ret =3D get_pfrt_log_data_info(&data_info, pfrt_log_dev);
> +               scoped_guard(mutex, &pfrt_log_dev->lock) {
> +                       if (pfrt_log_dev->removed)
> +                               return -ENODEV;
> +
> +                       ret =3D get_pfrt_log_data_info(&data_info, pfrt_l=
og_dev);
> +               }
>                 if (ret)
>                         return ret;
>
> @@ -311,6 +338,10 @@ pfrt_log_mmap(struct file *file, struct vm_area_stru=
ct *vma)
>
>         pfrt_log_dev =3D to_pfrt_log_dev(file);
>
> +       guard(mutex)(&pfrt_log_dev->lock);
> +       if (pfrt_log_dev->removed)
> +               return -ENODEV;
> +
>         ret =3D get_pfrt_log_data_info(&info, pfrt_log_dev);
>         if (ret)
>                 return ret;
> @@ -337,8 +368,39 @@ pfrt_log_mmap(struct file *file, struct vm_area_stru=
ct *vma)
>         return 0;
>  }
>
> +static void pfrt_log_free(struct kref *kref)
> +{
> +       struct pfrt_log_device *pfrt_log_dev =3D
> +               container_of(kref, struct pfrt_log_device, kref);
> +
> +       put_device(pfrt_log_dev->parent_dev);
> +       kfree(pfrt_log_dev);
> +}
> +
> +static void pfrt_log_put(void *data)
> +{
> +       struct pfrt_log_device *pfrt_log_dev =3D data;
> +
> +       kref_put(&pfrt_log_dev->kref, pfrt_log_free);
> +}
> +
> +/* misc_open() holds misc_mtx here, and misc_deregister() takes it. */
> +static int pfrt_log_open(struct inode *inode, struct file *file)
> +{
> +       kref_get(&to_pfrt_log_dev(file)->kref);
> +       return 0;
> +}
> +
> +static int pfrt_log_release(struct inode *inode, struct file *file)
> +{
> +       pfrt_log_put(to_pfrt_log_dev(file));
> +       return 0;
> +}
> +
>  static const struct file_operations acpi_pfrt_log_fops =3D {
>         .owner          =3D THIS_MODULE,
> +       .open           =3D pfrt_log_open,
> +       .release        =3D pfrt_log_release,
>         .mmap           =3D pfrt_log_mmap,
>         .unlocked_ioctl =3D pfrt_log_ioctl,
>         .llseek         =3D noop_llseek,
> @@ -349,6 +411,8 @@ static void acpi_pfrt_log_remove(struct platform_devi=
ce *pdev)
>         struct pfrt_log_device *pfrt_log_dev =3D platform_get_drvdata(pde=
v);
>
>         misc_deregister(&pfrt_log_dev->miscdev);
> +       scoped_guard(mutex, &pfrt_log_dev->lock)
> +               pfrt_log_dev->removed =3D true;
>  }
>
>  static void pfrt_log_put_idx(void *data)
> @@ -373,10 +437,17 @@ static int acpi_pfrt_log_probe(struct platform_devi=
ce *pdev)
>                 return -ENODEV;
>         }
>
> -       pfrt_log_dev =3D devm_kzalloc_obj(&pdev->dev, *pfrt_log_dev);
> +       pfrt_log_dev =3D kzalloc_obj(*pfrt_log_dev);
>         if (!pfrt_log_dev)
>                 return -ENOMEM;
>
> +       kref_init(&pfrt_log_dev->kref);
> +       mutex_init(&pfrt_log_dev->lock);
> +       pfrt_log_dev->parent_dev =3D get_device(&pdev->dev);
> +       ret =3D devm_add_action_or_reset(&pdev->dev, pfrt_log_put, pfrt_l=
og_dev);
> +       if (ret)
> +               return ret;
> +
>         ret =3D ida_alloc(&pfrt_log_ida, GFP_KERNEL);
>         if (ret < 0)
>                 return ret;
> @@ -387,7 +458,6 @@ static int acpi_pfrt_log_probe(struct platform_device=
 *pdev)
>                 return ret;
>
>         pfrt_log_dev->info.log_revid =3D PFRT_DEFAULT_REV_ID;
> -       pfrt_log_dev->parent_dev =3D &pdev->dev;
>
>         pfrt_log_dev->miscdev.minor =3D MISC_DYNAMIC_MINOR;
>         pfrt_log_dev->miscdev.name =3D devm_kasprintf(&pdev->dev, GFP_KER=
NEL,
> --

Applied as 7.5 material, thanks!
