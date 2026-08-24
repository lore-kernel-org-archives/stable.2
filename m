Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00E38E119
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567973; cv=pass; b=gy6sujPhEBZ3aTBY1NbnD+5BsYVL+WLnxqrr2t6d7gybdjUAxPIBIPit2Z4hXRHLBiYhLkAXZip0LYd90dC57c+MAQzzHyt05Mry2+15G3EFFjwKTx+j+nM9Oc6pGP/mg29pA8+D/hKZIuf3IOgyIkfgUx6R+yc5vDpOjommifw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567973; c=relaxed/simple;
	bh=hgryzcWBh81J+fqav+2BlfgO1BmbWhuhmWVgVs11gQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ui3QUB8laRd2Wris7pgZlRKJsoJNWWfT1i7JGbyqpjFx1vEon7b7ssQMe8kCQUlsVHWgW05JARqj7CnDmJgtn/2P44lWyqA2/5oR78KPzJjmEilH3NDtZI+Qn7baWuGAj3R6IMDM+ccCCIwttBKJPh3E5VhNQhHOPNvvKvy0y0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmBc/UZ0; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmBc/UZ0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccae46de39so4436545ad.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787567972; cv=none;
        d=google.com; s=arc-20260327;
        b=cC23+ZRghm7kXaO1Kp1zGBECozqRGEXjW/YuhuOKNHpBNzk+Scp85J6V6v6d/e1xAQ
         Uzl5OVjbosHwNLvw/r+wavLPfChEfpUiiXDRgio3FmWeueffGo2zYSvAwcvpLb/8mLl1
         aMCeaHpDQHxI8K1meAKhN/DkB7GPbmHU8WfJ+Qdvnt9V+icY3Nd0+00d+8xPgxg9IxRC
         NhcjSuIesAHaPPd6t7ZjX94ZZDTR1JN0ttGgIYgoq99k86YOAFe/SCQR5c4oAsZF8cQh
         x47ZKbwXTm7oFJiofa5nR8D0Rif3oRWuCyI/6KeG8h9/etSlyaxe0Dem3q6/4MELAXT4
         5dJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dm+SxIlEY/yR4zyZCKc0UXwl4nlxVLA5fi42KRK5dYw=;
        fh=HS9HB9sR3mX6bMHmJcIWDxrpmOddtzP8aGDml5JoEPo=;
        b=BkJyv27xTEQzrT45d0Lj0DnaC0CXHOOSpgVUE1dImaIFkcHT+oCgg6BExddNLE2l6Z
         pOQT+4pPeFIdgp5lqwlYe5agCp9Vi6YjNZdk1oQ1Q7p7T7gVQzE9SnTnGhVO7dGB9Mek
         0Ny8ySJCyFKycJfLNW0ayDuv9KHMndbFjkDKmfOmMao2srPGiHBIXQVUMU9prfnqPqO4
         k4OQ904EtUYuYXouDD+2hOEmvMtWhNb41ebU/KmFaUbWXxbMPoyJLc8jQn/LwfbEU83k
         ZCajEwNZzYOfES7fGOxp8CS7DqWB8fPk8A5XGzav+IPw4k+5xJ8SeTg6GetGapplGdOH
         bU4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787567972; x=1788172772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dm+SxIlEY/yR4zyZCKc0UXwl4nlxVLA5fi42KRK5dYw=;
        b=BmBc/UZ01fjCpGXrD5VaGU5g6PyvEsT+EoLVXxUJHydR8l0vT+LAtRR+8zhQgZtuw0
         I397lelTLyOYJpxfO3te6aVPtPY6wiZKPak4/zwmuDQLt1M3L7XW9sXtDhLrOm24GZkD
         hWxohSbC1GqPfocKIrpouJP21ss6AIsJUGMhAruWaqdnZK9oNWF9fvK4LjFR8+RtXaVc
         KIxlKgWDPs2aoCTYXEDIMFFXT99hFpPo8bwrRFNJ5wpfbewTh5iLIitzA0Dkz57FA2sY
         BX1auQ11LfyNa5WZsA646pIcZ8EV/EcZHy7ijYByeTADvrssIJtWZkKwp6F/d+HoG8Gr
         RQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787567972; x=1788172772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dm+SxIlEY/yR4zyZCKc0UXwl4nlxVLA5fi42KRK5dYw=;
        b=lJbh1R07lIke5VFN6dl9KpdHAVfOdbTFEVHho3f4pRcHwVk2tPwvmxJESOc/AAsBEY
         ucPONkEf8v4m2/G2Q8a2ZEl/nDtpp+6PaaWQ1joXvTKrRlAPeAvnc0fCYTjkNvXmEHFx
         IngFtyWgUugEVXQqU6rk+4hAHQu8rTe935Q1a+6hZd4IazKXepJdl/5C9xFsx1kPxnGo
         72kkbEHFDVyC52ezcsJy1i8SB9fKv3JnBKnmj8rpdaRlvXNXwFBsJYacTa1j5DEWedB5
         z8ncfeNbId12BXpFAUCCkVRZRUkOMs66DgRi61aWplgYAh6HM2SW4VoeuNEl9WqI/enL
         eP5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrJz3JJhVd9K383PMJ0szF/0eHX21j2L3/ZZ/Z3ROtBOtGYXmA8ioPRk7hqsWkCQjXs21u8QOU=@vger.kernel.org
