Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB534D90A1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448975; cv=pass; b=N0ykAB92VQTDe44SqbxlkzczmPe+7QMR0J+7XPW8kytlTdi4AkRnbzp8soJM8CWR6UT3U5qFYPX02YAYwJRuORHB1bYAvSPIk8w0tuyQdcFTN2k/FERDG143uhaqhWYg+5JV991PahpJXeSxAEoU89OvkfjQOmo95fAU/f9hCIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448975; c=relaxed/simple;
	bh=iuuQ7dR9HdxMRXsF+ziirdBpFFjIxzmgzm3h1gT8K+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYlQMp5VOe5NR/45MLC9ue+YVdNmYzsaXVLdDjoNEgT2J/D+TRwAURSeCMCFmYl6VwKzlnPxGM2aOgpsJI6mgin8/ISCoytRfgWpSKqvXW2rn1fRTVp/PhvQ4P9jm8dgwgsnOlRbojpdTSFpCtJM+fvM3Hz13zsZkUTSH0Zme4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd/M0Zpo; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd/M0Zpo"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-396afefb35bso413049a91.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448973; cv=none;
        d=google.com; s=arc-20260327;
        b=djaxD9JEb2x83N5yJCv+bARUsLrzcxzJZIKNUSo1Ltjkoy1yYcVL+RnFHyNktTYFH4
         kA/CSSnfRIf1uBPrCSWc2l25/bQQjH5NP7TW03yYtKlSi+HbPLGRbdoK+cd5XT+Hzp/D
         CTjKsGaKpAvTEpucV5AyzyTzQ0Tsh6/NgHojZgvfU+TtsaZjTzSG5qTHhg7yEyGPjNa+
         GZjRbytOyZE2BhpZaQXA3HuN107XhP+DZpN9rAnGFfgUygvz2BIjow7W0nNYf8hSHPOi
         hCQc6zZTYC05LJ3i1DZVWSIOEuPeJpb3ZXcxA4/fwDZ95G8z9dtRz3m0gD77AUj79eCC
         uZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sxpOnE7LTPITrCMhlDVyzIySVnND2vIqtOhTrxjppFY=;
        fh=MSF/ww2t+81mwwmMuAwO5JlByp4QdHBahXhOQbkqqkg=;
        b=KiVpH5mJLFALEjNNpuiK/RKgLxq92JzdNxMdSjPlANt63Nmqxy/aTom9FIW8wlvyvA
         XAUtWXEQdHxeu22g2cbQFp0M5Z8a+w8yxGhjf1DpaoPrYn9QOYFEHxALB/3QStEG1BVQ
         wzYmz0uzANDlJt4nLxBbERakre+4sjyUB1P+A8la9iTPIJYnBpTBx0TF+4AkeyE1c4vE
         Kd9scUW1XzuvtBs3pVg3iPBi4AS/bTaeVVhq8QPPLZrJDA+poOEqWVxsakqstP4QguOW
         sdkvNK2gz4c4IbIoTtrGv5lc3wsc6dgFw3VMQJiuvVKA+wLQyUXA1ImqFxZ/9ygp+rTO
         w85A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448973; x=1789053773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sxpOnE7LTPITrCMhlDVyzIySVnND2vIqtOhTrxjppFY=;
        b=fd/M0ZpoaMvnsHP/N8rtiiMyi0ienG5mK9WCAjyClRmp/IY9HGts+szIYHt0p8GWJn
         i8uJTdI3d2PVNJZphSKkB8dx9lmIIR5/GdsZoDmqkRPwIb7pi4ZDTqxdhLUFJpyriL8Q
         jaPEBQnU4KsuTNOv09xlGBLghE2VuedLetNDuZuKYDy9Mj2yfcur2t3LGMBle4doLSY9
         8lay4VktwcM/woxwY1jy0sHT1eOMRF6kLmpPq46gE21JfRWiG3J7bZdU8tEbp364gXSu
         Ol4d87KyOfVCdEPd918girfW3PR9zuvreScvqa5awb0DvVDKfJ48zKBWDnUcaq3rW2OO
         et7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448973; x=1789053773;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxpOnE7LTPITrCMhlDVyzIySVnND2vIqtOhTrxjppFY=;
        b=hMmOAUOjLsdxJRsygDA/qw+t6+ZmA6nzye8DNiuA4goagbjJ8KySgeREDiXMOxQzQv
         bToxBoxjm3t/LB6xx5vyjl4H+CK2O+v0dlXaecFslsnxA/gFNv2DrRNqhyv2MFYt2TQS
         2HO4BzKIA3wUD16icEtquudbp3iof9s1KEGWjfcRT1aJ2cU5RJocVbzYVC4zKmZsV/AC
         iAfNoGttg8ZuiZ7NuqY7o4IyC5qPzt4MtrStuvyvwNN+WBtbL2Dwkc1bOHf8Mm0de7rC
         IP4/WPOsOiYrmOfLSMv6YvjvcCk+7OqZWFf3oKaEvZbFigCBYXOF3ryYn6Ivo9y1c85h
         eCbw==
