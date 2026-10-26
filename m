Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036378;
	b=uX0bK/lkS0IdOquGSiui2iI5Fr981rBpFTrTY0FYseyz8eJcl03QJerWF24ZonBpqX5Q
	 76gZC3i+6hw6VrrQp/w38Ozqzgr06HQlbX++rW4/S3gpNlDPb5dtzzZ1wpTKZmMPyOq6s
	 cUb7w5FN5MalwYCexCFFfD8kp/K+kKDm6EFpdnOxZpLWX8TmEmHLQ24picMVt08Q/cFJ5
	 ELJHCZTi+WSaWGYH4oja6P/mtT0yIoyRUJhgdW6RirPBY12xINPHCD3HYOqeg5iNhDBea
	 R6C92Z2MidYWxfiTfZ98WUMyOOP8RZyFGBMHgAcKOlzOFD049WEXBnljXt9/O9jAQAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036378;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OjwL+dOXl1G0XYM6+finyh9q+bDo7EQ0zXCdvP4sKUY=;
	b=yZzYNfIeWX1OKiyghmRqqntmTkZHAHvgxGhDyE71baMOLjBuFIhOCvSOpGzkipttLjKO
	 Km1Axsl8EWDivDTyjWPqmwfMEEVo639HITwLJWFy5r9olTFGYNaegT4GMDYNJfjy3uFqA
	 6NZYLLuz0L9oiLvznJuMEGqedNcORNEy8a7lu5TUEqWtkAzGVypEnJUaLnVaIlYuu0fGy
	 9abzLtvVVSNL59kG7Tu41T+l5AAtC+qjmWjrtQDhrQVnOIDmrBztNoAOI0j2dXjCJ39ZO
	 9sQUs9Ir7xVUicvon6FpWLMos0iPO5UnVoufKat2DgXJhThuKZ4Mf7/xord3nVptR4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=FrVDQJkA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PWsvFXSP;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5611606A321
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5611606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=FrVDQJkA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PWsvFXSP
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 09A0C13802EB
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:39:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 13:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793036376; x=
	1793043576; bh=OjwL+dOXl1G0XYM6+finyh9q+bDo7EQ0zXCdvP4sKUY=; b=F
	rVDQJkAnwkechcedtUGj+LlJKPVJxedWqltj8oi1vF61VyeKCt36pkyuCO99sxtk
	WZiGJ07h+f8//gF4HvxL4FWzL8Z6bvThxlk+lrnMDkNCUQZyXFj8d0Q3UdyTKt2l
	9iuMoTgmEnBwoxJmtJMsr6NwJ/CY0RV8i0i9rwBeUEET0NdcD1b6Az/Xa4IRiczx
	YHDkbydGvvTDHRvFuGm0EgYw//c2gwCHBbh3dRJRldyEP9ANvg82ix4frg+0lAYe
	E0K5CnlCz5p7z0/VFxmZbBptZAv65ZrTpS4H/6F3UKnHcQ6rTbmETipC29I+7n9K
	kuaI3j+2Xekb5rDOQ2+sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793036376; x=1793043576; bh=OjwL+dOXl1G0XYM6+finyh9q+bDo7EQ0zXC
	dvP4sKUY=; b=PWsvFXSPHwOA7U63+FmsIT5MJ91tmnaoVdIO3ZUPNtH1Ab98ug7
	6yRLTsnP0VZYP4arU+dkW54hbAXMiH/3avrcLaDlx8VQi5U5X2CaxWFFE6ql9IvH
	u2KWd57w4YJQ39WjdP1yEr5vXSFiCsczCwW72tOywJYnGGFP5IjHGlc3xUc2zIGJ
	IuqjRRsuGWnrWtDoBR4G47nB03Yg6FvGmMYfG/gPsCV/5yAoylo+T3aqJXwBsxPG
	NxVBXkZWY9JY7jTGuC2TYoiFaYmOvxqntUjmj0EzHbSV/SWY2wxpzX/NJVfP+PMs
	lF55pPKm/iQJGbRExFpKi+RoxKlLRrZTxZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793036376; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LDQ2R4gba7OdMUx8kYJK1v2KazX7QaFnrgf+2AGUxT8DilZ
	/kGP4NFpR/6/Ei/zNKIc1q1TkJHeQj6avIizZK9SC65URFFYd2prZrBYORaj9HG6
	caRdI76d62I9V2Wao1+fEXw+5D+FdEHnugiJ0eQBnvfqVRMOh+lfAzlyu4NYOtmC
	qBdex8AT/wNqpIpFvlCWj7j+wEoKcvhkpslTw04VtrDN5F6Q6RceIC5qD+4z/dhd
	MDQ2iQbSuGfu5DUJMqvAhK75JmBgo50MI4AWCEch2F/jk6asblmcs02J/mchpGcl
	fyTlSSw11+Tzfgwo4CkXtBvQSygO65yveuL6EGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6Ww9OTLtowtBqWiQULkq+ViRqleNawRqoZVwSFz61xs=:HK5PFLyxFNzFgXX9dEXISx5+CcuJoukdbYSiqq5cWfw=;
X-ME-Sender: <xms:VpDfakvPYGwmN_RcJhMM65tFUhC25CZ0upVwgyH3PxSnClQheEyqWQ>
    <xme:VpDfagngJAvfN0X7xcKjN6W8bBdHw39DCvlKQ9KHbLnrX4g-bjZ3ZUPEqIe3OEU2E
    Bf6sFD51XGQsFxCbFmazWK4kihPX--4aOQhJ_WnQGcKxP4saAk8cw>
