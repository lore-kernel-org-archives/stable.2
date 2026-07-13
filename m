Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB03D647F
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933924; cv=none; b=EtiBqzwb/NtM03ES+IZq31EzunWAb90u+PHSFW2yRk4OwEL0Z7o4VhbSnbnXJI5VXiAyo3KlbxfluR4f++U41N5DO2bhkLkcQrZAX21hxiVjLuOa5AHEDxNso1Eo1D7TU+qBCSKGH/l6OSdJk2kjgNXYoLiP3OdjQk8zQF4Vckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933924; c=relaxed/simple;
	bh=c5+FxcOGmAmceHhtPcpLKMS/cB4l1dpKb753xDlDMDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3XjdHabEUAk5ozIorzL7FXdkxcvPEhjJ9XzF2nOwfkuZAlDqfnRatoDIdIvHlHihoY8FNIUI7BZQ5gZTooQFUfC9ML+Vb0zAVZCONC0L//R2E1ubEU/b/KMVXD26lgBkEIz9KXWRv/EFEj9LR0SEqjcXQB0pbOxgOn4sf5xTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfaf91daa2so634700e0c.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 02:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933922; x=1784538722;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W0GhslFIBhV7HjGc4JTm9mx3d3RqP/ws4R5ft90HGkM=;
        b=TyZQOnCejI8S5WlD6Yw2beyqLtiJTrSCTv53BMpl5pY/udeWjcT9qnsDmeQujoQVMJ
         NWGT4x9TIbAWrFcT9Be0Jo9LaML8blDeAbiFnzd9lFSj8IwxIJn7ARKyDWE/HmwwtxV0
         brP7PcJARAr2eX4tSmopr7+NrTAKyD+VpJaIR8xmcCi25OOSNv5fNx7aWMQZE07cF70L
         HzVYk3mG98bqQYzLhs95pIzpAAwAuK8/2flEoqCTeEXEAtOIoE/IkOtnBMbMouKAerr4
         s6KumehOCmwLrWokdZRsbYfEfeSJp/20fPT56C9BuwU0DMik9LiwCIzwqUqcxCtxY6DC
         9z5A==
X-Forwarded-Encrypted: i=1; AHgh+RpR90kXFH3Q23FekuSHe/UtbJ0eC3wQUuCg7zq4NSjs+Nlz+iCDr8CKnkjRKeV98iXUIld3oSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbAp/e9R6rA1NULRmrZ/v5zZ+mb9J1OzILmw7KMFn8onsXexa
	myO+UW7MoaaLncczBWNeVTfBSdauwqamK/tqsZCMontTpV3k663gVAZEmDAxSCuR
X-Gm-Gg: AfdE7ck83vicRgAahAVdtz9fS6BDIUZTGpuTTzFcYzYZBgLPZInWo+wf8XLNgne/fwx
	a25Zqf/LkEI4DaVWrAbbO5cmAF1SUc2+PqTH6Ezf7rRYjbokUwTNSFTx6jd50FgJNSBcMYb6Tip
	YcMtQIuaBxF5ZZ+uRBaxDVx2SDWEX7fx/tMFQWLyGCu4yxAO0sNEBCeiAlrwqiz80Fxj6Ihrdj1
	r9tUsqjtsEuLrAekgfhuRmt7LdVRsG1SfIHG4fi5/wuuLvOuZ/ut8um0thupG79UNwnLSVlr5Sw
	YFn4SB0STyZDGUqJLycnZ8iw1w4QRBfFmuIawacoG8OsAG3TE8GaDHSu/hEudSp9lnmfLkmmRsD
	W7cqDRB9DnDJACZVgtuj2/T0/6jt5FFTgvJ6y7fpHOhCWN0HwM8zjU/ev5VhSKeI/AHb2DNk9Tx
	Z5uUvnuTFpxLk7fxgGxiVZf57U3pFqInjOgOijh3MBFoqYL5uk00YwkQ==
