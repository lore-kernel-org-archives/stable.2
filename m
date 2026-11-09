Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217830;
	b=cCs4xqBGdO21vzg1k06vLOIBQpMLMeIbIHF8JGTIwJ+Z//M0W4Ee1x05z56/tnclEtos
	 J1uNApD/XIlbo+jD3bm0bef85zIDD+iZ9MXYmFxFQi5kDAlU2C7wTyKcFxsQUvt6MoIXi
	 E0r1WuEsRXz+rI/Iyxqm7Ni4DrvlxN+6jZjH8Nof/c4hsIrUk8TMAl5yfh0QCvxBZBK2A
	 E4x4RVf5r8jNjo4mmtb8u5ozg2xxcuFi3Qdwi/82dCg/0E/OUMMEIZUmJdxqXEZXBznYC
	 cxOeuCX9HKlhY8HA2BqJzyRR7ek29ADOYGIxT/BN+8CUrQ3WDPuAcyQtChAP7S7evuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217830;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8jQST5+SfU/stcEn1VOV+s+O2grX/AjdmKJu3mY8h/o=;
	b=Ej2fWZtB83gg5ecnot9hL7fjusmQvVPH4qbdBnpk+mTanNg/BT+xg+btl9BgAsHcfKqb
	 DhXdrqkbU23WSnlQlXTyA0tg/RB1TBN8yTwoQkONBA1wr4rKKpYus9txgbcSdkcoPOOVP
	 1zhp5NiyqTw84T4AhLnI1KSsRhPXkrb6TjIA8UF+o698Cf9M9nM5hxo2v9cfqLvWTKWNh
	 HfJnpSnjV3e/ZreZoUSKAxQCXtmQXfkW60jZ8HDvj4nWmCHWaGZQiMS0JukonmJuMsA/Q
	 5z+XfOGLkwVCh6KMnX1Q7GjGdkOvwNbkao1kukVfBoWc0aDVjdlNI+MkgnQ9l3a//0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvHIGFuz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E19606A321;
	Mon,  9 Nov 2026 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvHIGFuz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB921F0089F;
	Mon,  9 Nov 2026 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794217829;
	bh=8jQST5+SfU/stcEn1VOV+s+O2grX/AjdmKJu3mY8h/o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=OvHIGFuzeTrht0qsWVugipKYTrQLZcnvB6H9AoSgt/BfQa9OPyUvWqvJ8MOIsDadM
	 GanFXxKFurEMX1AJqRVtXq3aRWMU3f5+WrFTpo5wgIB//RmeuK1DCmhhBP23ms4Q1h
	 OxpyKGhtol4qDQfjdGC5xXV4KMT4/NcBlPfpG7uNWKEuNcRlrmaMThNfOOIhb6iqsV
	 6bvrPZ4Od2X8Yz8iIIBCfsyQcB4XJmpr+4JPhTB/o49dc/swkETYACw1k9TwnUEdPS
	 i/WrVh9yir+LZOUj1ItLVGLUb1Oim+AfBYVUIRuwBzAMFlgA47kPNAltSH3lzQo+Vl
	 sFPz+2VdU0FGg==
Message-ID: <43fc45ff-8636-4961-a80a-29844c15d7a1@kernel.org>
Date: Mon, 9 Nov 2026 10:49:08 +0100
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
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
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
 <a9fb2d3c-d518-49d3-9479-a25fa2cfc5b3@gmail.com>
 <8d23b1eb-72aa-479d-9486-dbfd86d8414c@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <8d23b1eb-72aa-479d-9486-dbfd86d8414c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 10:30, David Hildenbrand (Arm) wrote:
> On 11/9/26 09:57, Jose A. Perez de Azpillaga wrote:
>> On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
>>> Similar to mapping pagecache folios into page tables, let's reject
>>> additional references when splicing folios into a pipe if the refcount
>>> is at its limit, similar to how we handle it during GUP.
>>>
>>> This will prevent more cases of possible folio refcount overflows with
>>> large pagecache folios.
>>>
>>> Let's keep it simple and check in the two callers of
>>> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
>>> progress, so do_splice_read() can fall back to copy_splice_read() when
>>> read_iter is available. This keeps sendfile() and other splice users
>>> working when ordinary reads would still succeed.
>>>
>>> Also fall back to copying in FUSE when taking another reference through
>>> fuse_ref_folio() would exceed the limit.
>>>
>>> Also check in try_get_page() to cover pipe-buffer duplication by tee()
>>> and partial pipe-to-pipe splicing.
>>>
>>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>  fs/fuse/dev.c      |  5 +++--
>>>  fs/splice.c        |  8 +++++++-
>>>  include/linux/mm.h |  9 ++++++---
>>>  mm/filemap.c       | 11 ++++++++---
>>>  mm/shmem.c         |  4 ++++
>>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 3641abb90d6bb..4f6b7b42bfd3e 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>>>  		if (cs->write && cs->pipebufs && folio) {
>>>  			/*
>>>  			 * Can't control lifetime of pipe buffers, so always
>>> -			 * copy user pages.
>>> +			 * copy user pages. Also copy folios at their refcount limit.
>>>  			 */
>>> -			if (cs->req->args->user_pages) {
>>> +			if (cs->req->args->user_pages ||
>>> +			    unlikely(folio_ref_count_over_limit(folio))) {
>>>  				err = fuse_copy_fill(cs);
>>>  				if (err)
>>>  					return err;
>>> diff --git a/fs/splice.c b/fs/splice.c
>>> index e6d43329ed3f0..df73a4e65118b 100644
>>> --- a/fs/splice.c
>>> +++ b/fs/splice.c
>>> @@ -956,6 +956,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>>>  			      unsigned int flags)
>>>  {
>>>  	unsigned int p_space;
>>> +	ssize_t ret;
>>>  
>>>  	if (unlikely(!(in->f_mode & FMODE_READ)))
>>>  		return -EBADF;
>>> @@ -977,7 +978,12 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>>>  	 */
>>>  	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
>>>  		return copy_splice_read(in, ppos, pipe, len, flags);
>>> -	return in->f_op->splice_read(in, ppos, pipe, len, flags);
>>> +	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
>>> +
>>> +	/* Fallback to copying when hitting folio refcount limits. */
>>> +	if (unlikely(ret == -EOVERFLOW) && in->f_op->read_iter)
>>> +		ret = copy_splice_read(in, ppos, pipe, len, flags);
>>
>> here it can't tell where the -EOVERFLOW came from, if another file
>> returns -EOVERFLOW (i.e. tty_fops uses copy_splice_read, and
>> n_hdlc_tty_read() returns -EOVERFLOW after dropping the frame), it now
>> gets a second read.
> 
> 
> That's what claude told me during review, and when asked whether that actually
> happened in practice it said no ;)
> 
> So is that actually a problem?

Double checked, claude managed to confuse itself.

n_hdlc_tty_read() can indeed return -EOVERFLOW.

I should just have let splice keep failing, dealing with copy fallback starts to
get annoying.

I guess switching to -ETOOMANYREFS should work (and might be a better fitting error)

-- 
Cheers,

David

