Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389379;
	b=B1FWEPm0KZIQMz+6QaRN8Pdejy3Y2OOl2XCOnIyopzkI1QspgT5odRowV7AT+pVE9PZh
	 kMBARh7U+JbQCNJdNYAiyCOM2OnA3DmzqO+3mQ0FouRrMOcf0vHH2SJjHYE25yesoDtUm
	 t3UQJAJ5s9sEMEDd4ImojxpVX6nKlPgRD90VX6MhowtCM7+oQ3KeCHBlYA0m9aYjgoDDA
	 feoF0X/LDijHPWWXc/g0Gikb8YIcQ0EkNLcoC8yLL2v5vXBhGq768x8HbAP2EuxYmCM+o
	 mS3WVMjKFD+suI6v7i35/M4ahy+fCg9mPZI9xUGBheIJhNWkYEGFbZiQZjO6NprZD8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/wyfEDWWDuIr1slw1zxcxTDWKymMx6jtSpk7SY5bUAw=;
	b=woLgidXdwEFVHryxzM27YncqrgVjRc+8mU/LSL8/DyXE/O4q1KvzNY0EQF0J4xJICCD/
	 SiuzVzt9t0tYG3iQwd14LxGvOxzfgLyGH2iZ5TL9+UwlhAbTLpVgv+XvLdc6RL5hI4Z1b
	 BdcUU2OJATZFaPgvMi0qYYnkJ1LpIYFlHkzI+1Oo44pESyk9PA8bfj1SpaigGu5q0UH3k
	 1p8xc0mUzAVe+9GgkxaK3rKkI4Vi/HnqekWqQ51CId3J0n8p6a+esc/950xbg4PsY7ywD
	 E3P31UYW2Gm/foQq1DhO0QxHSLAuu7J5vbHqx/jey0VS9T3Q30bTqWhXpkfzMoV4law==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mIz+x5NO;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F03606A33B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80F03606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mIz+x5NO
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4922dbcee23so1687123f8f.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389378; x=1794994178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/wyfEDWWDuIr1slw1zxcxTDWKymMx6jtSpk7SY5bUAw=;
        b=mIz+x5NOpN2cIR1fstIXQYnCW6VsEYNhbJ5YAA4meZT+odupw2IgpROiY5YB5r7r+c
         mOJp+AdCWXCV8euzxhSfUecwtVnnQx6Cm6lKaIOf72GX6vB5NbP36m7XxayqEzrlDDye
         h7JdokGCk4+FYZRXUrHOIzSsGy2r1+W1dB/VK53iq19VzP8AjqWhJbuHwsZa39J3h+62
         CLdXEoJgSJVs0DHIW/THzxH0zM9+UGWQX4smgoEEoiexr6wF6DS1LIlx/phcG9iY1eBk
         rQ8rqqKfkn8zLr2LbSEPNwkwQGoNBwiCmB9M0uiXjHKcgQyBN/Segh6x2BRAGsjX0fLX
         zISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389378; x=1794994178;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wyfEDWWDuIr1slw1zxcxTDWKymMx6jtSpk7SY5bUAw=;
        b=yXJ7Un1Cf2muzo2pkpXaB8vHjKNDB9cL3FbkdKDkQB5YxsBQKBFAxDZC9hhw9CIKle
         jI55iqNMvGLUS2bAWPNPDQSPF0e56h2XLOf2w/R788Ptpi3YQPI3ZItLr9BtSbThP60L
         GJBhNLpmhdPQhPaoCRXwqUGV3T9DsrgiEe9oiZ27Em/ShUoJ0RlUc/19w0ODIbf4pQGU
         u8I3tX35hDv0fNBVzdEfxy7l2cBHZEV1NLpO6ZhUNWuJk7uibZjGiqK4PiY2via9hLAr
         uA6j0X4YyGu4bRRyC6XPNb7XwyDR0KYLDKilL2la42ZnUA6jHYLDLitDW2t613dL5QRT
         OrDg==
X-Forwarded-Encrypted: i=1; AL+hErFksFcibnsZB7l19eypQxo6D9DzV+v9clf6UFrPKacr5LG8BZcaARLucu12H4g8lCdiPdO+Hzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IgpIxd1vxLQrE+5/+zC/0Lj9d2NOiY1mnjm+KTyGmHxnhZeZ4
	Iu9bco2b4bom10AsavxaBNgPc+P5moa0zLN9XKY9HUDC9G5P5GW4t3rp
