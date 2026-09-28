Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079D64AA4;
	Mon, 28 Sep 2026 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573339; cv=none; b=NPnilEAwtlh0/9v3p6ZlWGGgyPO+USmS7Ip84bQIEynI8ZbOTS9hDqPyX8d6ZwOw7sYSrMWW1ZQhQ5TE1JCX7kKROpIzd8dzPqwwQY7kKN3ge1hS0cv0qKClhwYyP9iV7jDk0/1vHZH1IUMPuq5V5vIRddP/wwpesXEzxAFm/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573339; c=relaxed/simple;
	bh=BGt0h3pILZoHJhXj5GhkaOsKh5M4jgkgHFwCJ3CPnhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=johy5NCrqCleDNClKSjW1rRQ3ZhtHje8hiMnVUBKAkJ1L38qat5u6mMuSt5REqlPnfMis/E01vcKcx2qR25H9o5fueXFPBIH7n3cXD3b2632/vENEYnOS45iJxRh+MW6PSaHJVLNkAiPILmQyWaMaVrBF2KyCsttlgviw5htmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yrlsk9ze; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yrlsk9ze"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pbDd44Ecj3LGY4qmWrBA0K5RozmdVMC9pzx6cttne00=; b=yrlsk9zetyTGXZXZ7gF9+MTHBn
	9qPV6avqEL3nD6pU6zN/CRh9W400Eh/qDj2yOxHDjzzIXmyL7x1bIMawQEHS79H5+qtHPVAmfxtxF
	uu+fvw9AI1LcTXmWdkpAAZDkhc/hgmivhsgllCS96VdQjIrV1fcH3h2MwodKzDLiM6aG3YPUfiRam
	nJskiPxFR90cJepCOetdaTTeSInVnanplZ4PBJ5H0fv4UN3Ri1XiKV73AIN75Lne4PrniHremK7kS
	C25/zvyoIRhd9YbzL1CP455mqmps7QJJc71eE7yMNAKMIFjuzM0CQrQuF3lhryuad3/z1+zmign4q
	LICFq/8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB3v2-0000000HMUe-3wk1;
	Mon, 28 Sep 2026 05:28:52 +0000
Date: Sun, 27 Sep 2026 22:28:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Hao Ge <hao.ge@linux.dev>, David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Christoph Hellwig <hch@infradead.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Erhard Furtner <erhard_f@mailbox.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Fix missing alloc tagging of direct mempool
 allocations
Message-ID: <arn7FHZpYhNDvjIS@infradead.org>
References: <20260923063759.34667-1-hao.ge@linux.dev>
 <0d798541-6486-44ff-ae57-f631d1465688@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d798541-6486-44ff-ae57-f631d1465688@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 24, 2026 at 11:36:19AM +0200, Vlastimil Babka (SUSE) wrote:
> > Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@mailbox.org/
> > Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> 
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 
> Seems ok enough as a hotfix. The naming perhaps isn't ideal, we have
> mempool_alloc_preallocated() already for the opposite case. Maybe
> mempool_alloc_no_preallocated() to complement it? Rather long though.

None of this is ok.  Directly alling into mempool->alloc, using a
wrapper and not is stupid and broken.  Just switch the code to use
mempool_alloc undconditionally or to use a manually
kmalloc/kmem_cache_allow if the subsystem has a really good reason
to not use a mempool for non-writeback requests, but it'd better be
a really good and well-documented reason.

