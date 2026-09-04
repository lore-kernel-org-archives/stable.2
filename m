Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201650C2B7
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542057; cv=none; b=YcJ/86SBABKwzp6lXWfuhDb9klCtbHSkJKLRFvJ77hbRXP0AkUdCUfjZZ9OEH6IP8nOUSPt3Z0jJIS1YbLMtvGX7zjyw32682f+3lHw6QfZMj31jnYsU8nYKKDK828eMWj8rCbHRX2LQNu2oCeg9xSa+63zpKjYMbXpQ+/tRg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542057; c=relaxed/simple;
	bh=Czx++Bv+Cuv0Yiguw7eimQMoiXbfQDnkXg54do1X9Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/xta14rZ2zAAUapli2LKUiOW9GWErTBtB925fjOIxzFpW2XM2D9SVJs8LFNjXXUk403d//93lWvyTQKFvVYYPhBzZE+s+enugwzHvnDUsVg6J18sPetJN0oxhZ8a3LfkvMVDpV5yMdPWnppc2J/Z9uy6a9+O0bR6gB1+clhEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA+Xf4Ke; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA+Xf4Ke"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a40bcc8d69so1006825b6e.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542054; x=1789146854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjaqkPTnppiQ9iMiGEGM/pFHCNqFkiCYfaf94LCABdI=;
        b=IA+Xf4Ke7yec0AIxUsK86Lf/HgH6X20gDMkNlXcoLsoMAsNgsmvV6IsmailKeRVFcs
         04AB7G2MJHiMXMQVyK4kGob1Y2ck9cL1VrB7wLuRcxcU6YNVUIsEtWwYZF574412KGZX
         ZDaRhrsusJK0miESVxaqDAdHCNiUBdRDnZotkC1tZXptTwet4inkf+TSpmlYDkG4RHYd
         X/PD5PDhSexfBI5QcVviDXo7bC10/B0PORVpPVb0pPq3PSFKvvgAFjLKhg0LaUiwJ2e1
         lsLVf2dpbPRikKZMPOOtLPc8keDCR7HjcRZVcl3r33hz3dIsga/BfuEG3XeDSii5oZWP
         1IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542054; x=1789146854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjaqkPTnppiQ9iMiGEGM/pFHCNqFkiCYfaf94LCABdI=;
        b=fB4FAkbmD3z5VUr1Haw+fczuD+BNlOxx8CRUHZ1PpQtIeaIAIJJczc8C8qR5x0Wssz
         BepG53k34Y1rQv+ZOJ5z8NFh0xkFn8IVfKtvKroSpJiwaMmj23rRQCyBZLUjzjU3wC8O
         QqtmFvx4fk+aHD3V1HtKs+E8PD6jhXGunWbgyAZefZ+9sYS9OCVfI4tu4RLhXe6JuBOx
         GI6tFuLfdFlxnAE3j8ZPZdGqiP0xLQTAuRfCUqoN5vyqE+J7oFpPYoXr9gIlzxQCyJ0d
         633o6zB+5ssuxwSiF/F2bTurpkknYXVHNwFNe99dgLf55hIhvtOtaJ8LrcFaxgt1pw/x
         aqeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6MqKnhyXZEHUEpnSk8uq8t/U24WQN9odp3sAyK+xwM2tJprbo2Mn+AisJ71JO9f+Re/jP4T0=@vger.kernel.org
X-Gm-Message-State: AFuF++nEvkadht1I65qWawOloIHM1ZM+E6yVp9nX6nJX9t8deVFwvpvF
	4C8C3e1lRbYPepV6x+/GjqX9UWk62wyY9KqGU3HaWB6NTh7SXkenhq/P
