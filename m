Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623833;
	b=Lh0YzyO89ZEGhG9r/pdnWIpJV9HVJdsn+bhHJXv14TKv/TPJm48Wxl3xzIFX08jZ39tD
	 pR5LLmrjun8IYsoalyHyFDlB5ZmDfqnwsPeSdLbVebdJmEY1rvGBA/jG8c7xtwGyWnk+C
	 19RtnVxoIfnYMr7VN3xMT/hoitKvDFJrIjh38onf4GJp6X31k5P5ZI9sCA23GRgmWbjhj
	 P3f5psSml4JgkrB0466LuJsUKOKVcBpOD5m9NWIM04waLCTIpRdY/dQyCZ58odhLmd1B2
	 0v0DMik21AmxTxvyJnpQtqYpb533glAlTwgU52scq/E5ACkEW7cw3XFzS8qml4J0QXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=97k+e4o91hVS9qTh0dt39z8aEg6Tzz29+YtF2wcbbgQ=;
	b=PSDF9DMIRGWDl8BXy+U4yRm4K0uhgnrezGM2F2StIt32texQYpIkvlytuOuGMQlS5u6o
	 FX8rrnv3sgCXQMojjAzswPQLCDSmHvm0TKtbIU9EFS0N+e9UvLaUC5cE8FaOB4ijdWqkS
	 03qj7P0N9yBIpuDf6/omzLOlQoNo1CC4AZeT7vw/7tBCoaJRMnVCExwjZ/Xz7pkDbXiau
	 g22zUsKV6CZUnzTj7JpMCuGH0bxqG2OVdZmcErMJypGVJui8VGZwvKly0ZspcBf9jpNzS
	 qPL0xaVo4UXvefkvN+74DhmOSeCPWWmvg52/AUqx0emJlyPKZ1ihlgJFzCzHYgRK1/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtILWUY5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892D60A263D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtILWUY5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E611F00A16;
	Mon,  2 Nov 2026 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623832;
	bh=97k+e4o91hVS9qTh0dt39z8aEg6Tzz29+YtF2wcbbgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AtILWUY5mIyFfXVHZZaMeNlTRaC2KwUhu0hD8VnlvyFSwdU2U5A/xQ0ALr3MsnQFM
	 8ZeQHoUza99Mhfc2+tOUwCI5VTf8eyaOzi0yPy/CXApVpW5D2zaG8gxReKXCiTJ+M4
	 K1yLSKzWKE9omc2nQg2mWJM5SI4tldOftcDqRp9JTu6gj0QePp+mMqc7+CS05twCXT
	 ez1OpyhpBTBgtCScS0autEhUeeUpxfyzbif/uD4HF03RLlPLf3QSxSln88hA+vpxlk
	 adNtmnDK1Y3CC0YMNFcVCijWH5MvSLSh05Rf5zzVuXStZ3oF08Qc3JKxwsfIK1+2IK
	 7PkEAA6TPwAmg==
Date: Mon, 2 Nov 2026 12:50:27 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/6] mm/mremap: report a failed split before moving
 anything
Message-ID: <auiGqsbwuRhIfhvj@gremlin>
References: <20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com>

On Fri, Oct 30, 2026 at 02:42:45PM +0000, Josef Bacik wrote:
> Hello,
>
> I went through the callers of __split_vma() to see who can't cope with
> it failing, and mremap() is the bad one.  If you move part of a VMA we

Yeah, what's frustrating there is that, AFAICT, the only really relevant
case is DAX.

But maybe hugetlb somehow raises its ugly head as you allude to.

> don't split it until the very end, when we unmap the old range.  By then
> the page tables have moved and there's nothing to go back to, so we fix
> up the accounting and return success with the old range still mapped.
>
> Lorenzo recently added a way to split ahead of the move for the mlock()
> + MREMAP_DONTUNMAP case.  This series uses that for every move that

MREMAP_DONTUNMAP is another real horror show for bugs. Candidate for
'should have never been merged'...

> unmaps its source, so a split that fails is reported before we've done
> anything.
>
> Doing that turned up a real bug in hugetlb.  We take the reservation map
> away from the whole old VMA before the part that's moving is split off,
> so the parts that stay never give their reservations back.  That fix is
> the first patch so it can go to stable by itself, and the second patch
> is a selftest for it.
>
> The next two fix the accounting for when the unmap at the end does fail,
> we either charged memory that was never accounted or lost track of the
> charge for the whole VMA.  That gets a lot harder to hit with the last
> patch but it's still possible.  There's also a test for an old size of
> 0, which nothing covered.

I feel like the charging logic needs to be reworked anyway. This whole
'drop VMA_ACCOUNT_BIT' hack is extremely stupid.

>
> I tested this with the mm selftests and with a loop that fails each
> allocation inside mremap() in turn and checks that we either moved or
> didn't.  The numbers for moving part of a mapping don't change.  Thanks,
>
> Josef

Anyway, thanks for these, will go through.

>
> ---
> Josef Bacik (6):
>       mm/mremap: fix hugetlb reservation leak on partial move
>       selftests/mm: test a partial mremap() of hugetlb memory
>       mm/mremap: reaccount on unmap failure only if accounted
>       mm/mremap: restore VM_ACCOUNT if the unmap fails
>       selftests/mm: test mremap() with an old size of 0
>       mm/mremap: split first so a failed split is reported
>
>  mm/mremap.c                                 | 55 +++++++++++++++++++++++------
>  tools/testing/selftests/mm/hugetlb-mremap.c | 52 +++++++++++++++++++++++++--
>  tools/testing/selftests/mm/mremap_test.c    | 52 ++++++++++++++++++++++++++-
>  3 files changed, 145 insertions(+), 14 deletions(-)
> ---
> base-commit: cd1d0b147afa81f80927f9711e53401703964217
> change-id: 20261030-b4-mremap-pre-split-13a3d54d6dbd
>

--
Cheers, Lorenzo
