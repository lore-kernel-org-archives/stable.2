Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495F58F071
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070288; cv=none; b=Bop8Z1PD078GvdsnrG/Eg/ES1Zs82hYEW8ZiCwKRd8xbfDDjteVjxDoh8/9BLgH1G0Nnc6hnDwO0JSwNtN+dJ39JXQdXdNjKFAiLhQAs/i6FrS42u8bBe82nAWiBYN0S8KD8RPV8lWI1ACn6c5NckLYHxp6+ILsHHkjMsjEKJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070288; c=relaxed/simple;
	bh=MBFIA7ojoIb7ebHSTDzXkwW6fzfGgijhQ/LYfxVvct4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxuBaNHIchNbMSDcSYMxvzR02E7bAxIRR+BTePgD06YrrcFN8jeWBkYCN3THVvLi2BTrE9ffNnycLSU7lXascrNlTkxaQZk+8O1fCBx4pG40gdh1wK5LC1RXG+eQS8/MPbCxHLXKWxxs41H2t4EAjm/M6RkO0QBiaKbbX7HhAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlVP4RBD; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlVP4RBD"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f18c0e03e3so113677a34.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070283; x=1789675083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwZeLG/lY3dlk1m8H+DGflPWf4vG9wjk2ruxseRkZqU=;
        b=FlVP4RBDkE93HjNOWTvp6BSKFl4tIQiORPG6/h58Ow6YPswC19FVxYvLeRhIc85aWm
         N+xc+rop8/yFOVYF5Om+8DBTWpmTZ0SK+qJFSH1MQUyGtbXqlD0LubvVaWDftieKNOsK
         Q2WuI+n6gdNgEpq+F1OoDpL7JAeP1G80TCNEkew128vuIAJwyI5syypCt7f/pBmWJ2ai
         uAK0lIzVayvxJWrbpqsuvk88ZlQaCgjvb+rmhZq6+/Vn7Uy/Azx3HTUMCK/0oUf5F+Fa
         N4y2jxKtBzIWDhG2pp9OeR1GAkbx6Umao46TLJD0ugYvQEmLooP6I/zvr2dyNuEZREX+
         1WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070283; x=1789675083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwZeLG/lY3dlk1m8H+DGflPWf4vG9wjk2ruxseRkZqU=;
        b=EnAvVyzsE38sjXmF5qqo8LcdzzYUeR57hUFz0TlgKZYeqYFo3kmDpfWytfLW/6oCX4
         0U46A4V5NfRumsZBsBE1ckE2C7aFD70aQ1jhHrgh2aeRkqQIC5Iyiv0IUrCQ/f5mdZld
         z5RvyTuZswkf4nEp/cjdeXzQCwSe2XnUM7zdGR7Y/zfLrCf/C6bPXHN/NhMas5YjRIZD
         SMRQkAnfER3hJXsDP8W1qngOcYyu2Lw6sIfeJ/wRv4eAYXE+HAre7rToCtMtlidlhXrO
         U4mFX0WWYPKGneSONGwGgL1rRNrgYAqj6ByjBB3VdFOUxVsL4CaIO4vaC5Fuj9LSDyeX
         taKQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4kNIPsjk7Y00pv2Iweb2PLUJelc4nCiHhxQniWvu7o/OXF1UtGCtBhQhDxUQoG7Fjppll9TU=@vger.kernel.org
X-Gm-Message-State: AFuF++mqpp7Yo2E/8OcWMmTzY3KmXE1bpoyJeEDl9BvXmom6fbB3DHjh
	ZbFcwLQ1tOjjJUS6T3G0mtWRLaT667eCNggRH4YScMswIQWyBsNGBn9K
X-Gm-Gg: AYBFou1q1kltWIJ9jlTJrWKQgYldXfRGKvWGUbzy6uihViK4nCT+g7fYMCX+xQtJgSL
	h75v8ypYRquh8RJ1ewe1gFtfgKA9V9GurK1dYJv7UI3qFWxunPWkSmCuVIx54g2UI28FZAiUVni
	AeI92mcLp7441gkeCqMNF3w4JPDUfuR2P7clIZbUc+lmKDqrQcy7Hxncde+yAZXPoHWdBpmxhrK
	DMMSxVODL4vSIQ2LwEeV0A/gxUoiuURs8BH1kdnts8E2it2V8OBBlan+CaiBxI9y+b+S2GhtynA
	iQqHl6B7HRrNAjEDmbwIK8cjzU2R+3b/b+nNVdGtQlcH+LB1OC70ND1nwoSo8UuIYRi3c2WGcMv
	7zN8/A2/uybl5NASvJnAVyJ2S5er/aOK5COha4sAgvR/BvYEPXBOTZfyuVd4gN6Lmono7jHBV0p
	EuMPsV6Lh9/mhk+2ZWbHpQ2BGxAPPAH0dX3sHay7LsgTS/3Wef/09fFxunj/CN/UPv+8vQFsiEr
	uVkmUNq4gmudVMu8VL10keuMdv+gg==