X-Gm-Gg: AYBFou2FNL0svdVQ84hUC3nV3tD3RNe1a/7emy83OeHN3jpqFuFR9aPm4aYY29nILyL
	Hp7fk7T2istckRB1Q25UOb/W16LRy90azExMo81YIxf7FZoPaeHwomXj8U377A4e64+aQ/UwLq8
	OHPRI2RDHQQNzLwjCpBcLW6b6n0XFcJKDbaBk5L8xG5rd8DR8JZqLWPnSDFou4d0nCZ45TAETdu
	kmcKopK+U/4w23l7ayNWKEWKbvcmeC8J/deMiw5YlgYMItDFqj8QtVUD7FKZMeNg5dV28M1zZvd
	SpVA1a+l5pXBUGzlTWT+sVkCMZOXkDQ2OWGDLwGx2e3eGnHQPHxPEqS72Ajdjlogmfc9hzDsEjx
	VLW7LnoKsrI2U+ePkKkDw6b0h/HsHwzizmANKWtd1hMvbhzkuBFQI+gl1IE++IuAS7xrriYRONd
	SkCmxmQDDK+3HQIHy7f/2ar5pFF017JcAiNo3hLqeQ+aa6ufbOtUEJJ2+c6iBSq7NN01YShXk/V
	Zm8eugJeOp0kwNDcA==
X-Received: by 2002:a05:6808:13c1:b0:496:11f1:f2ad with SMTP id 5614622812f47-4b95f94794cmr7013081b6e.6.1788542054195;
        Fri, 04 Sep 2026 10:14:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971675a96sm2865607b6e.11.2026.09.04.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:14:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Alex Shi <alexs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hongxiang Lou <louhongxiang@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	jthoughton@google.com,
	fvdl@google.com,
	rientjes@google.com,
	vannapurve@google.com,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ackerley Tng <ackerleytng@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: hugetlb: Return -ENOSPC on memcg charge failure
Date: Fri,  4 Sep 2026 10:14:11 -0700
Message-ID: <20260904171412.191180-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-1-e3e8942c141b@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 01:22:56 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

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

Hi Ackerley,

I hope you are doing well! IIRC, this is the same fix as the one in
[1] (in spirit) right? 

I prefer this change since it is more obvious that we return
-ENOSPC right there and then. Since this is a fix please feel free to
add:

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  mm/hugetlb.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7857728457952..01b57f6d3b804 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2823,7 +2823,6 @@ void wait_for_freed_hugetlb_folios(void)
>   *
>   * Return: A pointer to the allocated folio, or an ERR_PTR on failure.
>   *         -ENOSPC if cgroup charging fails or no folio is available.
> - *         -ENOMEM if mem cgroup charging fails.
>   */
>  struct folio *hugetlb_alloc_folio(struct hstate *h,
>  		struct mempolicy_interpreted *mpoli, u8 alloc_flags)
> @@ -2896,7 +2895,18 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
>  		 * were committed to the folio and freeing the folio
>  		 * would have cleared those up.
>  		 */
> -		return ERR_PTR(ret);
> +		/*
> +		 * Return -ENOSPC when this function fails to allocate
> +		 * or charge a huge page. If a standard (PAGE_SIZE)
> +		 * page allocation fails, the OOM killer is given a
> +		 * chance to run, which may resolve the failure on
> +		 * retry. However, for HugeTLB allocations, the OOM
> +		 * killer is not triggered.  Returning -ENOMEM (or
> +		 * anything resulting in VM_FAULT_OOM) would leak to
> +		 * the #PF handler, causing it to loop indefinitely
> +		 * retrying the fault.
> +		 */

NIT: I do feel like this comment block is a bit verbose, though. We just
want to explain why we return -ENOSPC rather than -ENOMEM, maybe we can
just explain that OOM killer not triggered --> retrying is futile?

The change itself looks good though : -) and I don't want to block the
fix. We can change the comment later.

> +		return ERR_PTR(-ENOSPC);
>  	}
>  
>  	return folio;
> 
> -- 
> 2.55.0.970.g62bdec98f9-goog

[1] https://lore.kernel.org/linux-mm/20260720-hugetlb-alloc-failure-fixes-v3-2-7d2a169aa9ee@google.com/
