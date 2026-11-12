Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485853;
	b=PuC45sRi5zFAi/J31b829Efjp2FnA92XquCw34wluBMnFmJMKgcTuluPY3BwW+UcwZd/
	 xQiFRZPaHdbL2pKMkc1aoj8ThR8eQuyFqVzraQ/asRq6ag/yAF/G8NKU+Tij91sqvIeyO
	 UnSLbl8BbMTz5c88E6YLDqayWdl4qgWuMtPPR6C+SpSVFIbIIk2qAJ3yBd+ai98U1NkL2
	 MkrzvsuphK9623XUgZ8RasAoNFBMHfjSGXFClMonmZEpXdnR1ucHZM7m1rs1iaG/LVQrJ
	 vm3wdpyIi97dBX1zGGWnfot1h5aUu2161XVeyHDAwsidlTaOq/7GExMrQ0/dkFuwy6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485853;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=egNOu/7Vf2X7W7uluAYTFo+WYTwOy0dGXa9yzgt6ZV4=;
	b=4QimI0uiCpfJTuyHA3mls1nHTRBxe3kZIWZrcHne0DW2Cw3EovBAuTZed3E4UbgmQyNA
	 Uq6c0DWOagZ61dsCGHAmi5uqmwLVNBOA3W4h1gzOVjMTUfGrEIzbk7UBmXW+Fe/Gq1wqF
	 UQt95JvzWf/3pfot1lL27s5KAo/M7Wqk3zQ0BtxHS16/Ti8hpqtHG7eDUqDg5TYj85i5V
	 /5DvpXZ55C5tITUTsOKQvY2ECtdITVHIzxItOj6riLADTUX/nLHE3PmJ1/1ulkA5nFrsx
	 1oev7IX7LSKY4JXyAGZFBRoY742qLSqlJTj++hq+h8J8OfwoCd7J3z414yyY9HldaBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYRNQDKY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065D606A31C;
	Thu, 12 Nov 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYRNQDKY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715601F00A05;
	Thu, 12 Nov 2026 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794485853;
	bh=egNOu/7Vf2X7W7uluAYTFo+WYTwOy0dGXa9yzgt6ZV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CYRNQDKYwSNE75OEpsjDv9dNjJDH/9wXWcwkCgRl1QqXE62f4uONxtXX5dc0wsQs0
	 WbCx16kboXxBlB/B0vsnb5k03ky8z3i9dC9u0iLcFuSE+DKSeVNQJbZ6jceq38gQM+
	 qClCIRgvLECQGDxobOp51GqtjVLU4bNoIhY+asA/hxdLcGHuJqvg4TnLEhAFmGvmTZ
	 wEtb2rgiHZDLfVRt2osxfliQTOGWmbK41tGCAp+eIHjHnaVIZiFkTdH6xWp5LQtArj
	 FZvbiFaDY52nL/ZO4W05TXfdFxXIfIlMagq48ev+KEKfMAxYYWNy2VJEFaZHE/O2Ki
	 zNMvaBxoDQWaw==
Date: Thu, 12 Nov 2026 12:17:21 +0000
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
Message-ID: <avWtxdIHSJJ_uNwG@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWgulaWoKBfIFlo@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <avWgulaWoKBfIFlo@pedro-suse.tail5790ac.ts.net>

On Thu, Nov 12, 2026 at 11:21:38AM +0000, Pedro Falcato wrote:
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 7618e72766a5..4cb18b217048 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
[ ... ]
> > +	if (mm_is_oom_victim(mm))
> > +		tlb_flush_mmu(&tlb);
>
> I see there's a different tlb_flush_mmu() call below (in the actual function).
> Is tlb_flush_mmu() idempotent?

No, tlb_flush_mmu() is cromulent.

--
Cheers, Lorenzo
