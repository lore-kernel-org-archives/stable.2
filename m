Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702693;
	b=IeqEoZbQzbWY8jBZwD9ePKyBy6+LAvmo5oGKuDDxIwi7Z16YwjIZy0nJZvtbUUyxkNJC
	 9MUHlwCJlGtU6yWN5sro5tLL1jS4O6wIH6VG/gr591yMjFkzmkuC2mRDw4neu4B4hqYFW
	 DPe9vPPmkaZBKu1rb7JS10fYOdNa+n7SLWsjFb1gkbOUm0nTT+4CUC/W+LpL7AXik2FT/
	 hnvsarlV8h9EW++d4RDAQRlANDYxtP2Y7utQVOt2/6p+MXV8aZi66+ZNo8qU08q8t0ABV
	 rNYuWYPAjLqDcHwQyYqGkAnv2uaUNXlgSbawutWizwP2/xnqu+YKa7l58wbGqug+pbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702693;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MNJP5J4WKXx1jL6OKNbp8AhvMgZ2H2QDlO5rhgruVOs=;
	b=o2xyM/V0G676npuB4E1oHCtqkOPvUVAQ+EjCMZvN2oxzg6/bUi187tnqdOQlUhJGuzXq
	 Y+ZbQdHkZ0+YNlHc1hyE43VWbS88x+PQzbeNbqFdU9zROPWsZ6JISJSIsIwXKgYqkA/X2
	 JKZ9Drv3ljnF6dCTmSbXivPLGnmYrF9VeAo2Ef0Npl4p1FMQo2p2IlWXPa14CJDGlGB7e
	 96BIYReFEof8Ozcw7NsMb6g8A28Mi9c5X8I1jEbeUFctOOuElcbYR+7e9Ew0cMdu6lRVH
	 cz04qNeax+lx89SIL9LgEDBxxVQWN74EhW6bnNVU3Uq1ahAHX74Bk1EwiDQFH4InDFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=iI566ntX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HJdtMKHv;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1B606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D1B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=iI566ntX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HJdtMKHv
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 983427A02DC
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:18:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 26 Nov 2026 09:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795702692; x=1795789092; bh=MNJP5J4WKX
	x1jL6OKNbp8AhvMgZ2H2QDlO5rhgruVOs=; b=iI566ntXHTdZLfcmk7qdDq4bFS
	kpynnJzmRrmn5R2924OWkP9F5MjZ2qaZHsWJFhadCOkLQSgQ6t0JIpqdSKMD+O8o
	qhQEDg3Op4nBBGz9yMxVeya+u6NlUmoxDWMta/mcUv8NlWt3uGj8OFcsLqtBFF3E
	Vsq8/5HeE6H6rmyVvu44kpFjQzhqgwqFTVpQmt0/WgE5BQHBGyiaSunTx9hVuNi4
	Vr2tCgrpZYYmSVzpYqgn4G77qLQCNEMizbQBoRbo9PQhGxo878BAWYgADaHZOOCr
	uqFM4HeVaAGOPD5+HQ83njlQ3ubk3UvEHFht05ltZAil396e4juBCjfqdr1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795702692; x=1795789092; bh=MNJP5J4WKXx1jL6OKNbp8AhvMgZ2H2QDlO5
	rhgruVOs=; b=HJdtMKHvggE7+RNGJDgBoovT16S1PNcJNDtf5AAdJKz21zUweGm
	oP55vdc5uLobKZQeNoPgZ3miLxeoK6ORGTn1dU8Lq3lH4lPlY+zPEiodRdAF3X1R
	agRkGUYwO7wLDSd4vToMcW5kmOxOn2BanC+HjPeb2v/UQ022CYiVOKUiNeAHllYl
	caE1BpZJcdzg7hi5va+wsxs+xRYpIJ2ADoe0Vtu5eOSvEyq9fBDiIUUN6iNUHjmC
	80sw9SM4caQpYm7jod1xqjvSCXdpXZN/axw5z7qDatv1AWumZaPodH5q6XcsbmP7
	V/Jfmig5ObL5dhXiTqfiRmeTgq5qp7MxGtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795702692; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:byfa45rjMamnfvHpc8RE5cPTnoJc+72eUBrM4For9V3FUQf
	vMgPZmXi1jVYkk2yduh4q2jSLKDhKbnlBmGYMedGOJ1Bk6GXcI12jx22CORIeA78
	sAHauf5PDW72gyKSO2fdV0V7fqTYxxUPCsDCStfrxgT425KHrCcodpIWJb+0s5PL
	fgEJyr3ucvitu9fL7WWENvxzVI1mViYGS9FKmqML6l1sZ3LZGMxgru0MTrlwc/+p
	KDdGaIgYsZFt/bQ8IlkYncSWdRdL0sn7RTdRh7U5Ly88iV/VwjCTDUt7v5Zr0Ge2
	/dPGaO9Z4xTyfi4CmH8WMSWKKRHc+Lbqhl9RfEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sP5/+k9JUC/N/GBk3SzvZymX/M6kISK1QaMHhv3s79Q=:NEwlN8C8Wzik88svlKHfW0+dsX9Ibn9g0H9mKGEESqg=;
