Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949606;
	b=ma93iD+W1v27F1p1KVIbB9zOHmKsG+Re9BhIQVgW/n00EaY1g1R9lMFSQWAzk+UyzwcG
	 slsPwlIHdN7+TMtCN8S4IobthdOUm6+NRb+Y93hVqXaP91ce2j1JokuDWHTCIx1imC8kb
	 saelOOuOWZ79RhezCVnT5Yl3p3cTBzSFg9RGX2YHvrbt/wDBzjNc+Yl1TY4LYRcvAUR90
	 ADPlXpOZBQo5QqQejfqansZ+7Mw8sTwZQ1vY9b/j4FE7OhNst8cQ39NEfi0Mi2Tpvh5sd
	 AOk0birI9Yvdx1V6QRMj3Wg0CDzn5oeyXPfGOqWKg5RKoh1Eg4e676B1m0srMinrqvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZJOvsp983XDYRMIVjbk3zjfbQslPi07N9u22A9WMPio=;
	b=AcbQF4/EjAk5BEQW2Xir0/OWj+XldXyZzNBIJrce3eiIby14zFmamaU6HAdz3aey4Ajr
	 JiRGcbiATwc9hhyfgd0ry5H31duXJvhbFSQaEsHICPCNC27Mzy7WZSM09Lg07L38UC3Ar
	 EyYJu4C7U/7wSyFwZprW3yrWKtdR5xgBogHTHXYyIdaUda7BL9xg52X2L5jEnDovx9zAd
	 sUodxr5UE9JXU1tJ7bxH+ZXNuGGQpnkpC5gLjB4WyAaYQ7ZStNdUNjzra/0hKjTdUmZ/e
	 WxhivYjonnonu7i8ZQsglS/GPVPRXunicC85l2osCRF7RaHAUfH+V6bRpnEJL7SO5ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHU2A5+L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC3606A326;
	Fri,  6 Nov 2026 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHU2A5+L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEC81F0089F;
	Fri,  6 Nov 2026 07:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949605;
	bh=ZJOvsp983XDYRMIVjbk3zjfbQslPi07N9u22A9WMPio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mHU2A5+LsQVtAJnSEcfjo5qJzR/0bW3Bijrr0JQE5gQXcDSinL6vccTk+QtUevlmi
	 iU5ifKqLoa3fIj4VqQGRVZ+OfIFY2AEqxp6aq/RcF0bbmp9ZzD2UdzOZZrCLlTODDy
	 kuA526zQFhomBKeb7c2Fh9xLI5LnEdgtQPMSDL63HjaV+NIyqCotAivXNbPwz6J02r
	 xdO+aJ480qsq8A/ak1Mc0yCv31RgZl58Hb/VB68rb+HZzWyXo9sfosF7+l9yMnC1+U
	 le/cewkfpMHPFj4LQBV2yNtLCAPBbBR+TpbSFzXTpnFP9DK1rVkvS7cXTMaQmCVdkM
	 WOB8xpDpjj7hg==
Date: Thu, 5 Nov 2026 23:20:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Paul <p@1g4.org>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, atrajeev@linux.vnet.ibm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf record: reject CPU indices equal to the mask size
Message-ID: <au1_ow_duqzf7nyY@google.com>
References: <20261030064825.2156317-1-p@1g4.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030064825.2156317-1-p@1g4.org>

On Fri, Oct 30, 2026 at 06:48:50AM +0000, Paul wrote:
> From: Paul Moses <p@1g4.org>
> 
> record__mmap_cpu_mask_init() rejects CPU indices greater than nbits but
> accepts nbits itself. Valid indices end at nbits - 1. When nbits is a
> multiple of BITS_PER_LONG, __set_bit() accesses the word immediately past
> the bitmap allocation.
> 
> User specified recording thread masks reach this write before they are
> intersected with the selected CPU mask. For example, an affinity mask
> containing CPU 64 overruns a bitmap allocated for 64 possible CPUs.

What's the exact command line?

> 
> ==40343==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7bbab4000018 at pc 0x6195de57af45 bp 0x7ffe25545d20 sp 0x7ffe25545d18
> READ of size 8 at 0x7bbab4000018 thread T0
>     
> Reject indices greater than or equal to nbits before setting a bit.
> 
> Fixes: cbd7bfc7fd99 ("tools/perf: Fix out of bound access to cpu mask array")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>

Arnaldo, do you want to take it for 7.4?

Thanks,
Namhyung

> ---
>  tools/perf/builtin-record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d7c8f490cb62..80aaad7d51ec 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3689,8 +3689,8 @@ static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cp
>  		return 0;
>  
>  	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpus) {
> -		/* Return ENODEV is input cpu is greater than max cpu */
> -		if ((unsigned long)cpu.cpu > mask->nbits)
> +		/* Return ENODEV if the CPU index is outside the mask. */
> +		if ((unsigned long)cpu.cpu >= mask->nbits)
>  			return -ENODEV;
>  		__set_bit(cpu.cpu, mask->bits);
>  	}
> -- 
> 2.56.GIT
> 
> 
