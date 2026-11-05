Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893543;
	b=jpQ0IRVJeb1SzXRHMKtzYOVbrABcociLXowCGP7fyRdd47Qq+G5Wn2/ke08mj6obVncq
	 5a/8hzkcewXSrLUv1eIMpFj2u2PgQHuklGfZDaq3C2Nhnwsj3PnmU/HKMEwOjpoeUAjNC
	 RrO0vs88f4MgNTI4QjAaUUsKepO7nXIwyMSnoz8l2iXWVHR1JP4elI365YFK615xuTzxu
	 84PNwvwvjQyQU1/C9V8M87DzzIKvYzRVQ3avgRofPOeEGwEeXLd4PwDteW8yzY2mN65IA
	 Bphp8S5jGkm5Ve9ioIMv0fYHTgQBnFR9JmEhJsMhZmDxC1WIPAlXqES7rU5uxbE+QEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893543;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7SeedL6hQESLthQ7VnwGJ/wWVq56RBH0P2R4DH0oBMo=;
	b=1W5mGQyl7WzHpCOBbPD5hr6q8zBtNyYiypZ8W+2bqqsQEkFttRCfsNkZ4SjpHamXsJMp
	 AV6sKV/Zk5aP0lK8HnRlNrPxmaMIToqGdNJ7R/ULrRG1sC5PaXLWhuCiH64fNSsI6cP+M
	 Xlnpm1PaE4i+eFFSNNXT1XP1Is78uQ5Iyc48fpquTAYrPkkrE0Y4rjf3nH3+Kqu2nTkO6
	 W1wy9gxL19c5FjypRlibHUewhcRp+AGKFPVmfOsC6kF7h5eca64CRaaqtGXRp32bjLTNw
	 tE5X2dBMOwDE/V7jdYGVgOFKncaJfm28DqJTm6/4vvyIjghBpHg67fKF2g27spFNQng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alpha.franken.de;
	spf=pass smtp.mailfrom=alpha.franken.de;
	arc=none smtp.remote-ip=193.175.24.41
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A9606A334;
	Thu,  5 Nov 2026 15:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9A9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xOzeg-00071Z-00; Thu, 05 Nov 2026 16:45:34 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 4927FC05F8; Thu,  5 Nov 2026 16:25:29 +0100 (CET)
Date: Thu, 5 Nov 2026 16:25:29 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: linux-mips@vger.kernel.org, Paul Burton <paulburton@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: mm: Fix the cache error vector jump for XKPHYS
 kernels
Message-ID: <auyf6aVT0_KuAm2r@alpha.franken.de>
References: <20261021185709.22561-1-kaloz@kernel.org>
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
In-Reply-To: <20261021185709.22561-1-kaloz@kernel.org>

On Wed, Oct 21, 2026 at 08:57:09PM +0200, Imre Kaloz wrote:
> except_vec2_generic jumps to cache_parity_error with a j, which cannot
> leave the vector's 256MB region. An XKPHYS kernel such as IP30's, linked
> at 512MB, is outside it, so the j targets an unbacked address and its
> speculative fetch raises bus errors on unrelated fetches. Jump to the
> handler's uncached XKPHYS address instead.
> 
> Fixes: 7505576d1c1a ("MIPS: add support for SGI Octane (IP30)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/mips/mm/cex-gen.S | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
