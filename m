Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457221;
	b=K4tSEfr2YLmLeq5rrvUFexIEbhkjlfhWr4X4BIua0nADjOrio2XlYvRboVC1uTs4HSYr
	 5CAs9irqZUKp3BdEyNXCr7KZ2v2/0ZVf9qeAeLSIyaxK4pXJArRTMqTW5qV1RBHi9pHOZ
	 s7GcIBE0HszxNOz/fjQEe1DYxfiUy9ROogrEmW0uiHQx/tqLg88VxCbxKBwYhwl5Tj6W+
	 bJovfGjT/VP9oU7yFqRtKd2RljZkdSNF4Lbc76qJ6Zxnl/tcbmQ+eXY4ECO55PhAsYrKV
	 N446Cu/ErN89x4z7VNwY9QDwTX8Hf/u7+4D24R0j1zDK1b04Ng2pKy33IzRDEsJKhWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=THCDFH8janu1MCJy9xPLeuhEIpEIYRM+RVgL+pWhx/0=;
	b=N0fATuyo6JAFccqQglNVTH5ksj5ZpKN47z8iT41Fp+QHDfHxV7HFCrR1BJX/avCmuY2R
	 c5LCnCgKCG5CN/32lGwqUtEE0s9+c8joeohmGFhl/+xKxbA/sUAU6ZBTbb3KXN2//GGV/
	 Lh8uprOlLDTicQq7FUO8vq2BtN44RXy3vEYbjgvKWmz1fhVLPZkE6+TjSvLP1+jX66BLi
	 FJX5W7pOnZA1if0hL2mCmh1feRCifQfBNJ65TD7xqtflhmomGtmM3Csjd3GHLXOnqpZWg
	 Pg7iEhZ1XuBI6q2band15NZL4+oiTXbNNAp3FFFeVq3ml8x6NdrSgPhXAWzbrUWtPkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=F1hGJ6pA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B1606A319;
	Tue, 20 Oct 2026 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=F1hGJ6pA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC5D1F000C4;
	Tue, 20 Oct 2026 00:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792457220;
	bh=THCDFH8janu1MCJy9xPLeuhEIpEIYRM+RVgL+pWhx/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F1hGJ6pAbEUEAurSVOl+WnA5fdZw+wqQYEUu6cMp/lLLjBcE34O+QMYZC1x8+DJ2L
	 tZo9oDX/oObaWYdmkLnukB8KWe+mtc0V7Gi16c3hsyRRrsrCokqr9XZAgasJQrkZ6X
	 iOJ5bwpX2VfuWZPHlXUn/QEmaQRKpWVU0E7jwHqs=
Date: Mon, 19 Oct 2026 17:46:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ngoc Quy <ngocquy0700@gmail.com>
Cc: liam@infradead.org, ljs@kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Muhammad
 Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: pin mm_users in do_pagemap_scan()
Message-Id: <20261019174659.42c3529d5e35563cc6e5244c@linux-foundation.org>
In-Reply-To: <20261014095540.3261469-1-ngocquy0700@gmail.com>
References: <20261014095540.3261469-1-ngocquy0700@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 16:55:40 +0700 Ngoc Quy <ngocquy0700@gmail.com> wrote:

> The PAGEMAP_SCAN ioctl takes mmap_read_lock() on an mm obtained from
> /proc/<pid>/pagemap without holding a reference to mm_users.
> 
> proc_mem_open() deliberately grabs only mm_count, so a consumer that
> touches the address space has to call mmget_not_zero() first. Every
> other consumer in this file does -- m_start(), do_procmap_query(),
> show_smaps_rollup() and pagemap_read() -- but do_pagemap_scan() does
> not.
> 
> Without that reference the target can reach exit_mmap() concurrently,
> and exit_mmap() calls unmap_vmas() while holding mmap_lock only for
> reading, which does not exclude the scanner. For ordinary VMAs this is
> harmless, as free_pgtables() and remove_vma() run afterwards under
> mmap_write_lock. A shared hugetlb VMA is different: __hugetlb_zap_end()
> frees the VMA's hugetlb_vma_lock inside the read-locked phase.
> 
> walk_hugetlb_range() can therefore load vma->vm_private_data, have the
> lock freed underneath it, and then down_read() a freed rw_semaphore.
> The load happens before the freeing side clears the pointer, so this is
> a use-after-free and not a NULL dereference. Any unprivileged user can
> reach it with no huge pages configured, as hugetlb_reserve_pages()
> allocates the lock before the VM_NORESERVE early return.
> 
> Pin mm_users across the scan, the way the other consumers do. mmput()
> from the exiting task can then no longer reach exit_mmap() while a walk
> is in progress.

All looks good and checks out for me, thanks.

Except...

> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -3231,15 +3231,18 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>  	size_t n_ranges_out = 0;
>  	int ret;
>  
> +	if (!mm || !mmget_not_zero(mm))
> +		return -ESRCH;

Why the new test for !mm?  The current call chain guarantees this is a
cant-happen and the current do_pagemap_scan will cheerfully oops if
mm==NULL.

If we start getting mm==NULL passed into the function then we want to
know why, and an oops is a good way of bringing attention, Quietly
accepting it reduces our ability to find stuff we did wrong,

