Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20814383C84
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566212; cv=pass; b=Wm0vg2M/V6fsTRWeTDOXlPSGMbE62EMSoe8wlC8HP4yG6vhJ3apRXcLxI5MbI5LelslcXSTSIHVZ14e7AtUG4eXdsQANlJVK6o/UEB5Dzhii2Dki7UkvvAyCmqyF1Zy2oq9vIX6bvfpEv/8Foj5XHAE9vdcfzToiytf6FQde2mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566212; c=relaxed/simple;
	bh=mV4C844nkmkraNjWpzUFEfGiayI1N+j0A/3+fC1As4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrxiURFz6n7i2mrbxsc++BXfZJqiDChg+h8tTfuxJ4Br26yVXKoMMirFngyEOvmbcJiBTXRpFtQe2o/E4geLRzV9ghipuTIhe3BTk0Is5X5C7/JcoPBg5uVcg2QX+C/m9dmhh0smg8IVkpaZ6YWsKkKOljdmUc1yALl6vf6IOdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tppJWHo3; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tppJWHo3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so709628266b.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784566209; cv=none;
        d=google.com; s=arc-20260327;
        b=fbtbYK5CIZ9+x0I9i7hAOan+Hx5hr0VCq/qNHTzGuX54xUhwBY+kH0T10HD0IZkKNu
         OC48C/XsaS/zh4wJ6qA0rmedD1se9B+5b0iNbbgdUimiRwIgYml4SBOjQoO1r/7mcIWb
         uQmUKREu47kxjF7XE6bE9VVIJeET2FVWaQ8hX2O+cZAo9E5y3BH7mA+Js2zDxI/47oxi
         5Q1sr9dtfp/fF6XWbC/mKKnzKt3yzuhH8e8+kpF0G2Z5MmaDkX02D+LUq3Ybw9uYpDgu
         1zrYGJzJvahnlARrV3J/7NGBeXR1Yh0GN8fYUtD8xegR+obv+ic+a98ls1hx3Hdu3NPc
         luSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=163N5x68jnVbNG9W8e+t56UKy71p7BqItDDn6Xltr7c=;
        fh=keTyqGFWVli9lGcPu78HsSudxSJzmKUsB0wAqoITTWc=;
        b=ZZ8Xm5lkpAlmSHe77T3hQZyb1NAbytSTjxEGrKBfWVU+0sI3jNjqzwccbHGcwojy0m
         sPoHez5nha1pw4qzlsR5ijK02QxiV3MQ4XbZSBkB1K3vhlIMnsPmoEJb0eMTIlVlBWhu
         puctBmt3MRuxx5qaRzVBLvH5/QnHLA2lLYns52tRDV7GrvQBgp3L5o59JhRE6TRBcM9Q
         YXPqs53lqnnen++dI2HmaSwIVION+TE/mtl3ATjfpCCWw01drs/2gjT3XcZeGEf0hB96
         Pzw8mw0qtRltDggr12M2lMjZn9Qqv3JdxY5Bov1joaFdPAGJoqhAI5wtQL6X1FhsqbKw
         jHnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784566209; x=1785171009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=163N5x68jnVbNG9W8e+t56UKy71p7BqItDDn6Xltr7c=;
        b=tppJWHo3Zb/0Hqwg+sGtxqhRBrdGGMku9xRS9KxXkjboqINomQK1hEVLMZBBXqQZq6
         DKh15SNMEqlk2n5V2Kc9nLEe9VwMFzdEPQqHDiWb7aYcjY8OO9rsl3zx6p4tRH8fInhR
         XCvrWi8zOaQi5G4jtyjzh/iYgzth393DKuJbMd0FaIVNgz91HIQsy744CRz+kU1xBeWz
         IUANvU/pJXuNmhAmvTX8oNVEGoDCsA5sY4Wjg0UqRjXC+/S3tafD1YZpQRV4FXaythrK
         p85hoc9WbgiSgGIdSYPzskFr01GoBPMXyZZdEPsjGYINoqaB7alK2jUQQuOpSO16aX9n
         uK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566209; x=1785171009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=163N5x68jnVbNG9W8e+t56UKy71p7BqItDDn6Xltr7c=;
        b=reuCIz2cqjUw5oEatfZ5eA8zqavI4bvHSnUTbkNTqtDjFniO2maxsuySzmSdvccudS
         8fxsHi1XQEw6GbtyaI6DLixqlkrJeevdqkGcu9bETew6MLgB0tOdIH3wR/NQo4XFIqzJ
         vCWCTf4jel82sScEfawLQhgtA5MyAvVgm199wHoKxnixIlFFaUP1phE17cYlL/KU5M82
         uClxmJrVBkuwzHS7XYkykySKqCxSXKKfaKfCnrb/iJn/Ua/FRfpX182lorZhfYej8nEU
         8FBSYV1dqvVw0cLxwwd3FhcGbwMoi6ROGSXxu8t9Sb6m3CR+jVgsHt2PBOJYHWjh+ilh
         y1zw==
