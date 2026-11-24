Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513650;
	b=afaIi6v7nUBPFP22EgltYUs4Q4qO+9fIdfwYzqk8OmUsI+kXmelOw5fto10RXg09OWmF
	 /e33ABbwu3UJVBRkkDm3iz8Q/IEwCWiSSUhpM8XDNyE0IcAQSKajYE4/rnie9w2ltdsMy
	 8MJumGP4szwyMU+ShKuKJiCEEvkj6if+1mFWD7kkzUEoLvb3orOQrytZtX/43h3NAsoWZ
	 xCBbFOvGwEqHjD7NbepOgQnqPo/HXdr2OAf6EBuNX78k6MnWYrOUPL1MS8EcTf2UVPBWN
	 6Pm/zJiVKMgFthj7B/omGRM3MdJqkjjQwQ5LRSHPRJuPsYkz+7SOSMztcormcYOu3jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513650;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=BE5LNOJgpR9371JeC5ubWrbf/K2t8V/MrLNI+7kIZnU=;
	b=qjA5TVfK9tzHbICi4wtNV7UetE3qt9ut5Q6zT7Hn+QSz6bEs0A0odV0ZIgwXSYBdMTJt
	 oev8sqNkCMVSgsqaLnMbFJMeVTWsAcKVVBy1MH7uAg+NIXCFPCQd/aMmdutiWBbGFKZ6A
	 I4a8inuZlj6fXvdTXxIehbYIQXMcQMSZQwRKgRCWRphDA6Stn+9sgFl7AjMdUDf+AVO+H
	 FQu5++NmZtS5WDeNK8ZvM6TRACfrrZxx5bBysUrHeb6Dne8r0LBP34w8uAUOtZzZmBMLZ
	 5GqvqbWTpx/HbIwHknbB3Iq0OQ4SKch8d+STnGLjwu8dSa1gjhUxngmLyu+ILyeRx2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P21imY+g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D94606A866;
	Tue, 24 Nov 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P21imY+g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7271F000EB;
	Tue, 24 Nov 2026 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513650;
	bh=BE5LNOJgpR9371JeC5ubWrbf/K2t8V/MrLNI+7kIZnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P21imY+gWhrYCpeL/HiKbV+EYfI2Wx8PC7+4DSG+t3BwYqFQfayWh74rAYl2eJwsc
	 /pps4EmuqT43Ahbu7j7pWoxc8SVjTHgzOT7F4EuPOtozkAt14zJXbqcsQNhruX9yCQ
	 nP/NJCvh373cAS+Pot/J5GWhaMRDho39Iq0I+1NEFphF4407BvED0vNACW3HHwIfQF
	 NLhf674Q713NGMRmtpf/3+XzNCufwPSiI1dm+OsE18odtnWpwtRadgpY1oZV6rQLt9
	 TGlp7VSzF/1cO+cLsOKtumRZJ2avSwVW72e4cSHWVFtrk67QGXiKTVL2yMTQ0mC05E
	 rAFN7XX2B5pgg==
Message-ID: <66e5f9e3-17d4-4635-8919-c67ed562f9f0@kernel.org>
Date: Tue, 24 Nov 2026 10:47:19 +0100
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
Subject: Re: [PATCH v2 0/2] mm: fix deadlock on the folio lock when migrating
 and splitting folios
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>, "Jose A. Perez de Azpillaga"
 <azpijr@gmail.com>, Chris Down <chris@chrisdown.name>
References: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
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
In-Reply-To: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 08:56, David Hildenbrand (Arm) wrote:
> Whenever we allocate memory with __GFP_FS while holding folio locks, we
> can deadlock on the folio lock when triggering direct reclaim or
> compaction.
> 
> For example, evicting inodes with a populated page cache takes folio
> locks, and if we happen to need one of the folio locks we already hold,
> we'll deadlock.
> 
> FUSE makes this example easier to trigger, because it evicts inodes on
> the last reference. A similar deadlock with FUSE was recently fixed in
> FUSE [1].
> 
> Let's handle folio splitting by simply running in NOFS context. We only
> perform small allocations, so it doesn't really make a difference.
> Interestingly, this also fixes one of a handful of possible memcg v1
> deadlocks.
> 
> For page migration, change the code to allocate destination folios
> without holding folio locks, which is in any case the right thing to do
> to reduce folio lock holding times.
> 
> Some of this might also be fixable using Jan's work on deferred inode
> reclaim [2]. However, that is not stable material, and not allocating
> folios while holding other folio locks is an improvement on its own.
> 
> Unprivileged users can trigger this deadlock with FUSE and
> mbind()/migrate_pages(); however, it requires multiple NUMA nodes and
> quite some luck.
> 
> I reproduced the original deadlocks with FUSE and made sure they can no
> longer be triggered with these fixes. Further, I ran the usual migration
> and folio splitting selftests.

@Jose, could you find and fix other cases where we allocate under the folio lock
with __GFP_FS (and direct reclaim enabled?).

I think at least do_set_pmd() might have a problem when allocating a page table
through pte_alloc_one(). And I'm sure there's more.

-- 
Cheers,

David
