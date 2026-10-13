Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29E42255C;
	Tue, 13 Oct 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902773; cv=none; b=nBXgKuCp8VX+VHPIBE2PxLhWftuokO8UexGcToDdyEVf3FTRyXDH4bseOSYvEZ8k8zOEYRaDVbB8ImAeUZHW5KS8TkLls5rjepdBnxemfggyhy+hBEDwlQpascEsAYhkC07CG889iW3f2MMhYpx26OsmOOimNY8t/+kRPOgNKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902773; c=relaxed/simple;
	bh=jjpBFTErSy0osbl4v/wsww4m1OSHMX3EC4VBJahpAfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEL9daA8WxpaZEYbJOI+4HEKTRb3yqPXGAjfEr5oaEZ4lbCUwIX9lqTqSaA6EdG5IVxNUKzXdaSEFYFDvNRwp20zjUmw9UNfF3CnW3/VOEoWjWaAAJvzIId+rl44UWlyvs9h3E6aslsz7FSKImzJoi5HraYpv6j4pofA7TS2KqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R325y+e8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R325y+e8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0B01F000FF;
	Tue, 13 Oct 2026 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902772;
	bh=4F6Tw46VkpNnGRzthbkmTP21wgcYOdI2X0+e0mUpCFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R325y+e8Sm80qlgGpI6ejkQ0qXq2S1XHtB2tkNvLNBtXYPvujVNORQtOkp02R5DAm
	 uvOzEBFct97UIjQUblh6DAlGRtaaw4zPKE+tTW1eU5A4ll4wuM3t4quqTJtl++2jbL
	 x4AKLA7MIns2uDvWr493MCaD4Q4CSY7n2RvxVqBKWeBby4LSQNh3UT5i9FnwE/Kl3j
	 KNWjrnDtzahxrqSrcBcLhQVBZgBSdLZNpS03271OAhLApWyapgdhc8GmTkp8AaVPQH
	 mrmhjqkOn+R/15+ePbn0Bt9JdhPb6K7rbX3v7gQHh/CDDMIJRPvEaJ2nv77LyWTM9x
	 eYIKbtEfCSX8w==
Message-ID: <154d653f-c6ab-4357-b823-a345a8524470@kernel.org>
Date: Tue, 13 Oct 2026 16:46:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userfaultfd: fix UFFDIO_MOVE livelock on large folio with
 extra references
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
References: <20261012201514.97015-1-cenzhang@linux.microsoft.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261012201514.97015-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/26 22:15, Cen Zhang (Microsoft) wrote:
> To move one page out of a large folio, move_pages_ptes() first has to
> split the folio.  __folio_split() refuses if the folio has any
> reference beyond its page table mappings and the caller's own, and it
> reports the refusal as -EAGAIN.  move_pages() treats returned -EAGAIN
> as a transient race and keeps retrying the same address, holding the VMA
> read locks the whole time.  This is incorrect since in some cases
> userspace can hold such a reference indefinitely, such as by
> registering the page as an io_uring buffer.
> 
> An unprivileged user can trigger this with three threads: first holds
> such a reference on a page of a THP, second calls UFFDIO_MOVE on another
> page of the same THP and spins in the kernel forever holding the VMA
> read locks, and third calls fork() or mprotect(), which takes mmap_lock
> for writing and then waits forever for those read locks.  From then on
> every mmap_lock user of that mm hangs, including other processes
> inspecting it through /proc/<pid>/, until the process is SIGKILLed.
> The hung task detector reports the blocked tasks (third one), and with
> kernel.hung_task_panic=1 the machine panics:
> 
>   INFO: task wedge:95 blocked for more than 122 seconds.
>   task:wedge  state:D stack:12528 pid:95 tgid:95 ppid:94
>   Call Trace:
>    __schedule+0x596/0x1110
>    schedule+0x36/0xf0
>    __vma_start_exclude_readers+0x100/0x170
>    __vma_start_write+0x51/0xd0
>    __split_vma+0x208/0x3d0
>    vma_modify+0x6a8/0x840
>    vma_modify_flags+0xce/0x110
>    mprotect_fixup+0xbe/0x480
>    do_mprotect_pkey+0x2d9/0x580
>    __x64_sys_mprotect+0x1a/0x30
> 
> Fix by returning -EBUSY instead of -EAGAIN in move_pages_ptes(), the
> caller of split_folio(), when the split fails. Thus, move_pages()
> does not retry -EBUSY and the ioctl drops its locks and returns to
> userspace instead of spinning.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Assisted-by: LLM
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
> ---
>  mm/userfaultfd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 74f04c323c50..500962be1162 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1663,8 +1663,12 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
>  			pte_unmap(dst_pte);
>  			src_pte = dst_pte = NULL;
>  			ret = split_folio(src_folio);
> -			if (ret)
> +			if (ret) {
> +				/* do not retry, extra refs may be held forever */
> +				if (ret == -EAGAIN)
> +					ret = -EBUSY;
>  				goto out;
> +			}
>  			/* have to reacquire the folio after it got split */
>  			folio_unlock(src_folio);
>  			folio_put(src_folio);

Yeah, that makes sense to me.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
