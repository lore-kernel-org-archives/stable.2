Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC593F44C8
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921264; cv=none; b=pADUaQZy6S/tA+M/NEkanW3S5M/A8olybOWneARPTmWws1WosZEJiIHF9TSHYb8dvG5QgWWIMLtlp+fxbiG5S+nUefjXrCIDXORiunBFSucmCsxKiIlzWM+mZqCNTpbwsiHnBZQSzw2HNMLmfVbQJpP/iGPDVNrCXq8qiGltStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921264; c=relaxed/simple;
	bh=6Ta1AhKebc/NNxYCgUsy4zl5YgVvhOOquj6VbiznMgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq0RTqaP/dJDJCbtIL9Q61luuYGDFX5TkJYk27pDriTmD3zcng/F8BnW+EBNOfoElO5uuVr0F4/GEvlwetPkahdMfoIH/zQJXeOHrh1cYhF0Xq4KHIXlxkLcYeogfefBsnYBzIeQt44mvPZO8oRzBvoAJ49eQbECoaRItFDNtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDhWZcBm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDhWZcBm"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f7854678cso451366f8f.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785921261; x=1786526061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6wxwPIWRM1vDM9w14XJDhv0/P5Ac49d5AiJFGkrPer4=;
        b=LDhWZcBmY4T3/5P/Qg3C61rwJkaTZ6K414loO0ayP5omiGdyeGZzbMxjn4gLgozVBU
         7XpXOadpjKes5ZAkNb1AnoqzMDyPWCCD1ZeazKdtNIVQUKEPA3WW1Nw3RdJxk0XEnGto
         49dYRqCwF88ZCaNEAQm4FWnnRTN3QjuGrJ7hBFvTVldSIGpmZC7wsc0VMWSRuA8e5flA
         s/dj3Kf2QOAH17yQvupnaduAyChns7XJAPGj245QX41Aa8L7HwVChkbswWvWQk2cND9c
         QHOalaOHYR6URTtvvtIKpfyg4Jahd78PUX3H2g4pHwIu1x4vDZCyiGfzlvAnSy4DuJlY
         +u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921261; x=1786526061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6wxwPIWRM1vDM9w14XJDhv0/P5Ac49d5AiJFGkrPer4=;
        b=TnCeFs660vi+a9WDfCCVqO6d4q+tYhg48c4ibOQdT6uJWq8JmKG858WJVoA66tOJVZ
         6HC+ycpTO1K8dim6UsaPo4C5c16gAiUZHpj6gm8oiTd2Oc688ZuTMt3kQ1OIBk6wIlIq
         VXU8GqZsPFCCuMgLAs57BZwvOY9BqnPuD0MIDLOBQxSwTXYKEcY0hNWNzbVraUhyDF6W
         JyV5tFhrVB/EM1fyXIT+78c2f2laHnO4nX8I27GDvXXrYtT7RVy1JgSqNhhFaNUd5tJe
         9pXPuOxJaa5nIP2fu0EGKq4PJziKtYSep0AtiaYH1O7imDgLQ9NjurYTyP+u0WefWV+0
         a9FQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7CU73NcAoaoRMeY0+GT6fMZUrOrJYiMg6U76jsHoZmIN9q/ztdx6MBOGfsFWbJ+Dyn8t71ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvNGnIlq/mCEzQKyh21GBnYcKPTfrdpY1B4qFgfW3AbQLg49a
	pmLcTDsO/JPd/w3eLTksiS9pRinu8kSXnKxuRisM3V2ti5DtdcAwjdtJ
X-Gm-Gg: AR+sD10SrhjQkqE+m5rFkSd8l7E2QY1C5rzleiVufXIMn8xHHe21v/Q56n35obvfjvG
	TiW6AEUYW0hTQ8eNFujJ1wUB+NjGdcjArayUAV/lTITD0Ygb4kilkLw/JzYUoZeqp0+zEpdP/QW
	ssRtCHD5HS4GzHPoJlhMSX9qVDRfwm7sPVsODKgqC9N6GbyRG6qDuKKmxbpAJRET5f2PsHL2qUd
	qlsTbrrdgAVwWymKcANXBp/xzTxAfPL7DJ3SICDw7sHjaxibfaLgNqEUHicOO10AIjyERaUvhMO
	VDcjxj++zSKfzyeUwwN+u6eH3T5pyb233eEontShis7Nkxzi9LDgvc2iqR3laMcG6Q2HnNrAO5S
	yKdj9b/KWmuzIZVdUL79RgE1Snsrprj/7hJLcyiWMB925xMYriqc3u1587Td2s5PJptjJN6L0/5
	K8xHxcWq+kBhKTbZjrqvPnuLqEEljLpbx/TvTxwTv4vXQqXbrbMQ1UtAAiS7IFTdIYhJvLd9TDn
	bWFw/m9NMSL0+8ffOPCnYY/OA==
