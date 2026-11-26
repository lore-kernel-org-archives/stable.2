Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724831;
	b=oTmm/+YJyL26gHwjXIO5M29zzITb+rfkqfbrkUJKkfCRslEQRpEX4B8cEkpHiCQx9Hdj
	 DNc+OKXghu3CLdCdLmgmW7sNTzRBjBYSguSZB0G7vPiSOyByp/7tJB7qYhYjlFVKdkX4x
	 MhFBM72Sn6Ndfcs17mXPfZ5zhWN5T+S4cliHLXPZp+vgXCJwkfY2svxcMUvThYa09/mH3
	 q8yRAlJMDVxmKv0nzX0WQVrSaov82AfJsGPZwvn6iwSHiZ6GBFms51EGVU/GyWsdGsgMT
	 77vMBB5p/WgAOC4tMPCzCLFl+uKt9q5BRlrxRVl9Dn4wSB4UkfPAI8uYFP3gv1FvgTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mPIUXK+tyYI9lmjrCipc96I5GvVnkf1nt74AkZOGWME=;
	b=rd83wlp84OSdrDOd4CnHIUqBpn4H8x5nLvPqioUCXFV+slYUvZ2bwUwWzzC8aWTZdbkc
	 5v10ybGa9F1M9BswWlzNAukT+9yjAV1eEgt04tz1sqGafk3cEmadkvREnm0Jbonh+N5fz
	 R68iZdHqPY3Ra185ALR3t7chW4RdnhULGS//c6IWuFTjEsh+m8TxKydSen3uPu4sDrugR
	 zVn4i2UdVt2Rof9PRylKY5rzqHffIz20qQTvnSy0jL55QQL78he6UJb7USq0q1Lkr7mJN
	 pBXxymp3k+rDeunBGARBvsCfPBJXCoP/Hl/d/llWIIDjgyv0Cn/E/AViEl2sIwoPANw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AN5S4dmm;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44056606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44056606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AN5S4dmm
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a42b34e930so6501323f8f.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724830; x=1796329630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPIUXK+tyYI9lmjrCipc96I5GvVnkf1nt74AkZOGWME=;
        b=AN5S4dmmjEfr0x23doiCAhsgP9Rct0N1mVc31Eg7GWkoAhc8qZJXgJIGhwutKS4mN+
         zZxOwkvtjkS+UDTRYWpG38iWwNR3HTL+w5bMAS3q+Sm5xle86yKQtBTFIv96lEb3X/R4
         cJhUUzBzaTRYcFNx5A/CmCBUnFxHr7zVxdbCRiRTNSOPM6bTiYWk+H8s0DprAJ662SmO
         mFQFsD6FF8mtDrquIe+lxxN7+2nmyt8tlSWemAWNSDWjyZb7N2jWrrp+VijPIxiQnxNQ
         5aZ3ufDu56x7egcJO7RK/Kr3O8hviZzT/7mp2K8dTR6IEDuDObu/5Vzy8WJBEMZMrzRq
         sJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724830; x=1796329630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mPIUXK+tyYI9lmjrCipc96I5GvVnkf1nt74AkZOGWME=;
        b=Xlnffc/pvlzIgdwMI+OA1v1YiUKqULNZ37ccnmkQWZlE+Bx3Es4BADVp6plZIQ06Ug
         pvNGsaHdUm0S5IFynKjj+Plp6DaMSXan6TrCxGmmEGDUzXrRsJ0EdwlxhJTTsbBLLqrK
         xAl60bEizFsUwdOSFglSaxs1nv2M3n2jK2ntrzBgBbb4nucWkthRW0vwZfV0uyGrQq2y
         4WaKfDatXiv9cYC8f019Bf12JhEPwc00kEqqPFmwJxVZkHGbFb7a0ymhArGP42P1oIhb
         T2BcJH5IPF0uBeF1rcR3kXldE1sqxE0BsxtK1Hr42Zzaxe/+h4fD9mlGpYXjomKrXv+R
         puxA==
X-Forwarded-Encrypted: i=1; AL+hErHStLG2QzLc+qw16179hPPGdIp8gdeUnIdNcKaI/c+NhcvwvE9iPaq/3sVeiB8Qw8fttgMoQ5Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z876X52go5pR+xmuv4R2aT66NorICqWN4vSYg0Ap5wkprtUDg5/
	MI1iSOZpfDOkfDh1q50954c94go/F6cylZGMZhVUf+Xy8wFlxOfwwZrD
