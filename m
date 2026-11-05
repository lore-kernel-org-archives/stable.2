Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899592;
	b=nxKqlxQ+wva+634XIHvKn93fY/sW94NOXC84SJLRlBwBNikkcrTNUk9EH4oEcAkUZSmQ
	 Lu1oiFybxI59YSblNFWUB+8Rst0d+ZYDvGrFrHy1CXSLdEkvRmMmmGu/1Imtjkdn7lJDG
	 If4PtSKu6JIgkYm9TYYqtpja/Ju3N5GMnMMiZfAaZtD3RZdMveLjY3nsKjAZip6OHiuEb
	 ZJyJuYjGlfsMcH5jI5+imcgIOFKGhA8Jo7vx1hztAqMixJwyZP67t8aEs5zTRYKKlyjoW
	 6NkjGFQpHwqFvvkwpyH2E+lj8nSt8ezsqM7VUvt68hz6d0rITRx7NzxqZ7rItRnPbZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Mu84mZSij/3CB+1sN5Dy04N9VPY/s4lXydtYOJyIYgY=;
	b=VKhD1kfM1zpD+JbEae8dAeOUU9CKW74aRofD4oZj60vAbZIJ2N8oJor7BvHOEjGT7Mbi
	 i8dzEsyfb+KBRANDL9T3ejfWibkZ7lrPIyWddq+Vu4bl3QtbaR5KEubh2wqRe2QTYbk4b
	 vBAXTeJN97v1iVWdfKIX5XtDuAVyEdXMZ3Th6gd0y2GvwakKGDIAs/OFCIojbRBTAPSSY
	 vFKinFooQ9dU53uTXf86WICmtTQYCP6HRvtDcGTmrFvYmbqy3d/xHhE0JvJmckqG4zjT8
	 uSwcHpsqfS48gWiLm04XQ/PUsRiJY7ROR5T9wHB56ZgOpTE1QZVQDSzHBMHLc1lWNVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zXTOi7sm;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8E606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E8E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zXTOi7sm
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1156343f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793899591; x=1794504391; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mu84mZSij/3CB+1sN5Dy04N9VPY/s4lXydtYOJyIYgY=;
        b=zXTOi7smvXvipwVQjvMIs76ZO6ni8197RoO2H/+cJW7nTJcus1O8whu/l5eM5zZrZn
         V4U6Y4k9a3NPkhjFJAFG5IjS2cnap8ZQfKqsJ5sEG75ZPBi7cOBM6aKLOHIUboOfjlZH
         9sWhtVP9CQGhD+LBjywZjQTi2SwVCmQmS3qjUP/Pnnn1aMFrt+IuPe4U7kT1RSeumU4G
         /DlsBiMWvaN6VqKG9BP1NnWQ3mUR9ABPrmlUFd7gJDJ7m0/G6HAWnV8wUGOQvtKbXZsX
         2wl2w1SDC7fj6PuQjeFTnZrW8G8c5+Xl+sVgxWx4EVxP6JiE4h9LGf6yDa3yD+2CEUJV
         GcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899591; x=1794504391;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu84mZSij/3CB+1sN5Dy04N9VPY/s4lXydtYOJyIYgY=;
        b=riiG4I2gik1SplcFTMgpQeZ7J7KHTrP2pgoOMlss2u4E3j7kdgRV1sfYZbsA9rINjN
         gAn/z/D2Hz7sgoYi9n0NPzU5vkeIx/WBlq8NNUMZJvcLXLcTFlyB3rQzKzrX+1gH6BHC
         ZQm6i6GgGiUKzFMG3OgyQxvV7OanwYHlL3nQopuwz0qQXz7WdawE4/5X6BNzK6fwB+lt
         6hT9KRJxb23brrWMJUeAI1Ir8/kHxGPqtTzmCtmAr8w9o+z9NP27z22QQr13kEyShsox
         EkusKAdoYsD/MqfkE5z4MVxMdncYN/J2+hbKCAZcHnDN7jojgCjf1jBROw0x4Iaa4Qqo
         p5Yg==
X-Gm-Message-State: APuU4Z+Qvq2S9UtlZFsUvzWHS82O6Q/0imIE73T4Qhop5Zr6mjZzLXFN
	pvbxRQTG61dFzFx9zTHpfF58YVzVyRg589Dt/bSfQWDN8zr3dk9RnOQHkYbDeCckP2k=
