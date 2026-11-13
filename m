Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592585;
	b=t9l3fkYec+h7B2YhRdSlREm4BvTeORz5iWfxs7alquHsy3aV3SoP2Hu5hZu96upzdCKx
	 TNgVd2eRkSIYe7ojyUSg8f4KIxy+9qIpsKwYnSS0u4wQZYXXO9jXnldrVGT660UHalgA6
	 aauk06DBNyILykiOXQQfZBH2dI0VJZZ98RbNnoxg+2DGZHzyWBbcUPxJfqhFz+9PfHAeU
	 sLWIVReLYgxPwLsE4Lv+E+pFmF3QtbbIKDy38HImu/1thcqBi+MrpmRJAINVLMYcjcK+T
	 WeI7YO4uWOLEv7Gh741KviMxt6a2aNtr0UzQxvzhD3AGIoqi7F2o1XNLIDYRk5kLbjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592585;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z4NuS5WvkTyKHlT/Rjy7maiYnnlr6yz7spwuCHaRFJI=;
	b=dVcmY6mS1O9WPlR3qGx7BZDqzCuA6Ml9ccvpKonPrm7nd+HrsFlGjUSFnTr774rco/Ws
	 u9Mj/1bgvTOpmGTVetMi3oWSrJnP9njlFlE/35PB7AJ7kkCVNcHjAqtN2LllnrZ2Ppl7d
	 Rl836SipIXeGJ/6zuTDzaNcxpcuGU9QgggXk7ruxd672vuBmWKpoBpOinz384qYpWlDGQ
	 LIERQls5a6H1qEKgpHYNf+lU7UxJLdg195OEvCJzhtP53R9qGyZ9t5NUSfP6/AQZxIuTQ
	 7TroZWuLDYdZbRowS++BUTpwZ6ANbMFWHosquHYjmBJYO02YEgPyG1a2o+5YWqmFiZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnYVho3t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4079606A336
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnYVho3t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819CA1F000CA
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592585;
	bh=z4NuS5WvkTyKHlT/Rjy7maiYnnlr6yz7spwuCHaRFJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RnYVho3tABkAN8QRXrYg1cVLyOq3ohHCmTS1zWBUeQlhfVJrl/pIVhtmlCcRWtfUJ
	 JnCTY10rxC+/y9JxzNV/vfGrGbAanzEFaqtzBDStSk2U9zMeUhya9qEs2BQoBnFJYb
	 fWFXrbvBmONFKsYeAvkD9Tio6WFXW4GYlKe6VFhiaDYahw2Jf0LzFkjLCqAkxrygUg
	 sHZ8Z/kc9V8dXwMJNJof/+pRrMaaei9uMcvb8sS3TxC1SNb7tGZs5TrR0bxPIhalNV
	 kGYiYNXbaOhxGOGihoS6vMRCv7y2ADfmOFtxxiGqFzGBk1fyftpwQj23Qh/vIQFWL6
	 Z0QdPswHVKHgg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ae2fb3fe2fso12285371fa.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:56:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF46LXL5fpo0aDfVfebiRIT8wLuB1eUk0Eu1lL6Nxijgok6egt7QD0lb3TSHwyP+45lcaVQycA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GCBq81vRinSN/XCMghLy8rqzm2jmulzvg6PcxmAX/wJZmSF+C
	lGhLKS6PXyh/ZlMFxcKWUCkrpNTFDlDh5wH3QHqnKnrZOGzMZlw7F/m7EHbb627vhAFVRY7ZqhK
	JEcjOJ65RzNdiesFB50JcmWOHqvPGaao=
X-Received: by 2002:a05:6512:a8c:b0:5c1:5775:d1ea with SMTP id
 2adb3069b0e04-5c1709994a4mr1323474e87.11.1794592583815; Fri, 13 Nov 2026
 09:56:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110154630.1550730-2-ca@modelmiser.com>
