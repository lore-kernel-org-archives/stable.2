Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586A397E8B
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624708; cv=none; b=Tr8MqcB7dGfPNaKlViAG2FsxjiAZjNPRSQ7m/bEBOH6Ukw/texgIMQje3QpMGjECAFPyL9bKwQXDF4F9keCNhv76GV/xbmI8/zz+h8X+3hvkXmQ0zDr50ZJ8EvHv9lSk5zW/EH1ACerkwwjozy33HZFhqsDb03uwfoUVnDcB+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624708; c=relaxed/simple;
	bh=ritO5l+XD1Zkmzzc0cVAeUIZ+AMxMldftnVPIBQJRRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZWxopj0UpqtCo+9zvxmeySjGI28p5U5nQ7O7MabqW7hmlQJOkTG+9dSV/wqL+cLIELDaGMHJOSuyXqCRjKdILGFq2jeRw2SCnGnjveCZPWLno6fRIze/u2JhMz/gLrTHMONDZhHkVYMmfIheTssMYhSgA2V4xpDaPAu0+K9sWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZWlH/wm; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZWlH/wm"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb63dbd229so128736a34.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624706; x=1784229506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lZy5V414EOn9MhK1F1xbwGGbvkcelbw9AoBZCDSoa0=;
        b=LZWlH/wmYxFtO5gw3R2MgIP0VfzRdp0oxmi5kwIy0R+NDzu3aosQhhIw1eEVADDia1
         rp62yjqmLnKK71IkmI2Ae1qf8sUvrY9XTrVHsLuJ5vFMsLWrrOaTjWPzPYBIhSWmaiIJ
         eaU2OKIqCeqwIvqlMsNbN/5GEuYK1MqjHy3YF0fi4KXcOg/nVgeGlOxV6A3vZsNj+lot
         AFNG220o8385BBeKVyL16KKrWvo2tV6Ka8L2t+MTWbBfW+XMZB1s/QU+6zSXG/jRcylv
         l/b9y/CVijg4AXwJWBRhQms6uQHGMEmbWEr8Z1CmM2YkPbVm54s1wCPSZkoSnTwR58VR
         DwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624706; x=1784229506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4lZy5V414EOn9MhK1F1xbwGGbvkcelbw9AoBZCDSoa0=;
        b=PuKtuaMGDrrkzhaOnn+BIUz17KGxf+yTLB6xA25R1xwrHbQxLqPH/tEK69/2sj9pcz
         Uk3J4dTKGXv1N/pfC2fwH0kdIVj5VH8HUeGXDQXnLCK0fXaJke5lqjkaDR4fnLyjRdpi
         mITMT2+5cG+dTIA6gOSp56Gs7mPfkCmfV6mNXCXSt+4FVhgroIpkAtv4rRiXDDz+268p
         r605lG0IQ9/IwSRn/qVL4p8pJWVYF0/AAnXhT3rhXT3tFTqvFPdOy1JfhQ1hO9BXeN6c
         /QgtZJPQRnVjNr4LiL8jYCOZxemsujRy4bbWtQsAyr/HH5ho6JWt+zhVgXeYzvekKfgT
         Aepw==
X-Forwarded-Encrypted: i=1; AFNElJ8TX1M+29ctzrj+RWMYSDmAtNJI+h0xV42cNKNSsZLoRXNk+2Pn0M/i73OEq9/vyJLvuMPqpDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSNZm5LbCHlWW4aq+YhCDqlMdNEcLLMjWQkUZ3egtPeHdQWVs
	NLYrcWAu6zqiwtbpV8dgezefYQBNHDb0FR1M1B5g+8k2RtD/wUYT4rGRbn1kWw==
