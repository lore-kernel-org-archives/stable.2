Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794897477;
	b=aSsQXKFMzHS3dmBvtb03frpTdKnZd5+qzjwgLkdzD+j37hRBCZAfW1eejtXeryjHbFdf
	 vQNjzzeRLDHM6Z97zHivliJXvFrrEtEZntMv9wRIeJnMjViVySiOk0jLzf/0u8W+alabU
	 KQrH09UHUjPPW3oYBcujxijAdRuxZBl3+Xg1Z9CMCC9SXD0gOjtxpHs5QSVNcpFPokU7P
	 tLdl0vUPROYZxZVNeUHgL+tJmw1rzrUq1+UbcQ6rJXtbpig28Rrof5jnDlKVdXK/SxHaZ
	 VDLdX3yG2qrgOBzkDOcJpqWOXwUvh3p5w/kf4rqUawKYScF+kVDNRpOsZpjMe4LMUhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8/vn2gJipiD85BsJ1Ku8SNmRl9thwiwlJMFECHzYcD0=;
	b=ipgc3gcVVS8U0QzWUq07IXNzdOyUirehVDygJs30TdL+Oagj155KqthrpwoJKOImTvbW
	 mR1gbHuAcGqznP2NT8yxEkwqS/dn+S5/1l2TcnwFNtbLJtjFaywGrULtHa8kEO4hM0mg4
	 LbZuCPzRTRoo5SbUCiB5atz25ngx50CS76Vo3kYlVHjEUHxPYg8o1iPA5YaAEhvpWnDGM
	 78CbNMBW9Om+LTpsbjRNOdd8Pi+TLxXKlpmApfBl9ik7rDH+Kpxem641B1Z5kColsNKBd
	 prtLoO14z1QIwBniI/GMENbi/nHIeJtPAURUTICLdyGhCz7Z6GDnKblfsw4D3yKJBPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fZw3HLQ0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C85606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18C85606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fZw3HLQ0
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3adfb0c9e3cso6093081fa.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794897475; cv=none;
        d=google.com; s=arc-20260327;
        b=i8U18FLTz71tu5rl49chE2NydtEkBtCjOKlNLOa6P0rBmZWRlchPIG4WvqTy57E7Xb
         3l2ZuvVptVikVJsuUo60+8380MDNx2ZjPltkIYB3KaFKvT7zw/5TbjwTwXvVcClv/OfE
         fInOy5lqMGDlgUvLEGU3YjPTSwT52gHZysCmEcqEYgJmIhydzXo6/rfHs+6n5+Or7K2w
         Z3KTcRA+lzg3FTZiZlp0gNTghJE5V0eziDmf93iws+jF2/bOyMcJ/5eapstkU0QyTp56
         hBz4wqj339A12YvQFqS1pblmB8LKx19oTa1q3A5Hva9zPRKjr/Iz37IgFCNKReV7U/9W
         y2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8/vn2gJipiD85BsJ1Ku8SNmRl9thwiwlJMFECHzYcD0=;
        fh=HRAezeRaUIE9Qt9YSijW7P/fO2NXxYY5y3OxArA12Co=;
        b=XfJ0VuU3tJZa3zdtuVqloFnu+3UMrUIKC0HZt9L6LseVDgaikDurr9je72OeRVLo9Z
         XCCssnlVkpokh4Nrd4K/CuwZVfaciVQaIW5amMZ3XdPmcSL4E43PTiLGcMCzSSlh06TE
         rEagyASf/P2vt9oBub/E3ACRL4/EfC24SP0is1bb7b63R3ak5mb413WuXx3Jr3owYHkv
         9QX9c/2rmKI3tMjWlh00YmhyExwNs0yvkEZkTPShyLbCeOXY9KRP+xOOqsFUxWKI8nI7
         fZG+vYZGRKv/n1KL7IS6cLxoAxVtO6dEXmt0vUbZBdTyJ2PRoDMdZ8AT3yb1/FnC/zmB
         1bdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794897475; x=1795502275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8/vn2gJipiD85BsJ1Ku8SNmRl9thwiwlJMFECHzYcD0=;
        b=fZw3HLQ0nzuknu6xZZPoDZvl/L7k7TrZwsx5O6x0BB261gDfe1j2et0Foeg5z5mrdz
         pdov38qEG4e1cj1Xgv+BF7QG8EpS3uTPToJ/cPxM2P3pBo1pKt88mp1j6l8Lr9opRwrT
         UQol3T/ikaaqCg/kx4o+Pd7HKYdjzlhzq7ad2AaU1FYx4ATArJAAzvoJ61gTlvmuHGY0
         O6JvkVZ1OeI8Wuw/z/I9wPty9+oUFsd5ZIVwdZbnK2TVy5pfasGtQ3u+l7nglYvngY15
         oFQLd6ZP6sSDU4BH7A31BLLxMC5vw8UQ7K+BTZZJadCh3+IJ+RKhSEbeZVDIcTdJoU7H
         innQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794897475; x=1795502275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/vn2gJipiD85BsJ1Ku8SNmRl9thwiwlJMFECHzYcD0=;
        b=QvxZCrWOnZsHkqt54sxmCJ/fNxNyVng0JNnaNbqJVyC4gPAn61I2+eEETmYmz95voL
         341FUiXOhOk+j3G9IruvhPbFS6A8q1wjsehNEjsZz7EydqNUmGjA1VxQglR/pnAmb4xP
         y0S0ED5C5gCX04Q/cgarYBZEySAXOFSftVSB6anlPzd09TJMVZ/Nv86xa+GgdvztFxOF
         YO6niOOZTMMvqfcqTxf+Pw+gHEGakmAviVCDkHp9bwEbzVYaeIYPIIGxbLaZmnkYlK2m
         Bxs4CK5W3Pa+CeluAS5Od940EZQ/YoqpUp0ojeqPW/WR3g2zKKsdRI/gyyxytE9kvxF9
         gZAw==
