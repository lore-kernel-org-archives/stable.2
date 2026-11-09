Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247938;
	b=qUEnZrbMHQcuuTX07zPGBq0cUv7SrAFN7AvRtjJ4Ua2yg3Wm50H1D5712SuiDABNexcx
	 h0uIId83B0V3Q4X2W1AdBf16MwmXCiPRDi671kclyAw+kEowEmbrDEk5P2j6vgc8zNz+l
	 gDU0TS1IYVSo8wPOsHqqtAMath+KxfJCtuP4XS0KZsjKO1/5tFdHkWzdAzXZ4UYr0t9//
	 kJEj2aU3eiad4SYytEocSDqZtocnN5IfFYBj7iMyyTahP8SaHYg3o8do59/DwlaGCktBi
	 QvxTJb5ET85zzahqvAUUuUNdLMGrdf05cS8EBIC9/dePmUWVI5zZhAM/+db7BjNZaDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
	b=pSvZQL/ob9GSwgIXHi3ZebO7x1F5sFksPuxlwb66lYgpCIdIL/CSgo9jqqm1W9ZHE+WS
	 edSeIY29u170VcbBp7WKhJe2MHRSQdbsh0s1oXHCXEZJ+7V+3rZpEvAiT/J6YWAQ9PZkt
	 SYy2+3sBxDwIkoN+a5c2wiZ0pzW0mIR4B0Ha6qvZaGvuWyLUQfYRD+MRDN2N1ndTL4WMc
	 esSQb4ZX46wFlfnoG5MZhJ1psM3eaEvOYG7pYM2MXLYsMKYkuhB2inmmL4PmAW/vrtzyR
	 KNGEwKgNRkqgv82MhW0QbGoI1vL6wC+KmyM/8OwbrIb8DIgpgvcoKzXWpcGXRJ/8bZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYFkyAo2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650EB606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 18:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 650EB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYFkyAo2
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53bb57f1310so12696411cf.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794247937; cv=none;
        d=google.com; s=arc-20260327;
        b=b2xD8Y/BKkxGiyUo4IIdwJU2KyErG0T/oCxNOiF0jVgY5Bpa8Dqw0xz7Tt2/aioU4k
         cXA6vfnZUSkmtWbNo9NQu9mtBwuvovmsXGFbvT1YnKfMGkVfSro+4AyhDAkGwHQET40y
         IDL9ZQxzpYip1T82tyDp9JxUzU6V06/qPUDkho98cxngFXHIFWN5Q08S6lHvD+tvZGAi
         v94OX4CQj3UB9pX5zZEOXQQVFLz9OEz5m+hqxF02NO5rfMcDyG5cDolnnDxMzxbkuL2Z
         OxGuwQ2lk2J4pOgruKzaqfsFsmqHCDoNV5+zQxrn3TPOGHA6FIW6S9HlvE0U2AZC3oZi
         MCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
        fh=DiGGQnIhDvVqsuqdCBdNxCVq6q5a1TK24/cZ+s8eiww=;
        b=RAPrEpmC2vjOA5Q9ReA94dRizsJhGq12/yrZpSYJs1SCVn+GtR/U6+fHwi+Ym2buIO
         Xbdq5cF140uR4T2e1bcD/I7D4wp/BKfrEF/+HeGQY98M5wJ4nCYq+BJ7TddS0wF3GirS
         68lvzX9MYyzpcgNvFNMY4oSnrcnmsO9M+WZ5KulKtI4tkt6Vd+2XmN4liKCNdNu5h54M
         ZKzuqQecy+lp28w+wVaEzjKTG8XERTDozTexhRgLGeSGuOMFSJoBfN50T6uYxq4SIP7z
         3R7RLOqktck6aYkb/Wtc0ihRu0ijXKdQ+94F1Xxgxga9x3BBKdCOnZzF2qFsVfJJ+KXk
         nzbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794247937; x=1794852737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
        b=jYFkyAo2Kyv2q9G/ATbzjr2YhaIdcEZRAXQnEn6SRzTaE9eL4W/QVLk5jZ5iVUllLh
         sYQpHzdVFPcAeb7sNiviahcxwgzZqBYK3Dttm0ze5X/GLlwEO3MVErU7GpImiwh6V14M
         0sG6ZP5EYXHy4zMDL4TLnqC78Qk2iCOnbM8uBRjli+FCmeYoTKhrKmtbXH7nDSBDaLlc
         08F+Jf22vhVTOO062d+btL/der7gis/haSuX2fHGNNwOkqcbzjiWgTbVYroaRAL4f66o
         n7su4+HNqq6ukX1N0EikxdtggPHkmUa2xOgiMRuTdNuqbbpmcy5QQXPA44Ox3LC/lTZe
         F06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247937; x=1794852737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
        b=PSX2tM4qfTzrVawVNvWvD+GNBiMeMqBKrGIsygteOGvDz3FD1IVwTtY3afKRdgz89a
         HY15ZPpG7Nj4y7dMB8pSNns0XOUN066+1M8XG6TwvQzsrnojjXbwVDhnrsOaJzq5Ndkh
         xTtZoPNSFfzCePfepVZiI16MrfJwJXe7Jkgcr8WpPDe5Lo+NDM5qpVGtBw6XrfpaA1gX
         CrhB8FjWHQ5YXzspQsSY0Q9U7ATc6bG7eOHga23t10rv+gr1mhuFN/qa//damcp5Zryj
         AsU5+Q2TOQxeoM7y/0FVUfrVumX+ccar9UPDTiGaWLPMHlzMv+jPoC0bPpxsM2FhrN6Y
         FnFg==
