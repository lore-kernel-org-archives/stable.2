Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E33403F8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701380; cv=pass; b=pKH9qUGN0MmMoz1NvKirWevPPTk+UEzBWvR4WSvMKicTIb83503NzT4zlRURD3FuYi3N6H/g3rCUiUuYaWsG+rtgjYz3HLuUz/Hw3KwhYLb8jWTwL2Ak6LlT1K9j4AvIgoW1htbn7FzXrwiYq04Vcg4Mnt9lUQ2B55t7EkCk/0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701380; c=relaxed/simple;
	bh=ansZuHv5hUKB28upCGQgfNo4EuvlpKUL8A9OQ6KsPVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6ePzCCLTZLafkb56iKa/W8ohmZarmI545WlGfO5uxrGeTm6vN76DiiVHx63lg6iCPtZ5ONOiB/HKGWjqH1F7lGIh4inu8wAleLHDO9mmkoYGuFNLwGAOL80OMKNiQOc4Xano3u1AOcW5DkTL+E3mJ4iqaBvjbVfFICbCWGvN1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwWu85DN; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwWu85DN"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2489911f8f.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784701377; cv=none;
        d=google.com; s=arc-20260327;
        b=iGIW6guGDkP5ADrW34kaGMS1B4LyH0jLYTSwu1jiW28aGSwh0GFuKrBaKsPx2O+JbA
         qu/iwLcldrOpVQDy0tLvfXluPwaCkkqntainfDGTbFf5EJ+BVOKvNRs1FJjMmLqZOosU
         dgFbYfe1fy2uxa34j59iJJ4UILu+0xzPwkVZrmtxEFltbI6BMS32LMPIANnoUreDd82b
         lcGFKl+aeISBgSlOkq1u/oaI+ZDUlD+fOzZD2nRxy2HHDF7zE7NExoOfGCknhS2kY4ZN
         IoyXnYR20mXDcyqlZPdXBfHWi/h0xheZu+iPzqzPWd9ZU3Htgf8eiPW1K2rivgFMEjZ/
         pqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8ar+PE2tSF9whqkAGYsRk8+en4mtmc6KvMg4bog/9Q=;
        fh=DK/TXC/z/n5i+9IwmT8f5grLkL/Vt4VbItfb/GiLI/I=;
        b=M9Pr3QrPPALgRmo+9CZURPTQ/LUl1s4u+hy0wHQGA6/0/eq8HD4rb+rMcbx/vOq19D
         K1V0d9VdtJbF4QtMimWzg7OHuySZLpNmYsmE4TZBsTSaWdlbg6OwSe2v/aUk0TaEG9cw
         JeKQtlvy0IYF2X0zhWnFjnmIKGQr4tOzDGbA1o8CBP5bn83/zuPA4lglrOQk3DCpUGT2
         CZeKIIknqRSiJdgU/Se0k51vEX+0ERDJOa3AIFyKPijXmei8+ZZvPZ30M6Gg61YXxMum
         cj0Sz2CxYDVyTKaGqr7YYkTPDNFaXfrEh1W1mk25KdhJxY7GiJf+YDm6uCOcA1t21bnb
         aJTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784701377; x=1785306177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8ar+PE2tSF9whqkAGYsRk8+en4mtmc6KvMg4bog/9Q=;
        b=vwWu85DNVyU8YSvetk5kerwwlYxHX0vf0tGefDPftJvG63Iow67ZsU1+NCxDdbpae7
         kDcyfEJR3vEBbsNoHKSORMsMl+0fOnX4mnnOAJPgBjirOQiKi6baKFj+q0+gOnmzcCRO
         ohZu19Z8XdtBCvBPyhz/b50EvugIUX1Ffg1cjuBXLjjIXYCwDs9YStnzD4JdCq0vhez6
         2BGXAOh3PrUzNJQ1jU3HGb/Hj3Q9b8G40m/XYoFwc89Qk0DiYy+jHvIbEsOJ9FWJ0sKU
         Vkjnc0T4QN52dwQtaHV6jtjofVIvYKjw3asbo+GqsZhxHVX8/+UEVHAyzrRIcOL06bSS
         zK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784701377; x=1785306177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8ar+PE2tSF9whqkAGYsRk8+en4mtmc6KvMg4bog/9Q=;
        b=DI8GZK/XkUaSFfr06OBtj5APB1UD9u84C0bWwoX5kNXsuqyshjYv0B206mvVt7j9WY
         voFcUMdflq8IQUc2P95RNttZGmCyiq8T2u73jFErO0av8E/oMB3WDh3xYmadpN1XWEkT
         QI/AWS5M5it6D1WyouqRxm5OfwpG+D0XmDiGrOpu/BcoWhe+CdU23pc5ipcZwFng39Hl
         /6QNBQPX8OIeSD4BiKNBBx/g7HQWSOsGj9dCVQkHNiInncI3TqXJ/U5/A6pA4EJjrPje
         l+T/A5dB06YUahwtVeZMYtZk/DyBV6lblYX6SeS/30qso8H2AvXM8tliLMF87eIP06Z1
         /cIg==
