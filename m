Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793994273;
	b=OPqzqM1T6YgDuRAtWZk74hkvnmJ/usr8vmVQW7uhnA953qrDv0UU3m+Fjm7wpcIIwBHt
	 8YNtaQHqGIhwAA6pSPpUn5aKReGFJCBVXmpN7SDX0JuH9hwSfUXOwrxc3pOYock1L5DRX
	 HuGuE6kUhf+eowBN6KavJ9a71x83Xt7hwrvkd/HF+qcZis3pLYVs9K8RMyAidEbT177yS
	 6sH7l3IGj/VIMkI3l0+or+TsYNO0WHpGEhsp9tfHkqyxNF/I3RiNje4B4b8O9fVjFgy22
	 KmZuLtI4YlzRM7FS66ZOHjxzSAkjTbQ54nIDBLsfqc75KN91MKL9TX/yE/uB40Xwp6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dA/SScrLhx0g1iQzWQT3zXqR6x/uBQevrzuD0FNFdOY=;
	b=KgAP0LzQoAyErUcwTzuOjzjqQ460mZgIbVQcyrLRO0oGmbIjhLw8/GNDtgj6FBYtwAOl
	 YG7s3L19J31NmYLFFVT0ZlAcg4WNL6wqM8oIGfeTQRcHc1VrSc4z8IEW55q83vi8P6kkN
	 02b9BN+VC6b42wlW9aOZ360KKcH3xMcMVprk7e0WVWtfxPjE8CJ7d/a7/yqiwXItZ9AcK
	 zVwIoGfCnBr/Jzbi1jcETV1GvoKCfrAfX1QHyJVpxhzPPudabdpqZH6NKZb3pN0N3rNz4
	 InJKEIjw8cwdGu2qMA9+mviQaJfXfh10XCYfJtJ+kTePgmaQOQTzoj0u9DbM7mK9gOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gvGiICTn;
	arc=fail smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E96606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E96606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gvGiICTn
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491971ac844so920271f8f.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994271; cv=none;
        d=google.com; s=arc-20260327;
        b=lTuUTJwUZLCqXE1mB6CaxNlUeZ2nwEUUWfNJoCn49NdmXTTYP9bk/kYFpYFCzLZxgK
         Ed1uSfN+hCXEh/lhZLwmxox4UKOZ8V2LmwEeazBnxtQZJrX+I1cEZNb61+Ga7mEOqqiu
         sjumklrgAkqWiY3YkM/r/HcB40plj6hQKUEN18hS2P401wRR0epbuz4n1Yr0rasLy2jQ
         cMmyt65JO41OVvXvK5MHyWrrfvn3V0SuVC0hZD6Hgj4xrqzb+8VQjssVs+JpQHwT8ekN
         tHgZCzD0mJKRlG5CiubmzTX8/nisHQh7+wc+UpCytTLgRpBsXroOF98wiubNRsQ7hASj
         N+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dA/SScrLhx0g1iQzWQT3zXqR6x/uBQevrzuD0FNFdOY=;
        fh=JZZFIbhTKBSKehKe3yjUq7q7DP6MG3dYmeKKm0QLCCA=;
        b=hsZcHHUfjI2uFyLaYpvDiuFHe9ZRDHbieeKYeBbqbdWRnmXsZEupSdEh9Lt/Sq7ohy
         iGmKmtX+qJxTHAw+xt6N1PXn/eFlYCuzv82SFgaF8rSBLfOF0MAOHT7Gnv0bxqSLMaJw
         YV21N/ZSZAorlAMER8PGZfnFLhnc7lVIMfs3lMJqDIBrgYfjPhOrtxswkGNiGiU0y1c6
         dn0sZffStWzDJBjGF5qZOcQEy9HEIjLSr02PBao4Zd1H6+zJpo2tcXgDfKLw9C/78vD9
         6dL9lvDykkm95c93N9VQscbmsMvAcngCeDm8w0fL1HW4tb7oa5LihENLp/tcBQeuvJZK
         /Faw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793994271; x=1794599071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dA/SScrLhx0g1iQzWQT3zXqR6x/uBQevrzuD0FNFdOY=;
        b=gvGiICTnzCxuHUkMAvPjSTuWZIiFk8Swusu09/AmeTF8ZvFuXrcJhRLIcY+x3exYoW
         F8yUkxYY+efm/EEK1BYsyPJ8L9glXj9FOSUpKm6oIgqo96gg2B/tprxf7Zo+1nuwhQPJ
         6ijZt289CT0AhkP1KSZvtHAyYuLOHjwMjMzs8+ueD8xOqWSBMa5UKbQa8iANDPRMBhpP
         wKRy68tVmylxxmXKurkJkSeJUoYdTEE+gS5K04l3rvighmiI1bQyPSntaJhmORJBJysp
         +4rchM83WXR83dhu4E6bcHxEb4rCuQE23qiFaf6WcTXAmLpRJAsHpZkRzfGuHtlYZw8K
         6MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994271; x=1794599071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dA/SScrLhx0g1iQzWQT3zXqR6x/uBQevrzuD0FNFdOY=;
        b=niAqu98ochoSC7Z0kzLcjikGq2O1l7+P4mC1MV4gqODKbk0pKER3CeCGyABuJX3NQI
         8QaN/EUmffO34zoNEerhh36u2mnLehFbNhcE0OPZHrhyvMDJEH5SYyr4dDb7j0hQih2p
         f0LI0+YKzZoF/Y2iqN98fpP0uXr1H5qFSMYqaDpPHF3NiNvG+3D2ULVldzgIwatlnjkb
         qJPHcsVFVTzsEJ1Hi0GMB8MnXv6ai/vQ0SG/06uupuJJSF+JOrlId9e8F+6TZCD5cNxj
         mSkb9ogfmVzZ+fRnNX/OmNrvMOIRhaNk0gmdUs/kCK2zzFZi6qDsoPKX75ew7eT3Oark
         v1hA==
