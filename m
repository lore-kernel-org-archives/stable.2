Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994361;
	b=KcHc9VywXeQzM3IzY+Op8FMmF5mU+F2K7i75zwZ3gY3nUTo22zh72ZSnCaETtvocNdrG
	 m3w6oBtK81uYpD4DxG292/76CnJg0MuMggIccNXs3d1eVcII6BDlDtrjX5m5PHUNxyw+a
	 wmamkIA1wpnlKcAz5qZ3Zdb9E7+X4upeiKxwtBUoVMwr27gCKmQQAUNvlJMBpX8dy7kHm
	 mpCC14z4mzwe3RdD2CdACdlfG7fxTHl3mpSYkdicxgzYu5sdosQUI1cLTCK0/HRsc0EXX
	 L+zTQ/rPh4LRspH0imfYTSJC6mnHs7I94ymYlhvaMdDjt7w0CPB8j3NJVHg1vPDTVsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MtW6cUlF0xWQVNMRbFIZNlbptYiDw1CO/QxWvZcoGes=;
	b=m3/oDD/j8rbTo7nRN7zm5Q0O+/6N1G4hF+1HG2Q5CcdiJ3JUGhCHKlWfhx3A22DgdA2j
	 c/qJ3YbUGaq/pRtW4HGYpGMYyH5bDLYAE6ugdXh0+VjOtQEtdveebcSqRnALxxeizBO+j
	 Iq1xtFYpWJDQPt+sY2DtakVxusPHlnMbgdsUIwrYvLVX/nclE/gJHW47ur8xhmlDEAobC
	 8AoyoSig+UmwrtJOVLURhd4j066peB2+26AkLqzpELjARMvq2OwWJlIvucnJ/3YHOth74
	 wiFB1AVaTnTKwTg7XxXlDx0AiKv3a5OavgymnAujhvkKqNjKcrJ0e18YsylnsE7Q/fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0lSW8LL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AA606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72AA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0lSW8LL
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so309a12.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:46:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994359; cv=none;
        d=google.com; s=arc-20260327;
        b=KIadcH4t2hzPyFjMbE537DgVJEd0bBTnD3T/P5NbsF35TBBwegKluOUFxeWj6VDcDf
         KnKTpVRClVNIucMDfqZwx2iQbEPtpw8L9TFUybWIHZhMSxGPmrbJCuLHIiS3yxD3YE6S
         kTXfUJgoUoxoDOnwMdx2Qr86PmOGxbEmGdnnlboQxjmSTVPu2bekcqjYWPr75VjjExuW
         G4u+wGr3k8WQPzZgz9F0945aDsSuz2iYxCGldmCKUOyLi+CIpo5ROiKCQ7pUm7s16XsZ
         chBnzsFJHsL9SMPPg7mlVCL0rcSnlX29LBxYkaXmRS6ZFNa3HjheaBRvvlzfmTc2XOFv
         EPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MtW6cUlF0xWQVNMRbFIZNlbptYiDw1CO/QxWvZcoGes=;
        fh=UIXkf+6VacPjxE9kZub0pka/PrwgpvZ7HJxM3wtKZFw=;
        b=QWw1YmwdcwkIx+17IWb2O9REdPygtbbtfoLODncsOKPdh0lJsf0JR+nDd76PP4vCak
         mPh5iene0EUlOHcciVQDo03aJavnQFKTBM6UlA01IPD5nbqpoHw/EIZjbLHDuuntXs/q
         m/APBGuAVXrdEuAWx+WBeUAlPcPOGeEWsuK1EnvqcSrCTDh0Z0xQKgRJ6Ztejjzpz2YB
         V1n68SPb6162NUJBTgL5ruwzkEWjyEooWu7jDoaHPAAcNvVQLurYT8KyE9kinTiP/Web
         M3a7f0QkcVhOGu5p+U4efr8W5/zVTCfRUfWbmJXbGo8Nx/TVIS+d8oFFy874RSjKfKJt
         Nzug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793994359; x=1794599159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MtW6cUlF0xWQVNMRbFIZNlbptYiDw1CO/QxWvZcoGes=;
        b=b0lSW8LLban7Eer3WywvdFdQTbSrylW92pzpB1SznsBnaZEiz/E/mE1Ip9NJMfFT2l
         XjywJ0NDQ5ygvJ7ZXsfY2bkMJK18bVrY4MR6mWtzjuUiGOQauJxr54tkPLPipTCreCgn
         7+E7Wfev4B/SHsI6VGpf4Zfl0AjwC5Cg+74fNxZM1rk1oN8hIWWGUB/S7fy2mGS1l5uS
         moqnrQ2FWyXKqMHLqVC6QSNNKbcbqN+GP4/Syip1H9nFT4/PzdLxC80+nzHB69HS9dSZ
         eVxcLRFY+ZeyjSnuCy2tC2UHhrZ4xUKkftFfI+QiM118IjMWFAceDTjo5rzdOJAsyjCQ
         iPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994359; x=1794599159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtW6cUlF0xWQVNMRbFIZNlbptYiDw1CO/QxWvZcoGes=;
        b=zTfM/ht/hhTwBhbBNGpFh71/thR78iAirnX3qfratvHstahxpzHp2fTor23HjDQFdI
         UZg54+9PUjOnb2a6I4o8jaGnIsEffmvF5cW8oE7oeG5qwWiDA83D3TcqwjLJjZ6GrCBn
         v34sd76KCbN9O6G+GrwAXdibIlBxlVvA9ofOwl9COScQ4pg5k8qrxZ+ZVaQg26BS7Wan
         f8GPcgAxgafJMpdkhu88ho24896ylFhH2/+UaU37xod6AuV1R4Srtq3LoTNbWTCsMj5j
         7a2C9Cf5PrbSQ/z4mla1krX5HqQabu00+bs81qtmVSp90zQ1svrge5iR1Gb0dyWAb+8q
         Cg1A==
