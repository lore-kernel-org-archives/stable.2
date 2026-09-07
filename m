Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCF468C0D;
	Mon,  7 Sep 2026 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798623; cv=none; b=bIRsAGYtzFuuWqr3td1Qai+6LYV9CmszEwbl/BIZK3qQvaX+hA+EFwyARmWE0txyBUZIHZghCotG/f9axrf31s+IY4U/eE+LTPfHapy8A3MYVPD2hV66MFPiEzw9WKQ3iGxi1RdmXsWFq4XAAR2+uBgLInxJuu4ihXoXHfMof50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798623; c=relaxed/simple;
	bh=TYQA4jeD0DIJnAW0P78qjwDpNlErq0X6ckTCGSBrwCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fq8vSrhwMU6B4GXoS1t6AfO50Oknpch0l6A08cFCwmbEullBuAReAcPwm+yistwMjLOE/mdHnRUicxkGChlaZosO9p+DdQW8TKga41PeiCUFM9pCdHPcuGbG6ykx6laGI8Vhj8HZWwFbvE4TpgD9uv8M9Jd4je0R2E3Hpakz9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI62XHM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI62XHM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF721F00A3A;
	Mon,  7 Sep 2026 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788798621;
	bh=TYQA4jeD0DIJnAW0P78qjwDpNlErq0X6ckTCGSBrwCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KI62XHM/GgSlqq9owo7p9GRljeRJwENVHuSPu6fS8Kl04az1Sb242UsyNOKb+j4yN
	 ZZi0zcm8jQiNsGTjz2F6fRaAzU+TKsNUNm+PzC62GE/aHpaq6UwPqGqxc2Y6lfWGzw
	 8fOAhd9L3XYcD7ps5jP2GxzgfafQb5GNI1pLYcEFGNwa4yOuT4q41/5/NIV6bAf9Fa
	 dzsMQwOxbasMZ1trntTM+bbjwTqRFjeDxTzw85ts4FwCqtPSEh7RY7ypcCboomKVmw
	 Bm/hdu1W2T2NmbCIMF7QHMQsh208+sNp16Rr0HXynJ2r1S/ce+oZdiAjjQnk4wFxz/
	 hviFuc2R5p80w==
Date: Mon, 7 Sep 2026 17:30:14 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Cedric Le Goater <clg@redhat.com>, 
	Saravanan D <saravanand@crusoe.ai>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
Message-ID: <ap7mZ1Ktd_rRRrdX@gremlin>
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
 <DL08J4JGJ4UK.2G92WO0NK8XU3@nvidia.com>
 <apEzvfGgsvbc3vBI@gremlin>
 <dc52dd1d-f62d-4278-ab4d-95746383fd50@kernel.org>
 <ap7i1vLkfZj4rbNM@gremlin>
 <4743f22a-c24f-4f93-80f5-3260f29bd410@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4743f22a-c24f-4f93-80f5-3260f29bd410@kernel.org>

On Mon, Sep 07, 2026 at 06:19:30PM +0200, David Hildenbrand (Arm) wrote:
> On 9/7/26 18:15, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Sep 07, 2026 at 06:08:31PM +0200, David Hildenbrand (Arm) wrote:
> >>
> >>>
> >>> That's a good idea! Much better thanks.
> >>>
> >>>
> >>> Yeah, it's an annoying one as kinda want to say 'file-backed VMA' but I think
> >>> you're right vma_xxx_file() -> vma_file_xxx() is better.
> >>>
> >>> Andrew - could you fix that up in place?
> >>>
> >>> Obviously if there's further feedback I can respin as well.
> >>
> >> Just as a general note I really hate these in-place updates.
> >>
> >> For a reviewer perspective (like me stumbling over this) this is just a mess.
> >>
> >> Resending with b4 is as easy as it gets.
> >
> > Ack, you are right to be honest, and I do empathise obviously.
> >
> > I will respin these in future!
> >
> > Let me know if you want me to respin this to make life a bit easier?
>
> Sorry for being grumpy. With 1500 unread mails, playing Hensel and searching for
> breadcrumbs in my inbox is hard :D

Tsk, that's not grumpy, you're speaking to the king of grumpiness :P

>
> (I did see some reply from Zi to an mm-unstable patch, but not sure if that was
> applied in the end -- or whether Andrew fixed up any of that)
>
> I just saw my reply to my other mail, maybe a v2 would be best :)

Sure no problem will respin.

I will probably respin the RCU page table series too to wrap Kiryl's changes
into it just to make life easier there too!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
