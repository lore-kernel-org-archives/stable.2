Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4B48EC86
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378106; cv=none; b=kM54N1bJFIulcMNaSUh5fFc/BsyRcwUcB3EOMgqeZX/zAdGUhqz12YLAqppsuPO5vOAzkKoZziXIplY+IJKP8lZpv7jg2etAzpSgJivt9awjFTtjCslG/9BsSeWHU5EpSO/wUzeKKRDQkMzIpXo84WERer8S8ns41l5TKhVQsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378106; c=relaxed/simple;
	bh=QUCxLO/LL8obTfMdSNVAjLHY2xg60URMy+9eXEgIuHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGYkekdDdUoRXp6NJCD0WMxW2yk2iFv3/6G8GnZTotbiTM+qEwsMbcQnf2hzH5J9kx/xWAyzM/oTBf3u6CO4uQYCNFwtmxhQoMKCc4MtxbnDtiJjIoAk0UGmRDFbbBPsvynG2ztmLfFTghWoceBpdBCON98iR58F4AAHn9jZxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=OFT+rR+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALnO33wx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="OFT+rR+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALnO33wx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DDC87A0270
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 09:01:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 09:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791378095; x=
	1791464495; bh=LfyWAq2hiw63ziLXRgCl1FnUGuTYUXJNI/5k9KmmCgI=; b=O
	FT+rR+mQ/p8l6KlOVpJc1V9f6iX6G9CvnxqlJJKTNKUq22keTPOkePKljlJPi5OP
	HYYnEha2Px/6ghgg6vKx27SfaXPUNo3FNe3k4nvLEfH+qh6uQ2ZfZbHqnVTn2VAU
	XDR4WpYH6N5JsXqt+CsKandENqWyxCbdlWmwbApWYZTBB4qdZGZYVcotAIQfEYMp
	YUJyEHjyB/7mMvgjmrYDFwFBie+XSfSfR8X3tVkNs37l9Khwmnrtr9O+EcCgorle
	VJYM1OTyjKHzr4BPJhZImk29t6TSlEMH7G5tpievEzaxTggdhIFudaAbJcP+fI1+
	twEbG7PkdqWl8plwBGJ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791378095; x=1791464495; bh=LfyWAq2hiw63ziLXRgCl1FnUGuTYUXJNI/5
	k9KmmCgI=; b=ALnO33wxuA7li9y6LOWZcyR/M4aLNcHwQIMWCfQGo3oZg5gSXSz
	jmODkS24D0yJ3BdSFp5rMhdjeGMdjsEx53KvqJXBTrCk+OuSazjdO/7NG62hy0KR
	5YL5x1DakzKTjb65W9348AV54HqsHwVdZ3n3QU43i0djh9pU9S0kJewcwXhlqKH/
	R64ji8JnNwpuAJ25j16pDBFIZjbk4Wx2lbSkgUZbQV+vLEn+ZnDSOlFiGtjkP+tG
	pI8zQYRSdzLfkOiRNlmqb+HCQ/sir5Q5Zm5vj/KT+l0Wf486o3fGh9mbsJ/qFxd/
	1OpSsKbb2WnA+inhwDte16/cD6ktlYJ1zhA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791378095; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:LjC5VpnQPI9zl3eDbxVwd0gmRpu3kFs8JRSyyq5UJUM7XCL
	3yFSB9XW3ye9bx86TtOsbqVIo5nszRVmzytQHcHMJJspiaSDy2uztwLwCpDHTS7i
	0gc6efs3c/bnpzisKx7LeSA5XOauGo44XD9/bOCYMmTeooaWEkx/NnUBTMkAi5dg
	NrPmdxIQZG74Paj+Z62BeM68ofk4qqLG0GpueXE0tHhOArd9XdKwG+YRxOSf7L4l
	E1PqyEA8YG0eDv21+klDiolqSr+941NprvYURUoi2b/BbTP2YsJuYfh7MxJ9RnOe
	3wkTpGsowJ2D6j2N4D1S3ziEvza21lyBgiU4s0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fTqP09/yrRsXlRFof8Z20HxbCUXgJOuxJBG4Pm3V3e8=:QUCxLO/LL8obTfMdSNVAjLHY2xg60URMy+9eXEgIuHI=;
X-ME-Sender: <xms:rkLGapakT6OsXu-8CX1JPAX_u3zvNDqwgup8exgPzv9vIrESGkrtvw>
    <xme:rkLGaoLLlZQKa7p3bKFiBf7hPRB1gE3jRf9TKLkoMdqSIBfKbnC5d9Cm-DAd6Wmm5
    LYXbj3ppcCoiaVyRmtI-0B1vB-ja94kXhjJRHP3OjZrrwl7O-8WDh6B>
