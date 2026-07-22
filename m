Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A83382E1
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701412; cv=pass; b=Gg9s1U/G9RX/5HHZ7RksFixSC3j1mI4jAL2TzynzciHJWdrVnXhkt/vlzLt4CXt8IWTKI2eAHqtVhCwOAD3bx+F3+sAZQ7zyMfbjqveAM4c1T4qlQMep3aZ0Zprk4ccF/o5ZWAxrLm0R7C0omUTEBaOy+Ta3YkoPrdu3U/DRbz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701412; c=relaxed/simple;
	bh=Zi0TTWnVRjrxAgsXOkLUFjc66Q3O/SaTw7EJ09/k9t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/JgkwCyO3eytv44/v/3V7PljzlOqklhf2dBdUWE3RjPqhG0e+KHln5DYVUYGdIfm3qey0mC/WJTqwSokIEtr74hk9yj4HJYFNNkaNr/nXP0+Lz+7NX0x2NDCe+mWF7jVHuJ9kk/GMlT6fYjU8rHuor2b5tMkGvC8OiCPDgMljk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opLnJ9bP; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opLnJ9bP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f878135e0so68983f8f.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784701409; cv=none;
        d=google.com; s=arc-20260327;
        b=hQkbuBJZ1DKEORU8YpA5+vjCg2gT3eTKT2TTp4rBqsV2Qt/UY2B0OgLeoPainhmUTo
         1Lo2Xa4flL11PS0aPGHPFNZ93lnhrNsuQ0y+ZrVWYlJJY7TVsugJg2fROMJQ+vAoLzRX
         YD169QPE63JMdrs3SmhdA/076wKdNNJB725mG3WiT33gzKhxm/gLGMvvPGT12olPSq2A
         iMGKoRubJwRWWrOHd8jQoXHSm2UsCS8nhmQYdTfoGvHyvl2UqFH4c8kuXSto1YoFmFHT
         WX6ofe0ZMeBpfTeA03tMzq+tTXfK09fIrrzCvVohlhLRnhYMvfeBhDLmwQb6ugAXBsHL
         bfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DYM9uk4RjTWm27MB5EyNDXkYKmnCgxdummGBOSonWTA=;
        fh=DK/TXC/z/n5i+9IwmT8f5grLkL/Vt4VbItfb/GiLI/I=;
        b=igid7mtMfwywDMDG7TgFKPnUnvxlkKNvaLLv8UqHyDhQkXuySnePZr0J0jysL6MWTI
         4PbC5X8pDES7kaF3+4O+vKZRvnzBMsLnWWwBQatIe8jgRk/r2znLRpmmpx/ysw/RFhg5
         ibcJis0MBuP8NxxRi9L5rCrjA78io7RiMikRsNZ2MGzry5z3TG/4vIityJyrqNQWhizF
         EmGqt4vPuTNa/uZ422noe1bX6KJIYm3gcuj1bN/h5lpWo24y9lcD9+zkdT0cL0cp/KWb
         w90gk6M9ETZKzSeeJK2JcZEgEv8D0JNTeV9dAWgF8D/Mnn8n4fr7OtueAVqQoLCw2YHP
         uqNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784701409; x=1785306209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYM9uk4RjTWm27MB5EyNDXkYKmnCgxdummGBOSonWTA=;
        b=opLnJ9bPwt1V8SCf1WrchknM5TWdt4ZRDf2S9KOZJ4OO8IOKaDFM8NT5I6ox8DvXrp
         ngTLH2hAv7cnLmrO+uxpKNu/J8C08iT6F0XkVEra0BLfK937bnVXf7US1TDQPc70ny13
         lG7xuuHlmlAw7+DHeOom1pqg+g+cVlUpEC6GZlWpjpScXjP8wQbd8QOsq/c8g+Bq+kRf
         3kPQ8/V2zuJjpt/mtnfGa2aurtBvqWQUgH2LvvS0RopfKzHZoyEzHxQqeLG9kIk3xyCD
         GZHVOlSFhPfqZF3yPMPk0vFsMStLi4fYqBATbeHenb/MNYdLQmNmuUM146EscxxAm7hD
         uOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784701409; x=1785306209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYM9uk4RjTWm27MB5EyNDXkYKmnCgxdummGBOSonWTA=;
        b=g4IcxayoBSDMhz1IahXrO8fBYunqK6sCADG0wNootKF8IdusNDVKCn1J6l49waVyf5
         aH32y0gUCc8OL+TKQasjxHMDLyhuf9+lv7oAvnSEyi96yLN6ng9a3QJU3r1z1TZQXuzl
         YEtTrNepkAdDkcfxey+/Klmx2+w8CJ7xAcB0ZM9J90QCmbkPXYNkEMmTm8oHLV+61w3c
         cqIztLwJ7yvtCaLPji/57kHvxyApItNvBVRYdplWVBcWTEKhSqV2OukNQxZyaBY9qGz4
         wXBAYuvcx02sejHd8k+ai1DAdHHdr0jXIQOlUAO/NCAR3uJcRrmgNuUfZ3X4wXcTbMtC
         oJ3w==
