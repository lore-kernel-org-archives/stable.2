Received: from mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90019472F8E
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964587; cv=none; b=BA8hvUqmQFxWqXq2kTVCdMNc0vPzpZVP4w14Oy3QEajF7AWxtSqGB3vf9tvFFe1ovwhuAHtRyAeCXQJ96pyJ8l8qm121hpBfQU8NZ1AXUAGNcPnXZi6NDVFzVzV2fLIm29X2yQmS0ovgY0SQXAF0xZsIolSId149+Ui3XusQR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964587; c=relaxed/simple;
	bh=3NakkYm+exfqHeo87l+Jy3RJZBZS8mbhTiQS6F5ENvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ughiNWnpmoYexE9rjEiwqQoU1KkqCb90hJKhReXXaeaxmYr0lzNMdXMWbK5nnODH72F+XljrermZCEeaI9hlgJyDoPIbFlqsZ0ZCJ+DTwfQauLLvdRencIAxKhK3tAXsJq5RQWoHK3RUo1avlYbWA7x1ER+rfRKb2r47ZozhfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KgfDKtGl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KgfDKtGl"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3NakkYm+exfqHeo87l+Jy3RJZBZS8mbhTiQS6F5ENvk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791964582; v=1; x=1792569382;
 b=KgfDKtGlnya+w0y+13eDfqGYwadeUvStcnSjdRAXRZPy/w4ajj0Yu1rBDQ1hqaulwiQkV10G
 TBiORH9tEtm52K4jwFva0QEuVVFkuvUSmTzHiLNz9qiE/zk15Gsg+ZFlKVkSI9pJdKeHfueUC/x
 68XbzPnENWRiOxSmlLisNpgE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 38737ea13a66a289;
	Wed, 14 Oct 2026 07:56:22 +0000
X-Mizu-Trace-ID: 38737ea13a66a289
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: pjw@kernel.org,
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
Date: Wed, 14 Oct 2026 15:56:16 +0800
Message-ID: <20261014075616.76429-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261007113345.32755-1-lance.yang@linux.dev>
References: <20261007113345.32755-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Oct 07, 2026 at 07:33:45PM +0800, Lance Yang wrote:
>
>On Wed, Oct 07, 2026 at 01:01:14PM +0200, David Hildenbrand (Arm) wrote:
>>On 10/5/26 15:46, Lance Yang wrote:
>>> 
>>> On Mon, Oct 05, 2026 at 12:37:20PM +0200, David Hildenbrand (Arm) wrote:
>>>> On 10/4/26 05:03, Lance Yang wrote:
>>>>> RISC-V uses _PAGE_EXEC for swap soft-dirty tracking when
>>>>> CONFIG_MEM_SOFT_DIRTY is enabled and Svrsw60t59b is available. That's
>>>>> a problem for PMD migration entries, since pmd_present() also checks
>>>>> _PAGE_LEAF (R/W/X) to recognize THPs with _PAGE_PRESENT temporarily
>>>>> cleared during splitting.
>>>>
>>>> I'm curious: why do we have to set leaf indications for non-present things? The
>>>> HW sure will ignore it, right?
>>> 
>>> Yeah, that surprised me too :) Still wrapping my head around the details
>>> ...
>>> 
>>>> Is this a sw problem? Who needs that?
>>> 
>>> IIUC, it's for software during a PMD split.
>>> 
>>> __split_huge_pmd_locked() invalidates the huge PMD and flushes the TLB
>>> before installing the PTE table. Software still needs pmd_present() and
>>> pmd_trans_huge() to recognize the THP in between.
>>> 
>>> RISC-V clears V but keeps the R/W/X bits for that, so the entry is invalid
>>> to hardware but still identifiable as a THP by software.
>>> 
>>> Hopefully I didn't miss something.
>>
>>I thought some change we performed to GUP-fast wouldn't require that anymore.
>>But my memory is a bit vague ... :)
>
>Yeah, I'll have another look at that :)

Emm ... I'm back. Do you mean 4b471e8898c3, which removed the GUP-fast
pmd_trans_splitting() check after the THP refcounting rework? That check
made GUP-fast bail out during the old THP split. The refcounting rework
made extra GUP references prevent the physical split :)

RISC-V gained THP support in 2021 (e88b333142e4), after
pmd_trans_splitting() had been removed. It never implemented that helper.

Keeping R/W/X in an invalidated RISC-V PMD preserves its leaf identity for
software page-table walks. That requirement is separate from the old
GUP-fast splitting check.

For RISC-V, pmd_mkinvalid() clears V and PROT_NONE but keeps R/W/X, so
pmd_present() and pmd_trans_huge() still return true:

#define _PAGE_LEAF (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)

static inline pmd_t pmd_mkinvalid(pmd_t pmd)
{
	return __pmd(pmd_val(pmd) & ~(_PAGE_PRESENT|_PAGE_PROT_NONE));
}

static inline int pmd_present(pmd_t pmd)
{
	/*
	 * Checking for _PAGE_LEAF is needed too because:
	 * When splitting a THP, split_huge_page() will temporarily clear
	 * the present bit, in this situation, pmd_present() and
	 * pmd_trans_huge() still needs to return true.
	 */
	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE | _PAGE_LEAF));
}

static inline bool pmd_leaf(pmd_t pmd)
{
	return pmd_present(pmd) && (pmd_val(pmd) & _PAGE_LEAF);
}

static inline int pmd_trans_huge(pmd_t pmd)
{
	return pmd_leaf(pmd);
}

And the rmap walk also needs that leaf indication. page_vma_mapped_walk()
checks pmd_trans_huge() before taking the PMD lock, then rereads the entry
under the lock. Keeping R/W/X lets it recognize the invalidated THP and
wait for the split to finish :)

Anyway, R/W/X still have a job there (RISC-V doesn't have a separate leaf
bit), and I don't think we can just drop them yet :D

Cheers, Lance

[...]
