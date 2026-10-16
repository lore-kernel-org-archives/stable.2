Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE33CF95A;
	Fri, 16 Oct 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136451; cv=none; b=C0tWZ74SB3C1//DpSbDG2JFvWoVWG6rQ8CeoEmvBaEqTyfSzlXtJUgbq29o+bO1l5lG2mA8Y2H9TQE1asRM4JMTwuArPLNTbn4Nx8ne/eoBK6lmvq1si0VAaRNDy6xCT/YrPeXVyWA+/kFKPxKd1DcOm2lhqmUQLkbDHLJc9KMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136451; c=relaxed/simple;
	bh=9YHeeSkEad9lcO7e8anS5ZoWgjCCJVfc2anH4fFucFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWz5TdWtpaet9w9ZS2QQRSWPxHHokOJvNVVhIlpkThL48/i+5DLPS/+1COgQrurdWmLbpJ1LnE7Oj+Uq8k8drTNtls+5erUtOAAlA2j3oq+GD1jSGhwhml29QRpZ/tvnYTZPv8SNdPaAxC47AU07SfusYTBfUyJufH/ihlNPoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeHXOyzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeHXOyzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33181F000C4;
	Fri, 16 Oct 2026 07:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136449;
	bh=YqKGI+j411IZYdGH/R2G+obmJPd4f+afYx7B7iKNFqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QeHXOyzSZlJf70cWT/G9GYdva8YdkpRA+kCN//bbbUSjuZ7nWsJH54DybwORCfd9O
	 W843SNlU4sGXHAKMmjVD8EK9Zi1PzPv30x9j6lDm8DpxYg9EQN6qBC+cTVOWZi+bLG
	 VN9dfd/0oNUAN9WBzzdgnxFQSLsVzLefFO5dBJ1+5Jud+89Mr41LYn/oHUtdb/kzTv
	 Xac9eEDNLrL9P7kRVDsaxW4jp7GYf24FX052aJLv8oEKxk9f8MoeTr3RusV+KQRyUi
	 NRg+kq4wJ80ILSX03Dj+B1a4myJGi0IPit/JZM/K5s+tYThRxQ7d6xlrKPrGbOz3Gi
	 MPVQOHeVUPOKw==
Message-ID: <02ce93f0-b5ea-4b7b-baea-3b3035c8c2e6@kernel.org>
Date: Fri, 16 Oct 2026 09:40:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] mm: various (urgent?) fixes
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>,
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>,
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <A061083A-3A02-4ADB-9CFB-7CF6C731A872@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <A061083A-3A02-4ADB-9CFB-7CF6C731A872@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 09:15, Muchun Song wrote:
> 
> 
>> On Oct 16, 2026, at 00:07, David Hildenbrand (Arm) <david@kernel.org> wrote:
>>
>> Hi,
>>
>> here are various MM fixes. The majority was reported by Josef at
>> Anthrophic, the remainder was found while reviewing/overhauling them.
>>
>> Two issues/fixes reported are not included, as we are discussing
>> (better) alternatives on the list already.
>>
>> I left most of the original commit messages as schloppy as they are: I
>> don't particularly care as long as the code is in good shape and as long as
>> they are not actively wrong. But I (and Mike) could not be stopped from
>> overhauling at least some of them.
>>
>> While I don't think there is anything too critical in here, I think this
>> is a good opportunity to see how fast we can get pre-screened/pre-reviewed
>> fixes upstream that might be security-related.
>>
>> The majority are hugetlb + uffd issues, that are not actually that
>> relevant for most installations. But all things that should just get
>> fixed. Some uffd fixes need proper follow ups to fix some more of the
>> root causes of leftover UFFD PTE bits (or proof that there are none
>> remaining).
>>
>> I ran some MM selftests and nothing popped up.
>>
>> So let's try to get these upstream in a timely fashion.
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>> David Hildenbrand (Arm) (4):
>>      mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
>>      mm/hugetlb: tolerate uffd bits set without uffd for PROT_NONE PTEs
>>      mm/hugetlb: tolerate UFFD_WP markers outside uffd-wp VMAs
>>      mm/mremap: fix calling fixup_hugetlb_reservations() on the wrong VMA
>>
>> Josef Bacik (6):
>>      mm/vma: don't leak the commit charge on mmap failure
>>      mm/hugetlb: fix use-after-free of a new anon folio
>>      mm/hugetlb: unmap the page where the other VMA maps it
>>      mm/hugetlb: don't clear the resv_map of a VMA whose lock is held
>>      mm/hugetlb: fix endless write fault on a leftover uffd bit
>>      mm/hugetlb: don't leave a uffd-wp marker when zapping an RWP entry
> 
> HugeTLB is really nasty, while no new features are landing, we have a steady
> stream of bug fixes coming in.

Yes, and so far it's mostly due to:

* PMD table sharing
* Reservation handling
* Userfaultfd

Which is no surprise given how people already felt about most of these features
in the past :)

-- 
Cheers,

David
