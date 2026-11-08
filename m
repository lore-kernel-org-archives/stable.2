Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129805;
	b=TF9xHbeZUqt2a5CuFwQ/M7VvxfmoS6jnDIn6GqV9xwSVFtaO+PFgyPNzhyCvnFxic8v7
	 6PtzKQ7vW32ew6nTfi6ne92vJMm7nMi23m3aHIFvN7O8tFVuPE24bigTGe4O4MmBplI/v
	 pnV8ninqhkav4qrLHo2tbHFqPeW12hN519sJsqfej/6m2tAXHwB3yKCK9fwjO8nEhPIDu
	 lFg4mrEr3vGxlRa2o8OPveOi3nJZh3VIeKGOA0BdEVv+iVdCETaW8XBV9f830XC2beefm
	 SXOLnFIbIHdvfhz2sbP/44d6GPxmgqF1sq1SwN8Jp2mEZOtvBGToLdJhWM1svhT4b8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129805;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5XXct/mS8QSJCzfaXHvfDvD/GjABqbPTOqaOMdXOtqQ=;
	b=E3qbvucfkI6/DX6cqzv5hVoponi5ZIPm83OXZlOFeUQD8iQsKwCVkCRuiu0/rdIh6g5l
	 kFnVVICEvjQcuMh0R9UoSaPm9SQlrIhvl74h9nVz5GJIiqYFCJBoY5LZAUoBGcWkLA7+O
	 5/8B5tm0SrK2Crb567bwKeYgQUFBHjTvg08u/I1cqPRSpUQJ7CA9qAsfTqAuucAnBNbeq
	 ZMxA5Jzk2Wutu01bO40KVzkwDpwniKD0N9WefmU7eG08FRRAfVr6g+b9MD3YgOm+DZTJQ
	 CKeJWn+rVFNmIOnNS1L44ir0K52htS6Az3OpvCut3puNQO2UtBJ2nVeH26kQiplsBxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K82No4gD;
	arc=none smtp.remote-ip=91.218.175.246
Received: from mta0.migadu.com (out-246.mta0.migadu.com [91.218.175.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B3606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 09:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 483B3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K82No4gD
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5XXct/mS8QSJCzfaXHvfDvD/GjABqbPTOqaOMdXOtqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794129802; v=1; x=1794734602;
 b=K82No4gD/U0EDL8G5b0U3E/LJ/m2ZvtIurq4uACX0LgP99VkFG0/tl/mLp9yB/4+LZc8Oqyx
 y91WHpBUYPqB+EC56RlWaLqSTWEwxtt9cN3p4O9UVS6Ss8cvT+MH9gSuujZ94cxLHGxpsZP3usU
 bGtGN4oEaj5k9niDGR5r6uZ0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fe3ad667d8daeff1;
	Sun, 08 Nov 2026 09:23:22 +0000
X-Mizu-Trace-ID: fe3ad667d8daeff1
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	qi.zheng@linux.dev,
	hughd@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: don't allocate a page table under RCU in do_set_pmd()
Date: Sun,  8 Nov 2026 17:23:15 +0800
Message-ID: <20261108092315.89639-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261106-khugepaged_set_pmd-v2-2-d2457b5e377a@kernel.org>
References: <20261106-khugepaged_set_pmd-v2-2-d2457b5e377a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Nov 06, 2026 at 01:36:13PM +0100, David Hildenbrand (Arm) wrote:
>do_fault_around() skips PTE table preallocation when the PMD already points
>to a PTE table. A concurrent collapse can then retract that table and
>clear the PMD before filemap_map_pages() locks the new PMD-sized folio.

Right, having a PTE table when we check in do_fault_around() doesn't mean
it'll still be there later ;)

>filemap_map_pmd() can then call do_set_pmd() with an empty PMD and no
>preallocated table. On PowerPC hash MMU, do_set_pmd() then tries
>allocating a PTE table to deposit. But filemap_map_pmd() calls
>do_set_pmd() under RCU, so allocating from that context is not good.
>
>This race became possible when retract_page_tables() stopped taking the
>mmap and VMA locks. Previously, those locks excluded retraction while
>the fault was in progress.
>
>Add a may_alloc argument to do_set_pmd() and pass false from
>filemap_map_pmd(), so we can fail with VM_FAULT_FALLBACK instead of
>trying to allocate.

YES, just fall back and let the regular fault handling take over after
leaving RCU.

>This issue should be fairly hard to hit in practice.
>
>Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM1

Reviewed-by: Lance Yang <lance.yang@linux.dev>

Cheers, Lance
