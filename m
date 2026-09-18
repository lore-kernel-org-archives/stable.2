Received: from mail-ed2-f16.google.com (mail-ed2-f16.google.com [74.125.228.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120949890A
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715297; cv=pass; b=QbBDG6xpgHIM0wK+cXcUg1RewPlSPL96TYQcx7uz5CjNWFsUq9baB1v2cG0yNyR0iBM3FR5I76kuULe/cAoRft7QAsiP5Q6M+cAnJkN8A78dqJx+2J1cmy/gU5sEQZ44Ub0dA9pl466WwhlOmFnDXler1HGO/ViqNne4bTwgudA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715297; c=relaxed/simple;
	bh=bS1OBGEbI/rm6/QMdPtmnFgaRhDjFdxnhujgDAx/RlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCDkkSYvm+Xhxx64R6uxxZlcLY7THZ4fpEiELUsf55MCyUcELEZIiKccBbG+qVLKYGzupasQcA3Ly8JRbdK8JAbTDQXp9PZr5zBbkTyjaYuIy2i4h03MluIqxYcnKs/MNH3vzPAxzQnmhOSYOW6+ufPHyDb0Fx6vwJfb2ZdSKjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=42LHbtGN; arc=pass smtp.client-ip=74.125.228.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="42LHbtGN"
Received: by mail-ed2-f16.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso639874a12.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789715294; cv=none;
        d=google.com; s=arc-20260327;
        b=d7aF5wbwcpwGjcaM9VAYjLaqzNFS/veWgIf+pTfrjI9qipRxPPfKFLHltk44xBPKIB
         3V0xDUNjSMhQ4DNj6fifA8FGxXZxjK6KNxaIhJiPBNXSA9zal7fHtiegOFG51LqwmzA+
         1XHqqUpQL7DyqJl4GaZDlnMFwCyYXeGxNyCD/oIH6Dy6i1R4F5GyjINFB5QSBuW+oHsY
         sWiLHMqjcF/ZYtouxlXYO92gPk2k4PBLyiz7/sCbXNpwG+GS0GikL1utXjHMV54arUHA
         8NyAszukoBY4klLv/KOTXkpaoA9DML8PPhi3KExFRbSPXcbQUITaVmPpw2FKUlPLLFeV
         +ZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=We4O+cegvJtoaqFGeYIsxacYH6oBV4cwy/gzDLBfJso=;
        fh=HY39/tZUkc29YSqt8nvMK3TsMN680W99hNkIdks+QSs=;
        b=CHeg9GZv1bu37QdeF+bz3xSRpvqk0D1BXieJRJJA6Tt8y5C4+RxhRVB7HjCZqHmid+
         S0ghD5vA1gGAwJAxWrRdPUNkm5emvlrRMgxCZiFxtp6oiN9nk+7s76QnUYwQ7Oxm6/6+
         MX9IM0OBDhc2CTVptiC0AGyGYdmTuGaGoHGmStEqEXc/X6OGnHmh/72ChQNevtEoyDY3
         cbr5/RbcGfkKqm+sIZvGU2wmAUk7okRWSpLhzcRj1/SnGDiVJKCNT6bzHHvqOFbQ5uHp
         K/bq6Bc4ck2wBkhdWkgYdydzuyGa5++3mkGwMbtf7fHrcb33kBdPxUAjSAecKL/fbgJA
         DRZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789715294; x=1790320094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=We4O+cegvJtoaqFGeYIsxacYH6oBV4cwy/gzDLBfJso=;
        b=42LHbtGNx4Y3KTaBwJhWR1fC/SRqir9xXlxi218hupWA5WwG/o5ffosEgGBVU56tgL
         WhL8jPvG5PR/Oh0LUTQIqcX8rubo7MA46fYhnTKPe0+jciljTW+UjdGlMoaWnOGgxDX9
         g38w2S+CvZSMNQvvLTYjJzbX2fKOYdxCCtYWnUz3kh0nJ+Da3FVIc5To2otqPbYlRNRj
         B/z2YCAb0WM1yqD1xsz6/oLpcYd3kIQlH9CPvfsTI5lu49cl6TOP44Wb0DugmVVR4oca
         Uuf/2u5yBCsGaO32R3QlYrBCxyFea2d2TfKk6ZbU7bWTRSMiYq3BLjWK1uoRl6KBwkyf
         t6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789715294; x=1790320094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=We4O+cegvJtoaqFGeYIsxacYH6oBV4cwy/gzDLBfJso=;
        b=Scl3HOMQ2O4AfHSsDmxZ2kkYYKtvYTTXa8CFF3YP8CU4Fy6Wr16C0AtFOUen5oSvD4
         YC86NoH8TOwb5qhF91gZa6Q0/VofwbZpid+bTL74SIl6faQ11VvtEbVsLuZ6hr+x04Yj
         +6oa65y1lg6cfxgGd5NZTb9H4znw/lr1Vev74cET5J4pVqM4c1Z/qAqOkPLev+JAX3Cu
         dXu1R31sxOi+YJbpq+ik4fPypAy9MKscNbaIj/03BKNbTiOP0fm5D7LfKijlRH1dQxlI
         ZLIWliEkU6OAeBu5VnM6IzwUuwg9eYlrLeMM2Qd1s9ltoft8koe2IhsokvmlqkF+uaDD
         uNgA==
X-Forwarded-Encrypted: i=1; AKwUvByKgkSfMGGfpcQqkusSaQ+uWTFVujtTNC5EqYcHkcjV6t40qRrVZJWvIiggd42G5cDzhTqGCRs=@vger.kernel.org
X-Gm-Message-State: AFuF++ksL20fPUrANUBE8UrKsBKCVDagEDiMJtlf794YrWLcctbU21uD
	19A918VaHO+JbVIImC+0R/Ptb+jbVnQFuPgQ1ODdIcRSwUloC3CcCcktF7Ka9wlbLcgDX/HNyPO
	eCsuoda/jypkX0FEV2FyiOlMjiiAqChluZYZyHvw6fg==
X-Gm-Gg: AYBFou0S+TO0oL+tK0O5YIMohgCgK6xgpw5bDNWkH5kvwu44ya347dwZ+kPqTpAtFt2
	b4ylhxGfYNlFj3g/OXvmVX3UN0Y6wA9vfFBEvSE8SseH7s8lrw8B7senWT+9Ybyp5f9jAMc6+kl
	JHpNc6aKT6oTJH7+oWbdFeyTP9e+eWkUEo+HU7givw8cbpQsuMLVQa5oYOQ5ZWp4hMymYk9awSE
	VKeEsNQ7vSOHZ+dTeoMlUPITCIV/fZbb7hGI8yJr8VgroEEM3nR1icijpcV5cO07HpPQRWv1/Zd
	ZvqE/AuVAiTgVeZH/iKUv5EEYXBZURrndHWi1Ydb+lbJKu3stz8YQMIXFPQnJFySas6iwkDdV1r
	H4/6iZwvnCaz6
X-Received: by 2002:a17:907:9481:b0:c26:1648:a069 with SMTP id
 a640c23a62f3a-c2a15e529e2mr150203666b.36.1789715293450; Fri, 18 Sep 2026
 00:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
 <CAKTNdwH9QAgreJ-6+t1j_P1di4VyoMBSsFkf_g=mCi_-M8g9Pw@mail.gmail.com> <20260917221857.GA4056431-robh@kernel.org>
In-Reply-To: <20260917221857.GA4056431-robh@kernel.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 11:08:04 +0400
X-Gm-Features: AcwNN1V38kIzvvjNiCjrlXv4QyepNlxjuEonBAUHUeInRScoNnYe7tr3v4fBPpk
Message-ID: <CAKTNdwH6E5=9gZHB6tdianC2+1aDv4wnLmvL59kDW-dR3a12bg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses from the OTP
 CPU ID
To: Rob Herring <robh@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Michael Walle <michael@walle.cc>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Sep 18, 2026 at 2:19=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Sep 10, 2026 at 06:48:33PM +0400, Alexey Charkov wrote:
> > On Wed, Sep 2, 2026 at 5:08=E2=80=AFPM Alexey Charkov <alchark@flipper.=
net> wrote:
> > >
> > > Rockchip SoCs are shipped with a unique CPU ID in their internal OTP
> > > memory, and Rockchip bootloaders use it to give boards which have no
> > > dedicated storage for a MAC address a stable one anyway: they hash th=
e CPU
> > > ID and patch the resulting addresses into the device tree they hand o=
ver.
> > >
> > > Kernels started without that fixup, e.g. straight from the SPL in Fal=
con
> > > mode or by any other loader which does not implement Rockchip's deriv=
ation,
> > > fall back to random MAC addresses which change on every boot.
> > >
> > > Formalize the derivation in the DT binding and add a Linux kernel dri=
ver
> > > implementing it, so that a Linux image can use the same stable addres=
ses
> > > regardless of the boot flow.
> > >
> > > Only RK3576 is wired up here, that being the SoC I can test on. Other
> > > Rockchip SoCs keep the same CPU ID at a different OTP offset - 0x7 ra=
ther
> > > than 0xa on RK3588, for instance - which makes supporting them a two-=
line
> > > addition to the driver's match table plus the layout node.
> > >
> > > Patch 1 is a prerequisite fix. The OTP hardware has its own internal =
state
> > > machine which only works correctly with serial access, but the curren=
t
> > > driver serializes nothing, which results in timeouts and/or corrupted
> > > reads (e.g. returning splicing a TSADC trim value into the buffer of =
a
> > > caller asking for the CPU ID, or mixing up trim values of different T=
SADC
> > > callers). Hence the Fixes: tag and Cc: stable.
> > >
> > > Cross-checked on an RK3576 board: the addresses fixed up into the FDT=
 by
> > > U-Boot match the ones derived by the new driver, and the driver corre=
ctly
> > > assigns them to the network interfaces when the kernel is booted with=
out
> > > U-Boot proper at all (via Falcon mode).
> > >
> > > Sashiko also rightly pointed out a use-after-free in the nvmem core w=
hen
> > > a layout driver is unloaded leaving its sysfs nodes and the postproce=
ssor
> > > function pointer dangling. This is fixed separately in [1].
> > >
> > > [1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-1-2d16=
bebeb518@flipper.net/
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > > Changes in v2:
> > > - Switched from a scope-based guard to explicit lock/unlock calls in =
the
> > >   OTP driver to avoid mixing styles in a function using goto error
> > >   handling (Sashiko)
> > > - Link to v1: https://patch.msgid.link/20260901-rk3576-otp-cpuid-mac-=
v1-0-ea9135270fc2@flipper.net
> > >
> > > ---
> > > Alexey Charkov (4):
> > >       nvmem: rockchip-otp: Serialize reads
> >
> > Incidentally, patch 1 of this series also fixes CPU thermal throttling
> > on my RK3576 device: apparently, the mis-read OTP-programmed thermal
> > trim values broke the thermal governor logic, which now works
> > correctly with properly serialized OTP reads. So it would be great to
> > have these merged.
>
> It would be great to have the sashiko comments analyzed and replied to
> as well if you would like this to be reviewed.

Of course. One code-related comment Sashiko raised has been addressed
in a separate patch [1] which is still pending review. The
binding-related comments will need to be revisited, as I'd like to
first explore the idea Ryan proposed in the adjacent thread [2], as it
will change the approach somewhat if it works out.

Best regards,
Alexey

[1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-1-2d16bebeb5=
18@flipper.net/
[2] https://lore.kernel.org/all/20260916123355.4507-1-untilscour@protonmail=
.com/
