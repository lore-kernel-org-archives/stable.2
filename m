Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022475;
	b=BKuWQ91UJ+ETuhqih05Wp8P7cF0D51+UrD64CRJEXXpIy8K4JtVDprc22KD21QrHRm2H
	 SyLBp1PoMG/awQJwAv0J45hrfQapmlOdB8UYFK1IhBZqXgBVzZQJhxwB0e/oaCF+IOLrF
	 k3cso60iBYQ9wykO+HGNkD/UiGdeWVlGn1QXK9MbgclnyVyPXrUUoaxgjg+q7mofWvpc7
	 rw571adRBgNR9A6ZjCblMPyHamKZ01wCOPeoA8hTdE1ikBokF7SNRmqKf5bcZtvU2lEEm
	 kb7AM2q9W8FSyGgIY8XYGwlY+xd5/9IQsgd9YAvQhjHjORM3wq36JNC+TtspeJj9Y/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022475;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hesU+4ldnvOaAaxjWfy9d3z/Vr2tFTg+8pWVNqtk5cU=;
	b=x7FegXDdsDEe9nBAcgxwbewQJbnz1l6PTTQbS4qh0GuVe1XmEDr+OmUSvShRMoZZlqtl
	 hXVKk9qUO4mFGjCmU5II/TLzwsnQQl6Aj9zvq3qvCPLe97fy4jhz0XIcxQcxkRyqAfr3T
	 3x2Z2R7S6P36yACuIm/uwIqSdP5RP0ipxZt5uzGqPkwW8V92ncDmRCiEqPlbm+BzzjcLy
	 QJ9hchrKMtokNz3AGms/ZAKLRs3f9BQDiAHP2t1LIdbErMUwNqhv/gaaJA8E9IqHCKW59
	 NzoLabX0EUfZ+JSrJPdj+Ly5/Z0rq4KbgmLD4hcuKlhL5M0RTACHNifzq+4HL44JKoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEWUUcqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49D606A336;
	Wed, 18 Nov 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEWUUcqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719561F000C4;
	Wed, 18 Nov 2026 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022475;
	bh=hesU+4ldnvOaAaxjWfy9d3z/Vr2tFTg+8pWVNqtk5cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EEWUUcqa6leUkgcsEpfc2x29HRzw+OIdEg676QIVErDCbR3H3Ezwu5rlrejP0jH7X
	 lw5CugG/Qbkwi/sl1A86PLQvpSjvi3qJql1cqAUQM+6pZZncpY6crwzk5llTn7WyWt
	 o+KAI1Vgxt9x9SR0FeOA++Scoxwvce/u7eaULOIgwAQf+MrwWLrEoVvng6VziVq8wA
	 Mt4963yUj3GZGBy7po/Xd/pFd2gQ8a41eqmZeeb+BMGoMvSljEeJsVlm9aE0HR91pg
	 vZrYMozjVeF8Yt2c1vKQ7LB18IhCdxIo9XHL+QCmDNF6gdXh/hGfwi4BLpc2LG6d2W
	 lpqqKfEt3Ohkg==
Date: Wed, 18 Nov 2026 17:21:02 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
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
	stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 00/13] mm: batch of (urgentish?) fixes in oomk,
 cachestat, dev-migrate, percpu
Message-ID: <av3dRm-Gkx9kcYWj@gremlin>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <90a961f5-e488-46de-8872-0e1540eaad4c@kernel.org>
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
In-Reply-To: <90a961f5-e488-46de-8872-0e1540eaad4c@kernel.org>

On Wed, Nov 18, 2026 at 04:35:32PM +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 22:45, Lorenzo Stoakes (ARM) wrote:
> > A bunch of fixes for oomk, cachestat, device migration and the per-CPU
> > allocator.
> >
> > These patches were originally AI-generated, tamed into upstreamable state.
> >
> > Some are more reworked than others. Those which needed a significant
> > rethink are submitted as mine and marked as Reported-by the relevant
> > original author, others are smaller edits which are annotated as such in
> > the usual fashion.
> >
> > Please check for correctness, sanity, and whether the cc: stable is
> > warranted (I have not included it for 3 where it seemed unwarranted.)
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
>
> Lorenzo, I would pick up the migrate_device patches now.
>
> Which one should be fast-tracked upstream and which can wait for the next cycle?
>
> Use-after-free, shadow stack and out-of-bounds write ... look rather bad.

I think given Gregory was able to repro nearly all of them, I'd say most. They
are mostly small. So patches 4-9 I think should be.

Actually the shadow stack one (10) is unrepro'd and super borderine and requires
a broken driver and etc. etc. so I'd say that one is less important.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