X-Gm-Message-State: AFuF++l0SI40cZDxOn2lHw7teEJ1iQEloByWqHGhqpfU9tUc/mdEENmd
	42fpHCkJskkQP+pccC2H9+nyr8tFxwkwprl78IDdnvnVXthaA6YCbQ9u37jKHNRe2gOik5Aex+N
	VqI2/V2oTDgt9clO7dBxXoIrRlPpUQWrDZQ==
X-Gm-Gg: AYBFou0/VWmoDLj9bJeUibBbT67TCw/FW9VuALMNm60zgj4vmxL9n/3jjJt5hqZ6/X8
	zDW811hV/LYcIIeatN9rr/hfda4nFuH2R4GP2NjR4nREz25y8A7cNbMkNAJ729izX3YBpgSX7I7
	InG1u/o/jSiQyAvoLDStPIOBgktWtrDG2e31Ga97cd2qjQwOrAJykILNC71aP6o+dzW/KTfDtg5
	ZY25gCAbnoEni9CRcToDV2OGYSKVqnx/dkxKd07Hr4WPlE3MXXLXmksj35nUSKVhaM34l3H+RMG
	PMAKWTWlaaY3L70FgRl/Dkfgsj5ZLPEI5Kwa6V8jqrVkw5+JArWYqah4CRx4soUYb0+jMz1zJxX
	su5/gz83PXgLulad/TH3PoG/OMxFCdk3jiQZRR4FF6YCpsK6SaXePRyCHlqd//ri4byizmUsW
X-Received: by 2002:a17:90b:388c:b0:396:d28e:b52 with SMTP id
 98e67ed59e1d1-39aee107b37mr12466824a91.3.1788448972434; Thu, 03 Sep 2026
 08:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090303-moonshine-study-20ce@gregkh> <20260903133902.763984-1-sashal@kernel.org>
 <20260903133902.763984-3-sashal@kernel.org>
In-Reply-To: <20260903133902.763984-3-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 17:22:39 +0200
X-Gm-Features: AcwNN1VI1PTBa2XwAIjX67TudE4rpnTJup0KNXPTmA6RZm9oO9IPITjG6I2GENc
Message-ID: <CANiq72=-n_2CJf=pez4mbDWVrkO2cZBXNg64hGzmRfY+-zgovQ@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 3/3] rust: rust_is_available: warn for `bindgen` <
 0.72.1 && libclang >= 22
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Burak Emir <burak.emir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:39=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> [ Upstream commit dc01dfb37b34beeefcfe1c3055364d41a4070c7e ]
>
> Starting with LLVM 22, `clang_getTypeDeclaration()` may return a forward
> declaration instead of the type definition. This made `bindgen` generate
> opaque types [1][2], which in turn made us fail with e.g.
>
>     error[E0609]: no field `__bindgen_anon_1` on type `bindings::kernel_p=
aram`
>       --> rust/kernel/module_param.rs:78:46
>        |
>     78 |         let container =3D unsafe { &*((*param).__bindgen_anon_1.=
arg.cast::<SetOnce<T>>()) };
>        |                                              ^^^^^^^^^^^^^^^^ un=
known field
>        |
>        =3D note: available field is: `_address`
>
> This was fixed in `bindgen` 0.72.1 [3].
>
> In order to clarify what is going on and avoid confusion [4][5], add
> a warning to `rust_is_available.sh` about it when the versions match,
> similar to past warnings like the one removed in:
>
>   commit ae64324ad5c1 ("rust: rust_is_available: remove warning for `bind=
gen` < 0.69.5 && libclang >=3D 19.1")
>
> In addition, even if the versions match, check if the issue appears to
> not reproduce with the given binaries, to avoid a warning in such a case.
>
> Finally, include tests.
>
> [ Nathan, in parallel, updated the instructions of the LLVM+Rust
>   kernel.org toolchains [6] so that `--version` is not passed to
>   `cargo` for `bindgen`, and thus the latest `bindgen` is installed
>   by default, which should help to avoid some of these situations.
>
>   Thanks!
>
>     - Miguel ]
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust-bindgen/issues/3264 [1]
> Link: https://github.com/Rust-for-Linux/linux/issues/353 [2] # "Missing f=
ields in nested class with LLVM 22."
> Link: https://github.com/rust-lang/rust-bindgen/pull/3278 [3]
> Reported-by: Burak Emir <burak.emir@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1247 [4]
> Link: https://lore.kernel.org/rust-for-linux/CABwQupNfMAJOGqRM9ke6tj4f53d=
CCsBDKU7Vp+zf8mwk7bqt8Q@mail.gmail.com/ [5]
> Link: https://mirrors.edge.kernel.org/pub/tools/llvm/rust/ [6]
> Tested-by: Burak Emir <burak.emir@gmail.com>
> Link: https://patch.msgid.link/20260719120514.159914-1-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks Sasha for the backport -- I was going to provide a custom
backport for Greg for this (and other "FAILED" notifications I got for
a bunch of things), because we shouldn't backport the dependencies.

Cheers,
Miguel