X-Forwarded-Encrypted: i=1; AL+hErH/BY+D4RWJJ48ZKHhM4H1SSfYc1sKJ1AP9CFOXwbrTMpm4arHLmzd1XYuNeA0s+eXasmkBwwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9udSo8Yonj0e9uJl9HxhZhY82hOpRIMEQ6oeLpDglTbwpSmlba
	ymlOwUKetoWJd11iLgfi1A3pkYIDdCtvIeldPrgvvI7i7M/Iw9XLx/BMVSEz29M/7X95aDfu2Rx
	isJGDjeWZe243VD4AWG90hz/JC5SQzoBn3aHNvxMxTMdqPApAYn1kNaht3o8=
X-Gm-Gg: AYBFou0K/LIZ9+VpT/PdlunJnn3Tcc96VqdvMOf3FH21g4ngIN2tYA83K+tFyv2hSqp
	jTf4fkZd8Ta18DWuLZ2ttZBFubp0UIyaFYjoEygsBT7NqyXqpXapGivT8707ESJBPk2sFz891mK
	xu5PHaFwDyf6wHRRuRSpcsAM1hM7MHG6J5TRtZJdCmsMigM1T9MPTv/HQt3Ml8PRV6vR4zRUgUo
	h3kl5RsV7nJ7Zh8OniAjdUCuuvKMBGkRCW+33zk33fRWM6B2aXPvo/WPdF9yAksb3tKEbcU03w1
	gGU4eurZbXlShJBOK/DdeiiqaOX0ux1H8lB9q1ZO3P7Kr5QvoLozYhHfZ+fEVv0TKFS8ioGLVPW
	fRykR6PkpJM6Xsur31AmIAPCWaC0QFTZykkFtyU7qNaRBR7LSGUw3x/NoQ3jisGhw9X1+
X-Received: by 2002:a05:6402:424c:10b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b6fad61dcfmr562a12.5.1793994358649; Fri, 06 Nov 2026 11:45:58
 -0800 (PST)
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
 <CAKwvOdnnonRfRPPv8cJU5-n_N4JpJLsVixyTYOtmgMjWyz2LDQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnnonRfRPPv8cJU5-n_N4JpJLsVixyTYOtmgMjWyz2LDQ@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Fri, 6 Nov 2026 11:45:45 -0800
X-Gm-Features: AclHuK-y7Snn7fa_RHpKW_RqOSo_pYKXo3yMIDsQSg8EuPiGD_nqwOFftAAYja4
Message-ID: <CAF1bQ=SFw4GR3_HagE6k08ipFebgmxqE8UDJGmOQq9u3-0ZOnw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Douglas Anderson <dianders@chromium.org>, llvm@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, Han Shen <shenhan@google.com>, 
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

Look good to me.

Reviewed-by: Rong Xu <xur@google.com>

-Rong

