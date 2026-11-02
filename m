Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623272;
	b=wZR8cO7m87ODB50xmJO3va2QG4pFvWznOGni1NfVwCo1WtWDP2I/SR4dqyZ1FJs+cGRF
	 02n2Dl5vZ7k8HMf3a24Wla0i3ttnLnPPLFhZ79cB0w2A5+OtBqrx+m3baeu6tBbvUCw6x
	 mUoirRok1PXwxRG/QxBbiiKHtE1qlZ5/evox9gm4WEFcT5BBEyEc6m4ZPm5hQq+1bydTE
	 bXVceelSkpQKzCDTjxhwahM6iFW+qOP6TSxuWX1ST5asFdXJ15K4b5DuJQ/hf8VEq8lca
	 hUn7OEftO5lX3cjYKXlcSOv4Qs7VDPNr5TYAyDvkiv/Bd2cbyx52b2Ua0TUKYzomXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3y/yQ7bOSsnHyylDSSSE8FXmnqPmwJGFAWCe0iH8E60=;
	b=A5HoLWAGrF5UhhPcinkSHK3/RWR76Md7ehbCE+J9FP/lJFbp4zHfWyIC2FF5nKEdJytb
	 Ds+SnJLSfvgigMgDwepg9S81HkgNWXNsJb7DW+eAZyal3ZYBhMn4NUJyDt8+Kj+dwVXxz
	 5Qvy8voUYPVpqs4rdzcdEGt51fI2/kH58Os5KVnkcsZX0FFtv377kMGz+sUGqyPOuWOvM
	 Vm7ESgStZ80DDb5M/EKhia6jBnWlw9sEcooJHHxe726k+iCzPX/qRhelV06qtIqewg4RY
	 d/ctvMr1I+crE4Ggoa+kB9P4ZEmfs8q7CAoHA3RNWuVBgaE3oR9qYxe6UmxhCskCB5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZ7kANyX;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666E606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C666E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZ7kANyX
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e812e2b31bso17286045ad.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793623271; x=1794228071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3y/yQ7bOSsnHyylDSSSE8FXmnqPmwJGFAWCe0iH8E60=;
        b=OZ7kANyX+gh+ZCIjQsgnhe7nx3gX9Fh3lyOa7ONLFUUfV8lyszPtzgNuMOLH2GCL26
         XOfLEQyMwSWT77lFZDeVyc3pQlQVwLSE6T2l79ZLouxgzoNHEG+CXGp60d7DYZJNJFH2
         svbBZ3goM0LJbd++DgAY7TKHnp9VMJ27p0QNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623271; x=1794228071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3y/yQ7bOSsnHyylDSSSE8FXmnqPmwJGFAWCe0iH8E60=;
        b=cqWChDa//hfImGxAnsKCEE9GBkI+XszOXJhUytWSStkVy0nfH0MA27nLn2BCBMY6dQ
         K0qWgri22KlnOkUYP19yBJ9il1k/v4E7sigljsj/INebmXuwRTZjbF3NToKzVHkGrSmw
         QQjef7q4aQ9gIz17P/KAB9Y9avpBrpspQYwrk/GTLTYQBAoMtzOk/eMqC4edL5W0Fb5D
         AY7W9qyQD4CgpwMNAY/3x14qqDTpqLQ4jBQrRb2Mi9cf1EaeSsXDNeFzgSBENnNw2i4h
         SxITH4CUz3/tRL73Imb8Gr3WrEugmwYfzOkF7c+4Rl0vqClGz8ypx8SGEZ6UePfWpGeI
         o3tw==
X-Forwarded-Encrypted: i=1; AKwUvBz+0VnmKmI9wE+pGMEoN7yPX4DhQHUsrkJI7+4qIjqGxWRfbhQgvP8+WBFjOU0XgV+TT9R4G8c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eTFAaLv8i2xeU5WxiMUKS4B7McigtWXb/Vuc5wWtMt98Pk49D
	rUHHMJDeO/tmi3sWvTYUmL817uIfdcEcKC5MM+Ql9r5X1IrYHmtAri6jP9gzvuSL+bwOlcWE24I
	6UODHgQ==
