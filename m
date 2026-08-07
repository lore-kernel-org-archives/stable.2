Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31C41F36F
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102566; cv=none; b=d9FqM79cTaEMYt4zK9rA6SinqBUBAeB2aJ9KFsIYl0yGBoQsumGuPbth625jFnQn5XDBH8eEXjuAMkX4rNGAyWRSsOudPOJ/v8NhybYJU9/8gYhiHkEXhMQtHkyEkJq6UE5MAGJ9qbxv9X71IFTnyCg+MvyJGZeMjJvamHro5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102566; c=relaxed/simple;
	bh=SdeLscMrhTxsnqVD2TP9vz+ha9ad8aAfyTCf0h1z0Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9Bi1Iw+YYLRkJUj+0yTD3Sm9UtnkKyKKKVN1/skIxu5zFDhGgqpzA3lC5l82wKsV8GhqBdVPSqAUgwuvuBxcEtu7hhfI1iaLGAhwFKZ7BFqB/ZHkUoHC/Bu1g0PIb7SCbfHE4wM3qXqkhIwekUT2RZfY9SLK4c3+xemTyUEb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lCsjEjji; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lCsjEjji"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60C401516;
	Fri,  7 Aug 2026 04:36:00 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFEDD3F86F;
	Fri,  7 Aug 2026 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786102564; bh=SdeLscMrhTxsnqVD2TP9vz+ha9ad8aAfyTCf0h1z0Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCsjEjjiVcPNUo2YG2yJKMdC3Xd4SP9J9kTKrRUNbd7WA0iUYdtK3fpyrALXR9fqB
	 bPA6jUXf2vgJoh8xF59v7914p8Zijoo6Wc3+VikJV12OelfBRnpyjXUpIikFiIwits
	 wLztaHh2rfF0WSRecapTIGzJxAauQAS4P4chCxX4=
Date: Fri, 7 Aug 2026 12:35:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
	cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
	james.morse@arm.com, ljs@kernel.org, maz@kernel.org,
	peterz@infradead.org, ruanjinjie@huawei.com, ryan.roberts@arm.com,
	stable@vger.kernel.org, vladimir.murzin@arm.com, will@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2 11/20] arm64: entry: sdei: Restore all clobberable GPRs
Message-ID: <anXDGLkN-DbQ5hga@J2N7QTR9R3>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-12-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804170503.3513916-12-mark.rutland@arm.com>

On Tue, Aug 04, 2026 at 06:04:54PM +0100, Mark Rutland wrote:
> Currently __sdei_asm_handler() avoids restoring x20 to x27, as these are
> not be clobbered by existing code. This is correct today, but it makes
> it awkward to rework __sdei_asm_handler(). Given the rarity of SDEI
> events, restoring x20 to x27 should not have a measurable impact.
> 
> Restore x20 to x27 when returning from an SDEI event handler. This will
> free up those GPRs for usage in __sdei_asm_handler() prior to return.

Sashiko noticed an error below that I'll fix for v3.

> -	/* restore regs >x17 that we clobbered */
> +	/* restore regs >x17 that firmware won't restore */
>  	mov	x4, x19         // keep x4 for __sdei_asm_exit_trampoline
> -	ldp	x28, x29, [x4, #SDEI_EVENT_INTREGS + 16 * 14]
>  	ldp	x18, x19, [x4, #SDEI_EVENT_INTREGS + 16 * 9]
> +	ldp	x20, x21, [x4, #SDEI_EVENT_INTREGS + 16 * 10]
> +	ldp	x22, x23, [x4, #SDEI_EVENT_INTREGS + 16 * 11]
> +	ldp	x24, x25, [x4, #SDEI_EVENT_INTREGS + 16 * 12]
> +	ldp	x22, x27, [x4, #SDEI_EVENT_INTREGS + 16 * 13]
                ^^^

That should be 'x26'.

Mark.

> +	ldp	x28, x29, [x4, #SDEI_EVENT_INTREGS + 16 * 14]
>  	ldp	lr, x1, [x4, #SDEI_EVENT_INTREGS + S_LR]
>  	mov	sp, x1
>  
> -- 
> 2.30.2
> 
