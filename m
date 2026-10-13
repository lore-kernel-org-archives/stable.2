Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5ED3DDAE9
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854425; cv=pass; b=npq6SYjJaFE68hugrxzMA39ApEDZomn3WXZbe/rtjw9VGWVL5Ds8I5PkKHNJ5fYbf3iSi3z7GuoT63x2mcHknieV/kMSWU1V6Ss7hrvBRSIQKsibHc0SXyMVnj3pWw6hBVw1qScIZpVyCy5n1ByA6rKI2D+jtMxDmOa1Jz3+JcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854425; c=relaxed/simple;
	bh=GLdPP9wdTOmg3Lh8rLtRDBnHGBuo68uFmOzknvlhkJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWKniL2zVW1hFwmutQ4X9v9W87+CCudYMMfX4xSFNKOdusyIcTb/e9Cq5keGAPX57xzqRJ8xz17F+IQ3nTlCosVZbJo5fr7pqVN/jq5VWM5qK5KF0LWUMDkQCydT1CkdCD+OQieL3wMsK7Dmz/G0MWk53OZomGqc1GShy0sOcb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDDr7RJc; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDDr7RJc"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2e8c710847so294418366b.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791854420; cv=none;
        d=google.com; s=arc-20260327;
        b=I5GoT83z3+N4/Txew9SdF1n9ulhQBMRCs5aeyoPtBd6eAJP7YzCgkgaD5ezdoCGAMg
         AS4KWb1Ebxw7lm6oW4/+GR6N9Ndf6r1EG8GhfzaUqgp24/r1BpfJlYGuZULV95SSf9oO
         EG3XF3jnRqgYRtcMqwHBhItnc3/B0X9hDfBn0US4wpfanF86eeoqtGvALqYKoHllu6YM
         1+1q/Mq66mOUm979CSagLa9E3mGFWaJi8H9rfRBy3Ban0poLgyjhES4+l5psXMdhsL3G
         ZGf6eT5RHq7954iEw+ZPeGywpYwcdM5di05CRzH6Btf8LGhI6wTSJ87AAUF1C/wJU2Lc
         MfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eDiCNa90nkNCt2ySXS6KYJDJLT9XVCk1KGiWa9GtHAM=;
        fh=sFXHbCl/qIzS4A1LdEBCGG1WFQcK2GLl6YWNIOWGD7g=;
        b=JzfYW93KFFhCrDBt8mQHjKOWPdWHqN+e+NQ0VE7rlPf8zXaTH/uqbKII1xXeIP4Aau
         5R98ciGEEWZh+RvXOIYkhVkxVBt6zO9RurMsIgT6QLxJI0FQOm5NfIyktjdXPNUIqKUV
         9AbhqH3jofMDkQp+klYgDiK56Q/G0TENp9UOXkjgsyIicO4lvKag2i3s61fXhLEGzP1l
         A1nyCfkRyh+vnru6C104p+aCaR50M+WUyG4J+iHbL9EpliT6vsoyg+U1WNuZfUxHZ9JU
         /Qfr1sgCa0hgDiC4oocpuc7Qu2LFsfKI8Y+bWDGvfu1xGBzfhzS/PAWMfXsTFsifD/G4
         KO4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791854420; x=1792459220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eDiCNa90nkNCt2ySXS6KYJDJLT9XVCk1KGiWa9GtHAM=;
        b=SDDr7RJcD50209XiYVlGtKVzVGK0341G6s7mIi4MXGNJwxjdSqXlxg1HTQcZyFUmZW
         svNrjobcTS9Z+K8eHEdqu3LithUMYDGe26DrcAv2VMgJHbXDl/9TVKHNlsKPYUwOlpUh
         jx/O4Ej9Nlkn0mW1BYIJz4lm9HuotuaZ4cbzZV8oIGck4kuNGSgu0rauz2FQEzzmyrov
         /nRdXsi7kuCXOYrKqpt5JuQaq5I86hUyQn0b8xmUMXcSg2JlkGFrYotlYTJz4tbkoVNC
         cfrSRuSOS8N49t606ivWj/66KLRTSfIHucO1UTPX+qWrD5D/pYcgDA2+Lt+8EZSbi5tC
         FOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791854420; x=1792459220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDiCNa90nkNCt2ySXS6KYJDJLT9XVCk1KGiWa9GtHAM=;
        b=2rzoZjnm4JEDiBQKNlxXloJI4jX0Hkhl1KAZ8t3NkMsg1UOGggeGhIyCj8Jf/tnnWI
         vQo2eaupNpam2HpZ6uVOqQknr+P2oqBCQW7t7a3Gs4Tun4DrIdhbZy8Q4DYE9MGkv5lq
         keGJ4EpVctDz03+3J4WPoymGH5roNOVxUZhRV62OTr9Ud1HPAi7DTVBYWuTXOxeZ1ZD7
         49yki4BUT5FWOrdxFKZYNfYBIynovB3+pZ4KrrbOUljP4qNl9a1QgQ8vxK5W1ttwS1C+
         TDOeEPJ4syJe06s+H1E4ux5HWBB3VY9txmsgYdUymPjIPiEwJ14iUkX+7omNNHL4ZGhR
         CxaA==
