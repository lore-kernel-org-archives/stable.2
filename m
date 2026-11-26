Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702170;
	b=AGtIqIiOzpd/iDSzlMo2DElzNYv9D4Vgbmz3pyxswcO3IWFdrWrzLrQ6FfI7o0C2bue7
	 ALoNL5vJ/MhdoG+Jm6MkVHTdaAiXpRhNPLzBnLH/4ZFNgYl0OxfBixVpcvDt6TEpPfuxu
	 Do0QfQVyy1e5D0GlPf8XTWi/ocnWN6i5MkjMyLpuatMceTTWQj8gDF867u1CkX/Q3zCC1
	 Xg6FJ3Zzx67Bx4p0rLRHO9XHtochzIodPcz/0Y4V0FWctkgGLw9QByIhYNMbLU6R+nlyT
	 BgwuA26UCXVoes1XdfKp3rVSrsr/d8VswiRWgtzAvtrt5zKJ7HXmppKl/j5bzAsRybA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7838JVCVIFZHpChcKzHUN7ifBcuei9XazkkD9p8QNFU=;
	b=cpIQzyIy6vqe+awX/R56WRyjcVOD5MfIPLUHQF61jBxJ4KkVmXpnj8q4hloJPV6bSPEy
	 HDt0joInTgHako+LhlbPuytPRLGrVTcIxmyWRwlc4oAvwMMoQT6KDDCqBWokkTvkcsLSO
	 heyl2UU7MO11EXRy6RzER2BchwNDRQIV9kS05LIxNJ9ZRhyLDaFlU4npZoT5liAiwttfE
	 rjcGlutnupywc6B1QGLF6j5UwjaG4EnxV5IrS7FMt/HbNnpVBO7oqEAz30myy9C3HR0No
	 6JMAujDJUtUcEHU9LkwTI3Pe3YMCIg3QS8ST4AEE8/7R1nAY+RtAjK7eN+ODyKZ7Jyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d17URzsq;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF3606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAF3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d17URzsq
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b413997581so5358613a91.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795702169; x=1796306969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7838JVCVIFZHpChcKzHUN7ifBcuei9XazkkD9p8QNFU=;
        b=d17URzsqjWioo2PfC+RopqBDvb9xyjHmxFcKjHWIro7dm6NbcxMmmXlubr2cgTEkXB
         OfihcCG9CbfADY6zZIChr14Lsls1UnnntuCfozzSDdqm2xfpx3LeOonsleuI36T1kVX9
         XiI8ddfYfBl+0jEtfH4kdWeW4EFwY1b61jXbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702169; x=1796306969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7838JVCVIFZHpChcKzHUN7ifBcuei9XazkkD9p8QNFU=;
        b=KmHbG5fygeZkIAeQTl8Lkw4RPLdG0Jb7PgHFakbVLjRCkTxqhqHnW6bXt70BJSofkf
         7FfbRx5zAQcWhSGMMRR6vg4sqKUDoIRA8snL8yhF93SHUIhFrltUkZwR5elkPJ9kjBVW
         MmILbZhxp4LG/zVWZhg/WPhaYbagtFmwVpzIgJDSeE9Ow2FbF+awvpu+BCdEYZToBN+c
         Jl6hhRrfbmGpt5La/rt+CXFJkgi/jhmQwe0L5fVo3bWWnvhaI+v2543mNuWbwWaLKOVG
         J3m58XLbVRSdw3mlpQZ+fqdPfguyYOJ7ellF7t3Kjb0mVsCH5sHMJhWEPzSvgP5KuqrA
         sirA==
X-Forwarded-Encrypted: i=1; AL+hErEabn6gAmAUBOsuWQklnaBnDceO9YQuteOlwc1eN611+MK9hY73ZmUjO6E7qy6tCf5zBCjW3v0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bAny83vP9zR2WjUrzrV4rBaK6VaqlCCLBQiiNAWV7jl/FAAM0
	xFb7ULsavJqiJOyKQtqyFPtxGs5+UfksCGYzlMdR2IRa+3SI3NumkEe8ua+LFR8ZHctrA5Buta0
	MQzh6W4m4
X-Gm-Gg: AZFdTZcfd3ueVqneKS9Gini+8ReQSCyL+/eUGtrLTGNbhXEUG//A6hBWff+kWgkb3RX
	JzddlcjyQtAycFH7webO9udcDn+i7FSf44ZLIOrkUtjv1qSkLLsJAtNDUxztwz1hxX/KclUHbfC
	SarbbgndUt4dQSnmnzSKWqrGIzBkaCBGi6OjfLVV/rFUmDykULhCyMZsDicwE/Z9HFTnHTFlBKz
	9drNR8+NYFjU/iif42Wccrsob+aiVOWgufDc+SdaNZ0DSDU0Fj+9d0UGv2AHKMgeucdzaL0S3Ud
	JtwXTo7sIcM9/MEjQqh3DetnqJlISe5sJMFwfMwbcdlZm7qf43wEWJ0zzvDJMEmxLzM2Inr3Ty2
	ZsaDrn9YVCJPzeWzrQpiPxLgV4M9gn+cs1B+xdWIVHHRG/uEjSYAJMD2RnTyLp6YOMKT6Moyuk9
	Ja3QUXCGFY8ZS5EOuU6zsdvOIwL5KmWuefjA/YrS9FFBOdT0v5otigS4XYRI0K9smY149lMVuxX
	dzdVdytZ1cexw1hm6BDX+BAqou/LMYTvK2vC+RSGmvNVQYRqHP9mkfoWMyI9XBWiH+45HCMns8c
	wW29ZbNbBq6ZDjJbFEUYruzkhuG9gDIU1uzF+vwRmJH6yKqIWzmuFiFWBM4vyiVrEw==
