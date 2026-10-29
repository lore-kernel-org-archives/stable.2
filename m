Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249627;
	b=OTLycse5Enb71NRaAsD7P90r4a0PHmJs6OLqhkapVOu+MChJ1nlM+2SqGoW3dbLh4e9/
	 WfKh9Lm5qXTtimVD7IFy3r3IVXcXHm507S1b71mbPC7cHzkP0gKfJidi/NFknnxdsNbA6
	 50Vh1D45CoMwO7/vUL5soLGra6SjfqhZNTpR4Wz23TWBWjOe2uwdpYM1pGa4D5oane7OP
	 Ceo1Mk4+aZsfqCWu9aSsoFuDttbwWC5Annng0eNnrlTMvjgbxYHiCvNci53pEpqujCDyf
	 mO4DK6XjVMIKXieYVDj44HtMNQIvyCJh4k/Gi+O/odMKjLk7u2e5GL+lT++xlST4xOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249627;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nSvRu+DrKpZk9fhC33/WfqayjP5HLD0PEYNxYg/H2d4=;
	b=iiFndMexIVqKkPzfdQ8CAYUPGCijgFsFoMK9WvrAP0HpdMWeCvvPykyVDDWtmDit9/IY
	 1d5zRIQStLNPHq7J4BE0jvKl1yk8IvCeSvxFzY25L/2lapyB+Ywtv/c/Jh/10Bv02q/42
	 gr9B9b5c8EE9b4rtwm+/NJQ/xb69WzpMEx008hAXIR/m1B3Rft4zoyD0up67dvcaWhAg/
	 bSTjSCFS36b2Ma7DBDJvrhvhDWtcZUPcIgfUwNkQkY3YdlNeC3K1K/8/6UyTazSiacCnm
	 n1dBj1BCyOUxHlzgteaLS7q8qis6j8X2GGgshe96HvhiO9mGCaPnRqgv7RjQv+zUw1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wzldufxr;
	arc=none smtp.remote-ip=95.215.58.214
Received: from mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB8606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BB8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wzldufxr
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i7u+rlmCh6Mr8ur+/yCWDheirhBIEcgUXzKbr5iYaLI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793249625; v=1; x=1793854425;
 b=wzldufxrq7LeGF/UT1w/d7qBoo4cSoxFnLCvJgGiKddxIK6nGj3eWwtYfsSoRfGtBw1RSw+o
 l2EEGi9jB7oYX3VF+s085Fb8klvLZm/TtHLejbv1l7E/dPxEI1csGXXbkf56r/0e2nXCXfg2S7r
 8BiHJX3hY4QzJUxF7RNT23/I=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 06f3ecca37f8f8d0;
	Thu, 29 Oct 2026 04:53:44 +0000
X-Mizu-Trace-ID: 06f3ecca37f8f8d0
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	harry@kernel.org,
	hughd@google.com,
	jack@suse.cz,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	josef@toxicpanda.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	kasong@tencent.com,
	kees@kernel.org,
	kexec@lists.infradead.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	muchun.song@linux.dev,
	nico.pache@linux.dev,
	nphamcs@gmail.com,
	npiggin@gmail.com,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	pratyush@kernel.org,
	qi.zheng@linux.dev,
	rakie.kim@sk.com,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	stable@vger.kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	weixugc@google.com,
	will@kernel.org,
	willy@infradead.org,
	xu.xin@linux.dev,
	ying.huang@linux.alibaba.com,
	youngjun.park@lge.com,
	yuanchu@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH 33/46] mm/madvise: fix data loss from MADV_FREE on a KSM page
Date: Thu, 29 Oct 2026 12:53:07 +0800
Message-Id: <20261029045307.131675-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027-fixes_core-v1-33-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-33-6f74bec9a5bb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
> folio remains in the stable tree and can gain new mappings without being
> dirtied again. Once marked lazyfree, reclaim can discard data that those
> mappings still need.
> 
> KSM always marks a folio dirty when converting it to a KSM folio in
> try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
> but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
> PG_swapbacked instead of discarding the folio. This also protects folios
> that were already lazyfree when KSM converted them.
> 
> Skip KSM folios before clearing their dirty flag, checking under the
> folio lock to serialize with KSM conversion.
> 
> Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/madvise.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 75b409e97dbf2..a16e3cb256b7b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
>  			if (!folio_trylock(folio))
>  				continue;
> +			/*
> +			 * KSM folios can gain new mappings at any time, so we must
> +			 * not clear their dirty flag.
> +			 */
> +			if (folio_test_ksm(folio)) {
> +				folio_unlock(folio);
> +				continue;
> +			}
> +
>  			/*
>  			 * If we have a large folio at this point, we know it is
>  			 * fully mapped so if its mapcount is the same as its
> 
> -- 
> 2.43.0

The fix looks correct to me: checking folio_test_ksm() under the
folio lock properly serializes with KSM conversion, and skipping
the folio avoids clearing PG_dirty on a KSM folio.

Reviewed-by: Xu Xin <xu.xin@linux.dev> 
