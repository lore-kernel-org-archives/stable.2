Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D440D570
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429777; cv=pass; b=mAbtQq1qwo0xDXz2ipA/gEwXT2JPTE3HlWmDcyNi+ZOet47LIW4IC/dQgEek5FqVJMTjqtTwdzK55gfk4yWO84JkbqE5RKY8q2BOuIlQ+BhQCVQ82PgexdL8YJzDrLo7E73+5iqi15FPPKRg0VLjMaSxB0LpfGyxVzY6TgJ20Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429777; c=relaxed/simple;
	bh=KxG8FW2t1Y5M+en6j+orfhigu10djlUwEeeCbQF3vLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCsGty67u9OJDLN3HRz2m+Xv+UW6BHoSFgVWaAMGprvH1IQfdAgguWYKNGOlpAq/VYCWlWYlUyqbSDMxYS/VTWLzuoHdvga7QMo8PwtgqEdNdrvS/UlNDvbKOEK9M3BsUeW056pSBG0mAmJ24APiyFma2EpGBi563OmcTRrYIpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF4Vb6V3; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF4Vb6V3"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69e4a083687so1649747eaf.3
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 02:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781429775; cv=none;
        d=google.com; s=arc-20240605;
        b=bdm4xaPigA0bq0LrfATRa9MLqEXn5HRgXHGXOhklAL/wp3wQdJHSn+KbLxVZG8EMv2
         jXsprqPeNaANu6hOAAizCcM7bw3VnoO/YUbqpOkaQDxWc+jxo5CPETUXH4gURLaH8fpn
         dKLN7LRNP20FaCSoeRjsRU9InZl8sQ//NR8OG45SrLB051LTAZWc3BBO6Tc9VTi9Ijmv
         i2W8vAtnPDfZEqTolR//9f5u0L87h8iCAABBmpgf60X+rZ0KgizHrJ/XUfewEigfkW5J
         T+ACEZ8TDPBuj6oegohlgTiw39MxZH2Ogsfmj+ooBMT1ktcTbK7S6YdNSKAwp0V458za
         QLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uhzggcYBf9ZojUJZXYZOedKy8TL71m8+1uHUmTjSGs=;
        fh=A8ReHZzK/XXQ3YNXtw4HTzQFV1Glos8I1YWAMNRB+Go=;
        b=Yi/WgKNm7I1yumztU+Ka78yF5L3bOdHYnsRUnxp8gUmip9ZGQHz7mqC7fEhBINoccS
         eQD4/8MY3JBggU9GTl7fQ8qtyBU2tmf7yIGouZmAwv5CDAq+Ek3LdrFKLUEKNGzTb3C6
         VV+lt2AtmnYnweal17e4kpTynRz6cwvUt4dLxYrE108ZgGNSOKjHuTI79iy7YGlvTBEV
         uUj6hzZRxaubXVKrDHHG9i+3hoBq9wyJzETrCl6xAlVXsZr2+Zcc2dqklukc565KdpiY
         7xTJog+bZItkFdcVVgWDabq35141WA6smLJHHYEhq8zdEDdxf0foa5nVGKs16yH9g/EW
         KGkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429775; x=1782034575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uhzggcYBf9ZojUJZXYZOedKy8TL71m8+1uHUmTjSGs=;
        b=GF4Vb6V3CbrmfUzqqBOs+OXaTmV0CwyiTs0PZPsTq1+xb5m5Bq/QSwmZFPMukFzYP2
         S1AsT2LDgnQLfdattQsoZes/qsW+2ljpCNCbhLyMKja4DpUnhCoFc1q0XGWo9Q0Tavh/
         FkMUyHT7NdPVrIb0AtN7gDigmcXhAfC4KAotxBLGQemXu4VaYcDmClWIbzx9698mesdy
         dv9P7EfNtL2Eujtst8Uo3F54ZgCRbvyXbDV3XQIAtXxQqXYnN6ccs0EVSVbNY1ZQNVFK
         YeZlN1lolxCAnBPSIo8klNHP0gNYSFyUSXVHxUm3+8YXXUVhjM2hm700O3IyClGNdDVM
         u9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429775; x=1782034575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uhzggcYBf9ZojUJZXYZOedKy8TL71m8+1uHUmTjSGs=;
        b=RJlypwjyUDEtW+HpHrzgmEDwUO2Gi+SjAqNLwTvWU4r4n1Rp7szPOTe0Xz6vOdEIKx
         DHgOeLKx7sR3/IBVZ4e+BUsU/JqOOSuIbjyue95LJFd3vO/N4+ixcToR0vXRZ5EMm8vo
         Jq8trqRRc69ORR3hZT/reiU3uLQXPdRv6O0A8v1LcZRkxf9dYVm+KfabH+/T1sL0LjO1
         T0BDIuVGlOssHfWQSI2DyFyMavNQHsc2U0XIXN7ldwKTwyL99z1bj4N+y1OdBTqhq5q5
         G5qu0r9TTNNSaDmMhpejOfml7lBcNY4UERj/s5Zjl2nAmK5NvXjQh0Gp5HFkTlOS5sDT
         xYKw==
