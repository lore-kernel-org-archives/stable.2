Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5742ECD32;
	Wed, 30 Sep 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771707; cv=none; b=Bu3+F61jAwKwvg7yG+bYjARXVjxd6UqvPP1e/hHDNSb0vatsozmg3nZgl346fwP0Ort6JqmVYkfUytGzfeqTapsUweIeP+eCc5M7+8WJOv/fDKBt7dnEs9c4Xs8IG8ShOKAeM+0LyyAqyJriVlaG+H0/Iqf4QAjVd0zxvkHvYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771707; c=relaxed/simple;
	bh=e8RfN6FQ00wYgT8BxTjsnZpBn5OPWPtjU3uidaW+6iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjrjDDpGuZoJ0knb/9RLdHAzPnqwUk39KHNnLihkPbyO9GOSr1t49ti0MndTktMNYURrm2J0KXyglSKxZlyGd6n6f7rec8cH9WsQtpWEKcM4gUEDQO3OkwUu8ViwldcQ8b7yN8mmDCM+yt+N/DCy/yn+U08XMVBZqJ6tu0XKpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HvinTYn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNxrDK1f; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HvinTYn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNxrDK1f"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E84EA7A00B9;
	Wed, 30 Sep 2026 08:35:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 08:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790771703; x=
	1790858103; bh=8GSERcGj3ZPDBj8Cio+ClQgF2tiUgKwW6CxMvKtRxZw=; b=H
	vinTYn7N9NFC/lrxWjb2Yx3b+fLwlqpb9vR0vbV9QV6p0HRTxXXlK7KnDuUtN8Vx
	+bARqB743AoghNsKn2QAdZ5pyQBgsR6xUB2181hpMIWDCzfqX36VuKmE1/S7B028
	1bs8Vewb8Deb9LTAnu/GI7vZLdmb/TF0mnUO0+F4qa2d+y1gjoo10lFIzS/MQ/XV
	uOuYl6dVKQRrrE8BLNLiKuwRM67DSh03mhRGUOT6Xq1Ydid0tYCzdcxZ/ywK53iu
	aZNPXR+hprv+y/aDcgEIEYn1HJM6ELE/eaHsO95EKtSAt9nL58usK+crcs6lp79v
	Jy3kuxQbuXdT78Jerpkyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790771703; x=1790858103; bh=8GSERcGj3ZPDBj8Cio+ClQgF2tiUgKwW6Cx
	MvKtRxZw=; b=hNxrDK1f7ToxT0DuHw7zY3vMvHJ3nfL9dWKOoOFMvmkdmHy4O5a
	WKTrtKknBxdecWpu6CH9/78K8EZXSYBDTYtputhW0qe8UAxRux4+Yevwwjeidk8k
	ii1E9//dJfxDx30C/F5XduZWqy3D/WRBH7kcm3e0EmQr3DL/1WjsD3wNHwMYndTB
	d92EcrJPH1ZDKDQRcQ8jxAYJ7wiqX1ihuXrMUZRenTTNgQDHslweHWY9tfw5gPd2
	AwdlDWQ9lKV5xKD3TxAwIJL5ODEqbpKb8ajXoFeQ2/4VXt/9r7mE2cukWRxrhtUN
	5M2jiHGNrYj3QgF8s+RAa2ZM8irdyCIH/OQ==
X-ME-Sender: <xms:9wG9at4LqA3lQDg2fDTn7aj6EaEIrXfaZRB6DtLBYXnYqbZO-Nk2Gg>
    <xme:9wG9aip1ZO92wCYvVisdTU29yq_u62DRvdTwUnyTMtgO5YERaCTffkSV1jMctgYJ5
    xDn-Mmd56VGzrJ3qt22Zjnm9dvJyCwCRiF8cLY6spxUBn5VBbkGO34j>
