Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342682;
	b=bOT5cawNEo3vDEN9OaR4nii1d7J+R3JCBmsnd2gPrWHbE1nG6WjWe6cp1tKh+l61z+E7
	 oV0Qy48muXvm9niDLj+tY0ioGiqJnaDdwtTrzQoYPSrRM58BzXcTHuV+8Ygw8svZhXQmo
	 HF0q5bCFns9tFKAw3lWSW1VQcx/kZCt5O/DkueXzWQaMJMXVFZQt8yod9XwxcwYLI5C+Z
	 qkYhXeDCBWvWZXBbZBsqAmaQQtGw3oFFN846lWTa6jaGp75VBuse7cA34kHLj34WDFhzs
	 dQR//h/2qB5fghNhttu3X/M5VbUE/9L46HmVzbHiREf0iu8sT8uq+vJz2Dc07y6hc0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=euMDcLXwVyFRBye3EMDIFi0Mnp2snBdaowuxW7mbjUU=;
	b=y0cUiR6QOY2gbD/tlO7ZdA8V4FIuSt1zaEzyMqivft8sKRr29za1A32WUtbuYE8pZA5N
	 beGZTwtlqkinpB1iHmNdQkg2tD2811ebMb9DUsZk7GjZyDyas7o7KPI0jD8ehFbiblQZg
	 BlvpS7OUnQpEdQ6sNBHIgWMJUQByRupyGu+UHArcJl4QSmB88U3fytwlS7+qG/42h6aAb
	 eSt3HnzZZA+0IQtsJVEE4Z7ADl63G0K1RD1K0hvoB+ms6PqphbgK4Kv8pcOTOutGT3yl4
	 CCzBY75jphxO7Cd6YboikPPIqdBnP4nvmwXhkjibC3+PxkA/Li0MwiRqbJ9sDPdm07A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k2tE9abR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED6606C8E6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0ED6606C8E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k2tE9abR
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd5f2834b19so172981a12.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794342681; cv=none;
        d=google.com; s=arc-20260327;
        b=b4yExulGQeDUEuUi6Kc4V7BkmTJi1mIuvChxIPdEi4Bhd88MEyo4mDfVEhsZb0518B
         8xuXWEqYtRs/VVzK1Duuru2i0Rx/Mmoh7MUo+LBoFXjJICWQRJXdkyoQJpsqIRkEXC85
         pwqxZaJTfmnL8ElIqfaX0RJ9h6t/OyNgSfQA8cSPngttSoV/sEzJ5okNjt/P73JEgDuw
         8hbcSEP9Vu0YSPWxgWTickJBimvsFrL38D+2JWpD2AIYGWTHYKC+bgeZjThmqi3TOjGK
         QsCOMalJL9NW5dzQj+SPhRT/2aHU7JmDOe+MmlZbeyPQr/PgAcrBVewVi1EyLKboc3wa
         L8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=euMDcLXwVyFRBye3EMDIFi0Mnp2snBdaowuxW7mbjUU=;
        fh=CaKVNeKvc6kQPGyPJUpQ5zWho7k8hR1T38Rf4GOhlRg=;
        b=FPokWg6ntSjZ8iKDSbarW8FW+pkIsHFWMXArWTQzb7sCbjKbA4cKbOKR2Uvn+9vL8R
         eogD2Jr+dVrPtiTENJqkM4z41qnanQxDsfo91GQ/8itQNVWIG8Kml/KWKpvIi4UEsslg
         Ew5r2CNQAahYViEwEtRv+nL/ARPhRZupX7h/MCujpLM0qzq+dnhihoq9WyYaiVA5TQtr
         hOejUncGLLzydB4ZrmpZloYavuH3Bw04co1mFcHaEcgMAlvKnrw9DTR5Pjc8IxbNi7fS
         vpmmtOBRQS1eBezGimUPdqsBK4Qrjwf3BFXKk2p4ES+z5gfpyFf210xNgKWyNArfu5Dp
         4hxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342681; x=1794947481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=euMDcLXwVyFRBye3EMDIFi0Mnp2snBdaowuxW7mbjUU=;
        b=k2tE9abRBySKHePpNw1+hoNwrpCgT9c1iMM92CBR/SFMFu9jyXbH2iCcyH+EmTQTiC
         yBLJMfHXGvpr8xfRPVxQgfnzsDthjwfax2/Tnn6lH65+pgpZ0HNuhexFozmuzYNDgx1y
         +ICdy5xZl5sBC6bwvrkn36HKWD07+HHxiPTqxB/C1Omj/my+bOWwBptkbM1GsQUlAwPd
         k5iKPtFQZWvnr7YHFJcpDSPfMwZhKuL+MTgC+TsDNhb2aGfrhumIhozOSJlps1NyLDFl
         5aulmNUtJ6KcGlw54fstXxrfYoWNLogwNTb77YvSuFf2tr3hJNYtNL4UfLVJ9xRwvNJ4
         xX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342681; x=1794947481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euMDcLXwVyFRBye3EMDIFi0Mnp2snBdaowuxW7mbjUU=;
        b=o8bVUt0SlrUs1f1pUOjTlceKJgR0206kZSgMWrN4A72DMerJHmNwz3WUAIaOXqUioN
         kU2Ix/ddwq0eZoV/GRZuTpBTYsfYRLuInSM2HnM252AOUlHe5T/B2mD0zYycCNbUbsgZ
         9j4TyN6CmuYjHojXfDS3PY2YMxEImAVVMR9GjeUDbNuVaYGBN8p9DpmUBNOsgQ4jMMYu
         AAzrooFdjJtLiDU5lOac7GbET0C5V+SdFLGvSxBf6C9c2zOG2lMwayJfFlGJeaK/BAe0
         CbBlQ6vmcIT9ohH7vZziFA09GDGYCVKZVMyGJCoAdCeiyFQghlre/Dqktu+qYdvcJosq
         BWkQ==
