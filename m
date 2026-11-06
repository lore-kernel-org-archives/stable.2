Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994542;
	b=vVgwr0t/zEBK5R4Mj/od/3kEHgkh/sfAcz0Y9QxBpGrDt1og2QELlm7V4V5qjhm07Qqz
	 cw6N6mbeP4kMTKf5/K2xNW9Ng4ZcqgOUemqnhjqnX8bL9unT6FGU8gHu+3OTHhGAgT7Nr
	 7wPcx7TbWxsT0XIKOOQUTN5v1aPBYUloj+H6Nf1Knek/6NB9znmuWDAIeLCq6UcgH5L6w
	 pJ51RZzk4q4Qjni73CmfWObmS05mYeRGRJcgWxGKwh8tegKQdES5Vwp7ImFove+/KgAwS
	 eAiN57kzWuWpKYjAYd0Y53BVZoFs+bKhxYYqeLpJuDOQEnevZ1SCfBC7zvE9rwD0aUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
	b=oDTK6nwVuEZBd0Fz52i4L9iBLo+4oD1NKKMBxAjS2VSZyBCqKxd6DIfklTNIn8SCdtsw
	 bNB0DgHqyV5s//IMkOYm1uU4EL8Wv2iMaWdZfFZ+F7wApg1rkLw+2JFKLuJ7TBM3jq0bW
	 nXu0DBT4z2lGhD1zocTcVbL49MGf0/P90Y6Wn1cPiOjBMn+d+q/GQBk0ss6+siAFHlRMt
	 LVcuJVSWXQuhk6WVIGp6M+4a8U5xs1WELPGMSbJdzH9I4rStWBAG44gHWoYdGsaU+Tzgy
	 Baf4B2aCU0dLEah2Qie6rQ+wKQ4Di0TlWP5hngG88kKKlyyUn969Ha4h5k0I7DRs6Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyPperED;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF3606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFF3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyPperED
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-54d9ac78f2eso7899051cf.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994541; cv=none;
        d=google.com; s=arc-20260327;
        b=IaVhEoQ6Lnv4xqTZj+s4sc4Xvfy6xTt/jRTHgiNXwjikwm1D2Z7vmcjg0sHQ6mPx64
         wzYp4lu5PmT81xAOuO1PKCIQiC+gGFDFGYMDEnVy0PwhUsed5TrVN2I3HZHuJIBt6Zm2
         TmTOZZC1cPA4mnGYHZdKVzbJVGgD5B0Le3eT8T2qPbYXg1W3Cpv9tLl9DrGA4ZoTQTri
         M8KXR/nGgrzuNKU53L8XhdMoyCmNw3mhXS2uDkRRkrW1bx2P+ihbA2R2kZERxcZZfATS
         J6Np2L5mJGYL2fwLqnZfjf9KxTaHakM/o1zzZE6JaFfmltm4BEucGu3LcPdRa9IfuJ1u
         GYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
        fh=VIOOXPJWTNSzsEFse4UrIAytSL8AFEuHUBkgXEmiG2Q=;
        b=JODPYrLsb6JN1P0w8UrqkfGKdD9lM58SinpfBZ1/SFBQZpU3Q7im4EKq8RHP81jTOs
         QxFIE/uViG45XxuLlG/LJTTVLKnGEfPFO1+ZOM8fzqIWUYWkRw2yrz9XVbk3aYL5ciKp
         6bJoialvjl/n4ECrNpSl8Hk+YeZI9/+mk0kapEC+f4tgDPLtLrqsz9+qQg9ocEFQlFGa
         qUC04tvblPWdiP2L2Mgw0iZL3Q2H3TUl65zZgbytjibWfdWgHcyLqOj79f1u8XfbXQ5S
         1G8b8cT0ZbVzIqGL0nom4mk8VU9jxU6x5o40GcsdMafZ7CkkCfO7QrkKhe5uTmxAlD7C
         zDzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994541; x=1794599341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
        b=wyPperEDJFDS5ADQ8nuKsgHhpHE7PYSaU768vbWgKoHreydewdmho6uuzVeAienWkS
         /Yn0kyQMk0a2dfdx3CpmgxlEM7P3KliO1+hXpHPemuBw6uZthvK0K6E0NpGJdf2oQ0yT
         KVlxRUguqQtWBosSe2XX0crKRy0NPNvCnLgsPQWrURCxCYt4d8CgzO/lxjKESf8aIyWU
         9wJpLYrsCvMmYtIiOe7Rr+McCyHoIap5CjwpiRI/CbZTj6gt8vpNPj3kMgRQjtz+BWu/
         MtazFNqZ6mzCTGo+5m9IOYWmvtE55hAlfN8JXQ27ZUQHn9D1jXPpRDmPGctgcnW2+D3w
         2xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994541; x=1794599341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbZu5q+W+xtqYiktZfPU34LNXZ8FfBPEek4cd/Iy6iY=;
        b=mU2JiH6L3RwTzfd9mVV51wOw+foS4Sp9DCjRCi3XhuJiQx6VQa71AQDmiINx5JR5Ai
         jfrZsAe/c5CutRAmgP1GNnPqZ9jJSdUTIvL03ZQlahG6Xat7qvGYwhIakDWe5myFDYQd
         0Bjv+syu+QqkV64HG9tn4ptGX9qzH82DeXdxl3nsNthgx+ypGBsoxwhatmtINL4R/8NC
         OZ87viUAT2btSmYH1OMscCS0ddMlzPC9QiEIQ447qUe4eAJ1hBNb5PJLQWCgvjVhIQFB
         r+h4VnmhQMp9mj9fh4fW+wWC48XDvHoSYgeieJgRmoJxPJGdbrp0lfdtBgb2ERUk5zFM
         fPlQ==
