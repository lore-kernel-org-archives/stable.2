Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512701D63F3
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990857; cv=none; b=VQaNV+Tqa/6IOzHfCfnw3kNYXS+J06ispV+sbAWoKyutg95mQWSewAibs9t2/Mbyka8T00xDe9WA9eNTyEDdfbh1lp+wO5hM/33tR2dySNny4FMU7Y53x1hpAjX/7WFDGilJSP7haDKGrNS8YsomiKife4MqT8Jbdvuc3VD5b8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990857; c=relaxed/simple;
	bh=9ddEJ351YOyEt7gM0SwrAIClCMptaxB9Hq+khWI4W70=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I9ePvRgOkgyAwWf/UNHnEMAB5jadTlfb2qLPRKVSXoGRphlUmQXiGEqzNtYauNZ5MMBgG9pODzZZH0U62vMRq9Gv3GRwMwWeegPIU29g5zOatBC6SCv8cjhpcGdkq72wAs66HioI1mzmklCbqqh7uJ8dREuSKYfPw9qU1TFHdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GtZtHLE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GtZtHLE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3AE1F000E9;
	Thu,  6 Aug 2026 04:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785990855;
	bh=1dq4/C1vxz/RKFi4+i8bt0MGZ8jbut/19qhgFjo+N2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GtZtHLE0eyqqX9CWs2yHAVq/GVvHL5JN15JcCLpKmf7IBn7mY86hiwXPtZEvgtrl3
	 X5jOFP4ohBhykKaFbiMKbYnIV2erW8ETsMeEeqk/kCgUTGi4eTFurtVf1hlJ8B4EcR
	 0538qBXSTam/djPl/VeCit5C7aZLruO1V8+rwQYM=
Date: Wed, 5 Aug 2026 21:34:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: dayou5941@163.com
Cc: linmiaohe@huawei.com, david@kernel.org, ljs@kernel.org,
 nao.horiguchi@gmail.com, linux-mm@kvack.org, ziy@nvidia.com, Li Youhong
 <liyouhong@kylinos.cn>, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/memory-failure: fix folio refcount leak and
 locking in soft/hard offline
Message-Id: <20260805213415.002dc67766271d21c232910b@linux-foundation.org>
In-Reply-To: <20260806031958.677935-1-dayou5941@163.com>
References: <20260806031958.677935-1-dayou5941@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 11:19:58 +0800 dayou5941@163.com wrote:

> From: Li Youhong <liyouhong@kylinos.cn>
> 
> The min_order_for_split() function accesses folio->mapping without proper
> synchronization. In memory_failure(), the folio lock is dropped before the
> call, and in soft_offline_in_use_page(), the lock is not held at all. This
> means that while min_order_for_split() is executing, the value of
> folio->mapping may be modified by a truncate or invalidate operation,
> leading to a torn read or use of a stale mapping value.
> 
> Additionally, the soft_offline_in_use_page() path fails to release the
> folio reference taken by get_hwpoison_page() when new_order != 0, causing a
> reference leak.
> 
> Fix these issues by:
> - Moving the split operation logic into the callers and holding the folio
>   lock around min_order_for_split() and split_huge_page_to_order().
> - Removing the try_to_split_thp_page() helper to simplify refcount
>   handling.
> - Ensuring the folio reference is always dropped before returning on the
>   soft-offline error path.
> 
> This refactors the code to be more maintainable, fixes the locking issue
> reported by Sashiko, and also addresses the folio reference leak on the
> soft-offline error path.
> 
> ...
>
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
>  static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>  		struct address_space *mapping, pgoff_t index, int flags)
>  {
> @@ -2440,7 +2420,6 @@ int memory_failure(unsigned long pfn, int flags)
>  	folio_unlock(folio);
>  
>  	if (folio_test_large(folio)) {
> -		const int new_order = min_order_for_split(folio);
>  		int err;
>  
>  		/*
> @@ -2457,24 +2436,24 @@ int memory_failure(unsigned long pfn, int flags)
>  		 * page is a valid handlable page.
>  		 */
>  		folio_set_has_hwpoisoned(folio);
> -		err = try_to_split_thp_page(p, new_order, /* release= */ false);

AI review asks (effectively) why the try_to_split_thp_page() return value
never gets used

	https://sashiko.dev/#/patchset/20260806031958.677935-1-dayou5941@163.com

> +
> +		lock_page(p);

This code is a maddening mixture of `pages' and `folios'.  I assume
that migrating it over is a work in progress.

> +		err = split_huge_page_to_order(p, min_order_for_split(folio));
> +		unlock_page(p);
>  		/*
>  		 * If splitting a folio to order-0 fails, kill the process.
>  		 * Split the folio regardless to minimize unusable pages.
>  		 * Because the memory failure code cannot handle large
>  		 * folios, this split is always treated as if it failed.
>  		 */
> -		if (err || new_order) {
> -			/* get folio again in case the original one is split */
> -			folio = page_folio(p);
> +		folio = page_folio(p);

We did that 40 lines earlier?

	folio = page_folio(p);

	/* filter pages that are protected from hwpoison test by users */
	folio_lock(folio);



