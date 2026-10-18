Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78729D291
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346223; cv=pass; b=SK0FAfndrnrfdmW3TJ7Sxbg2THQ0hhaHq5qgTl19RyyPt77uJleOpL3AFg3kSt6Ri6sC+z5tbnVTEpCnsun5sNfKQ8y7JQNlObw88g6PybJGJsuCRvxGzhhFuNiXtwXHLbxzHOq/WIipDnW6SAR6mbqpAwnAnO4W+BYNvBezFz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346223; c=relaxed/simple;
	bh=ein2Kxm/7ddUQW+oHSZ4NEDEcr868l3pq4onBaj8gos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOzkEZw673R4nYBHXkS1DsKy8n7kt57NWAn9EqW94/uGtS4V8hkdCAXWQ4HyXwCnOSAk0Jgx6Kzh70GQ0gC8psZeeQCfPuzENOIoVDWbL3Vt0G9+IJoKGJu+livPeOb2luXBTcvnWwLkgqcTiZSxMvmRWKIrLe2wvWHdRugIyao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuKSafKM; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuKSafKM"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-360236b6c3cso112021eec.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 10:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792346221; cv=none;
        d=google.com; s=arc-20260327;
        b=mk0K9kzfqIr1SHRGpxOGDpW/4vwGlS3mnNr/F6255D+j197l15oSLuk/p8EVVtrSAU
         /ofaFS0frqVGHBDiZg6iyXc51PNTlHvgcD3r//YylgljgHRoJwqLqhy12H3dtIVaudBe
         A994/pzuRWN0UEmxlaDly8o5FVq6VcYGZNvNOs1o1P38FYV58Kk+UIoBpqjyAuZnBPyA
         GJKqvs5FlvfXaek4IuVW67cGskkbBq7HFOhaw7iZM4ydyvAZzOxVax55SxZADYoaCAsM
         tgPWldkjBYuFdLd6NFMueeCv2BPZTp1tZN3bL82pbilAmlj0Nr02IV4H+G+MBTAGpmyZ
         TVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKssVqS+1fUgzpvGYUPB7GmCd4wpzuePwRHvRr1rp2U=;
        fh=pstTTnOG9wWd3Ub9K8ZIeXuJW1l6OtT8sXeR8h84lak=;
        b=HQGLYLwWGift3PAz5gPayLwRpxe76uskhvV/Zx/XdFi/WF9e7WoZraD5Zp8PNLqRd0
         Q62UblMXsgkj7RXeoGN8sp4subKoulG6A+3vhNVKkDR6jzKPXORTyQmeeaMzVPKlZ/T0
         oVk6YQFCEOn6p2hz0g8rCxVnRuQ8gmCko6qnd9seCtzoG3HbCZ9Wx5uKDbsBxWMLQDCJ
         2X26vmproPIMXy9HLchwZKO/ZoGQwTkylj1EGv7PgnLznw9Tz99XDZ+H4rTWD2zLlraz
         E626JpaPlFBdxIgjSopy44vrP2+hK3+bpK/ZiHWXBYmJSCgGKdbb8OI/uVNFy+Uu0nay
         7Ybg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792346221; x=1792951021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKssVqS+1fUgzpvGYUPB7GmCd4wpzuePwRHvRr1rp2U=;
        b=VuKSafKMez6dANuC4OAkzaUUQ0QhKEUmnTCCRXY4qkh4XjBrgEaJSjU/L2iDnU4m5y
         DMldodLQGCaWyFU5wwiBqhm/xz04Q33b9tQQdfJ6yaShtJHWsB0wSfRWAe/8JQlxBktl
         9AhfCJAfXgNboCcf1hsPkAX4UKanipQNy+CfyO0V14l+njp3hSgnLAzXFWoFcUO+yFGe
         MVIgDXmRsr4ln7ilDaYNIoaVRZKFV1w5JMyCE4PGi7jUIRkJxqLlOoV5sGiedMZ2+/Hd
         7sOd2ty1ExwXoKZdUSAzWD1TZIIKDxx3jP124qr6ZK2Pw57KWCDBE4G5PbF7q6Gxblcs
         cDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792346221; x=1792951021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKssVqS+1fUgzpvGYUPB7GmCd4wpzuePwRHvRr1rp2U=;
        b=mE8OmeM/ef8IXc0R5oRLS6mYJMJVw2dWNpn1Z5J+c2sIvlZ+F6Y+b6cYgZSKhRt74i
         waIO/8sa/2ZQ0Dl78uLZzJ5zZzHSeQaOXmMJGlCLZYzKVIPuHQdCtclG3/nVHaXutfmd
         q/bfxy/mdwgKJrFBkqidEhBuXhzs2N5zR4uIa5f5ewGLzYA2vPZ2wD8hZGfe7/ixzdeV
         zDBLr0rw1IWCiPvbAJVkn8B44DAsiR6EMwVmZJ6K7ScvKblYareNYR+9OYhr13xeEbRM
         nEeLgnO9uoClZqNr21sHK/dHbSC5apWpaHuGOp37YxjzbGua3UBc2qc12FwolL9DMZuI
         FOkQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4VFcEh5ldFG3fS4NX+poC1+GumIjtzCpnY6AfZd3lZytzZT5psliyRrAp8kcEat6+i4Fqxgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIir2nYLPakIkrk8NbzmfcBv77tqL9mezasbRcwc9IJNCpJLUI+
	itTmYl9ePlZqjdPVkdEuAZRsTTExiFUYP8twGtzC2i9yxwN2jok5+qz1cuOmXF5uc/soaQtGK9Y
	Dt+Nzm4Kv0wq/1MuUOqSM4OP0NoikkiI=