X-ME-Received: <xmr:9wG9ajDFM4FzyDyXnpTlqlTnFsomSSYrzErX6zatuT4xORgpVSnudlqQ0Cs>
X-ME-Proxy-Cause: dmFkZTEL7TThQOaOF3FaiEQpbUh3RUYIvhHrP+VB69hyCNpeezulGTZnijh2t4LZPkoAqf
    jbRnDI/qi8ECq88mhKG9goja4578cDRZGaSOICis/fcT3/13u2RkSlNuh96r2W9FjK19h9
    rE5o/rnSTBI54ntwSdzJW8pFZAPjh9AbnHj3P4k+xzC7OQGSG6yOnSNtiJnTW7dQA7NiIB
    0Njg+rT/VKG4TRLEQAwCHSg5OqX/nKILpos0uxNOJELgix54o7wgobBEMnaQZQ3wbv9rvf
    SoRgDfU5qhZAA7Hp2Irv2PUVwiC0bPlhYbb34EgkfBph1/BAKQ4YZa+LR6myVjs8aC+8Ka
    wOSQHh5wmcp4W+2MpAqVTipg1pVZ39W9I1Yf29TLXB71YP+RRLIO+YygZuOyHQ2VBHDxb/
    orS4wFT7oqq7YXOmz++b7SPtAnX18HSDnHn239hrWLlrs9sh/ToxesY4xmH9ePB0NzR7IS
    SHmsrXuM2ES26b8/xzVUUTlicNOLop451lEGXhGUOYCcUOH4OGDXUpH1cdcjXL2jddGUqo
    kXmT5S16GY3om4/xRluvAec2NmT0YQWv4kNPg4xVKTREpH4+KyCc5bQ9c36KEV2MTOefoR
    Nb/ARKceiXIbMWlrt3CIac9++BGXLXb7zmRbs7ZxdlZKMf7NNfI9VxcQ8N4Q
X-ME-Proxy: <xmx:9wG9agcXB-j54LdqND22bVnimufnHTI2jOLHqLu4ErR1OUxvlCqofQ>
    <xmx:9wG9alDD6QHfCK5PqZAXa9JZSl5WEUMhtKgWAVIDFtwzgiO3Tmy6Uw>
    <xmx:9wG9akQSNYXZKbSJEokvjWXQ_bR7PRxmS3Mdg716fPSyWBf7_kDgeA>
    <xmx:9wG9apcOd2K6A9G_Byv_ELaK-gweT6DXkPu0oiCqJxS6I58FBg2FDg>
    <xmx:9wG9arVjfyhFMda6Ammn2TvTyqFG_OPB8v9WN9vohHpgARX-Xv9bBDn0>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:35:03 -0400 (EDT)
Date: Wed, 30 Sep 2026 13:35:01 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Harry Yoo <harry@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <ar0AiPWwfcZtksPu@thinkstation>
References: <20260929174553.175333-1-kirill@shutemov.name>
 <20260929125816.5a846a62943eeaf63725b525@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929125816.5a846a62943eeaf63725b525@linux-foundation.org>

On Tue, Sep 29, 2026 at 12:58:16PM -0700, Andrew Morton wrote:
> On Tue, 29 Sep 2026 18:45:51 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> > storm in defrag_mode"), direct reclaim and compaction for non-movable
> > requests under defrag_mode run at pageblock_order, to produce the whole
> > blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> > still use the request order. An order-0 request can therefore retry
> > indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> 
> 7e8756d7ad22 is new in 7.3-rcX, so no cc:stable needed.

The commit itself has cc:stable. And it is in 6.18.50 and 7.2.4.
The fix needs to follow it there.

> > - Reclaim at pageblock_order gives up after one pass as soon as a zone
> >   looks compaction_ready(), and do_try_to_free_pages() then returns 1
> >   even though nothing was reclaimed. It returns before the retry that
> >   would reclaim memory.low-protected cgroups, so when most memory is
> >   protected, the pass that did run finds next to nothing.
> > 
> > - Compaction at pageblock_order fails or is deferred.
> > 
> > - should_reclaim_retry() takes the reported progress as progress for
> >   the order-0 request and resets no_progress_loops. The request
> >   retries.
> > 
> > Order 1-3 requests loop the same way, and should_compact_retry() also
> > checks their pageblock_order compaction result against the request
> > order.
> > 
> > On a production host (64G, defrag_mode, memory.low covering most of the
> > workload), 95% of direct reclaim runs were order-9 runs that returned 1
> > with nothing reclaimed, at up to 60k runs per second. Across ~200M
> > should_reclaim_retry() calls in a day, no_progress_loops never left 0.
> > The spinning allocations were SLUB slab refills for inode and dentry
> > caches. The time spent registers as memory pressure, and pressure-based
> > OOM killing takes down both workloads and system services.
> 
> A production host running latest -rc?

We are running 7.1 with 7e8756d7ad22 backported. We found defrag mode
crucial if we want to use large folios in page cache.

But nobody besides us seems to test it :/

Can we make it default pretty please? :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
