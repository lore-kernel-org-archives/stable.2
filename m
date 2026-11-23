Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795436695;
	b=h1S4fguiDW0lYrz+g2iXTjyXuBIC7l1otYnmNIsA8dz6qAlft2F23plOGInrFIoHKHVX
	 +RUspJIZB8OThh+IAmz0oTd7e4xfLK97gvnLbaniwvcWjQwcSOhS+aedAXgaC1UQssgEK
	 MedtYnwkX6s3xIaU3251hJJUVlakaX9ajyvsj+JmTxYq5hp70TsLngKA/oyblur+dG4eF
	 +plDvNyaePEFQm3eKchcxrixJiJU/h9mBm509j0a+Ca4dNWq3oxyXvB5xipFQgLwsZAM1
	 9/5SqV+SaGIB3DMcHlnMqUl4bv3UnaHy0e0IVKamamL+Vi/AjdYVCuMHVCpdodTGazQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3JGEHCaGHgSI8BrKRQk6rt3qVFIqpC8XEVH84mN8VhI=;
	b=SskKsNKYMCqLlpdXnl2Xt+6Xjw9QN1sCPmqwEZEyhtTJyooqYk79eXU4vt/NhDVXoeb2
	 BWApTiZ4+IubB2U/yDsKyxnKriqkih8kxyBDQaRbYXVOKVsC3RwLbB2gN44dchWY51MjG
	 j3Dglk4GuyHh059QG6OFXSnRHQQSQ8A5H42uxT0PIQyX8RC6Jp2MFgCr36odExsQlkMjo
	 Ez23eclfaeKOVsbFh9jtAqhWO4yWop4sMmLm8qWvZcW4NGihKZmG/RkhBke6ZozoFYTjI
	 Q36MXWrmSsxLo71iXz7sJaXLlHsvGTY0DGR96GrEOmYwaHXNF4QrZI8jjbTXIRQOnww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=SMANlYAy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC53606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEC53606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=SMANlYAy
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50aaad19fbso358894566b.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795436693; cv=none;
        d=google.com; s=arc-20260327;
        b=q6UsLdBfUU8xm6Uw1049uLFsauyuZD07Tdawukj1CZ3pPcsFK7U8SkbnPlzby9IndK
         RbiYpySpmFwskshynMnrKZFkGOmLvW6BQiASbhjmFo7nBB6Q+grSY/xwtmGhPo4qmZOI
         zsOsQrEjCF9+X2SqxBsKPvZB8HTj5ad/9yPsgNIfb3fjpoSSLRoT4ayQUhKX7RKbzmdT
         v8+MuVnHLgu+ksm6H4U1yjFP7ptKVwM9Ay7tUOA61PUGhXpPQFGmbjL6gnsvu3McK8RO
         m2+hfL9TN6BxdCua3ZBnDOFST9pcHd9HHP6p5HG81nPJ5sBw8Ridawn1+ZSrb0doonoA
         Ut3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3JGEHCaGHgSI8BrKRQk6rt3qVFIqpC8XEVH84mN8VhI=;
        fh=q7O7iAZg6BD53pMgDluzQ/Yj5VUtu3z1rm1971OW09E=;
        b=d0M9sDTHbCXXi5jZLtJf5qVKHmuIAIpuY1Mu9A37UMAW4GLMd5C0C49YZ27nPufqLZ
         ynDCZA1qiYkWc/9254wjKv9AkCjIJAWZUDZOeerdsqqO0DFQg68sPtqzZYt/Na9flNlz
         aoYaJOMuH+9Uw4mknoYA9HOv0BCXJXBw/MfcIkem2eBcz3KgLeIWjnkUgOTiQDAq23XT
         h89xrKCBqndFzrr9+FJ+W1jU4i6o1aZ50cb/lo8ZYLTBPcr2dKboB99QaLKAZj8WEZUA
         0mB9aPKS74linpuVc3TydCWo22uu5yqCZ7ufWtdOQPsyX5Dh/wvXovgsscHP4dZ44wyO
         7BQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795436693; x=1796041493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3JGEHCaGHgSI8BrKRQk6rt3qVFIqpC8XEVH84mN8VhI=;
        b=SMANlYAyDeGkrtgBxN1TqmHqif7PndowLtrYXDCvfpS41NPxmuMXJ6jsNNc1zmz0Dh
         VkzUSIlzCAUMjR57cjvMvGDj7JSQ7Is69x/ZRWBbNAbA/cj/RFfYVFVvpPQeICtt3kkP
         T1mLwgtcbLB22yBUoh/AG+y6olc7pVHR86O3aJYjIu1333qq4MMiicORUlMC94lpov7v
         0KqOJwjAUfYh2e52uWhjmdbTHyAhuFc66iuNpk1TntsqbqIWDmWN8KcVWyrAD+MZ7y6p
         PJuvWoLdC9Dc8TdGQmajQg4Pxk20AAkOctDJZF3zZm1dNFNIH+3FhrguLyx5jviyO37e
         8OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436693; x=1796041493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3JGEHCaGHgSI8BrKRQk6rt3qVFIqpC8XEVH84mN8VhI=;
        b=pFHwaVvf4nENpxD9L2QuU82YX4+6A36rfO3MmfCyrnbrLyy/uGX3K18MFfvX/wuWLl
         K99rCrQ0/XEHoSpRWRM9NDOqQHZIhqoc6eiujHVCD3sakAisdroq+Y8FBWIoWSS22f29
         K5beTPaOBMo6M6IuN+IinJFgeSojcDSB9DnRC9ft4qUReR9JQaGBT9GmYrnSmWr293G7
         USRQgPHllUthvrJOa1KicUTy6rCLQat3HuXVMqc0haswCLvClwA4cg2cDYZOd0zMMGaE
         mUt98emM7J2dd7JRolj16dxwIsSNqtHayKn/fD93AlrOLNCNa8O6kzQtOjOU6C8F2xOn
         GBIA==
