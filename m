Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6DD2F7F00
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673807; cv=none; b=srEUXCqFse9VRrZoshN0yb0AFUKqapd07GTDux2Djj5E5cxyCXKn5PkD+Nnavcy7jliSltkR6I0wIHh2Wt+Es7VFRhtykJ2HiRzlY5xAiifuQWS/dIKmM7Dr8A36QGbjbaJTd9eUrv3wCVBxXRngS1gaC4YmG+9foi8kLeHRfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673807; c=relaxed/simple;
	bh=jSWFe0gfZdQSA97ZZzQPaz5fweeN/meOPeShoarvKrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWJ0Dy64YsAEJlCInlb+86ZxKq5mW2ef0p3slqyL/ZeA+5FBZKnSgNCFkW8hdarUuEAxM0V4pzlb9iJHFMXXstixDM2yS9697ygQOVT7rizeD1dE074gojnZQRW1v7QPKd/FicN89yX9yx6UGnnHjzom7T1YvOU6AvWNa+UD83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 14 Aug 2026 10:46:40 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: youngjun.park@lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.1.126 with ESMTP; 14 Aug 2026 10:46:40 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 14 Aug 2026 10:46:40 +0900
From: Youngjun Park <youngjun.park@lge.com>
To: Longlong Xia <xialonglong2025@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/swap: publish cluster tables after full initialization
Message-ID: <an5zgOC0HpxZEzI3@yjaykim-PowerEdge-T330>
References: <20260813150316.2793642-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813150316.2793642-1-xialonglong2025@163.com>

On Thu, Aug 13, 2026 at 11:03:16PM +0800, Longlong Xia wrote:

+Cc: Kemeng Shi <shikemeng@huaweicloud.com>

Hello Longlong Xia

> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> swap_cluster_populate() drops the local, global, and cluster locks
> before its sleeping allocation.  The allocation helper publishes ci->table
> before allocating the memcg table and, on some 32-bit configurations, the
> zero bitmap.
> 
> A stale per-CPU or global cluster cursor can reach the isolated cluster in
> that window.  Since CLUSTER_FLAG_NONE and a non-NULL table make the cluster
> appear usable, it can allocate a slot without the auxiliary state.  An
> auxiliary allocation failure can then tear down a table which is already in
> use.

I think this issue is addressed in Kemeng Shi's patch, which provides a
detailed reproduce scenario.
https://lore.kernel.org/linux-mm/20260720071342.50742-2-shikemeng@huaweicloud.com/

In short, referencing the table while auxiliary table allocation fails can
lead to a panic or something due to a NULL pointer dereference. That patch only fixed
the populate code rather than the entire allocation path.

However, as I mentioned in my previous review.
https://lore.kernel.org/linux-mm/al7WTNXanPVSELAH@yjaykim-PowerEdge-T330/
I suggested making it visible only when the ci->table installation succeeds,
even in the CLUSTER_FLAG_NONE case. If we do this, seeing the table in the
CLUSTER_FLAG_NONE case would not trigger the auxiliary allocation teardown
mentioned in the problem description.

> Allocate the complete set of tables into a private carrier.  Install the
> auxiliary pointers and publish the main table only while holding ci->lock;
> the slow path does this after reacquiring all allocator locks.  Allocation
> failures now free only unpublished resources.
> 
> Fixes: b197d41462c2 ("mm/memcg, swap: store cgroup id in cluster table directly")
> Cc: stable@vger.kernel.org

I see this commit is included in v7.2-rc1:
$ git describe --contains b197d41462c2
v7.2-rc1\~94^2\~147

Since it's in v7.2-rc1, is `Cc: stable@vger.kernel.org` necessary?

> @@ -788,6 +849,7 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
>  				       struct swap_cluster_info *cluster_info,
>  				       unsigned int offset, bool mask)
>  {
> +	struct swap_cluster_tables tables = {};
>  	unsigned int ci_off = offset % SWAPFILE_CLUSTER;
>  	unsigned long idx = offset / SWAPFILE_CLUSTER;
>  	struct swap_cluster_info *ci;
> @@ -812,9 +874,14 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
>  
>  	ci = cluster_info + idx;
>  	/* Need to allocate swap table first for initial bad slot marking. */
> -	if (!ci->count && swap_cluster_alloc_table(ci, GFP_KERNEL))
> -		return -ENOMEM;
> +	if (!ci->count) {
> +		ret = swap_cluster_tables_alloc(&tables, GFP_KERNEL);
> +		if (ret)
> +			return ret;
> +	}
>  	spin_lock(&ci->lock);
> +	if (tables.table)
> +		swap_cluster_tables_install(ci, &tables);
>  	/* Check for duplicated bad swap slots. */
>  	if (__swap_table_xchg(ci, ci_off, SWP_TB_BAD) != SWP_TB_NULL) {

As discussed before, this routine is set up before the swap device becomes
visible, so it doesn't actually benefit from this fix (although it inevitably
needs to be modified to align with the current direction).

Overall, I prefer the direction I suggested in my previous review. (If my assumtion is right)
https://lore.kernel.org/linux-mm/al7WTNXanPVSELAH@yjaykim-PowerEdge-T330/
or Kemeng's current suggestion.

(+ Also, if this needs to go into the 7.2 hotfix, Kemeng Shi or Longlong Xia
can submit it. Also, I can help to submit it based on my reviewed direction 
with both of your tags included.)

Thanks
Youngjun
