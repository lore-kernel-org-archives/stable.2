Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC83BCD2A;
	Wed,  7 Oct 2026 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370907; cv=none; b=LUXEWXvSBIlhZuN2ylJ671inm788LmJbmQQRTOOKmxw9/9ZuMf05g5Lb9Fhun5zGFmcIwSpr175+0JTgYOXhHPaxHZ336PCUyCREAbqcFT+rpkWI7s5vg53iyBVFQqmJ3nM6dLJ7mOJjNfcc676a7xyiyIZXJ3XYumTngvpAwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370907; c=relaxed/simple;
	bh=dlV86gXzHgWAwOA3RYUTEHMqRn+XNzA2rSGsnNUZcfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTo7PsaYU6vnNQyCXCc8vaPGt0w1sgCzZvsVK0Ws1TTEnMUHEQ0IQ34RQPjZMcpSwOngmk4jCxLf9KFGO1H0ynrr73SxRFmPMc+sf4VHhr+CEDVrBEGFzKZ6SQzD9JJFam3X5nlK0ySdBq6FXTxSFfjGn/FDk0oD394IWs1/ADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyDAibe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyDAibe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF84F1F0089B;
	Wed,  7 Oct 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791370885;
	bh=oj+jPv+W3w4mQ53IZPa0Z9z2WElXYSTGhTs8GSivQOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RyDAibe96Eq/7kf+TLq5bawmi37igOsg/UMj3h8nppbsBm4/0BO4DS9C2Kmn7qeq3
	 crVliEz67Dwxbp9KPAmewYN2KaM+5HN7ehBeEKXZI74Xw84Djzhpd/ITtoOSeurzKB
	 imskknXHsIhAMXD/TE5ljilnge8SW0Wh247bO3Ay4in9N2UkzDsYFGgHb8+ZWppYzh
	 filExIkMvEToz8TregUkBzcU001evOU1KzpRqu5vrtMAbVHO+9I6FerFDmaUHxsOi/
	 pcdYAXjNqgTu2kZsGVcs0lNsaffA54L13s20tpZzce4SVc/Eq0pYWzxFH5QuHIR+iK
	 1sF4YNgtGwp/w==
Message-ID: <69c33490-e5a3-4cf2-a5ed-d2bc8ed336d2@kernel.org>
Date: Wed, 7 Oct 2026 13:01:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv/mm: fix soft-dirty migration PMDs being treated
 as present
To: Lance Yang <lance.yang@linux.dev>
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261005134641.5801-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/26 15:46, Lance Yang wrote:
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
> 
> RISC-V clears V but keeps the R/W/X bits for that, so the entry is invalid
> to hardware but still identifiable as a THP by software.
> 
> Hopefully I didn't miss something.

I thought some change we performed to GUP-fast wouldn't require that anymore.
But my memory is a bit vague ... :)

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

[...]

> YES, looks a bit off ...
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

Good, can you spell that out in the patch description?

-- 
Cheers,

David
