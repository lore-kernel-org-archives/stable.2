Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986744;
	b=1P1qHj1t/U50mn50lnXk/sWR/w+2MNs6DvEAKL/JFZrV6pPot8VydjWt20FjLZ2dIyNy
	 xwUlVcafj/aK8NOchpcORNVDGcz2eb0p7SDjV+98yg05z4Ftf38d2UmfsZwJYcEK7oXZv
	 XC1Q10motraoaGJLwsn8fa1li5pTg4G1/JHfOTdiHTOwC6eQiFlj/cQUufviE86/e/cTY
	 qYiAegciM697xdzLXY7RYpN4oeOUiZswEAiZc/qMd+ikfsb1a97Pq9GjFXkwytdwqIhP8
	 3djZhnMSZR2RSF5c9j4UPGz88z6loKFskFAU3DHY/l/QKfWPcf2c0ilhfih0h0nLvrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GqiDj6frCHSUuvpzSZKk7ALvPsAa+wtM6puWkf2+a1Y=;
	b=nPKozhU5VtgW+c4FxlpM5udXpE8/QM2VsTeIbxwVg/NBsPLYxW+gX/mCwz9p3xvoK8Jx
	 btA2R5Zzz36oHYj6cJQjwF6eJ3jsv4TzEdDUEx4bkC7HLoMPZef8l4cRJipTnCDifggMj
	 V0QlfxkgD4OtU6wSSyNOc42c/ypVHgWubBxGoghDL04ikEsbA0hLxYy6f4G9Y7I8jWi0I
	 DPwvZ2wGZEKZdaDdxRLvO0pgbuyiAuuOtBgz/Fs67yW4OvLy53AQ93FelnWiNxL9TStN5
	 U8tea5n8vnurghfJDF1/lrQ26cMtzU+EmpyWTjOsz9oYKrPCS7vTpMJpaB7eWs/HJSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M7CeSLUn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E3606EEB0
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F6E3606EEB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M7CeSLUn
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so566a12.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793986742; cv=none;
        d=google.com; s=arc-20260327;
        b=Zo2bnXS6G5oR0bB8y05D5vU04t4qY1Kjk228l63PwS5NF7WOUzI7UOhpsjGXC74UUJ
         rgDfdq1+OCXSfWLMsfnivktA8cW4iNl8xRHpiifClcROoJHa6HIIqCE9kFB2GTV7REVN
         +55AuyriyMKvHRlMt1EyWAfNxKCfIVlUky9gBRIEEX6L5yHEEzCpKWZN6GfBwrWlttrP
         W07tWygO2GicCJ7yHPH+XLxlktKXbJL2DPqJITU+Oz33gAjZCaQ1e70DnJMizG0N62Wo
         k0F+mW401/SKS/l0UVSmIQZ8KXzRlBcwirgbTMB3HRYPMdBvoldL+NeHXzCHxv6AdtIj
         mWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqiDj6frCHSUuvpzSZKk7ALvPsAa+wtM6puWkf2+a1Y=;
        fh=whcDcFE0F+bB/Z/ab0NRVO570rW6RtPNt+DLgSVwBak=;
        b=UwT+ljcW1ny/FGZ9NxqD2mrrcXGSDlhWf0cVfjL5UTFUyRmzPwmkYF9f+b/yHfnJsB
         LrLT+EsQtrxzYWwvTjfwD3dorodsMLOzCDAw5MPBxjGCA3aRyHrEIe+vKYRRRHIxpFY9
         LHPKF2ckDNQhdS5qYrxaVUC1fatJgIhTVeCPg5j9WK/3PPIl1zJo0PiZHnqSlppejOh5
         CCarkog9eL+LiJWppeo+4YtN+vqXG82UKZYmHUh/DIvSB1gf4IvKB8LaNY+Wbsgkqp0+
         x5nHqVbNiWcEeKfqX61nB08X4dEOsfJDs4Mel6Ous6fiHDATk+ru7FUIS/5D5TsOCcg1
         29Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793986742; x=1794591542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqiDj6frCHSUuvpzSZKk7ALvPsAa+wtM6puWkf2+a1Y=;
        b=M7CeSLUnVxKXHq3kGnMleixotglsAYU0MiEuDhK7fsOjczEHbXTiKqJrfSGezu7e46
         ggPtTI1Xcu1odtYXH4SKP9WaZWktV2qIO6zMGm+ZLwGacmNcYBjSCJ+Z4BvSLjmsHiSh
         cLaAxzY2clUlwKsEJaU1gDoAuVR5YtNggNmVoLOadS+vVCK0RfNM/xzGagX26B70McbH
         OZbtACuWry1k7zu7QSWqfTyKzrhkuWG9u4kIM9/Ehu9AC6M5pzXqspMlwAWO+cFl2+Kl
         hoYlxUsus5SYVc6oVZQN4g3xXo9zkyEDFzFor3ASRDWe4LkSIxvWOavhR5OemRFAxYO+
         i3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986742; x=1794591542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqiDj6frCHSUuvpzSZKk7ALvPsAa+wtM6puWkf2+a1Y=;
        b=BimrZkmT7C5fEj/aRBwxFOe8g1MCCYYTdt46HNS4Ajcs4CKKpcCs47LRKpVLknICBi
         pWxf9/nVoGNVHlbpe4a5NFAY5L5z6XZxeS6whFHhY9+ATY1WKK9UB/1pVanKhbjSv1P2
         EKkfYEhKO7FmntSRhWg5J0DFJnpZcmzqUT7ltombmECGhbhhb/lol5JliL/pf6F1PQ1E
         u/q5yp777jd9CXL4k6y+J2iA5+ZOnDhL3jauAqx2XFjUHEsRIqqqPHkcqcUL2Ub6wbDO
         22B2gOlFuMqsmTmlafAlpOHMc7vzbrAvQ6ujwXB5worjVKuMhV7O1a9bpoS2Bv2nvSSl
         aPpw==