X-ME-Received: <xmr:rkLGaqiY6BNY-rn00D70B5A6hBiJGrkB3rMKs3FFG0_l7A8mcONbmp77ctY>
X-ME-Proxy-Cause: dmFkZTEB5LT5N/hKuLOxpT3FhmzKZiCnsyboT+IoHzaDb9BIyJrdfFbpyx5h8L275dF8PR
    1gaqApSorCvJHpMZXRD92IT2iJigmNDxP+9aXeoSmFUv6wpCTIparKt+Bqx9VhivzdDX/F
    5yHRu6j6zXCVbzVbREN5Q8QNxazUx0Q6WAgLeWJ5Euq8kTY2kl7A/9KM6FImB0mD2d2s9e
    T5k3yp6GCmtgCgQ5ksHxAiYwscff1v8goq+9tmI479Bfbk4LLsV48UsxwGDpbozuNMM6k3
    vsz5GRjY878MXDTcLlIG5Dfp9OLn+BMyVLs0z9D3hx47GSolY8VKtcvID8VIj1m+SSh5LQ
    Y7W8dVwsmxChI/mKlxLp8FtSg5m+dpefBE+3kqD4/VWkP4bugBLMLNC9+0hGR1JxAeGIwj
    +x3eiXsxRvm8ZWV+ZGagBg220DPSV21UbBlV7SQTiJGk57cfe+S5rOwNG9qDTNl4S3Oyjt
    on/yIglD+lqCI7LeTGJqHFyyyBA9ZLVOvP1305ccb6UPCjlBDLvmDb7fILSYhYjfMhyHXe
    E6q+q3djwvOIrt82RShlzk7NcyYgyrxGtCn4BobF03IuQ3LLrwqWqXgUj9jbUTA4oItN3l
    tSlupDx6EprJ31sLSweI7kbSQPAdR+2fXwiTC0fG3pgHgMxuPGjDApFRDj5A
X-ME-Proxy: <xmx:rkLGah_xotdxkGOPNQuxfTnIVuPnCR32_1--ay87zLM9xbgo5dt5Hw>
    <xmx:rkLGaogvV-uiiYDX21dZLqyuNvH3iV9z1VQXLuxadsgHGZribGaVkw>
    <xmx:rkLGahx2pov5mDTu7HwQc_lNgxFd-qcHdnJcUBJdA9C8oLpX6M56Gw>
    <xmx:rkLGao-hkltAZ9Gt85bAc1zosbIoouDgA_Svh-QFD1ktiL9RqeS4Wg>
    <xmx:r0LGauhyR_MnGD1brXLe4Ga9aPNE1amajtK6zbsMP2maHcgSaxxTsPLr>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 09:01:34 -0400 (EDT)
Date: Wed, 7 Oct 2026 14:01:33 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <asZCEttmL6VlMXKc@thinkstation>
References: <20261006091815.897133-1-kirill@shutemov.name>
 <20261006164122.ea9a673b336b8ac74725c35c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006164122.ea9a673b336b8ac74725c35c@linux-foundation.org>

On Tue, Oct 06, 2026 at 04:41:22PM -0700, Andrew Morton wrote:
> On Tue,  6 Oct 2026 10:18:13 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> > storm in defrag_mode"), direct reclaim and compaction for non-movable
> > requests under defrag_mode run at pageblock_order, to produce the whole
> > blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> > still use the request order. An order-0 request can therefore retry
> > indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> > 
> > ...
> > 
> > In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> > 
> >                                         before    after
> >     should_reclaim_retry() calls           63M     293k
> >     peak memory pressure (PSI some avg10)  99%      12%
> > 
> > File creation runs 5.7x faster.
> 
> > Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> > v2:
> >  - keep the compaction priority floor and the COMPACT_SUCCESS retry
> >    limit on the request order, so non-costly requests still escalate to
> >    SYNC_FULL before falling back (Harry Yoo, Johannes Weiner)
> >  - compute the promoted order once in __alloc_pages_slowpath() and pass
> >    it to direct reclaim, direct compaction and the retry helpers, instead
> >    of each of them deriving it (Harry Yoo)
> 
> Thanks.  That's a fairly large update.  v2 diff is below.
> 
> Are we sure about cc:stable?  Or even 7.3-rcX?  It's a pretty big
> change.

I think defrag_mode is not widely used. Maybe only in Meta.

What about keeping cc:stable, but only submit it to Linus for v7.4-rc1?

By the time we would have the patch battle-tested in the fleet.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
