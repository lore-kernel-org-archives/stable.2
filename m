Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8509367B70;
	Tue,  1 Sep 2026 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247492; cv=none; b=F844vJid430c5mXzp7G1EH8nYSF8/eoQrRVivaqRPeYT6LYYpz9LGiUvKyCBwRKQFd4OCWSf4V+6jpB8e2/zVBs5b3cilMPSvNMd6gaUyQS7TT7kaVvmhRF9P+j9Xr+pJ5SmIrsjW0f36LjRZdxKBu5X38mgjueB8N4hJVRZhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247492; c=relaxed/simple;
	bh=95d0ztqekd1ljeTlBrkA6kBPhHpLPYjaeu6n97jTlms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUbUcs9MoFIi5sgH8CLcWSnra1YlYdCMzvargfSqDWOzYBBEtkVOfoEss3fAsO/bVjdrJV2fCVgkNN/A/g3JUNZmQkxMCRAmkS0Rqv2+Ez8kUJywruKUFZFqMxdIZJDD14zQCs4+prBQktnaDfieauh2bsxbQDp2QRNaNHOoE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoZyl5sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoZyl5sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA101F000E9;
	Tue,  1 Sep 2026 07:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247490;
	bh=bZ55NtX+y+GwV6o0a3sXWCeig+tLS7zsgudQjjHqc4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PoZyl5scAeD4Qcr6uFGOerL4F2ILiG7/lM+gYubEiPHofI+iG910voC75BDqjrvjF
	 44obI1xLEi5Hvc4TTI2lDlkIXDJhjvEN/Sah6qqBF1kYBv2vJiaiWj6B8OjJiSKu9R
	 OOM2MEkJZQBfT3w0NNe/gOgV7WdDYCd0z6VAXlPZ3U7PxyeDkSObVQqbVL7PSjFUrE
	 ktScc/FQiLPG3N/rFyTNe/cwPtUT4drlMN64JRHeWTBL9JfdsTNT71BVtrilV9Olxp
	 hlec2RggrX6RWs7A0kpNdhTPO2SXWI+LF6y70cTj6CyqNuZqAc4tPlkqxT8PhOq5z7
	 SB36d4AklERzw==
Date: Tue, 1 Sep 2026 08:24:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Steffen Dirkwinkel <lists@steffen.cc>, Pedro Falcato <pfalcato@suse.de>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/alternative: Exclude text poking against
 change_page_attr()
Message-ID: <apZ9aKI35SsApV7U@gremlin>
References: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
 <178821524520.3717435.12731475498671524229.tip-bot2@tip-bot2>
 <4201eac9-297b-4672-8e7f-62e99dd13eb8@kernel.org>
 <apZ8AXqJBeI2BztN@gremlin>
 <386cbf7e-1734-4b56-ab7c-711d4f8ca48e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386cbf7e-1734-4b56-ab7c-711d4f8ca48e@kernel.org>

On Tue, Sep 01, 2026 at 09:22:09AM +0200, Jiri Slaby wrote:
> On 01. 09. 26, 9:18, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Sep 01, 2026 at 08:16:28AM +0200, Jiri Slaby wrote:
> > > On 01. 09. 26, 0:27, tip-bot2 for Pedro Falcato wrote:
> > > > The following commit has been merged into the x86/urgent branch of tip:
> > > >
> > > > Commit-ID:     1c4d1c070d734b241728378c0f79950c23a10883
> > > > Gitweb:        https://git.kernel.org/tip/1c4d1c070d734b241728378c0f79950c23a10883
> > >
> > > Was it dropped in the meantime? Gitweb says:
> > > Object 1c4d1c070d734b241728378c0f79950c23a10883 is not reachable from any
> > > reference in this repository
> > >
> > > $ git rev-parse tip/x86/urgent
> > > 477cf5cd1f698053df7426b7b8d9339e85e00946
> > > $ git branch -r --contains 1c4d1c070d734b241728378c0f79950c23a10883
> > > $
> > >
> > > Despite I managed to download it at some point though:
> > > $ git show --oneline -s 1c4d1c070d734b241728378c0f79950c23a10883
> > > 1c4d1c070d73 x86/alternative: Exclude text poking against change_page_attr()
> > >
> > > What's going on with tip today?
> >
> > Yup, I can't see this commit _at all_ in x86/urgent. Something's very
> > broken here.
>
> FTR, I dug out the logs:
>  + 096edb090797...4a0e6473921a master     -> tip/master  (forced update)
>  + 096edb090797...4a0e6473921a tip/urgent -> tip/tip/urgent  (forced update)
>  + 34cd1c931a36...477cf5cd1f69 x86/urgent -> tip/x86/urgent  (forced update)
>
> The original x86/urgent's HEAD (34cd1c931a36) indeed contains the commit
> (1c4d1c070d7).

I mean 'forced updated' gives me hope at least that these patches can be rebased
back to sanity :)

>
> > > > Author:        Pedro Falcato <pfalcato@suse.de>
> > > > AuthorDate:    Thu, 13 Aug 2026 12:01:26 +03:00
> > > > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > > > CommitterDate: Mon, 31 Aug 2026 15:17:35 -07:00
> > > >
> > > > x86/alternative: Exclude text poking against change_page_attr()
> > > thanks,
> > > --
> > > js
> > > suse labs
> >
> > --
> > Cheers, Lorenzo
>
>
> --
> js
> suse labs

--
Cheers, Lorenzo
