Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAF3988E0
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069383; cv=none; b=KHhp4CZnGqQI8N2LOYWS3DtXiPEgUqpSC8YgAQBqVjOH5Nu3tXv5h1ApVxe2BpUYuDnSBObuc+UsW1ylw8PqCRVNmgogui6dGnAFt8sZ2oZBmU7XIwqRZJhmLxk01QJKdoYIDk4s+Dq+LDPynf0Wvaq3uWAJrK6j5ff0a9DMJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069383; c=relaxed/simple;
	bh=JAwPI/hmIxe2EFHyscxT9tmXGIEsrX5r+QlEOoqDRv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBoFzpSA+8GNpl+WyD99f9ZUSbiyvNpcC3tdcDYLthmO/L0eY2Yb+VvOA/oQKQA0NIyFKtQGIWrnye480JII40c7X4zGzCChgtY8pfoaEj+LvG6oge8p/Yuej/Yi67xNlhBq48Nk+vmUz28pSzv8PNWb3ZNCnYnM6Fhze/d8m2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pJSxGIwi; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pJSxGIwi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783069369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzXLulUbBSbZLvJAq7z0tj7+rdC0gx8arHAJzkhxD9k=;
	b=pJSxGIwiCViVhM7YfkOworfjBjsSN6hJ51Ojh+C07ZWE94Uigy7V2fl54i7o2f54b17f9n
	SGqOyOgHBjWFc29laKmIvkt1gCeQ6vVeZ57eAnm6JMmZllpxQgcWkH30BRjMWNi6pGFt8r
	cCL2HmJEDDTUmc3Ct0RnBM4vYIRPkOA=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: pfalcato@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	song@kernel.org,
	ehagberg@janestreet.com,
	ziy@nvidia.com,
	gleventhal@janestreet.com
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when collapsing
Date: Fri,  3 Jul 2026 17:02:32 +0800
Message-Id: <20260703090232.26261-1-lance.yang@linux.dev>
In-Reply-To: <e924bed9-4c46-4fe3-b6cd-7c77fd9e25c8@kernel.org>
References: <e924bed9-4c46-4fe3-b6cd-7c77fd9e25c8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jul 03, 2026 at 10:55:42AM +0200, David Hildenbrand (Arm) wrote:
>On 7/2/26 18:54, Pedro Falcato wrote:
>> As-is, khugepaged and writable-file opening exclude each other. A file
>> cannot be open writeable and have THPs (because the filesystem is not aware
>> of them). khugepaged will never collapse file pages for files that are
>> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
>> particular file is dropped. This is fine because nothing could've been
>> dirtied.
>> 
>> However, there is an edge-case: collapse_file() might not be able to
>> coexist with concurrent writers, but it can coexist with dirty folios
>> (from previous writers). Therefore, the following can happen:
>> 
>> open(file, O_RDWR)
>> write(file)
>> close(file)
>
>Okay, folios are dirty.
>
>> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
>
>collapse_file() has
>
>	if (!is_shmem && (folio_test_dirty(folio) ||
>			  folio_test_writeback(folio))) {
>		...
>		result = SCAN_PAGE_DIRTY_OR_WRITEBACK;
>		goto out_unlock;
>	}
>
>Making us abort collapse.
>
>What am I missing?

Hmm ... dirty folios can be outside the range being collapsed ...

For example:

  write/dirty:      [6M, 8M)
  MADV_COLLAPSE:    [0M, 2M)

collapse_file() only checks the folios in the collapse range, so the
dirty/writeback check passes for [0M, 2M). But after that, for the old
READ_ONLY_THP_FOR_FS case, nr_thps gets bumped for the mapping.

Then a later writable open can hit ...

  filemap_nr_thps(mapping)
    -> truncate_inode_pages(mapping, 0)

and that drops page cache for the whole mapping, including the dirty
folios at [6M, 8M) ...

Cheers, Lance
