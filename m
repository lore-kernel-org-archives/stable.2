Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307136;
	b=5lO7kGjqDMo5ZwEQYXNMKg4fBam+poE5I5HD/hdzo/uk/AVxF8LasJg6zzwLnJ7GIRiS
	 T1VG6aHHi75ejZFPNpsfttgPS8iZuux1pEYzl/RK6tCRick1VfudriZX5K9YLYfkd/2Fq
	 KSI1TEj2dsDJqv+THMMdVg+KUqSYOZfpoCX4QdmbG2oOBm6m7hDrmMpPrIEFU2EBqhhU/
	 lMOyELE74/JItboCckp5WJmWwwVVsuscvdNDbTRNt5Mm2GlcRXRlDoVZbAHDmYHE0SSTv
	 yde1TCMX7qRbUGkTtkAtqoUpUD68bgs5VlkrsF2HZSDH/sKoBr3YytxI0tJD9JwpXZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307136;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=023i2+dmwmesxURH+DXS8VlOtNZE9VJsDp+NWBjJ6ZU=;
	b=F5arFigWwAD4bIhMgj19ttNmvPJuvZUUVQi1cjAf8RkCMGXDN9MMgy4TkJkcIsb8Ffnf
	 zN+b38B1ZIfLYCCOs3tw6+Sglz8HKjdrkldTLBX3vmd9gc4YUAZTI7v6W4cgQ0sYKbX1I
	 H+zd4v40T5vMLTK2YAVHFJK9XLx7ltUrkWaJTiZ/8N9Ldl5SEsH8Cp/pBPBU37aaHPfDV
	 KmgX/CVhiE8rryl1MheO2P/VCvxtu2y7R9+9lg8LPr6MzBtWx29T0eNS/xa7ab9E2tHSK
	 1VLXb+IdD2m/J3n9XmgAXf4eZnGPmraqCSYznUzZnwjJemTISSIKgREDDfFCRo0JBHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjtELPH7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E9606A31C;
	Tue, 10 Nov 2026 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjtELPH7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDBE1F008A3;
	Tue, 10 Nov 2026 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307135;
	bh=023i2+dmwmesxURH+DXS8VlOtNZE9VJsDp+NWBjJ6ZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YjtELPH7ceqREpK01mrgwYINdmit7Nc6FazA2KMh42Y2fQivlCCTZvXa3NBYX4LE9
	 tJvuAY3NUF1xRV2GvwgYgVu1HJkCSxFo8SdqSecuchD99X0otGjfMpd2mtaZbcJDXg
	 v4wRN7kHl4YIwQeVByP/Xt+Adkmjz9J8X9AJcFuetMyjOtp8DyoEVgdDIMtCXldDXQ
	 x9RpxGFwj9od0iSBv9SKQsYAZ7HrAUnfMo96dH4oQfG9wjQn1M2/dqofT8KVchQYsw
	 BNtEAb0fk57KYgxrL5HTD5muQ/7uTfbWMc7umRN8QM5h4kkT/KOiMq+rAwg7mO67dh
	 Mt/stp0jFeRCQ==