X-Forwarded-Encrypted: i=1; AL+hErECfVLVhmLZU2y/YlAH7YsWMJSDfOSUDZcnzyMbRTqRSjul/wh7+qM2brMb7StUV9UF0pOWNQQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9Ksai4fOQip+8tvH1U5ELyiVmXoDYy0qhiK+NOAMsysZA3qHY
	oIhrHvAJQS44v1gx/RtoEBUMoYMM9sUVqybvK0W8ptSrC+ojCDDBGws0K24gk1Z8amve1TB62jH
	Wcf0ZEFyvG6V2oRFb4+BxvtZhElrIFHILL2wwc8J1
X-Gm-Gg: AYBFou2FDbDegfpRZrXqA5/OM3qgG1ihdT/jxRkt1Lt6WJa++0/qnM0O0gYDcJuWGDr
	swHwRZJtn53n72EI+AxYQ7YhX1RfBUv/+GIvueMlaY3sAJWEu9SRorTbFbWpcb/KMMUfs5qaRL6
	l2E/0eFVb1Mt6RXGkJ2eJ4bHk5sRem4aRTSTYDAFk/em6Sm0aXz5ccbp2g9G/+Nz2FGfAIVS2W6
	5ZgD+xBREXFsJh8b0mPHFmJQjpWGPU2NztrMPAr6h2Puv60nKvaPxZMpuS+TFpfFAxDJyujjQsI
	4AX2pCYgqDdT/MrDIFjCb2ADLBvJHzL4gd6O3yvfqZWkWzpJIssKLfMdDoo92kqPow3dy/WPymY
	uy7FsrfbyQjY5M09ki/ILpUZ0Ozjy0hQYtE/V7j2lP5yuhC+81SMqwOougTU7mJHjBIHWqMW0dA
	CwGi+XyYPADqHAD4R5/xJA0HmIPkJZKn9pxK3v3BW9X2F1BxbsqA9BtLbOsc9kLl8tLzqTXu/bc
	f6jg+3azGb7GDwmypHHYgWqIEUzQc2p728cGw==
X-Received: by 2002:a05:6000:18a6:b0:492:8dd4:baf8 with SMTP id
 ffacd0b85a97d-4928dd4bbe5mr7282358f8f.6.1793994270567; Fri, 06 Nov 2026
 11:44:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106113800.v2.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
