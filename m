Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1F48E0D3
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010259; cv=none; b=hv3SEv1evzKCHTpA3NDglD0erQ8MSTA2c9xyTQn1APR4Q8n7/S0QfFGIIp07NCNDqtMbTEoIRDnb/huQdqGLaAqwWTT0mY6DWbv5kZAQJDEL7GoMvwOTrOL0uqX1Ap+3ahj72NmxAOk3HkFz+OgTv0H7PRuT1lvspaPaKZA76B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010259; c=relaxed/simple;
	bh=blewOPL1WdzK1u7y222FjCGpK1+bj18fRPdMFtJmPcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTPi6bH4IkGuNDJt4qodwuH4OTbe3q1Dv7zzp1QJZw8Q47UwNywBZ8sQJHSy4fe+JWH6sbNKD+06aP8YAIC3fbDOZTVpzw3AgT2sxxMRn6FRCx+4nGuwBhVUqkevR9rSxi0xikk5TXQbXsqmjA/Ka5OiE5MWeOlD5DsqSMcZnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=qSI7O4Ri; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="qSI7O4Ri"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so479966785a.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1792010254; x=1792615054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8jmkZ2iZY8eFbnVPoRrHfgWIjC40ttpxwtqJ35UT++4=;
        b=qSI7O4RipAsTLh3r89x9I+EEDIwhkIS4gCd6e6ks/W7gjMsK/OtxuphTOHHVmttbXC
         TcXgZdOhY15q28Y/dnf49NZRYzBRJQ1eZVVDx93Nr/y4DhdCsu/qxutd75c1TCssnImu
         gG/6OybINTmp/qBKDx/aafgi5anr/rqo3EnlUqKinO2Q1fXrSFpazHjZRDtyPHuYPLXH
         NnYhZj0CEVW/a566eaRyQLIq4pnZFt5gqv+X/ptUiUTW5bzAxa7/45X2UFN/J/9dO8Cn
         DZluzhj2ij5HTf8VSeDRAWwFdwOhuWFXBHQKT3GPI2hspsyHpueKLbjuwsKeulmRdkOh
         CR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010254; x=1792615054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jmkZ2iZY8eFbnVPoRrHfgWIjC40ttpxwtqJ35UT++4=;
        b=gRMKUHAY1nM29stDp63EezkcRmzRORq8Q3L9NhPcGwHfhF/c0BOjrU/kOKaaqVZUxn
         V6dONy3FUFw/aIfyEA1ySZCQigaRY8yaLPSlkxCRsTxwak879C6ADzGSgKZB5b+j4xjI
         f0y/DKG8i+KAwS0q8e3OB2+3xyWXhVwQI9xOJi6IQPT2cTwmQsghhM6oFWd5Zn54d++Y
         Nqlo5DlksWVJ7jinMVnCIOBGWARHOxju/sre/CKjSIJE05BZVKuR0J7PWzAjFhIeu8BC
         C2SFpk+zFfzUOd3O0UProawZjWlv/Nc264PaF3vkBXk+H70OsW25Py8UpTPyypW/Z3cD
         uZiw==
X-Forwarded-Encrypted: i=1; AKwUvBzkyUIg/Qg04+1eK2o45Dqu3zsjjadcLW1slyWnkgUVEkp4ek2ivtWnF4ciNwLf0KcWa3JiCr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOgE3JI7zNtcdKnYw1j05eDDfzp4YYbnZKIm5cOTUQDBOvdvxn
	U1dwiUDXX+zNNlfJfYLYck0TSzS7gqBijYqReCpNLTpmACcE2hj3P5OANKnmHURloMM=
X-Gm-Gg: AYBFou1+YZCKLLih33cuuovvLdZqH8U70OmxEvyw0JzekSX6gupU70cS2/LJpQ/4sE5
	AMoD/ueOfPkQ6QVW8sVBds6wwKk4m+iBhcWei1m6cKEB5SmeIIZz6vQfTgrG2zQztn/TishKDMJ
	rHOL3KdcQm9ZHg7Ao0S5KC8AMypNEXXNTFBpNFo+AGNfo4ID6ygb01bUcFsJgIv/HrWyPjXfstg
	Grj9kYH1d5i2U0Y+fFffg7VsdGe6ZR8W/BWTy0QLtPowAUnlfTjqOaRIFo4TLdITgI6fgZSGIcz
	YWrYon8X2FVMayeOiTSLJoZMhKjaVA3/Mgl7NuPAqLx1GLD4zYKtinRfgazpyQ78gDwvFAQ8Ydn
	kht55IjY9qMTvxBXkB5hw2qv4RteoQHJ7w5XeWL5EdfeVNq/AxU8BcjXRZ/TV3BqF6rOFhE7ana
	uFpIHALYJOgL1YHZ530WnyoMVqC6rDeo+6Op7A9YwxRJ8OxL3HxmnUUtr7FdMZhnYPwL/t
X-Received: by 2002:a05:620a:3188:b0:93c:7fab:c44e with SMTP id af79cd13be357-93ebd272a0dmr2741779785a.63.1792010254517;
        Wed, 14 Oct 2026 13:37:34 -0700 (PDT)
Received: from localhost ([2603:7001:f100:5081:9526:3c0:45cc:5ac6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef505463esm576153585a.32.2026.10.14.13.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:37:33 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:37:32 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm/page_alloc: count guard pages as free again
 when their buddy merges
Message-ID: <20261014203732.GG371161@cmpxchg.org>
References: <20261007021250.1665929-1-riel@surriel.com>
 <20261007021250.1665929-2-riel@surriel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007021250.1665929-2-riel@surriel.com>

On Tue, Oct 06, 2026 at 10:12:46PM -0400, Rik van Riel wrote:
> With debug_guardpage_minorder set, expand() turns the unused halves of a
> split into guard pages, which page_del_and_expand() leaves out of the free
> counts. Freeing the allocated half credits only that half, and
> __free_one_page() then merges the guard buddy with clear_page_guard(),
> which no longer touches the counters.
> 
> The merged block goes on a free list with the guard pages never counted,
> so NR_FREE_PAGES falls behind the free lists by every guard that merges.
> Before commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting"), __set_page_guard() and __clear_page_guard() adjusted the
> counts themselves; that commit dropped both adjustments but kept the
> subtraction implicit in expand().
> 
> Count the guard pages under the merged block's migratetype when the
> buddy is cleared. account_freepages() skips an isolated block as it does
> for every other free page, and moving the block off the isolated list
> counts it then.
> 
> Booting a 16GB VM with debug_pagealloc=on debug_guardpage_minorder=1,
> check the difference in free pages reported between /proc/vmstat
> and /proc/buddyinfo.
> 
> At three points (idle, after a read and file-creation load, after
> a second load), check the difference between nr_free_pages and the
> buddyinfo numbers in the normal zone, as a number of pages:
> 
>                 idle   after load   after second load
>     unpatched   -130        79205               99121
>     patched      -16           45                   0
> 
> The small remaining difference seems to be due to the numbers
> not being read at exactly the same time, and is also seen
> without guard pages.
> 
> Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rik van Riel <riel@surriel.com>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>

This should probably be not RFC?