X-Forwarded-Encrypted: i=1; AHgh+RoWitHBkBAShNpfJ7PrulJuw63phC+RW0QkMGCquNRUpoSlqvYU3JXAOEcf/59dXgM15vkNnpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygO/W6oDS4bFTUflA2zcfzKGLx1uxVhzf3tPkdNbHy5iu6+g6K
	U09Gr6ykM3L13F5JWvQ/Lp9ofnj7ZeMre08vD23wX/1WnNrvVupLT+UuoIey1OROTrFawcVpDvE
	fb36Q2Cd3jbISsZaYk5os2hHAS69V/GMVcHQBr6La
X-Gm-Gg: AfdE7cl3FhAgWnD9sq38anwouBbokn94FaUqEzstZI7/5yjCp2lkXgH/z8leeOOQ1RU
	GzrcSmFH8JrqV3gBpV5BZd3UuS2jCLCC7g4sTSElpSw+MC6JJOFtIZpZkhpaDhbSRyh6pX2zifZ
	n4ZcgDRAB3XlFnnLUDpevgwbr31hkqPCvfZeh6dMqq6rIJAKSvYugYiMDFbEsUkscgeAVZtoVYP
	VrntxnHJiNO+QvhhjmXcyt6CN8pmlJGIHVUGKoBs8ZST1RUeMO0427Ts2umpViR6zp2ZO5qQ56T
	FLaE+mWg6yQt+fWXlRxHqfcb7nNixVKgvKkFvInZywzZgcDUt8naF3vneu8/hrjsMhLdCefzwTA
	b
X-Received: by 2002:a17:907:e917:b0:c15:fc5b:b667 with SMTP id
 a640c23a62f3a-c16b40f8999mr685752766b.19.1784566208840; Mon, 20 Jul 2026
 09:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717141648.1007059-1-linux@yoavmoshe.com>
In-Reply-To: <20260717141648.1007059-1-linux@yoavmoshe.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 20 Jul 2026 09:49:57 -0700
X-Gm-Features: AUfX_myCkoH_ohyvAhDykS-FTisAi77kahkS1sYBNzC30PdiB5itO0E3RJF3Z5w
Message-ID: <CAKwvOdkGYLWAR+5q+XaO6VZc3-sGEm0nX0MvXoJOghx7Gn1tRg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 7:17=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> Relocated suspend code in OCRAM lacks compiler-generated CFI type
> signatures. When CONFIG_CFI=3Dy is active, the indirect call to
> imx6_suspend_in_ocram_fn triggers a strict CFI violation panic.
>
> Annotate imx6q_suspend_finish with __nocfi to bypass CFI checking
> for this specific indirect call.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yo'av Moshe <linux@yoavmoshe.com>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> Tested on a Kobo Clara HD (i.MX6SLL SoC) running postmarketOS edge.
> Before this patch, suspending the device caused an immediate silent
> hang requiring a hard-reboot. With this patch applied, suspend and
> resume work successfully.
>
>  arch/arm/mach-imx/pm-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index a671ca498..d9b0c1803 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -360,7 +360,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
>         return 0;
>  }
>
> -static int imx6q_suspend_finish(unsigned long val)
> +static int __nocfi imx6q_suspend_finish(unsigned long val)
>  {
>         if (!imx6_suspend_in_ocram_fn) {
>                 cpu_do_idle();
> --
> 2.55.0
>


--=20
Thanks,
~Nick Desaulniers
