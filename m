Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5ED4218AA
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683896; cv=pass; b=LCjlir22SCY7tvg0v0Rtz2/pcT86s6RC50uIhCj13Xx/OMJ+wOvItVhizKXXOSp7/YI0H3MJ9NwSqpCe3XRYqUK/+MiBFA87Ms8qOoj8BLHVkLGHWtQOXgKmMtSaJ4RMkPO4WgIDCwKjSfuAYQASS0DAtVT13jAiqKR1RVNKNC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683896; c=relaxed/simple;
	bh=OObufdYrSPslVqVKDe2Fi7Ap5Te31s9yw9R8FRUyzyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYrkPH/RSPKXqCcq2pQt3xdRKYpAfpNqF586Bz0pWENic//LqoMW2mz9rRao94mfNZEPVtUsBWGr0ZDSxBU/9tzhM6l2PzjlA7ImTbhehp6qS1ePaxTZ2GYZaoh/jLikmEine7/Dis+M6jA8sUuWRy5cR1Yyp4wJvXtjusBYysE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f55a3/uE; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f55a3/uE"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-446f87b6de1so301775fac.3
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 04:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783683873; cv=none;
        d=google.com; s=arc-20260327;
        b=U5xkJ26h3/ASMWOS018R7enLq6p3WkTeNBYVs7orvqmoAf3R6i7qwSuMAF/xrc/C2a
         zQzOVHl9CZd6fwyOZPr5mQIl53J3kn4QIiF8imGQQdY2GJKtnhgYpYhq9ymbczgW7MYg
         rkr9yycP5NDa7iymBb2TN1mcH0Cy0v8WB7zEmeLpbGLzGmhchuXchcQbBQlPso54AOAM
         mYexI5ocbs6/EvZ//IMdZ/KlLmEks1ws/u8/v1xdQ5WVNNDUpICm0ux1yobcj8EUtWm0
         fJcBKa8vpiyE5rTsPjuNaxOXkQsOP2RES49bGAQ1sngijufBMRKFXfCs7PBg1FNCLEux
         9NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1W19wWSuG0iYCLEvXWxpxOAlCnPTIm0FeKu7uLWgRBU=;
        fh=L+hK20vTmg1V+vMrcZNxGsgnb+ofkQZ821TulsOR11M=;
        b=tDatn2yFjeaZGUO6QOjADCnkE7hwd/ZdTkl/iULa5qLeUd6ngVqFyfVhKjOWvJ0Zpo
         qSmOPLXcyHXs2K+u2KT5acDzSdTYrFWhaVK6Horhx9aULq+GGPIsIyCGqOLKzsXGF/Lq
         lydGzS+VT5PuYJ6bCDjNv5Byv85E5Jxnos0Nlah1Nknywa1568U10MDMhOksCM5Md3e4
         CE7iy/45ivgXvNPb/XZ8JQM5LW0r7bEW8AVgvbJ+J9D1cvJzHLzTjJ58YC6avqlWmNwq
         E0ux0pN/1TdbzOWl/8/quhzP0SOwOFA7NbPql+WxCtbz7UbPsQvwVHrsli3u/y9P0zoB
         W4fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683873; x=1784288673; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1W19wWSuG0iYCLEvXWxpxOAlCnPTIm0FeKu7uLWgRBU=;
        b=f55a3/uEUFj8MRXyIYUEggpB06CXJoIHJOM8WC2OFwBaobJJ6+oC14/obv3UY47UWS
         3veq6Al3cWi1+IFXSoRenh/nqhCje8481uIELPPlphYYV0J4QbAHnl7nw/6KKWTU6868
         04qVdsYoq5lp8uOUSleJljBl8Cy74DfM+9IefsuU3isZYX75ntTqHVfrxK50UlBgGGkp
         PHgfGm156lkQMfrfTyJuEYjFZxAA/3gvyHvmlCtmxhoBxqoCwdddC46ECw3xEh757qyM
         voYB1C/w9NPGVYorISIc7SydClVpWVjJksTe2fw+7rGkXIT2h9ZVJ8X9BZ+jTWo1CQ5Q
         f77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683873; x=1784288673;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1W19wWSuG0iYCLEvXWxpxOAlCnPTIm0FeKu7uLWgRBU=;
        b=Ti2cnE4hdRuaClbtgcEB9woSGrEZB/lUaGL6MEweMZ0p905x9b/yrtU0p9F+w7pVlQ
         +tlZen0Jsz7oKWNRtZAa6SSX77V2O5m52+esbepy88jTXHEbfmm+KSopksD+PP0cTYYE
         AG2vC8kn47QvbGkvSC2+AmpL6OSej90867FVnKnb40sO6vg7MEk5UfGLGgaq2tLTyBB4
         v+8VB+KeRUmfBbrqmJLxMpgOcrTdQNzADuudKlqA20r+Dn4xyMQMQdhTTu1IMbClgkSf
         ezTMEYJTQRujPk0PcAEPvxCT+EHyKzSfvc/3CejUY7bloA2X16W9cX6pmMhwsvCe/xO4
         wAiw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6pTHTuWX+io6AN/EasauqG37/tiK9IJTHBTQDInZfu2VysUCgOU2SZCpgtMSYd1ZPMske7Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWAXCp4G3Sr73ZBmuGJoKl7hTNNdwlafTNr5QJFDpR4vsy1YfL
	07EMHHvpS+3A3A6sISSx6GOhFHDb1ZscNEXhBHd1yblNJwGTU8LkXek4C2Nxlibw1rOXTH8K+8h
	a/WuHF/zZF/ifVulC95IQ1uamVGP2yUw=