X-Gm-Gg: AYBFou0T/7KnnIxt1umyh3eONXJhL2ZsNQ1VTMZuiVGLzFfcW/ev974gNDGuIDdSHdH
	jaUQ4K53CGVcApqfuGni62MfEdj+7gelE3/TvI+1fLG1CEkK0eRJpRqaeDLBLY4PuzGrOXFcLMw
	ecKJhwZWVEcnnwAhHqdkTo2DdMflND0drhwNGnE0nCwdsVxx27Z1KxZhNQnB6zc+Rcd/l5VivzO
	/53qUtTosWmGkDRnd9lU/nQoYmjtDeaXYce7ZDOj3BcO7utZfpNRMvUEPimBwnPG7KnjWyIPh6x
	jDIjalWOAH/eDvwu5KdJKPo8ezolN3e2A76ndT/wSkJc4V0RYT8bhUQjkloirb7GbbC5W+t3/zO
	erQMgtztjnbZnzdBqYEnVl/ulaeb6KK/pJecgS4PSmfnMkRSCUftLdRv0OWBCp7mZ15elqht0BP
	V8QZ3MjicV1T5eJQtBWy6qQBHx+W1+8iCXNdj0ItAxpss9Al0VMapOT2iZZttt2nv1UmpZsayLI
	4m9mPYCvvoBcSfZObpz2cUiL6Lfe0vGhLkVVxRgeJImbjWucQm+FlQJMa1v9z+1JPz6IwkHbuyN
	NTatUVA4PdhQmH7cJxPUWnc1cHUsxbpai30oTLoWYVW0BxsLs10OZgyLjGSWsagv1A==
X-Received: by 2002:a05:6000:4011:b0:492:e1a6:90f9 with SMTP id ffacd0b85a97d-499c72712e8mr3087990f8f.18.1794389377659;
        Wed, 11 Nov 2026 01:29:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm10160123f8f.11.2026.11.11.01.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:29:36 -0800 (PST)
Date: Wed, 11 Nov 2026 09:29:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>, <will@kernel.org>,
 <mark.rutland@arm.com>, <ardb@kernel.org>, <song@kernel.org>,
 <dylanbhatch@google.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: patching: Fix instruction byte order in
 aarch64_insn_set()
Message-ID: <20261111092935.4d6060ee@pumpkin>
In-Reply-To: <3b540bc9-69b3-42a8-8431-75dd6079bf4f@bytedance.com>
References: <20261010084721.2197683-1-qirui.001@bytedance.com>
	<20261010085055.2200241-1-qirui.001@bytedance.com>
	<atEGBsR3eI3cXKay@arm.com>
	<3b540bc9-69b3-42a8-8431-75dd6079bf4f@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 14:52:44 +0800
"Rui Qi" <qirui.001@bytedance.com> wrote:

> On 10/16/26 12:57 AM, Catalin Marinas wrote:
> > On Sat, Oct 10, 2026 at 04:50:54PM +0800, Rui Qi wrote:  
> >> aarch64_insn_set() passes the host-endian u32 instruction straight to
> >> text_poke_memset(), which memset32()'s it into memory in host byte order.
> >> AArch64 instructions must be little-endian in memory, so on a big-endian
> >> kernel the written bytes are reversed and the CPU takes an UNDEFINED
> >> instruction exception when fetching them.  The sibling aarch64_insn_write()
> >> already converts with cpu_to_le32(); aarch64_insn_set() does not.
> >>
> >> This is reachable in-tree: bpf_arch_text_invalidate() fills freed JIT
> >> regions with AARCH64_BREAK_FAULT through aarch64_insn_set(), and arm64
> >> selects HAVE_EBPF_JIT without a big-endian guard, so the path is taken on
> >> BE kernels with BPF JIT.  The direct-fill loop in the same file already
> >> cpu_to_le32()'s the constant, confirming the expected byte order.
> >>
> >> Convert the instruction to little-endian before the memset, mirroring
> >> aarch64_insn_write().  On LE the conversion is a no-op, so behaviour is
> >> unchanged.  
> > 
> > We are just about to remove big-endian support (in 7.4).
> >   
> 
> Understood.  In -next arm64 no longer has a config CPU_BIG_ENDIAN and
> nothing selects it, so 1/3 and 2/3 are fixing a configuration that no
> longer exists.  I'll drop both.

Should it still be fixed in the LTS kernels?
(or disable BPF JIT for arm BE)

David

> 
> 3/3 ("arm64: module: Use text-poke for late PLT/veneer emission") is
> independent of the byte-order work: it routes
> module_emit_plt_entry() / module_emit_veneer_for_adrp() through
> aarch64_insn_copy() so a late livepatch relocation that falls back to
> PLT emission does not write into the ROX .plt and Data Abort.  That
> path is reachable on LE today (klp_write_section_relocs() on a
> MODULE_STATE_LIVE patch module), so it is not BE-specific; it carries
> Fixes: 91b89a634487 and Cc: stable.
> 
> I'll resend 3/3 as a standalone patch in a new thread.  Happy to route
> it a particular way if you'd prefer.
> 

