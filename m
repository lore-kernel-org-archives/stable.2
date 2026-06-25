Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F11378D89
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372740; cv=none; b=CS7JU3N1ytzA1siRlnbzhTHPBez7dakD8nndEdghqwAAHkJBVmZR40wAAdNQumJOjxXQr2IKBISE0Tyz92w6eV7PD+R2pe3SuLaLy+YpnjsgP4yd8/nzjIyQDcpp4E49/w4rHSq143tJNoUa/4eYLyNmMClG3UUZE3taOO3zQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372740; c=relaxed/simple;
	bh=zevK5vF09d6T9kn9KhDm+RWkCiWy3KpFERzApn0czK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5VR/Qtajhtl8DzSb0d8CrWVl1j3Oe5RqZEUHako0p+Ml3GfF8wsouMLju8icwUcDat6DdS93Q2LnO3zV1UP5TzlPjYIDclvmBz8IXfHOprl1J16QrI2MgZsCQV2PKMa2/YDTwDQ8GX39+NgBq1eiNs8aq37eRRkxszFUHBensY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qw9xP0OM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qw9xP0OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4061F000E9;
	Thu, 25 Jun 2026 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782372739;
	bh=1tI5DV4QPJAYhk1GZLq5dEDXXnyejB+8Z3wWKxu2iKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qw9xP0OMU2Nk3/poNDhfRXCKoVkrLWZ+L1ttpZR8WR1WF6zo/nCb9jq1++108mnX4
	 ef+OHJXG//V4JfpC1zBGTnn76typTPjKq6Of2LO1y5v3P+49vXCZtH7BgbN3F6vxPe
	 CBC/a8tZbs5CrOLCsm/0DGYreylotf//bqRgMKH0=
Date: Thu, 25 Jun 2026 08:31:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062536-pleat-unpiloted-9a6c@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh>
 <2026062320-backtrack-unusable-96e1@gregkh>
 <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com>

On Thu, Jun 25, 2026 at 11:42:31AM +0800, Faicker Mo wrote:
> On Tue, Jun 23, 2026 at 3:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> > > On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > > > Subject: net: net_failover: Fix the deadlock in slave register
> > > > Commit: b84c563
> > > > Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> > > > 26.04 (LTS) uses this kernel. Thanks.
> > > >
> > >
> > > Sure, but note that 7.0.y will go end-of-life in a matter of days :)
> > >
> > > Also applied to 6.18.y which will not go end-of-life.
> >
> > Nope, breaks the build :(
> Hi, I tested it with make defconfig(CONFIG_NET_FAILOVER=y), make
> vmlinux, no errors.
> Both 7.0.y and 6.18.y branches were tested.

Here's what I get:

$ make -j100
  DESCEND objtool
  CALL    scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
  CC [M]  net/core/failover.o
  CC [M]  drivers/net/net_failover.o
  MODPOST Module.symvers
ERROR: modpost: "netif_open" [drivers/net/net_failover.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/home/gregkh/linux/stable/linux-7.0.y/Makefile:2061: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

