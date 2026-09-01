Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377D3B9D81
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291619; cv=pass; b=tRDmlpZxbaZRcvisiPq2OI6XscJ9W8Bojn+CaJPuD//KjW1oyf3E+4LFxtjLZ/hhjNRjK0SpaQkLKZvzRL2i3YUJ/blsNJLqzI1m38IRMKRvqvPFn4CaxvOiLBbSK42PlxFgZu938XkW1mBv94aDDKwwLBIJZbewMEpecqMX2VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291619; c=relaxed/simple;
	bh=vPIlT3/0q3DmEJlhpdxnF5yqYyOZkdrfaCmYL1+wp2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/ZwvnLzFfm89DX6/X9saoiGMHmeaMl+qLjp7sQ0eEuIh58wGft1db7MMr0uRCj5lVuY2/SHPWDl8PL+Zdmv9dhrR2L2lM8ZRSgzzRKDGV0SucW+2HImPbrWQnkl2JLE1Pf+q6OMS1xHJ6DjGtP4MfZK2qJMMNYXRlEFGBYTsBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gx7Q4MFn; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx7Q4MFn"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso11645e9.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788291614; cv=none;
        d=google.com; s=arc-20260327;
        b=r+OvmVc6MjFqkiaW2nEgKvxM9ZxgKb82oC1Cg6b6YZrzCx0KuXslTL65C0hU9M7M3p
         mMLS840Kjsk2o7WL3L8y/R293GwD7ou1AGg4vPXJcz32xMONXlxIjDxF85Dx4ar5GurB
         DZ4dYjcO7iZvdC0nSgtZRLHMQOsRC3eT0IUK1T+3xeBgJJuXQbo8gM5XNNsSYSP2dGD0
         nwpmGhTgohh13YgE418vV49nRtXjcaRmk7oDkANC4Ay+ztRnuHZcSUE7rrNDnELedkAX
         0gwjmMPmw92gKYYgVFib4G5zJecLHbtn/O9CcexffCI7x9xAbyc09GxUVNrKbjHKc3Hi
         qmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCPNVjswzrfu/6ewp3QsYppMVfdEr2MBSoZ8rIPqMgs=;
        fh=q8CBlZ7Cb7ObKPU/EUIdIwORPQHXlY2vgVo1Cht+jvg=;
        b=jB3PhaTdalVwpfBB4h/juOLx7WXSlMr1UiGJX33j2zrRu6mcSqPAe3SVODI39qMUVm
         AqE4XcgI7tGURhcS9rO+jMtQl08qRNp8XzUqX+0rgddRHEHW0rO2dtdtHx6KwtVFBpof
         L7cK5QCNetr2K490TfIko5QmBYERCv40j2Vwc0vSa0aPo9q2zN1ZoPf8iuagz/kLehG6
         qainlUM2KHwPgdsxWWD8gK4BC6iQYdV53LJHxZA9cyoNj/O+G44TahxxZ0QAJiNnPwrd
         NYDpgMEH09UhtmLsPlOqdF8ZqMywsPdcRLSatlV3lGNIeUTgKmaxLOz0dWzdy5umSxY7
         C6AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788291614; x=1788896414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mCPNVjswzrfu/6ewp3QsYppMVfdEr2MBSoZ8rIPqMgs=;
        b=Gx7Q4MFnwNsfICRyxiXCv9K8TYow9oyE4B4HpblwoG3BvjRlGX42gnaJyPAB8cJIoc
         lcSjFKFCgQVhWYWwQMtUWLqvXlQ56YulkKxRGY+MRymhQaVdPqqg8LJuM0sdTd9qoYw6
         iQJmBhClUpHGAaH8Mkcowe+JZKt5dMUZEWT8IloYdC5ZlAMjnJk17DlK9NNsFXKqIBjJ
         JCWBKDfw75FiAsp/3e1bDgrW17jc6DITZseOB/qfYZd00hpBa4l2mXb8TqLArGkl7XF0
         uKENTgjKcc89pvgz38HjCfINlap9X8yF52J3cGfx9EDDDJq6IDsE8g+Q/IbfhBHqCP+6
         m5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788291614; x=1788896414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mCPNVjswzrfu/6ewp3QsYppMVfdEr2MBSoZ8rIPqMgs=;
        b=lLqMcEbyD7vPx1mG5MRrIugICn27RakSS+R93LkfihgzXT9sOu1tdDgAwrjhfXXskL
         nTaa/YsIaaLguDL2Tcxx+6rYyqFMMeQsEiWu+Kuu2v6irFpbrLEdrrclP2gAkkV+CrIC
         Vf5rYtHN8dsum9V0wp0grDDjqudgkMJGRd6jh2hO+rKY0vilYeur/GM/2ZeM8jVf9Vyp
         qUSiyol4ogtCSy4z+z3bGxy89aCnh9saOQgOIVeFUW7ELOBRqnBM4s8vSyTa+Gaf1oDl
         ivbi0agyZ5+js3tO/ppbrP7qsNmrKbI0heW3QVaZLFVlJev1ZBJWpOSFeGYTIsGe8WZF
         b1pA==
