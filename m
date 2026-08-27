Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB34C9010
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856634; cv=none; b=qz91H+M5viWEsEJHWTNqxTqgqx6IocH22SVSM1IXbGGasr9gG+zhQTmkOPwsgBuDXh8CBWigMBRsmW5+WVbEGaUWzrNF+sEBGCn0G2tmopu82+ysnOEmQxpniyvysC6RuZXpaX4axIPowI5CvBR6F9JPbTcml2oK3SBRCrJ6HJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856634; c=relaxed/simple;
	bh=OX8MB7Faqz16FfyUs85JOvv54LKZYzIgi3xZY1Wp7OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omXDgRu5Na11ap1j4Qy3dnbdoOVHNl/DQisVJB2z5n/6qf2Xh05+Gg4Jup9qbjPkfD5yGaprYZnUTJ2M258lQVLo6FpwaflyAb5zjb0gcwDuXIRsMf9CqadC0083TiSrOlOEhbJH08BGnn4EgKhVvwMuThfWQxuCbHujf2uOqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jB3OwxfU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jB3OwxfU"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efef6533aaso2322726d6.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787856631; x=1788461431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msFJqjtLZA54o3SsVIL9LxyTHRQJCU32uWQJGDxK100=;
        b=jB3OwxfU14X7ihLcmmH+SWXvoNMJdVwHrgfy0VRto7RD4MHO9bh1WH54j3xJX5qFxB
         5l137tLKpyfuFKR8VGKCQe6gRVwuGk1oc1oS4HmSbgIi3Gc/lmX1O4tI7K1u3oIkobnK
         HHyzkAyfsOu1GuLSRyEob9OFkQ5h3SrRklQOFVfrfbdJ4irvlWDrze8TwXSeu9BMaPeM
         FCrN2ID+kZiJfHOg0m+gRqKt82c/znATo8H/MsBIxM5E5QXlmwOBq6Hudqz+2/IszqEB
         PG6+8ppAXqApKWzqxGi3IjzEUE3Cu+FzVeKd+HAaR1bkHfBa7DKNECT3iQLuPEE7Nby7
         lzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856631; x=1788461431;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msFJqjtLZA54o3SsVIL9LxyTHRQJCU32uWQJGDxK100=;
        b=I5VmfQQ73GIUs0Yh7MQB1jkfJGEF2N4xyN5GeczKplNm5wOCLhkcd+fWrvpGV37XXC
         xgWH0oUIls+D+KJZnqfHe18/Z3zIASwqDS6NiPIawMB5CIRLnbkQughgAacJawNSaxQP
         LmppBqZlhMFtrzx/Vob1JtxiY9DUErXJNtguUZzB4XAu+Di8uWfZCDK8AWe4cemFpUnA
         ICIIcS/tlAQOFXHc8YyMx5Hf+E6xBdE8jE7aJOEq568oebgjGM/wLa1CC2P75M2utRNR
         FttI6KYO4nyAEofLeLpsjcXtE1/7AhH3lwSOxENLCF14iNUqwzKNDUD/iBuMdTubmFkX
         pFyw==
X-Forwarded-Encrypted: i=1; AHgh+RogSY1OuuNqfIE0dTq1IuxI9Z5CAkX4ILapq6Q5secrJOCAkzwR2A9Vq1pH5hdqV3jm/Ti1kAc=@vger.kernel.org
X-Gm-Message-State: AFuF++mVCxfj5RO5PBBY6N9+9Kh4cykepRBrY8DnJl8Gdq2prGOQmnRZ
	AlAOZ9qSld5yKSDdSSGEybabkD6AUqpU9qZjVBFBzx+029A1/AL+wPMOvizQ4MTKw0A=
X-Gm-Gg: AR+sD11ZpzuxUrC+Q1PFuRk4BWJXsevv+nXKisWKc3POuqpVWGqs/rFQWOFUGkRxWjo
	LhEu6WWxiWkcCSiTJ2vVl5BN91pT1wZe2WZMZmKJT5JZAzlIgrRkKg2j5hjGT4NWRnlKwOZ2is4
	aoRbuSw/WAULOPVbmyysNbe/uqj+aizmwP0iCSco6C7ayVU7W8yyIerRpmotuqtWBfOJAOGKl8d
	KShY6j6GsQ3YP0fSmiMRNM25V/LfmK5U2+3cBXhF9+omAN0S94Hrk6jmYRr0FWPUJkDupxphn6q
	PGWLMBZhCfdhbSUGBtE8fZzJYLWpjzuY+0hzpx6bITFO49+wbpux0sHXhHp2P9m2yYTnzGBor20
	cN2n8sqhUeuHRvJp75VbV26DeB7sF59a1/p66ViwJdVZ+9QEq9gQJrWvaqfgMoK5Tkc1rkWjMJj
	Mvn5YehPpaGEBrvjEP2RsJCzP5oOl8wfiAjrdtC72HJm5WUQ2aiw4fBoPCAqbbPyDaTPhBzVtAA
	B1lPYZZ0MFYoMttzlmk5gvjUdWmnGexQGPG3qb0OoWO
X-Received: by 2002:a05:6214:5883:b0:90c:c6fd:e8fd with SMTP id 6a1803df08f44-90ce0c4348fmr19428846d6.2.1787856631396;
        Thu, 27 Aug 2026 11:50:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73e3261sm23067036d6.32.2026.08.27.11.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:50:30 -0700 (PDT)
Date: Thu, 27 Aug 2026 14:50:29 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, peterx@redhat.com, jgg@ziepe.ca, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/madvise: use vm_normal_folio_pmd() in
 cold/pageout PMD range
Message-ID: <apCGrJthAhZ_A1B6@gourry-fedora-PF4VCD3F>
References: <20260821144947.167382-1-gourry@gourry.net>
 <20260821144947.167382-3-gourry@gourry.net>
 <01865a13-2c18-464e-94eb-466613de7bb3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01865a13-2c18-464e-94eb-466613de7bb3@kernel.org>

On Thu, Aug 27, 2026 at 07:07:38PM +0200, David Hildenbrand (Arm) wrote:
> On 8/21/26 16:49, Gregory Price wrote:
> > 
> > Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
> > Cc: <stable@vger.kernel.org> # v6.19+
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> >  mm/madvise.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index ffd6a68320a8..ab362bc482a5 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -393,7 +393,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  			goto huge_unlock;
> >  		}
> >  
> > -		folio = pmd_folio(orig_pmd);
> > +		folio = vm_normal_folio_pmd(vma, addr, orig_pmd);
> > +		if (!folio)
> > +			goto huge_unlock;
> I think you can now drop the is_huge_zero_pmd() check, because
> !vm_normal_folio_pmd() includes the huge zero folio.
> 

I was err'ing on the side of not removing existing checks, but I can
take a look.  Trivilially - I think you are right.

~Gregory
