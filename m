Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6C4DB540
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448998; cv=pass; b=YmWcd9WI0zAAprk+AmWZuaPVSbjeI/iam9awi0b6r6QSCUt1n3OoNXzhs5sBpEERZeJMHt76+k4q4PqSpY1UCca7Ve8KKfKMU3eidgZ1T+8qoqNLef1h/D+w7hZh2dFmKCqMZz01AApgDAE878gx6t4s2FAEvV3PrvgXaWz12l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448998; c=relaxed/simple;
	bh=lBgEjIE/uNDcy9KyZJQdhss3TOSLP76yxl4lCJ5XwvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clkM8UFwbBYjML5gkjyLPnRhxIYUIKApByAKCQBLaFmiOspBBfTDNLGRoT3JNnwykenkYJlP+7Qj0RYFKHuboG7H+XV8Dvf+H3lQd7YnWzSL0SxRY3uR9KW6mJ8dM9cViHAWBYDSLvDgOJq1MdW4Lsddni8wIyY+j7XSiR+HaoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUQfCG0p; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUQfCG0p"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398b9f77e03so301135a91.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448995; cv=none;
        d=google.com; s=arc-20260327;
        b=gtLKQ5H9SJSUQZYX23jDuNNTLXfHbaoTQmaQFcAl4uNrZeftij29QosRGlLyVxPr06
         BtMA2MeiUEeiCqiowYH9csZ2gFmtMCw+Bb6OsrOLF4vqH/EGax7UV9/lz449gbnhKQ0F
         j88c163kjox12BF/SD/IPJbMNHn+xNQjvauWOKIN1tHY3z6zbLZIYJXtr0cyUz8HD0Nr
         A35oFKlICx0PFaGvZmwJPGxMjXnbfHew0U6LE+HNIRcSqlOa+T8q3Sxe0wkPqHgw0tbM
         3lcPmbtTXmXbaqSc6HSPTS3x6TqrIPeymt70IKzvIIW50FKxdEjsGj2NjuHBhjoyTAlH
         tv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tla5agjs+qu45ntNGTLG/yW8xvbg8y+9Y1JASvqFH0M=;
        fh=MSF/ww2t+81mwwmMuAwO5JlByp4QdHBahXhOQbkqqkg=;
        b=O9Bm9fJRbm1kUr1ewIcNdqy87txX9q9/9CE8BpJ4t7dnp9lzDrpxn0SRgJL+uZaHuN
         OBKuG71renmEeJHbr9dJb833opisw2eb24oWrvOj9jmuW984pmax9DmexOlQaB0XgXk9
         UvoND1VU828VIW914vgiRxR3ysN8r8Wx/ofhyItyCb9DsbEsHBOQ236OHDoyMc+VKq3q
         cUsuTZ23QljnDCP0WiqhR8BGIn0hc1Be5+BH1YeNW+o9vOtSKUkES/3OvC2EGK2GSkZX
         sd9avXgkVbpbnWtHBoLJPCtcUs5q8Av+XB/i70+NiDizSbx9NspOxjBCO1GqbYItVI8E
         Cl+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448995; x=1789053795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tla5agjs+qu45ntNGTLG/yW8xvbg8y+9Y1JASvqFH0M=;
        b=IUQfCG0pprv8hLHsoQmRqaJit2nHDypqO7uPTXOPjatBrOVqXd2CI9sbxQ6Ev244IB
         M/eig2nbIeyDYpVNPhJrVx+yUW7pJtN37QqLFIahP2DzUPkyDV8kH3DEc8EBaRMJW54+
         MgOEYVfgS011Egw5Re+2x6Hjo5x54Fwm5o0gz9/aJ59x6uN4TfvhyvDYqSE/bcHBNJag
         v+nTTm0lJERjBjEZboRMDboCgsHrLSusOl7kjmf8lGNy04Gy7GaV+cZSYwhgSNjOx07E
         k5VFdT+Ezxic2Co4SGxYU5boBHotxtWVtI8mOBAenGGtxdcfO+h8xdMy/qMnUqLhKWvP
         rqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448995; x=1789053795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tla5agjs+qu45ntNGTLG/yW8xvbg8y+9Y1JASvqFH0M=;
        b=YxddwoKcXQJc2IyWbpcW33cQwVoo6m3CS13gWHwjgRkK7R3aCSoCaSMkgY5ypCfbiH
         tyIhNnpsQiD3QwPDwZyv2E8PlxBASQYuboFvM7rn1jKbId+XjlWvkwubtJxbUmomR7nM
         pCin6SiYB0o2XYjLrHgHQTyVU6c66rFygO9/ioVUHaxkOt4l4gLZ2zoBnQKeykJcSkFu
         Ua4eKY8Q2RRtiBe7yoTzN2eKYO/XN8XAPebVQkjzzb43zvSUhTNhZK3KFXRc+7pKBbhd
         GpzgiMRTDg9tKVTFxgJ6P7d8CXRPKjE6ViQNa4p9HSeCPR3nIMxzzY9kS4OPj1zIDMyO
         B7+A==
X-Gm-Message-State: AFuF++lbGVpyu//zLXz/mKYyiTpU16DAsPWHPwUvDJvpkj/lDV14gMoe
	RiPD9mI5O/8rWEIv7DPOF88AxG087EZ/ESsmWl5jfDF1cTkgq9teuYwmufa4YFv/AkZY5SxyZTS
	I36dWm7TDOZ8g+WW3UD12OKpnwa0ZnME=
X-Gm-Gg: AYBFou2frbLlroWk6okjGyqeFd9tgFynP8cJlw1kz7F4CJ7R86Cx86OMmrqLOR7E+ez
	DVRucA7GWwpM+j7KupWsueQdMzYW2/No5oA6KEeHkeWHfWDgnYgweexdPk55j2JGULn1UgzEKk2
	2qbTH306o0teZqRnlg3uwYLQNajb8KO3T5z49p8K17TFPF08/fQck9iZMpEJS6rFUO4abW6pk2c
	2ornoTRBahqeh+v7jXc7zHaakVv72NKoOEfYyuRxcRyQ8Pm3H+WxfOI153rUiygUIPO/SkV60qe
	449RYfreMVETA/zbtu1uKjR6JEBnGQTIAN18ZjFrJVqdYc+AaY+ERU1dHUxX5plhdJoPI3mh4TE
	Ntm5GTRtQCTKgmnmLejdty+lQ1UNZkliS4/rFJ2OXkYoIJBkaLqjQos/4XHzimJvpKpklhoJn2M
	gXmIqhrK0=
X-Received: by 2002:a17:90b:4cc4:b0:398:bada:838b with SMTP id
 98e67ed59e1d1-39aee277bc5mr13413383a91.6.1788448995137; Thu, 03 Sep 2026
 08:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090302-mumbo-scorebook-4564@gregkh> <20260903133614.760808-1-sashal@kernel.org>
 <20260903133614.760808-3-sashal@kernel.org>
In-Reply-To: <20260903133614.760808-3-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 17:23:02 +0200
X-Gm-Features: AcwNN1WM-yL1zs0HuXFcqOhRac35eYFlCeBIB_8rS1B5RhhTXIamUTqhJccVfiI
Message-ID: <CANiq72nkw9N1gMTNxi7HhSqLk7_knbLx414WihO6idWWnvrHTg@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 3/3] rust: rust_is_available: warn for `bindgen` <
 0.72.1 && libclang >= 22
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Burak Emir <burak.emir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:36=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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
