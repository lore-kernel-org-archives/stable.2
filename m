Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990787;
	b=rWxP7+Cptqc2vRUMUflNOQ9i0yVSn/qgxMvNbuR6sgWVEXNACFVWMperlg1hh+j84tIo
	 SBxi/Uf9zKWC9KvL43bTcr75/6GnILXDqtVLvl5LtMVWElD60bVSg6fOyGyTk/HGvIG2H
	 NTLEdW3hCy5+c2Fx34e4lkU6pJbL14Iww/UiYKFKGmlY0dmbVvmDzxWCvEIwyODVRDxwY
	 Mvv5zS4JZOSKSQUer/qz5JhszexNv5c9vnnVb71lAjiIkKbfi1i8ZdlJ8Oyz5255/2Xd7
	 6XbpdB9BBuw/SPfvPqXg57L1L8iYMlQtMOUdCOZjf/TdrKozKmcRWctxLIq7NY5JgdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
	b=v6Lr8rUYJQ8u/m7cRf+/GZ92cqNOuO4GbHmxaBqJYhVbT7//xCpQB2EQg0AHE3C9VHtI
	 pKkL3gY/xZZ0AybQb1S04l3W9tdH8wym10RvSkJg2hE0a3Big1kOiL5cloISRqPX8J4sg
	 NXYHmO78kk+dAALNUmsTkPb+5WNuUANmyyfEt0QfGrOvfla1dpbYaiValcEgcQd3H1/5A
	 WTwSOdiBhNVMyYbfv/VYyxMX4LKz9O+2zfQa9E6O9MezWGkoabgfxz91P/vZtICZ3ZhHT
	 4R2M4/UGxFdGdw7D/4tgiaS11p1WQiUeVa0/VvObAgByPXBQt3/8uX2Pe0iasw5h8xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9HC86ZS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A88606A33F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A88606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9HC86ZS
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c895a0eso93270085a.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:46:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793990786; cv=none;
        d=google.com; s=arc-20260327;
        b=dRkg9UyBqeIxZ9rDZza+VQxAeq57JhScys7rYhrw9P7Kg6DwRsN21hoHNuIX3hdWv0
         he+HPaUBfMFo7tKzMgUTfgfdktjjgIp8TGSPaGrpMVE0CNcJN8YhMJ0coBZCoGSMcXPA
         ncT2/UrgS4WcO2bL/BklgpiXbCdA5WR4jPBBItCfwqIEJgsEIAVshhUBScSLENtJfzdb
         Ual5mInRRFJscTb+q3bcsQSFDnvaeskeP1wVpqgOhRadQenoklu1nPr1laOf/7vLdF6I
         QbeCjpF5WOdkqP7ecCyK/HNgECiHbs17drUB0KIZ0wxoA0cc+mRly15TtiqBuhJWO0hJ
         EWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
        fh=LGxIj5Km0DEltJlBOw3huHMzxGX89QjM4ziYHb+9eKQ=;
        b=SyHIm29JDd+m7Ro25DyxJI0GqfBUDHh5KoDvDCqccgmsQ6qsCjrPebdAhp+bgUCbpe
         Z3qUN+/C6ex1O11KgkgHgtyXAjLfHO85V9DxfywcE6e3XqzLbnH0Cjl6LVzz1EkUMNIf
         37lYsa8oZK5OL76kzd3SxmfCAw4cxy0O7nHvrCX5PvoCcPs5i6+qWrUc0IG4qwjl6cQJ
         2cn+F7WUFo3o78Nxv/Ff7k/Vu0vBmvL64C5UCYfsBb5bZKtIA+ewkzF/kNta9RhK9/t5
         DYywNmlbjJC4lkKbAz7bqG2gXLT0W3qyAWaPK9F6hpTF61JOMkF/YWQk8vCJzZkt1xwC
         y0LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990786; x=1794595586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
        b=Z9HC86ZSkUDNPhx/CjWi/SScFfOIPSHSo7vMWUh+XGsATmPW8BWEkCM6bOCgqO0Are
         20V/CwD73gFN96nZWlmqysgtlzg+CXzInQPANKnmNePAw2GtNLcDs57tXNMHpd95fp4K
         m5pRi6yR71ZCllopH7Ng9CmRbPV0moMMBHJ3IgZrdANixqOan7PwN+ZUAYblo01OJz/D
         mrnxC/fS0LoYFk0xfk8L5+mFtw8CSkAJi36Nr/tAeEtHUIaHNZA/EKAYiXYe2yn97+vP
         vY53r76H67QgodzNEezlF9MB/G0k/L8R1rgP+HWHFLFuJsYq4T4nDQNrbBQXwxpN0NTc
         +qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990786; x=1794595586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
        b=PpXut6D9UhYa+5GECAs+EORNN3l7QnJHAlqoYljGCe0jr9rF4CBpB665jpGC0JgPSI
         w97ZrK/ZS032HcU6RVvjasj+xG4NEBlbqw9gmvMlfJ4uVvSinoOji1nota32CexnGeOh
         LVyfUnOC7Dk7Ccvqn/d3p7Ma9l7BV4T8/1KKVJKz6Yz3NF6aqZS1fXnv28F90JdqgTTD
         UUsIFRM9JtAdpgUYMCKlhqg0ydQzoI4gbUGgPaGMNX5pVdFhM0IvMFQuqWrpUVytioIe
         DYipAJlLaJIm15QlkrzpZifhlk/cVQwOq9yb6DLWyjjr1f03wdMjTny6JjPQV4tFVsl5
         C2sg==
