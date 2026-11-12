Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510920;
	b=kFqIVSqf91ZFOrHv0Fq4sRmEZIL5VExrSBHVD9Z0bvEI9nLhO98AmICYSP8QzXy4ok7b
	 gp2LtxwQn1WnhEjRCVd/t3uI4fDiqBnWIRKn5um+72N+TfeN7K9WSxQ9WqI69gKMyvFkl
	 DhYdQQZUdTqaTt6k2S1Uz/ZvFIZqkdickAfYajOaWGvoX3qWV5ImIvQsc66UqW2RO2QsY
	 34ABmpmwx5R9FVLBLMjXVWemp+RwtXF3IbCOJZZilWXFOouo9lO34uhhofQEXTrnV7OHE
	 ToRpTorkhCNbYElHvpiBVtZTKvOaZLlSZR1kNzDHqvcxvjqzzyCe4MsIfby/9Hb8pnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510920;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uQqZHDN7sbU6LhPjRDha9kLuoQ88Z7yb10zf83LJBxI=;
	b=2ilQa7uYYW2QpNSg5nC/pYjcxEjj70M4nMwjHlRZ77cwitgiHA3dwRPmiZC9vZsL8+5Z
	 F+WeSVEfomCd98zoKG+7mGCG24vajeNbvTtFN1ohHay8HUPlBNGO3wPaOI9Xccy5joPv1
	 4RGIyp0oEuG74YR5epG9Qt1+5vEacYpkwIftsgNB96kVo5ZgbtDVTMrySpFQ7nIg+xRBl
	 7p/X83JvM1c18b2CalfQrBy4KOWnEl0S/r2zih3znQFrswaOPYgZRDgPkkerZ8N7oKBSo
	 oB1lja81AosNGYlqw9fLJ0UixWXaqsj8W2+vwLiZQPCDPuEoAF8k/NH3WirSa2PN12Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWmPDlF1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489A606A31C;
	Thu, 12 Nov 2026 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWmPDlF1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B7C1F000C4;
	Thu, 12 Nov 2026 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510919;
	bh=uQqZHDN7sbU6LhPjRDha9kLuoQ88Z7yb10zf83LJBxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gWmPDlF1val16ZjKXedNPnCxMzpzAng/zfovWxeBLCayEGTOGGXxVM6X+Ll7q97eg
	 cWVNr3znfkJuOln7L/5gSTA1SbO4ytS64tzUhmAFsXyS6DcbR66XqNdKczjDkGNKcV
	 LsJfrOMF+q1iPixZLl0yJ1oGedZkvah1XfhqyteTfwr5QdwGSGYoGdrsiTK/fg31og
	 6TWHhiHZ/Iv5HKOGDXpsqgIQQPVU+vS0KWntCndnK/xtEdHSdGVMARu9P8h7MLfW6B
	 UbKMvS0IUQykAIChWVCk3U2V7NP9+NERWtYKYQvaYUAmPJOBKSwc3aHEayKyv28ONs
	 mwbyYy33ozMew==
Date: Thu, 12 Nov 2026 19:15:07 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avYQAYzkmS9Z8mcZ@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <179450279073.482102.1691484916250559829.b4-reply@b4>
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
In-Reply-To: <179450279073.482102.1691484916250559829.b4-reply@b4>

On Thu, Nov 12, 2026 at 11:59:50AM -0500, Gregory Price (Meta) wrote:
> On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> > The OOM killer can quickly trigger again after having selected a
> > victim. That victim might not have freed its memory yet, but its mm will
> > be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> >
> > This can cause the OOM killer to kill an innocent process when the first
> > might have freed enough memory to relieve the memory pressure.
> >
> > Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> >
> > Note that the task which calls mmput() might not be the victim - if it
> > took a reference on the mm (e.g. ptrace), it may hold the last reference
> > and release it when it calls mmput().
> >
> > Therefore we cannot rely on current to tell whether the mm belongs to an
> > OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
> > unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
> > mark_oom_victim() sets on the victim's mm, and check that.
> >
> > Reported-by: Chris Mason <mason@kernel.org>
> > Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> I was able to reproduce/observe the unfreed batch and the second victim
> issue.  In the base series i could kill a second victim with the
> in-flight oom in about 26/512 attempts, and 0/512 attempts with this
> patch.

This sounds a little like an episode of Dexter but thanks :))

>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Appreciated!

--
Cheers, Lorenzo