X-Received: by 2002:a17:90b:3810:b0:3b1:bee2:223d with SMTP id 98e67ed59e1d1-3b41c9bc27emr20095158a91.53.1795702169103;
        Thu, 26 Nov 2026 06:09:29 -0800 (PST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm17203987a91.10.2026.11.26.06.09.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:09:28 -0800 (PST)
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so9879730c88.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:09:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHjKhA30xmHFfqm/a2OBlfNI6FJqPTM4wyJ9AsoNr+Xq97pjkQ6JiMNWuIm10E66HJcXoCkn7c=@vger.kernel.org
X-Received: by 2002:a05:701b:450d:20b0:1b2:4378:3545 with SMTP id
 a92af1059eb24-1b5568e825emr23220173c88.21.1795702166818; Thu, 26 Nov 2026
 06:09:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
 <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com> <0fd097a2-029b-4023-bc22-d2eb587a646d@app.fastmail.com>
In-Reply-To: <0fd097a2-029b-4023-bc22-d2eb587a646d@app.fastmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Nov 2026 15:09:10 +0100
X-Gmail-Original-Message-ID: <CANiDSCtcOa1UuCOb8wwpMdGRk_3Kb0aZtoiNfMXX2Y-0fCjorg@mail.gmail.com>
X-Gm-Features: Aa3M54rtRoX6wSK5Y9qAl8rp--BKPEAndffZ9pTASgsLVd44EKFxzDfIZ7n7-aM
Message-ID: <CANiDSCtcOa1UuCOb8wwpMdGRk_3Kb0aZtoiNfMXX2Y-0fCjorg@mail.gmail.com>
Subject: Re: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark

Thanks for your review. Do you know if this is going to land in the tree?

Thanks!

On Mon, 2 Nov 2026 at 18:48, Mark Pearson <mpearson-lenovo@squebb.ca> wrote=
:
>
> On Mon, Nov 2, 2026, at 7:40 AM, Ricardo Ribalda wrote:
> > Friendly ping...
> >
> > On Mon, 31 Aug 2026 at 13:12, Ricardo Ribalda <ribalda@chromium.org> wr=
ote:
> >>
> >> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge =
them in
> >> sysfs-driver-hid-lenovo-go to avoid this warning:
> >>
> >> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfac=
e num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times:=
 ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentatio=
n/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfa=
ce num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2=
 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfa=
ce num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is define=
d 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Do=
cumentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfa=
ce num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is =
defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645=
; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go driv=
ers")
> >> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >> ---
> >>  .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
> >>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 -------------=
---------
> >>  2 files changed, 6 insertions(+), 40 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Do=
cumentation/ABI/testing/sysfs-driver-hid-lenovo-go
> >> index c8221373ef76..f3ba3504939d 100644
> >> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> >> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> >> @@ -364,11 +364,12 @@ Description:      This displays the available op=
tions for the mode attribute.
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
> >>  Date:          April 2026
> >>  Contact:       linux-input@vger.kernel.org
> >> -Description:   This controls the behavior of built in chord combinati=
ons.
> >> +Description:   This controls the behavior of built-in chord combinati=
ons.
>
> Nit - this minor change is not part of the patch description.
>
> >> +               For the Legion Go S, this controls the touchpad's oper=
ating mode.
> >>
> >>                 Values are windows or linux.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
> >>  Date:          April 2026
> >> @@ -377,7 +378,7 @@ Description:        This displays the available op=
tions for the os_mode attribute.
> >>
> >>                 Values are windows or linux.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
> >>  Date:          April 2026
> >> @@ -640,7 +641,7 @@ Description:        This controls enabling or disa=
bling the touchpad.
> >>
> >>                 Values are true, false.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_ind=
ex
> >>  Date:          April 2026
> >> @@ -649,7 +650,7 @@ Description:        This displays the available op=
tions for the touchpad/enabled attrib
> >>
> >>                 Values are true, false.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_e=
nabled
> >>  Date:          April 2026
> >> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/=
Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> >> index 4d317074bb7e..218164cfe544 100644
> >> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> >> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> >> @@ -231,41 +231,6 @@ Description:       This displays the available op=
tions for the mouse/step attribute.
> >>
> >>                 Applies to Lenovo Legion Go S line of handheld devices=
.
> >>
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This controls which value is used for the touchpads op=
erating mode.
> >> -
> >> -               Values are windows or linux.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >> -
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This displays the available options for the os_mode at=
tribute.
> >> -
> >> -               Values are windows or linux.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >> -
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This controls enabling or disabling the built-in touch=
pad.
> >> -
> >> -               Values are true or false.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >> -
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_ind=
ex
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This displays the available options for the touchpad/e=
nabled attribute.
> >> -
> >> -               Values are true or false.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
> >>  Date:          April 2026
> >>
> >> ---
> >> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> >> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
> >>
> >> Best regards,
> >> --
> >> Ricardo Ribalda <ribalda@chromium.org>
> >>
> >
> >
> > --
> > Ricardo Ribalda
>
> All looks good to me.
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Mark



--=20
Ricardo Ribalda