X-Gm-Message-State: AOJu0Yw/U+gTKyoKpVPCoCi4GP31qRPVnMh8J3S4PvqTdgqZug6X4lIl
	qaYlYWw3irOrCpdLhLHfIhCg7Q1P4l3bcHFFLhJ9svxoSsYJix2z5VJDN7q2erBvV5emfrlVDji
	d/E6rdmKa2EJjsb5Lm5wZyg7j/tl3inTFoXB0xXZW
X-Gm-Gg: AR+sD12Z3rqN6R0iZiEaAbgXNZfbAEuWsGXxD6jGGsRzT8kO/a/mjQj+yNyXOedPx5w
	My1l9ERJLcDIdc7kXK+Wdq2hxyKKHJlFSmKR4uDVIZmB1zp9JyNpAspRwV9mVIHvsycFmj7Wuvg
	vM5gKx56Kmm1xEdtIPap8lqHIgIQiNiaNqHhyBqYA9z4ieayALB/+kCYUtVZOWANhj89rO611zc
	oqgVR6ffVsD0BKdQbWLqPHtOUe9eifBk4Mju2wF3L4FngXnaEDYPb1vXmMird2zOCkuWAy3iAZv
	ylQoId01jTOnsn6N
X-Received: by 2002:a05:6000:41c2:b0:475:f100:360c with SMTP id
 ffacd0b85a97d-47f6234003dmr25443546f8f.59.1784701408647; Tue, 21 Jul 2026
 23:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721152424.521567757@linuxfoundation.org> <20260721152425.635542881@linuxfoundation.org>
In-Reply-To: <20260721152425.635542881@linuxfoundation.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jul 2026 08:23:16 +0200
X-Gm-Features: AUfX_mxsrSdDyl3_7tKTy7_aH7RAMmHRJQ1nNTAE4JfYa1EUInn7tOh6qeIXNRE
Message-ID: <CAH5fLgjeGuBf3DBSwRDXbWCCc1__ZmkZ4W+5F1iwhAFCc2A25A@mail.gmail.com>
Subject: Re: [PATCH 6.1 0048/1067] rust: Kbuild: set frame-pointer llvm module
 flag for CONFIG_FRAME_POINTER
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 11:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Alice Ryhl <aliceryhl@google.com>
>
> commit 191f49f1e38b1c10eb44b0f967c6175c884ef7db upstream.
>
> Due to a rustc bug, the -Cforce-frame-pointers=3Dy flag only emits the
> frame-pointer annotation for functions, but not for the module. This
> means that functions generated by the LLVM backend such as
> 'asan.module_ctor' do not receive the frame-pointer annotation.
>
> This is likely to lead to broken backtraces and may also cause issues
> with ftrace if these features are used with functions generated by the
> LLVM backend.
>
> Thus, use -Zllvm_module_flag to work around this rustc bug if using a
> rustc without the fix.
>
> [ The fix [1] has landed for Rust 1.98.0 (expected release on
>   2026-08-20). - Miguel ]
>
> Cc: stable@vger.kernel.org # 6.12.y and later (flag not available in pinn=
ed Rust in older LTSs).
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Link: https://github.com/rust-lang/rust/pull/156980 [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://patch.msgid.link/20260616-frame-ptr-fix-v1-1-dc6b29a631d9@g=
oogle.com
> [ - Adjusted Cc: stable@ as discussed.
>   - Added comment with link to the PR, similar to what we did in commit
>     ac35b5580ace ("rust: arm64: set uwtable llvm module flag for
>     CONFIG_UNWIND_TABLES").
>     - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Makefile |    3 +++
>  1 file changed, 3 insertions(+)
>
> --- a/Makefile
> +++ b/Makefile
> @@ -904,6 +904,9 @@ KBUILD_CFLAGS +=3D $(call cc-disable-warni
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  +=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  KBUILD_RUSTFLAGS +=3D -Cforce-frame-pointers=3Dy
> +# Work around rustc bug on compilers without
> +# https://github.com/rust-lang/rust/pull/156980.
> +KBUILD_RUSTFLAGS +=3D $(if $(call rustc-min-version,109800),,-Zllvm_modu=
le_flag=3Dframe-pointer:u32:2:max)

We shouldn't backport this to 6.1 because -Zllvm_module_flag does not
exist on the rustc version used by the 6.1 kernel.

Alice
