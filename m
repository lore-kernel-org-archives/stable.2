Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609055;
	b=mdW0kQPMHkNwsbjXUSGvbRJZBFIazynUqCid0yeeIR9oOeB1vbCLGbtqF8r8+KTtO7L+
	 gV58scNIyI7+vgtI6P13I0u9p0AboAqlVECPM4IFl4hogTHklgNDCuDAMKhB3/lmTGs2i
	 o1R7liOCaBlSiTsaA+77WQ8OPddTVONRShEzZbIp29iuGp3Pn4Oa/WgshRDozHDUF+dY6
	 P57ja8x4BXyOgQOFRzqKo/RmFAlE/8RGy3iKV8ts6H92y+R+dy5ah5rX8FEKz7y9ho4rt
	 ruxfKQSeybXUR9uE3k45FURloCkRKkuATGiev2GoO+jjY7KrIH1VHd88Lxjz80304VA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
	b=1MLkHEm32vFpnIGLmN45zsSx2a7jydpxLmoS+So7ioSR8blDjqwgIPMadzG03yV1p9/p
	 44vzAvmDHvhIC7pu79cUFi/XMyRNecBCqI86NI5YGTGrevxyvVYX/xfnem9aKOUCJ3R0l
	 7Yef3Iq8AYRpx4VAwIGd3S68uxby0nia31qqqrckOPjGd7ph1FmZ7XMhD2XeOXmGd+QrM
	 MOlpPtkZBXWKDFKJqVAj/Ghjz2LkNTpVzdOCAOApK0Wtgj5NOVZCCMY1HbOKwu05CGQiW
	 VdepVviPpNpldQ/JOmp7CB1tXvIqiSQegMBLLE/n2Qi6/AbxIeRhcc5vWHW/HlGLCgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmVclC5M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE1606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00FE1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmVclC5M
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-917b78dfe30so14931296d6.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 11:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609053; cv=none;
        d=google.com; s=arc-20260327;
        b=HsvnbOsYUjmAEM/8FZWytye4dVWrjMR3zUvM60IzRm/bnnr47Qmm+Rj/GWxCw05DQP
         8dmGAPXiWPjW/00bV82lSGIQxlwgLmd1w58uqrFbSFhTcmRTfOCdjC4vavxkLH6LlPmI
         VhF4oy5QMDHfYzrnaZC9rQNf58CCICaVNAaW2bJwNA9+l/zaIAURdOJqe30gzTdfsnZI
         AEuTV1rOHDWU4hBjDHlficG2VMJq06bz8bY6/tb7WYmbQyPCtjbUlIT1SJvEfdEI7Vaq
         OmWWavstfw1yPBazxkwCw0XY0A6FN/aWaJzqYwiVFVCMJlNILfPw8TE9wCriuRY76JVY
         kF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
        fh=nuUfgF4391CHcZtTPKmjA3O7ZWcTbA008lkL9ZoSB9g=;
        b=hz2b5gG/uILKFH0XYGun2WEzLsmb0Gbl0n+hqCGTfG0flNaJfONksYsVEryZtyGozf
         c3qR2lNMesDIz08Io68Vy1ibPRNIyPOEmLpJJnqwoTtrJt7K+0QPdYulyQ/vs+GC069/
         /thMgIktDTl/6Etalt1gNTMRHal/F/UFVmwH8QKCLnHYbRtu0Jyc+doxN/Oj02ivY0y4
         vJHQAWzdduMqS1zK+bKdeQ3nB+ZCSpfdYhKB2PyZa6/ELZ2go2w2p1v4ttigjcO3JFMf
         KplLaMGIkHHv7cuJZ7EjtIV5OiyrIslVNmy1rswfwr5upo9Gp3mO3R05Kair6QtEJNkE
         CGwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609053; x=1793213853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
        b=bmVclC5MlwrTR45BapWQgbddpL/QxFqMLlQtOhGHP08FQUvEZuWo3GWybvcGgbhhx5
         CWqqf7dJuQqmHyZQAiiycqSDdSXitDAT0MaC6S6UiFQ8Nm0sQu+TlAhY6S+5IeYPdZiW
         RzJakPeQWusbAGhcqb/WPvIFeQDMqGQOT1gB6wTdDou/74bERRmvj+zCS9x6jnHqLNA5
         qpDWoxDYmzaV5IVY+K+W/18QWkty48TAWqaQq2NsmOpQbohk5Z7MhbbkB4N0D+ZcxCsv
         q3nELFMt5li1271WxJim9KthYN/1ypAwRUntNRrxQAmX5v2dBTaod9gLrg1OhCr07RZK
         2KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609053; x=1793213853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxU+fpXdNAqE/uzoh+966DgHUBkiqVjMoTjja5oXr5o=;
        b=Smrq8AF1rQA8P8+e8gUTzFwIgb28YWVzcwO29HWypKNmb0R7GmcxVrwHT7G51v71SV
         m4zZkGkk7KsA7hpElzcoeHNdfdP08wm8QG7GRRhXAu1RRmUFlf4+lFRmggcyGcoZg0oK
         3swHLwPmsFgM3ZofHbGyqpw8WO/0FkqS2ud+BHXpDI84j0wrl0mGS8Oqn8mndhkY5NMo
         TRBmDSLp4jnL1QM3KDD3hnhT/c2QPZCSOph1I28yu7/j5EXFQiVn3JJ5Psd7Rh/d+27k
         thx8GsWsRd7ouI62SqDusFPjY8Cz349Zf0eE6rgKk3BK5xmwGnDJLaQSmkuehnN0PVEt
         QyvA==
