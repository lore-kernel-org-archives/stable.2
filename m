Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997794;
	b=VU/Ve91+aW3yHoIfBYJ1W527YbbDjGp3B12+D5M+gODJh9YK7Ar6PiG1i3xS9RKylVfM
	 DSMxTwlyurg3z+WJCf1/txnamCM1RcbXWOJTHMQRG9ZgJz184S6Yvfr0+06Gzv0TxO0MV
	 W9uNyGV83C/rhrTk+CPGDP+GIHAA5+WoA3UODgSEKodnv1iNbsa1OfYrHcVuefKUWmAyN
	 ie952oDz0LB+6fM4EKhn67i8cC4SZxr1oCbgZE1I2OWpb+ibpWe20g7nDcEOyK+B9mL6H
	 G9D2PCprn9lwRnPKh+QKBKeDTSlL3gl2u3e2/2XzBr/uZf19xpv4nePT6RcAW+FJcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
	b=du8OMj64atgi72SnGnWegMPxUIgcro7uL7l4wHYN2eUYrvbDZm3N+ey7QLN9khpwQT9A
	 5FsRNfUTctDyawULmOsrbb3j6lXLTN8FEf7Lw3V20ENHi9801YDC6AXLRu2GnQGFJdlao
	 KyoxVDNZeZPETVZRC3wBEQNRB3qmJbwE1IyYx0SxLat3DakdyKrNdMuv3cEanO6KIziNr
	 Lwz/EcspcuGfVTMLL8eIOUGHHyTvxl0IyG0NQnbNOmHSASdzL2tX+bAws2Sl0XKmkMkDh
	 /8ONEwqzrBoXdtj6kHSpK86HyLUGmizfXnfscLnlNFSHdFhmFJarea2DzAZVoFcWQBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=REFEyl2N;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5E606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 20:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A5E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=REFEyl2N
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso12465446d6.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997792; x=1794602592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=REFEyl2N/lgmfldAVFpxIWxQa8mjfRZ+rZu+VbJlPELmGLoAMssVZsg4Bw+JPUe95Q
         Y/+7TrhaVb742lX5HOvfYl5c8tdB9czfTvg+/vPAkrj9deCRb9o77jvOHMvRN4NFT+Us
         ybtE7N/j08Yo8TizgspuDg/xp1VtRZGq6sUf6uJV1YrIhg2qFP9g5wF57DH9VkfVQStn
         4ZNBdx9BbGLhMDmmTMxt1/LSgHH4HYRUio31WfKrQQRxXVL0B2mrBDJi7luolVdmYxxx
         r+j1ArDIDr+vUF0me32H7jSKSjODetgV3j9jw0TC5pHi0hn9wyRUYJT4xRQMphXho2hD
         k69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997792; x=1794602592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=is4pv9pAzz71ohdddTZuwpN1CzpC+8kPbwNVI56fffybinju3i1fmQAkP7787rjJoc
         KYirnJXEPbzJGtiAahPr6ErdbU0il3zreUPfkN0naCyKVrKcnnEj/y9IcGKQW6eu2nmy
         xrYZn9Jau0MAsVBN48Eg5tfzOiu0TDdakxvshS1wPz4p6AnqN/+ObJZ3xbWXyQkQVkim
         mc2rWwmJCCtJ9a85ysPGMcktk3KN0eVyHfHgdz1rBfRImNzwnHkrQC8M3iavzX15MEs9
         9RyYdOZK1rdLSe3Qg/t0JL72ZKWcdWfnWr6E1HzV5WKMZp7cW48PixvRzvfKr1pI6/Lt
         2I3Q==
X-Forwarded-Encrypted: i=1; AL+hErGMJ9HZ4tZjn3Wyl+GaUPnpJJSG7OlJNN5q8JxzNniv6lguS0tCKYNmNPQhr9EaKktjlrIgCS4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9qU6QTDPWJJOgiCvkyAxpV/SsnKultxBfONOskVa/ecbTZpZC
	A/85JZbdoGxwQIWM6XFQyeaTZaQw1m+v2giPHnzh8n3H9dbdw/uJACTF6gLOnEU8R0Y=