X-Gm-Gg: AZFdTZetZHIBXaazdHi4eXdwummyZ/0j9MbB/9WzydGnfAqmap7YtnA2nnP/rDF2M1p
	vXCjybeMo7YLnG5/Zo67NnqP4xNmxq+NGzN0xvpAwYjuPgTr00oWpdyuSwweEsnqrDHsDf6nC8B
	3L4qkXQqFOkNwzYr2jkJR5Xx6O5XzVlVbqWkLb6lZcXhL7eockGnX9pEWnxsa1Pag3ecsp7QtRe
	kskzQIRJ1vW4IwXOCYA8vFDu3FbVP4VcFvaznb1jZbT/dnV62R55fbe+M/pYmJxxZQuaa4oVrd2
	W1lIVesTgFADWsdCxer7de5m6duZxRcidMUr1yIsiiPZLbkyj0Ixd/7MPViibR1BiDZjhyLS91r
	rEgbgrNopnb3qt8eg++faIUVn9gfw0iC4Y4KxZGTYxPHScJrV9yWwzbywxpToIGEa0dghCbCgNu
	Nk/m8ku8VhVuSvy1GuFu3BHfdnh3n3twHhOVSZO11kWfTc5jBtK4HWll3utguK49+bVFTZkPQJ/
	KaFvVPmPW6Wld+XiJXYWN+9lfKxMsvntRYs9ytttq400CwjWlgPIHLhcOOfItfcmMUj4J5Rc2ik
	OJ/K7hWXEm1d7BRzYv5/5T9n
X-Received: by 2002:a05:6000:310c:b0:487:27f9:844 with SMTP id ffacd0b85a97d-4abb627ed47mr53600472f8f.57.1795724829363;
        Thu, 26 Nov 2026 12:27:09 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm44007075f8f.33.2026.11.26.12.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:27:08 -0800 (PST)
Message-ID: <03ab430b-83a2-48c5-883a-70b20c4bcffe@gmail.com>
Date: Thu, 26 Nov 2026 21:27:07 +0100
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
Subject: Re: [PATCH 2/4] mm/memory: don't allocate in finish_fault() with the
 folio locked
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Zach O'Keefe <zokeefe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-3-azpijr@gmail.com>
 <9d506473-4844-4ed2-ac58-e72cd72b5c9e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <9d506473-4844-4ed2-ac58-e72cd72b5c9e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 5:29 PM, David Hildenbrand (Arm) wrote:
> On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
>> __do_fault() preallocates a page table only when the PMD is empty, so
>> that finish_fault() does not have to allocate one with the folio locked.
>>
>> Since retract_page_tables() no longer takes the mmap and VMA locks, the
>> page table can be removed while the fault waits in ->fault().
>> finish_fault() then finds an empty PMD without a preallocated table, and
>> calls pte_alloc() with the folio locked. On ppc64 with the hash MMU,
>> do_set_pmd() allocates the page table to deposit in the same case.
>>
>> Allocating with __GFP_FS while holding a folio lock can deadlock in
>> reclaim, for example the memcg reclaim deadlock on cgroup v1 described
>> in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
>> writeback").
>>
>> Return VM_FAULT_NOPAGE instead, as we already do when
>> pte_offset_map_lock() fails. The retried fault preallocates the page
>> table before locking the folio.
>>
>> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>>  mm/memory.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 11cc4039b853..b7e53d7cf6e5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5986,16 +5986,21 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>  	}
>>  
>>  	if (pmd_none(*vmf->pmd)) {
>> +		/*
>> +		 * The page table was removed after __do_fault() found it, so
>> +		 * nothing was preallocated. Allocating with the folio locked
>> +		 * can deadlock in reclaim, so retry the fault instead.
>> +		 */
>> +		if (!vmf->prealloc_pte)
>> +			return VM_FAULT_NOPAGE;
> 
> Hm, but do_set_pmd() really only needs one for ppc64. Assuming we allocate it as
> NOFS in there for that corner cases ...
> 

yes, I'll allocate it with NOFS in do_set_pmd() instead of 3/4.

>> +
>>  		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
>>  			ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ true);
>>  			if (ret != VM_FAULT_FALLBACK)
>>  				return ret;
>>  		}
>>  
>> -		if (vmf->prealloc_pte)
>> -			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
>> -		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
>> -			return VM_FAULT_OOM;
> Could we instead fallback here, after we tried to install the PMD ?
> 

sure, I'll return VM_FAULT_NOPAGE there when nothing was preallocated :)

-- 
cheers,
jose a. p-a