X-Forwarded-Encrypted: i=1; AHgh+RrdGNlfNQBvz/9D+bJ3gOpGToZjWVmJ7Zc4QNvD3+76Jrb+UfQ4otUSPF/2g/kN+GLRs4+y4Hg=@vger.kernel.org
X-Gm-Message-State: AFuF++n+OjtA48fFF2zaXI1CIpLBqgmWl1Co8Bn1sHUdIcxKQm6V3uWH
	r2AwrKAQvBy4KuDgaCeR2Ewwyh7oNLjKR/wOnOM6Eo15a5bSfiXbJh+5ZbdhgyzrHpE+3s5Qp5w
	agjYaFZx1K6zCXoliebyWpPeSO3M/BpSAAdL4GKMb
X-Gm-Gg: AR+sD12vyYnak8Y5mMMoeIZx8WAl/Z09PTpSSH+nQED6kMGQV8Iu89FsM12CQUd4ZEr
	V/uEys1zNQ8tI/8z35eMUNFsGEqIZ5fce8SpIHj84fckjPxseS3gH1WRhoSze3Eh+IhPeLV5W4S
	G278RZfgognr9SrVo2uGrHsZIbh2jSHGCMDrgCyX5OU187ppu5c6KGRer4uFBPHCogMbqPwynQu
	YuJbC7cLv6yvKzEUw+eQMfQx2tNW4ITsm16BYGnW1mEd0S1E3WdLkWOlZSMrilM5n+xnB6axBHO
	HZzimOF1KiCygAjEyVa0q9OsBhc3nrrOavzGQSR7oEnuGafrEyqxyykYcx5e/gqKhyQjG21QqN7
	C
X-Received: by 2002:a05:600c:224b:b0:499:7da3:dd0c with SMTP id
 5b1f17b1804b1-49ce462122emr115145e9.0.1788291614023; Tue, 01 Sep 2026
 12:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827194508.446733-1-linux@yoavmoshe.com> <20260830155100.1020620-1-linux@yoavmoshe.com>
In-Reply-To: <20260830155100.1020620-1-linux@yoavmoshe.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Sep 2026 12:39:36 -0700
X-Gm-Features: AcwNN1XK0l8thrBV4rYONxxoAFHyd0qFWNxSTWm7rTcE9pRg3SR1YhO1gQnpQwA
Message-ID: <CABCJKuecSgC2yZ1QHACv3gfOYf+cPXvR5TCEM_t67NX-putr+g@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 8:51=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> The suspend code that runs from OCRAM is copied there with fncpy(),
> which does not copy the kCFI type hash preceding the function. With
> CONFIG_CFI=3Dy the indirect call through imx6_suspend_in_ocram_fn
> therefore panics.
>
> Keep the call covered by CFI instead of exempting it:
>
> - Add SYM_TYPED_FUNC_START_ALIGNED(), a variant of
>   SYM_TYPED_FUNC_START() that aligns the function entry rather than
>   the type hash preceding it, and use it to declare imx6_suspend():
>   fncpy() requires the entry point of the function it copies to be
>   8-byte aligned. The macro lives in arch/arm/include/asm/linkage.h
>   since the requirement comes from arm's fncpy().
>
> - Add a cfi_type member at the end of struct imx6_cpu_pm_info, which
>   directly precedes the OCRAM copy of the function. It fits in the
>   struct's tail padding, so no sizes or offsets change. Fill it using
>   cfi_get_func_hash(), putting the hash where the caller's CFI check
>   expects it: four bytes before the function entry.
>
> Also mark ccm_base, suspend_ocram_base and imx6_suspend_in_ocram_fn
> as __ro_after_init: they are only written during __init, and the
> function pointer in particular should not be writable afterwards.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yo'av Moshe <linux@yoavmoshe.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