X-Gm-Gg: AYBFou2godB1Yas4w8+60VO8Xd5/IwL0Dpj5qB0FvyNIt0ZlfSqtRaoj+Hr9CrAr8JM
	fdlngiUGiUTgCLOFbWCVRNOliBSbfkd2g/pp+8Z0LFW6lMtBgy5c+XTKDgml3ywvpS6YBRvoiB5
	EaMvZ4+lt3Z5xfmL0xZ6Y97kd+DdAddhM3LPQbTR4DOrPetwyPrJNa299rhCR6qA87HeB9V2pCJ
	3eyr91G/wxONmCBc9nC8VoC0nJ5ICa2o5ASiGdswSJpxIaWwFnhYOV7DyNC67/AOFDYm93zMGPe
	YgLFygjYXwI7quY3CItZCalluXRBpr7xP+h2av99dNe1d6N/jR2BscYMew5G2TarrNtjYDrR+oH
	c7RYD9LmSKdeP6hnsexlT2dXE7dXiU8vd78izAAD3zo+4atNn6LJzSdd3jn32A+jWq/MnpfOPWe
	skQUYxKT6pAMoiwLN5f4+BZ3agUl99eGPBgaIYoGFzpyBNsCXAIGzxmMwz7/v+iGJwqipY4fyhR
	VgkZWgr3e5W3XwN7KoMYz4GbXkgCcdhxOoL8Ej0wmIob9UC3HYByaAp7I6y71ZlwoliIWEAb+d3
	x3HFhDtOGGdweVmqmTnjCIyeWqNDvsbgADymfIS+GpD8tY/nUjHE1ASTeyTYTSN6pU01pI6E3tw
	9ZEF8FxFU+g==
X-Received: by 2002:ad4:4ee5:0:b0:91e:a5c2:37f7 with SMTP id 6a1803df08f44-91ea97a22b7mr53003846d6.42.1793997792129;
        Fri, 06 Nov 2026 12:43:12 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c742sm29232026d6.11.2026.11.06.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:43:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQmE-00000007ent-3ktJ;
	Fri, 06 Nov 2026 16:43:10 -0400
Date: Fri, 6 Nov 2026 16:43:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <20261106204310.GK663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
 <n3l2cnx6d25jovloqyoxiz566mh62janclmiewjvumtmqfezo7@zmsmco5vvssn>
 <23f947e2-ff06-426d-adb7-396871304736@kernel.org>
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
In-Reply-To: <23f947e2-ff06-426d-adb7-396871304736@kernel.org>

On Fri, Nov 06, 2026 at 09:09:10PM +0100, David Hildenbrand (Arm) wrote:
> On 11/6/26 18:58, Josef Bacik wrote:
> > On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
> >> Similar to mapping pagecache folios into page tables, let's reject splicing
> >> folios into a pipe if the refcount is at it's limit, similar to how we
> >> handle it during GUP.
> >>
> >> This will prevent more cases of possible folio refcount overflows with
> >> large pagecache folios.
> >>
> >> Let's keep it simple and check in the two callers of
> >> splice_folio_into_pipe().
> >>
> >> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> >> and partial pipe-to-pipe splicing.
> >>
> >> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> >> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >>  include/linux/mm.h | 9 ++++++---
> >>  mm/filemap.c       | 4 ++++
> >>  mm/shmem.c         | 4 ++++
> >>  3 files changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 79ae8fc0d6bb4..a82cfbce18215 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
> >>  
> >>  static inline __must_check bool try_get_page(struct page *page)
> >>  {
> >> -	page = compound_head(page);
> >> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> >> +	struct folio *folio = page_folio(page);
> >> +
> >> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> > 
> > Since you're here anyway can you change this to something other than
> > WARN_ON_ONCE, since that results in an OOPS with panic_on_warn set?
> > Thanks,
> 
> If it actually turns negative (or 0) with out changes, we had an overflow and
> for sure want to know about it :)

Yeah, didn't you get Docs merged to clarify WARN_ON is fine if
userspace can't trigger it?

If you use panic_on_warn you *WANT* your system to stop if it detects
corruption, that's the whole point. Removing corruption detection so
panic doesn't trigger is pure 100% nonsense.

This keeps coming up and it's frustrating to go over again and again.

Jason
