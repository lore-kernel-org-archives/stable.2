Received: from mta1.migadu.com (out-84.mta1.migadu.com [95.215.58.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212054A261C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210268; cv=none; b=VuVP4ewYq4zwne0EomRdPCevrzq6ttlqmLs/PmVhhzS3xnud/gasmo8yNnjKEjNo7/EH1SizEF5ZpIYxTLDbw/ufE12jddjxHSbSJtjFwzPZ1RII28F5Y33+ZlRS2Bs/WIBNQWMwiP4FiouZUtzzYU+vLK5kgLmtywdYL+P+C6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210268; c=relaxed/simple;
	bh=CbENxEWT081LxG9Ca/66oabxXg/6aD0RFXIFh5r/llo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGg3ssR0QfNxuMFXzxL4XDKCukGZIeAhgaTCVKY/GpDk//BOK9Jd6c/bAVBbzSuOKKWTzLFOJnYrSK6E3tPAvKNXZOuHhgnduOZdyRsk/JeCPYMRvMFMFNFNmOww3FFtA42+kK29vuG/SsbHMeaWCud0ZfsPYoWYpCCUJ/nAzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h6zOtN/q; arc=none smtp.client-ip=95.215.58.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h6zOtN/q"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CbENxEWT081LxG9Ca/66oabxXg/6aD0RFXIFh5r/llo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791210255; v=1; x=1791815055;
 b=h6zOtN/qBwuHI80mhLldSlsEthK5OvmsfCxKoEmVv2prrKumZMQj6qMudQmsfYofcg7Jl3EM
 L/j2MfunxfX0R4jcbjOvxnrn6aynQP4GlaV/XAgKD6WmslFoiCAUaIzX7R7qx7D6UigUlZCz6g8
 Ue9KIaQgKfVXdGG8VrRLtjfo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ca78f09690eedc77;
	Mon, 05 Oct 2026 14:24:15 +0000
X-Mizu-Trace-ID: ca78f09690eedc77
X-Migadu-Flow: FLOW_OUT
Message-ID: <b928b8a4-5ec5-4642-ac02-9ecbbbfd6218@linux.dev>
Date: Mon, 5 Oct 2026 22:23:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv/mm: fix soft-dirty migration PMDs being treated
 as present
Content-Language: en-US
To: david@kernel.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, zhangchunyan@iscas.ac.cn, rppt@kernel.org,
 kas@kernel.org, andrew+kernel@donnellan.id.au, rmclure@linux.ibm.com,
 debug@rivosinc.com, baolin.wang@linux.alibaba.com, usama.arif@linux.dev,
 wangruikang@iscas.ac.cn, namcao@linutronix.de,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com, viro@zeniv.linux.org.uk, ajones@ventanamicro.com,
 arnd@arndb.de, axelrasmussen@google.com, brauner@kernel.org,
 conor.dooley@microchip.com, conor@kernel.org, jack@suse.cz,
 liam@infradead.org, ljs@kernel.org, mhocko@suse.com,
 paul.walmsley@sifive.com, peterx@redhat.com, robh@kernel.org,
 surenb@google.com, vbabka@kernel.org, yuanchu@google.com,
 stable@vger.kernel.org, pasha.tatashin@soleen.com, linux-mm@kvack.org,
 me@ziyao.cc
References: <fabd52b6-36a7-442e-9cfb-47a39e4ae3d6@kernel.org>
 <20261005134641.5801-1-lance.yang@linux.dev>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261005134641.5801-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/5 21:46, Lance Yang wrote:
> 
> On Mon, Oct 05, 2026 at 12:37:20PM +0200, David Hildenbrand (Arm) wrote:
>> On 10/4/26 05:03, Lance Yang wrote:
>>> RISC-V uses _PAGE_EXEC for swap soft-dirty tracking when
>>> CONFIG_MEM_SOFT_DIRTY is enabled and Svrsw60t59b is available. That's
>>> a problem for PMD migration entries, since pmd_present() also checks
>>> _PAGE_LEAF (R/W/X) to recognize THPs with _PAGE_PRESENT temporarily
>>> cleared during splitting.
>>
>> I'm curious: why do we have to set leaf indications for non-present things? The
>> HW sure will ignore it, right?
> 
> Yeah, that surprised me too :) Still wrapping my head around the details
> ...
> 
>> Is this a sw problem? Who needs that?
> 
> IIUC, it's for software during a PMD split.
> 
> __split_huge_pmd_locked() invalidates the huge PMD and flushes the TLB
> before installing the PTE table. Software still needs pmd_present() and
> pmd_trans_huge() to recognize the THP in between.

Also, x86 keeps _PAGE_PSE to identify the huge PMD. RISC-V doesn't
have a separate leaf bit, so it keeps the R/W/X bits to identify
the PMD as a leaf entry :)

> 
> RISC-V clears V but keeps the R/W/X bits for that, so the entry is invalid
> to hardware but still identifiable as a THP by software.
> 
> Hopefully I didn't miss something.
> 
>>>
>>> When a soft-dirty THP is migrated, set_pmd_migration_entry() preserves
>>> soft-dirty with pmd_swp_mksoft_dirty(), setting the X bit in the
>>> migration PMD. Even with _PAGE_PRESENT clear, we end up treating a
>>> migration PMD as a present THP! The fault handler skips
>>> pmd_migration_entry_wait(), and a write fault can end up in
>>> do_huge_pmd_wp_page(), where pmd_page() decodes the migration entry
>>> as a mapped PFN.
>>
>> That sounds bad.
> 
> YES, looks a bit off ...
> 
>>>
>>> Move the swap soft-dirty bit to bit 12 and start the swap offset at
>>> bit 13 when CONFIG_MEM_SOFT_DIRTY is enabled. This keeps R/W/X clear
>>> in migration PMDs and lets us keep the existing pmd_present() check
>>> for invalidated THPs. Leave the offset at bit 12 when soft-dirty
>>> tracking is disabled.
>>
>> That reduces the effective swap size (and PFN we can store). Could that be a
>> problem?
> 
> We don't need all 52 bits of the swap offset.
> 
> RV64 PFNs only need 44 bits for migration entries, and actual swap is
> already limited to about 16 TiB per area with 4 KiB pages by
> last_page (__u32) and swap_info_struct.max (unsigned int).
> 
> So there's room to reserve a bit without reducing the supported swap
> size or PFN range.
> 
> CONFIG_MEM_SOFT_DIRTY is only available on RV64, so RV32 keeps its 20-bit
> offset.
> 
> [...]
> 
> Cheers, Lance

