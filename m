Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986984;
	b=Tq9LbwuNTJGFn5iu70dSYaVZPcyJITi1OnwFLeUHIkqmE83nWxEJiCUVq5brOUZ/0l9o
	 +u5NhQUU6xQvUm30FAEggz1hB5Wj3RUilgIF3psiU4QlDLo+1jnFxngsN2eXfF8zqbAED
	 ycgW35ejRX7bqvSRiSWpJzsj43X4jyqWVhU/gBNJ/gqnUwJtBOpxxyBlvXb18gJvq6zD3
	 CZKaOy4ljE04pXbEJVpNg9KwCV4l+AGOJtfzQIE3uSdW0g5uSHSMDTiVWokV381zpHsEl
	 cQvMmATXsRVsODdUiLQXefcer98X/JzbpmVbzmUANvabwJK6kEIsKSTbcEYeEBpsQjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zCfrwF+d0gm8FLK7Blq7MpU0ABelay9GJEspD8JPZms=;
	b=xKM9xtz7Kc5+At3C036CwBY0wOTFP9jh6mWWpWub4W5iMphCldjiqtJZKKHcNvDw4moz
	 VsPpjHm0J6t32vT9ztw/5hXX+9RpA/wxjUaObVH4RcIDxdhsqdpzALAVMfwdx7qUlLxvk
	 hNfjjTPn4UGO2nzuVorxHKsDSiRnzPF9bma12xg0b5G9WqSyyxg812qhTupwhozbF1fp8
	 y9tZkhgfRdJ8BB+yAp4xqhccUufMjKBjdxicMxPw45XhdhDl0tjHOzBfga5FW/P762U5l
	 fCAFdZNCJrIWzvb95xhdfytoquWy/H0jf0plmv2C+FD1KSHQ1ZUHebM3NyBAFm+6uvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l2ro5fQr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F5606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 213F5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l2ro5fQr
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso3899a12.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:43:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793986982; cv=none;
        d=google.com; s=arc-20260327;
        b=BxnM/pqGqZK4nKSgn8K2rBSmSoBJDA41RUuq8C867pcoFoELtVrxuM/UXL0yTzt3ex
         gE+UHRWJOF3UIAt3/DEx0JvvG0dQm/wCS9DYk4dbNDnHkGS6rrjaLpq9R1KFWrtnWJ5d
         XN/C9u7gkhIkMF3NW5g86D995svRjrCz0q1IaS6NG+5AM2IqD9HEd/jt4dF6Fir1Eb6a
         A6+8vMxcP7bRn9aV8yVZ7QhicBuheUCyPS7UjcBsfo05Gxq8jMBX4+dqT4KJbeeXBe8/
         JAipSSqZsYmIa2q2qoKGR0GeOC55ygAhQnT5vk6lMTu1eDLDQeIOaU4mMMINEhgzHtVp
         jWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCfrwF+d0gm8FLK7Blq7MpU0ABelay9GJEspD8JPZms=;
        fh=kgc/tnBXVUqvH6vWl0yWP7L1nKEZPVROQxH+DEWsxF4=;
        b=if7prDIw3CVLA/oJgdfc6y7J2IWEZVY2rEgOQtDw+Uk+8UsRu8BxmGhu8xekyH5toB
         wKbLYe62pZUjEI77WmKo00ze7ahcy6yCJTEasB+m7S7zJILq9HxPHPj1i5DFHnOpxIb5
         LeqIW+HNAMGgcQ/VJpYMy69flOTogBXIV97M+YpMqfpXplxyfO8IALajc+jI0tFy9k+/
         WgcBfFRSdk/MHZ3FYzA3foxJN/q1PDmh8B/MwgAwd0O6sGBvbBcquwR1ISgSyUgptTas
         IEY8PpAbROFpqTEztJdvd4a2Vy4teA98jwllkkNEe48gZF0uAIo1dE3eoJq72doIWhfN
         02cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793986982; x=1794591782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCfrwF+d0gm8FLK7Blq7MpU0ABelay9GJEspD8JPZms=;
        b=l2ro5fQrGF8ThcmBTRuXeAQRtbC/ARC1ruTiblsIEn2TfppdJiydYhKAM4Pfr6JIQM
         LmzWSYpfeCkYvybW5XzERjWOO+6ggOGxW1b5Q0S1/5Nwphf11n5Zyqi0o+WmhZ18AL34
         bu7QEScxPJWzlU3+4nw+SDW0gHa7ujBtgCU3EL78GwCPlLGAQai4bYGevl3WnHpN4cFc
         aAGG0P0bjrCebkNJmEzrz2n3jrEKJqdTDq7fSg32FrEga3uAMZa8+0fctC922fgiezc9
         SmB1SAE0rxRy8hRrjFof1/beFTpbeXVK3rmbPxIStIUohKKEazLHCMUOR3keloElEMN5
         chXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986982; x=1794591782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCfrwF+d0gm8FLK7Blq7MpU0ABelay9GJEspD8JPZms=;
        b=YBl3aVt6HeFmlT+/9W4m4obtLkOd6eGUgx/+lFWAwZy7n6vm9s424QQORTXV8MlKGN
         tz9s5IF0PXvElF1sBQv4DHv6z0+daZUf2Kbpo2L5UTS3kLMF9xAgamnJ7BRJVL9soGEg
         ErRUNM3p6qIfAjj4UuxlOArPOBimpCIs+iJvuTz+LwpJyOlwLD8x/HMfQtUZBuAWVkpz
         NQah1Buc2tup2VuhpGxX1TaAPX8C3AXHwyWEolqhAMOZinJQfk8ng8rBGVllUTvt9sVA
         +wEBiRRbDREAXweHgwnhCTaMNUwr9AP8o+6w011hU3LZ4CZUBseLwpkdqq/RuRzYUHh1
         GiEQ==
