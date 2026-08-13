Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2130E83F;
	Thu, 13 Aug 2026 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612019; cv=none; b=sNhwMPJM+a+GVzK9sZcZeGUwGysoNM/QOm9whSvDZr1KIJOMRys7lrevcUIE5ZFBkVJBqhLvfdVl78fJrB0AOXcWHWw3LMaTy/mu2fm6Cm7ec2B8e8Ao54MfQFYiq5Yhh59iAIE9U4zy2tz+tkpMNeZ4X3pukPiAVKPNYvFg0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612019; c=relaxed/simple;
	bh=f74M4vY5M+2zO1em0yOqfoJZ60aIm02Bq2xp6Rph69k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgPGCgSdcoKuNB/kzwcYhm90I4xwF9azTUykIP0pcAYJeLSViW5Pi5jZsOjYbJRfAu37vceRS8s2UbdxoBrd7JbWtP8ps+fdBzpaiWG1aadHsuvW58WHpq+QRciXmD+ynyO3LhN2HXoCVPeELNGS+DRPT0tNPMqq/cA4N6VTnOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ1JRuGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ1JRuGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193941F000E9;
	Thu, 13 Aug 2026 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612017;
	bh=f74M4vY5M+2zO1em0yOqfoJZ60aIm02Bq2xp6Rph69k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UZ1JRuGvfKkMyoxXfQ8kKoa030GuhZsX9w/7MUDxcPmPecINNwx/WxJhR5cDxJzkR
	 /1kbAoVtalAYqD2He1nq9FJtU89y4q6aiGhMGrdErZEn+I5YdKz6w946Fk/qEMAF3B
	 pTFPf/qYgy5I9fVvRB4c94tWQvxMB8+H8TXUUSoACVtNykug+Ayb/EQJfqmqF8rDa+
	 6E124O0yDYZ5IJh5sxcj/mqoZAeIZ5HJU0oCQDcB1gcsAyNK5pFr0vrsddBkg9Io4c
	 Md9RPmDtObgg3yckY+CLkSo6ohVCFK11OmIThdsayNORgEQascflUh+lhwp4ehbVKn
	 K6cWSkGaPvKVw==
Date: Thu, 13 Aug 2026 10:06:34 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <an2I80eAb1hb1q1t@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <anCwUb9lV18v6mfN@kernel.org>
 <anXp--mLLEE2Qo0g@lucifer>
 <90c2be6e-fe03-4da9-88d2-fe4d4f745cf2@intel.com>
 <an2GkrW35R5reoeC@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2GkrW35R5reoeC@lucifer>

On Thu, Aug 13, 2026 at 09:57:33AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Aug 12, 2026 at 03:20:23PM -0700, Dave Hansen wrote:
> > On 8/7/26 07:34, Lorenzo Stoakes (ARM) wrote:
> > > In any case - Mike - I think you probably need to respin this on tip
> > > x86/mm anyway?
> > >
> > > Maybe worth doing that and seeing if that makes life a little easier for
> > > the x86 folks.
> >
> > Yes, please. If it interacts with things in there, a rebase would be
> > much appreciated.
>
> Thanks, Mike is already working on one I think he should get a rebased respin
> out shortly :)
>
> >
> > Also, please do send things separately if they are fixing active
> > regressions or bugs that folks are hitting in the real world. We'll send
> > those urgently and not through the normal tip/x86/mm process.
>
> By separately how do you mean, as individual patches? There are some ordering
> requirements here I think, is it OK as a series on that basis?

Why, speak of the devil :)

https://lore.kernel.org/all/20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org/

Let us know if you need anything us from us, happy to help!

--
Cheers, Lorenzo
