Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BD33688D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185378; cv=none; b=YQjSQitaxh5a2THFd73MArsrinSFboHmX23ivuitPEuWLdospGFjk2xYtFMB47ynOTWzb/ar+a0DjgxaJnyXyR0HLxhxas/R2nXT2+sZL/iE80FEY7MUhVefez0mKwg22i6EwM/JYw2uVngSFYUtz6WVx9flY/ui6kjdgeQMutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185378; c=relaxed/simple;
	bh=sK9V2jYPHnq/dXSshCTHnIO11I1X6+eo1StxCE06jiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP+7t6B16l5Du43K3eoAMqXsDdobp2jEdBs7t8n9AoHDAPkAShlWnl8WPmV4aL+faWhcbH6v3i27NaMxZ2NRCWaw2SrAbnhj8DvYdLISleq/WNqyvOPK5nN/B9A/MbOlrj5sYVENDeKXyJvX0WrIEtjO0UEMaZ5aVi3G2el0oeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jYPdXbL0; arc=none smtp.client-ip=95.215.58.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jYPdXbL0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sK9V2jYPHnq/dXSshCTHnIO11I1X6+eo1StxCE06jiE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791185374; v=1; x=1791790174;
 b=jYPdXbL0bEvo4/CEfima5qxmIMBAoDtxF5EhkCsW2q8qWeMN+37WuD9rlTJbTbUItvpO1gcP
 pkgs9zmzljDymTwLNKL8wNHtGhoBJiVUE3lICIlRIFNx4iNfAi7j7DmMlZinl+ZKmwK89+yhY6b
 QEFMk5nv10+erCzergbo74uU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 443fea304e721487;
	Mon, 05 Oct 2026 07:29:33 +0000
X-Mizu-Trace-ID: 443fea304e721487
X-Migadu-Flow: FLOW_OUT
Message-ID: <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
Date: Mon, 5 Oct 2026 15:29:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
Content-Language: en-US
To: Pedro Falcato <pfalcato@suse.de>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, riel@surriel.com, linux-kernel@vger.kernel.org,
 qi.zheng@linux.dev, nadav.amit@gmail.com, thomas.lendacky@amd.com,
 kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 brendan.jackman@linux.dev, jannh@google.com, mhklinux@outlook.com,
 andrew.cooper3@citrix.com, Manali.Shukla@amd.com, mingo@kernel.org,
 stable@vger.kernel.org, toshi.kani@hpe.com, david@kernel.org,
 mikhail.v.gavrilov@gmail.com
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/5 14:09, Pedro Falcato wrote:
> On Mon, Oct 05, 2026 at 01:23:02PM +0800, Lance Yang wrote:
>> pud_free_pmd_page() uses a single-address invalidation to flush the
>> paging-structure caches before freeing the page tables. With AMD TCE
>> enabled, this only invalidates upper-level entries associated with the
>> target address. Cached PMD entries for other addresses in the PUD range can
>> still reference the PTE pages being freed.
>>
>> The AMD manual quoted in the commit enabling TCE says these instructions
>> remove
>>
>>    "only those upper-level entries that lead to the target PTE in the page
>>    table hierarchy, leaving unrelated upper-level entries intact."
>>
>> Even with all PTEs cleared, speculative page walks can cache present PMD
>> entries after the earlier TLB purge.
>>
>> Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
>> the single-address invalidation otherwise.
>>
>> Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> I'm not sure this is correct. The PUD is clear. We invalidate the TLB, which
> invalidates the translation caches for that walk. invlpg will notice the PUD
> isn't present. I don't see a case where it can ever not clear the rest
> of the translation caches for all leaves. And, in fact, by that point the CPU
> can (does?) probably formally treat the PUD as the leaf.

IIUC, clearing the PUD in memory doesn't invalidate cached PMD entries by
itself. With TCE enabled, flushing one address only invalidates the entries
associated with that address ...

(That's how I read the manual, but AMD folks, please correct me if I'm
missing something.)

So couldn't other cached PMDs under the same PUD survive?

Later/speculative page walks could use one of those cached entries
without rereading the cleared PUD, and access a PTE page we've already
freed ... If that can happen, it sounds pretty serious ...

> 
> Did you repro any bug related to this? The functionality is perhaps
> underspecified in the AMD manual.

TBH, I don't have a reproducer yet. Just LLM stumbled upon this while
I was investigating another memory corruption issue [1].

[1] https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/#t