X-Received: by 2002:a05:6000:40ce:b0:47f:96e3:530e with SMTP id ffacd0b85a97d-47fec4f015cmr9183382f8f.8.1785921260475;
        Wed, 05 Aug 2026 02:14:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5b1bsm6458207f8f.12.2026.08.05.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:14:18 -0700 (PDT)
Date: Wed, 5 Aug 2026 10:14:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 vladimir.murzin@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v2 02/20] arm64: percpu: Fix this_cpu_and() mask
 generation
Message-ID: <20260805101416.454a49b6@pumpkin>
In-Reply-To: <20260804170503.3513916-3-mark.rutland@arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<20260804170503.3513916-3-mark.rutland@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 18:04:45 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> The arm64 implementation of this_cpu_and(pcp, val) is built in terms of
> ANDNOT operations, which requires the 'val' argument to be bitwise
> negated. The bitwise negation is not implemented correctly, with two
> bugs described below.
> 
> (1) The bitwise negation is performed as '~val' rather than '~(val)'.
>     This won't always generate the expected value when 'val' is an
>     expression.
> 
>     For example, for this_cpu_and(pcp, 1 - 1):
> 
>     * 'val'    is  '1 - 1'   ===> (int) 0x00000000
>     * '~val'   is '~1 - 1'   ===> (int) 0xfffffffd
>     * '~(val)' is '~(1 - 1)' ===> (int) 0xffffffff
> 
>     ... and thus bit[1] of 'pcp' would be preserved unexpectedly by the
>     ANDNOT operation.
> 
> (2) The bitwise negation is performed on 'val' before it has been cast
>     to (at least) the width of 'pcp'. This won't always generate the
>     expected value for the upper bits.
> 
>     For example, for this_cpu_and(pcp, zero), where 'pcp' is a u64 and
>     'zero' is a u32:
> 
>     * 'zero'           ===> (u32) 0x00000000
>     * '~(zero)'        ===> (u32) 0xffffffff
>     * '(u64)~(zero)'   ===> (u64) 0x00000000ffffffff
>     * '~((u64)(zero))' ===> (u64) 0xffffffffffffffff
> 
>     ... and thus bits[63:32] of 'pcp' would be preserved unexpectedly by
>     the ANDNOT operation.
> 
> Fix these issues by adding brackets around 'val', and by casting 'val'
> to an appropriately-sized type before bitwise negation.
> 

I'm not sure the arm asm output is really needed.

> 
> Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 63bbfd4944a37..31193bcf89a2b 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -206,13 +206,13 @@ PERCPU_RET_OP(add, add, ldadd)
>  	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
>  
>  #define this_cpu_and_1(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_8, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_8, pcp, ~(u8)(val))
>  #define this_cpu_and_2(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_16, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_16, pcp, ~(u16)(val))

I don't think the (u8) or (u16) casts are needed.
They force the high 24/16 bits to be ones, but the asm should
ignore those bits (or possible even prefer they be zeros).
They might also force the compiler to emit code to mask the high bits.

Actually the (u16) cast is wrong for (s8)128.
That is tricky to fix, maybe:
	~(sizeof(val) == 1 ? (u8)(val) : (val))
(Remember ?: promotes its operands to int.)

>  #define this_cpu_and_4(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_32, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_32, pcp, ~(u32)(val))

The (u32) cast isn't needed (and has pretty much no effect).

>  #define this_cpu_and_8(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))

This one still isn't right.
If val is a signed int with a negative value then it is sign extended
before being inverted.
	val             (int)0x80000000
	(u64)(val)   0xffffffff80000000
	~(u64)(val)  0x000000007fffffff
Something like ~(u64)((val) + 0u) will DTRT.

	David

>  
>  #define this_cpu_or_1(pcp, val)		\
>  	_pcp_protect(__percpu_or_case_8, pcp, val)