X-Forwarded-Encrypted: i=1; AL+hErEEY13qsfSKwwShd7s2EToZEjih2pEOCobpoDDWa2mWhuKOs4hgSZ/Dyyn1MYYLr9b0FTXtDO0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zobMu8RRQXVblilmH4ApKC2JYiKT3kFt75DYFzrE8E0SzMPeP
	IZ9QYrQAXfLxqdI/9xDKMsm8I9QhijtUQR11lkm7nbslQqO1+PDZ57N37Rt/KQ66NsEwPzaa4V8
	ZZMiNKbipxhifouSUYcWdRk4bEDiJre0=
X-Gm-Gg: AYBFou08hxyEjD8QWNB+xm6X63CAoOpGSxW9GE+4vqz7Ulb9Y+AQha8zZgNIRzZLAHw
	B/+dXMtnPCrz9OSHUGEU47tYiBRZgKL+AKmv0/8zZc1Iuaht0ZdYh2xPM6Cp1K0SWLsgzbrLSfi
	0P6ywoqZcJvgbHB6mhZWHqdoxFsccH4YNKl7DzkLqnSCim4biRfrUjVVi2mffgC2QJGEIM2pEJd
	LQRru05f0EpmF/74GWn5lmUhPwVb5KGc01nrGkc4cVEBXzogWd+qYjJf99YotO0IP/N/8D5MT2p
	DkGj0ht2RTddp5tIafQS+c4aliabW2OiZ4g7fWHQyH5VuPf7f+WTcCKeogn3Hzi8debNEt6aRiy
	gBsaHUmFO0img9OvFzGaE9ks2Zx0Rqq12Z6eIYSlMel2mYz6Kg/KLYmm57aTFiZe6hmRbpJ8LyT
	x5BDL+dIktEGa4BRuRnXa4201q9tlpvR/UUfOctNItY+VdL3pOb5yOWZt7XaVQAp35TaGENcnOn
	t6/tI26adGnbDywmt1jWnJ7j9rFp7619FgA5FQoUGWTOp4PuE0LheiZBw==
X-Received: by 2002:a17:90b:4b0e:b0:3ab:be66:ddc5 with SMTP id
 98e67ed59e1d1-3b182f3642cmr189775a91.6.1794342681275; Tue, 10 Nov 2026
 12:31:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018175457.87803-1-ojeda@kernel.org>
In-Reply-To: <20261018175457.87803-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Nov 2026 21:31:08 +0100
X-Gm-Features: AclHuK_uckGpnRQludUiuJa2Hr3E-2Svi5DrMdfVjm-Nu4czLx7g97kWJ04gZ0I
Message-ID: <CANiq72npfiOC2ZCan-zAe-h79kba_5jtWFAeAoigCs_hnO8gJA@mail.gmail.com>
Subject: Re: [PATCH] x86/rust: use `-Zindirect-branch-cs-prefix` for RETPOLINE builds
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 7:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The C compiler is asked to add a `cs` prefix to the `call` and `jmp`
> instructions that go through the indirect thunks for the `r8`-`r15`
> registers, which makes them 6 bytes long instead of 5. That gives
> `patch_retpoline()` enough room to inline them, e.g. as `lfence; call
> *%r11` for `spectre_v2=3Dretpoline,lfence`.
>
> However, Rust code does not get the prefix, e.g. for a
> `CONFIG_MITIGATION_RETPOLINE=3Dy` build:

Any comments on this?

If it helps, then I am happy to take it via one of the Rust trees with
an Acked-by from x86.

Thanks!

Cheers,
Miguel