X-Forwarded-Encrypted: i=1; AL+hErFuKhud++wMcSbkfx8853ctAfUa30CqQr7V6FAaIwFcVMFkfp/Axwf6kRNVQXYHwtrUDJaOYAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z98jgoT4gDJE9BTWGRsLrT04NshNUuq/BR9ZuV9ZIN70s1/vGxX
	KCl7LhuP05nVEXaqodFZ1GogRLOys6Yk0QJ/d9XFI/jvpiR08QfQYSc9QDDebpOs78qS7vSlUk9
	9uXSHHxUAHEZHEOdKykbLOohX4e1tUAM=
X-Gm-Gg: AYBFou2sfuoFk/oQJaa9XzCzZSpHnzciNxc/OoSl65z2PYUnXZZ0R4qqEqT/neek53g
	olYTfPvAIdwZ1df2OemSSuqVcIe46Kde3qEDrBE92IWaVhjwvpXLp3Djtiwu/1SFwSZptYqx6oA
	JikBGI8u5l1/WIy34r7kvyGCE0YjHvS5KWXFDQWTZXkqfTgGlzTQOnG8xGWNbNbSaDlRL37dmm2
	QhkTlQwfj0Jx9bZEZc5zo9DM//ykpVkaL6xVhaWsSHcj5EWIEo56PxAD9M1bZUg+SyU2vxI4oFQ
	xdggzogJk/WfKA7CrwTKIcxE5RP44E++UMl1cuQTCPOWOvz20Amz6NMYNzW7OyLCj/H3H2TjdQX
	XlN6FXf7rlznrHCovr7YWWWsXjV+L6M507a/IGNu7wb+5wBbnz/6A10P6xxjuuLeJICnAwOuwDF
	LI5RrC31TKgSucRTvCkUqUnJ7n+MjuFnjdK8+A34HjUiRh4ksbasBEZerrq6oOrBAOIx2yKfNOy
	rc+splTbWFRDlQ3zctCSPApBfhzXN6MOa5EnBsduf+tFp4XQ8RBuaqlJtbfpukkuMO6eqkkwA==
