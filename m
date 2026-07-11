Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187323C3443
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770704; cv=pass; b=jLq0comfm8SiQt6XQdIRTY10Z3JJI5HbzfUrGgjRyC1Zgm4SdJ9+dFvh281Otd3HrHrBjHJg0NN3Vca+ZHzQUeUH0GyAUtilBakTSgTBk6PK9d//ycjYcFtTljvhCATnpuSdIltJK4sSgufoZWPSkW247BUtuAEcMO59wmpSfd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770704; c=relaxed/simple;
	bh=32RtRzJ7crDmrcnf8nK4Ny6k5rIl6i+EKv0kmdGD3Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrn2ID7X/5/vUwTS61Ni9uYKG//QkiegGEcr5bWyr+pX+MoXAxNrKO5iOQkQFEn6f8Obb0hF6IEwvIJdez6UTc/ks3iF/XQw99277KaQcNLV63nf3cApyDDTPfhQC2lLfwFscHrQnnXapo5JYAiEIYHRKYquHO70K2XkE2Gk7wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt8VCoY; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt8VCoY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cad85b7b5aso1760665ad.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 04:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783770695; cv=none;
        d=google.com; s=arc-20260327;
        b=mZerM8hnAWiuOSvLWREfyJislvwH4riGuVqOnGU4ZtbToIi/lFg/4Hkqb5mAy3TYJU
         E1B33md9CtQkoUUWd0FRWTi2PN4YsM9qGw5NGILNoArbnEGTC6NRZoqapjaW0xDDPl1I
         nufzRyBI2l+KtptYHm0rFpS4lep7QepMn3qJOD5884uD0g/o72Z5mdE1h03px8rFNKff
         bOHyV1+1ZehQDzwgjlV/7Qs+XIUhGbQ7r5oGUzS1AWSpQJOLDb2kCslDN42luXrUF4px
         p9oFEl8ZLJ9bP7UrIBoCvPQAJQJ4sP7swyt8W3q76l4xq+N3y6m3Qgx1w60aaHzUKL1+
         XaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+UMGE819wkdK2DVLaPYqRBNsu1W7eq8gbWnBfh/WA5A=;
        fh=NVjgPsVbZDntEU46CaoAT7QqFpGYgB79RA+kw2vHe+o=;
        b=qCCNvFV3+PCwPYn5Hj9BUi41Je+tF9gOYVGZ/SBYGcwyJa2/kPjLQwqYD/FKyGcRDe
         gSnT4ofGY1VQ2LTcJNPYLm6Xb0PPNmw4V5sh8s9iTP+ZDmjzdEysKe797ce5LZm8uMNP
         W5FpD8IwwCG3YBCU3tcrSGf36hYw7+/3MhvTPnBQ0mcWwWj31wqqEvQu0yogKd03OMYv
         ow9Os9O9oGcR6w2pOhhwALVTNzMA3nXzHOE+JCZOvzMFT9lOTpp3PUCWkqYjhwVG47J8
         BRTgKY8yze/TO10/5JjE+Qqh46KDLURpzM95xpwsYeeHH8vIX1WKy71EqWT2ZhJy27r9
         QoxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783770695; x=1784375495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+UMGE819wkdK2DVLaPYqRBNsu1W7eq8gbWnBfh/WA5A=;
        b=YFt8VCoY66Mo5Vua5AKiHUBhXhy157WmYWTk4MpHA64g8/XgsINCiD2lS0j1cGFUl4
         EJWH73p5xs67rnvNQAg+BVx3jKbn6H7GE2rQc64USKYQP0Nll0z+dWCwv0DgC4Az6HSV
         LD3aEDNY4GiO6azuozWqBAUrRCxG5RJxyFsVSGLlP7F47UIU0/eBJ47Qo+AW0pWdjJ9y
         zpXM+TetBcQ9IFCCjyCt7DzRO7ITq3EaAkswYeUOAHlF+VvxJ78IDImQOp0durjb5Hip
         vTYJP872Ej2VrkHdyvei+un4ZMg0QBI2FW3pPqa0omss473f8rFIRU1Mtppg+t4iLqUj
         G6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770695; x=1784375495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+UMGE819wkdK2DVLaPYqRBNsu1W7eq8gbWnBfh/WA5A=;
        b=T4Lwre2IGBfK2mJoOYFqKhjExnvkWMhuQ8wnVvP7xAgJDCcxmBfGbixYSqNgw/hT6A
         KPjQai66NrT4Q81yqb8Ye1dpMAOS5kAA4FoM630SEfQQoulefgVirsRKwPVliN7veSwD
         W8gImdrt1Vbke92UlxUpnRAdEek0NOm9gOr2oidmTRyR8sKsclhGZ7FojiLUT3KsCXnN
         2tIdEjlujqgfOTDSAIeEXmiPJN51ieZWO909KZtkdDamVtdGyFzhRgxR6781aX6oTTVc
         zRW1w6D1T+tIlXDaNAQy7RHbfdy4FYe8FYHti2dB0/YiCK6JoRLxv1+O6MiZAl09aCTc
         3NMA==
X-Forwarded-Encrypted: i=1; AHgh+RrEzpNVNyPeMLgKb3MeOC4Si3GkZLeBvcCpJAalHqqmEoZ85hxJORh8mNuO9AotpNpXzU8/SHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRI0sxGzOYKjckyDb7bB6i81SH24gqA/TDTVDuWX/SH6dIUTm
	yzkO7bYHSopt5RWfzQAijsCq+98qwBtoDM+GvLsdOeNs7xus4Df9B9Jl21sqrQ8hJmc+WPhvWwi
	oHMxZ34o2MEzfJM3UVNIX4yTIJIDowms=
X-Gm-Gg: AfdE7cldCso1XGv02onEtrtTf0so2eve+l9vfGxMYe1Y7t6alUL23JEK3aVbG2McuQG
	dvv3oJEUuJCTE7EyR+AcdvpbireTf/ctaVaGLBivexk9tAWyjzYPYO89u0YxbjdvalfMmyvvBrj
	eqS62mJZGZymdoK83h/oI4aJ1xH6CYGNb6PlCxAeDdgXP1e7GRK9zBvG6QPkpVO7gaJ+TMrKkgX
	nQrsSz+KBYpeyPX1/nGaDFD2Dc7Barl7pXyFDNbkd8m6aQ1dwBSc0UynjjP80VZJegBsJ+sbkr4
	pXQwDfaplAfGitJIPe3BeoKqhvg/x+cu/RjVL46RZVgSCrOkTNUrrgT3eGUPp7ugFXuBCNGhI2i
	jwLx+kB1iUEIAXdYFdeGpR7A=
X-Received: by 2002:a17:90b:2e0b:b0:38d:90c1:2400 with SMTP id
 98e67ed59e1d1-38dc74c8082mr2087131a91.2.1783770695310; Sat, 11 Jul 2026
 04:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710173252.191781-1-ojeda@kernel.org>
In-Reply-To: <20260710173252.191781-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 13:51:22 +0200
X-Gm-Features: AUfX_mwoKjXTHcjSODaSdur4011uhKST8J0DfGvxttGWqmvWIQB4Nfm07D_RmM4
Message-ID: <CANiq72keASONEFeLQivMaSnpio3zVgSGCAsTcxjevizdBcZ+Mg@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function for
 Rust 1.99.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:33=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.99.0 (expected 2026-10-01), under
> `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy`, `objtool` may report:
>
>     rust/kernel.o: warning: objtool: _R..._6kernel12module_param9set_para=
maEB4_()
>     falls through to next function _R..._6kernel12module_param9set_paramh=
EB4_()
>
> (and many others) due to calls to the `noreturn` symbol [1]:
>
>     core::panicking::panic_null_reference_constructed
>
> Thus add the mangled one to the list so that `objtool` knows it is
> actually `noreturn`.
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Link: https://github.com/rust-lang/rust/pull/158796 [1]
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/alEBInX9gD1M5NAr@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

I changed a Link: to Closes:

Tags still welcome for a day or so.

Cheers,
Miguel
