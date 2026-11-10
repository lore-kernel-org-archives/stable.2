Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316468;
	b=TyVy2470WvzrJEsR5l+h9g4aYU796FfKcNRBwwZfF0BApMt3IMhaT1iTjZO7gLHFpvtd
	 2JoBAVDjHJ+x2YCoZKBrG2PW7E+Q9eLmavUGxWvSjhgSWccerVmV7XUrJM5BGT6OQ0Oto
	 69ITofYkgFE413ro+6e+2KPE1bShiW0/0fN5SLmO9xLUnGPnc5oVZgUGi2w5W7Wm2E6cD
	 LR4LhUdJtyvEWkCMhqCanPtAur+0nkjuBZQY66s+kdGVC9Rc9K1dzzlj2MrLBPnhonHep
	 YwpZwh7hK9oZAn1RnALzcGnFv6WImFvzBdb+4NSwBAekLF/Bj7L3PeP8bGjZA3Ynr6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316468;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E0D4lFouC3sbFRgg4Jcn0sQ9USf0uYoRvw06StM8D7o=;
	b=X8eJeF1IQhKdiT4Z70YhyipUD5k5jQw1FqvtnPTx93ziOEs+hAVf0rxzrafoIuOyPTJj
	 +oOklvBtRjzbWe97qZ8blw6DrBloEj9Fh22cPgRSJLKKs6CV43pbt/NGzWEAUGT05+bTC
	 TCQ2sBaM7X21YoJwXKYC+8iFxAAQzl6vYBHc3DZGe+W8WDPY97H/0ncejbEyly4IOM9Dd
	 pD9Bcq/HiStVpZQe88Jrdemw5lGv6eW8Ex43gmwEfWM8jJ4rMVwnDVEkoKErVYH6+meRX
	 7LSQk7Szldo9p96ybu0rsELAUwtHqYs2ya9AnHk+iaBiYLEhbGTGGfrH5Dtk6C7yRGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUCaOs2u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC315606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUCaOs2u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1421F008A2
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316467;
	bh=E0D4lFouC3sbFRgg4Jcn0sQ9USf0uYoRvw06StM8D7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gUCaOs2uTZ+8NNoMmWNAXXqfiYfiRBbfi9D9aYLUWjiT+uHC37Bb6k4/cOe5g75VB
	 wvIk0AbW5hJwBc4dNx1oVUKaRsSpm46cl0R2Pr5/0oYQ6ig5/BAGwLJUqGhND+yo9o
	 GmeFEOk9r81oT0zZo1P8+/vBW4QS71oE5qmIwmGZwB4hRAOZlKpADBu+9xQuURs9fA
	 NaNASNvBqZ6ZGqTBfs9G5+sFu+8t/mhMRXMI8uxDQA3klxjx3Z4q/kbGMMkuSAhgc+
	 539GiimSRZdyJG+YBkgW5mCobpPfAuF0i7lQBslR/h4pfzL0bZ2+NIV7N4JnIKrQKr
	 dgFwPyAuiN62Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c08539c827so1418698e87.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:14:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFBuKqAV6Vun4nbIjUclmO9UT3hVtsRMbT8f1SEsO5ZMr2iPK1fItiOb3nGuXaVYsr4HoN09CQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oOp64IBenbscA2luzI2zU4JXJgfcaZ90AKPMP1OFk5qCFPCTU
	8dt5JYzdlQVoRAgy3PekcMshy4TmdxgKKQY+nxfAF4HbcXhaUnIAZ9zd6QSnZ0++iOpYB+W74m6
	Tzwxpw37AxiykCbbxouxhHOrg2SlCWqQ=
X-Received: by 2002:a05:6512:3088:b0:5c0:bcb:bcf9 with SMTP id
 2adb3069b0e04-5c156ebc96emr867357e87.50.1794316466194; Tue, 10 Nov 2026
 05:14:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108233900.4043941-3-ca@modelmiser.com> <20261108233900.4043941-4-ca@modelmiser.com>
