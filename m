Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202865;
	b=cezLSJ/5dned0xuqOtAmGvU7jH4w73cBY8SO3+NG0yrDeH9RcKfEbS5JSesJQ+YJzEGR
	 j8r2rLcYJj04nXku3I8dZO5g1glCIdoo079X8Y2wtm+wSnjhxR9A6gU+MoeycH08l7qxN
	 2S7rN3xRwTRGw2U0eo5qGLRDtcy0/v2uwfrPxuqmrSOtYQMuvQ4CYRWgktrJ+5Q1cKubw
	 Nul3XFL3ED99fQs/Ty30/li55bNEGdhDbc6eqDiDaNoOcZvoemrSZQQZS6RaNw92XRJS/
	 59UXC6e7zGjVZHIm5i+5CdzSO5l9Y3kq6eSKPgu8UfSD7FhvvnfySFGNGlLQyCiFUyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202865;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tTZpPE9gJn7s96098K7j6uvB27YaMf32yiUhWF9ATX4=;
	b=UCRvB8NQREsEiACs2FR86N7mvLhLMryAoz6vNoI8EjwG4eRybt21KT5or0gsKXKEvCJo
	 qFE+dC5C4UjWfo41uUu2SbSnulCI3A0Xo5RmhiWNv6aNaNQCo0UoHJUApiCOikaTHrtE5
	 iKz1wPjvmCLkAgFZIyx1+Xr0gJJDlt9OPEJ8okbW9xTMPs0L7JSIypzODJcwmLRomYs7z
	 zjIfUSh07n31fLSAw+/0iPNIcBoX/V05ciKHAS587ULHWU/q4wKkhwHJK8vfwl5STiF8M
	 R6DMI2vIB6Y3xvh+kIw7bLvFSgXWQeMhEyENDUoBRbGS6sV4G3qzcmQXF1j/r6DNv0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bIPJgOc3;
	arc=none smtp.remote-ip=91.218.175.79
Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF060A2602
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AAF060A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bIPJgOc3
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tTZpPE9gJn7s96098K7j6uvB27YaMf32yiUhWF9ATX4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793202859; v=1; x=1793807659;
 b=bIPJgOc3iPcKTa1DXojN+YH2KEJcCalwAlquT1K3q2vP78rezERhjcEiyPnYf3XJJi+zm40e
 VZ8Y7h0Sg0LHwZ3RIB6hSZlxVJqtHyTLtmTMwa/Q5NiV5ZlDRHprLtwNr+zvun7UOnbjrZLyZOI
 1EXHQla+Wo0nAnoYaUtKJ62U=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f81f3d53b1ebb019;
	Wed, 28 Oct 2026 15:54:18 +0000
X-Mizu-Trace-ID: f81f3d53b1ebb019
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 13/46] mm/huge_memory: fix truncate racing with PMD zapping
Date: Wed, 28 Oct 2026 23:54:11 +0800
Message-ID: <20261028155411.50458-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-13-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-13-6f74bec9a5bb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Oct 27, 2026 at 12:17:33AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
>If this was the last mapping, truncation can skip unmapping the folio
>and proceed without waiting for the PMD lock, racing with dirtying.
>
>ifs_set_range_dirty() can oops if MADV_DONTNEED races with
>ftruncate() on XFS, when we get the folio set dirty after it was found
>to not be mapped anymore.
>
>Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
>matching the PTE zap path. This keeps the folio mapped while updating
>its state, so truncation must wait for the page table lock.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify comment and description ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Good catch!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
