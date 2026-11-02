Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793629383;
	b=KPNdwBbmtLIjzyOvX9RD21pwFmc+EjrPzpZDNG/Rc/3RUSzrhpAA3C05XYycKAWAEcVK
	 2v33GhViy1YMVZQ9QKdK5F8CaCp7vQQJ/c6SnPIB1PnXsqV71Oi7tudgD+yEFNKDqlR0K
	 Qvwuh5Lk5e9uV90msyrENxmQ/ywPz4O/6SkvRgc9D4up/b2INoTQVYXHWNwPZCubziBAS
	 c6GvxPR5/WYCXELKxSq006SOfjqzI8C0EwQEJxzfQNjagXRF9thElm99AlIh5m58DViAB
	 DCJXRA/XxiiCunCYpI0jZAX1bsN1cz7X7bUXM4Beb8hvTR4Ml4Wc46x+G23xx1qMjBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
	b=ZQE5sUF6BqwsIofamosg6f3uVtSqgv288SUU7cW7mHMqKdrkAFjJRxvxcMPHXjtH8RfY
	 8m6r/Hzi9prjA7oWy6ee0VjiohVe5wOM+rE9FbMq7QbXIDim0wO+816KPX4jmC1Ah2IWB
	 dKzN+HYM467WEnpDE7pYUrtOBD6AvqO3sMPtRy2s4kFRIHaS+HHKxJc3FPNDeotyV/WHZ
	 y5jFq3pHqbH3EkMM3GNxE4YYQQws4g36kOEK1aZJdpe+r0EjueA4s33zOO4NyHbkwDcoo
	 and//OJ1qT6wyutb2lY6wUCsO3YaYmviMdatdmB02K4Gudxx48DLSuj7rbDMfNqIi1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I5x7qIGW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D67606A33A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D67606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I5x7qIGW
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c79a9a739so49724816d6.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793629382; cv=none;
        d=google.com; s=arc-20260327;
        b=R2oxdpeZS6JotiOJsdEdpm5atg8KQ/dxP5elEGxk2NWA3kM1DTQJzJTVchDjKv3T23
         9Ge20Q6V0Dp3LGjaMNVsuW1tH31JyTg7etuFnxq4hyVVaw5jqSBhB9oJTKNDJ6voHNCP
         u+PR6sKK/aHeAUUmon4R1DdnsGjUQyRaSzBT1K/nfBW7YyENI1MVWXWsRoTfgPV9nAjm
         kG2x3hAwR657RJFW3pIeZtlZWGoseO9RC902Vqc3JoyBFBmo6Gk8efAZGKPBQBwTA8UE
         4N4I1V9SilN1BCAO9IW9ZL1vei5GuimuI5d9Ip8dmjc2KKp1a/W6jVtuMiiTAxi5B2TK
         LHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
        fh=/uml8Jszj+Vfxoo/5MRtCQNm4bZ47wWvTnlOGd3Ec2o=;
        b=ZkYhzJemrm+sZb9DOHTBdu4xJOVsreN+wpEenweMpbD+l4MFgg5yxJcZApn5tOxOqJ
         9tManLuYe2rF1XoQA+5SsfZncsYlAxyKhyWGOkY7fHiclSvyzlQIlaXmjHSaVxoZ9lL7
         Kxg9TZI8wditDJS3lJGuq4dG910R2fiNrzSj4UkJqgadBr/yvjKtTXux0REOyDf738pN
         et3G8iUTKRsqUWsXEIrMGJeGaHHt0fIvLo+YpVYdwMLpnIv3rrpNM+wRlwG49VOliZuB
         VsX4VpfQ4siWdup0sp5uxkbOa1th+xxCsZiUkXE908/FrXFWlYrYowGfRGSP/AYLqXu0
         EfUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793629382; x=1794234182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
        b=I5x7qIGWTsAsfBWf71taDZbRlUUaYCG2iAGsyK7dWndyX8PF0VEktAOe3+XdQMCNnn
         TBZ3rZmTyRKlBo8mXiaPVVz2takyoI4yGmsQNCJDi0waYa6MRwyO0xsSXwTVHPpcLHrQ
         EuF+Z5O316PvlCsze993jBk6PNZ752f4/PHaiYLawgqLEUCIcOxRmSmWKtO1gycmyzBn
         oWjstQPbA8hAo9iAh8ZoQFDFflZp+sobMnmGafMi45kKM8djdRbnhuTD1rltWlU7wajg
         pBBV5sSGs1bGdhsHE0xQn6zYU3qRBgkrKAiAruouuTLmMJZud4rfXYd8JP4Af18wYrhP
         Kh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629382; x=1794234182;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
        b=NmD4C3rKQD5ZJQ3JtOY2tqB6ptJXcDT4rllJQ1J96839m8my+qcTDq2+OC/jioARVk
         28vMjgixu0tS03hYoJtnnaSQ3zlboCFajNzl3/Iqa/k1XNOpbTU5KHRcX70TwMe2n2kz
         P6FNLJ/EgsfSPftlafWaUE36iy3VfHwxrJSImQLESwDGErvzNr8IWdkZ3cOlXeSidCb8
         ZI3Y1NVjYPqvA8yEgeAs0T5CtwcDUsk0iFRMnuPFJrdgs2+uc4/wcIxLtc+1h0n8HcQn
         fqfW3Kb/94t0i8hZranae/lAYO8ypFZiwn/FvwabqokMa9fZZ/wom26o3M9GzLcsuozf
         08Pw==
