Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793271361;
	b=XvqrY9FCzT32CUksSBNJBHg00lwO79yNu/jKLaAdE69Z5JXRfzCEeY+8vrg28qANS2Hc
	 3TFRBcy828ecFsKReIkp4epjNj00FLtn3JOJ66JVzgSejqN5LcprLkXs94+CiDKGfFYK+
	 KPyc19knNcYQ6EGB5phh9P5El71UDQK45RWPSV/EyZ5JPvZC9FhCyaaDJTvetUEa+ZUpU
	 mPqVCSN1Ne+yTN8xlufCkzV3GYNjClLR4bwvxjyZjXPsGGwZZ5ks8qWcFwEdl3RCG4Sni
	 drQicx5VXkoDmzeLHpM0RONydThcBWHsXXHhDop8MGSl3wkmT4qQ5rov9uluh5hO7ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
	b=IV+7bSIOllQ7HjY0IUKPvwAVnXbfzBSqA49K04/vCI14M03hf67BbK3ZFvyR3Dze0JEJ
	 NYPb/IlreeTRNatwlELYEk9+XQFuBXm9BZFVfEb2DCmvvF4jyaxU1A1veNSwENisaSHfO
	 VsxHkOzhtJ+NGYOsvr4Mk7o4qBjWCKRc/DDQgDKBHiDYER9aG6Tdu+YrpnWs5uuVtfPP9
	 maNRogQrBzk8Xwm3+8mVO6MleJU54YzafPIJvfOqz0vmIspMFx4iAGmMDl5K2deGcSya5
	 DFUDp8SP4iWpFFd4i7zzjwNvVcNZecEjXF9pnaoMEJjmUdciMVFJdsrUpqKM1PRB6HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDa6YDIn;
	arc=fail smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1108606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1108606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDa6YDIn
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c434376dbebso127907666b.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793271359; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2Zr2nVjwm8wHiSL7w62pZQVUsZDKLkjqdCFeQpH6w2Na1EKUPefvipHiKZm2SXONp
         a3C1XZigEiTsK221CAMJh+A8PaBSxYombtQ0JX/JKvbFD9MvR0rWsRBR6pGkrMg34W3F
         0hMOCDjIc24XlEVwmexMfwbB14xl9KCNKVXQR+QlSXpj6sEC1yPYnX5S9ZS8ITk06eOw
         UzMxGgeMcxWt+wME+5LNmPPZDaYbDHV5SsHyct+kJ144yx3JqDpXw7aZxEGXxNbjWWBg
         cK0iZyEHVJzt/qOv2nLQVlC47VIxfi1IFvT2TRmvpqVyfvUXI2XLj87JAPmpmZWQNLzf
         Pg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
        fh=TSCGqJ+qhDThxNqTLcQn9KMKcvK7NFB4AYRMJheYP20=;
        b=rjkD3U8C1XbG4i7stuuS0v0JXEj7JTGrr76ul79A1FGuLOIL+YwulRWOnqc4o1bpy8
         u4d6Z9J392w7cp8H/ZBfItLDadJ74QCeiL8nl1paPsnDXeTsog/oognonymltaUP1JoQ
         KKFB4PWDggbWdDSCA0rJ2GeTrIoRy03y8sCv7XYN1KUH6a97FppPhl04XlOmbYzs0N/W
         A9+mwtw8Gz6FigiaaPwFRdP6i/AXCyGbdcyrLoN9A2pQPcz6GV1PpRbHSuI9xc0MrBdP
         IUL8zY2zDcSupKz85kr7xKqbKrpvdeQhjVcCWORVk3QN1kzEwoZi971EuOrT4l++jp3M
         gdbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271359; x=1793876159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
        b=aDa6YDIns00zqTqrPCKgp5NqUduDBvv/bV2D9/roX28//Qm4jLBZeNEDCJBoxLxGYQ
         3deQplSXIB4dGOBpsXUlzlSyGM8+f/V65tj2kzCO+HIFi23vUmupF/K2QwQrMt6eBNFz
         NvwDNZJi4UCAi4M0oQHbYVPmxVudV9V1fWpgW5IneFG2GZIFBXRNTcPKxhERt80v0+j9
         DBItCsZ5yudK5t35vTLzHsgO0WbzthAXGGQKmQPFzA3FhrDwQLCU+Gg0I/Icf18qQCSY
         xROhsSzumYexKJtliqcMeqogE6Zs3iKhWq58DD0amHAcIztBMpIfeCsfWWEg6e+3OZXA
         yIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271359; x=1793876159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
        b=YdMhImR1tVLC0cUfAeyeUbMXKsDFT+Tph5hOH17OqPrYN+S+50lL/oCg3boOqAkHrt
         +rHt5q6kGGUL19AG3U2MEG3QD1aZh8lYEg+DVqgKfoTJl9RJmKt0sxod1ZgAIBVHjIIm
         d+LGCpHRynanTx9gQwOM6hK9HUO24Offw9/asjQ7gDTF2qZLzBrw6f3edzL9NyI7zaoV
         aoTejuORgZL9nYIHmjfia6MNeIX8D4j3VaQqKW+4wMuphCDeDVGtWgog5gZfU+PeXKOd
         srVNRqgansBY7iUZqqJ+ScFWXA7tgh1bh9vq7GDRZ7o5XFCQp3NXxdn47lS5B923ozL/
         4CVg==
