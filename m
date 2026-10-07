Received: from mta1.migadu.com (out-105.mta1.migadu.com [95.215.58.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477CA3CC303
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372856; cv=none; b=WgOWMJM6rYJYeLRqYEfCl6CFSEi/3jah2A0YY9fIzlXNYh+2JJAVqAzVNwMPmh2smkoLuEr17aRaHYVnC1x0dOqITHYkxWZNNxE0DQcq+T/RoKxRHYJqcBJlzCiZVlEiudRhuko6tzKrnNBFB/wBwlY7AeyJgBdnvR/Yrhp7onQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372856; c=relaxed/simple;
	bh=VQVhQZKIl4zNDQJKB9bVX5VumbsxMCs4+iJKLBdZmkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LADJ2E3x8P4O+fI6Xg08rcAQIj5uo7OFY2uTj+6W5PfEzRRpNGVFy0J9FvVVFl5gJbjKl6t5sZ7R0PSCwAt9gyO/Eebz/rhhUGYd4yx8ieEyJlssrEqzbhNreXixy7BaphT+9AvhPxOHo6iCHs9GMEVodWvuXwKSu7OH2jaBjtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mzlRK2Wn; arc=none smtp.client-ip=95.215.58.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mzlRK2Wn"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VQVhQZKIl4zNDQJKB9bVX5VumbsxMCs4+iJKLBdZmkg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791372835; v=1; x=1791977635;
 b=mzlRK2Wne3Jl3AjHi5WznBZZZa1mbNjXgzL6EkkByUXq92CM6SFCLthWfd4Fvc3d4z/BTpCP
 WUOD0sX6IUiZTPAu3KFfvDLCfKSD562lRW0t4qbgFRAmak8IECLfDD4mr67y/B1s70m3UOchhLC
 q50oM+2Uex1a/zpy8ZzRwImw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aa4fc3b16c8ec0d3;
	Wed, 07 Oct 2026 11:33:54 +0000
X-Mizu-Trace-ID: aa4fc3b16c8ec0d3
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: lance.yang@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	zhangchunyan@iscas.ac.cn,
	rppt@kernel.org,
	kas@kernel.org,
	andrew+kernel@donnellan.id.au,
	rmclure@linux.ibm.com,
	debug@rivosinc.com,
	baolin.wang@linux.alibaba.com,
	usama.arif@linux.dev,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alexghiti@rivosinc.com,
	viro@zeniv.linux.org.uk,
	ajones@ventanamicro.com,
	arnd@arndb.de,
	axelrasmussen@google.com,
	brauner@kernel.org,
	conor.dooley@microchip.com,
	conor@kernel.org,
	jack@suse.cz,
	liam@infradead.org,
	ljs@kernel.org,
	mhocko@suse.com,
	paul.walmsley@sifive.com,
	peterx@redhat.com,
	robh@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	yuanchu@google.com,
	stable@vger.kernel.org,
	pasha.tatashin@soleen.com,
	linux-mm@kvack.org,
	me@ziyao.cc
Subject: Re: [PATCH 1/1] riscv/mm: fix soft-dirty migration PMDs being treated as present
Date: Wed,  7 Oct 2026 19:33:45 +0800
Message-ID: <20261007113345.32755-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <69c33490-e5a3-4cf2-a5ed-d2bc8ed336d2@kernel.org>
References: <69c33490-e5a3-4cf2-a5ed-d2bc8ed336d2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Oct 07, 2026 at 01:01:14PM +0200, David Hildenbrand (Arm) wrote:
>On 10/5/26 15:46, Lance Yang wrote:
>> 
>> On Mon, Oct 05, 2026 at 12:37:20PM +0200, David Hildenbrand (Arm) wrote:
>>> On 10/4/26 05:03, Lance Yang wrote:
>>>> RISC-V uses _PAGE_EXEC for swap soft-dirty tracking when
>>>> CONFIG_MEM_SOFT_DIRTY is enabled and Svrsw60t59b is available. That's
>>>> a problem for PMD migration entries, since pmd_present() also checks
>>>> _PAGE_LEAF (R/W/X) to recognize THPs with _PAGE_PRESENT temporarily
>>>> cleared during splitting.
>>>
>>> I'm curious: why do we have to set leaf indications for non-present things? The
>>> HW sure will ignore it, right?
>> 
>> Yeah, that surprised me too :) Still wrapping my head around the details
>> ...
>> 
>>> Is this a sw problem? Who needs that?
>> 
>> IIUC, it's for software during a PMD split.
>> 
>> __split_huge_pmd_locked() invalidates the huge PMD and flushes the TLB
>> before installing the PTE table. Software still needs pmd_present() and
>> pmd_trans_huge() to recognize the THP in between.
>> 
>> RISC-V clears V but keeps the R/W/X bits for that, so the entry is invalid
>> to hardware but still identifiable as a THP by software.
>> 
>> Hopefully I didn't miss something.
>
>I thought some change we performed to GUP-fast wouldn't require that anymore.
>But my memory is a bit vague ... :)

Yeah, I'll have another look at that :)

>> 
>>>>
>>>> When a soft-dirty THP is migrated, set_pmd_migration_entry() preserves
>>>> soft-dirty with pmd_swp_mksoft_dirty(), setting the X bit in the
>>>> migration PMD. Even with _PAGE_PRESENT clear, we end up treating a
>>>> migration PMD as a present THP! The fault handler skips
>>>> pmd_migration_entry_wait(), and a write fault can end up in
>>>> do_huge_pmd_wp_page(), where pmd_page() decodes the migration entry
>>>> as a mapped PFN.
>>>
>>> That sounds bad.
>> 
>
>[...]
>
>> YES, looks a bit off ...
>>> That reduces the effective swap size (and PFN we can store). Could that be a
>>> problem?
>> 
>> We don't need all 52 bits of the swap offset.
>> 
>> RV64 PFNs only need 44 bits for migration entries, and actual swap is
>> already limited to about 16 TiB per area with 4 KiB pages by
>> last_page (__u32) and swap_info_struct.max (unsigned int).
>> 
>> So there's room to reserve a bit without reducing the supported swap
>> size or PFN range.
>> 
>> CONFIG_MEM_SOFT_DIRTY is only available on RV64, so RV32 keeps its 20-bit
>> offset.
>
>Good, can you spell that out in the patch description?

Sure, will add that to the commit message in v2 once I've heard back
from maintainers :)

Cheers, Lance
