Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959413;
	b=2sDnjJqdVDgjZ5cl1YJ9vvp4NfplmoBXC5eKyf900O53TEFplk2YZk15Lg741Gohs/3G
	 IV00a4ERrZksQQJuXlLXYirgw98zIF8CwQyxAE5Zql9n/yB4jtjY0mogIhVmYlmq291JH
	 4WANJ+AgZypoEXPjIEznt1nHb5qovXw2JIaI7SoYrcIvnwQP3TChX8yu7hZx42XP60QOJ
	 nJoz7Pv89HUAHTVU+8QyOlgPhYv6pr/GlPZO2RdLucKV20sf8pQ3CfW38M4N1dd9vC/8J
	 Brbt5uenNNYaaQN3R9KpRMJATpuP570Pg441kjCspfe5G0KN01qOt7QIpnUMH03JDaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959413;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rMheU+EhCPcWnJV6yby7BQW3sus9xoZHDLVucVGtR10=;
	b=ZEG45F1feN05PpTkHwfzyZ7SLBXF80BJl8njsRsFP2uBQaClrQC52ar5lMATr4vK2kfn
	 RCA3PBqqLn7iS53KN/80dCdMGbZEGGnbJArlokahjkOpUW6y1LImwNX+KvaKU3bz94mTp
	 kAwEICS/gV9A/9i4l/TYNs0rN69mZZKJCX4jPBDo6WXW8BfgqYJmZCgUt6FjYGVX/3HTQ
	 K3XkfKDee4osHScHYuvodso+kKGb5G05QHlOX4wAM2/0TDfsml3UDihT8km2OwwFqj6gX
	 /zuezMoKomAnl81xfBbizqgwPX1yY+AG3PQtYg4wkkPA3aOh/x8qowIhhZUNBW1FiLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K70IeZK4;
	arc=none smtp.remote-ip=95.215.58.11
Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86239606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 10:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86239606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K70IeZK4
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HebWn3oEvn+Xp5ULYEc4RbMXXdDqctn1MVk/JQNM9Qc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793959408; v=1; x=1794564208;
 b=K70IeZK4ChyvsIjWjnf+4PyYUZUZL+M7DAGxBjGVRAmkn4E59xs9gXe+dS1tEo52DLU3NhHk
 wXzvG7P/tU2y7zNLQsSQnRMcfXQ4yMM+F2CZjQk+ARRmJKVphNGgrmSLhAxkOKraKZmY/dMWglf
 06tBoeDwOxOfZFLyydTEs3CE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cd637f8f166aebf7;
	Fri, 06 Nov 2026 10:03:28 +0000
X-Mizu-Trace-ID: cd637f8f166aebf7
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
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing into pipes
Date: Fri,  6 Nov 2026 18:03:20 +0800
Message-ID: <20261106100320.77084-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
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


On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
>Similar to mapping pagecache folios into page tables, let's reject splicing
>folios into a pipe if the refcount is at it's limit, similar to how we
>handle it during GUP.
>
>This will prevent more cases of possible folio refcount overflows with
>large pagecache folios.
>
>Let's keep it simple and check in the two callers of
>splice_folio_into_pipe().
>
>Also check in try_get_page() to cover pipe-buffer duplication by tee()
>and partial pipe-to-pipe splicing.

What about fuse_ref_folio()? Buffered FUSE_WRITE requests can carry
pagecache folios into a pipe through /dev/fuse without going through
splice_folio_into_pipe() or try_get_page() ...

Cheers, Lance

>Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> include/linux/mm.h | 9 ++++++---
> mm/filemap.c       | 4 ++++
> mm/shmem.c         | 4 ++++
> 3 files changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 79ae8fc0d6bb4..a82cfbce18215 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
> 
> static inline __must_check bool try_get_page(struct page *page)
> {
>-	page = compound_head(page);
>-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>+	struct folio *folio = page_folio(page);
>+
>+	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> 		return false;
>-	page_ref_inc(page);
>+	if (unlikely(folio_ref_count_over_limit(folio)))
>+		return false;
>+	folio_ref_inc(folio);
> 	return true;
> }
> 
>diff --git a/mm/filemap.c b/mm/filemap.c
>index 920bbf86dfdff..0f2ec790a5b65 100644
>--- a/mm/filemap.c
>+++ b/mm/filemap.c
>@@ -3168,6 +3168,10 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
> 			if (writably_mapped)
> 				flush_dcache_folio(folio);
> 
>+			if (unlikely(folio_ref_count_over_limit(folio))) {
>+				error = -ENOMEM;
>+				goto out;
>+			}
> 			n = min_t(loff_t, len, isize - *ppos);
> 			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
> 			if (!n)
>diff --git a/mm/shmem.c b/mm/shmem.c
>index cda1a0f7db99d..1c0f6bceac486 100644
>--- a/mm/shmem.c
>+++ b/mm/shmem.c
>@@ -3819,6 +3819,10 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
> 			 * Ok, we have the page, and it's up-to-date, so we can
> 			 * now splice it into the pipe.
> 			 */
>+			if (unlikely(folio_ref_count_over_limit(folio))) {
>+				error = -ENOMEM;
>+				break;
>+			}
> 			n = splice_folio_into_pipe(pipe, folio, *ppos, part);
> 			folio_put(folio);
> 			folio = NULL;
>
>-- 
>2.43.0
>
>
