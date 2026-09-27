Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FF846A
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790471932; cv=none; b=dQ0vcJ4tlfS9VLZyYEY1o0ZIbWil1EqOSM5nP1P4b8VgQQVwl9uMUmO5eK+/sx+KaqdjSc9pxzQ2B+6dGt5Mr/Uhk4PUvJif0ZUTMhLb8TB0dBE2Z7k1JdLBCI8PsPSW1wfyiT7jsP181bb8GYE34KY3xl+hYpxGQf2NFTY9Bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790471932; c=relaxed/simple;
	bh=BxUPSzZDS3MMZBdygGN7lGzobedNX+2vAOdH6yZV9HQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aaciAiCER1yIGT5uTUzDkD0x9tFOebXdCngmTGr03u8AOH/kN1NPIhiSElJtammjHfisi2877I/9z7s0LWo1pv8TkJb249HHQIc33YFPGUqETANIYvP5dqhTsx8IYc7jdFbVK4eDmvT1wfWD3zjzP7YrZP5e/RpIr+6nUUFbAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ruA78NxH; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ruA78NxH"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BxUPSzZDS3MMZBdygGN7lGzobedNX+2vAOdH6yZV9HQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790471927; v=1; x=1791076727;
 b=ruA78NxHZghH/CS8b4IZTk3u92vY78GLlbeP2q+V+oY2f0rLYCMkzg+mw/U14VljTaa4PUjQ
 JZkBvhM5D1jCH0jZF9kLvoHZHBlLM5u8lrLPTzZxe/15Hv71cR9iG7tzX1zk7g6E2C0Po3sEgas
 pqEYe5W/QQQfBXlBk4Eddigw=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 685dda7770d68273;
	Sun, 27 Sep 2026 01:18:47 +0000
X-Mizu-Trace-ID: 685dda7770d68273
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] mm/hugetlb: fix subpool minimum reservation rollback
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260907132055.26696-1-zhoujinmeng@bytedance.com>
Date: Sun, 27 Sep 2026 09:18:29 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Wupeng Ma <mawupeng1@huawei.com>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Jinmeng Zhou <zhoujinmeng@bytedance.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EA8A5B8F-CF1B-45B2-9E2D-CF59A67050DE@linux.dev>
References: <20260907132055.26696-1-zhoujinmeng@bytedance.com>
To: Jinmeng Zhou <jinmengzhou22@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 7, 2026, at 21:20, Jinmeng Zhou <jinmengzhou22@gmail.com> wrote:
> 
> When a reservation request is partially covered by a subpool minimum and
> the remaining global reservation fails, the error path first calls
> hugepage_subpool_put_pages() for the subpool-backed portion. It removes the
> failed global portion from used_hpages only afterwards.
> 
> hugepage_subpool_put_pages() uses used_hpages to decide whether rsv_hpages
> should be restored. Since used_hpages still includes the global portion, it
> can remain at or above min_hpages and prevent that restoration. It then
> reports the subpool reservation as releasable, causing
> hugetlb_acct_memory() to incorrectly decrement h->resv_huge_pages.
> 
> This was reproduced with four 2 MB huge pages and a hugetlbfs mount with
> size=10M,min_size=8M. After a successful three-page reservation, a two-page
> reservation which needed one subpool page and one global page failed with
> -ENOMEM. HugePages_Rsvd incorrectly dropped from four to three even though
> the subpool minimum was still four pages.
> 
> Roll back the failed global portion from used_hpages first, so that
> hugepage_subpool_put_pages() evaluates the minimum reservation against the
> current usage and returns the correct global adjustment.
> 
> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

