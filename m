Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.127
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012457;
	b=PHfZ6Oiqe7828+Pbt3zso9/7tARPrnWeaEFjsXeLkhwvkSQ5kqa6j4gs6f3WgBSYYUUN
	 TAlYnGZ4Np1KYdhxCOeMP+zTI2xiwXA+3k5M9nwdGNecAt2f6hGV/0ms26PEYi1Yfixad
	 RYatm09rAOuEsRMZqIWEGo8Rvw/w3STF3BG3uxQyi2PiDOupieBYpAx8N8idScrNosUfo
	 VEzqeD0KSIrvShYsvXSn36Li6c1Fsrgg/dOv+jQoFtDTnmh6K94emTGnHnqftTqd/7Z3u
	 jo3+s7QuIGUUyno8D2Z/46qtlwNwBG12YI1DT0RVgwQXg5aNZRq6q8Dsb1xRPf1DsJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012457;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MndTzYV14X6jKTNzKDMu9gfax8gLbgHUdDxFcB5nCiQ=;
	b=Y5WWpste6K9SDRugmGgK/34CeiTeO0Yvh2OQNbcY6ED971f/LQKtW2+yAKClriVKhLjJ
	 YhXYXKKgifzz2283hlQ++y6EVjBtdcDm8K+M8QdizUS6N45B/8FyTacGKW8pJsL/cM/+/
	 un1zg1aST/KS5JdoPBlsMcFXklk2Sb0nd+bIt1lMFGMMk0PDva68M6oONjCyo2zcqkNQC
	 GZYP4NqjfUF+lLieHAGa4/RZdKADv5L31Qjwch4N7VmCzlgYUnb1YA+8IK8YINeKK4SqZ
	 2H+xUcOHF1QxZRrlURlLdeHLrrrLuY7S719jbun/0LhdpQrDGuMPmv0JZ9t9cOH5Shg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DEMB8Hc0;
	arc=none smtp.remote-ip=95.215.58.127
Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22835606A333
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22835606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DEMB8Hc0
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y/2CZtS0my7XAoRAXQcDwklNbzZpak4z9kOV9aXMYhk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795012454; v=1; x=1795617254;
 b=DEMB8Hc0FAAaDf3ZdafLSfO43GKgeNTxTB7eXILXydJguMPl5U+PetvbAP1n60+Qzy1+l6kl
 tyi0H6wIhVAxd1itL+0clV5mPBgISrOo/fLbM9jcSZ6L9VlxYjjEYPAhM9WRgpb5P0jFyMO2yEK
 JAXv96hg4QCdQ3pZkhf1bnmY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ab288a68988a4ad9;
	Wed, 18 Nov 2026 14:34:14 +0000
X-Mizu-Trace-ID: ab288a68988a4ad9
X-Migadu-Flow: FLOW_OUT
Message-ID: <3b705a3e-cbc5-42f1-b715-d407c08cdf87@linux.dev>
Date: Wed, 18 Nov 2026 22:33:53 +0800
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
Subject: Re: [PATCH 6.12.y] mm/ksm: fix userfaultfd protection during merge
 and unmerge
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Samarth Narang <samarth.colleges@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Bobby Powers <bobbypowers@gmail.com>,
 Brian Geffon <bgeffon@google.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, Doug Gilbert <dgilbert@interlog.com>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Martin Cracauer <cracauer@cons.org>, Marty McFadden <mcfadden8@llnl.gov>,
 Maya Gokhale <gokhale2@llnl.gov>, Pavel Emelyanov <xemul@openvz.org>,
 Rik van Riel <riel@surriel.com>, Shaohua Li <shli@fb.com>,
 James Houghton <jthoughton@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, SJ Park <sj@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Mohammed EL Kadiri <med08elkadiri@gmail.com>
References: <20261109200758-failed-6.12-990d6c2194a9@kernel.org>
 <20261111082901.32704-1-lance.yang@linux.dev>
 <2026111802-facial-asparagus-d380@gregkh>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2026111802-facial-asparagus-d380@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/11/18 18:48, Greg KH wrote:
> On Wed, Nov 11, 2026 at 04:29:01PM +0800, Lance Yang wrote:
>> KSM loses userfaultfd protection when replace_page() builds a new PTE from
>> vma->vm_page_prot.  Dropping its uffd bit lets a subsequent write go
>> through ordinary COW instead of userfaultfd write protection handling.
>> For RWP, a merged page also becomes readable without faulting.
>>
>> Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
>> have to handle unmerging.  An existing KSM page can be protected with RWP
>> before MADV_UNMERGEABLE, so unmerging already needs fixing independently
>> of preserving RWP during merging.
>>
>> Unsharing replaces a shared page with a private one and should leave
>> userfaultfd protection in place, as do_wp_page() already does for write
>> protection.  Currently, an unshare fault reaches do_uffd_rwp() before it
>> can proceed to do_wp_page().
>>
>> - With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
>>    break_ksm() then reports success with a KSM page still merged.
>>
>> - With asynchronous RWP, protection is cleared before unsharing.
>>
>> Preserve the uffd bit when merging, and restore PAGE_NONE for RWP.  Let
>> FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
>> private copy as well.  Unsharing can then complete with RWP still armed
>> for a subsequent access.
>>
>> Link: https://lore.kernel.org/20261026130054.91461-1-lance.yang@linux.dev
>> Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
>> Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
>> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
>> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Xu Xin <xu.xin@linux.dev>"
>> Cc: Chengming Zhou <chengming.zhou@linux.dev>
>> Cc: Liam R. Howlett <liam@infradead.org>
>> Cc: Vlastimil Babka <vbabka@kernel.org>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Jérôme Glisse <jglisse@redhat.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Bobby Powers <bobbypowers@gmail.com>
>> Cc: Brian Geffon <bgeffon@google.com>
>> Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Cc: Doug Gilbert <dgilbert@interlog.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Martin Cracauer <cracauer@cons.org>
>> Cc: Marty McFadden <mcfadden8@llnl.gov>
>> Cc: Maya Gokhale <gokhale2@llnl.gov>
>> Cc: Pavel Emelyanov <xemul@openvz.org>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Shaohua Li <shli@fb.com>
>> Cc: James Houghton <jthoughton@google.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: SJ Park <sj@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>
>> Cc: <stable@vger.kernel.org>
>>
>> (cherry picked from commit 990d6c2194a938a19a8cf94c6cfd75171345089b)
>> ---
>> Backport to 6.12:
>> - Use the older pte_uffd_wp()/pte_mkuffd_wp() helpers.
>> - Drop the mm/memory.c changes. 6.12 has no RWP support.
> 
> Dropped as you didn't also include a 6.18 backport :(

Okay, I talked to Sasha earlier about the soft-dirty backport.

Will wait for it to land in the relevant stable branches before
sending v2 :)

Cheers, Lance