X-Forwarded-Encrypted: i=1; AL+hErHmDfFjSChVyoRdn7Tkvv5heAPSbITRv4gB13P4xZYmwTIRjuUS0oGGCSdgAbqPvD3JKoc5O1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Jf996bea4RrWZHj8WibwlNST6JazbSw0gI5yf8XHzq7wurNr
	Ce2BOqOdoAufXwvaJS4E2dohzm53qRMdRkbxdUp6phMszMqjTD5mqtgPh6KBhWyzwfeY8B5vihI
	pumitUd1gCfgsTqNXH134wc42sfXyUWOy2AzIoNBTNg==
X-Gm-Gg: AZFdTZfvdOEA8lhGsGx+iIFgpWMSqYi4lkakCGFpf1nVPh99TrkFQiUTxIc1wgEb6ca
	0c83VbNVeoDhj+omdPfwKwYpYhOj4GXma9YVqyrDp37MrkKUglX3wnhn8JyxPKxdG9hY+RPFXYn
	wsypINdBIzy64T3f1RgwYxC6K9e3/HUp35yUh3WYaqMWreONsEK6BVJK2xRaOPUSNpnwWdkXxx8
	t9Oi+/DZaJ1eupL3A8u+hYFsumVd1CiWGW6pKPWOWMQvhS+kuE+yIZywW7MeQDv7u9afVGV1q7t
	fc8jcqLHGfIdDF/05htmJ+BJHNtHvt67DCyWC1zz/nEy0ILPDq31i53GBMXGcG9DDQBpWMXBFHU
	agJbycHEK/1Gdzbq2ZqC9piPtsZz2OxB4B7B5pKjvsJsBj+ollZzELykVz9SmRajU1kEJoDPnjy
	k8dc1xEBH3rOB/M1I=