X-Forwarded-Encrypted: i=1; AFNElJ/qtbXEZZbVBNlWhKPDrjgfg5uBNtPWgmk+2e2hAGEAtvkDH4YvRkL0Lzk9XIOHWeVaa1eSZ54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrn723fp8Du/lEVoBkCrketQCf4/Mb/Cygx5AIj6nMFPRoswT
	I+k1FVWrgGS8OzdNX87yVLIndc2MYIPzPVnuHiBAaBDaKajgHpkgYOF/bufgbBE8LmGkDCDpkwp
	H0KVkXKfefiSLCOzKUYlU6L9N86BSilU=
X-Gm-Gg: Acq92OHvkXXi97lZhdZ9fpHRai4oXsxhnALxMnsvygdNvGxTfMMaIWhSkIcPumd7rhp
	fHXTPdefbuu6Uw1H2Xy16ME7EZlrccfjqqVFsnE802h0NsWllWUcmLmIYIFEq4fIGA93RKSq7wb
	KBMcXsYd1tRdp7kMVdhlrvu4T9J1cA+rjA03Au6OQl/Ad5HIPu5VxOUZSg2ZgReVN9BQxX3nnzb
	pUMu5zq8W5FYOTIAsjmmXSIx/BPpRCr/9mUgjcxTvpZQrxFD1atoY9kI2PavbBbll2a399qJYKY
	rf9QdGM=
X-Received: by 2002:a05:6820:138c:b0:69e:264b:cced with SMTP id
 006d021491bc7-69edc7531e5mr6172237eaf.41.1781429775361; Sun, 14 Jun 2026
 02:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
In-Reply-To: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Sun, 14 Jun 2026 12:36:00 +0300
X-Gm-Features: AVVi8Ce4epODd7EyUdn-8D3EO5xEsrDf3SP-UUJGVD0bPFa4W7aiY6G9RUo7VLE
Message-ID: <CAPnwWgOwtOib1UoOWYX1xVPFKDuXRQYkwEEuweGqo9H7BCXQ7w@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: fix stack-use-after-return write in I2C read race
To: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raman,

Thanks for this patch. The race is real and separate from the input
report length checks already in for-7.1: those bound the HID report
source, but do not protect read_buf lifetime after a timed-out read
unwinds. A spinlock (not dev->lock) is the right fix for the IRQ/input
path.

For stable backport notes: did you reproduce the use-after-return, or
was this found by inspection?

Optional hardening for v2: initialize read_lock before hid_hw_open(), or
immediately after allocating dev, so a malicious USB device cannot hit
spin_lock on an uninitialized lock during the brief probe window after
the input path is live.

I'm validating on FT260 hardware and will follow up on this thread with
Tested-by when that is complete.

Reviewed-by: Michael Zaidman <michael.zaidman@gmail.com>


