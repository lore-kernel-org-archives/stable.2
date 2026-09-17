Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62045000
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673211; cv=none; b=l3f71DjHNZZcM8bCuGKPofUNzw5HWGuv+FuQS+xVpNUOHZVil5VWp+Yo9eqg4QTPXgbDbj6aE5WynUoJi103IpC75VD5hW5MQuDgycqkX56x2j5DnYLBAq+bY/odip90MoJEl4zMTg/WAN0Z+40gqV7UtyiNtDIgEIwMqjB9B7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673211; c=relaxed/simple;
	bh=yNZjRUW+ehnB6kYW1BDeCn8vZ1K549OOsZwMzAzKLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah2iFz9CACQQB54G73L+f6KkyACNY83kgaE9wnl2y3nbppgjuQLAsEATxAMwpMK1cFSNxymNU8oMWDjuofhQH0X/twKQJF4su/CzBpvf1o71Zj/ffb7pYy0DA99urPyj7wYGv4N/bWMEVhBHElxdORgEC04IigS8PHVAndzutVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSZ2567A; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSZ2567A"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6bc475ffcf6so577155eaf.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673208; x=1790278008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=se2Vsxe0TSsDe42Voe/AhBhDb+5OgYc7j9RLVDJ97eE=;
        b=hSZ2567AlgtlpEKe+Hgozv0dXX/fZjp3sZLSZQ4e2jD2sHq/bb8O8eoxJOY6aYVQcS
         kBtl6H5yOCPRNyEPvlWYEdSLA6L7LsepJPkeWr2UvLh4DooXl0QdtyZlcnc8T3TeRzlu
         w9TEi6DKvoAvwsZnKY0/dh6jldZM+T35mf8zcsHiw94iXDgDPejyMUUU40eL0BKtl6o/
         PRpPeWeYOenCNPFtJ7To+FstkALrtOjhfZ42LhE2BUEVoDcjx/Bzq1vbHGdHA9fla2Ug
         IjHlhcEXh7CShmkztE/Rk0I/V2J0TV1t4fkl7/vycvvtZty+u+FB+V575v6oT65xRNEn
         94uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673208; x=1790278008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=se2Vsxe0TSsDe42Voe/AhBhDb+5OgYc7j9RLVDJ97eE=;
        b=Lmu7jlexy5cR23Ccoh0Ojku1AlM6gQbN1QP5Nf2TC0O+HXPiWd51VGsJpNXWgF3evM
         gVl/x3jBJ4sCcO9gTXpXDy2pwyscAMgx/rIlqO33zXceBbxQK16TiCVEgszu+ZFB7TIl
         rKc0VzH7c0UriVEcGDtM9fMwixElIZJe5RqLpaha2OLtaj3fnN20fMHFZ6WL3KAMjOzv
         Gdmun1MJ4CbOqswPW6Yi8VES+ZsnqmqVeuaDhYwlCR/wSOfwr2q/5uFJY8CrXPRgDFmX
         kdW+JP+3u3j1Z8q30Nr69gLnixAaxMJ0Hu5TyBoSA9YhL6ziRVrsr8H+oCTyhEfh+CyR
         8n4w==
X-Forwarded-Encrypted: i=1; AKwUvBxUhZ54IxcIB9d16vF++ld8+iOREB0F9dO6roGoJqd1QhTgkBpcGZgNa9TjESPlhCNb8g+eGRw=@vger.kernel.org
X-Gm-Message-State: AFuF++kWaShzsFTQe8o2F2u1GDxgI8ake5AM34uZ8joiSW6v/O9vp38Q
	aA0BY1xoA/MLq/aGq64E8gK/MVqSuZIzXlI+957g+1lS4HzCzdPsFhNx