Message-ID: <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Date: Tue, 10 Nov 2026 11:38:39 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
To: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 23:23, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject
> additional references when splicing folios into a pipe if the refcount
> is at its limit, similar to how we handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
> progress, so do_splice_read() can fall back to copy_splice_read() when
> read_iter is available. This keeps sendfile() and other splice users
> working when ordinary reads would still succeed.
> 
> Also fall back to copying in FUSE when taking another reference through
> fuse_ref_folio() would exceed the limit.
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/fuse/dev.c      |  5 +++--
>  fs/splice.c        |  8 +++++++-
>  include/linux/mm.h |  9 ++++++---
>  mm/filemap.c       | 11 ++++++++---
>  mm/shmem.c         |  4 ++++
>  5 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3641abb90d6bb..4f6b7b42bfd3e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>  		if (cs->write && cs->pipebufs && folio) {
>  			/*
>  			 * Can't control lifetime of pipe buffers, so always
> -			 * copy user pages.
> +			 * copy user pages. Also copy folios at their refcount limit.
>  			 */
> -			if (cs->req->args->user_pages) {
> +			if (cs->req->args->user_pages ||
> +			    unlikely(folio_ref_count_over_limit(folio))) {

Linus points out off-list (thanks!), that fuse_ref_folio() should have
really used try_get_page() right from the start.

And that we should just not fallback to a copy, in particular,
if the refcount is invalid (<= 0).

So the following is what I have for now. Once we remove the limit
handling again, that code won't change, which is good.

I went back and forth with folio_get_checked() naming, but decided to
not mix in the "try" as that just reminds of our speculative refcount
handling. (folio_try_get_checked / folio_try_get_referenced)

I'll send a cleanup to rename try_get_page() later.

I played with using the new helper (folio_get_checked()) also in patch #1,
but it resulted in too much churn for something that is supposed to
be a temporary fix, so I'll leave that in place.


From 00e58e422e28126cfa381d4b877ccd488f4e5609 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 4 Nov 2026 19:02:48 +0100
Subject: [PATCH 1/1] mm: limit pagecache folio refcount when splicing into
 pipes

Similar to mapping pagecache folios into page tables, let's reject
additional references when splicing folios into a pipe if the refcount
is at its limit, similar to how we handle it during GUP.

This will prevent more cases of possible folio refcount overflows with
large pagecache folios.

Introduce folio_get_checked() for checked reference acquisition when
the caller already holds a reference. It warns and fails on a non-positive
refcount and rejects additional references at the limit.

Use folio_get_checked() in splice_folio_into_pipe() and
fuse_ref_folio(), returning -EFAULT on failure, like we already do for
pipe-buffer duplication. Similarly, make try_get_page() use it instead.

Likely try_get_page() should be renamed (or removed) later, as it doesn't
match the folio_try_get() semantics and is confusing.

If we hit the limit after splicing some data, return the number of bytes
already spliced. Teach the callers to handle errors, and stop
filemap_splice_read() if we only spliced part of a folio, so we don't
skip ahead to the next folio.

The check in try_get_page() also covers pipe-buffer duplication by tee()
and partial pipe-to-pipe splicing.

Note that we deliberately will not fall back to the slow path of copying
the folio, particularly as the folio might have an invalid refcount. If
it is ever really required, we can revisit.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/fuse/dev.c      |  4 +++-
 include/linux/mm.h | 26 ++++++++++++++++++++++----
 mm/filemap.c       | 26 ++++++++++++++++----------
 mm/internal.h      |  4 ++--
 mm/shmem.c         |  7 +++++--
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3641abb90d6b..50f41bb28783 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1230,7 +1230,9 @@ static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
 	if (cs->nr_segs >= cs->pipe->max_usage)
 		return -EIO;
 
-	folio_get(folio);
+	if (!folio_get_checked(folio))
+		return -EFAULT;
+
 	err = unlock_request(cs->req);
 	if (err) {
 		folio_put(folio);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cccc786465a7..c1baeb7823ee 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2287,15 +2287,33 @@ static inline void get_page(struct page *page)
 	folio_get(folio);
 }
 
-static inline __must_check bool try_get_page(struct page *page)
+/**
+ * folio_get_checked - Try to acquire a reference to a live folio.
+ * @folio: The folio.
+ *
+ * The caller must already hold a reference to @folio. Warn and fail on a
+ * non-positive refcount, and refuse additional references at the limit.
+ *
+ * Use folio_try_get() for speculative reference acquisition where the
+ * refcount can legitimately be zero.
+ *
+ * Return: True if the refcount was incremented, false otherwise.
+ */
+static inline __must_check bool folio_get_checked(struct folio *folio)
 {
-	page = compound_head(page);
-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
+	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return false;
-	page_ref_inc(page);
+	if (unlikely(folio_ref_count_over_limit(folio)))
+		return false;
+	folio_ref_inc(folio);
 	return true;
 }
 
+static inline __must_check bool try_get_page(struct page *page)
+{
+	return folio_get_checked(page_folio(page));
+}
+
 /**
  * folio_put - Decrement the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/filemap.c b/mm/filemap.c
index 0f6d57432a7e..e6e73e37f3ea 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3047,10 +3047,11 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 EXPORT_SYMBOL(generic_file_read_iter);
 
 /*
- * Splice subpages from a folio into a pipe.
+ * Splice subpages from a folio into a pipe. Return the number of bytes spliced,
+ * or -EFAULT if we cannot splice from the folio.
  */
-size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-			      struct folio *folio, loff_t fpos, size_t size)
+ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			       struct folio *folio, loff_t fpos, size_t size)
 {
 	struct page *page;
 	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
@@ -3063,13 +3064,15 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 		struct pipe_buffer *buf = pipe_head_buf(pipe);
 		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
 
+		if (!folio_get_checked(folio))
+			return spliced ? spliced : -EFAULT;
+
 		*buf = (struct pipe_buffer) {
 			.ops	= &page_cache_pipe_buf_ops,
 			.page	= page,
 			.offset	= offset,
 			.len	= part,
 		};
-		folio_get(folio);
 		pipe->head++;
 		page++;
 		spliced += part;
@@ -3094,9 +3097,10 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
  * Return: On success, the number of bytes read will be returned and *@ppos
  * will be updated if appropriate; 0 will be returned if there is no more data
  * to be read; -EAGAIN will be returned if the pipe had no space, and some
- * other negative error code will be returned on error.  A short read may occur
- * if the pipe has insufficient space, we reach the end of the data or we hit a
- * hole.
+ * other negative error code will be returned on error; -EFAULT will be returned
+ * if acquiring a folio reference fails and no data has been spliced.
+ * A short read may occur if the pipe has insufficient space, we reach the
+ * end of the data, hit a hole or hit a folio refcount limit.
  */
 ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			    struct pipe_inode_info *pipe,
@@ -3154,7 +3158,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
-			size_t n;
+			ssize_t n;
 
 			if (folio_pos(folio) >= end_offset)
 				goto out;
@@ -3170,13 +3174,15 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 			n = min_t(loff_t, len, isize - *ppos);
 			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
-			if (!n)
+			if (n <= 0) {
+				error = n;
 				goto out;
+			}
 			len -= n;
 			total_spliced += n;
 			*ppos += n;
 			in->f_ra.prev_pos = *ppos;
-			if (pipe_is_full(pipe))
+			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
 				goto out;
 		}
 
diff --git a/mm/internal.h b/mm/internal.h
index b129510b92e2..08e259758937 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1276,8 +1276,8 @@ struct migration_target_control {
 /*
  * mm/filemap.c
  */
-size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-			      struct folio *folio, loff_t fpos, size_t size);
+ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			       struct folio *folio, loff_t fpos, size_t size);
 
 static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index be4ab228cf67..8b94877c36c1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3751,7 +3751,8 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 	struct inode *inode = file_inode(in);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio = NULL;
-	size_t total_spliced = 0, used, npages, n, part;
+	size_t total_spliced = 0, used, npages, part;
+	ssize_t n;
 	loff_t isize;
 	int error = 0;
 
@@ -3837,8 +3838,10 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			n = splice_zeropage_into_pipe(pipe, *ppos, part);
 		}
 
-		if (!n)
+		if (n <= 0) {
+			error = n;
 			break;
+		}
 		len -= n;
 		total_spliced += n;
 		*ppos += n;
-- 
2.43.0




-- 
Cheers,

David