X-Gm-Gg: AYBFou3b0YL7i0KnPe6IuxdYYLjvoslFFykQvHjdTLF+Yln0BVvk8D6CzHIwpcTWXwL
	l1HyQiYTd1jrSeqaGEyaqUtgRr89ElAvtX22E23kqSYoN8PmKmdwglMcQQ4sTy6m+jBv5wWDaSh
	PIqu7SUev0spB5wBO1nlJLPrgXbdp5g7ibA7gL6ENElf6GipVFNQWV++9Se8SwrregcKioR+ALo
	GZIyQKe/uPVmGbI+1TTTsuLTlUnnoGmPKusc4Q8HnJ9MTSqNkoSdAdS/87VCQQ4q+sOPSyR7+cP
	8/VI5i6qYBwoHlo13Ak+O6B9m7C+zdHX1NB9vSgoasBaquD+Zq8ETvXuF8iCK3/WG0RVkhykwdd
	Hl5/AWvSudIudoMyfNfzeQ12zxwCHTWI0J30wGbY6cm3sXT0HzsHwPmtZ7OBWzNVIDFzwnM+NSq
	Wld/b5RahQTGbnsn7e2nARPW2lbtGSZkKf84d81/leGX2fQiOB7Wn0fx7Ui5Vc+w==
X-Received: by 2002:a05:7301:da84:b0:358:7ed4:a049 with SMTP id
 5a478bee46e88-3619b212ef3mr13057373eec.0.1792346221395; Sun, 18 Oct 2026
 10:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018175457.87803-1-ojeda@kernel.org>
In-Reply-To: <20261018175457.87803-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Oct 2026 19:56:48 +0200
X-Gm-Features: AclHuK_3ymV6Lp1a_ivM4oJdQMCp7Ooe_ysoxuTMLzooZXb3XPtxZZvpcBg_tIc
Message-ID: <CANiq72=zv6uDRu+x=BpSLWsZnB2XCnPduQ1PXPPQNzxDgtm54w@mail.gmail.com>
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

Not sure if `Fixes:` tags may be wanted here, since this was simply a
matter of not having added the support after we got it into the
upstream compiler, but two candidates are:

  Fixes: 97e59672a9d2 ("x86/ibt: Add paranoid FineIBT mode")
  Fixes: 4a1e02b15ac1 ("x86,retpoline: Optimize patch_retpoline()")

I hope this helps.

Cheers,
Miguel
