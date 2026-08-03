Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710C332628
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739710; cv=pass; b=Ujens5fde+1BSrsEQ9jrm4/NWR65ThH50UJ6OhMXjJPy/tOgYd0ccNtjntH8Ym20JKkyEyiRknocO8iSFNC9GpxftWJkZWvnk/Bn87Bnbz0bV3bY2EL4924E0W3rfSBNjTgltIo48QaxJ3txWg9rZ6YKvYx7lBAD0IUlo/RpCh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739710; c=relaxed/simple;
	bh=ggw+muFFAaFfC2b4AAgdDK63S2vV+ASj+i8ZzmEkKRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3opBq6I+jk7F6XvCwlytlarENkFNlUlr4jtviztT3g88MFZyEiIf17Hvtmx4Jd9iKKPBIGjwmQow3dBCLWa/ykcmCQdoB21XiBIjS+aGhQ1CoyV3w/K7f+2S7cZta39UztY0L/DEHeTeZp5l0qxOp0Woacs9LulT3kS+eX3G0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTc+ANJY; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTc+ANJY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84eb072307dso205605b3a.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 23:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785739706; cv=none;
        d=google.com; s=arc-20260327;
        b=HhAAlMB1soKs2JP66JzGwWsjE16rrwDrb48zNRSRtq8QXKdZtjjZFooDCcHn8pXvln
         uhq+jeiNNU9BH+TxlLXOZxcc5p7+5OsQqORU0zu11LyNVfjz8KZ3AQvnXW9CCQxeVBFw
         hYBnroH7MiBOlwv2x489eNWmXgdR6SlbSQaWsVa9Il0dhSo/i+NjVIPvRm4jdKALXkoc
         sB9e034kTn7tCAJLPi7ky9DeQP77dhXivsXfLguOJI5XT2oU2t6qYrNXV1mZK5FypX1m
         qxGwN0KM2wqdUOiAva29PGhRsWgg8GJXipOy4KdzWEtD1zadAa3MMo1YgXWhZJKZ72yW
         oCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gcuQshpEc3oEbrwYaDSyL2PkFa3C8K+8uk8C2LXbIHE=;
        fh=S/x273nHAKenGjl0PdBjYh2jrb+Nikc9WziKaAbZq2M=;
        b=n0RLNwZYEikLCStVfJVbYQqUxQdvvdDlv6zVcl5STtD9OxRaKfXyJG95FU6g9/R7mH
         1Lb5ytugbOVmY4vAssxMHaF1FmrsJgWhxcFEgsncDM8iXoMYCRmbmp7t8+6Ss7C1Srcw
         3Za/0HLFjS3mYrekfVpchRJ6jn4wbjK5whXNsGR53ozvO6kclmm77pOZmYeSA2aJF6cD
         sUC0zJtnpG81FpTEvxzBI0xyideTrM+N59yVYH4/Lid3Axh4dDYiePj5Ezldqp/WCQY1
         UevQdrqmaWgHk4Y3LpM2R/hmnwI9pM7/ZrpMRczRTo0tQnBg9LQS0n+BU77abD7U6iWI
         Uk+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785739706; x=1786344506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gcuQshpEc3oEbrwYaDSyL2PkFa3C8K+8uk8C2LXbIHE=;
        b=iTc+ANJY0T37GaKSYt5vwmRVrEs0rBBhRr4a8v+VN18cZvEzav/HOtStmDGs4Fh41/
         +VEwtAcHJAsvRqQk07nqKsIxoo3QE2OnvPFKJ0LeVHMY2Is3cG3FV+u9xH7lqm5QWzAe
         IAUp03MS0MLO+cH9IjTrhrn88X6nkR9dhsO51PFnE84YnXgZBhHADESKdg02erDTFs1Z
         8AXnD7dNa72zIyCmod8zEx2uSb6gF8losEM3Rr5FgR1yKyxmCXX1e8M+jdNtVeGBZ2SX
         tcGJZNEfrr6kRtNT1i6+bL6gJHwFq92hOcy2D6Q1yN/we+tf4Mf3T5rr8MuuYtSAmtg9
         JPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785739706; x=1786344506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcuQshpEc3oEbrwYaDSyL2PkFa3C8K+8uk8C2LXbIHE=;
        b=YPkn4fUepXHhDOO8zeGRSh8yZj4ZlIaVQJQ9xVcwvbVscfJIlxVkWaBGQeMDA9DSp9
         CzIWQgyetNvahHa8UqEDY3GwJoDHyb01ONm5ydnQUIcmErSIf9PXeUTlQEK7ozX9s4f9
         2rNaiHRCLp0pNA21CvbMRl4nf0rCyESDhB1VFFdgEgjwP9URUDYN3k7hcYFS5g2gFsmh
         z6yHy4k94RBEfMY8hgGZ3iKvOMMVm7B54HNO67vlii/fEdORLC2TG7izfpee45UsVvwU
         /v3tpOCuokeB+bitV8FHVykfieg5/KigREAO8J5TryKjUMSYwxfj3FIIHYhFvz0atMaq
         eCPg==
