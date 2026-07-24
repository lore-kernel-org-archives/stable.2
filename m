Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82343E49F;
	Fri, 24 Jul 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904109; cv=none; b=MCTvKumyhze5gLqnYFFzLclFWm05JVoKOcoxypATWD9Ih8x1WVhFmAPIWNGpi6XSwswYXQHO5mQukXxxuKKcr/5vF4bF2qv7qE++7p+vN5wBEKo56iw5sxLgsl5BFhn2SLDC8KjD48XdSJQ4r1ISTgaPsdNGkiswdfyufWQCRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904109; c=relaxed/simple;
	bh=VEdyfSOMiLYKG+pMBcNfHqYYr7Gywte/hoxoyY6eQYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlZjwIpPFRJPkMDfNIOjfEJua7ksMrxzNg5qwVr4zvlMdORPR21i84wWZBAJUlM556hy/qDSVBWKRCo9bDsZsjhB8tKUiUBTRWS1Aa1bBvro3W+STMwrOtlmxUL6TaTQl9MJLJYJmKjoLoLx7RfsHtGIAhr+N1axGQbKSAkecX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXGQYqR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXGQYqR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402F51F000E9;
	Fri, 24 Jul 2026 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904106;
	bh=prmJPmF/8BHCmbcXAOVCMwGPV1ing11vO/5nNpERaGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXGQYqR6216oCUrwRFBkabmwhHHDsyMtEl0kllhefRGB/eMd/vZdNQrzxLlWeBfJV
	 7clrKvtXHvpXxSfE0qn/0at3AHajsJv/GEJrWHqtVvtjPUWT1H+KfSVtgThomKQjhI
	 d7gxtXS37SKKtR2+FxNL7B0m5aoo3+amIs9koWDDd7IfrPehCkYMYFtiHv4g7SB66T
	 IzvSGyk0+7AeLsKTv5Q+2KubsqVmENWz4Pbdp2htWW6G+JCTqh2DTkxraJdmfqzUqH
	 eA0orueZLfinuFDkNUi7UR/LLMjplFUBzI56jKL47g0HpKRct62EOSdh6tfzrqw57c
	 qITozH7zUP5XA==
From: SJ Park <sj@kernel.org>
To: dayou5941@163.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Fri, 24 Jul 2026 07:41:42 -0700
Message-ID: <20260724144143.94526-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724060135.3014676-1-dayou5941@163.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Jul 2026 14:01:34 +0800 dayou5941@163.com wrote:

> From: liyouhong <liyouhong@kylinos.cn>
> 
> damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
> and then call damon_migrate_pages().  When target_nid is invalid (including
> the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
> without putting the folios back to the LRU.
> 
> Callers then discard the list head while those folios remain isolated with
> an extra reference taken by folio_isolate_lru().  The pages stay off the
> LRU for as long as the mapping exists (anon active+inactive counts drop
> while RSS does not), and the leftover references can pin the pages after
> the mapping is gone.
> 
> Put the folios back on the invalid-nid path so ignored migration requests
> still return them to the LRU.
> 
> Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Cursor:grok-4.5
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> 
> ---
> v2:
> - Drop the putback helper for easier stable backport
> - Open-code putback only on the invalid-nid path
> - Keep the original indentation and Cc stable@
> - Add a separate cleanup as 2/2 (factor out damon_putback_folio_list)
> 
> ---
>  mm/damon/ops-common.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d1842e2b00ef..f5ded45fabd1 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -394,8 +394,15 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
>  		return nr_migrated;
>  
>  	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> -			!node_state(target_nid, N_MEMORY))
> +			!node_state(target_nid, N_MEMORY)) {
> +		while (!list_empty(folio_list)) {
> +			struct folio *folio = lru_to_folio(folio_list);
> +
> +			list_del(&folio->lru);
> +			folio_putback_lru(folio);
> +		}
>  		return nr_migrated;
> +	}

As I replied to the second patch, I'd suggest doing putback just before
returning.  Then this invalid target_nid handling can 'goto' there.


Thanks,
SJ

[...]
