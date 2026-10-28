Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206481;
	b=T1v5Jk5J/wCMeAl0XH5iw0F7Qes9MyjAOrTPYQx1JOwbw5uneDn1qJ4Q7j6dmhkMOv/Z
	 wniHIYWwoiAjjhHTObPVhRESoAzy09p63D54R2uQCeiIW2D3ibZNKzPu6iheb0RHWkVCm
	 q0O90T1+BVgHJOVnWZFy+x4o70QE+WdMCu/VyeNkTDN9f0s3kg3ZOAw+7BFQaj5sD/IWI
	 R9dMwRm6jHbXQ0jsq7V0Y+HTyO7HBiVwJNW1d2BKWSBzL8eHon2LiJbPpOWmbJvyWng/j
	 CQu+zg0A+VZt7aO/jbcxrFkbdFbWGM0fBvu0e2GPBmFRA9d7HdO9JNk16tim17ZrPDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
	b=p+jV7LICdX+wYUtbObuW5WQL1Cxs6LvRuuPHUzEtMRshvLRYU1MWhF6YJEJdPFczlBp1
	 k8LfthpP0UbhvHN78DysNGbMozITZYgNl/ymHUHdK7ZVUwQIJHU2lxoWmbEcaHNIfzz20
	 le/HsvgVKg+nNP13Z5hBA9wk7S6mS7XVGFTnP+8lE1YQga0jk+G+YjLVvJHUZva8A26Ri
	 0kxRZw9zPXLsVBzKKVhJl/jWScj8eGem37SXV7i7UtuVPj+4HLKd/D1A2oOJ6MGOZcqhG
	 RaWzjfmOxbR1oP4cAySpvYF/4Ab4DkTYLDwYP7zlRUbJ6mKPX1yFbOk+bmvbhwd4tTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj4eYMqF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30689606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30689606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj4eYMqF
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4395d31228so187613966b.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793206480; cv=none;
        d=google.com; s=arc-20260327;
        b=gNzv11OJIIvvdT/ytYEpROP8tF5djc7uzyCr/kg932GLQROcMBqlxooEWE+7WgC5O1
         ALXia+/jQ9BkVHDuc6JBnIO3FEVud/HQbyB1AeUl2oBTMZRBHJ+KZD1e9X3vNhgVYmqp
         VLQEQUcVYKWzAH/UIlRvHO4u4dt+dMtzFreC63wSvdQCJ+0slaR4QtdXNymwy0CK/Fg+
         kvSr9Hmt3hwAANspYM3je1EgvPWoLTjYy2QgQt3xFiCGzx7Y+2PIRFb+YpqBTtRd/TJr
         lXdkXIIv0NeG+MZQ/GQi/UWwohLJdxvhhm34VOhSK4mbaa+ltExnJs5gj6uTImzrpsJn
         azEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        fh=FJGEkH54opTO8Pr2jr+uAhG13OzWCiDM7GKZqvBnp7w=;
        b=cvwaR3FZTaKQTnxtJ49MHgdNw3bsUjgM+A4I04aVdoVpjWAwfpvyYFfcbLyhbwKi/t
         cxJe+eUSMk2+qDVk1RMnBzha8hE8rsjtGgek84N2642knmuioQk5AGHYKflzoKudQtxx
         0TeTAu132q3wwlxpc90gw06G+scVQUI3Y0YYXjszrytohS160mavIek0sXSnQTDB5NOq
         dVw61xdck+x2+gX/DouzZLeqpLXgvgzmZmn10L6YBYitcVIRTgc6iJjm/Cc09T5SumR3
         bLH6stcJtAn7mHfCDG7sC+zKxT8iLkNALjpqC/gm73L2LMhPEBEUV4RTVFMAvW+gCl46
         FQdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206480; x=1793811280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=oj4eYMqFg7gHe9H2JcxnVX1xekmxsJ19PcyDmk/OMgjn5UXSCYYnXu7Ac1axMQ7SR9
         q4zcTyMTKwoBmlpjcyBns4x2YrJV/wZCM14e5QvikeiV0C+wKNF7KUibECOIrMdPWZb8
         TeeSnShwQLOPfWWedxcIMlWY8bdOdzbeIcmNlPYAeJPXpTRHI3uLnL51w/g/MSBgrYqU
         hM8NCxRBVHWjK69lGvL9PkV9slxoAJvbLHj55IQQFN7GfFG4bIrQO3qJDWc5uDOrVsDp
         Urwxbb1Ol2RkuzF1a7HS3sIe18QCl/MS8DkzaZbxu24cwwm8EY03lDrdPNjvlUvh/BZE
         LYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206480; x=1793811280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=Xp/MfH8syz3CFsDd4RAFyQSlUMaBZ5GtYritkLZk59C3E2gmO00+NjVJ0Ntiycbdb+
         NXoPX32EjaqaHEiVp4jFwZSmZv6ycHE6rBVbb+vEUmQp5zNM1UmOotk3K6sqMtIXMgWK
         bb5jp8je6PEufO8INYtzzSMS27wADj3bDRUGd8e0fDpADaJ6oW8dta1AFQ/gEVPq0RPS
         FN6Azg+ZMbDWbqX4K98csD1guWqab4XFlDQ77b1QCJKu6a+XF0n70WmZmUG8eQzruwXF
         NDFc2/FfnDOSMdsKYRFaa7rmv7NhFSBgdUt1Z/4Q3RUlIB8IEI3RDW5UJHQCQyMkPsXO
         Z4bQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUIlwtIBq4jJSzSmFebDiIQM/OwAxtlVDKb4wfjvnXrsrppEfGqjYtGbXQxLka+KjhJMfSLDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdg5i5uDA4iNtxREc1z/zQPyYG65ADIULeoP8hUm52oyEc+fvL
	XHo8FL/sGqu5QcyamLJMSLKRJ7qIYfV30ctpKKnirW3tdXxgJR8i1+ttjDXIZK3eydyKBCFi55C
	FSjHi3x+tYpSL7TT8dFF8zolSlO+SkQ0=