X-Forwarded-Encrypted: i=1; AKwUvBxJJeORvNdTSoEdRRWx3M0PzAnjtv75+T24NP2ShBQTrxTUVwqqoN27p14iI/6mBL6nXWWfL/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6evTKGRPXqx4yChneGgCdYHTzsKALHceTrqb7cMvHlEIUjIMD
	UsikGxkLyYSFoIDLd2D+l2P9XRxQhH+t9Lp4ThV6q/Cf6moAi5rmeSLx3BvCYPOwEPFSLQ4bJz4
	9gP2JQfBVleNyIZQGS3fIphjZrZQm/uA=
X-Gm-Gg: AYBFou0ha3DzXOLQ32UCuz3lFArCJ0PnP4v41kQqJJJoXb4B03NxNv9VTWCjM1gvWXk
	hfhSCHQJ4IjVSFven5RcPykFaEX/JaU5qmYiNWc/prQ+rmBLfM3uEBR2lIZu/3P9f+3bTxZTm9k
	I72FKAQEejuppfGBbm4X8go5lWbUHFY4+shiCY745sDZIPK6WOVk+S4tfV+0DX9GnEYorqPY8pj
	mTXoJD6IwI509koZYafZR1EHisZiKXxJCjpoTJIANGBhZHzjpEmDOFwbbr2LQQc1naAqH68OOiu
	mz6T9TqHgrIbOn0+mQn1aWA/UhN07RQomt5gERxsjgwlpJ0y7pF8ypFZTfSCX6+YtdM5QuxnlTb
	RldNtM9f9gdSV8W4ZfSAm8Zp7NlJG1BskyyME
X-Received: by 2002:a05:6214:410d:b0:912:517b:40fb with SMTP id
 6a1803df08f44-91c12f1f4ebmr46726246d6.45.1792609052612; Wed, 21 Oct 2026
 11:57:32 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com> <20261018124755.850888-4-jinmo44.yang@gmail.com>
In-Reply-To: <20261018124755.850888-4-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 21 Oct 2026 11:57:21 -0700
X-Gm-Features: AclHuK9stdHp_EZ12QZ6ixOiQE0-gFWmsBr9NPmTz86JK-NBRQoQJ6Axr2WSgaA
Message-ID: <CANRwn3QaVYAvFHS-oLqChjCyhGdMFnmMvOS-jBCV7m4=cLYcpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:49=E2=80=AFAM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_intuos_pad() uses wacom->pad_input throughout, but pad_input can
> be NULL when wacom_setup_pad_input_capabilities() returns -ENODEV during
> a successful probe.
>
> Place the guard after the data[0] report-ID check and return 1 so the
> report is consumed. Returning 0 would let the caller fall through to
> wacom_intuos_inout(), which would misparse the pad packet as a pen
> event.
>

The other intuos functions (wacom_intuos_inout() and
wacom_intuos_general()) reference pen_input and a rough evaluation by
eye makes me think that they are susceptible to the same kind of
issue. I feel like it would make sense to add a check for non-null
pen_input at the top of wacom_intuos_irq() to protect its helpers, in
addition to the pad_input check you add in this patch.

> Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/=
Cintiq")
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> ---
>  drivers/hid/wacom_wac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index bec8dbec5bc3..65829de86363 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -581,6 +581,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>               data[0] =3D=3D WACOM_REPORT_CINTIQPAD))
>                 return 0;
>
> +       if (!input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: pad_input is NULL\n", __func__);
> +               return 1; /* consume the report to prevent fall-through *=
/
> +       }
> +

Returning a non-zero value will trigger an eventual input_sync() at
the bottom of wacom_wac_irq(). Realistically this shouldn't matter
since we would never expect a null pad in normal operation (so these
spurious syncs are unlikely), but it still kinda pokes me the wrong
way. I feel like update wacom_intuos_pad should be updated to follow
the same return convention as the other intuos_* functions where
wacom_intuos_irq() has a "return result -1" to allow functions to
signal "handled, but don't sync".

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....




>         if (features->type >=3D INTUOS4S && features->type <=3D INTUOS4L)=
 {
>                 buttons =3D (data[3] << 1) | (data[2] & 0x01);
>                 ring1 =3D data[1];
> --
> 2.53.0
>
>
