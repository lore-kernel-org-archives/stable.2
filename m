Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501F3B42D9;
	Sat, 11 Jul 2026 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765447; cv=none; b=j7Tp4q80bmOEebfZ3+qZd5i/2PysX9iCmTs1KDeBnKd0eDqgEp2OfVkmM5nAuSxTg/WqTVxHTYyBfYX++hu+yZzEIDlwWAl+kOK2eVOMhVoEvAt1pfRZgEaMoraxeGHSGNgTNBzjhjQd89NCCDQfzUK4cjkIpMK6XUT4Ar5FARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765447; c=relaxed/simple;
	bh=Q9Di/b4iJPVqt8blc9MpK5VXPQ9bMvymiQqeNa2PNPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrBJdwVb/N2n0C2QcudPIe8FL6j6gh/1Ha491sO7wMsTv+KyqDj45NXeQWg2CAq15nlSG4NCcahNYMrhtslbfypeGEbwq9ZH1ZOPAqVvSimhD/e49UQcHNUfWX4WQTtacPT4JZjFZRo8Vu9l7aFrVZr2/hhbKZ1PsrCxbW7Jcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFQ3gLCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFQ3gLCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4901F000E9;
	Sat, 11 Jul 2026 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783765444;
	bh=0oDfAhKxe2iIPvXBwZ8w8OqX8bhaAtUgCdeCLElZr0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AFQ3gLCG2F8EzmcbnFgC7gXQ7+rlVe/CyFvWTelU67y/+n/6aQbX1XOkmykw9tUPE
	 /P6+6BOidbH5gVI5CZO/bLXo4usru/OohXH8TOztGB9Udw8iDDo+Xllxib24tFY0ai
	 KphhFdvjtDOeXDxc5dCTXugSF0bSqxKlqRtyJn1svzNNlgc55jvSdlVUsVFTVlXTiT
	 uNdRAFdU9OOiUI5/b7/bNe7XjHBaQ/QR5BW6pvhYuYZWXWIPke/bHWwwzbzW8WS442
	 r8u5zEzFk3ZH/Chl213qDo0W4krI6Ew6mEcQuxNV+fma+WognwtqI8K7B7RyyHR9Vj
	 Dq8zG9EMFIhhw==
Date: Sat, 11 Jul 2026 13:23:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, David Carlier <devnexen@gmail.com>,
	Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
Message-ID: <alIZugA2b2gnPOrp@kernel.org>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>

On Fri, Jul 10, 2026 at 11:49:18AM +0100, Lorenzo Stoakes wrote:
> Currently there is a nasty race between ptdump and vmap when attempting to
> map a huge P4D, PMD or PUD entry.
>
> This patch resolves the issue by simply having
> vmap_try_huge_[p4d,pud,pmd]() hold the mmap read lock on init_mm while
> invoking [p4d,pud,pmd]_free_[pud,pmd,pte]_page() and
> [p4d,pud,pmd]_set_huge().
> 
> Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@google.com/T/
> Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gmail.com/
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mmap_lock.h |  1 +
>  mm/pagewalk.c             | 22 +++++++++++----------
>  mm/vmalloc.c              | 50 ++++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 54 insertions(+), 19 deletions(-)

-- 
Sincerely yours,
Mike.