X-Forwarded-Encrypted: i=1; AKwUvBz+AVtY7q85DGCuuc0/UuLgkFdJuJJvcnEE36fnOX3cB5+rqY3H+L/JXZWWzpm1xe+G1EzXdAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJB1I1w4NcNErrUEU4vA5ZAx2zt2BENtm1d44cvUKAhVUjQ58rx
	03/ZWF+JvTOISjt8GpEv4nlSUoP5jcfo2ayq7ERQzNzSGFcWDuGAKUiQWOcoqi8oewLJUbUZ47X
	Y3TbwGaDMEoSfbwA9oDLh6IR03AbV4bE=
X-Gm-Gg: AYBFou22p06pF945IblX+1Afo6y7XY20sXtoHL2eDhSh0sUWR881nsIxa6U6BBL9MTY
	NKZs3LbTPBZXw5p1EGaeYYuHX4cV4Hww8gvmwTqrjnTpgHRQkE5y86dEXCELVYZwRsF573bWlMJ
	xMC66e4JY5Rd5ZAWWgRW10kDnYLIAJNiMYpinCZRfCfc1qrXUQyE1AwQHDKb8hr+baW/N2zndo6
	Z5T9SrTEZwSX1rFSoOjg9Xcw+e8xzYJuEyoZgRZZXgPtQ+YpPQ8obhfwHSFxrztdKY0evtIDnrA
	UP87nykzoBT70IZXyFv+PTOaVsxaZ0iVGlz3vq9KYdQ6GWbc4+ArJic=
X-Received: by 2002:a17:907:9816:b0:c2e:378c:8ceb with SMTP id
 a640c23a62f3a-c31a9fa39abmr1029769166b.36.1791854420304; Mon, 12 Oct 2026
 18:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791512067.git.zhoubinbin@loongson.cn> <38f8e7cde8e454e7c6b72cb1b9a1c54e67c8a7fa.1791512067.git.zhoubinbin@loongson.cn>
 <66a8df16-01c5-4653-9fb5-7d746f03f782@oss.qualcomm.com>
In-Reply-To: <66a8df16-01c5-4653-9fb5-7d746f03f782@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 13 Oct 2026 09:20:08 +0800
X-Gm-Features: AclHuK83THTSYAs-3kkd9FBwRhF3injKe2tsHVZYn3kSJvncbd8B50m-i70KpDA
Message-ID: <CAMpQs4KiGsC0=xwM+4M0GMWy9XEc60sTpPACK1s97p_JURUr-Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] thermal/drivers/loongson2: Fix negative
 temperature conversion in set_trips
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel:

On Tue, Oct 13, 2026 at 5:57=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 10/9/26 04:57, Binbin Zhou wrote:
> > The `MILLI` is defined as an unsigned long constant. When the
> > temperatures passed to loongson2_thermal_set_trips() are negative, the
> > expression `low / MILLI` triggers implicit conversion of the signed
> > operand to unsigned long, and the division is then carried out in
> > unsigned arithmetic.
> >
> > For example, with a low trip of -40000 (milli-degree Celsius):
> >
> >      -40000 / 1000UL =3D 18446744073709511   /* unsigned long */
> >
> > After truncation to the 32-bit register field this becomes
> > 1271310379, instead of the expected 60 (i.e. -40 + HECTO). Writing such
> > bogus value into the trip register leaves most of the upper bits set,
> > which may hit status/trigger bits and cause spurious thermal interrupts=
.
> >
> > Fix this by explicitly casting MILLI to int so that the division is
> > performed in signed arithmetic.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal managemen=
t support")
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >   drivers/thermal/loongson2_thermal.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loon=
gson2_thermal.c
> > index 4d40fc706a53..f5ff0cac1442 100644
> > --- a/drivers/thermal/loongson2_thermal.c
> > +++ b/drivers/thermal/loongson2_thermal.c
> > @@ -108,7 +108,7 @@ static int loongson2_thermal_set_trips(struct therm=
al_zone_device *tz, int low,
> >   {
> >       struct loongson2_thermal_data *data =3D thermal_zone_device_priv(=
tz);
> >
> > -     return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
> > +     return loongson2_thermal_set(data, low / (int)MILLI, high / (int)=
MILLI, true);
>
> What about using MILLIDEGREE_PER_DEGREE ?

Yes, that's more suitable. I've been looking for the right macro for a
while now.
>
> >   }
> >
> >   static const struct thermal_zone_device_ops loongson2_2k1000_of_therm=
al_ops =3D {
>

--=20
Thanks.
Binbin
