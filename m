Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5019C54E;
	Fri, 24 Jul 2026 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784869212; cv=none; b=eHK7J7QNWsVlgMZ80iwd3fseuenrNKXOZ7OfX5azttVyGOtyGrYKBslb+ZfPdjxW8upi4gw7uOJN6JakAcMBtFHPo9yfXSkhAGu91whqe/9PyLbiBOkEAWygMjvZaXugbFtseEDdOTanNByQ3tL/gYoyhPTY75wH7xPfW90Up54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784869212; c=relaxed/simple;
	bh=FKoklqZ/F4qlcNQwi4NG2VG2qgjj6czo5jSltulEqdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEtj+cSO6RHfhb/17trPsqe0EgX8BbLOdM1kk8xEcBdbltlL3+ebXz2SYAp5/348BOf64lNCyXMbSKGiIv6uo+5k3sf9xJVZryG78oLB48K5LSymCoPgXmMGjReS5hdFZoFHf5DCJ/XuJDkjnfDhGdI3pkRtK+JuEsouR+FlEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7jQZqL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7jQZqL5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C51F81F000E9;
	Fri, 24 Jul 2026 05:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784869211;
	bh=8aN/tFTmYjh7e7BXhnjg9shBkB4zPYrFR+2K22VPt7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q7jQZqL5zPAnUEuDlRMBVshTPiBEUjbRRzF2pfdNNi5pr4nz1n7VjCV5DFvCQPfYs
	 XVOuMgzaksClCK9hTOo6AEhgaZGtOqQJsLcHatDU6oZaC4HxNWkg36iaCMQMNbBovz
	 NRGhHlp9QJh1y8bSe9h7kH4m6Q4RixxeyQBwJGdgy23m7RKAKTu1VD+Y1LpXBtkjw3
	 VDjCklUxV0sxEXI/hlmdmp8ZrE0Y7OAXWtL52r/dK4R+0nqkBxeylxXd6zRrTMQQ6h
	 HnNXiZ+jksd72AwP/wa0onSfwx6tvi57AZ7Y7bK3IKmP9pN7adGkAMs9R4FTlQuX/8
	 PhRYtw3SMP31A==
Date: Fri, 24 Jul 2026 06:57:53 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anish Rashinkar <rashinkar.anish@gmail.com>, stable@vger.kernel.org,
	Philipp Hahn <p.hahn@avm.de>
Subject: Re: [PATCH RESEND] kbuild: Stop modifying $(objtree)/Makefile when
 building oot-kmods oos
Message-ID: <amLw0RbalfDGzyJl@levanger>
Mail-Followup-To: Nathan Chancellor <nathan@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anish Rashinkar <rashinkar.anish@gmail.com>, stable@vger.kernel.org,
	Philipp Hahn <p.hahn@avm.de>
References: <20260723105845.1704689-2-nsc@kernel.org>
 <178484858201.4095280.2018856728416028444.b4-review@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178484858201.4095280.2018856728416028444.b4-review@b4>

On Thu, Jul 23, 2026 at 04:16:22PM -0700, Nathan Chancellor wrote:
> > Update output Makefile in the corresponding tree only: for out-of-source
> > in-tree builds update $(objtree)/Makefile, for out-of-source out-of-tree
> > module builds update $(KBUILD_EXTMOD_OUTPUT)/Makefile instead.
> > 
> > In-source builds are not affected.
> > 
> > Since commit c9bb03ac2c66 ("kbuild: reduce output spam when building out
> > of tree"), building out-of-tree kernel modules out-of-source (make M=...
> > MO=...) causes a rewrite of $(objtree)/Makefile with KBUILD_EXTMOD and
> > KBUILD_EXTMOD_OUTPUT being set.  That is problematic:
> > 
> >  * $(objtree)/ must not be changed in any way when building out-of-tree
> >    modules as it breaks other uses of $(objtree).
> > 
> >  * Setting KBUILD_EXTMOD and KBUILD_EXTMOD_OUTPUT in $(objtree)/Makefile
> >    kills the tree for incremental builds that start right there
> >    ('make -C $(objtree)'); builds starting in $(srctree) reset
> >    $(objtree)/Makefile to its original content.
> > 
> > Further, $(KBUILD_EXTMOD_OUTPUT)/Makefile was not generated any more at
> > all.
> > 
> > This commit restores the previous kbuild behaviour prior to commit
> > c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
> > but leaves in-place the use of filechk for output spam reduction.
> > 
> > Fixes: c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
> > Reported-by: Anish Rashinkar <rashinkar.anish@gmail.com>
> > Closes: https://lore.kernel.org/r/CAOESE2Q2-0KUDaM0mUo+c_F-tMaUsBZ-gpnhdoe0rmYdgnnuJQ@mail.gmail.com
> > Cc: stable@vger.kernel.org
> > Tested-by: Philipp Hahn <p.hahn@avm.de>
> > Reviewed-by: Philipp Hahn <p.hahn@avm.de>
> > Signed-off-by: Nicolas Schier <n.schier@fritz.com>
> > Signed-off-by: Nicolas Schier <nsc@kernel.org>
> 
> Thanks!
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Do you want me to take this via kbuild-fixes?

Yes, please take it via kbuild-fixes, as it actually breaks build trees.

Thanks!

-- 
Nicolas