X-Forwarded-Encrypted: i=1; AKwUvBxzoiqBijXX3wqApLwOonU7Ano87lx7rOr3Rx4Bdbqlrgqmy03tLFjJ3rY99PlM7YKQQkn+LTc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUs8QIV45QFXMgPVkr36ccvQTfyrf+eqEfZZM5ImYl3HLEogau
	tADXlishqL/CMXvPX2hDxC2UAGNzqdXbtQFejKrk1KN6K/2LuBH+gaPDning/42x8kAMvPKFYHV
	nUetlEAMsWlCy11MnHuYbZ5ET0EwH/5k=
X-Gm-Gg: AYBFou2sEsN8q/MaPeblMS58MWdvfbkuIcJ5HPwolWcnDIJtrIg44x0eVSevGY7Wci7
	mJsMj6yZLi6M6KQwTaHLuAG7U+9leYLigZ701lYEhNC9rEvPLLgJjmAhGQzNoyFT7u5gMb4QdQJ
	W6Tl/qv4s7i/TnCw43ZTAqVmiTHFcB5ydvmJojdDFNu2bzUg3HkUIBxVxcrm5+qwtlcDBR4zaNr
	e0ElWOBj/Pk6kn5Lwnpyk6XHnm1yAMMkyuq4+3aTHL9XLJFWR6gO//8CymMu7DObQHfI+SJ4z6R
	rjnczYyJ3iggsaAb7pqPLUqPJG0AnNOtSusmzIfKfAmGKMqToZtEw40t5Etn9U1p3GhoKyGBsdq
	RsCWiVS68owRj0ByZtdrc1XvfhE/YPMkx6XUtuhG2Cag+FOZ/N0uIdSVdMMJrEJU8mYRUNQ==
X-Received: by 2002:a17:907:d308:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c49d13b7f8amr182816166b.19.1793271359214; Thu, 29 Oct 2026
 03:55:59 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028195133.86636-1-dennylin0707@gmail.com>
In-Reply-To: <20261028195133.86636-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 11:55:47 +0100
X-Gm-Features: AclHuK9ES-fJm4qV7qIWyYn7jHeO1ZZUKHOCjIZSlhGweuLSd8vCQZhkASRtuK0
Message-ID: <CAOQ4uxgDk-NQ3hrHLwPkLT_6T6EvM1Mxk1aOtCsz1TYgup_FNg@mail.gmail.com>
Subject: Re: [PATCH] ovl: reserve space for the casefolded name terminator
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 8:51=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> ovl_casefold() allocates NAME_MAX bytes and passes that capacity to
> utf8_casefold(), which also needs room for a terminating NUL. A valid
> name whose folded form is exactly NAME_MAX bytes therefore fails to
> fold, and ovl_fill_merge() falls back to comparing the original bytes.
>
> For example, when two casefolded layers contain directories named with
> 255 uppercase and lowercase ASCII letters respectively, readdir lists
> both names even though lookup treats them as the same directory. The
> same names merge correctly at 254 bytes.
>
> Reserve one additional byte in both the allocation and the folding
> capacity so that NAME_MAX-byte folded names use the canonical merge key.
>
> Fixes: ee95c5fc86dd ("ovl: Create ovl_casefold() to support casefolded st=
rncmp()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/overlayfs/readdir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 7d6f7f6022eb..6113d690f8ad 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -81,13 +81,13 @@ static int ovl_casefold(struct ovl_readdir_data *rdd,=
 const char *str, int len,
>             name_is_dot_dotdot(str, len))
>                 return 0;
>
> -       cf_name =3D kmalloc(NAME_MAX, GFP_KERNEL);
> +       cf_name =3D kmalloc(NAME_MAX + 1, GFP_KERNEL);
>         if (!cf_name) {
>                 rdd->err =3D -ENOMEM;
>                 return -ENOMEM;
>         }
>
> -       cf_len =3D utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX);
> +       cf_len =3D utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX + 1);
>         if (cf_len > 0)
>                 *dst =3D cf_name;
>         else
> --
> 2.43.0
>

Queued for ovl-fixes

Thanks,
Amir.