X-Forwarded-Encrypted: i=1; AL+hErEnEeNt5OlRMA5fYYZusF/eiWnLNen4RP6cUNSDvUFj9GANp4tIrfkYqaRK3MMv0P70J/ndoCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YslNhPlgWmqB9Ef8KcdwbbEcCVsS6KBYXovMchtTluQLhWu2T
	Ymtv2avhr/Q2Uu2Whn8DPvcZnEDI9cCD4G/7zWKNfSEUzVRNi5/QC3xRU0/AvHwsSkTo8qNHAHP
	4uQxOI/eofTIPJh8Wek3u8D3y9oNITMraRu8h0cb2
X-Gm-Gg: AYBFou01Q53876QXX/69QYgi9phGwoKLVfzb2EhsCWwu+rbyjms5XU+iIHZCUf2f7N5
	tHos6PzfRv+aikA87zzB2v1eUEu49ezq2NnjyIQWKZJmQ5HliN+rrlfAFVzoiv1WIcqouthqI4Y
	BGUppVhtEGKMvcSE2YhHBsYg/vVxLEDxpsixUnOXPMzU0guRIGwjiUTa0wd8b/DNoQ1E1nRwIGz
	aG+Hl68zXMqlslyuI3b2xlj6qC9peK0l6JclJ2J4rKiKkqYNs+U2BhdU2ofzbFTqaUPVXKWiWus
	6uFu9GowPElSl07umH6bDQx/fFo7SUgoz+gK3d22Zi8/WH4vMuCwUG9ErGqOEE+kiuAORPVgd2w
	VXKbn2WQzv+kbc7hQlXd3CHP4YN481u2i3yR5lSLbba5ID7eNzmqoxsrLyzrqRpwkMmIyu5SyjT
	RIRV9t1Zq4+fjP
X-Received: by 2002:a05:6402:a594:10b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6b6f843548cmr6213a12.11.1793986741181; Fri, 06 Nov 2026
 09:39:01 -0800 (PST)
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
In-Reply-To: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
From: Rong Xu <xur@google.com>
Date: Fri, 6 Nov 2026 09:38:48 -0800
X-Gm-Features: AclHuK9krDICcHvY12_TQOAPQOmYyqI_XtzGscWcqlFs1PTf4lzGC_gvkF1otP4
Message-ID: <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com>
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

This looks good to me. Thanks!

Reviewed-by: Rong Xu <xur@google.com>

-Rong

On Thu, Nov 5, 2026 at 3:12=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
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
> RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS do not need changes because
> SampleProfileUseProfi remains false by default in the LLVM backend and
> is only enabled by the Clang driver.
>
> Cc: stable@vger.kernel.org
> Fixes: 315ad8780a12 ("kbuild: Add AutoFDO support for Clang build")
> Suggested-by: Rong Xu <xur@google.com>
> Link: https://github.com/llvm/llvm-project/commit/2fc4a4a9d3a87a9e11c48ef=
25522aa17c2a71003 [1]
> Link: https://lore.kernel.org/r/CAF1bQ=3DS52KWHopqxksctbBirFEr5Mz1dKKMAoW=
h-dqLHii3Nig@mail.gmail.com [2]
> Link: https://github.com/ClangBuiltLinux/linux/issues/2188 [3]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  scripts/Makefile.autofdo | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> index 57a3aba6ffc2..8754b60ad2ab 100644
> --- a/scripts/Makefile.autofdo
> +++ b/scripts/Makefile.autofdo
> @@ -13,6 +13,7 @@ endif
>  ifdef CLANG_AUTOFDO_PROFILE
>    CFLAGS_AUTOFDO_CLANG +=3D -fprofile-sample-use=3D$(CLANG_AUTOFDO_PROFI=
LE) -ffunction-sections
>    CFLAGS_AUTOFDO_CLANG +=3D -fsplit-machine-functions
> +  CFLAGS_AUTOFDO_CLANG +=3D $(if $(call clang-min-version,210000),-fno-s=
ample-profile-use-profi)
>    RUSTFLAGS_AUTOFDO_CLANG +=3D -Zprofile-sample-use=3D$(CLANG_AUTOFDO_PR=
OFILE) -Zfunction-sections=3Dy
>    RUSTFLAGS_AUTOFDO_CLANG +=3D -Cllvm-args=3D-split-machine-functions
>  endif
> --
> 2.56.0.455.g6c5a503b38-goog
>
