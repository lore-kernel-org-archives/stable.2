Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959855;
	b=gUbUku7qMAgJB84+UNwMppFHH5koeeDhLmNnFLlhvl1jurDS6y9u0f/71aDzHxne6n3W
	 Y0jP9zI8kHalaoRkTO/ACQR5v2tE6sCtCbZ7xdme754ubuT65MSYuqrnLR369xJhO2ADc
	 taBKJImybam5WKt7VariWxebrPSLcmqNVDuubjYv6l/Fj3g555THccpc6B+9sYnVNb06k
	 nNk+7Hx+L3WuRCqR2yDd3jmxPpsKvIqm5rc8/wf62akfsCxSw/GQSM3C5gBR88M7M+WMv
	 l6aDw4K0rxzI6EfaQCXQZCVqArg7J/pwH7Sw0QMnHyAcLbJ1o7Rvu/EV2NtuqdD2bKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q3OTBwL+TyzHGc36tg10hWnQr6i2w3v45IA4aHIlkR8=;
	b=JJGkglY5+xbTodrbwaHY1hwTEAtvsX0eo5iCT9aVAvR7IMNLeF1EyhqgWz//tN6GW3RX
	 X8vHwCeedoSPFyt4p7pYClsZX9ZRVP/UOk8fSMX3qwBACRy6zHAyvgp8a8DPaTsL0hRtq
	 DPsNq0V2ehe5qB9Tt/eTxiJrS/Z0XmNiRiwB0h7n0GtIbJo1Stj9Uf50T+L11d5yncwGs
	 /9r7ByzLf64d+BNZQhgancCqc9SsF0HWcR6d20vOqBQoYhipZVaPmsQyoAykU22VpFH2B
	 RYYLUxapRazV8Y3fFD62QhkBSEyx2xkIq7KXSLtmGtn/mChnRmBHvEeS+SKlaYyZqTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7zqySAa;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB8606A891
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDB8606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7zqySAa
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-702fd86d674so281644eaf.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794959853; x=1795564653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3OTBwL+TyzHGc36tg10hWnQr6i2w3v45IA4aHIlkR8=;
        b=u7zqySAaeYlhQpUqV32/X9eVu1RKlum8oNRsvTE0fE9E/aFMffn73Sjoe6uqQ+UtF6
         kFw4KN7mtWw7vryJ8J2BaTVqAinedz5zMu6sBZJux61Y73pSxtRTi2UVibzBDM07DXut
         zQDVi8UZ8hNSRxTub8QfrDLw6lhXILUFeJl9c/rooB1T1Z32GdUzCVlWmA9B6GzU+WLH
         FCe5awUUR1fFU7u/bKBu+Zb0rfEqOR0Hg5KrzgwNbQ58CP4ZiBGle/c+Itb7dkxBoGEE
         tWX1+5H46LnaqccEfkZ5MRv9NaFp9blwOAN8sSC7xlw+fTHzL491r8VuA47VelVm7Mvb
         KYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794959853; x=1795564653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q3OTBwL+TyzHGc36tg10hWnQr6i2w3v45IA4aHIlkR8=;
        b=mhgl87cMzXpXQrtk1izgGNZsu8i8c16ZyB9tweJ05W6chP4Chitnn4y02IYMGCy62L
         p+HHRr+jjTflaEiDorA8RYeVj3QqTdzIGqIlX5ELgl2kD+1JuEAAB3b96oavWrzdpwvV
         mW10sI7NpnXIZcZUtD/Ffu9hcKkFS6qaKLarxiOLjSmHmAIUery5mvm8x23h5zaqAUDt
         m7asZF8QR4EPsIwmF9TK/34BFbUhxLaF5Quzfq6XSmbUY0+nFDb90TDrcgeM7ilOjENk
         6e9frROtKmNN5zt8iuffTzBZAVkt8LJDZ8FbrwXgVhV3ANSgX7NeVGUDMu1eSiebvn92
         BodQ==
X-Forwarded-Encrypted: i=1; AL+hErHeyiy0h1REfctPgLCCJEocyBQTurvZMulbwq6z4BFNeeXflOGmWEseWkTi2dBohFlz7BAxmJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tb1RIMhEHmKKOg1MTNfRnfwfbiVAZ3LYrWXNhsaHulqMLaRyp
	JFrYb7ChM9XugqkEHRRPJ/uY5HDoJkE0bixQcER1HRqTfjnU8GYxn+c5
