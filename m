Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826528;
	b=tkMw3KEHDqgElXafRmMcMUvOXn3Ozcv43rdEz7RvhyzxJK/2NeyI1O6iY0KH2pg7vQ7H
	 cw6QuE+3o18HvykhSdjym1tyOdPfQR1KhzNV8rUTvXpVimSkclaigkrIyi7PjNcrzMNVe
	 mf5je0e6covxwEct8SQVT10/DxUYUPWXoN37MgRsV5Lb4N0a/oBVNjjnYDmuU5TUjqe5I
	 9AimgpxV4gYI+W6Lts1zZv2Ii/+sTyMOqXcHvkfejTNt66ncY7zqEx8ld+cLGJfmibgZn
	 INrWrLKqiwQD0mFdCZCRfIZ2FINjcuLCrlVY8vra8pYtvsppq2PO3ZpLWBvO7r9IpJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826528;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BKcngCVl81a+5cZXKQf9a6BxtCh+iivu3O1Qx8AltbQ=;
	b=suavSf8kZy1PJHLO/obKOFT7SQ7Y+OLRizVLFi8044uTmIhW0w4guUpi1Dzu/PkYvUng
	 c96EzuSXsMc89WhfeScCMIE9B8KrW4PCyQOKnUhb3F8s24P1sX8CPoQkDVgXhKOk4KhHW
	 fesp9jOAOYLsNHEcbemVJ6fFaHPjH+zsR1pvysxgayyIx0+cZTP61Dv9p7hHi02GQWlAk
	 wnMObybmUoSACWKHbIgxGFDq/XqhJwCzRh536pzaZfFwn7ZtSWGBL/HO54zbyEtwnlUcL
	 gu1X51aBs9o6t2c0HduMeSDW69YqqtU8dS6aICODtE35wN8aUxT55EJ3Yq6rDeWZXxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eW48fgDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B952606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eW48fgDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF391F000C4;
	Mon, 16 Nov 2026 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794826528;
	bh=BKcngCVl81a+5cZXKQf9a6BxtCh+iivu3O1Qx8AltbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eW48fgDzzDOs6ff2VSkCZ5ZhnZNSLmJIJ2FmLgLmmOPTuW82IsPqc4sa0+mxzgTr0
	 5Pf9kdVun4VQB5+6aTdEswDRgTOPz6Qr4ERQI27euYwpSUQi0EMtL8BMjr7LSW6hWP
	 auxR7UdLXc1bK73BZqqctXGk8JvraqYHl3823bnY=
Date: Mon, 16 Nov 2026 11:55:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Andrea Mattiazzo <amattiazzo@suse.de>,
	cve@kernel.org, stable@vger.kernel.org
Subject: Re: 098bcea71b8d security relevant
Message-ID: <2026111647-accent-penniless-9cb3@gregkh>
References: <c78fbc1b-b190-4111-a6a8-f456b5c85a51@suse.de>
 <2026111326-acre-backhand-a1d5@gregkh>
 <20261113202510.2107c905@mordecai>
 <2026111303-colonial-wrongly-7d9c@gregkh>
 <20261114062419.GBavf-kxerE_YDukB7@fat_crate.local>
 <20261116094133.4aa496f0@mordecai>
 <2026111606-uneaten-passport-9d89@gregkh>
 <20261116114902.561ada6f@mordecai>
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
In-Reply-To: <20261116114902.561ada6f@mordecai>

On Mon, Nov 16, 2026 at 11:49:02AM +0100, Petr Tesarik wrote:
> On Mon, 16 Nov 2026 10:54:47 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Nov 16, 2026 at 09:41:33AM +0100, Petr Tesarik wrote:
> > > On Fri, 13 Nov 2026 22:24:19 -0800
> > > Borislav Petkov <bp@alien8.de> wrote:
> > >   
> > > > On Fri, Nov 13, 2026 at 02:30:48PM -0500, Greg KH wrote:  
> > > > > System configurations do not seem to meet the cve.org definition of
> > > > > vulnerability, right?    
> > > > 
> > > > Yah, a system without any microcode loaded by the BIOS is not the common
> > > > situation but rather an exception.  
> > > 
> > > One of the systems used by SUSE Performance Team boots the kernel
> > > without applying any microcode patch first. We assumed that the
> > > microcode from early initrd was applied in that case, but it was
> > > applied only to BSP, leaving all other CPUs unpatched.
> > > 
> > > Thank you for explaining to me that failing to apply a security fix
> > > (i.e. failing to load the available microcode update) is not security
> > > relevant, because the admin should know better and update their BIOS
> > > instead.  
> > 
> > I'm not saying it is not security relevant, only that it does not match
> > the definition of what cve.org considers a vulnerability and so is
> > allowed to have a CVE id assigned to.  Many such security things like
> > this fall into this category, as you know.
> > 
> > > I still do not like the fact that the Linux kernel then lies about the
> > > vulnerability status under /sys/devices/system/cpu/vulnerabilities/,
> > > because those files are based solely on data from BSP;
> > > cpu_show_common() contains:
> > > 
> > > 	if (!boot_cpu_has_bug(bug))
> > > 		return sysfs_emit(buf, "Not affected\n");
> > > 
> > > This gives the admin a false sense of security, but I agree it can be
> > > perceived as a configuration issue: The admin should not rely on that
> > > data, because they can simply check /proc/cpuinfo to see for themselves
> > > that all APs actually do not have any microcode applied to them, and
> > > then go read AMD errata to understand which CPU vulnerabilities are
> > > mitigated with a microcode update.  
> > 
> > So is this bug not fixed?  If so, it probably should be.
> 
> It is fixed with 098bcea71b8d (by correctly updating the AP microcode).
> I guess the commit should be included in stable branches even if it is
> not a security fix.

It is in the 6.18.y and 7.2 and newer kernels already.  If it needs to
go to older kernel releases, let stable@vger.kernel.org know with a
working backport and they will be glad to queue it up.

thanks,

greg k-h