X-Forwarded-Encrypted: i=1; AL+hErGuXx58ytk3Ah3QMgd8y1V//DzmtR4+lHdcgGG3zbAWz5XQFs6K35Y1t8PXJaFKThllHbfhgiQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GEzyZuLdUeHYqEepqpR78yyACqWa3HMJ4dUHb9eUPnW+hfEma
	T5uyas+c+3P0unHaF0ksAfqVzp0AJpi9YocG8nzKZs1EyY5nkOJf3GzQJlp0sD9Y137GGve+f+s
	Y0nTYJljXUSCZhqsJjHgCMk5Ms+haP3WyiiwkCe3n
X-Gm-Gg: AYBFou2PyHfhRP0k+uuznCXs8k5FHlfxGcBDgJ/iP7PDqiyqZlkG9zwCOE/yDnJ+B2F
	nQtqC8wotCrhsy1y5Ka7qHr9QB7olvgleSNAl7L+jUB3vSXe8c8lcHwFQpbbhIAJNkVOfGKSgbV
	g33DPGIQnp7xKWX7URl08tf9xRvZjehjrPKQrywR1e2pSH7zEd3bH5Op4Jm1cAP7r4Vla4XgVcH
	2ONqJSHiEPAdgwUuaEjflFYzJK7YXo46AX+U+T1w7pMgtuE7QKkqhbmDrpRXllDUEKkpY4aChmi
	Nkh5wUPCZAkX+YPUXzVA1QpGvH68nJyKKICYQUNcKo5E//pOEtdF1oOAMbh20WnRnfvD1B/t48g
	/qZ4ziUNMlaif6uqwW7dJQBaMlgq3C7D/tskyVyB7QKatZc5CGWs2aakrwn/BoxQZKWzcY1o5Gs
	E9wtnXLVutnHv9
X-Received: by 2002:aa7:d790:0:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b6f841a8e9mr5248a12.7.1793986981869; Fri, 06 Nov 2026 09:43:01
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
References: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
 <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com>
In-Reply-To: <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Fri, 6 Nov 2026 09:42:50 -0800
X-Gm-Features: AclHuK-wkGWa84CFDmjnSjcaCwRdnzfHPz195HdzeZhErhZwgCS6NVR4XJm0nNw
Message-ID: <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Douglas Anderson <dianders@chromium.org>
Cc: llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	Han Shen <shenhan@google.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Han Wang <nesthanwang@google.com>, 
	Snehasish Kumar <snehasishk@google.com>, Nilanjana Basu <nilanjana.basu87@gmail.com>, 
	Yabin Cui <yabinc@google.com>, stable@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just one thing: I think we should also have this flag for Rust so Rust
and c are consistent.

Rong

On Fri, Nov 6, 2026 at 9:38=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> This looks good to me. Thanks!
>
> Reviewed-by: Rong Xu <xur@google.com>
>
> -Rong
>
> On Thu, Nov 5, 2026 at 3:12=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
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
> > RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS do not need changes because
> > SampleProfileUseProfi remains false by default in the LLVM backend and
> > is only enabled by the Clang driver.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 315ad8780a12 ("kbuild: Add AutoFDO support for Clang build")
> > Suggested-by: Rong Xu <xur@google.com>
> > Link: https://github.com/llvm/llvm-project/commit/2fc4a4a9d3a87a9e11c48=
ef25522aa17c2a71003 [1]
> > Link: https://lore.kernel.org/r/CAF1bQ=3DS52KWHopqxksctbBirFEr5Mz1dKKMA=
oWh-dqLHii3Nig@mail.gmail.com [2]
> > Link: https://github.com/ClangBuiltLinux/linux/issues/2188 [3]
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  scripts/Makefile.autofdo | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> > index 57a3aba6ffc2..8754b60ad2ab 100644
> > --- a/scripts/Makefile.autofdo
> > +++ b/scripts/Makefile.autofdo
> > @@ -13,6 +13,7 @@ endif
> >  ifdef CLANG_AUTOFDO_PROFILE
> >    CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PRO=
FILE) -ffunction-sections
> >    CFLAGS_AUTOFDO_CLANG +=3D -fsplit-machine-functions
> > +  CFLAGS_AUTOFDO_CLANG +=3D $(if $(call clang-min-version,210000),-fno=
-sample-profile-use-profi)
> >    RUSTFLAGS_AUTOFDO_CLANG +=3D -Zprofile-sample-use=3D$(CLANG_AUTOFDO_=
PROFILE) -Zfunction-sections=3Dy
> >    RUSTFLAGS_AUTOFDO_CLANG +=3D -Cllvm-args=3D-split-machine-functions
> >  endif
> > --
> > 2.56.0.455.g6c5a503b38-goog
> >
