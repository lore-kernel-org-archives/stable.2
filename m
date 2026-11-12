Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486799;
	b=IMwtURSn0CgwmdPKtSaUH3RNvhOZmO70IPqhyhExNvFfjyS3tlbSsTMEKG5GsbXlQo9J
	 6xpdmkAZ8TyOGoJOb/9r1+5nqvadISCQWxAj0TutOGjnLbpq19tQi/WQqwSsgl43pu3v4
	 SoBto8pU+5k/4YDf+aNs2JBuYcNL3o5CFcZDkWDPQLCY5VjzZW0TdwsbZdztSCJ0D5siU
	 7OQkD80iyuOtztxkAbbH5ILqKsEESDQHrbYOhzTeww6ohN1b7U8yg4at2kLVnkn6CIvl4
	 8gpDsdCFbBOxl3n4tSdHAPgttZnEpbXSFXDlcefjOSeWESM0+SO1Gbw2HjnBhUJDNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486799;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DFTNJC77J9tgE0ZUnDgATKIY1weLjDkKxfUFz6j/nbA=;
	b=Wa3aFOohvDNiI1hhR/5tcq6RDToNsIUYFVgKV9enB3+ZtOGonq7r903/DwKCH9WQZKiZ
	 IXbUrFsTvcdTYa1aduIr8glXtTz5phZIoI8LoDEHKKvLMafxVM4wrb/XM2/+hNYOJhGP8
	 Jwm3XaU1hE7kHZ9ipRs8IxkGsaZ46mN7+ShgKRly1jzcAdtR6yUXNlJy10+bkiqGWv2nA
	 ibB1I+KcjafwO/Xsw1qPdGucZ7NYom5rGvkAmaHB7wH4ViWlVSS8XvfDegIWJpuIhpS4m
	 3GDQSktAEkZHFgQtyvARJUc4RwK1eUUSTZ8WqqD+6qxolWOxkm/zN6kJE1CicQ/aClQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcnyYf4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F587606A321;
	Thu, 12 Nov 2026 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcnyYf4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E91D1F00A05;
	Thu, 12 Nov 2026 12:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486799;
	bh=DFTNJC77J9tgE0ZUnDgATKIY1weLjDkKxfUFz6j/nbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IcnyYf4Lnmvno4HSaDYNqpLViApXQJxkxsTrmbBk1kxUnJoVojSJPuh7/q27zkDUe
	 tspkSE3MSu6vxUJRoLTa7pCfCX2QRUgHs88Isq+w5Jqo8J/IJrVwRqefO9H016yWWv
	 VF5EkeRCe5dSMxXZhQRCBXRjsdXQvhVu87d074n/znSQB/iUlkSFLToer3QfZnmI3m
	 RGjscswltykJ4albLnBEHIJYeq7/eYGI7b7TFKoRIxYgODlHTf8YewkEMXYtZWd+qe
	 5gAsaUol72u4NigCA9c5k8cUiVZOwLd5uZxmAsQvEBhkjfVry2KnkmuNxFHWRo4+8j
	 KxGaZYiCTX+dQ==
Date: Thu, 12 Nov 2026 12:33:07 +0000
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
Message-ID: <avWxV0AcMe_5bAdc@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWgulaWoKBfIFlo@pedro-suse.tail5790ac.ts.net>
 <avWtxdIHSJJ_uNwG@gremlin>
 <avWunRPQJQctsvYl@gremlin>
 <avWw2I3Or0z1OmqE@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <avWw2I3Or0z1OmqE@pedro-suse.tail5790ac.ts.net>

On Thu, Nov 12, 2026 at 12:28:50PM +0000, Pedro Falcato wrote:
> On Thu, Nov 12, 2026 at 12:18:46PM +0000, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Nov 12, 2026 at 12:17:21PM +0000, Lorenzo Stoakes (ARM) wrote:
> > > On Thu, Nov 12, 2026 at 11:21:38AM +0000, Pedro Falcato wrote:
> > > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > >
> > > Thanks!
> > >
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 7618e72766a5..4cb18b217048 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
> > > [ ... ]
> > > > > +	if (mm_is_oom_victim(mm))
> > > > > +		tlb_flush_mmu(&tlb);
> > > >
> > > > I see there's a different tlb_flush_mmu() call below (in the actual function).
> > > > Is tlb_flush_mmu() idempotent?
> > >
> > > No, tlb_flush_mmu() is cromulent.
>
> Naturally.
>
> >
> > (kidding, yes it's idempotent :P)
>
> Great! Thanks for the cromulent reply.

That's gracious of you to say. I'm glad it has embiggened the debate,
however serendipitously, and I can only hope it hasn't furthered the cause
of antidisestablishmentarianism.

--
Cheers, Lorenzo