In-Reply-To: <20261110154630.1550730-2-ca@modelmiser.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 18:56:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iLdz68hRJbuiULM-CaDoB-tu8_hMSeDkwx+f5z2jkcRQ@mail.gmail.com>
X-Gm-Features: AclHuK_oVbcpbi7gbT7o-DVceCdgZpxBmOG6quCsZ-e6C8G31-f3G0B_vbHIxao
Message-ID: <CAJZ5v0iLdz68hRJbuiULM-CaDoB-tu8_hMSeDkwx+f5z2jkcRQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pfr_update: wait for running calls in remove()
To: Chad Aldreda <ca@modelmiser.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 4:46=E2=80=AFPM Chad Aldreda <ca@modelmiser.com> wr=
ote:
>
> Commit dacb7cef6f32 ("ACPI: pfr_update: keep the state until the last
> file is closed") makes ioctl() and write() fail with -ENODEV once
> remove() has run, but a call that started before remove() keeps running
> after it returns. Such a call can evaluate _DSM while device_del()
> unbinds the parent's ACPI companion, and after an unbind and bind it
> acts on the firmware behind the new instance's back. Its message says
> such a call "finishes against state that is still valid"; that was
> wrong.
>
> Run the firmware calls of ioctl() and write() under a new mutex, and set
> the removed flag under it in remove(), so that remove() waits for calls
> already running. The mutex also serializes rev_id and the use of the
> shared communication buffer, which concurrent calls on different files
> could interleave. User memory is copied outside the lock, so a page
> fault that does not complete cannot hold up remove(): write() now copies
> the capsule into a kernel buffer first, and a fault there returns
> -EFAULT rather than -EINVAL. It queries the buffer again once it holds
> the lock, since SET_REV may have run in between. An unbind during a
> capsule stage or activation waits for it to finish, rather than
> returning with the update still in progress.
>
> The race was pointed out by Sashiko's review of the matching
> pfr_telemetry patch [1]. The fix and this message were written with an
> AI assistant (Claude) and checked by hand, and tested in QEMU with
> KASAN and lockdep, using an SSDT whose _DSM stands in for the firmware.
> Hardware with this firmware interface was not tested.
>
> Link: https://sashiko.dev/#/patchset/20261108233900.4043941-3-ca%40modelm=
iser.com [1]
> Fixes: dacb7cef6f32 ("ACPI: pfr_update: keep the state until the last fil=
e is closed")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>

Applied as 7.5 material, thanks!

> ---
> This goes on top of commit dacb7cef6f32 in linux-pm, which Rafael
> applied for 7.5. The matching pfr_telemetry change is in v2 of that
> patch:
> https://lore.kernel.org/r/20261110144436.1529000-2-ca@modelmiser.com
>
> As in pfr_telemetry, user memory is copied outside the lock. For
> write() that means a kernel copy of the capsule, of up to the firmware
> buffer size, so a slow or stalled user fault no longer holds the lock.
>
> Tested as for the pfr_telemetry v2 patch, with the SSDT device _HID
> INTC1080. QUERY_CAP, SET_REV, write() of a minimal capsule and STAGE
> work before a sysfs unbind and fail with -ENODEV after it on a file
> held open, the same holds after a bind, and there are no KASAN or
> lockdep reports. With a test-only msleep(2000) before the QUERY_CAP
> firmware call and the driver unbound 0.5 s into the call, the unbind
> returned at once without this patch and the firmware call completed
> 1.5 s after remove() returned; with it the unbind returned 2.0 s in,
> after the call completed. ACTIVATE and STAGE_ACTIVATE were not run,
> and neither was removal of the device itself.
>
> The code, changelog and reproducers were written with an AI assistant
> (Claude Opus 5.5), and the assistant ran the tests above. I ran the
> final version myself and got the same results.
>
>  drivers/acpi/pfr_update.c | 86 ++++++++++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 797956d9defb..73cde535b34b 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -19,11 +19,11 @@
>  #include <linux/kref.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> -#include <linux/uio.h>
>  #include <linux/uuid.h>
>
>  #include <uapi/linux/pfrut.h>
> @@ -85,6 +85,12 @@ struct pfru_device {
>         struct device *parent_dev;
>         struct miscdevice miscdev;
>         struct kref kref;
> +       /*
> +        * Serializes the firmware calls, rev_id and the communication bu=
ffer
> +        * of the file operations, and remove(), which sets removed under=
 it
> +        * and so waits for calls already running.
> +        */
> +       struct mutex lock;
>         bool removed;
>  };
>
> @@ -424,6 +430,15 @@ static int start_update(int action, struct pfru_devi=
ce *pfru_dev)
>         return ret;
>  }
>
> +static int pfru_start_update(int action, struct pfru_device *pfru_dev)
> +{
> +       guard(mutex)(&pfru_dev->lock);
> +       if (pfru_dev->removed)
> +               return -ENODEV;
> +
> +       return start_update(action, pfru_dev);
> +}
> +
>  static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned lon=
g arg)
>  {
>         struct pfru_update_cap_info cap_hdr =3D {};
> @@ -432,12 +447,14 @@ static long pfru_ioctl(struct file *file, unsigned =
int cmd, unsigned long arg)
>         u32 rev;
>         int ret;
>
> -       if (READ_ONCE(pfru_dev->removed))
> -               return -ENODEV;
> -
>         switch (cmd) {
>         case PFRU_IOC_QUERY_CAP:
> -               ret =3D query_capability(&cap_hdr, pfru_dev);
> +               scoped_guard(mutex, &pfru_dev->lock) {
> +                       if (pfru_dev->removed)
> +                               return -ENODEV;
> +
> +                       ret =3D query_capability(&cap_hdr, pfru_dev);
> +               }
>                 if (ret)
>                         return ret;
>
> @@ -453,18 +470,23 @@ static long pfru_ioctl(struct file *file, unsigned =
int cmd, unsigned long arg)
>                 if (!pfru_valid_revid(rev))
>                         return -EINVAL;
>
> -               pfru_dev->rev_id =3D rev;
> +               scoped_guard(mutex, &pfru_dev->lock) {
> +                       if (pfru_dev->removed)
> +                               return -ENODEV;
> +
> +                       pfru_dev->rev_id =3D rev;
> +               }
>
>                 return 0;
>
>         case PFRU_IOC_STAGE:
> -               return start_update(START_STAGE, pfru_dev);
> +               return pfru_start_update(START_STAGE, pfru_dev);
>
>         case PFRU_IOC_ACTIVATE:
> -               return start_update(START_ACTIVATE, pfru_dev);
> +               return pfru_start_update(START_ACTIVATE, pfru_dev);
>
>         case PFRU_IOC_STAGE_ACTIVATE:
> -               return start_update(START_STAGE_ACTIVATE, pfru_dev);
> +               return pfru_start_update(START_STAGE_ACTIVATE, pfru_dev);
>
>         default:
>                 return -ENOTTY;
> @@ -478,14 +500,33 @@ static ssize_t pfru_write(struct file *file, const =
char __user *buf,
>         struct pfru_update_cap_info cap;
>         struct pfru_com_buf_info buf_info;
>         phys_addr_t phy_addr;
> -       struct iov_iter iter;
> -       struct iovec iov;
>         char *buf_ptr;
>         int ret;
>
> -       if (READ_ONCE(pfru_dev->removed))
> +       scoped_guard(mutex, &pfru_dev->lock) {
> +               if (pfru_dev->removed)
> +                       return -ENODEV;
> +
> +               ret =3D query_buffer(&buf_info, pfru_dev);
> +       }
> +       if (ret)
> +               return ret;
> +
> +       if (len > buf_info.buf_size) {
> +               dev_dbg(pfru_dev->parent_dev, "Capsule image size too lar=
ge\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Copy from the user outside the lock, which remove() waits for =
*/
> +       void *data __free(kvfree) =3D vmemdup_user(buf, len);
> +       if (IS_ERR(data))
> +               return PTR_ERR(data);
> +
> +       guard(mutex)(&pfru_dev->lock);
> +       if (pfru_dev->removed)
>                 return -ENODEV;
>
> +       /* Query again: SET_REV may have run while the lock was dropped *=
/
>         ret =3D query_buffer(&buf_info, pfru_dev);
>         if (ret)
>                 return ret;
> @@ -495,10 +536,6 @@ static ssize_t pfru_write(struct file *file, const c=
har __user *buf,
>                 return -EINVAL;
>         }
>
> -       iov.iov_base =3D (void __user *)buf;
> -       iov.iov_len =3D len;
> -       iov_iter_init(&iter, ITER_SOURCE, &iov, 1, len);
> -
>         /* map the communication buffer */
>         phy_addr =3D (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.ad=
dr_lo);
>         buf_ptr =3D memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
> @@ -507,22 +544,13 @@ static ssize_t pfru_write(struct file *file, const =
char __user *buf,
>                 return -ENOMEM;
>         }
>
> -       if (!copy_from_iter_full(buf_ptr, len, &iter)) {
> -               dev_dbg(pfru_dev->parent_dev,
> -                       "Failed to copy the data from the user space buff=
er\n");
> -               ret =3D -EINVAL;
> -               goto unmap;
> -       }
> +       memcpy(buf_ptr, data, len);
>
>         /* check if the capsule header has a valid version number */
>         ret =3D query_capability(&cap, pfru_dev);
> -       if (ret)
> -               goto unmap;
> -
> -       if (!applicable_image(buf_ptr, &cap, pfru_dev))
> +       if (!ret && !applicable_image(buf_ptr, &cap, pfru_dev))
>                 ret =3D -EINVAL;
>
> -unmap:
>         memunmap(buf_ptr);
>
>         return ret ?: len;
> @@ -571,7 +599,8 @@ static void acpi_pfru_remove(struct platform_device *=
pdev)
>         struct pfru_device *pfru_dev =3D platform_get_drvdata(pdev);
>
>         misc_deregister(&pfru_dev->miscdev);
> -       WRITE_ONCE(pfru_dev->removed, true);
> +       scoped_guard(mutex, &pfru_dev->lock)
> +               pfru_dev->removed =3D true;
>  }
>
>  static void pfru_put_idx(void *data)
> @@ -601,6 +630,7 @@ static int acpi_pfru_probe(struct platform_device *pd=
ev)
>                 return -ENOMEM;
>
>         kref_init(&pfru_dev->kref);
> +       mutex_init(&pfru_dev->lock);
>         pfru_dev->parent_dev =3D get_device(&pdev->dev);
>         ret =3D devm_add_action_or_reset(&pdev->dev, pfru_put, pfru_dev);
>         if (ret)
> --
> 2.43.0
>
>
