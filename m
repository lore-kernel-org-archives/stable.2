Received: from mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93763490BF4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214250; cv=none; b=okQBT7pOt6McJUmOvnii1FOn7eMWqsNu3MLrclUnLvowdF0wjAlu3m6rfrwH5MKP500vEzcagjvnc2goCVQRBwvVbPn+3Rr23hTIcBkn7GW8q2psBu/H9Q3XjIHq3xFce+eM6QSrl4Z3zygteTNMm9yMrYC5iX3RCR9w2U11/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214250; c=relaxed/simple;
	bh=21gxMkJy8Tqmj1dU+Rerqv+FZsw/hh5Y+yv1SLdWWq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiexKvn3GSrRlUKJW7XGprhYPt+YovM0CRP3tqZt0sfHWnTPu2CkA8Gs1z0TcuIGeDzZkUiQqVFxdbmBP8SXShKfpIEqqa96eF5EWAnHbkcJuihXhtjcitPLQTybU7WRpX7BD+hLyrsioxTn3HTw4n7jmrJ6w7y6dAkypG0tgA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6VTrRgn; arc=none smtp.client-ip=95.215.58.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6VTrRgn"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=21gxMkJy8Tqmj1dU+Rerqv+FZsw/hh5Y+yv1SLdWWq4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791214245; v=1; x=1791819045;
 b=j6VTrRgnmgzRxAAV5m0NuUV7WgNA5nN8NbSXu28bo6iVIfQN3PvHmEkXzYNdZ5rWnac5ytVp
 Q3TotqNBm6pnqRcQnDWmsImLU3aT1Y9TxpIWmn7u08n7L6pSkC0iswyl3r7264eH7INwvUAKvcW
 CuBWw23onubzWK8GWFH4DDYQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0be697459824643c;
	Mon, 05 Oct 2026 15:30:33 +0000
X-Mizu-Trace-ID: 0be697459824643c
X-Migadu-Flow: FLOW_OUT
Message-ID: <5fd2d5a3-8499-4811-b2b0-457a2116807e@linux.dev>
Date: Mon, 5 Oct 2026 23:30:18 +0800
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
To: Rik van Riel <riel@surriel.com>, dave.hansen@linux.intel.com
Cc: luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 qi.zheng@linux.dev, nadav.amit@gmail.com, thomas.lendacky@amd.com,
 kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 brendan.jackman@linux.dev, jannh@google.com, mhklinux@outlook.com,
 andrew.cooper3@citrix.com, Manali.Shukla@amd.com, mingo@kernel.org,
 stable@vger.kernel.org, toshi.kani@hpe.com, david@kernel.org,
 mikhail.v.gavrilov@gmail.com, pfalcato@suse.de
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <4686fbed54796cbd32b5d524938d9cde184ca501.camel@surriel.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <4686fbed54796cbd32b5d524938d9cde184ca501.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/10/5 23:15, Rik van Riel wrote:
> On Mon, 2026-10-05 at 13:23 +0800, Lance Yang wrote:
>> pud_free_pmd_page() uses a single-address invalidation to flush the
>> paging-structure caches before freeing the page tables. With AMD TCE
>> enabled, this only invalidates upper-level entries associated with
>> the
>> target address. Cached PMD entries for other addresses in the PUD
>> range can
>> still reference the PTE pages being freed.
>>
>> The AMD manual quoted in the commit enabling TCE says these
>> instructions
>> remove
>>
>>    "only those upper-level entries that lead to the target PTE in the
>> page
>>    table hierarchy, leaving unrelated upper-level entries intact."
>>
>> Even with all PTEs cleared, speculative page walks can cache present
>> PMD
>> entries after the earlier TLB purge.
> 
> The comment above the function says it all. The TLB
> range should already have been cleared by the time
> pud_free_pmd_page() gets called:
> 
> /**
>   * pud_free_pmd_page - Clear PUD entry and free PMD page
>   * @pud: Pointer to a PUD
>   * @addr: Virtual address associated with PUD
>   *
>   * Context: The PUD range has been unmapped and TLB purged.
>   * Return: 1 if clearing the entry succeeded. 0 otherwise.
>   *
>   * NOTE: Callers must allow a single page allocation.
>   */
> int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> {
> 
> The PMD could have been (speculatively) loaded by the
> CPU after the PTEs were freed, so that one PMD mapping
> needs to be flushed here, but there should not be
> anything else left to flush.
> 
> The code looks odd, but it's a good idea to always
> ask your AI to draw up a full chain of events for
> a bug to trigger, going all the way back to something
> calling the mm from the outside.

Thanks for looking into this! I'll take another look
and trace it through.