On Wed, Jun 10, 2026 at 5:30=E2=80=AFPM Raman Varabets
<kernel-linux-20260610-80b7ab08@raman.v1.sg> wrote:
>
> ft260_i2c_read() points dev->read_buf at a caller-supplied buffer
> (often an on-stack variable), arms a completion and waits up to five
> seconds for the device to return the data. The HID input callback
> ft260_raw_event() runs in the input/IRQ path, independent of the
> dev->lock mutex held by the read path, and copies the device-supplied
> payload into dev->read_buf after a plain NULL check.
>
> These two paths share read_buf, read_idx and read_len with no
> serialization. If the device delays its response until the read
> times out, ft260_i2c_read() resets the controller, clears read_buf
> and returns, unwinding the stack frame the buffer lived in. A
> response that arrives at that moment lets ft260_raw_event() pass the
> NULL check and then memcpy() the device-controlled payload into the
> now-freed stack location, a bounded but attacker-influenced
> stack-use-after-return write triggerable by malicious or
> malfunctioning hardware.
>
> Add a dedicated spinlock that serializes every access to read_buf,
> read_idx and read_len. ft260_raw_event() now holds it across the
> NULL check, the memcpy and the index update, while the read path
> takes it when arming and when clearing the buffer, so the teardown
> can no longer slip between the check and the copy.
>
> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg=
>
> ---
>  drivers/hid/hid-ft260.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 70e2eedb4..f47945954 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -240,6 +240,8 @@ struct ft260_device {
>         struct mutex lock;
>         u8 write_buf[FT260_REPORT_MAX_LENGTH];
>         unsigned long need_wakeup_at;
> +       /* Protects read_buf, read_idx and read_len against ft260_raw_eve=
nt() */
> +       spinlock_t read_lock;
>         u8 *read_buf;
>         u16 read_idx;
>         u16 read_len;
> @@ -501,6 +503,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>         int timeout, ret =3D 0;
>         struct ft260_i2c_read_request_report rep;
>         struct hid_device *hdev =3D dev->hdev;
> +       unsigned long irqflags;
>         u8 bus_busy =3D 0;
>
>         if ((flag & FT260_FLAG_START_REPEATED) =3D=3D FT260_FLAG_START_RE=
PEATED)
> @@ -526,9 +529,11 @@ static int ft260_i2c_read(struct ft260_device *dev, =
u8 addr, u8 *data,
>
>                 reinit_completion(&dev->wait);
>
> +               spin_lock_irqsave(&dev->read_lock, irqflags);
>                 dev->read_idx =3D 0;
>                 dev->read_buf =3D data;
>                 dev->read_len =3D rd_len;
> +               spin_unlock_irqrestore(&dev->read_lock, irqflags);
>
>                 ret =3D ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(=
rep));
>                 if (ret < 0) {
> @@ -543,7 +548,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>                         goto ft260_i2c_read_exit;
>                 }
>
> +               spin_lock_irqsave(&dev->read_lock, irqflags);
>                 dev->read_buf =3D NULL;
> +               spin_unlock_irqrestore(&dev->read_lock, irqflags);
>
>                 if (flag & FT260_FLAG_STOP)
>                         bus_busy =3D FT260_I2C_STATUS_BUS_BUSY;
> @@ -562,7 +569,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>         } while (len > 0);
>
>  ft260_i2c_read_exit:
> +       spin_lock_irqsave(&dev->read_lock, irqflags);
>         dev->read_buf =3D NULL;
> +       spin_unlock_irqrestore(&dev->read_lock, irqflags);
>         return ret;
>  }
>
> @@ -1018,6 +1027,7 @@ static int ft260_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>                  "FT260 usb-i2c bridge");
>
>         mutex_init(&dev->lock);
> +       spin_lock_init(&dev->read_lock);
>         init_completion(&dev->wait);
>
>         ret =3D ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
> @@ -1067,6 +1077,7 @@ static int ft260_raw_event(struct hid_device *hdev,=
 struct hid_report *report,
>  {
>         struct ft260_device *dev =3D hid_get_drvdata(hdev);
>         struct ft260_i2c_input_report *xfer =3D (void *)data;
> +       unsigned long irqflags;
>
>         if (size < offsetof(struct ft260_i2c_input_report, data)) {
>                 hid_err(hdev, "short report %d\n", size);
> @@ -1075,6 +1086,8 @@ static int ft260_raw_event(struct hid_device *hdev,=
 struct hid_report *report,
>
>         if (xfer->report >=3D FT260_I2C_REPORT_MIN &&
>             xfer->report <=3D FT260_I2C_REPORT_MAX) {
> +               bool complete_read;
> +
>                 ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
>                           xfer->report, xfer->length, size);
>
> @@ -1085,8 +1098,15 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>                         return -1;
>                 }
>
> +               /*
> +                * Hold read_lock so a timed-out ft260_i2c_read() cannot
> +                * clear read_buf between the NULL check and the memcpy.
> +                */
> +               spin_lock_irqsave(&dev->read_lock, irqflags);
> +
>                 if ((dev->read_buf =3D=3D NULL) ||
>                     (xfer->length > dev->read_len - dev->read_idx)) {
> +                       spin_unlock_irqrestore(&dev->read_lock, irqflags)=
;
>                         hid_err(hdev, "unexpected report %#02x, length %d=
\n",
>                                 xfer->report, xfer->length);
>                         return -1;
> @@ -1095,8 +1115,11 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>                 memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
>                        xfer->length);
>                 dev->read_idx +=3D xfer->length;
> +               complete_read =3D dev->read_idx =3D=3D dev->read_len;
> +
> +               spin_unlock_irqrestore(&dev->read_lock, irqflags);
>
> -               if (dev->read_idx =3D=3D dev->read_len)
> +               if (complete_read)
>                         complete(&dev->wait);
>
>         } else {
> --
> 2.54.0
>
