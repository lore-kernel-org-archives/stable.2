Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8138837A;
	Wed,  9 Sep 2026 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994515; cv=none; b=R/nPztOLi89IbZyzyXbNW6ok7gBjmlPpsm3VrRG3oppQ5rTzb4KZTHfqWgRYGN7UlDR7Nv1Rwgva20x4i+PJ/ta/a8jWS6AWL9B5BK7dOVQT0HstBvCQ46kS89xPHH1z6toNOb4iP5BjzieWD465ixsF1y4Yxb+3SjHnUhrnfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994515; c=relaxed/simple;
	bh=n42Ht4SewGy2TjuGtPnBKSb8T9SoSGxECEkHTL8eTIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KFgwxT5d8wUx9go7yqcMef2Ont/arNIScmqujswrf4lMUYcH8Dj0rool38wGk/nnFG6O1A1DxZT+ymkSy4IkYr7oPshvu+5ffU3pZlYUxYjL+7DdGelJgNJCJhvSKmXxwUK0pQzq2V6oE7miiAVClpRluo7t68tlXOP9XVj5N3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aMaZpOvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aMaZpOvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E50C1F000FF;
	Wed,  9 Sep 2026 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788994501;
	bh=JJKtsP/R+XzqNSFd2tRI6ryvg6jMdWPMorma0LHyLvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aMaZpOvm+QJmid1g9VQpesLwijn9I+3Mz/AtivHJ8/EHdkXOoJaPDgBMaemYqcPFD
	 3JLeqfZWFYUMNaXd92PhUa/bNluE7+9cvlizDnghCFWi6xP6ZeCehyZhYtlUHtGxFw
	 wD1v3gA0Q4uFK8IV9pVCtqjgW3ATTmG6frpHUzfk=
Date: Wed, 9 Sep 2026 15:54:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: ackerleytng@google.com
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
 Alex Shi <alexs@kernel.org>, David Hildenbrand <david@kernel.org>,
 Dongliang Mu <dzm91@hust.edu.cn>, Hongxiang Lou <louhongxiang@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, "Liam R. Howlett"
 <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, Nhat Pham
 <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu
 <peterx@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Shuah
 Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Usama Arif <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Wupeng Ma <mawupeng1@huawei.com>, Yanteng Si <si.yanteng@linux.dev>,
 fvdl@google.com, jthoughton@google.com, rientjes@google.com,
 vannapurve@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Zhao Li <enderaoelyther@gmail.com>
Subject: Re: [PATCH v2 3/4] mm: hugetlb: Fix subpool usage leak on
 allocation failure
Message-Id: <20260909155459.dbf9d67ae21a72935bb863d9@linux-foundation.org>
In-Reply-To: <20260909-hugetlb-subpool-always-track-used-v2-3-30c5d83b572a@google.com>
References: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
	<20260909-hugetlb-subpool-always-track-used-v2-3-30c5d83b572a@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Sep 2026 14:49:28 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

> From: Ackerley Tng <ackerleytng@google.com>
> 
> When folio allocation fails early (e.g. buddy allocation failure or
> cgroup charging failure) and a reservation was not used (meaning an
> unreserved global page was needed), the subpool page acquired during the
> allocation attempt must still be returned.
> 
> Currently, the subpool cleanup error path only returns the page to the
> subpool if a reservation was used. If no reservation was used, it skips
> releasing the page back to the subpool, permanently leaking the subpool's
> used pages counter.
> 
> With subpools now always tracking used pages, always release the page
> back to the subpool whenever a subpool page was acquired.
> 
> Opportunistically rename the local variables tracking global reservations
> needed and global reservations returned. This clarifies the accounting:
> a value of zero for needed global reservations indicates an existing
> reservation satisfies the allocation, while a non-zero value indicates
> new global pages are required.
> 
> Adjust global reservations using the difference between reservations
> needed and reservations returned to properly handle races where concurrent
> threads interact with the same subpool.

This one conflicts with "mm/hugetlb: fix max-only subpool accounting on
alloc_hugetlb_folio failure". 
https://lore.kernel.org/20260428113037.88766-2-enderaoelyther@gmail.com.


> @@ -3074,13 +3074,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	return folio;
>  
>  out_subpool_put:
> -	/*
> -	 * put page to subpool iff the quota of subpool's rsv_hpages is used
> -	 * during hugepage_subpool_get_pages.
> -	 */
> -	if (map_chg && !gbl_chg) {
> -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> -		hugetlb_acct_memory(h, -gbl_reserve);
> +	if (map_chg) {
> +		long gbl_resv_put = hugepage_subpool_put_pages(spool, 1);
> +
> +		hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);
>  	}
>  
>  out_end_reservation:

Here.

I presently have Zhao Li's patch staged in mm.git's
mm-hotfixes-unstable branch, awaiting review.

What to do?