X-Forwarded-Encrypted: i=1; AKwUvBypxv543dVe7cY+HebgRvEboEzYXv4bOeFUf1U7jU4QC/OFe9BYbog1XLZDOeXSNk68dr1a2as=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TLu6iKlioF3cgkTaXOGV+U2mM81bJ1v0TBSw3BGx1B10QGXyt
	JHyAGPgtI6Ww4pG3+Y1MMjC5LSelC5G20LGShIJ2iS8M6qOURpP9eLGBlZCDZmS/fEjkvhJZvkd
	F5qB0pV0bAq2CGjINb0m6tOtgK45x0S4=
X-Gm-Gg: AYBFou10Z5l7cAeBQ/rveRoGwuIrLtb/IrIKN5EPghqekcxRecdbx6ndmhFapH+/l3e
	+VQ9AwY49dVqaODH3a7wwCLw9pfKRaf+r1aHU8eaEH68m1CcRrCHCH3NevRSsBufkKCSt4Ti+4p
	pk+tYZ2eUvSBtzqYXPTpokxdFF5YYufkIFKmsAmHfJ5UlZ7viFdVuKChk4Vff04iA2qK74Bxfdk
	qGTSSOHqysHx7QpyhqPLLNTwPJNH7ac2vUU+/mKAJYTdke8ycR5JrdKCMTdgJTrfseDNWDuDfum
	9FQLMB1+tF/hNenbSU494IOszM/CzK3tNeqAZyHhXqkGtF4Y4OF90RK4xYbAzdKLF8Vk32EDDQ0
	VEPkU7n7AD0hQWhCBbza1eMmta69bWYlfBfy6
X-Received: by 2002:a05:622a:5b08:b0:536:64c9:b1af with SMTP id
 d75a77b69052e-54e1329ad88mr53720801cf.24.1793994540966; Fri, 06 Nov 2026
 11:49:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260915041248.2432629-1-qwe.aldo@gmail.com> <20260915042546.2454238-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915042546.2454238-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 6 Nov 2026 11:48:49 -0800
X-Gm-Features: AclHuK9iaJcHe9K1bRdtuipGjw8e3uQB2h1pAJywOj53Kvv9pWIoHDLbZ4NPWUE
Message-ID: <CANRwn3Tt0VguzG=_azEZAP8vfxr0BbyWj=Nu-R3a0TA1nNGqog@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: validate battery range before scaling
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 9:28=E2=80=AFPM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> Battery events divide by the difference between the logical maximum
> and minimum without validating the range.  A malformed HID descriptor
> with equal limits can therefore trigger a divide-by-zero exception.
>
> Move percentage conversion to a helper that widens the arithmetic,
> rejects non-positive ranges, and accounts for a nonzero logical
> minimum.  Clamp the result to [0, 100] instead of rejecting
> out-of-range values, so that real hardware whose ADC occasionally
> reports slightly beyond its declared limits still registers its
> battery and updates capacity normally.
>
> Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measure=
ments to percentages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

I realize this is *very* late, but (similar to the just-reviewed
sequence number patch) I'd like to request a version of this patch
that only addresses the divide-by-zero without introducing variable
widening. It is unlikely that the range of battery values would ever
exceed anything more than a very small fraction of __s32 so the
widening (and associated requirement to use div64_s64) feels very
unnecessary. Checking `if (range <=3D 0)` on an __s32 range should be
sufficient to catch overflowing and empty ranges. I think the
introduction of clamping is pretty reasonable as well and should be
kept in the v3.

Again, apologies for the delay---hopefully we'll (finally) get this merged =
soon!

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> ---
>
> Changes in v2:
>   - Clamp the computed percentage to [0, 100] instead of returning
>     false, so that slightly out-of-range ADC values do not prevent
>     battery registration (WACOM_QUIRK_BATTERY) or silently drop
>     updates.  Reported by Sashiko AI review.
>
>  drivers/hid/wacom_wac.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85..XXXXXXX 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -7,6 +7,7 @@
>  #include "wacom.h"
>  #include <linux/input/mt.h>
>  #include <linux/jiffies.h>
> +#include <linux/math64.h>
>
>  /* resolution for penabled devices */
>  #define WACOM_PL_RES           20
> @@ -1937,6 +1938,22 @@ static void wacom_wac_battery_usage_mapping(struct=
 hid_device *hdev,
>         return;
>  }
>
> +static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32=
 value)
> +{
> +       s64 range =3D (s64)field->logical_maximum - field->logical_minimu=
m;
> +       s64 result;
> +
> +       if (range <=3D 0)
> +               return 0;
> +
> +       result =3D div64_s64(((s64)value - field->logical_minimum) * 100,
> +                          range);
> +
> +       return clamp_val(result, 0, 100);
> +}
> +
>  static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_=
field *field,
>                 struct hid_usage *usage, __s32 value)
>  {
> @@ -1950,7 +1967,8 @@ static void wacom_wac_battery_event(struct hid_devi=
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
> @@ -1958,7 +1976,8 @@ static void wacom_wac_battery_event(struct hid_devi=
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
> 2.43.0
>