X-Gm-Gg: AYBFou2WNAFYZDCc6jaLzNR/bIolaowGWs2r/NSUthvcdLWUtg/kgnt5NIWK7uGV5RU
	JUGyIUpBBeAG9kgtTHkiFUYfur8pOvcZpRRFPl/ertZVvCLxEHr2vH7b36w7flNfhJLOm+NZWXJ
	/LmiG1z043MkOHaKIOJLUxPrBhZlaJTk6hVb3Tr7GhX2sqZOW3xcxlUD/siZBh7+WarWmD45362
	SLkZF9jwLbtVJQgxtHa0Ws9TMaI9Lbk1Jj1ZwinXlwQb4Y4F8XUZHoQLuYqe/M75b10ZMAXS4AP
	/ozStx3N7aXVSO1gCFDHMNH1TKyfv+eB5yT0RQj4KtL8KhVAjsEdE/pHCYGost029xlzjC5v72+
	WyuzyzF9oU55P9wrlKcnUlYvWiqRk/kwKVahsyaAFBbBNWacBSSCMN/ELGjbLnrDXlswxVhql9H
	At7e4XpV6pLFJwDrhey0tdGZdVNwT30825cizSG5E4H2zz4hF//qDz+gv1D13dxWklhvuTMVtCK
	PH0jJ2aMsqqlxcdDmjyEHT9/9AJag==
X-Received: by 2002:a05:6820:7091:20b0:6c9:80d9:5f6 with SMTP id 006d021491bc7-6c980d909bcmr2173414eaf.55.1789673207394;
        Thu, 17 Sep 2026 12:26:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f727fe99sm3306425eaf.12.2026.09.17.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:26:46 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	fvdl@google.com,
	jthoughton@google.com,
	rientjes@google.com,
	vannapurve@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ackerley Tng <ackerleytng@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: hugetlb: Avoid re-allocating global reservations on region add failure
Date: Thu, 17 Sep 2026 12:26:44 -0700
Message-ID: <20260917192645.3436692-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916-hugetlb-subpool-always-track-used-v3-4-38aae9b5ccdd@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Sep 2026 16:39:04 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

> From: Ackerley Tng <ackerleytng@google.com>
> 
> When reserving huge pages for a shared mapping, reservations are first
> requested from the subpool, and any remainder is accounted in global
> reservations. When adding the file region entries fails later in the
> process, the reservation attempt must be rolled back.
> 
> Previously, this error path explicitly dropped the global reservations
> that were just acquired before jumping to the cleanup label. The cleanup
> label then returned the pages to the subpool. If concurrent activity in
> the subpool allowed the subpool to absorb more reservations upon return
> than it supplied initially, the cleanup label calculated a positive
> difference and attempted to allocate new global reservations from scratch.
> 
> This premature release was completely unnecessary because all requested
> pages were already backed globally: partly by the mount guarantee and
> partly by the global reservations just acquired. Prematurely dissolving
> those reservations forced the cleanup path to attempt fresh buddy
> allocations that could fail under memory pressure.
> 
> Instead, track the number of global reservations actually accounted so
> far. In the cleanup label, subtract the already-accounted amount from the
> difference between requested and returned reservations. This ensures
> that when global reservations were already acquired, the adjustment is
> purely non-positive, dropping excess reservations without ever attempting
> fresh allocations.

LGTM, thanks for this Ackerley!
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/hugetlb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6589b188cf657..ee1ba9ded0ec7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6678,6 +6678,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	struct hugepage_subpool *spool = subpool_inode(inode);
>  	struct resv_map *resv_map;
>  	struct hugetlb_cgroup *h_cg = NULL;
> +	long gbl_resv_accounted = 0;
>  	long regions_needed = 0;
>  	long gbl_resv_get;
>  	long gbl_resv_put;
> @@ -6768,6 +6769,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	err = hugetlb_acct_memory(h, gbl_resv_get);
>  	if (err < 0)
>  		goto out_put_pages;
> +	gbl_resv_accounted = gbl_resv_get;
>  
>  	/*
>  	 * Account for the reservations made. Shared mappings record regions
> @@ -6784,7 +6786,6 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
>  
>  		if (unlikely(add < 0)) {
> -			hugetlb_acct_memory(h, -gbl_resv_get);
>  			err = add;
>  			goto out_put_pages;
>  		} else if (unlikely(chg > add)) {
> @@ -6826,9 +6827,10 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * There may be a difference between the number of
>  	 * reservations to consume and the number to restore now if
>  	 * there are multiple threads interacting with the subpool -
> -	 * restore the difference.
> +	 * restore the difference, taking into account any global
> +	 * reservations already acquired.
>  	 */
> -	hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);
> +	hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put - gbl_resv_accounted);
>  
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
> 
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
