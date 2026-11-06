Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944252;
	b=u6c8E7CmwoX648lWEN3H/qpGrM0DMSystz2VNCoUo5I9DzskbZj/E+VO61+tlcC1K/2d
	 G8lq7i1hGuelrYBpfNAy+dc3U4wPtXJF3/7WRcINKKqP6OpymzUha69T20HDeynaKVoVz
	 eXhrAWy0XdjDFX+PZIlvAialUnmNCTuWVK05CjAoBWmJ/IeRpopIQMC6GRmQLGeX8F2pi
	 FjTmiPTgJigCybLy+fvCiATiNp/zv4YzaMybRJ0m3vqAjTl0IbexQBR9Os3DjmSYD1hxl
	 DYABV57pOquktDl1/WReEvpR/uSdVLc+416L+oxQScb/j2pBVApP3Szjg2G8ADurTcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944252;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vkwduMqYAfdl/KfY8u0XGrj5UOL1s9uwI783UTJT08A=;
	b=usNznIdvRGw5SGNe5+F26ISpAlk8nLD5YfZppD6NB2IVqpcUWdnV9o+4gITh5VOaIQEt
	 h+KNXyoFUmfnZC7M94H7X2cFz1ZgtVCfZ5IHLbUqglH0Y4fU2hvIldaKlmQn4S78VXcXm
	 trbNxdXR12dtzmbvjpBKeWXazzcfamZr3nkBc3G+cQCrz2IhTKaSM8g61FaIJjX8T5srO
	 Kg0ussGV5DunQo94ACSYkfOCATk56w3nFOfGpHB2jeugjoHfxZItNqTcTsiW5nFCYQphh
	 RuD0w80/amoeCk2QHfAljRcfErWWE3uuUra20DcsNtEcAz+v2cuV7GLsi8Mg8MrRKjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZBEJp8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6A606A32D;
	Fri,  6 Nov 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZBEJp8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EF01F0089F;
	Fri,  6 Nov 2026 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793944251;
	bh=vkwduMqYAfdl/KfY8u0XGrj5UOL1s9uwI783UTJT08A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jZBEJp8Se8g0VR3BMOOsKQtTVxEIf2NFDuWpyMLHOJ4vGIK8goi4b9D6rZvYe5hLj
	 XltKVv3P8zfDRQk2qnEPO0rBcnYOovctdU1/zwewB/qF8iRd/Guyoj4WKOT3jTfVJc
	 y8BJvUMAShufXs5FgNC780uJlG7h5wx4DVL3ZzN3Hsa4LQdrYChEjukuKNLNban7/1
	 PNrYAuE378GXIMExAUJvSrBuSpVk5wcdLAVnDIodD8UskiyvHUzuaUwV9M41twCJX1
	 CJJYPHcB0SCGD+qbxz+nqVuAqbaCqUhHPKIfwlUSNxE8kjuXWE3JIPU51WWQ05uwCG
	 tHx2XTBqcRPUg==
Date: Fri, 6 Nov 2026 06:50:45 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
	akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 3/4] mm: hugetlb: fix GFP mask propagation to CMA
Message-ID: <au1qtSMDpimURGuq@localhost.localdomain>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
 <auxTwrKCeg7a3hfY@localhost.localdomain>
 <1535887c-6be2-4415-b54e-2008e6e7a35c@linux.dev>
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
In-Reply-To: <1535887c-6be2-4415-b54e-2008e6e7a35c@linux.dev>

On Fri, Nov 06, 2026 at 10:43:53AM +0800, Qi Zheng wrote:
> I'd still prefer to keep __GFP_COMP so that
> cma_alloc_frozen_compound() itself guarantees compound allocation,
> without requiring callers to supply the flag.

Well, but aren't all callers hugetlb? And we already do supply __GFP_COMP there
for evident reasons.
And should that not be the case, and you want to catch someone who went rogue,
I would just place a WARN_ON_ONCE to catch it here, so we know who is not following
the rules.

Makes sense?
 

-- 
Oscar Salvador
SUSE Labs