In-Reply-To: <20261106113800.v2.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 6 Nov 2026 11:44:18 -0800
X-Gm-Features: AclHuK9lc1j_hydZKjHRaIqC6GPhtItrfzxvxTIux1kraqJqkaT_i4EQKE6q_vU
Message-ID: <CAKwvOdnnonRfRPPv8cJU5-n_N4JpJLsVixyTYOtmgMjWyz2LDQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Douglas Anderson <dianders@chromium.org>
Cc: llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Yabin Cui <yabinc@google.com>, 
	Han Wang <nesthanwang@google.com>, Nilanjana Basu <nilanjana.basu87@gmail.com>, 
	Snehasish Kumar <snehasishk@google.com>, stable@vger.kernel.org, 
	Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Bill Wendling <morbo@google.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:38=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Starting in Clang 21 (LLVM commit 2fc4a4a9d3a8 ("[Driver][SamplePGO]
> Enable -fsample-profile-use-profi (#146795)") [1]), the Clang driver
> automatically passes -mllvm -sample-profile-use-profi whenever
> -fprofile-sample-use is specified, enabling LLVM's flow-based profile
> inference algorithm (Profi) by default.
>
> However, as Rong Xu noted [2], the kernel's AutoFDO implementation uses
> flow-sensitive discriminators (FS-AFDO), and Profi has known issues with
> FS-AFDO that degrade runtime performance compared to LLVM's original
> profile propagation algorithm. In addition, Profi's min-cost max-flow
> solver (applyFlowInference) can hit pathological compile times (30+
> minutes or hangs) on certain kernel control-flow graphs when profiles
> drift slightly or when combined with GCOV [3].
>
> Pass -fno-sample-profile-use-profi to disable Profi and restore the
> original profile propagation behavior that kernel AutoFDO was tested
> with. Guard the flag with clang-min-version 210000 since it was
> introduced in Clang 21 alongside the default change, whereas
> CONFIG_AUTOFDO_CLANG supports Clang 17+. Note that cc-option cannot be
> used to probe for the flag because cc-option invokes Clang with -Werror
> but without -fprofile-sample-use, causing Clang to fail the probe with
> -Werror,-Wunused-command-line-argument.
>
> Although SampleProfileUseProfi currently defaults to false in the LLVM
> backend and is only enabled by the Clang driver, explicitly pass
> -Cllvm-args=3D-sample-profile-use-profi=3Dfalse in RUSTFLAGS_AUTOFDO_CLAN=
G
> and --mllvm=3D-sample-profile-use-profi=3Dfalse in KBUILD_LDFLAGS as well=
 so
> that C, Rust, and ThinLTO flags remain consistent even if rustc or LLVM
> defaults change in the future. Unlike the Clang driver flag
> -fno-sample-profile-use-profi (added in Clang 21), the underlying LLVM
> -sample-profile-use-profi option was introduced in LLVM 14, which
> predates the LLVM 17+ requirement of CONFIG_AUTOFDO_CLANG, so no version
> checks are needed for the Rust or linker flags.
>
> Cc: stable@vger.kernel.org
> Fixes: 315ad8780a12 ("kbuild: Add AutoFDO support for Clang build")
> Suggested-by: Rong Xu <xur@google.com>
> Reviewed-by: Rong Xu <xur@google.com>
> Reviewed-by: Snehasish Kumar <snehasishk@google.com>
> Link: https://github.com/llvm/llvm-project/commit/2fc4a4a9d3a87a9e11c48ef=
25522aa17c2a71003 [1]
> Link: https://lore.kernel.org/r/CAF1bQ=3DS52KWHopqxksctbBirFEr5Mz1dKKMAoW=
h-dqLHii3Nig@mail.gmail.com [2]
> Link: https://github.com/ClangBuiltLinux/linux/issues/2188 [3]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Maybe we can credit a few folks with reported by tags, to encourage to
report issues upstream more in the future?

Reported-by: Han Wang <nesthanwang@google.com>
Reported-by: Yabin Cui <yabinc@google.com>

> ---
> v1: https://lore.kernel.org/r/20261105151159.1.I0b27923381ef34cc99cdf8b65=
fea2e1bafce6370@changeid
>
> Changes in v2:
> - Explicitly disable Profi in RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS
>   as well (Rong Xu, Nick Desaulniers)
>
>  scripts/Makefile.autofdo | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> index 57a3aba6ffc2..55fda66ad960 100644
> --- a/scripts/Makefile.autofdo
> +++ b/scripts/Makefile.autofdo
> @@ -13,13 +13,16 @@ endif
>  ifdef CLANG_AUTOFDO_PROFILE
>    CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PROFI=
LE) -ffunction-sections
>    CFLAGS_AUTOFDO_CLANG +=3D -fsplit-machine-functions
> +  CFLAGS_AUTOFDO_CLANG +=3D $(if $(call clang-min-version,210000),-fno-s=
ample-profile-use-profi)
>    RUSTFLAGS_AUTOFDO_CLANG +=3D -Zprofile-sample-use=3D$(CLANG_AUTOFDO_PR=
OFILE) -Zfunction-sections=3Dy
>    RUSTFLAGS_AUTOFDO_CLANG +=3D -Cllvm-args=3D-split-machine-functions
> +  RUSTFLAGS_AUTOFDO_CLANG +=3D -Cllvm-args=3D-sample-profile-use-profi=
=3Dfalse
>  endif
>
>  ifdef CONFIG_LTO_CLANG_THIN
>    ifdef CLANG_AUTOFDO_PROFILE
>      KBUILD_LDFLAGS +=3D --lto-sample-profile=3D$(CLANG_AUTOFDO_PROFILE)
> +    KBUILD_LDFLAGS +=3D --mllvm=3D-sample-profile-use-profi=3Dfalse
>    endif
>    KBUILD_LDFLAGS +=3D --mllvm=3D-enable-fs-discriminator=3Dtrue --mllvm=
=3D-improved-fs-discriminator=3Dtrue -plugin-opt=3Dthinlto
>    KBUILD_LDFLAGS +=3D $(call ld-option,-plugin-opt=3D-function-splitting=
=3Dall,-plugin-opt=3D-split-machine-functions)
> --
> 2.56.0.455.g6c5a503b38-goog
>


--
Thanks,
~Nick Desaulniers
