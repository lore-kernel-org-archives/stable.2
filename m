Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA0361670;
	Wed, 15 Jul 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124502; cv=none; b=u9Jx0+8Y2Gkyfy/lmb2SBPlraBskl7ELJwjfNu4bVNJpfRlbte68BP9c4byGcqflXyAyeaXZkSasdUZmPQ05NJTatDf9DWdGe3M8w+pvWn+3hUxO35IPND/1ZbR16Zy4ztJAkITEH/lqqHWuWw3+1fd+2JWFGdfwXFGYIi7zOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124502; c=relaxed/simple;
	bh=8gdqI1otbtucq9mAlimPPAH2c32sbPPqv/+x1kXTq5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDU2//u5yW1L0Z+Llq2CUr4cPBBr7L/jH4OzTWuxUEDNt2GD3UyBRC8inw6KfjLHHtGSAsXSokMGqBDYpE6DbzlG8hEB/AJQt5h7nCQXyOUx4Hu3sLazpvt/wzVybvE0irAQ7NT8BtMOdQpVg1yu70DZAbg+HnhHkiP1Pzrl8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ra72+LF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=it1ZkUkv; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ra72+LF6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="it1ZkUkv"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 48D791300194;
	Wed, 15 Jul 2026 10:08:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jul 2026 10:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784124498; x=
	1784131698; bh=4z4v+0DkhPOZ+hMcb2wtvk/RMec06BLgrTqpTtj12FE=; b=r
	a72+LF6SF1x0q3s7SvHjPPoURNKMD5wDdFgosU987W+Nnm0JPdApDOZp6fSNa5x6
	nZj09w45rBvINrpqDHMB5p8h/ZC/Rj56Syp6JA+1N7NdDM5fpm+F2uZoIsVS4pTK
	H363tgf88oh1WphUBdLnAu+GKH50fH3bf8O8G1DLvoG09iqBHHL40ommvYOPAYaB
	Iwcg5/xOQMcjeipp/ypJUO9er1nidFfvF5e0Z3EwqZf5ZYiAsCJ73IJQHW/yBks8
	VBYKLGVJ3bw7nRgVEA6c5qIpLuAPwDj8U7gca+eh0pVRtO0eOil/kT7jEk5WQSAX
	lq/wDfCzN0FeNKNEcXIcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784124498; x=1784131698; bh=4z4v+0DkhPOZ+hMcb2wtvk/RMec06BLgrTq
	pTtj12FE=; b=it1ZkUkvhHcu1S/x2SpteV9crdshSbdpsfUwkdNZSvD5V+0N8w+
	i8KX8+gQfJKD5M1SDkw/p0kFPf/zyuvvlwZ8H3e0vtOcnhrql5va8bNcK380N4Xq
	kX7DZYIEZO8fa2Df+PlVNIVrbOb7e//5j8vIELyx0GKTL7jvB/qs9pWZG5Zlnlb5
	FAjAL+1i/0mLXzUBMyz0a5ARmcqIt1W2Vwnm1M4BNBdLAHc2NnaVImtIhW0e5nJK
	x+4hLjXARfSz9dxLnVId2QmS1qSniAxIyFUIRsupSn3IBLuqFr2nfMPSoEfbLWvj
	gQtEHajpLEV4WYfxuZOUrK7jsTVwmKfgQdg==
X-ME-Sender: <xms:UJRXamWn639D9fqtTvAAAVe4WsjqyQHAiiEba8n0Ay-delIOUVYouA>
    <xme:UJRXal7yaA0MsrVlXIgq5CeHwXOZLCSkvznJb1uAWSMQLAgBUuCqStUOrgTRSdead
    EwCkY0LVq5d9oLL6eEOem3OmQFkDRCAnI2v7-Jp_PgtBI-hydoQgItc>