X-ME-Sender: <xms:pD8Ia5bTq2pFJZFedzuvQ9OPuQs1Kzbxm_sSKhSP9WhixHSeTeIpIQ>
    <xme:pD8Ia_3-8Aj_pYNsVnengVPnyyf4QBlnpN8tFhZS0ywvGA_fuEEClYDbZE6GBk-aC
    YlJ0TWUgN2LmXZF4_wjLLZacyloKYtjVFUPrc5jj5QFdDMNFSo>
X-ME-Received: <xmr:pD8Ia9DkGl-LrQ7UjG-obqI1gwOerbSdLRcJ0xoFmkJZ0NVzvWlesFNjxoX34xJvkxeO8HdfThXrEoP_q2hS5bVehSNxH78>
X-ME-Proxy-Cause: dmFkZTFiveiKlmvLWLeyon3f7kVwyIlsLzRRmR9/KJ4AcwisN9PtMOVP6mPgWvHQ8gQlgr
    SfI1/Z5jbtBTZpW9LKjSpG0J74W2rjIl+xVb1vIuHGCtFDObsodXmQcWf90RIAbQNuz7m0
    vk6awfdjcyhkTflscxH4/8xs+8cIZZrYcfVPKmpsG02LPA2l36AinfTN4QKiUbdcrc/4+G
    GxYSr1rxrVhLhuMKw+nPSEu9jJQbb41xeqgCsaF1GuEgpe6mDGYqpJV/bYPUyNp+eHX1GO
    ibjf6ePY60zQaf5fOfr/QvF8Of9cCNiZfjgPSQ1Y8ekDnR5UcANykPeLuJw9D+JjnjSOJl
    DOk61PMY7y7chdNM4OfVEIuiwzUwvwgJJ76PPZArO55RoVdJO1HpQIlQTpli5zSyfKajCE
    tlHvjSPFsTc5Z5i3EzqpbCfO7AzQTaQ3jYpkBoO6aXKrvkWV1+fEhXsBUf5wDH8L4l4yyl
    GYZj9rK8jlNY9v3viIz9uh3aRDDGbNHuY7gBK5yRp03s7UcDVb7rOs16vqeWY3SKfs1VoZ
    bkexA0zYz9V7d8Eq4Hf7fTw+eb80T2p8rMiDUHWm+TJMJq4+k0Q1myBXBswSLgVvvD53ld
    YDdBYoeiOAlkxEAvSj46ga8IZwDmx7wbAvE6Js37d9P5TeamC/7gsv7n3NOw
X-ME-Proxy: <xmx:pD8Ia7-_cCsLEADKfHD4GkEov8NC3jydgSCk-BOOWok77UPivZ1_yQ>
    <xmx:pD8Ia4WuPpK1QkaFOfl_FJPhXjtxCyjmEN27Ra0pRAaT6Ps2AdnDJQ>
    <xmx:pD8Ia0KcqSSPn_b3HvrjhUPWlb_n-zetRUbPBRXuFnAlA8K3vQMwvg>
    <xmx:pD8Ia8DeHWKt62HwZd5SSR_14F75NIB7pHxaMnKVyYQJWt5bnkN33g>
    <xmx:pD8Ia4rDE1zji04bd-vigh8YFFqxXIX1vmhAwutnbZB6cb_zGQiNxvHk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 09:18:11 -0500 (EST)
Date: Thu, 26 Nov 2026 15:18:32 +0100
From: Greg KH <greg@kroah.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: stable@vger.kernel.org,
	syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 6.1.y] khugepaged: fix readahead lock inversion in
 collapse_file()
Message-ID: <2026112627-anagram-unselfish-0719@gregkh>
References: <20261109201858-failed-6.1-eadce52a9ef6@kernel.org>
 <20261111132506.88827-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111132506.88827-1-lance.yang@linux.dev>

On Wed, Nov 11, 2026 at 09:25:06PM +0800, Lance Yang wrote:
> collapse_file() can call page_cache_sync_readahead() while still holding
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for
> invalidate_lock and neither side can make progress.
> 
> We need to release those folio locks before starting readahead. On a page
> cache miss, roll back first, populate the collapse range, and retry once.
> Doing readahead after rollback avoids an extra pass when all folios are
> already present. If another miss occurs on retry, give up rather than keep
> retrying while truncate or reclaim removes folios.
> 
> Keep page_cache_sync_readahead() and wait for read I/O with
> filemap_lock_folio(), releasing each folio before moving to the next. The
> existing uptodate check during collapse still handles read errors.
> 
> Shmem uses shmem_get_folio() for swapin and fallocated folios without
> taking mapping->invalidate_lock, so it is unaffected.
> 
> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Link: https://patch.msgid.link/20261026152013.10511-1-lance.yang@linux.dev
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> (cherry picked from commit eadce52a9ef657d561b3e76c9b5f178bd99735f5)
> ---
> Backport to 6.1:
> - Use find_lock_page(), unlock_page() and put_page() for the existing
>   page-based collapse code.
> 
>  mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-

Does not apply :(