X-ME-Received: <xmr:VpDfakyMxTAcw7YAFXhGLBb7cSk8qCGR1MZW7lU55Eq8QTsPAyQX5K4-lzs>
X-ME-Proxy-Cause: dmFkZTF6H3SEpQShDd/kr54hvdkdt3MDjTF28+OqAC/bxg6UM4iEJWWMlnnT27v9jePEmz
    vGMx8mJpChUjh8v1OiOAzIMSlkJxTEn6JkrbUpKe5ErfD84wXqDBMbWsH0xqlTzlt+hdpX
    HDMnRTKOD4gayTPO77h+/Ew/lA79lBP4gW3fvzv7nBS/pThjI7OlhteCj0KZuy/1hMJ6hl
    7wmBRBmCVaoZTUGA4TbSiu2cZAiVpR2sAcoEBREPHEr0+AEhMBFYMn8kihpTBwQKSYCN0e
    19KCYnBmkwGoKFl6OLcnuRebfdT7MuZ9XNsKec6UnbEsx7bfq/xEUZydvzTLi/RATFXjpR
    wg+k4o4CXPH2SHleMmZd+BJOxQjRUBedVDMhgIl4OfPGAJcx+beaQw6YEv7A+FqYkHm/ut
    zSnQBLlCtTdKLQafgvSYYz/RytMnVVsxTnFXIt2nl75Gv3qZpsXjjxUKpHBOrTZ3ZdkISo
    NDQKKsOTGpDz/LwIrqV5boxfnXtPK9RxGT6X8zV4kMwZ3tPcECJ7n2FNAQCeI3MmONSZNa
    zVwHbzNgIkWSjZgZz2TmJOap4iORe69JcFquTFfiuvDTwYx10HKrvTSr8EO0wMyplkS86w
    xvaW1X0JnKp3AcjJQzKKgJbBSrQco6NzrXRHjs/+lbO8Y53HXH+/w7g09DeA
X-ME-Proxy: <xmx:VpDfamwXPRg6kIALhDkqagVgg6yM9zrSZqcuQeKsPQDYoDoh9idcQA>
    <xmx:VpDfatB2V75JiLUBZeB-0A6yudE42QZQZm0BSVgir-yaurDCmJEAbQ>
    <xmx:VpDfahph8RNX-Vy4wt4o9RDAs4PQ-LNcicnx_uZWvyvHj56NtyDaZg>
    <xmx:VpDfarQEV2WjxZIMj2k32K03Eq43nNqa66hkd6edr_rcG7lSkx5J_g>
    <xmx:WJDfahffJM9mqtUXpu9sfOKyk63ISmf__apPCjOjkhdYXJi2hYZ9tLFA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:39:33 -0400 (EDT)
Date: Mon, 26 Oct 2026 17:39:32 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vladimir Davydov <vdavydov.dev@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Stevens <stevensd@chromium.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 12/16] mm/shmem: fix truncate hang in large swap entry
Message-ID: <at-Pen0rJcHRDnBv@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-12-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-12-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:45AM +0100, David Hildenbrand (Arm) wrote:
> Truncating a tmpfs file or memfd to a page-aligned size inside a large
> swap entry can loop indefinitely in shmem_undo_range(). The task holds
> the inode lock and cannot be killed.
> 
> A large swap entry represents a whole swapped-out folio. For example,
> truncate a file whose pages 0-7 share one swap entry to four pages:
> 
>     [ 0  1  2  3 | 4  5  6  7 ]
>          keep    |   discard
>                  ^
>             new EOF, start = 4
> 
> i_size has already been updated when boundary handling asks
> shmem_get_partial_folio() for page 4. Since it is swapped out, the helper
> calls shmem_get_folio() with SGP_READ. That rejects page 4 with -EINVAL
> because its starting offset equals i_size. Nothing is read back.
> 
> The final scan cannot free the entry without losing pages 0-3. It skips
> it, restarts from start = 4, and finds it again indefinitely. An unaligned
> truncate avoids this particular failure because the requested page starts
> below i_size. Folios already in the page-cache cannot trigger it as the
> direct lookup will return them beyond EOF.
> 
> Fix it by letting shmem_get_partial_folio() call shmem_swapin_folio()
> directly for swap entries. This bypasses the read path's i_size check,
> allowing the existing boundary handling to zero and split the folio. If
> swap-in returns a smaller folio, it also splits the swap entry so the final
> scan can free the entries beyond EOF. Retry the lookup if the entry
> changes during swap-in.
> 
> Handling swap-in allocation failures remains broken and is unchanged by
> this commit. Even when shmem_swapin_folio() correctly returns -ENOMEM
> instead of -EEXIST, shmem_get_partial_folio() returns NULL and
> shmem_undo_range() skips boundary handling. If the large swap entry
> remains intact, truncation can still loop in the final scan, while hole
> punching can return without zeroing the boundary.

Oof.

> This may read an entire large folio back from swap while holding
> i_rwsem, only to discard part of it. Avoiding that I/O would require
> splitting both the swap entry and any large folio still in the swap
> cache. That, however, is much bigger work.
> 
> Original fix generated by LLM and sent by Chris Mason in private.
> 
> Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

It is getting horrible situation somewhat better, so:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