X-Gm-Message-State: AOJu0Ywtwwgk7U6BLRwDDFQ6a61IS4/rOkqtIm8L/NAX5fwV1igu40YY
	vgKkhAgkpcIK+VMFZE5cI6vOdZ9PEqHg741GzniHwKdTEqJ0Z8azf8PuSZGBimBN0s9R+m3K+WG
	Vjn5l81gohDMN8zEaJb91FY7B79wIIfbrzUuVjCrG
X-Gm-Gg: AR+sD1214N2uxLKoYy4xZ078eadfd5iepF72/18DoqQVKb4pJ2tfmqz0GbBKOjAoMCv
	jq5LUWKWOqEsCpcex4VceCIfJNV27U4QbdvuFSmknaTjSYZemU+iRPjuPh307bgHSYcCW1tfwit
	W+hUF6UQCfh69OzV5yFNHixuyt44zJknNPzNTS1gQqY+pIBl2rBtGo+BRD1JzT7TEAsjSSsA/Qm
	gOJnKrTbXxHLxtED14S9JzmjTGgIA2wiSrbKcZKeLRQkuobiAcvA4MpWZip7A9fhAh1r7eJrM2p
	socd/1gjspoi4m4y
X-Received: by 2002:a05:6000:41dc:b0:474:d7a5:4b6d with SMTP id
 ffacd0b85a97d-47f6230d16cmr25728475f8f.21.1784701376894; Tue, 21 Jul 2026
 23:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721152441.786066624@linuxfoundation.org> <20260721152443.212105076@linuxfoundation.org>
In-Reply-To: <20260721152443.212105076@linuxfoundation.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jul 2026 08:22:43 +0200
X-Gm-Features: AUfX_myz5AVwlhMfAKqIhVYYjJxuDVlz6T3kotV2RykCrJ12L1ODYU1rEHzqql0
Message-ID: <CAH5fLgh=6eOcsUpBODZmyhQnZ0eqDfY12MkmA20w2JmgxJ3wiQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 0063/1266] rust: Kbuild: set frame-pointer llvm module
 flag for CONFIG_FRAME_POINTER
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 10:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
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
> @@ -857,6 +857,9 @@ KBUILD_RUSTFLAGS +=3D $(KBUILD_RUSTFLAGS-y
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  +=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  KBUILD_RUSTFLAGS +=3D -Cforce-frame-pointers=3Dy
> +# Work around rustc bug on compilers without
> +# https://github.com/rust-lang/rust/pull/156980.
> +KBUILD_RUSTFLAGS +=3D $(if $(call rustc-min-version,109800),,-Zllvm_modu=
le_flag=3Dframe-pointer:u32:2:max)

We shouldn't backport this to 6.6 because -Zllvm_module_flag does not
exist on the rustc version used by the 6.6. kernel.

Alice
