Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3871212566
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392484; cv=none; b=Lkt/EsqVz0CiyazwEwC3R39rwMxRI6zoSAlLKZz7TXJ9rr9Akbq/9TTWYjRxPjqNYZbP5KK9WrPt60IpwGV/fKYaPTEWJrLnz+pbIIvH7yR2LUlYD7Y4pAnEVjUhkDLYzwQHpVnJ107RpFIgjXe2Ye+ifuzjWm7X58yOZGN8aOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392484; c=relaxed/simple;
	bh=culk48HL8bXpu0r6FCRlrYUTQGpj6eC0Vq/pDDnEH6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV82J23REqeibC+7i11VaJr8aGJNI5jzpSVrh77r8Bwy+0iT9C798ak2MKhM69mBExTd7fb1pmj3wjIX/Dapnhe0w+9RTI5zzZxiw5cFnMp/sXU6RG/bGWjpeexzxBg3fkCDRU3AllQayaBnnx2VY/1LrNG8lsDAfCWXQLpvqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fiSxugUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fiSxugUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BDA1F000E9;
	Thu, 25 Jun 2026 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392483;
	bh=iVLD/Mi/f86fBSiMdLQaqOP4RSHQzTVoQRncNaHo6zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fiSxugUjpDcnQsMgCqPjVg8qmGiHIffyg6o4kKRwVGyFQgSws0eaPCqETjWS7psqn
	 QSivNBkx3+Wnr58aCpZ4OaiRBX0x3KqlIpGW2Ykk3sOwWVFf9Hh9taL04koGMbTZbx
	 ufUR9/V0G0YgXtu3uDkZBLvdC5b96qW99uzqnNAU=
Date: Thu, 25 Jun 2026 13:53:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062530-kinship-repackage-8875@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh>
 <2026062320-backtrack-unusable-96e1@gregkh>
 <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com>
 <2026062536-pleat-unpiloted-9a6c@gregkh>
 <CAG9krM-Ny2dL28umOotOGg8YtXkcReb11_QtyFMg8eJ=kNeiEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9krM-Ny2dL28umOotOGg8YtXkcReb11_QtyFMg8eJ=kNeiEg@mail.gmail.com>

On Thu, Jun 25, 2026 at 08:11:18PM +0800, Faicker Mo wrote:
> On Thu, Jun 25, 2026 at 3:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 25, 2026 at 11:42:31AM +0800, Faicker Mo wrote:
> > > On Tue, Jun 23, 2026 at 3:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> > > > > On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > > > > > Subject: net: net_failover: Fix the deadlock in slave register
> > > > > > Commit: b84c563
> > > > > > Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> > > > > > 26.04 (LTS) uses this kernel. Thanks.
> > > > > >
> > > > >
> > > > > Sure, but note that 7.0.y will go end-of-life in a matter of days :)
> > > > >
> > > > > Also applied to 6.18.y which will not go end-of-life.
> > > >
> > > > Nope, breaks the build :(
> > > Hi, I tested it with make defconfig(CONFIG_NET_FAILOVER=y), make
> > > vmlinux, no errors.
> > > Both 7.0.y and 6.18.y branches were tested.
> >
> > Here's what I get:
> >
> > $ make -j100
> >   DESCEND objtool
> >   CALL    scripts/checksyscalls.sh
> >   INSTALL libsubcmd_headers
> >   CC [M]  net/core/failover.o
> >   CC [M]  drivers/net/net_failover.o
> >   MODPOST Module.symvers
> > ERROR: modpost: "netif_open" [drivers/net/net_failover.ko] undefined!
> > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[1]: *** [/home/gregkh/linux/stable/linux-7.0.y/Makefile:2061: modpost] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> Got this.
> Need commit 3fdd33697c2b(net: export netif_open for self_test usage)

Ok, that worked better, thanks.

greg k-h
