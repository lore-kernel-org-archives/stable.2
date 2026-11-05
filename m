Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870968;
	b=SaODe5p4XteQNQNQ0dHtbU0j3tzd+88PknhdM9bEzbjsndPmKzCR+ZnFRegEz9ka9iD5
	 JwBkMkqUchxG3vXGbTdCr63Ypsmd09AZc34NyIv+GgFFMj+ueDKTGqc70kaE9ZKpOhp9h
	 xtkeJIPktHoqLDOCvhPFov58BYaSDXI8xlZxtQthP7OM5XRKnkNdMBGXq8b87S8kNhdRE
	 PRVfTGJK1cfF2u1pkcojnjcy2iqjhE4z+Oij7Z6CpSTkeGs4NH/WJp5byy6erPee3PWz9
	 7/tgis/qt2NQ3L0Sn7GkUqbSDCJlQ2WDM78R7Zj4n/880durHNeRYXVzroqM94ZpErQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870968;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JFCU0FbtSuC2D7iPyi82SNxybv9/1CahXus+XyLTnc4=;
	b=Oq2YyPszESjFRNj+HWCDoCONCFu0XL4H4YfE6sWVS/3cIg4cMElPVHSwNKfTqVfuPswx
	 6YHgboVmp4azuptdJuXL/lcOTlrY8/HluLqfQMyOpD2Il0swAo9KX8ovgIRo6aPSPK/fm
	 7ds4yn/DBpD6lTmfSNsW4hVPPE87vAOs1DaMNN7JXCwrgaCBE1cXBLiNqUwy+PKYvejsj
	 dgucwvgxDRQMjhjiupYcQVhNdobRsaQajMU7Eej/r5U9VOSEW2juFpcsqav8e/Cdc6BNI
	 kRXGlI/7JtWkEVyh75L7ZWFKl4SLHzxD1okRkZDcPi1JuWTJUjAOzecZrx4Z4zJijFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpbPfdgW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88ED606A326;
	Thu,  5 Nov 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TpbPfdgW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A6C1F000C1;
	Thu,  5 Nov 2026 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870967;
	bh=JFCU0FbtSuC2D7iPyi82SNxybv9/1CahXus+XyLTnc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TpbPfdgWbH6gGD1XVstA3oJT7b5CDkZRmfmPvVlwNVz4gi1txWb4MKNvOd82hHgzx
	 M5n8Hmb/YE7vOWlwMKHpqWHPpRRa9p7m0CXdDzdArFmMwW8329BlYcDhHpVfpkbf9t
	 XsDszlEngFjzmH/tsneOFgvuRQ0B4NUL7WOT0fTxGOXmR0Y8sateaDFB1Uvp7/riDW
	 cpyHu51t9NjfjbOmkgb/P/0Cj+GSqjjP+yqXVo0GINez7r4zd34ot8676o2QweXQhB
	 O/isZNK0GboRZ8H9gaLSOhM8H/HMh1YB+Eyum/mnnJ6C5UeIf/aN47XVz+8g59wzdS
	 YcSuMUyFfZUIQ==
Date: Thu, 5 Nov 2026 10:29:22 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
	akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86: hugetlb: disable default CMA reservations on
 32-bit kernel
Message-ID: <auxMctmYZTTwtRRJ@localhost.localdomain>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <ece5aebe95f6565046d17ffb738670feb3202943.1793850539.git.zhengqi.arch@bytedance.com>
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
In-Reply-To: <ece5aebe95f6565046d17ffb738670feb3202943.1793850539.git.zhengqi.arch@bytedance.com>

On Thu, Nov 05, 2026 at 12:07:43PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> A 32-bit x86 kernel can run on a 64-bit-capable CPU advertising GBPAGES.
> arch_hugetlb_cma_order() checks only this feature and returns a nonzero
> order, although gigantic HugeTLB support on x86 requires CONFIG_X86_64.
> Specifying hugetlb_cma= can therefore reserve a CMA area that cannot
> serve the intended gigantic HugeTLB allocations.
> 
> On non-PAE kernels, the folded PUD_SHIFT yields a 4 MiB order, which is
> equal to MAX_PAGE_ORDER. With CONFIG_DEBUG_VM enabled, this triggers the
> VM_WARN_ON(order <= MAX_PAGE_ORDER) check in hugetlb_cma_reserve(),
> warning that hugetlb_cma is attempting to reserve a non-gigantic order.
> 
> Require CONFIG_X86_64 as well as GBPAGES when selecting the default CMA
> order to avoid these ineffective reservations.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/x86/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 3b26621c91286..70726a99ede7b 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -45,7 +45,7 @@ arch_initcall(gigantic_pages_init);
>  
>  unsigned int __init arch_hugetlb_cma_order(void)
>  {
> -	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> +	if (IS_ENABLED(CONFIG_X86_64) && boot_cpu_has(X86_FEATURE_GBPAGES))
>  		return PUD_SHIFT - PAGE_SHIFT;
>  
>  	return 0;
> -- 
> 2.54.0
> 

-- 
Oscar Salvador
SUSE Labs