X-Received: by 2002:a05:6512:3e0d:b0:5bf:a66f:e5e with SMTP id
 2adb3069b0e04-5c17058b108mr5667796e87.0.1794897475024; Mon, 16 Nov 2026
 22:37:55 -0800 (PST)
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
Date: Tue, 17 Nov 2026 07:37:43 +0100
X-Gm-Features: Aa3M54p7eBlg9yL8nKjCRYF_cKn6fvAcKLXbakSS16n9mf6XS8H5ekFNr6S-Wr4
Message-ID: <CANiq72mrpgxyb4d9C5p1KS0n87GmYTXcyUX+dhZ39T2vRtOQwA@mail.gmail.com>
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
>
>     $ objdump -dr rust/kernel.o
>     ...
>       e2b: e8 00 00 00 00        call   e30 <...>
>                 e2c: R_X86_64_PLT32  __x86_indirect_thunk_r11-0x4
>
> Moreover, since commit 4a1e02b15ac1 ("x86,retpoline: Optimize
> patch_retpoline()"), `emit_indirect()` assumes there is enough room
> for the inlined sequence -- e.g. with `spectre_v2=3Dretpoline,lfence`,
> the kernel warns and dies while patching a site inside `core`:
>
>     WARNING: arch/x86/kernel/alternative.c:736 at apply_retpolines+0x2ee/=
0x400, CPU#0: swapper/0/0
>     ...
>     Call Trace:
>      <TASK>
>      ? _RNvMs6_NtNtCshS2CUL9MEDn_4core3fmt8buildersNtB5_9DebugList21finis=
h_non_exhaustive+0x5b/0xd0
>      ...
>      alternative_instructions+0x1d/0x60
>      arch_cpu_finalize_init+0x5a/0xb0
>      start_kernel+0x1f4/0x280
>
> Similarly, paranoid FineIBT rewrites each kCFI call site into a fixed
> 20-byte sequence, i.e. the 14 bytes of the kCFI check plus a 6-byte
> call. For a 5-byte call, that overwrites the first byte of the next
> instruction, corrupting Rust code:
>
>     SMP alternatives: Using paranoid FineIBT CFI
>     ...
>     Oops: double fault: 0000 [#1]
>     ...
>     RIP: 0010:_RNvNtCsdVypMZsLRAh_4core3fmt5write+0x1e9/0x210
>     Code: ... b8 68 81 16 9f 41 3b 43 f5 2e 4d 8d 5b f0 75 fd 41 ff e3 <c=
c> c0 eb 02 b0 01 ...
>     ...
>     Kernel panic - not syncing: Fatal exception in interrupt
>
> Non-paranoid FineIBT is not affected, since it only rewrites the kCFI
> check and leaves the call itself to `apply_retpolines()`.
>
> We added support for `-Zindirect-branch-cs-prefix` [1][2] in Rust 1.91.0
> [3]. Thus pass it for `RETPOLINE` builds when possible, which makes all
> sites indeed get the prefix:
>
>       e3c: 2e e8 00 00 00 00     cs call e42 <...>
>                 e3e: R_X86_64_PLT32  __x86_indirect_thunk_r11-0x4
>
> The kernel above boots fine with `spectre_v2=3Dretpoline,lfence`, inlinin=
g
> the Rust sites as well.
>
> For older Rust compilers, set the LLVM module flag instead, which
> has the same code-generation effect. This means that every Rust version
> that the kernel supports gets the prefix, that the kernel boots fine with
> `spectre_v2=3Dretpoline,lfence`, and that paranoid FineIBT no longer
> corrupts.
>
> In addition, add it to our target modifier workaround for `rustdoc`.
>
> Cc: stable@vger.kernel.org # 6.18.y+
> Link: https://github.com/rust-lang/rust/issues/116852 [1]
> Link: https://github.com/rust-lang/compiler-team/issues/899 [2]
> Link: https://github.com/rust-lang/rust/pull/140740 [3]
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel
