Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489869;
	b=dAcoXEwdwGY2yZWZ/BD2pGfe0V9vJOQNivRNidiqA5+MSBmjUYhYe7wnPbMXjxvBWFLZ
	 AYH3iJVeXr7xtLV4cxOtNC+/h9rr18iduQTfwBkSyZcIi/6Z9xGB5UWt14b05oTtMRPox
	 7OWm5H38FT4SNQRxVRZ2HdP8vt4o7oRYD585Bqmb8KgCkqtnmD/pFREAwZOy22k2Dv3nQ
	 lZ2gvYG/78xZFBLpMGdgefYgt/lDHa9CI9ZDTRf5EYx8UWR0WFWFw+ho+JlIG/4/oo/Us
	 tG+EFxnw0tUzsqqazA/Pneb4HPaisxwxSTX3Z5GKkL5vrRnWe/PNgPeEDSQD7phdq1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489869;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7xmjRmraj6hajKCrG/rMZBddCcIUHPD2VWLoAxsDBOs=;
	b=fsEeFM/y58K8clIvX4WioB/WtweZMe/JF8dq9nqn/xm6Jrvl7AO8qCCo04LGzSVULoeh
	 JI58ldctRvlVqhdqAxYD2n0ZmA+GNRdYSP+tr6WcFBHg4EEtH9lcnFP0L2H+kzPA0njYE
	 otOhUuWrC348u5FbbjnRa3gwwv+toRkUMUdS2GNc/O5ezRu1SQtIsrV3XkenYmXv14U74
	 irJsYjfwPUQ0D/sEIBa4YUh+NuGBrD5WmZf9zoxqM/1CbR/Uq1z7CGW+FR/iEC7EfetyM
	 1agAQPThcGQjmt+y9Y2IaFZu+rdjzv10snMU3h72eR2KfKBuuFxrYEUkqDQVW3j58og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKMrbqce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C056606A31C;
	Thu, 12 Nov 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKMrbqce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4522E1F00A05;
	Thu, 12 Nov 2026 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794489869;
	bh=7xmjRmraj6hajKCrG/rMZBddCcIUHPD2VWLoAxsDBOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lKMrbqcelcaBTBGaUr87HDTzI186L8p7uxe/R71dZb5jnFEWOt2ZzD+umyEqWRurC
	 JT0tVrTFJvZ2ZWIjLFu9OHHqm3J9lqfi6fJk5xJdAarAHcppGuLg2Wov53d2v/n98j
	 EyrlI+Au+8f4CMeYPUR6+pOyTfsWkNMtXIX/sVRTcpT/txuHalkPKrCX0a6Pttvq7f
	 B1YhwwMB+oqZa1vAa/s67LjWAKW3YR+CjtLXB0YtFwBnF2u+vyg40wLqnuDPKWU6R2
	 84mtk/sQzGKh76nBjk/kgwfOhINXcdtQzO3rZ2tN8H8HMi2IhHb0KNkgTawloAbWvW
	 HCyhuk1jMYGDQ==
Message-ID: <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
Date: Thu, 12 Nov 2026 14:24:09 +0100
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
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
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
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
 <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 14:09, Pedro Falcato wrote:
> On Tue, Nov 10, 2026 at 09:35:42PM +0100, David Hildenbrand (Arm) wrote:
>> Similar to mapping pagecache folios into page tables, let's reject
>> additional references when splicing folios into a pipe if the refcount
>> is at its limit, similar to how we handle it during GUP.
>>
>> This will prevent more cases of possible folio refcount overflows with
>> large pagecache folios.
>>
>> Introduce folio_get_checked() for checked reference acquisition when
>> the caller already holds a reference. It warns and fails on a non-positive
>> refcount and rejects additional references at the limit.
>>
>> Use folio_get_checked() in splice_folio_into_pipe() and
>> fuse_ref_folio(), returning -EFAULT on failure, like we already do for
>> pipe-buffer duplication. Similarly, make try_get_page() use it instead.
>>
>> Likely try_get_page() should be renamed (or removed) later, as it doesn't
>> match the folio_try_get() semantics and is confusing.
>>
>> If we hit the limit after splicing some data, return the number of bytes
>> already spliced. Teach the callers to handle errors, and stop
>> filemap_splice_read() if we only spliced part of a folio, so we don't
>> skip ahead to the next folio.
>>
>> The check in try_get_page() also covers pipe-buffer duplication by tee()
>> and partial pipe-to-pipe splicing.
>>
>> Note that we deliberately will not fall back to the slow path of copying
>> the folio, particularly as the folio might have an invalid refcount. If
>> it is ever really required, we can revisit.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---

