Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A463D5676
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491638; cv=none; b=L7Mi2adfBeE+HtnGESAZ24oeVZXWpVmGlo8o11P5MM4dUvlZcYB6+yDs8jasq06yg+RVulkJzt3CRqG3NrPu41cGZbFvKqBqUP2LZYs275zph4fSsTzD82filzOQxULcWwm4NxTUECXYm2XBYCyoWVAGIr7jUKhlfLavlqTJBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491638; c=relaxed/simple;
	bh=OnuZ+BwkSdhjDschQ2BAweRJ8IwvXb1/GKs0Z+4e8Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRSXpsYTenuV/UrdvVAxiEuWIkTJrazNYF2kIxkdGGTCLGWSHZF+zI9Vg0v8ag4XuqolyCWYP6/lF7Gax0OaJjzyOqu623Y14A2c522JsSMDPn73idqSUVB87yWWTIRbvSCc/ph5mbh0cMAXIbV8dC9gFRIhLtPJwI2bVdISTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N+fyTBRT; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N+fyTBRT"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91219376dd6so40324246d6.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789491634; x=1790096434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7OHDMKW8AHHfxeSwNE6rmRPVcZ+sv/FI4h4eXB3h1kY=;
        b=N+fyTBRTlef06DHwQJCFYFp/oKST9lEv8vmqOI7uo5/4gD9I0sN7RYWQl2iLtGs4/M
         WERDMiM/vDHGt91T6hLPnrtCLbfACc3hrjXG574xZiXr/F4na9auuTlFPUPk8BW0xRJp
         b+Gcd1lJR2bZrRlsoD2MhHgvJ1drCDdeOpaGyEhRM85sNDpu13MOEJRIaH6NanY2lytP
         9H3f2qh6fajavcnULKxkouYGSzNi2I2E+Dk36xIjveixsqt/DFVT00zclekFZ9OJSS3A
         cbZZhfdNtBUvGSTL5XWgw4qnn4Thii3WKb1GlZp1RBFLDhbh0+WK758/MWshJ2kR2q5G
         oJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491634; x=1790096434;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OHDMKW8AHHfxeSwNE6rmRPVcZ+sv/FI4h4eXB3h1kY=;
        b=lKer92G7mT8Sdi9PWH50EoRW601BzbR5VOTrBVEw9+lDedEKb5mBxEzPMaGSZ8I+Bp
         Dr8NrtTQsjvZeOpfOIBPJX5q+joG/BpilhnXpTVYNhULfTOYcVMWRpJR5NKGrDhscR1Z
         Ole42xlxMnjJRbxOokj/MM7QjCpk8H3qW6MfvWv/Wm4tXiB410gkgBdnb1haZu0euhwz
         Tei/2QdsEM46yqvKeDI9eMiaKG0QU81yoVTKMoCVLbxhsrjaTQw12iYgvdW3zHmsX9Nx
         Za6ylUtEO/CJlpQgFjRlC9F8zy/70D13MMg4ftg/3NR5vr0b74GGPYQRwJ+P8/BWHq3V
         WF2g==
X-Forwarded-Encrypted: i=1; AKwUvBymHNTTW/YnyXhBcuVnYSFsL/AC4VKU/RvObkURmvlHtZuTiB7ACko0QC/yUtBrAKvDd3X07aY=@vger.kernel.org
X-Gm-Message-State: AFuF++lcX6YxgFUbzBzQXf/+gHyAbPeBK3hckiyfFr/5NlcbzGddZph0
	vXSrthA7/Nzmfv5mF0cHABH5iCQzXbzdLrhpjL7rb1apos043XDYLqkj1FJ4o8J0Ffc=