X-Forwarded-Encrypted: i=1; AHgh+RpfaAobrHyLOJtZA6Ta3dlv5kVRrok+LFfOrKLFl7yOhtrbSxcucODxtv2AOc5OFEe/JEgxXAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSatR7+a+TdSSzSZfpDObIry3BhWFNbrA0TrdVDxs8s/eAOBvj
	0Wigw7Vdd7QPU/f3iAbGILLIzcwMsIykBfayBSc/jI6kVxdzDRExxdxsrpdt+y0QWBf1pog3jQu
	9eXKyhbYmrjhNF05UqCXWfrPvs6guby8=
X-Gm-Gg: AR+sD10qC+1CJh5qtp09QBml1pe8i5tbNVMBZ+Pgw8Ze2WMDtbcgIACaVhwNVxbSIKm
	gDzai6UfuQdRc0QaYTv5iHLMmlgbYqOec2RCSqpnRNI5WJ+1Dyh2keFQiRT2TpKHO7fMIUF0roL
	SUtYWLx+IaBq3a6tDZHrGUj2q19VMd+MxX9mECS/l/xsMA7P8WQqWfBZf//S1Xziva32BY7ocAr
	prFcwdeNJiBH7gHuWqUpc66zgDcsDk11QZjqPqjXgxLXo/6OqsEortHDnsAo9A2uMPZc+a/JW3S
	S70gAwX5JVyF0n10UCzmcMk/jcY5YyXQQ+Z3tjGnUojD8U1KLNbqUvtFDlFyO3GC9PsD6OjI22e
	ILPMJ+nbUGkQzuYBh4JcFZSlmYAwKwfLP1AOwDcxUXv6wmp/P2fnmmxYQFS2p
X-Received: by 2002:a17:902:f78b:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d05206277emr118828115ad.0.1785739706173; Sun, 02 Aug 2026
 23:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729173803.13459-1-ojeda@kernel.org>
In-Reply-To: <20260729173803.13459-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Aug 2026 08:48:13 +0200
X-Gm-Features: AUfX_mwuzwdP6nxeRWpgmu6tvIOqTJdDLP6cx79YtVLMLU9QsM8nZQfv9wD7MiU
Message-ID: <CANiq72mH9EkHr-0XNqbX1NpQLu+UTO00tieYrG_oXiNTuqaihA@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: disambiguate `zerocopy` for `rusttest`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Antoni Boucher <bouanto@zoho.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 7:38=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> From: Antoni Boucher <bouanto@zoho.com>
>
> Starting with Rust 1.76.0, `zerocopy` was added as an (indirect)
> compiler dependency [1]. In turn, this meant that the `rustc-dev`
> component started including a precompiled `zerocopy` crate in the sysroot=
.
>
> This makes `rusttest` fail because the compiler finds several candidates:
>
>     error[E0464]: multiple candidates for `rmeta` dependency `zerocopy` f=
ound
>       --> rust/kernel/prelude.rs:64:9
>        |
>     64 | pub use zerocopy::{
>        |         ^^^^^^^^
>        |
>        =3D note: candidate #1: .../lib/rustlib/x86_64-unknown-linux-gnu/l=
ib/libzerocopy-dfef4cb07ca752aa.rmeta
>        =3D note: candidate #2: ./rust/test/libzerocopy.rlib
>
> We cannot use `--sysroot=3D/dev/null` for these, thus point to the depend=
ency
> explicitly.
>
> Assisted-by: LLM
> Not-yet-Signed-off-by: Antoni Boucher <bouanto@zoho.com>
> Link: https://github.com/rust-lang/rust/pull/118546 [1]
> Cc: stable@vger.kernel.org
> Fixes: 567621523ab7 ("rust: zerocopy: enable support in kbuild")
> [ Investigated when it started happening, reworded to add that and to
>   follow our usual style and sent on behalf of Antoni, who found this
>   during his work to support Rust for Linux with the GCC backend, i.e.
>   with `rustc_codegen_gcc`. - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks!

I changed the Assisted-by tag with the details that Antoni gave me.

Cheers,
Miguel
