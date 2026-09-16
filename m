Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05B4D6C32
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575053; cv=none; b=t3c1n3v34svdmSZ4a1c+0H7ikYRySTfnBPiP21WE3KGk+wfZC5XuJb7KXv9SxNlgk/J5wRDBBvlb6nFmIvBdZK1CdpQ3U7Uh0BsCrca3L6BrAHyxiXR/dVcOyHPlDVJRlAY8Mqec/O4tp/WH8oypZAENKD6aai+pEAZphbqCnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575053; c=relaxed/simple;
	bh=rxwh6HRPyMOg2IENeHM2VavTtsrGnyH3kk4Zp4dIvF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owKmolYt/+PHJwI10KZqy1rliNtRDGWl9cIe0N1LfqXR78nO1u+wPlSqCWQeX2EBlVOpGlSzag69bd/1vsqkSYrBvFHjY4GNmFrq557eOjGt+PJR6aTOivwpnfpjSvsk75Za4x909xc7VG5WlaOVuwUyZKR5rruovyF4RcC3eCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TrFSMl5E; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TrFSMl5E"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-939f5f82829so202765885a.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789575050; x=1790179850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EzULl2Rsxwfe7EFb6MSMik7LenJTHelPDSDR0csqtEA=;
        b=TrFSMl5ESedbuJFx8Vm7RCbWOcge2/6wmdlIFn4lA6izxn4lVCOW9Elc0WcHDMCpzo
         E2bc4nOXlEqQKb0lzZy+KEWaEV+U1BsWeLHuCIVwON3nRFzEHfTJ9vKOgh1aE7in/0+8
         L2WEb1QNeqUWlZOTgjVx1zRzdHTC/IffAqWbWNvOnzZGko5+jUn8EGirVaaA5fRvh2yH
         LUkVXEr6DCAHaAsgh0X656f6s/3H17hcGmS3eJvn8mMlXrb71yUKjsn8hrsdMqYEbPEk
         8/gASMW7mfvwnTerlXElrUQrQlDV4D5hwwAKuJVSetp58kgXlClFZnR1X37yRQpb9Xz2
         0VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575050; x=1790179850;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzULl2Rsxwfe7EFb6MSMik7LenJTHelPDSDR0csqtEA=;
        b=sW96bPSCOlWfWpRmF4Z7sJ81ipFz2r9RmeSMJSa5VHY+0QVKuRzubmgH4tFvNl/SVD
         jkLg7MTOpD+1lVLH564+rMWKya9Mwfw3hp95EmP9j8bnz0GkQVy6a55z4STwBLn2UoNH
         EmnXwpkpeR67jWiQ1lC7p7ZDrWvAgDK3UKQSwkhSElMy3sGt3bW4VYWCMY+QRfB9N4WU
         xGzg7gym48hOalaA+s1iZw+NkrtvxsF/x6jJcUydY/jaqzh5ZCJyQU63P13aOpQhlTZj
         Bew4hy1Y5nfGUno7DlN9yqDrYc7cfNYhtqBK9UDPp8FLtQGuy6bFxgPMM/urD7z8fu3U
         tHMA==
X-Forwarded-Encrypted: i=1; AKwUvBwQ1l40wQh2pORF8IyfodCs+j0IKD0H0BkL/ck1L0skvAQ9ckHaQRaPC5XrlNT9x3ANq6H67Nc=@vger.kernel.org
X-Gm-Message-State: AFuF++nZLXRiG+LrFJI0lUI9ducmOvhEa5I/EVIeaG1L9XtUJvwBXPTz
	x8cvDZ1YLNSWB6DYhOcWT8Ir6Fdp8+3rp05dy67g9eDiDeLc0EkSHHgGZs2m8wBVuxs=
