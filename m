Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA43265606;
	Mon, 14 Sep 2026 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789356212; cv=none; b=cA3D78KvvJiRrn0QzVozUfOuwP8vScL73QVOvBcJOTZLToxvivp3r/RQ6H+w+MMlYNQE7q9m3T3CkcUkXaPkqjLJ0ENkQi1k1GgUIhibO5eUQHD/8nCDlkMch/xtiGaDjr05Q1YP8mfirwxK+td7GEU99Q7aITAHCSVMHgwfwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789356212; c=relaxed/simple;
	bh=0BL9yRTsY+WMh3fFq0N353IildVntctyWMbttr76m7Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K54kn2M0ktjGMLXZb7Dz4OqSAo7fFk3JigbcpQ2WkJhMhTAUMyUSLzwYUbcvtfUkCwaW206T1URZf44AnwfW0y863YUQROfsFRwRGpVGZM8deeVXkR9AvFURTGAJtjDC2YXFm1Co/NLUTSoOnu+gM3Z1ZqY6Wjsd3EivngsKDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AzmM2RxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AzmM2RxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618721F000FF;
	Mon, 14 Sep 2026 03:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789356194;
	bh=sg3f98BxUMWsi0jHBDrkEMS50jrFIb0Q1qn6f4dy2+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AzmM2RxTMzOeloRCcPj3pFvD/yvKblAnyPrFI6Z9Md5JhDeA+WTxOvXz2EDDjwCrR
	 3YvQsujETxFUV/8J6j/GCLTTozaLIIBk5hn2qNG+snxduDo9vW7EWEtB72igXqQt6Z
	 R+zE6wrRJNPvi9Bd03F2gJI7/oTmETzwQirgN4/w=
Date: Sun, 13 Sep 2026 20:23:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiqi Liu <liuqiqi@kylinos.cn>
Cc: vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: apply per-task GFP context in bulk
 allocator
Message-Id: <20260913202313.6c9bf636f773fcacf573af03@linux-foundation.org>
In-Reply-To: <20260914024555.138125-1-liuqiqi@kylinos.cn>
References: <20260914024555.138125-1-liuqiqi@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 10:45:55 +0800 Qiqi Liu <liuqiqi@kylinos.cn> wrote:

> alloc_pages_bulk_noprof() does not call current_gfp_context(), so
> per-task scoped allocation constraints (PF_MEMALLOC_NOIO,
> PF_MEMALLOC_NOFS, PF_MEMALLOC_PIN) are not applied on the bulk fast
> path.
> 
> The most direct consequence is PF_MEMALLOC_PIN: without clearing
> __GFP_MOVABLE, prepare_alloc_pages() selects MIGRATE_MOVABLE for the
> PCP list, and a task under memalloc_pin_save() receives movable
> pages from the bulk allocator.

Thanks.

When fixing a bug, please ensure that the changelog fully describes the
userspace-visible runtime effects of the bug.

> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> Cc: stable@vger.kernel.org

Especially when proposing a backport.



I asked $LLM this question and was told

> This can increase fragmentation and interfere with compaction or
> contiguous-memory allocations, eventually surfacing as higher
> allocation latency or allocation failures under memory pressure.

which wasn't so hard.  Please update your organization's prompts to
ensure that this information is always included in changelogs.  And, as
always, carefully review the LLM's output.

Other useful info to include in bugfix changelogs:

- how was this detected?
- is there a report from a real-world user?  Reported-by:/Closes:
- is there a reproducer/test-case?  Did the patch fix it?
