Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312022;
	b=jEA/RFuDw+WueAXRPy5Yvpl85a6Tt88E9Uv469I4R9wFCLee2czPcDGYI7w8FXDfIU4x
	 fQznfcmy12FaVqBAjDSgLftWIF8tOv3RiCpOCNvz27daj8UXndlCrhzekBQ9kXFZ20qLT
	 6Ia3fdM6cjnP2iYNFFaGIp4xnRVZfCr/rXJxmT1ossi0eQ/sN0ZMZcO6vj7PeeXLw+UG2
	 CNg0KV1dCWleoSVg+I8Ut+9leNSSxmqkgWYMpP34I7R6VT51RR4niGiSGgc5fO1EH/ane
	 of4UeQLiqyfmcaWjNy8QnzWMefP9vFeKe0lQ1jrnCUZXMpfBe3wGvU4kfERwLJiggQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
	b=xXICz91ETz1Bi4Gu2RzmceYdO+6oLUgHZire5czjTp2vkiuduUQAtxu5suijCpIny8N6
	 sEGzdnua34yxfn3qxZtwR7BPsv/uZdqL/6su9t4OMtGTzjbr6ns4fj1qfMMx0ULEuFSAY
	 Y1HOdOkkQWeZ7YZ+6PRloX/ax1AbDL3F7o69i+VvKNXdyfQP31P/jqWYYd7IQlBvHJtYO
	 M9U6P/jwZ7IHY6RKA49ZZd8FTyDwtxdv7N5IzAKnwQwmaEGIp+r5JDU08PcJOhR9ELqrS
	 1s+V4Ba46TBBwRu1msaGYSdmSpkR27FuosHDOimENpWogL1am/PjoUGE79seyIrvNgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RygyfnWn;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B0606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 171B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RygyfnWn
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a215e64962so22035795e9.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312020; x=1794916820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=RygyfnWnL4Yk98O5t8EfRhHJ09wgqoKDc50vcLztTT6VXIdGWIzxp8gp/oS32JisXO
         kLYRYeznXrsblttCwXF35i/TiPDW3jopVuEIWql4OVWvjiutcXKU/UhCKEYZ4UR66O+e
         kULSXyMPCUX82fsckuZ3E8/kna98lIel4VII+ANkE31SFugl57e0klPU61lHfgCvDtTP
         MtFuBcaDmc0Sm6fZGoIl3GD+SdzoAAyrnDFRUROyQH/KkkH9EDfZSB4dt1fPJiCh/NsV
         ut2IqQIh8tubjGervp8DrB5/N+bX1ezKOwAYOMPw+my8dmAF1D4nC3K5R5n4n3eGr4qG
         fgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312020; x=1794916820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=Z2lLjM5kUzmvpEBYVvtjOKx9Re/eiLLLZr8dR02EO69L3WKT0L9qnJEu1dBokeS/GG
         nFrMQQtWSY65SxwCTvUn7i9IJj1K40wsJVlBhsKVw4ydLmnpibDRyyPdiZgvaasNMDFZ
         nMgYBFNeuvrefpdZIIQLMMzyD9z6HTl3hNX93om2SQD252NriNQtQtdllkk5JP0E12lw
         xCI5vmy4/+odUvBmhftFjlpHN9S4mJ/k5yAwjV3MZeYgjF/IyiL2gSXXF+u+4aunVQTK
         FUjw+fqb7IrJH5vO9je9S26CoYksAuWux2gvRy3WHHyYV5FH211QCdTW0IrhAPD9KMtb
         e+Jw==
X-Forwarded-Encrypted: i=1; AL+hErF7+LVBDPSGnm0P1lVhTP/R/yxVF5ej3FOuiE+vCgP6SJml/z/e8NpVM1ZRJqpzHbs0/hUJT0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YZwVDo/Il4GXOeA4QdhgU2lU8MKruUehNGSnCI5otWVgQ8nOy
	yoIss3SWWfQktuoH8j90dumeXsvMd+t98Uc4RLnvoF8oZ4DfDHwRB3kc
