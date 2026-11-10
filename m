Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315797;
	b=mk3KeHK6lNGVPh0XlmZOZS6dLA0kSuu8vLf4peSXNNoM+sFhdYvVsc1/K4D1GhK9ku+q
	 6mmbcDWFzny8f0rEoRc3FHbPNjGL39bzaGg/KHxVuLuHTN1nOvVvjJAtSe1WeTtc/gIFC
	 6wpAXyFOGENYJTVrnDyLdlATrN/xyf9MtTFWH59fWP6tkBY5l2QkDoo60v4/5ROKE3mMJ
	 5AQVNrHlJxBdIA8x8wXZVn3eoF+UwhRd1VM1i7kWLx2LBpYZVVjJ4f2oWhlB4LGZ6v1yJ
	 wZO3reP/TAuYjIh6fhjSHH71CoL7JytGI7jYGT306M4+hdYuK4+/TJc8DwV349sh9ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315797;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6pwwepmjTUl49OHZ5STOt5SUhTuA3dLbSUXmCL5j6f8=;
	b=PoEVLm864M/1wF7DzuJN9vx5RbxuZnyAe/I8lbiRnnmAeYyYmQPAVb8dKjelYWhXgZgH
	 DD7l9gekH4ziyLFD+WO+2z5is/WHN9UJpy+EU57rwhFd/I4vH4m2zXnn0wOSD8Snuw4io
	 4E/o8ct3vbe/VHIXQKNLZ3q+yH3WeZr3c87DXMM15tpMkhPT3VdvYPi6XenMpTcoCtN7t
	 nFkJx3Lwxy8BmtfOJu05m9HVqmWujC3Wh0BuEPH7Ck/T2GQNxZQmPTvQ7ENTgrNAFx0+w
	 bX6IgPwgFnQCMq1WiZwjTbo/gMm+LerDXA/ZJZyTO9H7wMPRWjFHcnGfJDXsI7BqzHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkHR4HPX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD262606A756
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkHR4HPX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A4F1F008A5
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315796;
	bh=6pwwepmjTUl49OHZ5STOt5SUhTuA3dLbSUXmCL5j6f8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TkHR4HPXdLeZWl4ob3lLsA7fxwi24Ky1wvxbr1Xi949bri+a+BESgcpFXw25/dM94
	 /7byIMt4yidx368FDyIHTDFd+1mrl46HyJSwqeea/T+3AaSAWVbnLIFLfz7jOM7zOX
	 46A/uajQB4CN3cL3zEw3PEMkzYSCCPxiPV52YpAytJ8DOrllAVL51WlFBrGx2KibDx
	 XZLeuNcBsoRurWJK9pJB0kt/7le3hEg6gc2GJ0QgCYSrV2rVR45CMk5yQEalkdsllB
	 xW3dhXRm0LJzavOW6myULhzzfAdM6vvRkX39w5YcO3MVEL1I5/NhdlgcWD6x/lBORq
	 Ifxm6/EHWRyNw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so1790246e87.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:03:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH6fVoiZdgyAdfcMKgh62TyJpfMmQ0K9Ck78C2NOY52mfvq0HqIbi8d3Uiha707siOVlktv80E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YANZtYF1gM2eK91Ne35thri1W6bffmVgjlxzYNLqCvaFro5jl
	ncKSarptue0onYuvomAkrvAisJ3CN6uMkda70LTGATly3FXcqKt59QWnLD+qDfcN8AT82lrKJLy
	W3qreQq+l9Cl2YRM1skpOjBxCNl0tXLI=
X-Received: by 2002:a05:6512:39d0:b0:5c0:160:6dae with SMTP id
 2adb3069b0e04-5c156e99541mr851697e87.24.1794315794795; Tue, 10 Nov 2026
 05:03:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108233900.4043941-3-ca@modelmiser.com>
In-Reply-To: <20261108233900.4043941-3-ca@modelmiser.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 14:03:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iBKOgYeTHYvrzAR=URQX+gpmpF-S0JSJwzkfYBqQHL6A@mail.gmail.com>
X-Gm-Features: AclHuK-54cehDMOrJTGpS_ib2FV9q8AklIT9qCi-8k6gpKsXn8vFETw18ma8yvk
Message-ID: <CAJZ5v0iBKOgYeTHYvrzAR=URQX+gpmpF-S0JSJwzkfYBqQHL6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: pfr_telemetry: keep the state until the last
 file is closed
To: Chad Aldreda <ca@modelmiser.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 12:39=E2=80=AFAM Chad Aldreda <ca@modelmiser.com> wr=
ote:
>
> struct pfrt_log_device is allocated with devm_kzalloc() and embeds the
> miscdevice, so it is freed when the driver unbinds. A file that is open
> on the node outlives the unbind and nothing holds a reference for it:
> the next ioctl() or mmap() on that file uses freed memory. Unbinding the
> driver needs root.
>
> Allocate the structure with kzalloc() and reference count it: open()
> takes a reference, under misc_mtx, which misc_deregister() also takes,
> release() drops it, and a devm action drops the driver's own. The
> structure also holds a reference on the parent device it uses. A call to
> ioctl() or mmap() that starts after remove() returns fails with -ENODEV;
> one already running finishes against state that is still valid.
>
> The problem was found with a Coccinelle script that reports device nodes
> in devm memory [1]. The fix, the reproducer and this message were
> written with an AI assistant (Claude) and checked by hand. The bug was
> reproduced and the fix tested in QEMU with KASAN, using an SSDT whose
> _DSM stands in for the firmware: ioctl() and mmap() worked before an
> unbind and, on a file held open across it, failed with -ENODEV. A call
> racing with the unbind was not tested, nor was hardware with this
> firmware interface.
>
> Link: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.co=
m [1]
> Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry=
 driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>