X-Gm-Gg: AfdE7cl2U16TzN8b9Jgf+w50wPiQes/alo8TMHMJj8nrFH402e03qRwHQZPR0CxLjCw
	nDol4l3mVH5S8MuJahPxnj/bMZbVFVTJeQYA44QSIs08ICoGsLr5bUg0hCxOesd7Mg/dCsHZM2A
	R3N+C6pRajn1YMkUzn1VKPfGIk//3e5hFmzQzgDcrvZJiu5I/QkU2bgimCXdRj8AEz+DSABBjvO
	jMffdnllCyC+oSDYRTQtnLoLwhD254dAiNh6AmXEghQxzDWZF7m+p58WOLKF1AaDX3F5j2u9teP
	/wiPBk0GrozMJVIZDcEoP9mQoEE=
X-Received: by 2002:a05:6870:524b:b0:448:71f4:a28 with SMTP id
 586e51a60fabf-4516373d9d4mr7087933fac.2.1783683872003; Fri, 10 Jul 2026
 04:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
In-Reply-To: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 10 Jul 2026 12:44:20 +0100
X-Gm-Features: AUfX_myjz4e4hoeh8KGxFCShwyc8M_PHWmZnYqgvQliJ8DmTRF2ndSu2LOcWe1M
Message-ID: <CA+XhMqwpDGYSQvDKrFz9XuQFiaz8_rgW0LupEzFhehSrFvUZaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Toshi Kani <toshi.kani@hpe.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Fri, 10 Jul 2026 at 11:50, Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> Kernel page table walkers fall into two broad categories - those ranges
> where no exclusion is required via walk_kernel_page_table_range_lockless()
> and those where exclusion is required via walk_kernel_page_table_range()
> or walk_page_range_debug().
>
> The former category is used only by arm64 arch code operating on ranges it
> both wholly owns and does not concurrently write.
>
> The latter category consists of kernel page table walkers operating on
> ranges that are wholly owned (but which need exclusion against concurrent
> writers).
>
> The lock used for exclusion is the mmap lock, and for kernel ranges this
> the mmap lock on init_mm.
>
> ptdump is a special case being both the only user of
> walk_page_range_debug(), and the only case in which it walks ranges it does
> not own.
>
> This presents a problem, as page tables may be freed under ptdump. And
> indeed there is a use-after-free bug in the kernel as a result, which this
> series addresses.
>
> vmap promotes page tables to huge leaf entries where possible, freeing the
> lower leaf page table when it does. It does this with no meaningful locks
> held against concurrent ptdump walks.
>
> As a result, use-after-free can currently occur. This series addresses the
> issue by having the vmap huge promotion logic acquire the mmap read lock
> while both setting the huge page table entry and freeing the prior leaf
> page table.
>
> The ptdump code already acquires the mmap write lock, so by doing so we
> ensure that the ptdump walker only ever observes either the huge page table
> entry or the existing page table entry, and nothing is freed underneath it.
>
> A mitigation for this issue was already applied for arm64 in commit
> a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), which this series

seems it should be fa93b45fd397.

Cheers.
> has to deal with carefully.
>
> This mitigation resolves the issue by acquiring the mmap read lock on
> init_mm on vmap page table free if a ptdump is in progress.
>
> However the fix in this series would cause a deadlock if we were to simply
> apply it for arm64 without also reverting the change.
>
> This is because vmap may acquire the read lock before ptdump attempts to
> acquire the write lock, which then gets queued, and rwsem starvation rules
> mean that the (unacknowledged) nested mmap read lock in the arm64 code
> would also block, meaning the original read lock is never released and thus
> deadlock.
>
> This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> lock in vmap logic, then partially reverting commit
> a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), keeping the
> enablement of huge vmap support, and removing the ifdeffery with the
> partial revert patch.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
> Lorenzo Stoakes (2):
>       mm/vmalloc: acquire init_mm read lock on huge vmap promotion
>       Revert "arm64: Enable vmalloc-huge with ptdump"
>
>  arch/arm64/include/asm/ptdump.h |  2 --
>  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
>  arch/arm64/mm/ptdump.c          | 11 ++---------
>  include/linux/mmap_lock.h       |  1 +
>  mm/pagewalk.c                   | 22 +++++++++++----------
>  mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
>  6 files changed, 51 insertions(+), 69 deletions(-)
> ---
> base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> change-id: 20260710-series-vmap-race-fix-2a4cac988938
>
> Cheers,
> --
> Lorenzo Stoakes <ljs@kernel.org>
>