X-Gm-Gg: AYBFou2JkIJuEAihICkq5iq3rXb1syIAweEV4wW+h1qUIFbdnG4/QFgsJzYWqhsbicU
	h2fFAzSRB6HZth6k5SkhzXgTou01zGb+U40E6HIaLjSunYza3GZbPHv/QVS96ZctTz/Hfa6lJ1t
	n8DVzPnamwbr8OcSvVYwjmSCMc58vIDKtwO8fndNQMYPAhx00+hkDRDGrtGU6ehIQaMhekq0/3c
	d9dYEOcV5v6zLS8SNG9EQHmyffKogeZ+8Y/WKAmP45HTV/dXRbRjnmXSZphz/ll7k4fN7L1kkoC
	tChwQZNdJoJiiQA6YY2OC8iJ6aOLL4xXEDUXBzo9TqD/UarBEJztImeVhXeE0IKUpml3zhvi3sR
	rfJ3evbDyKJdkPPIYlQomV2WsG4Niy2l42u4wPulhSSnTnBuIK+Cw9L+YrPjwG6KMcpq1Kn0Jt9
	cBcm/9biBFjGcCERiNCFBUZ7URmvneC+R/DHGfSWVdy6MQEoRzIWYL+URzzUAqbg6iUDCpACL4C
	G7K1Aos0b4drwagjt8h/t+7VphIWpfJWb+1SB/3Y3sg8K0/lAjyi375fDqeCYSnAjhmvQcaTXHM
	VMLYtM28SnBOA+em08aqZU3b4uAtsytOhLpBWl+QYKorFAwoG4X0xaIYdmCC8m+gn1Xx1eRziLl
	+63WJCW1c4Q==
X-Received: by 2002:a17:902:f54a:b0:2ea:9c9f:b24c with SMTP id d9443c01a7336-2eb364b823fmr92368215ad.23.1793623271092;
        Mon, 02 Nov 2026 04:41:11 -0800 (PST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f5fesm27382635ad.21.2026.11.02.04.41.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:41:10 -0800 (PST)
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1879262c88.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:41:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz3YtH2+izl+CeovOL70ALr0Yy4q0v5EyUy0gSFdrMvghA0Fi6CgOWBeaQhs1uEppkyNoCOLaM=@vger.kernel.org
X-Received: by 2002:a05:701a:c907:b0:16a:1fa:58cb with SMTP id
 a92af1059eb24-1ac56d95460mr14461485c88.1.1793623268480; Mon, 02 Nov 2026
 04:41:08 -0800 (PST)
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
In-Reply-To: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Nov 2026 13:40:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
X-Gm-Features: AclHuK_jasd6nzcnp46dLaPaUwH7gcY2wdNBwqnJpio47XI4ra-_IDB-wFb6mZo
Message-ID: <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
Subject: Re: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping...

On Mon, 31 Aug 2026 at 13:12, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge the=
m in
> sysfs-driver-hid-lenovo-go to avoid this warning:
>
> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface n=
um>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./=
Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/A=
BI/testing/sysfs-driver-hid-lenovo-go-s:234
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 ti=
mes: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Document=
ation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2=
 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is def=
ined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; .=
/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
>
> Cc: stable@vger.kernel.org
> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers=
")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------=
------
>  2 files changed, 6 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go
> index c8221373ef76..f3ba3504939d 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> @@ -364,11 +364,12 @@ Description:      This displays the available optio=
ns for the mode attribute.
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>  Date:          April 2026
>  Contact:       linux-input@vger.kernel.org
> -Description:   This controls the behavior of built in chord combinations=
.
> +Description:   This controls the behavior of built-in chord combinations=
.
> +               For the Legion Go S, this controls the touchpad's operati=
ng mode.
>
>                 Values are windows or linux.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>  Date:          April 2026
> @@ -377,7 +378,7 @@ Description:        This displays the available optio=
ns for the os_mode attribute.
>
>                 Values are windows or linux.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
>  Date:          April 2026
> @@ -640,7 +641,7 @@ Description:        This controls enabling or disabli=
ng the touchpad.
>
>                 Values are true, false.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>  Date:          April 2026
> @@ -649,7 +650,7 @@ Description:        This displays the available optio=
ns for the touchpad/enabled attrib
>
>                 Values are true, false.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enab=
led
>  Date:          April 2026
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Doc=
umentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> index 4d317074bb7e..218164cfe544 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> @@ -231,41 +231,6 @@ Description:       This displays the available optio=
ns for the mouse/step attribute.
>
>                 Applies to Lenovo Legion Go S line of handheld devices.
>
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This controls which value is used for the touchpads opera=
ting mode.
> -
> -               Values are windows or linux.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This displays the available options for the os_mode attri=
bute.
> -
> -               Values are windows or linux.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This controls enabling or disabling the built-in touchpad=
.
> -
> -               Values are true or false.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This displays the available options for the touchpad/enab=
led attribute.
> -
> -               Values are true or false.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
>  Date:          April 2026
>
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>


--=20
Ricardo Ribalda
