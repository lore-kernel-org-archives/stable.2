Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29504477E3;
	Thu, 15 Oct 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090433; cv=none; b=mgaCnRJ6oyHgZu1JtLXE90Kdh/siGumXbe3EoaWXRSqO6WoAW81ixJX+jIC4kgqHp3YcDjLGWP5XhT2mVc0LfvTgvRj9UOmyiYdXlxykURViy48yc3/tY8chqlUIY+5Goh1pIIPGMM71UkVN49NFq2WN8sZcKCeJtpBXDntPTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090433; c=relaxed/simple;
	bh=hIsbxBUoIz+pxdMoEQrUGtFN2MLpDH/N/h8Zz38vr2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRqOo3XwB4+hqP6xb3u+52FAd3hLDRlFnO96I9PW+oSubqbUMC5GoL1v0yHcXQ/xLuTRM1rWrbaVyeGoycUJ8G1a7YTUmuR07L1XdiVueGvuwY4FoQW7K3jHNP0cH5e1riHAj0GCFfipANQi2dMrr+Qx+tjwivcmJ/LhaYl47eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imD0/fca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imD0/fca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0EC1F000C5;
	Thu, 15 Oct 2026 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090431;
	bh=fggwqKCRETIhrcEpFzizgT+ZMtVPKk27E/12MBZzVeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=imD0/fcaZvYiLvldbRP2hJZWo+t3fYKcnRpe4CJJqSII9+iZcy62TbBWKccAGi5L/
	 ccNJeTXpizip2xhR7A1RuB3ovY9rd53kWr/stKicM9LE9HJzoP/G2Qj7xlN9h36mui
	 jihqRxxNbxCnwMY3SuUDprf608IVjVu9z1nPLnY9kgfVp+DgX2cXZK2wrJEhK1oZVx
	 UW14DIGVomNqxb250G+dNLnUIUk2G6lUGpijJWsnCRmm3jd8xaUDYxiphShs5RM/7u
	 hXAKS64kmxnApAEYFsxqmmyQrTx06uFtURinLAq4yTeEEFwxj9ulmkRRlN8SYzbxbj
	 o3ZbRAKLYbo8w==
Message-ID: <723dcd38-909c-4bb5-8384-0e13da1a8c72@kernel.org>
Date: Thu, 15 Oct 2026 20:53:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/vma: don't leak the commit charge on mmap
 failure
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>,
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>,
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
 <atERwRzzAdCSXaPM@pedro-suse.lan>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <atERwRzzAdCSXaPM@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 19:54, Pedro Falcato wrote:
> On Thu, Oct 15, 2026 at 06:07:07PM +0200, David Hildenbrand (Arm) wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> When an accountable mapping replaces existing mappings (MAP_FIXED),
>> __mmap_setup() only charges the difference between the size of the new
>> mapping and the VM_ACCOUNT pages it replaces. It then zeroes
>> vms->nr_accounted so that unmapping the old VMAs does not return their
>> charge, which now backs the new mapping.
>>
>> If the operation fails after that point, the error path returns
>> map->charged, i.e. only the difference. By then vms_clean_up_area() has
>> zapped the page tables and closed the old VMAs, so
>> vms_abort_munmap_vmas() cannot reattach them. It leaves a gap and
>> finishes the unmap with vms_complete_munmap_vmas(), which uncharges
>> vms->nr_accounted == 0 pages. The old VMAs are gone, the new one was
>> never created, and the charge of the old ones is never returned, not
>> even when the process exits.
>>
>> No privilege is needed to hit this, only a file whose mmap hook fails,
>> for example a socket (sock_no_mmap() returns -ENODEV):
>>
>> 	p = mmap(NULL, len, PROT_READ | PROT_WRITE,
>> 		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> 	mmap(p, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_FIXED,
>> 	     socket_fd, 0);
>>
>> Every iteration adds len to Committed_AS for good. With
>> vm.overcommit_memory=2 this lets any user make all further accountable
>> allocations in the system fail with -ENOMEM.
> 
> I don't think is urgent nor does it have security implications. You can
> already broadly screw up the system from any user when overcommit_memory=2.
> This just goes around the single-process user_reserve_kbytes AFAICT.
> Am I missing something?
> 
> Just looks like a good old bug to me.

Yes, most of the things here are just good old bugs with limited criticality (as
I expressed in the cover letter and the "urgent?" highlight in the subject).

Things like use-after-free or deadlocks are rather bad, but they are mostly
hugetlb specific, requiring actual allocated hugetlb pages in the pool. So there
is limited attack surface in practice.

All valid things we should be fixing, though.

I suspect we have a flood of MM fixes coming our way with differing criticality,
so this here is one attempt to figure out how well we can deal with the
mostly-trivial ones in a fairly controlled (e.g., proper human review) yet
efficient way.

Anything less trivial or shaky needs proper time to settle, as always.

-- 
Cheers,

David
