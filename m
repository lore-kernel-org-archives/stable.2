Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690601AAE28;
	Mon, 10 Aug 2026 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350247; cv=none; b=qjHyM4L7rdpvOq/9WwOMC6f4ZuhGDNhLp+Gda8CKZJXusl6NIRAkm32bwcntmZx7H654rQTeeeuDK562/MDsK32YEQoe7tUZpS/EPQ/XoD37JMGLqp3HvoHyzQig0L0B3aLZLa5xf4eDr8NrTZT6NBCPdn9YWZT6TWLKgZP2yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350247; c=relaxed/simple;
	bh=udpzQOnp2NHd3xagHK7GnNYaIbSRI46MyJU+yjjkzVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMmkpyC8bCECfRVp3hEPYOHqVs5LRRh7EyBpx5jfCJbqQUMIJ2kJXpfevDX5ej0U81pGDyLE5x4TqRrQ9Rq913u4+d+o7TxlMd9NUZmfMaJLdJ7vqKcEA43jjBxV+0Oahuxl9WDjeWAt7Oza4UG83gVe4wQ00Dhwh8lyu89QQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDf0pMZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDf0pMZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ABA1F000E9;
	Mon, 10 Aug 2026 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350246;
	bh=za/dgLTVAKpnAfno98BQIXcUPCYXTejUD5HWiea1RH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kDf0pMZ6OrhTueAr8AycS7nuhFdWoL9WvStErXhNm3cYqWa7kU6wjtfmC+OyLrVpv
	 4vcetwy4RP5rGzvLxz/ApRu7FEj2/8mu0Fh6OkbeAkVHL0lYg/YY1rtEXL3U34Y0TE
	 h/SotQuCdSuIzeWasbGnrYi5yUA8CXqyCUUIcb96YUOQV1vHmzJa8E/I7DIdaXfJVH
	 knYSokPq7zwOwZF+tta9poedyBEfuUZEQezEhdexuDZ9331hbNSKqpN/by80TRaAK7
	 2Br7Dnjo0gE0pQovl+l+bj5eaQqyd33PsRgF+ysKBRRemFMcwTWr4U33sHePjaQ7Mf
	 j/Fiqqabfzcmw==
Date: Mon, 10 Aug 2026 11:23:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Maxi Saparov <maxi.saparov@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>, stable@vger.kernel.org
Subject: Re: [PATCH] kho: do not reserve scratch memory in the kdump kernel
Message-ID: <anmKnlBmOssfqdbL@kernel.org>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803193938.8778-1-maxi.saparov@gmail.com>

Hi,

On Mon, Aug 03, 2026 at 03:39:38PM -0400, Maxi Saparov wrote:
> From: Maxi Saparov <masaparov@coreweave.com>
> 
> If a kernel with CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y (or kho=on)
> does not receive a handover FDT, it reserves KHO scratch memory in
> kho_reserve_scratch(). The function computes the sizes from the early
> memblock reservations of the kernel. The default scratch_scale is
> 200%. The lowmem and global scratch areas each get twice the size of
> the early reservations. Each NUMA node gets one more scratch area at
> the same scale.
> 
> The kdump kernel always takes this path. Since commit a6715d7ec472
> ("kho: skip KHO for crash kernel"), the kernel does not add KHO
> metadata to the crash kimage. As a result, the kdump kernel never
> receives a handover FDT and always reserves scratch memory.
> 
> The kdump kernel boots in the small crashkernel= memory reservation.
> On our x86 hosts, the kernel and initramfs make approximately 176 MB
> of early reservations. The scratch areas then use approximately
> 650 MB more of the crashkernel memory. When a large early allocation
> fails, the kdump kernel panics:
> 
>   bio: can't create integrity buf pool
> 
> A kdump kernel has nothing to hand over: its only task is to dump the
> memory of the old kernel and reboot. Disable KHO in the kdump kernel
> so that it does not reserve scratch memory.
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxi Saparov <masaparov@coreweave.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6fad9152387a..53b59edb5b36 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/cleanup.h>
>  #include <linux/cma.h>
> +#include <linux/crash_dump.h>
>  #include <linux/kmemleak.h>
>  #include <linux/count_zeros.h>
>  #include <linux/kasan.h>
> @@ -1636,6 +1637,9 @@ void __init kho_memory_init(void)
>  
>  		if (kho_mem_retrieve(kho_get_fdt()))
>  			kho_in.fdt_phys = 0;
> +	} else if (is_kdump_kernel()) {
> +		kho_enable = false;
> +		pr_info("disabled in the kdump kernel\n");

Can we put this on top as a separate if, like

	if (is_kdump_kernel()) {
		/* disable KHO */
		return;
	}

>  	} else {
>  		kho_reserve_scratch();
>  	}
> 
> base-commit: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
> -- 
> 2.55.0
> 

-- 
Sincerely yours,
Mike.
