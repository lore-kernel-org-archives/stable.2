Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366829;
	b=rltA7roZoKaQ7U4h67aH7iNKyc/hNyKvoP4mQ7La7OBtLWVlTSBccnxJrIo7Ij9yhdXO
	 KWF5zm2XT4ifRlhb5pVLznP88AqC/YRn2ckR3KKGJxLuWNBLMpxnxXqyODxR+EC58uanU
	 hHHemHjcYdbRuzJaw1XNpQ2DySWAKzC+ZnDxrz+2TqO/egwz5t9g8Jhnpez7EWpXiO9wE
	 4y/qNQUvg1cHvBcz8VyocjFn66xE4BE6jgXfs76vD5q0+K6PVElNFKPGIZaSy5fP+TPT4
	 Zg6hhXznWcaCeWT9SRnOlF3F7Jtl8P4ETK/efllSWEAMdCU1Tmca6K7yGswY2PTJRHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366829;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=uEqI+Hp2ezJcINVPIUjY03p8JSLOYnYNaqnNBkjZ3rE=;
	b=wI1oVQsk+MkGOeEDiN+tlJba/GWvxVJnjAZV7v/s0TvrGOs47JvSrpeGveLo9VENcRzl
	 PNDBtJjveATnnAv8HRS8G2DWv5pYTXHAighQpvSIWl2SFADQ0JeF+clYFgmT6Ad1FM5vq
	 nafSCjP0r1kaEm12pFH6CblOIBW6dgW6SXVqTH2ojytJmrXOJM35dMakcBzyTMKxewD6u
	 dJv0hg7iZisMCHW0QRlN8FSjCmTmtMMlKEWGy7NoOc6wZMd60X/rOXN0QMny6hgnZ5QlS
	 sIiMuPopIb+05dJNim+kd7vM9AfDa9P5GKgmXrxUStg6Phhh7nFcjrLY8aqZE+xwXcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vmmyrz6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37E606A332;
	Sun, 22 Nov 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vmmyrz6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0C71F000C0;
	Sun, 22 Nov 2026 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366829;
	bh=uEqI+Hp2ezJcINVPIUjY03p8JSLOYnYNaqnNBkjZ3rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Vmmyrz6uK/hYFVidaN2kK+me23a5dUvyk0Op1qeTqHLVqOB88p979QDWelJLt4iap
	 Q1sC8F5zSKZsnUF8J+6xDtlQUU5jID1AtgIYKPRDH4joDHKoOdZ9Z0UEKeZAtS4hQx
	 yvEnCcbrfkkVFn4UA1Xad0pMG9ZT2em9iF5BDDR36qpKsYiSWqPFlFM2EpWLlPWNni
	 AFqo/CI+7GxHabb1n9Gz8W7wZ8CkJ7YkvELRNntoSdhJ45I8dnGf7IW2mmXqth+sBq
	 QNCUJ+JztoZssg7tPc2aSRqkemJ25EJPdIv0x9dG+NYWgEVGBcV1LmZgxEIEXdKLDK
	 1svDrLaa66c8A==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
Subject: Re: (subset) [PATCH v6 0/4] mm/huge_memory: copy PMDs at fork like
 the PTE path does
Message-Id: <179536682240.11318.5673184071692513568.b4-ty@b4>
Date: Sun, 22 Nov 2026 18:00:22 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 19 Nov 2026 14:44:01 +0100, Konstantin Khorenko wrote:
> v6 is rebased onto mm/core for-next, as David asked, and patch 2 was
> finished on the way: it now checks the page cache refcount limit before
> it copies a file folio, as copy_present_ptes() and copy_huge_pud() do
> since the refcount overflow fixes. So patch 2 changed after the
> Reviewed-by tags it carries.
> 
> copy_huge_pmd() decides what to copy at fork by its own rules, apart
> from copy_present_ptes(): a lockless check for special PMDs, and a skip
> of every file THP. Following David's review of v3, this series makes it
> decide the way the PTE path does, under the page table lock, with
> vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
> patches:
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: thp-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/4] mm/rmap: duplicate a PMD mapping as one in folio_dup_file_rmap_pmd()
      https://git.kernel.org/mm/core/c/4d47d354
[2/4] mm/huge_memory: copy file THPs at fork like copy_present_ptes() does
      https://git.kernel.org/mm/core/c/e21c5cf9
[3/4] mm/huge_memory: read a special PMD under the lock in copy_huge_pmd()
      https://git.kernel.org/mm/core/c/39b0669b

-- 
Cheers,

David