[...]

>> +static inline __must_check bool folio_get_checked(struct folio *folio)
>>  {
>> -	page = compound_head(page);
>> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
>>  		return false;
>> -	page_ref_inc(page);
>> +	if (unlikely(folio_ref_count_over_limit(folio)))
>> +		return false;
> 
> Ah nice, the helper I wanted :)
> 
> Nit: Having these two functions called back-to-back will result in two
> separate loads on the refcount (folio_ref_count() distills into a READ_ONCE).

Ack, something to optimize. I'd likely leave that for future work, as we'd need
yet another helper.

Unless I can convince myself that it is easy to do.

> 
>> +	folio_ref_inc(folio);
>>  	return true;
>>  }
>>  
>> +static inline __must_check bool try_get_page(struct page *page)
>> +{
>> +	return folio_get_checked(page_folio(page));
>> +
> 
> God I hate this. I never realized try_get_page() isn't atomic, but
> folio_try_get() is.

Yeah, but that's for another purpose and more expensive.

> 
>> +
>>  /**
>>   * folio_put - Decrement the reference count on a folio.
>>   * @folio: The folio.
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 0f6d57432a7e5..e6e73e37f3ea4 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3047,10 +3047,11 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>>  EXPORT_SYMBOL(generic_file_read_iter);
>>  
>>  /*
>> - * Splice subpages from a folio into a pipe.
>> + * Splice subpages from a folio into a pipe. Return the number of bytes spliced,
>> + * or -EFAULT if we cannot splice from the folio.
> 
> -EFAULT is a weird error code to return from splice, et al.

We might be able to use ETOOMANYREFS (have to check if that could confuse
callers), but IMHO EFAULT is good enough.

What would be your suggestion?

> 
>>   */
>> -size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>> -			      struct folio *folio, loff_t fpos, size_t size)
>> +ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>> +			       struct folio *folio, loff_t fpos, size_t size)
>>  {
>>  	struct page *page;
>>  	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
>> @@ -3063,13 +3064,15 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>>  		struct pipe_buffer *buf = pipe_head_buf(pipe);
>>  		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
>>  
>> +		if (!folio_get_checked(folio))
>> +			return spliced ? spliced : -EFAULT;
> 			return spliced ?: -EFAULT;
> 
> I don't know if there's much kernel code out there doing this, but I like
> the trick :)

There are a couple of thousands, but yes, one doesn't encounter it that often.

> 
>> +
>>  		*buf = (struct pipe_buffer) {
>>  			.ops	= &page_cache_pipe_buf_ops,
>>  			.page	= page,
>>  			.offset	= offset,
>>  			.len	= part,
>>  		};
>> -		folio_get(folio);
>>  		pipe->head++;
>>  		page++;
>>  		spliced += part;
>> @@ -3094,9 +3097,10 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>>   * Return: On success, the number of bytes read will be returned and *@ppos
>>   * will be updated if appropriate; 0 will be returned if there is no more data
>>   * to be read; -EAGAIN will be returned if the pipe had no space, and some
>> - * other negative error code will be returned on error.  A short read may occur
>> - * if the pipe has insufficient space, we reach the end of the data or we hit a
>> - * hole.
>> + * other negative error code will be returned on error; -EFAULT will be returned
>> + * if acquiring a folio reference fails and no data has been spliced.
>> + * A short read may occur if the pipe has insufficient space, we reach the
>> + * end of the data, hit a hole or hit a folio refcount limit.
>>   */
>>  ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>>  			    struct pipe_inode_info *pipe,
>> @@ -3154,7 +3158,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>>  
>>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>  			struct folio *folio = fbatch.folios[i];
>> -			size_t n;
>> +			ssize_t n;
>>  
>>  			if (folio_pos(folio) >= end_offset)
>>  				goto out;
>> @@ -3170,13 +3174,15 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>>  
>>  			n = min_t(loff_t, len, isize - *ppos);
>>  			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
>> -			if (!n)
>> +			if (n <= 0) {
>> +				error = n;
>>  				goto out;
>> +			}
>>  			len -= n;
>>  			total_spliced += n;
>>  			*ppos += n;
>>  			in->f_ra.prev_pos = *ppos;
>> -			if (pipe_is_full(pipe))
>> +			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
> 
> I'm confused. Why does this need to be done here?
>  

I have above:

"stop filemap_splice_read() if we only spliced part of a folio, so we don't
skip ahead to the next folio"

Thanks a lot for the review!

-- 
Cheers,

David
