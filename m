Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485939;
	b=rgX11Kvr/7jyIucbwJ7NEyKxi32p4akjChXkYX8MhCiVppsMMH/uPKOEVi055oIL+5JB
	 8CLteS9gT7Onlk2ogT51KSRhE7019zsiwJ4JbFHGkfmoxVz/T/N7Mt0eLY4x2ytVWu9az
	 g0A2eX2yxNsyyF1EvCfBEICyFiw/6hssybuSHtb/cUpHdwc+Tn13/YHkP43Q/lSsXOASV
	 p8OOBBNUrKSpW+ysqNxGdwFzIbyDvQkepcUBxzV5zB0XhadjyMkyikdtM14fCmnf8K2ae
	 hc+JHljUXX/wVZqCZBzXBz6DAmdhQoWbIqMRzb435H2V5v/D8eLYywCVHM8/TyKZNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485939;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=25rHB//DTA19AkBG+LmGkOqVCqlrxZXLVv/KBpqslEE=;
	b=xmnB4W41JZ/KooR2s0VH3nzTEuQtJzbQ2jauUjts8pbkfoL1qoHBl69/JlhSiYZUUKqx
	 UUfvxQTHJ7VTrOwJl9ROHdL+e4IsKBCE8N9Ylsdq9PA1FE/APtcFnjIVOA7gcKtg9YsQK
	 /9jopezh61KxnFLpLxpbeNf4o3XKLEajfZcotr9ql9LQGtOK2p5I+RvV8NdOkhxILiTGN
	 BI27Swl2aewQbSOUonWa0lbkrnke75/y31mM3z5vp7gFl8tb2+nH5lMM2AzibL+pDTCN0
	 qlUxp/MwIR0Ve6plJotQTbfkskXRm/c5Ej38A4wqMyrnNm9eD/l5kW8tPk4q8w+mTIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnMask3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19201606A31C;
	Thu, 12 Nov 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnMask3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE031F00A05;
	Thu, 12 Nov 2026 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794485938;
	bh=25rHB//DTA19AkBG+LmGkOqVCqlrxZXLVv/KBpqslEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnMask3pUReTtazaSjEd7UX4twP0xj2/zq4bNCoLyQMvGzj6B7L8OdMDz8qfunJ3T
	 IRLcCUL5wUMDwEPlAhgUsaMf/nvYyfH3n+STUeu6alIyswNcgmJhZhomp/K+AvYehQ
	 ejIoK5dGvB5ofSymMCFArJMx540CVaU5pNHl7JpgnlZ/fQsTld34jALF6uQUQDdaao
	 7uNZCm1wGFPo+zCXGtsAsnlF8zHEJ21egX1PinGzPUjQSW/DPdndwamEoAolglQJQH
	 m8UamT18OR3euOYZmbaex1O4mocS+YMwYGUO585Aa3nNTzHF9EkoxQHu0tK9kFSDy4
	 qZNe8OSGdrOMg==
Date: Thu, 12 Nov 2026 12:18:46 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avWunRPQJQctsvYl@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWgulaWoKBfIFlo@pedro-suse.tail5790ac.ts.net>
 <avWtxdIHSJJ_uNwG@gremlin>
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
In-Reply-To: <avWtxdIHSJJ_uNwG@gremlin>

On Thu, Nov 12, 2026 at 12:17:21PM +0000, Lorenzo Stoakes (ARM) wrote:
> On Thu, Nov 12, 2026 at 11:21:38AM +0000, Pedro Falcato wrote:
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>
> Thanks!
>
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 7618e72766a5..4cb18b217048 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
> [ ... ]
> > > +	if (mm_is_oom_victim(mm))
> > > +		tlb_flush_mmu(&tlb);
> >
> > I see there's a different tlb_flush_mmu() call below (in the actual function).
> > Is tlb_flush_mmu() idempotent?
>
> No, tlb_flush_mmu() is cromulent.

(kidding, yes it's idempotent :P)

--
Cheers, Lorenzo