X-Gm-Gg: AYBFou2KO94H3PVoUufj1prHh/HgtAIVe1Tyu4NMHNPL/5fda7p/e3sqGgFiEpTnoPR
	9sBQRs+VxGRcK6kZBlW5MD6+zCGtrCb4fvwL/gJ9NEez6swKz3HJwDp3JbX3z1i4fyEBQ3CweEU
	daKl3D+Elvz1L20aDhSzP3exbNxSyxvFu6CNCrMSwKiDNcPYcVHbRtydnze6tzDd0Uxv/ew7gRG
	kn8VbtBpL3RJAlcex7TnXzU3ZMVQteKh9uBt9I6xZwtA0JSf2P9Dg27VgnAeOm8EIR6eiOhfjb4
	m1EmzK9zWkXmEd83y+ArGqevmPy8xf8yWRQFs0Fpxbi8WLBWAcWYW9OkBMpDYkZXtZ/Od/Iz+31
	tIy9JQnzspuJ8aqfT8DcdMhyynZXdLCOk3Fcseb02GyArckLBLJwog1qvapqRCdD7fRtBQw==
X-Received: by 2002:a17:906:f586:b0:c46:5973:2a1c with SMTP id
 a640c23a62f3a-c49be00bf7amr248310266b.37.1793206479455; Wed, 28 Oct 2026
 09:54:39 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org> <auBbKP8UNI9talDL@gremlin> <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
In-Reply-To: <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 29 Oct 2026 00:54:01 +0800
X-Gm-Features: AclHuK9Ir5cjQUbkmvsMXXN1XNQvMKyhNeup0qo5sC4qB6sDOiJzphX3Pz6BQcc
Message-ID: <CAMgjq7DzLFcznTqVaRneoN+qa9StPTvcBwHMdLM52ZbfZ-ffEQ@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 09:06, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote=
:
> >> From: Josef Bacik <josef@toxicpanda.com>
> >>
> >> MGLRU passes stack copies of page-table entries in walk_pud_range() an=
d
> >> walk_pmd_range() when walking to the next level. These copies can beco=
me
> >> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a P=
TE
> >> table concurrently.
> >>
> >> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> >> support page table walks"). Likely, earlier locking masked the latent
> >> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> >> retract_page_tables() without mmap or vma lock") allowed concurrent
> >> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg lock=
ing
> >> for MGLRU") dropped the walker's outer RCU protection.
> >>
> >> The fix is simple, so just fix the original commit so we don't have to
> >> speculate. To fix it, pass the actual PMD/PUD pointers. This restores =
the
> >> RCU-protected lookup and validation against the live PMD. Note that th=
e PUD
> >> handling is required as well to handle folded page tables correctly in=
 all
> >> cases.
> >>
> >> Fix generated by an LLM and sent by Josef Bacik in private.
> >>
> >> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> [ david: handle walk_pud_range() as well, clarify+simplify description=
,
> >>          adjust Fixes: ]
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >
> > God, terrible. And why does MGLRU feel it needs its own independent pag=
e
> > walking mechanism?...
>
> It's all a big mess. I think at LSF/MM there was some talk of using that =
also
> for traditional LRU, but I guess it might take a while ...

Right, there are reasons, MGLRU's page table walker uses a bloom
filter and have some zig-zag avoidance. It would be nice to fold that
into the generic walker eventually, but it=E2=80=99s not a high priority ri=
ght
now, but we=E2=80=99ll get there eventually. And using that for CLRU lacks
support for lazy promotion so I'm not very sure about that, but still
things are being unified bit by bit, so it will at least looks better
step by step. :)