X-Received: by 2002:a17:907:fd15:b0:c40:33d:f06f with SMTP id
 a640c23a62f3a-c513aaad90bmr920564266b.39.1795436692893; Mon, 23 Nov 2026
 04:24:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
 <CAKTNdwH9QAgreJ-6+t1j_P1di4VyoMBSsFkf_g=mCi_-M8g9Pw@mail.gmail.com>
 <20260917221857.GA4056431-robh@kernel.org> <CAKTNdwH6E5=9gZHB6tdianC2+1aDv4wnLmvL59kDW-dR3a12bg@mail.gmail.com>
 <AQpdyd6hRl9cLAxBK-fEdzq0dcZsWpHP63dbDpOxcNQWCdaNIc4D3Mfi9Ll86jBVsbEVhr5-9EZzFHbkF6efBDcRUT7nXx9TH5Aeffy5DyU=@protonmail.com>
 <RWg2ZbGh-TJtEJMDWD9DGxBKsszG10BM07351ALdCUa9UL-IImPGxSYztcNF3kiRFVCA0x5cECwign-2lb56nPMGZQ5LVZhckY4-KTb5qpk=@protonmail.com>
In-Reply-To: <RWg2ZbGh-TJtEJMDWD9DGxBKsszG10BM07351ALdCUa9UL-IImPGxSYztcNF3kiRFVCA0x5cECwign-2lb56nPMGZQ5LVZhckY4-KTb5qpk=@protonmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 23 Nov 2026 16:24:40 +0400
X-Gm-Features: Aa3M54pJDInt1dUc3UbuIPmLJ056A7-Am1qM49T-fqpCAj8EFLf-eta10BiPxGY
Message-ID: <CAKTNdwHOoG8j59X7z6j15n8TTf-A-+EQhvC+SqNWOq24p9vNLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses from the OTP
 CPU ID
To: Ryan Leung <untilscour@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Michael Walle <michael@walle.cc>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Sun, Nov 22, 2026 at 6:08=E2=80=AFAM Ryan Leung <untilscour@protonmail.c=
om> wrote:
>
> Hi Alexey,
>
> On Wednesday, November 18th, 2026 at 10:51 PM, Ryan Leung <untilscour@pro=
tonmail.com> wrote:
>
> > On Friday, September 18th, 2026 at 3:08 PM, Alexey Charkov <alchark@fli=
pper.net> wrote:
> >
> > > Hi Rob,
> > >
> > > On Fri, Sep 18, 2026 at 2:19=E2=80=AFAM Rob Herring <robh@kernel.org>=
 wrote:
> > > >
> > > > On Thu, Sep 10, 2026 at 06:48:33PM +0400, Alexey Charkov wrote:
> > > > > On Wed, Sep 2, 2026 at 5:08=E2=80=AFPM Alexey Charkov <alchark@fl=
ipper.net> wrote:
> > > > > >
> > > > > > Rockchip SoCs are shipped with a unique CPU ID in their interna=
l OTP
> > > > > > memory, and Rockchip bootloaders use it to give boards which ha=
ve no
> > > > > > dedicated storage for a MAC address a stable one anyway: they h=
ash the CPU
> > > > > > ID and patch the resulting addresses into the device tree they =
hand over.
> > > > > >
> > > > > > Kernels started without that fixup, e.g. straight from the SPL =
in Falcon
> > > > > > mode or by any other loader which does not implement Rockchip's=
 derivation,
> > > > > > fall back to random MAC addresses which change on every boot.
> > > > > >
> > > > > > Formalize the derivation in the DT binding and add a Linux kern=
el driver
> > > > > > implementing it, so that a Linux image can use the same stable =
addresses
> > > > > > regardless of the boot flow.
> > > > > >
> > > > > > Only RK3576 is wired up here, that being the SoC I can test on.=
 Other