X-Gm-Gg: AfdE7cnv5L5JpiZLTC6qmxRQ2j0OzsZycMz9Tix8xEdJqRqmYp5mincFz1MWmHP22+/
	RsS7UaM2eQnhJpNgkxrAfxqa5z1HdrkbDAu0/2HNiu4MRel5MJmcO6KqO3lSIjL7h93a4B+AX58
	ExFx5JISY7rkh3IfzJgFJLnvsExs1VaaXiJKL+qqY+WRpvBxLlQBjAuTuIbtz1kGsxukcGSs+sq
	sPOgIaz29EipB5bvGmx066J6f8S9zTevfOPl+oZ9bIB1FCQ/dVMbSH4j3PKxD+D2CMH8tTq7adC
	+PF/cNBqShQvxnMPqLAFpMd0NFOkdyl1+pO+BkgA/PBeT7alESWlpgvjMdsOW4Wip8UnB7JivRg
	+7BckfioFcN/n2Ms+8xJiuY0RMzrhWXaZ+/5auTSErJkZmPam8xAePzxpUQWSaFGRu9HCpE1N2E
	0q8jzWk481+Cuc03fLYk02j0JsZb8kEgHx/0RdEDk0nbI=
X-Received: by 2002:a05:6830:26d:b0:7e9:e288:5d45 with SMTP id 46e09a7af769-7ebf291f688mr262898a34.18.1783624706057;
        Thu, 09 Jul 2026 12:18:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2631dfsm4741295a34.13.2026.07.09.12.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:18:25 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	fvdl@google.com,
	rientjes@google.com,
	jthoughton@google.com,
	vannapurve@google.com,
	erdemaktas@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ackerley Tng <ackerleytng@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: hugetlb: Return -ENOSPC on memcg charge failure
Date: Thu,  9 Jul 2026 12:18:22 -0700
Message-ID: <20260709191823.2180602-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-4-c7f27cbb462b@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 15:12:52 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

> From: Ackerley Tng <ackerleytng@google.com>
> 
> When mem_cgroup_charge_hugetlb() fails with -ENOMEM, alloc_hugetlb_folio()
> currently propagates this error. This results in the page fault handler
> returning VM_FAULT_OOM.
> 
> Because HugeTLB allocations are high-order and use __GFP_RETRY_MAYFAIL,
> they bypass the OOM killer. Returning VM_FAULT_OOM to the #PF handler
> without triggering the OOM killer (or having it make progress) leads to
> an infinite loop of retrying the fault.
> 
> Avoid this loop by returning -ENOSPC when charging fails, which maps to
> VM_FAULT_SIGBUS, terminating the process cleanly.
> 
> Make mem_cgroup_charge_hugetlb() fault handling use a common error handling
> path, the same handling used for hugetlb_cgroup_uncharge_cgroup{,_rsvd}(),
> which also don't trigger the OOM killer and hence opt to terminate the
> process with a SIGBUS.
> 
> Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
> Cc: stable@vger.kernel.org

Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> ---
>  mm/hugetlb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f3f4b964b153..3e1d99f03c70e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2991,7 +2991,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  
>  	if (ret == -ENOMEM) {
>  		folio_put(folio);
> -		return ERR_PTR(-ENOMEM);
> +		goto err;
>  	}
>  
>  	return folio;
> @@ -3014,6 +3014,17 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  out_end_reservation:
>  	if (map_chg != MAP_CHG_ENFORCED)
>  		vma_end_reservation(h, vma, addr);

NIT: is there a reason why the comment block below doesn't go all the
way up to 80 columns? I also think that we can achieve the same effect
with a shorter comment block : -) I think the essence is to answer
"Why -ENOSPC and not -ENOMEM?"

> +err:
> +	/*
> +	 * Return -ENOSPC when this function fails to allocate or
> +	 * charge a huge page. If a standard (PAGE_SIZE) page
> +	 * allocation fails, the OOM killer is given a chance to run,
> +	 * which may resolve the failure on retry. However, for
> +	 * HugeTLB allocations, the OOM killer is not triggered.
> +	 * Returning -ENOMEM (or anything resulting in VM_FAULT_OOM)
> +	 * would leak to the #PF handler, causing it to loop
> +	 * indefinitely retrying the fault.
> +	 */
>  	return ERR_PTR(-ENOSPC);
>  }

But this fix looks good otherwise and I don't think this a big deal : -)

Thanks Ackerley!
Joshua