There is Sashiko's feedback on this:

https://sashiko.dev/#/patchset/20261108233900.4043941-3-ca%40modelmiser.com

please address.

> ---
> The Coccinelle script reports a devm_k*() allocation when it, or an
> address inside it, is passed to misc_register() or a similar
> registration function in the same function, or when the allocated struct
> embeds such an object. It reports this driver for the misc_register() of
> &pfrt_log_dev->miscdev.
>
> Reproduced in QEMU 10.2.4 (q35, KASAN, booted with kasan_multi_shot). An
> SSDT adds a device with _HID INTC1081 and a _DSM that returns valid
> packages, and memmap=3D reserves memory for the log buffer. A process
> opens /dev/acpi_pfr_telemetry0, uses SET_INFO, GET_INFO, GET_DATA_INFO
> and mmap(), and unbinds the driver through sysfs with the file open.
> Repeating those calls gives, without this patch, 15 KASAN reports in
> pfrt_log_ioctl(), set_pfrt_log_level() and get_pfrt_log_data_info().
>
> With it there are none. All the calls succeed before the unbind and
> return -ENODEV after it, a mapping made before the unbind was still
> readable after it, and the same sequence behaves the same after a bind.
> Unbinding with the file already closed, or never opened, gives no
> reports either.
>
> No lock is added. A call that passed the removed check can run during
> the unbind, against state and a parent device that are still valid; the
> driver has never serialized calls from different files. Mappings of
> the firmware log buffer outlive the unbind, as they did before.
>
> kzalloc() rather than kzalloc_obj(), which first appears in v7.0, for
> the stable trees.
>
>  drivers/acpi/pfr_telemetry.c | 55 +++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> index 2387376832a1..5ab8baabcc60 100644
> --- a/drivers/acpi/pfr_telemetry.c
> +++ b/drivers/acpi/pfr_telemetry.c
> @@ -15,10 +15,12 @@
>  #include <linux/errno.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/kref.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> @@ -62,6 +64,8 @@ struct pfrt_log_device {
>         struct pfrt_log_info info;
>         struct device *parent_dev;
>         struct miscdevice miscdev;
> +       struct kref kref;
> +       bool removed;
>  };
>
>  /* pfrt_guid is the parameter for _DSM method */
> @@ -247,6 +251,9 @@ static long pfrt_log_ioctl(struct file *file, unsigne=
d int cmd, unsigned long ar
>         void __user *p;
>         int ret =3D 0;
>
> +       if (READ_ONCE(pfrt_log_dev->removed))
> +               return -ENODEV;
> +
>         p =3D (void __user *)arg;
>
>         switch (cmd) {
> @@ -303,14 +310,17 @@ pfrt_log_mmap(struct file *file, struct vm_area_str=
uct *vma)
>         phys_addr_t base_addr;
>         int ret;
>
> +       pfrt_log_dev =3D to_pfrt_log_dev(file);
> +
> +       if (READ_ONCE(pfrt_log_dev->removed))
> +               return -ENODEV;
> +
>         if (vma->vm_flags & VM_WRITE)
>                 return -EROFS;
>
>         /* changing from read to write with mprotect is not allowed */
>         vm_flags_clear(vma, VM_MAYWRITE);
>
> -       pfrt_log_dev =3D to_pfrt_log_dev(file);
> -
>         ret =3D get_pfrt_log_data_info(&info, pfrt_log_dev);
>         if (ret)
>                 return ret;
> @@ -337,8 +347,39 @@ pfrt_log_mmap(struct file *file, struct vm_area_stru=
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
> @@ -349,6 +390,7 @@ static void acpi_pfrt_log_remove(struct platform_devi=
ce *pdev)
>         struct pfrt_log_device *pfrt_log_dev =3D platform_get_drvdata(pde=
v);
>
>         misc_deregister(&pfrt_log_dev->miscdev);
> +       WRITE_ONCE(pfrt_log_dev->removed, true);
>  }
>
>  static void pfrt_log_put_idx(void *data)
> @@ -373,10 +415,16 @@ static int acpi_pfrt_log_probe(struct platform_devi=
ce *pdev)
>                 return -ENODEV;
>         }
>
> -       pfrt_log_dev =3D devm_kzalloc(&pdev->dev, sizeof(*pfrt_log_dev), =
GFP_KERNEL);
> +       pfrt_log_dev =3D kzalloc(sizeof(*pfrt_log_dev), GFP_KERNEL);
>         if (!pfrt_log_dev)
>                 return -ENOMEM;
>
> +       kref_init(&pfrt_log_dev->kref);
> +       pfrt_log_dev->parent_dev =3D get_device(&pdev->dev);
> +       ret =3D devm_add_action_or_reset(&pdev->dev, pfrt_log_put, pfrt_l=
og_dev);
> +       if (ret)
> +               return ret;
> +
>         ret =3D ida_alloc(&pfrt_log_ida, GFP_KERNEL);
>         if (ret < 0)
>                 return ret;
> @@ -387,7 +435,6 @@ static int acpi_pfrt_log_probe(struct platform_device=
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
> 2.43.0
>
>