X-Forwarded-Encrypted: i=1; AKwUvByteetl1dVkk0pHEdQMho8wppguVFaUgP6JvU8I9uaodaaGpSFmQV9sgLBQy+hbzLMYD0WarDM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VxzQc7bT8zbxYQli63gHESPjGDCwbrMpWWFroP+/Tg27SlcFq
	Pe8G5xh4o4cTt7Y+5IUoqhSYswnZoTS5fq8Xs3dxmU1mhgDfQWXwlywvWoBohLrZT39ot1QmZZb
	80lL9WrC9PgXjHxecFjEr04++yKWAX4c=
X-Gm-Gg: AYBFou1y5YFzbMk7YbCbaE6DUeq+g0awTPX12rdPvNBu2Qet/0v/MFXUgtvKmR7ML7o
	w0maigRdLv8H3kTpkSikdUC/GgKQO2FMYgZeNlEBHXJ/IyrecMLuO1xGxVPbJ1G1RiE+bKiPsCX
	4cytA1P8htOc4jfn9sjtQjYL8rE70GGzndAqV28EtjT0/vSqMNfnOqPDW6v5IiDc2UAb72/pXM9
	6xRF0sFg8MCuar53DxaTDS2Yqa4d5ohd4o1zfq5wiMTIzPOT8oKw91RgQ8+LVMHQmk4j2bGMHVT
	uN6B0IoN1TibT1Jolqzzw6dH1QVhfdyTPBGGP2uC2ntX/TJmw4GD1F5l3HN4obum3Zqi+mN89+S
	XgvW6TbIPb3Knol/0galqF6Atb1tzF15aB9KlPg==
X-Received: by 2002:a05:6214:1252:b0:917:7d92:6486 with SMTP id
 6a1803df08f44-91ca4a0c511mr173181156d6.6.1793629381607; Mon, 02 Nov 2026
 06:23:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260824184019.432703-1-max@enpas.org>
In-Reply-To: <20260824184019.432703-1-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Mon, 2 Nov 2026 06:22:50 -0800
X-Gm-Features: AclHuK-al9_fk_gWf3tmNtTa80C7h_iFVOnR-naeSMTklj7rwoY_cjC4_EB5wQY
Message-ID: <CAEc3jaD8W0CZ+V06c=S2V8oR+UwFVKd8KGbtNhzBm7Gv5XnM8w@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND] Input: joydev: Don't expose DualSense motion
 sensors as jsX
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max,

This looks good to me. It was an oversight from when hid-playstation
was added to not add the filter to joydev.

Signed-off-by: roderick.colenbrander@sony.com

Thanks,
Roderick Colenbrander

On Mon, Aug 24, 2026 at 11:43=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> Without this, DualSense (PS5) gamepads are allocated a second jsX
> device for their gyroscope/accelerometer, confusing programs such as
> /lib/udev/js-set-enum-leds which look at jsX device numbers to
> determine the player number. Ideally, we should have only one jsX
> device per gamepad.
>
> This follows the schema started by:
>   commit 20ac95d52a28 ("Input: joydev - blacklist ds3/ds4/udraw motion se=
nsors")
>
> Fixes: 402987c5d98a ("HID: playstation: add DualSense accelerometer and g=
yroscope support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/input/joydev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 32459fd8a7c1..f49dd10782f0 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -753,6 +753,8 @@ static void joydev_cleanup(struct joydev *joydev)
>  #define USB_DEVICE_ID_SONY_PS4_CONTROLLER              0x05c4
>  #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2            0x09cc
>  #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE       0x0ba0
> +#define USB_DEVICE_ID_SONY_PS5_CONTROLLER              0x0ce6
> +#define USB_DEVICE_ID_SONY_PS5_CONTROLLER_2            0x0df2
>
>  #define USB_VENDOR_ID_THQ                      0x20d6
>  #define USB_DEVICE_ID_THQ_PS3_UDRAW                    0xcb17
> @@ -793,6 +795,8 @@ static const struct input_device_id joydev_blacklist[=
] =3D {
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2=
),
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_D=
ONGLE),
> +       ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER),
> +       ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2=
),
>         ACCEL_DEV(USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW),
>         ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_PROCON),
>         ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_CHRGGRIP=
),
> --
> 2.47.3
>
>