X-Received: by 2002:a05:6830:3886:b0:7fa:5c68:d04c with SMTP id 46e09a7af769-80401bc5c1fmr251411a34.22.1789070283153;
        Thu, 10 Sep 2026 12:58:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f670db38sm485051a34.18.2026.09.10.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:58:02 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ackerleytng@google.com,
	Alex Shi <alexs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hongxiang Lou <louhongxiang@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	fvdl@google.com,
	jthoughton@google.com,
	rientjes@google.com,
	vannapurve@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: Re: [PATCH v2 3/4] mm: hugetlb: Fix subpool usage leak on allocation failure
Date: Thu, 10 Sep 2026 12:57:59 -0700
Message-ID: <20260910195800.3459455-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909155459.dbf9d67ae21a72935bb863d9@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*/
On Wed, 9 Sep 2026 15:54:59 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 09 Sep 2026 14:49:28 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:
> 
> > From: Ackerley Tng <ackerleytng@google.com>
> > 
> > When folio allocation fails early (e.g. buddy allocation failure or
> > cgroup charging failure) and a reservation was not used (meaning an
> > unreserved global page was needed), the subpool page acquired during the
> > allocation attempt must still be returned.
> > 
> > Currently, the subpool cleanup error path only returns the page to the
> > subpool if a reservation was used. If no reservation was used, it skips
> > releasing the page back to the subpool, permanently leaking the subpool's
> > used pages counter.
> > 
> > With subpools now always tracking used pages, always release the page
> > back to the subpool whenever a subpool page was acquired.
> > 
> > Opportunistically rename the local variables tracking global reservations
> > needed and global reservations returned. This clarifies the accounting:
> > a value of zero for needed global reservations indicates an existing
> > reservation satisfies the allocation, while a non-zero value indicates
> > new global pages are required.
> > 
> > Adjust global reservations using the difference between reservations
> > needed and reservations returned to properly handle races where concurrent
> > threads interact with the same subpool.
> 
> This one conflicts with "mm/hugetlb: fix max-only subpool accounting on
> alloc_hugetlb_folio failure". 
> https://lore.kernel.org/20260428113037.88766-2-enderaoelyther@gmail.com.
> 
> 
> > @@ -3074,13 +3074,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> >  	return folio;
> >  
> >  out_subpool_put:
> > -	/*
> > -	 * put page to subpool iff the quota of subpool's rsv_hpages is used
> > -	 * during hugepage_subpool_get_pages.
> > -	 */
> > -	if (map_chg && !gbl_chg) {
> > -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> > -		hugetlb_acct_memory(h, -gbl_reserve);
> > +	if (map_chg) {
> > +		long gbl_resv_put = hugepage_subpool_put_pages(spool, 1);
> > +
> > +		hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);
> >  	}
> >  
> >  out_end_reservation:
> 
> Here.
> 
> I presently have Zhao Li's patch staged in mm.git's
> mm-hotfixes-unstable branch, awaiting review.
> 
> What to do?

Hi Andrew, I hope you are having a good day!

Yeah, I also noticed this too [1]. There are actually 4 proposed
solutions for this in the mailing list which is a good indication that
something is wrong here : -) But unfortunately it seems like there was 
no resolution the last time I pointed this out : -(

I CC-ed all the authors previously on that chain but wasn't able to
get a response, maybe we'll give it another shot here?

Ackerley, Zhao, David, Song, hopefully we can align here.

Personally I'm partial to Ackerley's approach here since I think the
get/put semantics that he proposes is the easiest to understand for me.

It would be great if we could sort this out since I think it's been
a while since we've had all of these proposals in flight.

Thank you everyone!
Joshua

[1] https://lore.kernel.org/all/20260713144557.3845941-1-joshua.hahnjy@gmail.com/