X-Gm-Gg: AYBFou1SDwnrnXcGr7p8/jVp2w7w11bd7MzqnCCD4Z7+nLJ/NkE06Sg+V4PrW/5FnWg
	kbDrmsR7CuHVDRCoPsHep5FYxffrCPXYyMg09cwXRLmTHjKasJNNlYzS9yBKL2yJ+oxGJtOmyQS
	SiilFuYg8U3gJw3O+QUf6K8xnt9Crkua3k6EZZSChfubkSYZrhPahh0GpaaYuhriThMx506M4n8
	028mTYYpBLgAFqsOaG6WPDvPrBugJZ4adNm2PSSxnV5WsVdjqE02o7b6/ya9x3B5yLnXQ2L/ufG
	pmGJLCvbitGlBvfAs9s66PXuBqM4smhRvQc+6RErAKuRM160INCEl+5X5XACAaX4NvTn5v3TgZd
	ZtIXn/ROBj+lPCxkJPGyPqXQD9DHpya2aALmiBzYmwNOGevxBTdlDHX8xHaOKYmTJVoYvrSYzND
	DXPfK79A7xCMx3fUXHxorbMOWbnvmCUkKpLg+O0uDUoljahjt/j3R9e8N2tEtY2Hdvzex67HnXt
	oosF4v9Zu77JNnYQPYho71Gw5QeAvOzwndVWQmt3dHaR0A+AoblfLugcJTEMlrUZA8uudnVeWyy
	ILIqAgeWuzy/zArx5TYVY3b1RNg7IoxxvA3Ei6EFnKQKLJo9gkFNEBaXLKkJ
X-Received: by 2002:a05:6820:1c8c:b0:71a:e1a9:4b74 with SMTP id 006d021491bc7-71b1859452cmr762291eaf.72.1794959853612;
        Tue, 17 Nov 2026 15:57:33 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b1945800asm648215eaf.5.2026.11.17.15.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:57:33 -0800 (PST)
Date: Tue, 17 Nov 2026 15:57:31 -0800
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memcg: fix zero throttle delay on 32-bit kernels
Message-ID: <avznwfoMxq9s2NwC@devbig011.atn3.facebook.com>
Mail-Followup-To: Hui Zhu <hui.zhu@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
References: <cover.1794902513.git.zhuhui@kylinos.cn>
 <6931674296b98139f5e02821d66ad1855eba36c9.1794902513.git.zhuhui@kylinos.cn>
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
In-Reply-To: <6931674296b98139f5e02821d66ad1855eba36c9.1794902513.git.zhuhui@kylinos.cn>

On Tue, Nov 17, 2026 at 04:04:20PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>

Hello, thanks for the patch.

> calculate_high_delay() stores max_overage * max_overage * HZ, computed as
> u64, into an unsigned long before shifting it right by 34 bits in total.
> On 32-bit kernels the store truncates the value first, so the shift always
> yields zero. Tasks over memory.high or memory.swap.high are then never
> throttled, and the reclaim retry loop in __mem_cgroup_handle_over_high()
> is skipped as well.
> 
> Keep the intermediate in u64 so the shifts see the full width, and clamp
> to MEMCG_MAX_HIGH_DELAY_JIFFIES before narrowing to the unsigned long
> return value: a truncated result would escape the caller's own min().
> Nothing changes on 64-bit kernels, where clamping each term is equivalent
> to clamping their sum, which the caller already does.
> 
> Fixes: e26733e0d0ec ("mm, memcg: throttle allocators based on ancestral memory.high")

Is this the right fixes tag? That one doesn't introduce the division by
MEMCG_CHARGE_BATCH.

> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>  mm/memcontrol.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 84f4a8fd4d16..1ba42724ed1e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2576,7 +2576,7 @@ static u64 swap_find_max_overage(struct mem_cgroup *memcg)
>  static unsigned long calculate_high_delay(unsigned int nr_pages,
>  					  u64 max_overage)
>  {
> -	unsigned long penalty_jiffies;
> +	u64 penalty_jiffies;
>  
>  	if (!max_overage)
>  		return 0;
> @@ -2601,7 +2601,13 @@ static unsigned long calculate_high_delay(unsigned int nr_pages,
>  	 * MEMCG_CHARGE_BATCH pages is nominal, so work out how much smaller or
>  	 * larger the current charge patch is than that.
>  	 */
> -	return penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
> +	penalty_jiffies = penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
> +
> +	/*
> +	 * Clamp before narrowing to unsigned long: a truncated return value
> +	 * would escape the caller's min() and look like a small delay.
> +	 */


I think this is a bit verbose for what is happening here.
Why not:

return min_t(u64, penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH,
	     MEMCG_MAX_HIGH_DELAY_JIFFIES);

Or just dropping the comment block seems fine. I think folks should be
familiar enough with values wrapping around.

Thanks, have a great day!
Joshua

> +	return min_t(u64, penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
>  }
>  
>  /*
> -- 
> 2.53.0
> 
> 