X-Received: by 2002:a05:6122:50a:b0:5bd:aa13:c9a6 with SMTP id 71dfb90a1353d-5bfbed583f7mr5056632e0c.0.1783933922075;
        Mon, 13 Jul 2026 02:12:02 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f8f4283sm8541512e0c.17.2026.07.13.02.11.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:12:00 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf62388d17so1051179e0c.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 02:11:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq51p19Kbe1YQ+2IkB3G/oOWdXySylNvI6O00kNVfOPlJ0iMRydiPrMJoi25gg61Ebn0O5UixA=@vger.kernel.org
X-Received: by 2002:a05:6122:4881:b0:5bd:ddab:59a7 with SMTP id
 71dfb90a1353d-5bfbf36c0c7mr4476532e0c.10.1783933918601; Mon, 13 Jul 2026
 02:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710160450.64967-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260710160450.64967-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 11:11:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQJ8mzUi0birB5f1KnCMX_QufHTgYB7AW=d3ZoFer+Yg@mail.gmail.com>
X-Gm-Features: AUfX_mx2_XwwyHYURvzuCSrFPVED98PoIu91Ql66CsUnywXi7izjAFqbWrYeOLo
Message-ID: <CAMuHMdUQJ8mzUi0birB5f1KnCMX_QufHTgYB7AW=d3ZoFer+Yg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: ironhide: Describe inline ECC carveouts
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Fri, 10 Jul 2026 at 18:05, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The DBSC5 DRAM controller protects DRAM content using inline ECC.
> The inline ECC utilizes areas of DRAM for its operation, which are
> in the DRAM address range, but must not be accessed or modified.
> Describe the inline ECC carveout areas used by the DBSC5 controller
> on this hardware as reserved-memory, which must not be accessed.
> Include DRAM areas which are unprotected by ECC as well, those are
> parts of the DRAM which directly precede the ECC carveout.
>
> In case of high DRAM utilization, unless the inline ECC carveouts
> are properly reserved, Linux may use and corrupt the memory used
> by the DBSC5 DRAM controller for inline ECC, which would lead to
> the system becoming unstable.
>
> Fixes: ad142a4ef710 ("arm64: dts: renesas: r8a78000: Add initial Ironhide board support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> V2: Include the unprotected data areas as well

Thanks for the update!

With the ECC carveouts, Ironhide survives booting with "earlycon
memtest=17".

> --- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
> @@ -107,6 +107,47 @@ tee@8c400000 {
>                         reg = <0x0 0x8c400000 0x0 0x02000000>;
>                         no-map;
>                 };
> +
> +               /* DRAM controller inline ECC areas */
> +               ecc@10cccc0000 {
> +                       reg = <0x10 0xcccc0000 0x0 0x33340000>;
> +                       no-map;
> +               };
> +
> +               ecc@12cccc0000 {
> +                       reg = <0x12 0xcccc0000 0x0 0x33340000>;
> +                       no-map;
> +               };
> +
> +               ecc@14cccc0000 {
> +                       reg = <0x14 0xcccc0000 0x0 0x33340000>;
> +                       no-map;
> +               };
> +
> +               ecc@16cccc0000 {
> +                       reg = <0x16 0xcccc0000 0x0 0x33340000>;
> +                       no-map;
> +               };
> +
> +               ecc@18cccc0000 {
> +                       reg = <0x18 0xcccc0000 0x0 0x33340000>;
> +                       no-map;
> +               };
> +
> +               ecc@1a66660000 {
> +                       reg = <0x1a 0x66660000 0x0 0x999a0000>;
> +                       no-map;
> +               };
> +
> +               ecc@1c66660000 {
> +                       reg = <0x1c 0x66660000 0x0 0x999a0000>;
> +                       no-map;
> +               };
> +
> +               ecc@1e66660000 {
> +                       reg = <0x1e 0x66660000 0x0 0x999a0000>;
> +                       no-map;
> +               };

Given all DB[0-7]FSDRAMECCAREA00 registers on Ironhide contain
0x0000cccc (md.l e98[0-3][7f]450 1), I think the last 3 regions should
start at offset 0xcccc0000 instead of 0x66660000, too.
As a bonus, we get 4.8 GiB back ;-)

>         };
>  };
>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
