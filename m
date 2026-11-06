Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956317;
	b=iP2Hy4VdQ1IIHeUByPzhUc4K3IYn2pH09D2umLWDuZfaPqVhmMoexRi2bZvrKUbgfLS8
	 S/ec79RfJGVWydjQdczTm+p63aZRLlNPpJ72i4DuOoJpPVaXhNYQdYOpHceneQlUUlZrS
	 Ui15OL8RLt8rj5gr0+xXhOHE5dul9URyKowoO+4be8o6sRWq/TLXQHWZNxO/+uMjh5gAN
	 rpNSBbVYO4sowGCxh0YRISLX4Ex2vj3hS4YLppZ+smjyFMlIlBTORqqRY43Tc/okIGFOG
	 nHFFSbUUSuP7gtaf4Y1Sq1qif/yIhFWD306fkRFHbO02xVYvwywW7Es7iICh0OBaRmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956317;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AKi4F1XkSqKNw3b7+Ng4uXx+ZMXFkYDoN/Pwc1tdXyw=;
	b=Sbx/BSXB8wR2p53cPjbksmd/JP7faWFoU7bQOUcZFVHjVjH7ayjvkLgqMsyAy0pktAz3
	 tjTa/6UUUN61jyW2Nn6kjNUlMruPyNVt6ykJVW6ogGhmDql1yMM8SrGBQT5ZJKic/30rQ
	 Q4mhOD6AzfugOqvZM5wk8ULBFjtlTZLBzxJbsbhnQq631dl70lB/y+z/qZ8Q1hMPIkJCw
	 ovEi2fPwRkxS8jP5kPUJ/PU2f5e5cNvPH7e+dvdwbvxLupdgSVA3CYxOXRBNICJsykPIW
	 AjKVmqsIZHBeskKQ4ts3a9ib22gFz5a86eJ9N0xfF5bOkDmCvTnrnOvL5gpBvuaT7VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SP14kqgH;
	arc=none smtp.remote-ip=91.218.175.11
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB7606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9DB7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SP14kqgH
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RB9jCfeGXFtAeNZRCJe7qF1HA2DzPZCiRtQ6f8rlwO8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793956308; v=1; x=1794561108;
 b=SP14kqgHZegobLguKceMWVRaaEf3xj0wYia2VHIJv7nrvC8v/x1oCpRu272qEx3kMDDC6SEE
 DlL0PmcvKPbKwAj+xL2YncyuVQl1aPxY6vKPhNcd0sk3NnzrIjyjhtFA8ayH6u8Qep1tmr357io
 IqEHRdCNdAzL3+8AVKpJKnLM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a5d8b693a372ae24;
	Fri, 06 Nov 2026 09:11:48 +0000
X-Mizu-Trace-ID: a5d8b693a372ae24
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	peterx@redhat.com,
	hannes@cmpxchg.org,
	songliubraving@fb.com,
	riel@surriel.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	robin.murphy@arm.com,
	steven.sistare@oracle.com,
	jhubbard@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
Date: Fri,  6 Nov 2026 17:11:39 +0800
Message-ID: <20261106091139.67845-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
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


On Thu, Nov 05, 2026 at 02:10:10PM +0100, David Hildenbrand (Arm) wrote:
>With large file folios, overflowing the folio mapcount and refcount
>became possible. For anon folios it is currently not really an issue:
>each large anon folio can only be mapped once into a process.
>
>That's not really big news, but it's about time that we do something
>about it because some modern technology might find ways to abuse it :)
>
>One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
>refcounting"), however, file thp support was added later.
>
>File folios can be mapped multiple times into the same process, allowing
>for processes to hold many references to the same folio.
>
>As a short-term solution, let's introduce two folio refcount limits:
>one for ordinary consumers and one for admins. Leave some headroom
>before the refcount goes negative, which we really don't want (having
>the mapcount go negative is also not expected).
>
>Start reporting SIGBUS if we run into limits. When restoring mappings
>from migration entries, instead zap the pte/pmd entry. We allow for
>slightly exceeding the limit to keep things simpler.
>
>This is far from ideal, but better than all easy alternatives we can
>backport comfortably. For now it fixes the big problem: letting
>the refcount (+mapcount) go negative and cause trouble.
>
>This is only a temporary fix, we'll follow up with something better.
>
>While the refcount checks are not required for order 0 folios, let's
>just add them for consistency: each folio_add_file_rmap*() and
>folio_dup_file_rmap*() needs a prior check.
>
>Also, just document -EHWPOISON for copy_present_ptes() while at it.
>
>Reported-by: Chris Mason <mason@kernel.org>
>Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
> mm/filemap.c       |  6 ++++++
> mm/huge_memory.c   | 24 ++++++++++++++++++++++--
> mm/memory.c        | 23 ++++++++++++++++++++---
> mm/migrate.c       | 11 +++++++++++
> mm/userfaultfd.c   |  4 ++++
> 6 files changed, 96 insertions(+), 5 deletions(-)

Nice work! I just went through all folio_add_file_rmap*() and
folio_dup_file_rmap*() callers, including callers of set_pte_range().

All covered, looks good to me1

Reviewed-by: Lance Yang <lance.yang@linux.dev>
