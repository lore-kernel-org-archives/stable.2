Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9E3F54A0;
	Sun, 13 Sep 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789323432; cv=none; b=TGSL98uLoYHf/x3U4DuIOIBT6tRxFxIPogojdydvnx8s8tHSjLGTfZN4ZkOZaqiKwSGqGAYWTQ0+zM9jhRsGZry9IlY6zPvUEn+suVOG9heEtpeUiyKxeaVJdjkWs5Mki/FQYA3aSR3jofrtUoWmk+PC6WquOxK6pJjwITBz3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789323432; c=relaxed/simple;
	bh=2ay6uYNiAvfzm+LVUR52j3HSlIOFM2i8nvtj5febeoM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cYHa2zr0mPSGZ0dXIT/hRGtO3wbATPGhvIttBD65C9i3L4tUZBEDrZCVxZ2f59sY0h+O/RPX04jZAWF1xcznZG4m8OhSCBV9L++Wkf66v7dM8/WIH83EzoadLKAeDAt1kk3FaJ02qxOiVIE3h703h1StdMC14EHysRT9Vuu3o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CH2uAWDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CH2uAWDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7899E1F000FF;
	Sun, 13 Sep 2026 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789323422;
	bh=KU9uwymn0LP9fWhntovos+AUWynKcZgGYx2o/2j+a04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CH2uAWDPfwJyNBnFFm4FV6Qp6lxylRxMjUnlTHRYBRgV6ogXRxUnAeAuICkUT9bW0
	 3HeCA7cuIqR5q9Gk6G14cSFkh+hoeSXKNcYBE8tMpgn6AhbDt/j1m+ZslOy2aDmnqI
	 cubMNgGpEpRteAyW+WxLtkz+6XEEN/wL+Q/XueLA=
Date: Sun, 13 Sep 2026 11:17:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry
 Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] khugepaged: hold invalidate_lock across
 collapse_file() readahead
Message-Id: <20260913111700.6de78b5834842f7dd3f12d07@linux-foundation.org>
In-Reply-To: <20260913163644.122133-1-ngocthang2710.1999@gmail.com>
References: <DLEBZ0GIGNQ8.17U563YYJ37AA@nvidia.com>
	<20260913163644.122133-1-ngocthang2710.1999@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 23:36:44 +0700 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com> wrote:

> collapse_file() calls page_cache_sync_readahead() to fault in missing
> pages before collapsing them into a THP. That helper takes
> mapping->invalidate_lock itself for the duration of the call, then
> drops it -- but truncate (e.g. ext4_setattr() -> truncate_pagecache())
> takes invalidate_lock and then waits on each page's folio lock while
> holding it. If collapse_file() has already locked one of those folios
> by the time truncate reaches it, and then tries to acquire
> invalidate_lock again (e.g. on the first readahead call, since
> invalidate_lock is not yet held at that point), the two paths can
> deadlock/hang on each other's lock: truncate blocked on the folio lock
> collapse holds, and collapse blocked waiting for invalidate_lock that
> truncate holds.
> 
> Reproducing this over ~150,000 collapse iterations with truncate
> racing concurrently reliably hits hung_task: blocked tasks within
> about 20 seconds on an unpatched kernel.
> 
> Fix it by taking invalidate_lock_shared once for the whole scan, after
> alloc_charge_folio() succeeds and before locking any folio, and using
> page_cache_ra_unbounded() directly in the readahead call site instead
> of page_cache_sync_readahead(), since the latter would try to retake
> the lock we already hold. page_cache_ra_unbounded() does not clamp to
> EOF like the helper it replaces, so clamp the requested range
> explicitly.
> 
> 730633f0b7f9 added invalidate_lock acquisition around readahead but
> missed collapse_file(), which already locks pages while calling
> readahead; later filesystem conversions made the deadlock reachable by
> taking invalidate_lock before waiting on page locks during truncate.
> 
> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")

(You forgot to cc the original author)

Five years.  

I wonder why this hasn't been discovered by lockdep, AI, syzbot or any
other of the tools we've been using for so long.

Thanks for doing all this.

> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2257,6 +2257,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	enum scan_result result = SCAN_SUCCEED;
>  	int nr_none = 0;
>  	bool is_shmem = shmem_file(file);
> +	bool need_unlock = false;
>  
>  	/*
>  	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
> @@ -2271,6 +2272,15 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>  
> +	/*
> +	 * Take invalidate_lock before any folio lock: the readahead below
> +	 * needs it, and truncate holds it while waiting on folio locks.
> +	 */
> +	if (!is_shmem) {

Is the shmem special-case a red flag?

Probably this fix an acceptable minimal-thing-for-backporting.

Question for maintainers as well as for yourself: but does this
indicate a need for a more architected redo?

