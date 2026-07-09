Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDD4499AD
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623303; cv=none; b=FTptCfMJunYzfZw6wPIAVnX8khaxPUOxMx7jLliYwbAGHnCxrxJbz2J67vSzN9O4E3IG6BIpgqnjQ4XHSuacWiFcjsOa62R5hNwt2m5tseYi4/QNj+j0maK09kGK2yq75yB19w9oUoC8ozS1BydFLz5MHH9bcUqU1GCRfX15wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623303; c=relaxed/simple;
	bh=yEH1Th0SMln4nRxcxBbel/RZvr2c6M5YqAH272qGUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDukVQZvgpliUxGVM8C82TxWzTV6hC/Syj9WX9lKPzuCZbI/PIwA77gpH84lKFQbQNkaWtHFcjVXHZKYWc/QlFi/hTGcrnuA2IuyLuGGm0Nw1CZ9I0V/7yLANyVBl0wMoQTOCtiZwkHho2RMj55Sb1rnxf9gEUxZbTYF3CTgn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8X0I0Uo; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8X0I0Uo"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso175253a34.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623298; x=1784228098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wf2mCygj2V3MtxPOIjhT5RGqf+/9JXlGVheo76S1fao=;
        b=i8X0I0UoR4MJs8iyzeTDh+RnR9NxndvVSYo9xZUgeZY1zBMl8W/HuesVO/cmXMip6P
         hd73orXixvA+vVLz0ySGONIayPxuIBAwCxWLdHofmBv8xlloHyLe+lNrzL1kS2prQZGP
         CI6ywlH27qEkr0a5yuVMF21w4t/JtrguLEXhh8EKr26tH3Ljk8H/5pclbTKXTM/+XhuM
         56bUMM8XYvS466LZ+fb99hdTrGQMjAGQ6JuVsRW0VSucMj10DFS9fu73Lp8bzyi8Tue+
         nLLevn6hqvLV1iWgWQxnQNmecbFKmQJyWlQBATTgopJpFV8H7sm4vjUAWwA0AJBKwUj8
         gTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623298; x=1784228098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wf2mCygj2V3MtxPOIjhT5RGqf+/9JXlGVheo76S1fao=;
        b=rUt9Wv9sGb5P7j8K5Gmr0aUkJF65KetR2E1hYwga6ovFCik5+Q+Vz2h6rAfIZmqI+Z
         LFs8eO/fgOuLJ4VTpKa8rT4rNp5kHNIjhRZHjuzlCRoCEJXwF4MgGhUeNUA0YnREqGUB
         muUn3JLKxOp2TdaITECpnamWPhH3wY1qt9r41dkb6dHH5HyFAEGY/3nWZUSshgR+u/WM
         AyPODXOd+PRper+K9DLYR7yL2NXucZ45YSJNT/lkAPSaxHXY78bJgaziSoPYCdHAshfj
         Angb+OGxClTp0a4sLPyrbmXDFFZITV8ZAzbCk3JNP18u4gJFtLUcLTGOA+JPGoIv5x1f
         FsKA==
X-Forwarded-Encrypted: i=1; AFNElJ+wFu1etbdzSJ86KdcUaYZSP9fxQ4AsXlQMjdHobh2XOa+o4ikfKkhKHQM+QNli01SJLRETZGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dLmUZz4GEGzv8rsRbd93iOg6laHJSK4zyamTNxmZJlvxTnds
	knLld0wjXX9uUV7t80OVo6SKHoBvPGXFeE0XqzXMRnIbwirvnMbgduCv
X-Gm-Gg: AfdE7cmSvMqyIdvOvs3YNpneXCIvOlhiXrmPwhClnm+9ioEQeMHl9uEaZSfJKwMAab4
	9+6lobulOW31ko9RbL4mUxbw3qO0bnjcBWCYrOTyYd11jd1pTlSA+ySL2K5pMd9SF0YfZxDJ3nS
	cwzbXZIsU0APCx/vRMiAB1djdd+p/Y13zCEWpMIhB7QPCAehPN+pnFRAW/DTB/eBnYHOQmIa1Nh
	uhxW0k5NPIUMaCwBXM2E9GNCIycyUhQXoor4vcX+arlB+DlOyy0ZLB/2Sdaq4WVVNXujbMgnSHD
	PgUP3fqXCbMtVeNTzC5RHrZtFYr3Dxqek8LlcVCMWyRXvrC5KqJVSxf8+JNbIt7JzGQtG29bIGj
	nunt1EWAuMMfGRAjWYWRp92ZPjhQGhY7RbjnZ8gocz29uzKVzBca3ymAFYdT4pcoP1uQUtbjXfB
	Q90x07xUb0jVwYS9PE0AFUau7JLgRJV4yZdWqxKhtqOdQ=