X-Gm-Gg: AYBFou1RToy97/tPS48BgO/5m3wCsCGDg6M59esWXn9n1Af0XYtZVSH14Fzf4PUzfY6
	W0T0LBh+oiMKM25fXF9T5F6IL+dMkm4IdQ0vZKG+f7y/BYop7u+/zxnds1PxPR4S20BaKBmTscK
	f1yzQ4Q6rR3VxQ5tdojbFv4ZQ6VphMDnDKTyU/iiHJywnyx7/JLDf/QDwQxPqiz5pc6eB7LGWLe
	gHnMk1G1pXDq4zehGaOlDZtT5Zw8NmLH4k5MC6CoDyTa+BB3QYk8JEhFa/F8/fS25y8TZSorj4K
	vjT2h39EbI5IeOQP8jS1snzaCZMv6kh9RjCCmo3Tcbts+0Ln/PgeSvhqGHHtogGJJry3joDhBZw
	4+QKKz0mf34j0pcIBWy1RM2NO0MuzUgReXQh+MStkLXOL+rgq1Bvz2oJUcnMYcJR0X8uTAq6h21
	1o9g3nHjYXZdsEwIZygaGST7jUdMqBvV2Ie81XCZXggmZm+RWvTo9/NvLzDROl0mBVPiY+n/xdS
	gPsl7gj/OaPibl88B1NKeZ/FC5AwI3C0SX6f6CJF7/iQaqum0ju749JPDlT/jJEEFhAw+kJ11+l
	KB1eTIaaEBfbGcwuMoPMWl4O
X-Received: by 2002:a05:600c:3e07:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4ba0234a8f3mr43245435e9.22.1794312020086;
        Tue, 10 Nov 2026 04:00:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm97526925e9.11.2026.11.10.04.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:00:19 -0800 (PST)
Message-ID: <d4bb71af-cd1f-4d42-b724-916064f4cf0f@gmail.com>
Date: Tue, 10 Nov 2026 13:00:16 +0100
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
To: "David Hildenbrand (Arm)" <david@kernel.org>,
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
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
 <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 11:38 AM, David Hildenbrand (Arm) wrote:
> On 11/7/26 23:23, David Hildenbrand (Arm) wrote:
>> Similar to mapping pagecache folios into page tables, let's reject
>> additional references when splicing folios into a pipe if the refcount
>> is at its limit, similar to how we handle it during GUP.
>>
>> This will prevent more cases of possible folio refcount overflows with
>> large pagecache folios.
>>
>> Let's keep it simple and check in the two callers of
>> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
>> progress, so do_splice_read() can fall back to copy_splice_read() when
>> read_iter is available. This keeps sendfile() and other splice users
>> working when ordinary reads would still succeed.
>>
>> Also fall back to copying in FUSE when taking another reference through
>> fuse_ref_folio() would exceed the limit.
>>
>> Also check in try_get_page() to cover pipe-buffer duplication by tee()
>> and partial pipe-to-pipe splicing.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  fs/fuse/dev.c      |  5 +++--
>>  fs/splice.c        |  8 +++++++-
>>  include/linux/mm.h |  9 ++++++---
>>  mm/filemap.c       | 11 ++++++++---
>>  mm/shmem.c         |  4 ++++
>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 3641abb90d6bb..4f6b7b42bfd3e 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>>  		if (cs->write && cs->pipebufs && folio) {
>>  			/*
>>  			 * Can't control lifetime of pipe buffers, so always
>> -			 * copy user pages.
>> +			 * copy user pages. Also copy folios at their refcount limit.
>>  			 */
>> -			if (cs->req->args->user_pages) {
>> +			if (cs->req->args->user_pages ||
>> +			    unlikely(folio_ref_count_over_limit(folio))) {
> 
> Linus points out off-list (thanks!), that fuse_ref_folio() should have
> really used try_get_page() right from the start.
> 
> And that we should just not fallback to a copy, in particular,
> if the refcount is invalid (<= 0).

now that is said out loud, makes sense.

> So the following is what I have for now. Once we remove the limit
> handling again, that code won't change, which is good.
> 
> I went back and forth with folio_get_checked() naming, but decided to
> not mix in the "try" as that just reminds of our speculative refcount
> handling. (folio_try_get_checked / folio_try_get_referenced)

agreed with that.

[snip]

> -			if (pipe_is_full(pipe))
> +			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
>  				goto out;

nice!

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