X-Gm-Gg: AYBFou0iseBhSC13TAYve7kU/fuFj8rfLgMChStB1g3UFnexwYUPEtV8Ug2bfLmFi9R
	974QzIVnvBui0ixWAtNiaCFdXqv8jFEuop6awdbYQhDmwkwxdAXMfjwUA8bsiQ4jcCk6co5i31L
	LpCrux8MY8+E8e5Ch0vPqw7DYNyKUvgPdxHZZN/W7wOn02CxP9j+rk5JIMBdx5w30JyfIKtodyp
	4yM25QutpHsWAdwdg3mydyZ5xjHGge91kt9c92/yflKBd4GR0iEy8q1AspHLUJPP8YDYYT1YYE6
	e1jf4tnsWPK85GD15pgFgpEE8fyKDfSlOdePb+AgklulfMaOIZo8hhyDaIQSE2xJjoolcxuO5eD
	Yc+je3bT9V0NcKUnJYHn0cfQdwuj7Xrs7J2cdL5kq1m1xp2z1EgIYJWKLRL14Eyz4aVrd/Kg018
	4h63fESvmvzx2knPf6eWDZH+0lO9D/ONw7xRBIUcHh7c7OX/Xi9GJcB1siROLSNUKx5tQOOt58K
	qMVj4FwqB7jzoiw8nHQ1ROVL6FtbJYWcJjUPToW6kgfB4/dDLOkkoU=
X-Received: by 2002:a05:6214:2e47:b0:910:345a:f453 with SMTP id 6a1803df08f44-9122e65cc6dmr128613806d6.36.1789491633607;
        Tue, 15 Sep 2026 10:00:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123bed0aaesm2890416d6.41.2026.09.15.10.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:00:33 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:00:31 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqlzzwLOVT79Ti_7@gourry-fedora-PF4VCD3F>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqloB0zm3RjJ47m1@gremlin>

On Tue, Sep 15, 2026 at 04:55:47PM +0100, Lorenzo Stoakes (ARM) wrote:
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 574aa2bb7c7e..ba5a3d77241a 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -464,7 +464,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> 
> This function is truly some of the absolute worst code I've read in
> mm. Shocking.
>

relevant meme: https://i.imgur.com/W0N40BK.png

No argument here. This function in particular is really horrendous.

I think i'm now 4 or 5 stacks deep on the "Thanks for fixing a bug, but
while reviewing your fix sashiko found yet another CVE-worthy bug".

I'm convinced (like you below) madvise needs some attention.

> >  restart:
> >  	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> >  	if (!start_pte)
> > -		return 0;
> > +		goto out;
> >  	flush_tlb_batched_pending(mm);
> >  	lazy_mmu_mode_enable();
> >  	for (; addr < end; pte += nr, addr += nr * PAGE_SIZE) {
> > @@ -568,6 +568,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  			folio_deactivate(folio);
> >  	}
> >
> > +out:
> 
> Seems odd to put this here for a condition that explicitly guarantees
> !start_pte? It should be before the if (pageout) reclaim_pages(...);
> surely?
> 

I wanted to prevent any future use of the label from skipping the
start_pte check.  The function is so bad I was err'ing on the side
of being a bit defensive without making it worse.

I suppose reasonable to say the goto is worse.

> I honestly wonder whether, rather than adding yet another label/goto into this
> absolute bloody mess, whether we should just live with a bit of duplication and do:
> 
> 	if (!start_pte) {
> 		if (pageout)
> 			reclaim_pages(&folio_list);
> 		return 0;
> 	}
> 
> I actually think that'd be clearer at this point than throwing in some more
> indirection.
> 

I'll spin a v2.

> That's for the backport but somebody needs to rework this entire bloody
> function going forwards...

The longer I look at madvise, the more I think it is a wart on mm/
as-written.  A userland-driven page table walker that requires all
the special-casing of Yooj Pages, zone device, swap, soft leafs, a
bunch of tlb flushing 5-tabs deep...

Scary surface.

I've been trying to think about how we might make this more reasonable,
but generalizing the different walkers across mm is pretty hard.

~Gregory