In-Reply-To: <20261108233900.4043941-4-ca@modelmiser.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 14:14:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-kc0qdgYncJUSqhw7w-Y7svxnqChSGP8StGaAckw7Tg@mail.gmail.com>
X-Gm-Features: AclHuK-J0IQKxSqxYpSdieCIBbY4_MtW6eSRdRbeP0hbidLlG4SKGNr3oYXizWk
Message-ID: <CAJZ5v0h-kc0qdgYncJUSqhw7w-Y7svxnqChSGP8StGaAckw7Tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: pfr_update: keep the state until the last file
 is closed
To: Chad Aldreda <ca@modelmiser.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 12:39=E2=80=AFAM Chad Aldreda <ca@modelmiser.com> wr=
ote:
>
> struct pfru_device is allocated with devm_kzalloc() and embeds the
> miscdevice, so it is freed when the driver unbinds. A file that is open
> on the node outlives the unbind and nothing holds a reference for it:
> the next ioctl() or write() on that file uses freed memory. Unbinding
> the driver needs root.
>
> Allocate the structure with kzalloc() and reference count it: open()
> takes a reference, under misc_mtx, which misc_deregister() also takes,
> release() drops it, and a devm action drops the driver's own. The
> structure also holds a reference on the parent device it uses. A call to
> ioctl() or write() that starts after remove() returns fails with
> -ENODEV; one already running finishes against state that is still valid.
>
> The problem was found with a Coccinelle script that reports device nodes
> in devm memory [1]. The fix, the reproducer and this message were
> written with an AI assistant (Claude) and checked by hand. The bug was
> reproduced and the fix tested in QEMU with KASAN, using an SSDT whose
> _DSM stands in for the firmware: ioctl() and write() worked before an
> unbind and, on a file held open across it, failed with -ENODEV. A call
> racing with the unbind was not tested, nor was hardware with this
> firmware interface.
>
> Link: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.co=
m [1]
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update de=
vice driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> ---
> The same Coccinelle script reports this driver for the misc_register()
> of &pfru_dev->miscdev.
>
> Reproduced in QEMU 10.2.4 (q35, KASAN, booted with kasan_multi_shot). An
> SSDT adds a device with _HID INTC1080 and a _DSM that returns valid
> packages, and memmap=3D reserves the communication buffer. A process open=
s
> /dev/acpi_pfr_update0, uses QUERY_CAP, SET_REV, write() of a minimal
> capsule and STAGE, and unbinds the driver through sysfs with the file
> open. Repeating those calls gives, without this patch, 9 KASAN reports
> in pfru_ioctl(), query_capability(), pfru_write() and start_update().
>
> With it there are none. All the calls succeed before the unbind and
> return -ENODEV after it, and the same sequence behaves the same after a
> bind. Unbinding with the file already closed, or never opened, gives no
> reports either. ACTIVATE and STAGE_ACTIVATE were not run; they share
> start_update() with STAGE.
>
> No lock is added. A call that passed the removed check can run during
> the unbind, against state and a parent device that are still valid; the
> driver has never serialized calls from different files. An rwsem would
> make the unbind wait for a firmware update to finish.
>
> kzalloc() rather than kzalloc_obj(), which first appears in v7.0, for
> the stable trees.
>
>  drivers/acpi/pfr_update.c | 51 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 98ace679601b..b9e4c1065ad5 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -16,9 +16,11 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
> +#include <linux/kref.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> @@ -82,6 +84,8 @@ struct pfru_device {
>         u32 rev_id, index;
>         struct device *parent_dev;
>         struct miscdevice miscdev;
> +       struct kref kref;
> +       bool removed;
>  };
>
>  static DEFINE_IDA(pfru_ida);
> @@ -428,6 +432,9 @@ static long pfru_ioctl(struct file *file, unsigned in=
t cmd, unsigned long arg)
>         u32 rev;
>         int ret;
>
> +       if (READ_ONCE(pfru_dev->removed))
> +               return -ENODEV;
> +
>         switch (cmd) {
>         case PFRU_IOC_QUERY_CAP:
>                 ret =3D query_capability(&cap_hdr, pfru_dev);
> @@ -476,6 +483,9 @@ static ssize_t pfru_write(struct file *file, const ch=
ar __user *buf,
>         char *buf_ptr;
>         int ret;
>
> +       if (READ_ONCE(pfru_dev->removed))
> +               return -ENODEV;
> +
>         ret =3D query_buffer(&buf_info, pfru_dev);
>         if (ret)
>                 return ret;
> @@ -518,8 +528,39 @@ static ssize_t pfru_write(struct file *file, const c=
har __user *buf,
>         return ret ?: len;
>  }
>
> +static void pfru_free(struct kref *kref)
> +{
> +       struct pfru_device *pfru_dev =3D
> +               container_of(kref, struct pfru_device, kref);
> +
> +       put_device(pfru_dev->parent_dev);
> +       kfree(pfru_dev);
> +}
> +
> +static void pfru_put(void *data)
> +{
> +       struct pfru_device *pfru_dev =3D data;
> +
> +       kref_put(&pfru_dev->kref, pfru_free);
> +}
> +
> +/* misc_open() holds misc_mtx here, and misc_deregister() takes it. */
> +static int pfru_open(struct inode *inode, struct file *file)
> +{
> +       kref_get(&to_pfru_dev(file)->kref);
> +       return 0;
> +}
> +
> +static int pfru_release(struct inode *inode, struct file *file)
> +{
> +       pfru_put(to_pfru_dev(file));
> +       return 0;
> +}
> +
>  static const struct file_operations acpi_pfru_fops =3D {
>         .owner          =3D THIS_MODULE,
> +       .open           =3D pfru_open,
> +       .release        =3D pfru_release,
>         .write          =3D pfru_write,
>         .unlocked_ioctl =3D pfru_ioctl,
>         .llseek         =3D noop_llseek,
> @@ -530,6 +571,7 @@ static void acpi_pfru_remove(struct platform_device *=
pdev)
>         struct pfru_device *pfru_dev =3D platform_get_drvdata(pdev);
>
>         misc_deregister(&pfru_dev->miscdev);
> +       WRITE_ONCE(pfru_dev->removed, true);
>  }
>
>  static void pfru_put_idx(void *data)
> @@ -554,10 +596,16 @@ static int acpi_pfru_probe(struct platform_device *=
pdev)
>                 return -ENODEV;
>         }
>
> -       pfru_dev =3D devm_kzalloc(&pdev->dev, sizeof(*pfru_dev), GFP_KERN=
EL);
> +       pfru_dev =3D kzalloc(sizeof(*pfru_dev), GFP_KERNEL);
>         if (!pfru_dev)
>                 return -ENOMEM;
>
> +       kref_init(&pfru_dev->kref);
> +       pfru_dev->parent_dev =3D get_device(&pdev->dev);
> +       ret =3D devm_add_action_or_reset(&pdev->dev, pfru_put, pfru_dev);
> +       if (ret)
> +               return ret;
> +
>         ret =3D ida_alloc(&pfru_ida, GFP_KERNEL);
>         if (ret < 0)
>                 return ret;
> @@ -568,7 +616,6 @@ static int acpi_pfru_probe(struct platform_device *pd=
ev)
>                 return ret;
>
>         pfru_dev->rev_id =3D PFRU_DEFAULT_REV_ID;
> -       pfru_dev->parent_dev =3D &pdev->dev;
>
>         pfru_dev->miscdev.minor =3D MISC_DYNAMIC_MINOR;
>         pfru_dev->miscdev.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
> --

Applied as 7.5 material, thanks!