X-Gm-Gg: AYBFou2/0XO/96t3DQkhTATSBTwq42ZzTgBM6E6MMMui0Ccl1yj+BmXVbS0ScB9tEve
	H4DGS9PcvixR6oIlnztjVPkUS6XMt0NrxUnY+vC4SWwI03T1+8Oyx64dJzmC/aaAp2qSEFL0n6f
	8wp2HznPNwlpjv4S7AhU0sfn6A1Oxa/SAjRtsDu3LC9thpOpKiOuRZ9kO6X7ewSf1BwTolua2kv
	X64okrt+tmDIDnvr4uqdTyEeUj4GGLgLPU4VKJFE8By3A5euQyFh8Uutai1P2g8gmXYHjPEH/MT
	0+YwSXuMa4ylKQwEI3WIgRCk8ugVHO57anG0Td8CuEp7kmOwuzrdDNkb9L0FWbZj/khwtYMh2Sy
	UOSs306TqKpwH3RNJUyapirRj4Ke0tBzkWmudWbjv0A7YSGTruq+nqvOtnk1he42fVV3QmKzR1r
	ODM9ORdftvkQFB8RpGvKjRPV5AgFa+vxyEc75hJ12tl3mYohl3dr3pPiZ4RqS5YphTSJDnkNRU/
	9f0klTEpy+c93Jy1/PVoZGo2U5HPZmtCj6nZFCLNiSidyxGlP9AD+HzhP527HyigWDzQWidHI61
	GpdBe5AmlS3nO6Yz7Qa0YvT5uC2P0SmUGA==
X-Received: by 2002:a05:6000:260b:b0:48e:6f76:dea2 with SMTP id ffacd0b85a97d-49277d9c77cmr519333f8f.38.1793899590581;
        Thu, 05 Nov 2026 09:26:30 -0800 (PST)
Received: from draszik.lan ([109.255.181.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed5538basm10657579f8f.44.2026.11.05.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:26:30 -0800 (PST)
Message-ID: <5f5613d5e9679307c992d613823b0325ed958234.camel@linaro.org>
Subject: Re: [PATCH 05/10] regulator: core: Hold supply device reference
 until constraints are resolved in regulator_resolve_supply()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown	 <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Thu, 05 Nov 2026 17:28:55 +0000
In-Reply-To: <20261104182148.1176116-6-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
	 <20261104182148.1176116-6-lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9+build1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Lee,

Overall looks good, thanks for catching this. A few small comments
below:

On Wed, 2026-11-04 at 18:20 +0000, Lee Jones wrote:
> In regulator_resolve_supply(), set_supply() previously consumed the
> caller's lookup reference on &r->dev without taking its own reference
> for rdev->supply, while the concurrent path (when rdev->supply was
> already set) dropped put_device(&r->dev) immediately after unlocking
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I think
"called put_device(&r->dev) immediately" or
"dropped its reference immediately" reads a little bit better.


> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 935fee27f126..6d522731e4d9 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
[...]
> @@ -2290,22 +2291,20 @@ static int regulator_resolve_supply(struct regula=
tor_dev *rdev)
> =C2=A0		supply =3D rdev->supply;
> =C2=A0
> =C2=A0		regulator_unlock_two(rdev, r, &ww_ctx);
> -		put_device(&r->dev);
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * Supply resolved by concurrent task, and constraints set as
> =C2=A0		 * well (or not required): fast path.
> =C2=A0		 */
> =C2=A0		if (done)
> -			goto out;
> +			goto out_put;
> =C2=A0
> =C2=A0		do_final_setup =3D false;
> =C2=A0	} else {
> =C2=A0		ret =3D set_supply(rdev, r);
> =C2=A0		if (ret < 0) {
> =C2=A0			regulator_unlock_two(rdev, r, &ww_ctx);
> -			put_device(&r->dev);
> -			goto out;
> +			goto out_put;
> =C2=A0		}

There are three locations in this file that still do
'put_device(&r->dev); goto out;' in this function and could be updated
as well:

* the '!device_is_bound(r->dev.parent) exit' around line 2264
* the exit after regulator_resolve_supply(r) fails around line 2275
* the 'if (r =3D=3D rdev) {' branch around line 2242 (with a little massagi=
ng)

Then there'd be just one place that releases the lookup reference.

Cheers,
Andre'
