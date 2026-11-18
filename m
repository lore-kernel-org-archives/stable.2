Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998917;
	b=JQQJKjXdVLHyNdoXKDJH5+PMxfXZiEKQgYMahyzAXqL2I/msaSbuk80DELOpyRLnu9a1
	 nidDQl/V4SfBnmMUiBVUPlXv0lDppwaYkbFQZx2piMwe6NoHLVLrFVMpVLpMco4GZVlOn
	 EAKhpHo7ovZk9hgyIGSt9bdNCvt9aYQCQCSrmNtk/AoKmmw22jVIM4FnPpb2+iNFVXqA4
	 rlFwFQZ8raOREIR5kV0p3dbpsrgtA8IE3ItqPMQZFSLaR2ldzrCtRbqBLElie7PlYqOCX
	 fZSeYcGopwJBv2Cl+B9K4sU2bxxR2svJf3Ksd+IOs0eqc7BrPeGlvtaPKT4r5aIEcPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998917;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=W1uSvoiBabt6oG4pYFkFZJDxqSEx4Q5tZSCD5RmYIGE=;
	b=004tmy6SbNRKaaZpG4di1IibCpSo+ZCrQfSbBNkjLfPTSN0okcGvm8r1YikY5UjL6AjD
	 BKppAe76FmBg18J87WpOGkTblaiK4UL0RokzA6mUui+UexppzaxxiR85XhQYTniSLK3jQ
	 2ORAAw3gURIHcHPM3A3tMzIHyGKBii6QEkFJhrOblBvK1cZdMLaDLRlO/esxLaPQ+imZi
	 iWv/d5xKiw9laqnZobNnVdrUp3kSzEGzMN4SHFpXNDmA4EhH2BdDuEt6FAmniRUJ1YBbD
	 efjdI9EL7k2QQcLQ2MAlxXJxHJOWp8XWWjRRnW0GSucsPKF4efZCBFuTTNpsJhi6qjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="i2fmd+/4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78607606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=i2fmd+/4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6211F000C6;
	Wed, 18 Nov 2026 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794998916;
	bh=W1uSvoiBabt6oG4pYFkFZJDxqSEx4Q5tZSCD5RmYIGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2fmd+/4Qp0bzjUEUWcNuxOu9GRwAYkHqLMaoQkWYlDkcbZF2l+wHCk5a/UUpDyyf
	 OoVTWa6ijhndHh2b2kcfzKuDKBf/BcdfZQpSS/8rMqYFzPtD+BgQPQlgNEwHBGzfns
	 MVWTvx2aNWf1YK/sbxxSfU+6840g9h2ordfn2Gr0=
Date: Wed, 18 Nov 2026 11:48:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: stable@vger.kernel.org, Samarth Narang <samarth.colleges@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Xu <peterx@redhat.com>, Bobby Powers <bobbypowers@gmail.com>,
	Brian Geffon <bgeffon@google.com>,
	Denis Plotnikov <dplotnikov@virtuozzo.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Martin Cracauer <cracauer@cons.org>,
	Marty McFadden <mcfadden8@llnl.gov>,
	Maya Gokhale <gokhale2@llnl.gov>,
	Pavel Emelyanov <xemul@openvz.org>, Rik van Riel <riel@surriel.com>,
	Shaohua Li <shli@fb.com>, James Houghton <jthoughton@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, SJ Park <sj@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: Re: [PATCH 6.12.y] mm/ksm: fix userfaultfd protection during merge
 and unmerge
Message-ID: <2026111802-facial-asparagus-d380@gregkh>
References: <20261109200758-failed-6.12-990d6c2194a9@kernel.org>
 <20261111082901.32704-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111082901.32704-1-lance.yang@linux.dev>

On Wed, Nov 11, 2026 at 04:29:01PM +0800, Lance Yang wrote:
> KSM loses userfaultfd protection when replace_page() builds a new PTE from
> vma->vm_page_prot.  Dropping its uffd bit lets a subsequent write go
> through ordinary COW instead of userfaultfd write protection handling.
> For RWP, a merged page also becomes readable without faulting.
> 
> Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
> have to handle unmerging.  An existing KSM page can be protected with RWP
> before MADV_UNMERGEABLE, so unmerging already needs fixing independently
> of preserving RWP during merging.
> 
> Unsharing replaces a shared page with a private one and should leave
> userfaultfd protection in place, as do_wp_page() already does for write
> protection.  Currently, an unshare fault reaches do_uffd_rwp() before it
> can proceed to do_wp_page().
> 
> - With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
>   break_ksm() then reports success with a KSM page still merged.
> 
> - With asynchronous RWP, protection is cleared before unsharing.
> 
> Preserve the uffd bit when merging, and restore PAGE_NONE for RWP.  Let
> FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
> private copy as well.  Unsharing can then complete with RWP still armed
> for a subsequent access.
> 
> Link: https://lore.kernel.org/20261026130054.91461-1-lance.yang@linux.dev
> Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
> Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Xu Xin <xu.xin@linux.dev>"
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Bobby Powers <bobbypowers@gmail.com>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Cc: Doug Gilbert <dgilbert@interlog.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Martin Cracauer <cracauer@cons.org>
> Cc: Marty McFadden <mcfadden8@llnl.gov>
> Cc: Maya Gokhale <gokhale2@llnl.gov>
> Cc: Pavel Emelyanov <xemul@openvz.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Shaohua Li <shli@fb.com>
> Cc: James Houghton <jthoughton@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: SJ Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> Cc: <stable@vger.kernel.org>
> 
> (cherry picked from commit 990d6c2194a938a19a8cf94c6cfd75171345089b)
> ---
> Backport to 6.12:
> - Use the older pte_uffd_wp()/pte_mkuffd_wp() helpers.
> - Drop the mm/memory.c changes. 6.12 has no RWP support.

Dropped as you didn't also include a 6.18 backport :(

thanks,

greg k-h
