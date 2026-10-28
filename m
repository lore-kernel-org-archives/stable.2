Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221887;
	b=nm9Fguih4KmP2RJy23O8JJ5AdnkL7Syb83xPxASNFGF2ed5HyWIMMgKovElQgNnH8610
	 2uvG1Dybhx5F9td9U3hvwt1fiXjDm7c0QZPnnorJoYyVBOKmxa5W52z9pWLMz5MyWPAzr
	 +n770Xilte6gAFdzO3EBnFaxQ9jUsIQQCiIhkok1HLd5BQhCHjqPfNOB1w6jegVjzBOTK
	 8DfE5ceGdJCClUpdavwtBMR4s5/rk46+vMztHGuRdY8ihjjdolI61ZiP5JasQHgHMjXbK
	 q13jWHYPe+h7AuEXoW249V7Er5ciJJI1eCcYwP19JamUt4bfiH9KWV08MUq0PexjQmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221887;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2T2ryu8CYGBb/tgqfVT9uEsdD2RyXJuHuC2cnmKBcaE=;
	b=cA/PMustbvcd3CG/9L0ZbREnPciv76RDTkG/xS5jVxriHP9nJE7lRb7Tc/j14pIuLlDL
	 c/WtqgLi4XImvswxaFienYKainsr8Q+35IYLcxup95PpJOlMlTPcotrJiNRvNUCn2DZ8Q
	 pkmyYBIKJtC5IIETh+nS/6BZt/854N/ZlPUzSTKD/bcG4wBhJklBDMj1VQlxvXvD94+PF
	 trGPVM83vUXBEgSbkuyHRg7tmofzJzXt6ajmh+3xy1O0/tmzxtxaw8/2PVEnDGndQ+hy5
	 Ni3IDXhIXzNogsbsIpkkX5oAszIW8NcyLWl2VH+/6uao5LzefQyRMdppFzWVDV+l7Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kIvE1Av/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABC606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIvE1Av/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399D61F031F5
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793221887;
	bh=2T2ryu8CYGBb/tgqfVT9uEsdD2RyXJuHuC2cnmKBcaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kIvE1Av/NonADig4ues3OMWwzmxsWyNeBhYPhdsQL5Yc5BL1YXObcZTr1qaF3e5ga
	 dszFsqLr0ZRvrDM1FuSyNUyoV71ayuuKa3+vu2X5iasPuSZrzMyirfRIfuayvnhBF/
	 NMoE2sNALjgYz+YqfbqEiZ+gLdBOk35crImYyNQ9bkRu9KZhv7hFFtEOZyTUnWVYDh
	 37gsGkGUTMWclDWhNrbCjPF0V2u0TwpumujohEzJyZE+CpZMOVJRLnX4vMbsQ2Iz8g
	 gKWPFlP4nqLmSSFIvwhUyZ6/5awb5oYMOgvY5W14PBNquzH4csFPyZaMDQ3MnIgecS
	 rEIPPcuuD6+Tg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e55db58cfso123663285a.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:11:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzTat+8LFevVtBuAyaM345bctAeypWpthAIXEPodSCYe3/Ubr7ntjHp1yFcIyDuxNF505txa4o=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6DUtInv5eIC7Ph/b7J1RjDx7fnlJ7YL/wDG+qKrTyDfPEMnha
	gzjQ2J6eAHTJCBqCGJqwBTqZS/lYWhpG9CfrjRfisjeId6+hdZjF3e9EfdNDD4/BzrtasLJFYff
	jLsBUzM8MdkAXmp08eEbU3tVna4BbbtM=
X-Received: by 2002:a05:620a:2a12:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-94408cb191dmr541635185a.45.1793221886373; Wed, 28 Oct 2026
 14:11:26 -0700 (PDT)
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
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org> <auB-3BQn_rR6IfY8@pedro-suse.tail5790ac.ts.net>
 <22b819a2-631d-468e-b724-770caf9f94e4@kernel.org> <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
 <auHve-G8bboW77IZ@pedro-suse.tail5790ac.ts.net>
