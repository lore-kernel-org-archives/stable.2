Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001399;
	b=N54D0AvBrEsPeTpDMHfztB1ejMllhIe3ci0/mRezXlCe6x9yCMUTkQ8ymgvARVNO9yjX
	 k5ntGPYKKgHUcMsvaScgoMEx1hLWjvNgTvBee2QcwMb6BsJH7kJoOaNBNni6Cm3rLFBAQ
	 p+6t6b/jtAU3yABUzYBy0puzGqmXPxBwVU9ahuMeSRZkORSh/YzejljieIFS/dyqVucnm
	 JVOb3S47Mkoo/fpVAdncLoXel1L4IWcNRhbY4q5E875G7f06Dgh2wGTGh9hU/I/9QaoXj
	 317LoWMBilO6bDvtRClgKAe9lS6PFQ/KZwVdourY62KhwaoX5RBuaMDO90qJF71/f9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CKJXXPGigrKiCn6BqmrO398ZNmnv1y4ivGMlHte/o0E=;
	b=bohcY2h9qGUO2SvAlzy5Qm/qydboP0IFFhQip5xvgk2m8hp08mBT/bzVsYUJZNecAPHG
	 drQLe+Ul7DHeuNH/OAG5NfXKH8Blo0AWoFQz+yBEiv0B6MSZU3+qrw5Nqm77RSANcKVgt
	 pHlZKolA787zZ7d6a5KRaRI2y15sDRHDxJQmQXgaNBmq5Gr3ifhfdAVzNqs4HBg84mnkW
	 2xElmmxwkfu5Kaae0B1p8XtmwKkCwH7+ZS5Dl00tH7qAxLqwV7VDfeFFI//AbevXGJeCl
	 iIM4TDfKvbX6L2A8CrQl6JYVP5Oh2S8vKqbjvPpGg57SlW5ygcDXZUKMJI63l+w1aig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuBN95WS;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A6606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A93A6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuBN95WS
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd69954c755so725198a12.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001398; x=1795606198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CKJXXPGigrKiCn6BqmrO398ZNmnv1y4ivGMlHte/o0E=;
        b=uuBN95WSEgtwvJ5b3XgGzVGsIkSPMmD8peFA0kaW4t8J3Hwzt8LSI6YOOnU2f1r9i5
         OvNL3KbvQYpNCSdr4fkW8z4Owu0lZQUoGE+LyG6s6i/gmvGrxNZaz3EpqcOQR29bT9OR
         zH/OqaFbFTiUIWiVtLqPyPJUBEj9XAGdKQ5OShvoTH1AoAnu0p+lO+2MdvvRXDmrJSfC
         k75uYDvq/+C9rUeOwqRvUt0WBSJxm4StE/pdGoVi70UzAJnNG2hvAZBtvQ7qwy8laElu
         wfqopc3FOF8KIQCBjYlAmTR0Cnk8apqX8oyrqsp8R2XoG6GAvC/5UTnu67p8g94mHb8V
         FzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001398; x=1795606198;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKJXXPGigrKiCn6BqmrO398ZNmnv1y4ivGMlHte/o0E=;
        b=veo4waabffWdjekPilQi9GOx6nLYXR/UOHIzbW5Ry4sU7ukZsXa8T6xEigqmNvuUvK
         Zslz9J+mUEFO80Dr9zlOvkEqwCcLdup5nxkSn2HCxOekefFPDYVVwbDBCc+bR1VXoulP
         V8sUkDD60H0GJcraqEab3/3ipWvNHin+WkhDiqkTZah8ZzeYqyfRq/Dei3Z2XZ29MlrC
         /iK3P3SFvQtWdo5W66WxFLT3VxXcUPLUeX/MmIQ8bi/r8gtoO9o/uNgsoQZThbSNT/gX
         Vm0iT2JTJxpuXd5Dy70EkpKKkoD9j7IbpSKM43gD2MskYb/WGehccrFAheCkGQU0Q+Fh
         fxcw==
X-Forwarded-Encrypted: i=1; AL+hErF5ejaPUwmpeIlV6GR1SqIPaVt9hhfGWLFjdIDfo9nuU3AN5BbDTF9BqZB9dLtlmB+RG5GfFD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u9cYtPoTDoDH2TSQOT5qCpuy1KnM+gX35uzi/0/YqW/eiSNiO
	WaOh+spWcYvFcBGURnVAqr8hxvWRzcfIqsa3NPayW+FPFGa1/M/H4ln8