X-Forwarded-Encrypted: i=1; AL+hErE9i7QljjM+7wDeWfz+d7NGnnwv51I7pcans4UDVxhU9d0VsFoiIGpIzyLNNwhBkTzmfYKzeJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NV6l/9V0LXgUCCXGqKHUUBV3JTDnjAy37qdg8C7A+NMCwovkI
	ObrtboPvxTvWUvR5A6II/veNXPGQzJeDG0wzlGxt+nq/YesoVXcllTJmRm+P2qE6C5OG0BtmBNq
	Zx0YucFYHiJkUv2Bz0jLSfl2KQ7RXkTw=
X-Gm-Gg: AYBFou2MJJe5FVOgXjRSy7pnTQP/waUR5cUCg3HBPWHoxIQ95V0MGte2HMC1Nrrt8bb
	oX9ZBQhHyNuzYG1OlSvXk5ydWxAFla9rD38+smwi5pRR9rQ7XyaBGpgEgFR3RyQseXCMQY8kCsW
	q2m+mttKYRt1QKlciN0l/HC/trb+Ie6yUksRTHgpHGqOU916kpcYuA7lpymI4XSQtNEALLrn9p+
	0tIJDHE4eD98QAFkE/xSqxLJ6PJCbwp3ojmQDZASwpliMdksieVfN1pUhXU24xcSAkpBv9NUVbj
	Kz+DN22I4GUn8njLl/0b6YkbJiyoOHdulbJz2fgXZtFWcT1keq8Q3F/TQ0hsJYPX2Dwc5SbS4Hv
	9A9OWftswNbaaSnM84dkAgn/LM7w7QZKc2bMz
X-Received: by 2002:ac8:5a49:0:b0:536:6c87:ebdd with SMTP id
 d75a77b69052e-55527133c46mr2041511cf.14.1794247937229; Mon, 09 Nov 2026
 10:12:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106213526.3393779-1-qwe.aldo@gmail.com> <20261107012636.1008932-1-qwe.aldo@gmail.com>
In-Reply-To: <20261107012636.1008932-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Mon, 9 Nov 2026 10:12:05 -0800
X-Gm-Features: AclHuK_GFmi3iEIOGHod7r7_OlLsZDYJCh5KSeGDmqGi69z7Emf7p-xajIEWGmY
Message-ID: <CANRwn3Rt_zT5jwCvgbC1J-V1EUzLKKqDC+aDrgt=y1HkzpzYuQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: wacom: validate battery range before scaling
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:26=E2=80=AFPM Aldo Ariel Panzardo <qwe.aldo@gmail.=
com> wrote:
>
> Battery events divide by the difference between the logical maximum
> and minimum without validating the range.  A malformed HID descriptor
> with equal limits can therefore trigger a divide-by-zero exception.
>
> Move percentage conversion to a helper that rejects non-positive
> ranges and accounts for a nonzero logical minimum.  Clamp the result
> to [0, 100] as an additional safeguard against out-of-range
> percentages.
>
> Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measure=
ments to percentages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

LGTM

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> ---
>
> Changes in v4:
> - Reword commit message: describe clamp as a defensive safeguard
>   rather than claiming it handles a specific ADC scenario.  The
>   caller already filters out-of-range values.  Code unchanged.
>
> Changes in v3:
> - Drop s64 widening and div64_s64 as requested by Jason Gerecke.
>   Use __s32 range with a <=3D 0 guard instead. Keep the clamping.
>
> Changes in v2:
> - Clamp the computed percentage to [0, 100] instead of returning
>   false, so that slightly out-of-range ADC values do not prevent
>   battery registration or silently drop updates.
>
>  drivers/hid/wacom_wac.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 361738b..36bab07 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1960,6 +1960,16 @@ static void wacom_wac_battery_usage_mapping(struct=
 hid_device *hdev,
>         return;
>  }
>
> +static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32=
 value)
> +{
> +       __s32 range =3D field->logical_maximum - field->logical_minimum;
> +
> +       if (range <=3D 0)
> +               return 0;
> +
> +       return clamp_val((value - field->logical_minimum) * 100 / range, =
0, 100);
> +}
> +
>  static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_=
field *field,
>                 struct hid_usage *usage, __s32 value)
>  {
> @@ -1973,7 +1983,7 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>                         wacom_wac->hid_data.bat_status =3D POWER_SUPPLY_S=
TATUS_UNKNOWN;
>                 }
>                 else {
> -                       value =3D value * 100 / (field->logical_maximum -=
 field->logical_minimum);
> +                       value =3D wacom_wac_battery_percentage(field, val=
ue);
>                         wacom_wac->hid_data.battery_capacity =3D value;
>                         wacom_wac->hid_data.bat_connected =3D 1;
>                         wacom_wac->hid_data.bat_status =3D WACOM_POWER_SU=
PPLY_STATUS_AUTO;
> @@ -1981,7 +1991,7 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>                 wacom_wac->features.quirks |=3D WACOM_QUIRK_BATTERY;
>                 break;
>         case WACOM_HID_WD_BATTERY_LEVEL:
> -               value =3D value * 100 / (field->logical_maximum - field->=
logical_minimum);
> +               value =3D wacom_wac_battery_percentage(field, value);
>                 wacom_wac->hid_data.battery_capacity =3D value;
>                 wacom_wac->hid_data.bat_connected =3D 1;
>                 wacom_wac->hid_data.bat_status =3D WACOM_POWER_SUPPLY_STA=
TUS_AUTO;
> --
> 2.53.0
>