On Fri, Nov 6, 2026 at 11:44=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Nov 6, 2026 at 11:38=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > Starting in Clang 21 (LLVM commit 2fc4a4a9d3a8 ("[Driver][SamplePGO]
> > Enable -fsample-profile-use-profi (#146795)") [1]), the Clang driver
> > automatically passes -mllvm -sample-profile-use-profi whenever
> > -fprofile-sample-use is specified, enabling LLVM's flow-based profile
> > inference algorithm (Profi) by default.
> >
> > However, as Rong Xu noted [2], the kernel's AutoFDO implementation uses
> > flow-sensitive discriminators (FS-AFDO), and Profi has known issues wit=
h
> > FS-AFDO that degrade runtime performance compared to LLVM's original
> > profile propagation algorithm. In addition, Profi's min-cost max-flow
> > solver (applyFlowInference) can hit pathological compile times (30+
> > minutes or hangs) on certain kernel control-flow graphs when profiles
> > drift slightly or when combined with GCOV [3].
> >
> > Pass -fno-sample-profile-use-profi to disable Profi and restore the
> > original profile propagation behavior that kernel AutoFDO was tested
> > with. Guard the flag with clang-min-version 210000 since it was
> > introduced in Clang 21 alongside the default change, whereas
> > CONFIG_AUTOFDO_CLANG supports Clang 17+. Note that cc-option cannot be
> > used to probe for the flag because cc-option invokes Clang with -Werror
> > but without -fprofile-sample-use, causing Clang to fail the probe with
> > -Werror,-Wunused-command-line-argument.
> >
> > Although SampleProfileUseProfi currently defaults to false in the LLVM
> > backend and is only enabled by the Clang driver, explicitly pass
> > -Cllvm-args=3D-sample-profile-use-profi=3Dfalse in RUSTFLAGS_AUTOFDO_CL=
ANG
> > and --mllvm=3D-sample-profile-use-profi=3Dfalse in KBUILD_LDFLAGS as we=
ll so
> > that C, Rust, and ThinLTO flags remain consistent even if rustc or LLVM
> > defaults change in the future. Unlike the Clang driver flag
> > -fno-sample-profile-use-profi (added in Clang 21), the underlying LLVM
> > -sample-profile-use-profi option was introduced in LLVM 14, which
> > predates the LLVM 17+ requirement of CONFIG_AUTOFDO_CLANG, so no versio=
n
> > checks are needed for the Rust or linker flags.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 315ad8780a12 ("kbuild: Add AutoFDO support for Clang build")
> > Suggested-by: Rong Xu <xur@google.com>
> > Reviewed-by: Rong Xu <xur@google.com>
> > Reviewed-by: Snehasish Kumar <snehasishk@google.com>
> > Link: https://github.com/llvm/llvm-project/commit/2fc4a4a9d3a87a9e11c48=
ef25522aa17c2a71003 [1]
> > Link: https://lore.kernel.org/r/CAF1bQ=3DS52KWHopqxksctbBirFEr5Mz1dKKMA=
oWh-dqLHii3Nig@mail.gmail.com [2]
> > Link: https://github.com/ClangBuiltLinux/linux/issues/2188 [3]
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Maybe we can credit a few folks with reported by tags, to encourage to
> report issues upstream more in the future?
>
> Reported-by: Han Wang <nesthanwang@google.com>
> Reported-by: Yabin Cui <yabinc@google.com>
>
> > ---
> > v1: https://lore.kernel.org/r/20261105151159.1.I0b27923381ef34cc99cdf8b=
65fea2e1bafce6370@changeid
> >
> > Changes in v2:
> > - Explicitly disable Profi in RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAG=
S
> >   as well (Rong Xu, Nick Desaulniers)
> >
> >  scripts/Makefile.autofdo | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> > index 57a3aba6ffc2..55fda66ad960 100644
> > --- a/scripts/Makefile.autofdo
> > +++ b/scripts/Makefile.autofdo
> > @@ -13,13 +13,16 @@ endif
> >  ifdef CLANG_AUTOFDO_PROFILE
> >    CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PRO=
FILE) -ffunction-sections
> >    CFLAGS_AUTOFDO_CLANG +=3D -fsplit-machine-functions
> > +  CFLAGS_AUTOFDO_CLANG +=3D $(if $(call clang-min-version,210000),-fno=
-sample-profile-use-profi)
> >    RUSTFLAGS_AUTOFDO_CLANG +=3D -Zprofile-sample-use=3D$(CLANG_AUTOFDO_=
PROFILE) -Zfunction-sections=3Dy
> >    RUSTFLAGS_AUTOFDO_CLANG +=3D -Cllvm-args=3D-split-machine-functions
> > +  RUSTFLAGS_AUTOFDO_CLANG +=3D -Cllvm-args=3D-sample-profile-use-profi=
=3Dfalse
> >  endif
> >
> >  ifdef CONFIG_LTO_CLANG_THIN
> >    ifdef CLANG_AUTOFDO_PROFILE
> >      KBUILD_LDFLAGS +=3D --lto-sample-profile=3D$(CLANG_AUTOFDO_PROFILE=
)
> > +    KBUILD_LDFLAGS +=3D --mllvm=3D-sample-profile-use-profi=3Dfalse
> >    endif
> >    KBUILD_LDFLAGS +=3D --mllvm=3D-enable-fs-discriminator=3Dtrue --mllv=
m=3D-improved-fs-discriminator=3Dtrue -plugin-opt=3Dthinlto
> >    KBUILD_LDFLAGS +=3D $(call ld-option,-plugin-opt=3D-function-splitti=
ng=3Dall,-plugin-opt=3D-split-machine-functions)
> > --
> > 2.56.0.455.g6c5a503b38-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