X-Forwarded-Encrypted: i=1; AKwUvBxzcahoa+xVRyv/snljCfWdlMTPKOfQz/QfHlUy375z1M/P7USOpvClciPOp4clFKmmFQvwqY8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KR3SWBfWuHvMiHD+5ZyXdHiE84HEoFopJHdkKm4UmShFwQmRl
	wqDKaOtloQsGON6luog8tV8BuLaegufi76YrhO70Knqo/5AV8/pUmv9d0Jb2rpvaV1nsfRdw2xh
	b0QO/nlp5EfKF5f2nrTC1zZYpDcbiPQY=
X-Gm-Gg: AYBFou1xehr0xxA94P4U4XHJwXq+eFLIXYvtGUf8PGBqEW2zL68hR8o2aonVWYNF2LC
	S/BRKVAJqlPpWp3xu09AsuXI3yAIpi4IIx90HwVOhHAd2wk1mcBu49hj5yAwy8Kxk00sTjXvXcD
	M5s+4U9flzzVWUdbxT7+ABAOFjjetAd+q/EUMVjGZlyzEX+8FhsmgsrHoyLxFDrAsEVFRyvMPFX
	1GReesBJnz2u0tRdhP7hiZOqZk2yWqu0Go/yOWNldEoR4ApKvVe1hN7Kj5dRIZOjFBfF8bsF0Dj
	a7pruh7OAskZ7WpCsjcFgy5WKzikI5Yo/faljf+C8RdIVDu1JrlGjb6chcEKlQbKp75DOx4pKPC
	WY5wM1Y/HjkKatqRXJTXwK5YqtoUHca0qGIMz
X-Received: by 2002:a05:620a:2b93:b0:942:a42a:78a2 with SMTP id
 af79cd13be357-945f34ead3bmr431647685a.31.1793990786229; Fri, 06 Nov 2026
 10:46:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
 <20261106120405.169399-1-qwe.aldo@gmail.com>
In-Reply-To: <20261106120405.169399-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 6 Nov 2026 10:46:14 -0800
X-Gm-Features: AclHuK_mPu4CGKBJY9JOjjdbWKDK_1Mvm3MPelFofXSeQQja0gast3M1vggbj_s
Message-ID: <CANRwn3TtcDdy4wgHCRfzecAoB6m3Jat0kNOd-AYPskg1OA9+Bg@mail.gmail.com>
Subject: Re: [PATCH v4] HID: wacom: avoid divide exception in dropped-packet calculation
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:04=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail.=
com> wrote:
>
> The dropped-packet calculation uses a modulo against sequence_size
> (logical_maximum - logical_minimum + 1).  When a HID descriptor
> declares a sequence field whose logical range spans all 32-bit
> values, sequence_size wraps to zero and the modulo triggers a
> divide exception.
>
> Replace the division-based calculation with a branch that computes
> the forward distance through the sequence range directly, as
> suggested by Jason Gerecke.  This keeps the existing int types and
> avoids the divide-by-zero without any 64-bit arithmetic.
>
> Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 1=
6-bit")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Much happier with this version! Thanks!!

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
> - Replace s64 arithmetic with a branch-based helper that computes
>   the forward wrapped distance directly, as suggested by Jason Gerecke.
>   Keeps sequence_number as int; no type changes needed.
>
> Changes in v3:
> - Replace raw s64 modulo with div64_s64()-based remainder to avoid
>   __moddi3 link failure on 32-bit architectures (i386, arm32).
>
> Changes in v2:
> - Normalize logical_maximum/value as unsigned when logical_minimum >=3D 0=
,
>   matching HID parser signedness. Store sequence state as s64.
>
>  drivers/hid/wacom_wac.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 361738b..1d3ae94 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2426,6 +2426,13 @@ static void wacom_wac_pen_usage_mapping(struct hid=
_device *hdev,
>         }
>  }
>
> +static int wacom_hid_wrapped_dist(int after, int before, int min, int ma=
x)
> +{
> +       if (after >=3D before)
> +               return after - before;
> +       return (max - before) + (after - min) + 1;
> +}
> +
>  static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_fiel=
d *field,
>                 struct hid_usage *usage, __s32 value)
>  {
> @@ -2551,8 +2558,11 @@ static void wacom_wac_pen_event(struct hid_device =
*hdev, struct hid_field *field
>         case WACOM_HID_WD_SEQUENCENUMBER:
>                 if (wacom_wac->hid_data.sequence_number !=3D value &&
>                     wacom_wac->hid_data.sequence_number >=3D 0) {
> -                       int sequence_size =3D field->logical_maximum - fi=
eld->logical_minimum + 1;
> -                       int drop_count =3D (value - wacom_wac->hid_data.s=
equence_number) % sequence_size;
> +                       int drop_count =3D wacom_hid_wrapped_dist(
> +                               value,
> +                               wacom_wac->hid_data.sequence_number,
> +                               field->logical_minimum,
> +                               field->logical_maximum);
>                         hid_warn(hdev, "Dropped %d packets", drop_count);
>                 }
>                 wacom_wac->hid_data.sequence_number =3D value + 1;
> --
> 2.53.0
>