In-Reply-To: <auHve-G8bboW77IZ@pedro-suse.tail5790ac.ts.net>
From: Barry Song <baohua@kernel.org>
Date: Thu, 29 Oct 2026 05:11:13 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xD_EU9sBZmJRb3ET3zfxnOnXJvZB1p_3pTLV=Y4xHPMw@mail.gmail.com>
X-Gm-Features: AclHuK-GiN_SNdh0TbEQNxyVeAnkfKV91o-Gzvz83ZLTf2wxKLZGDZHJQeX3iwc
Message-ID: <CAGsJ_4xD_EU9sBZmJRb3ET3zfxnOnXJvZB1p_3pTLV=Y4xHPMw@mail.gmail.com>
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
To: Pedro Falcato <pfalcato@suse.de>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
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
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 8:55=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Wed, Oct 28, 2026 at 03:48:09AM +0800, Barry Song wrote:
> > On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> > >
> > > On 10/27/26 11:38, Pedro Falcato wrote:
> > > > On Tue, Oct 27, 2026 at 12:17:22AM +0100, David Hildenbrand (Arm) w=
rote:
> > > >> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> > > >> mmap_lock. A concurrent brk() can leave the child with a stale mm-=
>brk
> > > >> and newer heap mappings, causing later brk() requests to fail.
> > > >>
> > > >> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can s=
imilarly
> > > >> cause inconsistencies.
> > > >>
> > > >> As a simple and robust fix, grab the parent's mmap_lock earlier. T=
his
> > > >> way we don't need to update individual mm fields in dup_mmap() and
> > > >> keep missing ones. Stop updating the 4 existing members (total_vm,=
 data_vm,
> > > >> exec_vm, stack_vm), as that is now no longer required.
> > > >>
> > > >> Keep releasing the parent's mmap_lock in dup_mmap(), before
> > > >> userfaultfd completion, to avoid moving the userfaultfd handling i=
nto the
> > > >> caller. This should get cleaned up later.
> > > >>
> > > >> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> > > >>
> > > >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > >> Cc: stable@vger.kernel.org
> > > >> Reported-by: Josef Bacik <josef@toxicpanda.com>
> > > >> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > > >
> > > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > > >
> > > > FWIW, strictly speaking malloc() isn't usable in a forked
> > > > (multi-threaded) child, but glibc/musl provide this in a best-effor=
t way.
> > >
> > > Yeah, I'm more concerned about other things that can race ... :)
> >
> > Regarding the race with memcpy(mm, oldmm, sizeof(*mm)), we
> > still have one [1] even after this patch.
> >
> > That is, copying mm_struct can happen concurrently with
> > lru_gen_del_mm(). However, this race doesn't seem harmful.
> > I might be missing something here though.
>
> I don't think it's harmful as well. mm_init() reinitializes those fields.
>
> Though I hate that memcpy. I think that ideally we copy by member and
> data_race() benign races, like what is done in vm_area_init_from().

Yes. I was suggesting something like using data_race() to
silence the warning[1], but applying it to memcpy() also
seems a bit too drastic.

Another option is to copy members one by one, skipping those
that don't need to be copied. However, that would make the
code quite lengthy, and the copying might also be slower?

>
> Anyway, KCSAN reports aren't the most serious thing in the world, so this=
 can
> (should?) be cleaned up later.

Yep, I don't think there are any blockers for this patch. I had
actually given my Reviewed-by tag before raising this race.

David discussed races between memcpy() of mm_struct
and other operations. I recalled another related case, so I
posted it here. Hopefully, I'm not just making noise.

[1] https://lore.kernel.org/linux-mm/CAGsJ_4xnM66UZ-n55AHW4UHn+PSCP7G-gGUHU=
fSt6MRZGeRnfw@mail.gmail.com/

Best Regards
Barry