X-Received: by 2002:a05:6830:2b08:b0:7e9:b537:102e with SMTP id 46e09a7af769-7ebcff9e14cmr5905427a34.27.1783623298042;
        Thu, 09 Jul 2026 11:54:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2630casm5108633a34.18.2026.07.09.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:54:57 -0700 (PDT)
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
Subject: Re: [PATCH v2 3/5] mm: hugetlb: Fix folio refcount mismatch on memcg charge failure
Date: Thu,  9 Jul 2026 11:54:55 -0700
Message-ID: <20260709185456.1854151-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-3-c7f27cbb462b@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 15:12:51 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

Hi Ackerley, 

Thanks again for the fix. Thank you also for adding the reproducers,
they made testing this really easy for me! : -D

> From: Ackerley Tng <ackerleytng@google.com>
> 
> When mem_cgroup_charge_hugetlb(folio, gfp) returns -ENOMEM, the folio has
> its refcount set to 1 via folio_ref_unfreeze(folio, 1).
> 
> The error path calls free_huge_folio(folio) directly, which expects a
> refcount of 0. Hence, VM_BUG_ON_FOLIO(folio_ref_count(folio), folio) is
> triggered.

So yeah, I built mm-new (with your hugetlb open code series) and ran
reproducer #3, and got the following output:

...
[   23.855813] Call Trace:
[   23.855838]  <TASK>
[   23.855877]  hugetlb_alloc_folio+0x190/0x360
[   23.855930]  alloc_hugetlb_folio+0xf9/0x310
[   23.855972]  hugetlb_no_page+0x590/0xa00
[   23.856016]  hugetlb_fault+0x194/0x770
[   23.856060]  handle_mm_fault+0x29b/0x2c0
[   23.856103]  do_user_addr_fault+0x208/0x6e0
[   23.856146]  exc_page_fault+0x67/0x140
[   23.856191]  asm_exc_page_fault+0x22/0x30
[   23.856234] RIP: 0033:0x401734
...

Running it with your fix, I don't get a kernel crash. So this change
looks good to me, please feel free to add:

Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

But.....

It seems like fixing this bug actually surfaces a different bug.
I don't see a kernel crash anymore, but my kernel gets stuck in a 
different loop:

...
[   42.526726] pagefault_out_of_memory: 120780 callbacks suppressed
[   42.526732] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[   42.526955] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[   42.527084] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[   42.527192] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[   42.527288] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[   42.527382] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[   42.527476] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
...

mem_cgroup_charge_hugetlb() fails
--> hugetlb_alloc_folio() returns ERR_PTR(-ENOMEM)
--> propagated to alloc_hugetlb_folio()
--> hugetlb_no_page converts it to vmf_error(PTR_ERROR(folio))
--> propagates up to the pagefault handler..

But there's no OOM handler to resolve, I think. So it just keeps retrying
the fault and cycling over and over and over again... I think we need
to be returning ENOSPC instead of ENOMEM like the other failure paths
in alloc_hugetlb_folio (or hugetlb_alloc_folio... I think we should
change this name, it's a bit confusing).

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 288535838a48b..05214b1cd491a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2903,7 +2903,7 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
                 * were committed to the folio and freeing the folio
                 * would have cleared those up.
                 */
-               return ERR_PTR(ret);
+               return ERR_PTR(-ENOSPC);
        }

        return folio;

This gives me the following result from your reproducer, which I think
is the expected behavior:

attempting to remount cgroup2 with memory_hugetlb_accounting...
Successfully enabled memory_hugetlb_accounting
Child: Attempting to allocate and touch 2MB hugepage...
Child: mmap succeeded at 0x7f0023600000, touching it now (should trigger fault)...
Parent: Child exited. Cleaning up.
Parent: Child killed by signal 7 (Bus error)
Parent: Child got SIGBUS as expected (if kernel didn't crash).

What do you think? Happy to send it out as a separate fix or feel free
to fold it into your series / fix, whatever you prefer.

Thanks Ackerley!

> Even with CONFIG_DEBUG_VM disabled, returning a folio with refcount 1 to
> the freelist can corrupt allocator state later.
> 
> Use folio_put(folio) instead of free_huge_folio(folio) to properly drop the
> reference before freeing it.
> Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4093c1c0a4a1d..1f3f4b964b153 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2990,7 +2990,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
>  
>  	if (ret == -ENOMEM) {
> -		free_huge_folio(folio);
> +		folio_put(folio);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> 
> -- 
> 2.55.0.795.g602f6c329a-goog