> > > > > > Rockchip SoCs keep the same CPU ID at a different OTP offset - =
0x7 rather
> > > > > > than 0xa on RK3588, for instance - which makes supporting them =
a two-line
> > > > > > addition to the driver's match table plus the layout node.
> > > > > >
> > > > > > Patch 1 is a prerequisite fix. The OTP hardware has its own int=
ernal state
> > > > > > machine which only works correctly with serial access, but the =
current
> > > > > > driver serializes nothing, which results in timeouts and/or cor=
rupted
> > > > > > reads (e.g. returning splicing a TSADC trim value into the buff=
er of a
> > > > > > caller asking for the CPU ID, or mixing up trim values of diffe=
rent TSADC
> > > > > > callers). Hence the Fixes: tag and Cc: stable.
> > > > > >
> > > > > > Cross-checked on an RK3576 board: the addresses fixed up into t=
he FDT by
> > > > > > U-Boot match the ones derived by the new driver, and the driver=
 correctly
> > > > > > assigns them to the network interfaces when the kernel is boote=
d without
> > > > > > U-Boot proper at all (via Falcon mode).
> > > > > >
> > > > > > Sashiko also rightly pointed out a use-after-free in the nvmem =
core when
> > > > > > a layout driver is unloaded leaving its sysfs nodes and the pos=
tprocessor
> > > > > > function pointer dangling. This is fixed separately in [1].
> > > > > >
> > > > > > [1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-=
1-2d16bebeb518@flipper.net/
> > > > > >
> > > > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Switched from a scope-based guard to explicit lock/unlock cal=
ls in the
> > > > > >   OTP driver to avoid mixing styles in a function using goto er=
ror
> > > > > >   handling (Sashiko)
> > > > > > - Link to v1: https://patch.msgid.link/20260901-rk3576-otp-cpui=
d-mac-v1-0-ea9135270fc2@flipper.net
> > > > > >
> > > > > > ---
> > > > > > Alexey Charkov (4):
> > > > > >       nvmem: rockchip-otp: Serialize reads
> > > > >
> > > > > Incidentally, patch 1 of this series also fixes CPU thermal throt=
tling
> > > > > on my RK3576 device: apparently, the mis-read OTP-programmed ther=
mal
> > > > > trim values broke the thermal governor logic, which now works
> > > > > correctly with properly serialized OTP reads. So it would be grea=
t to
> > > > > have these merged.
> > > >
> > > > It would be great to have the sashiko comments analyzed and replied=
 to
> > > > as well if you would like this to be reviewed.
> > >
> > > Of course. One code-related comment Sashiko raised has been addressed
> > > in a separate patch [1] which is still pending review. The
> > > binding-related comments will need to be revisited, as I'd like to
> > > first explore the idea Ryan proposed in the adjacent thread [2], as i=
t
> > > will change the approach somewhat if it works out.
> > >
> > > Best regards,
> > > Alexey
> > >
> > > [1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-1-2d16=
bebeb518@flipper.net/
> > > [2] https://lore.kernel.org/all/20260916123355.4507-1-untilscour@prot=
onmail.com/
> >
> > Hi Alexey,
> >
> > Have you had a chance to explore this? I have got a working proof of
> > concept [1] for the format I suggested, tested on RK3576 (NanoPi M5) an=
d
> > RK3528 (NanoPi R28S).
> >
> > Best regards,
> > Ryan
> >
> > [1] https://github.com/untilscour/openwrt/commit/a622c1cf292f7a4bb70935=
21e25436be324fc1a4
>
> I've updated [1] the proof of concept slightly. Perhaps you are busy
> with other patches? As it's been more than 2 months, if you don't mind,
> I'd like to send it in as v3 of this series, with you as co-author.

I've had a look at your proof of concept. What worries me is that it
introduces a "virtual" DT node for the MAC address derivation without
a corresponding hardware block underneath it, which sounds against DT
conventions.

I'd like to try a slightly different approach: have the CPUID cell
carry a dedicated compatible string such as "rockchip,cpuid", with a
binding description outlining the added semantics for deriving a MAC
address from it. Then have the NVMEM driver check if the cell is
accessed as "mac-address" and apply postprocessing before returning
the buffer. That's what e.g. drivers/nvmem/imx-ocotp.c does currently.

Let me give it a try, and then let's see what other reviewers say.
I'll add you in Cc.

Best regards,
Alexey