X-Gm-Message-State: AFuF++mCVZENFK8mh6dnUs23IIH00/P9sH/jo5nj+ThuCgMsC99mmDgM
	4JhF5LKiQMSLIit785y+0wYQjdPe7tL7bOaNGkK7TDDq6M0cBrWSNnSAGrZI8Bs4R4NcEpdRXHR
	HqdsWSekELz9R+9QQ1MPiGDUApFu5NZ8=
X-Gm-Gg: AR+sD10v0aq7KNc65GcSBSvZUwRQ4GdCQeu0kIYvVfHiLqfK7R7+R9LQe7j8rPmDbBm
	SRen2imrhVY2n3Ri2F3wifnJmlxN4IiwxtApTmzLfWiEFUXyqRRn+WGBEGkowCHWk4NGTH7QMTX
	cHfXACbqpYB+37S+6KI7UhclNuvpJlicIEbxIROF1dLM/q27YR6SRyqgRYuQhB73iIGnUmdn9yx
	bzBWvBqa5A5+Y68IeCZg8onCElK2SbpXGYypHOMG3SG+9w0h6W6WrI+CdeyEZWK2T/qqbmzIlRu
	HBDOJfcM+DYSr1ATcRFPw9nvz3rZInMywWXkdFdhzqr5I2zhED5i9iM8C1uQ2fNLyxjye3yeatf
	sZB7kZv5hJMk1Au89s42pOkLyMs7rNnbTqpprYqInSEYX20YfZrkjBWSn3eVM
X-Received: by 2002:a17:902:e544:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d64a9ae35dmr206138235ad.0.1787567971710; Mon, 24 Aug 2026
 03:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816133233.197500-1-ojeda@kernel.org>
In-Reply-To: <20260816133233.197500-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 12:39:16 +0200
X-Gm-Features: AcwNN1XqG3kZZP3a32PBSrKWeajLatO9hp7-Kfpxa1ILeXqg5p650B05C8OP7O8
Message-ID: <CANiq72k2A4UCLakuKZ3V=N-FHONk26npA55J+gkFT197XAOMfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: preserve unreachable traps with inline helpers
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Matthew Maurer <mmaurer@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kbuild@vger.kernel.org, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 3:33=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> When `CONFIG_RUST_INLINE_HELPERS` is enabled, it is possible to hit
> `objtool` warnings like:
>
>     vmlinux.o: warning: objtool: _R..._4cmdq12CommandToGsp4init()
>     falls through to next function _R..._4core5array4iter8IntoIterRShKj3_=
EEEBa_()
>
> `rustc` normally emits traps for unreachable paths. However, under
> `CONFIG_RUST_INLINE_HELPERS=3Dy`, `rustc` emits LLVM bitcode and Clang
> performs final code generation after the helper bitcode is linked,
> but Clang does not trap unreachable IR by default.
>
> In turn, this means `objtool` follows compiler-generated impossible Rust
> `enum` paths through alignment padding into the next function, resulting
> in fallthrough warnings.
>
> Thus pass the LLVM `trap-unreachable` option to the final Clang invocatio=
n
> and suppress traps immediately after `noreturn` calls, which `objtool`
> already recognizes as dead ends. The combination of both flags makes it
> match `rustc`'s behavior.
>
> Rust 1.85.0 (the minimum supported one) supports LLVM >=3D 18, and both
> flags are available in LLVM 18.
>
> Assisted-by: LLM
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Matthew Maurer <mmaurer@google.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: stable@vger.kernel.org
> Fixes: 3a2486cc1da5 ("kbuild: rust: provide an option to inline C helpers=
 into Rust")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied series to `rust-fixes` -- thanks everyone!

Cheers,
Miguel
