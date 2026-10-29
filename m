Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271248;
	b=1kKgiVtFCe9xrGnh1JUUZpIasMM5VY9Ut6ZnacV/A7pdQohrxgu4waC0ut8RcJlcJN7I
	 1IqhgEWp3UGzPqJG0RTpqQO2mAL3/wz3Wiq146NYfatZOKRcWkk6HCUhjsUc0sIjIYZ8Y
	 xjPq5Xe83I4gnMgnCMlvmLTW28STFWFiDzR5psfK8G2YMW28PGhhkRYj2/ufBhmY0nQkr
	 +XzAygYZ2MZzfsAb3LkzItUt1jZ9RYa3T043KOntCiUBNOkquSw2nxLVMaYHi8YJcpfQA
	 kaLz8gZ/CX5I3WiMPW3tXk9GnUdrjwiItB9pqPjj4Aw8SxUNeGe6P20zCAFfXecA1yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271248;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=yRQohK+CSt2OKE4WJtHLQd1a3qhKEoEvkjG3iYzfLuI=;
	b=lB6pErQGLDgklKmfS+brC/awczRWu3VcdKZ34v9BYB01O7LK1mB0K3Vmt2KqQiKG2gsh
	 jOp7Iu4fFlYplYFBBP4T2bmXiuvdZ2I3X9Q0wVyturIUTAgeLzTasXuGo1cDO2hf6Nw7a
	 01j/va0RHM/Ve1goJ+HIql6DgLHnHI4d4n/6nMlIL0ECy9ROHwiTfkotq5B2HhVd4PFKj
	 e+BRPoB7oDfGQTTcUDsC63fI1QSWP7OVMhM+yXp5voXxulMla9RiuZG14p0I8HYwDtPcH
	 bT3DLPluI2qxia0ZQsJCCXBEAi1NuJIrTnkj3BglssACVA9DdPxAM96cu1IDNBhPQkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0zWNQbb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B2606A31C;
	Thu, 29 Oct 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0zWNQbb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB29A1F01829;
	Thu, 29 Oct 2026 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793271247;
	bh=yRQohK+CSt2OKE4WJtHLQd1a3qhKEoEvkjG3iYzfLuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=N0zWNQbbnqBYz5SjJ7FymjJkYGEKptrE0TDLsZJx4o4qG4WBngSOzXO06L54iDVYo
	 5c66LIlnuajAKwRqmp8TSe6/sf6rsGNOVtyXtkbgOGeb+IVmi/Ad6785EauUqkvV9I
	 6jwsZJBIR+U1ZzYyNLvmAFomsFtds6sAvYNYFC4BT/oIy/3cSIfXeC2bf/fRiTZj/b
	 uvO5K9JnpHfhTMlyuorebMDeQG5dPl9Va+Jzwtdxs29naBrp3OYND8YS3ozUwUPEz6
	 RPNUivzrLa1PDKRzDwJLu6FKOync5cOh9c41m6+qWsEP2fmSXV+5oi1vd27KhuBcJj
	 st9g5SU1pI8rQ==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 Balbir Singh <balbirs@nvidia.com>, Josef Bacik <josef@toxicpanda.com>, 
 "Pratyush Yadav (Google)" <pratyush@kernel.org>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
In-Reply-To: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
References: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
Subject: Re: [PATCH v4 00/15] mm/shmem: various (urgent?) fixes
Message-Id: <179327123632.4954.5925006193124962193.b4-ty@b4>
Date: Thu, 29 Oct 2026 11:53:56 +0100
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

On Thu, 29 Oct 2026 11:43:21 +0100, David Hildenbrand (Arm) wrote:
> Thanks everyone for the fast review and tests!
> 
> I'm planning on picking these myself and routing them through mm-core.
> 
> This is a handful of fixes for shmem/tmpfs. I sneaked in a related
> hugetlb fix that stalled upstream.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[01/15] mm/mempolicy: charge shared policy nodes
        https://git.kernel.org/mm/core/c/9e3b76ba
[02/15] tmpfs: keep the quota soft limits of an unused id
        https://git.kernel.org/mm/core/c/85a7d29e
[03/15] tmpfs: preserve explicitly disabled quota limits
        https://git.kernel.org/mm/core/c/3283c3cd
[04/15] mm/shmem: honour F_SEAL_EXEC when an ACL is set
        https://git.kernel.org/mm/core/c/460346e9
[05/15] hugetlbfs: enforce F_SEAL_EXEC in setattr
        https://git.kernel.org/mm/core/c/73fe78f9
[06/15] mm/shmem: hold off eviction in shmem_writeout()
        https://git.kernel.org/mm/core/c/69634c49
[07/15] mm/shmem: stop retrying folios that cannot be split
        https://git.kernel.org/mm/core/c/52f47e06
[08/15] mm/shmem: preserve data in clean folios when splitting fails
        https://git.kernel.org/mm/core/c/06162197
[09/15] mm/shmem: discard whole new large folios on fallocate rollback
        https://git.kernel.org/mm/core/c/beba3c5a
[10/15] mm/shmem: rescan after nonuniform folio splitting
        https://git.kernel.org/mm/core/c/920600c0
[11/15] mm/shmem: fix truncate hang in large swap entry
        https://git.kernel.org/mm/core/c/29c3fae7
[12/15] mm/shmem: preserve allocation errors when swapping in large entries
        https://git.kernel.org/mm/core/c/f8bb4422
[13/15] mm/shmem: fix truncate loop after boundary swapin failure
        https://git.kernel.org/mm/core/c/9df76e1e
[14/15] mm/shmem: fix accounting of swapin-error markers
        https://git.kernel.org/mm/core/c/5dca4cd7
[15/15] mm/shmem: fix truncation of files containing only swapin-error markers
        https://git.kernel.org/mm/core/c/52c5619a

-- 
Cheers,

David