X-Gm-Gg: AZFdTZclk9e3lXy1YcuaPQgXWBsY7olqdCrejSo7SIVg8QtSq2i7vvC9YOwm5kQnwY5
	j8x8brJisYpsLTgfh52DH7l4BFeP5FjTp/vPVPiIgLXpP/UO2F+EmW8Oi9+dqLIEhXFTpkj9d4K
	4UPjx+9l5y3L4Bdpox9gIx0OT0eijUvP53jAeczv2NGGqL2OiyfPofpzHlq6Nr8gBQkI4N/h/Df
	gEMSka5qaSlLo5u555wVS973fgOrNJjYg2hKjfjLNzi9TNJ8VrDA4EMe8IuEQDj4J2mKugysjG6
	kh2Td8FZ2TsQh8Oq9pzAYdkhMyTcIoHXFvUcZvfMSJIGNFu/8jcH7Vkszm2PDFjvKOtlzLO6XCC
	fMs49tULvPrH2P5CHpLwioY1XKtkzoTlOg73g5jtLiqsRvOAxQ8+OrCMDB3Pvlo6FLl3TEtfg/c
	0c661bZiUovtTVAFhECIkU3E+PuHgKO9NngFyOS0/ygXBi2Fjol/QdKewi3hWGUs1Lw9/kcDmk4
	L6Bcwi+3nbK1A8rWjnQjAMoN0mQLr4ow/TFFO2cvA+c7iEyIVB4MWkpXxPpmHOaEgn6kJ/GBj1K
	y5qs9TpuwXYcyaIuMUG1Ijq8zzs=
X-Received: by 2002:a17:90b:1a8d:b0:3b3:c4dd:5437 with SMTP id 98e67ed59e1d1-3b3d06415fdmr2730809a91.5.1795001397974;
        Wed, 18 Nov 2026 03:29:57 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d143d69csm3960221a91.1.2026.11.18.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:29:57 -0800 (PST)
Date: Wed, 18 Nov 2026 19:29:27 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Peixin Xie <peixin.xie@linux.spacemit.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: cpu: Fix incorrect cached machine IDs on
 secondary harts
Message-ID: <av2L1MlTWoYI74eu@inochi.infowork>
References: <20261118-riscv-marchid-fix-v1-1-6d677fcd5461@linux.spacemit.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-riscv-marchid-fix-v1-1-6d677fcd5461@linux.spacemit.com>

On Wed, Nov 18, 2026 at 11:04:33AM +0800, Peixin Xie wrote:
> During early ISA-string parsing, the boot hart stores its mvendorid
> and marchid in riscv_cpuinfo. This happens before setup_per_cpu_areas(),
> which copies the static per-CPU data to each CPU's allocated area.
> 
> When riscv_cpuinfo_starting() runs on the other harts, the copied IDs
> are already nonzero, so it skips reading their own IDs. As a result,
> secondary harts can retain the boot hart's IDs.
> 
> Read mvendorid and marchid unconditionally on each hart, as already
> done for mimpid.
> 
> Fixes: e482eab4d1eb ("riscv: cpufeature: Fix thead vector hwcap removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> ---
>  arch/riscv/kernel/cpu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index af84b97af3a1..64c0c83eff76 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -197,16 +197,12 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
>  	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
>  
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
> -	if (!ci->mvendorid)
> -		ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> -	if (!ci->marchid)
> -		ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
>  	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
>  #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> -	if (!ci->mvendorid)
> -		ci->mvendorid = csr_read(CSR_MVENDORID);
> -	if (!ci->marchid)
> -		ci->marchid = csr_read(CSR_MARCHID);
> +	ci->mvendorid = csr_read(CSR_MVENDORID);
> +	ci->marchid = csr_read(CSR_MARCHID);
>  	ci->mimpid = csr_read(CSR_MIMPID);
>  #else
>  	ci->mvendorid = 0;
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261118-riscv-marchid-fix-3ea3672d1e0e
> 
> Best regards,
> --  
> Peixin Xie <peixin.xie@linux.spacemit.com>
> 

LGTM.

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