X-Gm-Gg: AYBFou0wNIpROTdjo32/K3cWmgbESAWIjRSNBkexhVeTpaJz1bZOuZCulSpkr/4ZTTS
	RuLWrBoM6Wu06bXCqgwMJgiNEuBmsmWYvYSzi3wZYiIIhqD+tcSTd+Ji7Ui6YXvLRa3NhX7ov54
	Zyi3AZzE4DOpgCaHop8VgzYibChS9S1UgLgIN+1wf7/mtVoayIGS5/ddfqtR3/cE2qESlHCSuaQ
	ul5bUHghpp7+YD72wgnJUG2UhdDGGuFInmNZ57+BgdJgwKx4WaU56VFgfp1rzCnroC+E3W7UiUc
	HRZEzCJfPH/VgpIwApWD+sgvcWgsUjlamvXrS54YywOT3fPlIqypWPr9z4DejnUjin/nktTODfC
	+qxXH5FArucwaMZjKePclLB6t3HteXpQPBGWOvGwexoPb9FxWAXsJi8BQxcBRO93cFwvAm56EXG
	Ryr9+bXnyVOIEk9YUeoKDCfIDfrzkTwsaDXjMZtvw1E/57PRh1BBmVi8nohjK3N+qX+VY3J1WkL
	d4+qG0g3TV1PnprP6zfVjMKru5VAnRxJORHAs5MfXy7MZ67Vg3bVEw=
X-Received: by 2002:a05:620a:1b83:b0:93a:1196:ce5 with SMTP id af79cd13be357-93bc63ec899mr23113285a.33.1789575049934;
        Wed, 16 Sep 2026 09:10:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b782562c0sm248094585a.32.2026.09.16.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:10:49 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:10:47 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, wangjiexun@tinylab.org, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqq6ey3DG9h5NIDZ@gourry-fedora-PF4VCD3F>
References: <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
 <aqqjW5dpyznijYLh@gremlin>
 <aqqk89oTigJ9LS2N@gourry-fedora-PF4VCD3F>
 <5437871c-d9ee-49d2-b24f-965c73c29c3e@kernel.org>
 <aqquDtEZL1ndymGN@gourry-fedora-PF4VCD3F>
 <46d923e6-5724-4df6-b0d5-8dda7c547f6e@kernel.org>
 <aqqyhkZqcXDUrzeb@gourry-fedora-PF4VCD3F>
 <4fadcda7-d96a-4cd9-9b0f-5d387b6f82af@kernel.org>
 <aqq23i9824-GWdhg@gourry-fedora-PF4VCD3F>
 <9b50a047-b5e6-45c3-aee6-551896b52eaa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b50a047-b5e6-45c3-aee6-551896b52eaa@kernel.org>

On Wed, Sep 16, 2026 at 05:42:43PM +0200, David Hildenbrand (Arm) wrote:
> On 9/16/26 17:37, Gregory Price wrote:
> > On Wed, Sep 16, 2026 at 05:24:43PM +0200, David Hildenbrand (Arm) wrote:
> >> On 9/16/26 17:19, Gregory Price wrote:
> >>>
> >>> You missed this part:
> >>>
> >>> "I'm trying to be careful about not causing a bigger maintenance burden"
> >>>
> >>> I wouldn't do that to you :]
> >>
> >> I just wanted to make it very clear that I don't need another schlopped gigantic
> >> patch series in my inbox that I'll mostly have to ignore because it's
> >> un-reviewable ;)
> >>
> > 
> > I would never :]
> > 
> > But *motions generally at madvise* if this isn't schlop i don't know
> > what is lol.
> 
> Just to be clear, I enjoy any cleanups in that area which are well written (and
> your track record shows that you do exceptional work ;) ).
> 
> I would also enjoy a properly stubbed page allocator as well as I envisioned ...
> as long as it's not something schlopped together and rushed out.
> 
> ... of course you would never work-slop me/us like that! :)
> 

It's fundamentally a bootstrapping problem.

Regardless of whether an LLM wrote the tests for page_alloc in its
current form - it's going to be schloppy, because the code itself was
never written to be testable in the first place.

That's the actual problem we're all dancing around.

~Gregory