X-ME-Received: <xmr:UJRXaudPTwCiuZEghlXtXE2M96rLN4dT50uSbnX83FqMR_0If-KR8Fc2jjzjGg>
X-ME-Proxy-Cause: dmFkZTEpAbFhk9XT00JjqNpXWGdW8G+fTRJY2oeiXEvO++OR6PQ9/87bVJe4j6SWYcZC/e
    i4UGaPFfCT0wdVcMjwVIyM2eJOqWcmUiCvlHQuvcbDnEzKaVYTefdBC3MBHUATFAK5eTKb
    XQ92tfowyD/1ICcH9GOmDzWoJkE9rPxOvrxfqBumY+rQ6PkaHXgBEd2sWRMrNXO7MTuaCh
    YQi1KrackKrSIaGGhAeBrwya9uraHA3JXDQoQce8cq0RtNS3zRPqRbr3D2idp47SUPioFW
    7iuYs+NN2cd45QAHNphHug6Ec/ERMXeq8YB9uI4djMvSYt7zeJCvnnC/Rv1um9/5aI76L5
    bXlEegLUH4OgRz3aO5ExmKktEQTyQVvlnxf+s05SS1XjuTrxn1gdv8MEC90Hk/tkoQCG79
    My+NGrKX/3QSDiOqFkr8c1+Vx1sRwxDSfON2cLbT63wtA1kX6AIFamNkTtHdjrJn2Kf3Rx
    SyTJf4B45AZyRXUiD2SY0Uh4BMFGocMsu1wn6CGo4Hyn2wpmYMYFLkR45BBzofugEPAtNY
    wMk6mQ/ELff4FVzCOvowUe7XAsMbYjsdGhBBPZkN6sTvxYfXtBC7yhPFUTo3FddPLTE6Ny
    5MuIjeAI4AO9nMieaeCrhLSWbJmdOOtDSqzGS77R2OT5TamMdM8BM65U3cXw
X-ME-Proxy: <xmx:UJRXajvZUZMg6La8pfz2tEENC43ou0_TIBahEcCEiGrH7Y-hdUAwQg>
    <xmx:UJRXamjDPP-6HIGUS06bQplHkoMHItkX1xSEAG69ahBPiPgfcZpUeg>
    <xmx:UJRXak6pIxGhX5vKH9S-70F16mZO8p6isd5x17gxstfoZ5pRd3XO4Q>
    <xmx:UJRXanKeCLp00ZJqZjXo01QFy8BNTseOQRMHJFoz_PVbvhbeWnaAnw>
    <xmx:UpRXahaEQHsu79mPcyQwK2UgNN34vNUq1Mxh5AOeGhomZ-1QXA_Ute4o>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 10:08:16 -0400 (EDT)
Date: Wed, 15 Jul 2026 15:08:15 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, 
	peterx@redhat.com, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 PMD holes
Message-ID: <aleT2uw9glPnKiqv@thinkstation>
References: <20260713091710.206548-1-kirill@shutemov.name>
 <f5700c45-9eab-47e1-946c-47d9a531bfeb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5700c45-9eab-47e1-946c-47d9a531bfeb@kernel.org>

On Wed, Jul 15, 2026 at 03:47:00PM +0200, David Hildenbrand (Arm) wrote:
> > 
> > MADV_DONTNEED has fill-with-zeros semantics: it changes the contents of
> > the range to zeroes (a subsequent read maps the zero page), which write
> 
> Only in MAP_PRIVATE | MAP_ANON mappings.

Right, I'll scope the fill-with-zeros wording to MAP_PRIVATE|MAP_ANON.

The fix itself isn't anon-specific -- it covers any non-hugetlb uffd-wp
VMA (anon and shmem); the invariant is just "unpopulated => written",
matching pte_none in pagemap_page_category(). I'll spell that out, along
with the WP_UNPOPULATED marker mechanism (a missing marker == the range
was MADV_DONTNEED'd).

> Do we really want to backport a test case? Usually we split them from the actual
> fix.

Agreed -- v5 will split it.

The rest goes into v5: your shorter comment, reuse of
unpopulated_scan_test()'s sequence, recover instead of ksft_exit on the
mmap failure, and rename to unpopulated_thp_scan_test().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
