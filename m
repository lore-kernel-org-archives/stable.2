Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F13502A9;
	Tue, 16 Jun 2026 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594032; cv=none; b=iOPw1oHs3MHJUizAbmnJOT7i3zXxm0qx1MoNCRDH0uHsBZGqff5eHpG9JULHFTF7rnNRfo1LU+SFAfVuQgt5EN2c1lP6Ja2vVtmUz48lga9+VCq48hNHNVNxNBxya7vlYhhvDP1TSkp29og1IhWNJTX1ycPdKnVjApa7WAt+MjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594032; c=relaxed/simple;
	bh=Ut5qRS6rGpVfBsBBURz9asjqr94BKlPhlB7+Q0ilNCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcSBvl7tNH/QGkKUvLd1ZCib0XH+1dUKDqpYigFi553xp3XGg9Mc1xnXz820vEm17zSF76DhS1Su8x1zN+sDZDBSgVw9R3EWx97vaQ6gHdoGpC3yqSjkAq5parj5llGcSHv6yAfGmSmAK8Hf4K6zzrYf4HjIHTpHW5KKB+DMxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWCSG+xo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWCSG+xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F04C1F00A3D;
	Tue, 16 Jun 2026 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781594031;
	bh=2yPfSU6MBOdHhivpd/ALvH3pjEUub2lJ35/vvEet6cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NWCSG+xoN7ZC6bJ/vlUAWGPyyVnYof3n5RAP/QXjkNdKOOoC9QF0PprU+Zc9mbaBG
	 mLihSIPO7J/jSSbgts5nq/NUDRsZcLH7HF8bjTU52Lc5QH0zap92JKI8Ke/ky28HNd
	 N16XfFpC/7toNJxlLah8plReo+9gTq7pglqqhYOvHO659AyHxR8H0e6/V2Dx4980Kp
	 SHjKYyzjlajzJJnNHugoVwXG6wNknkDJT87pla9l2gsAcYtN+PdtyUgq4PcqjbfpZU
	 t6Pp3wj7Pjlw8CgVmtn5mkS350LDsg0vD2JvqlFfDBlqkzAR4E4O+eO3yO56A3Txcf
	 Yf+u8XnxU+5Rg==
Date: Tue, 16 Jun 2026 09:13:45 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>, 
	Leah Rumancik <leah.rumancik@gmail.com>, stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
 <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org>
 <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Jun 15, 2026 at 03:19:24PM -0400, Hamza Mahfooz wrote:
> Cc: Carlos Maiolino <cem@kernel.org>

FWIW I don't maintain the stable trees I really don't have time for
that. Darrick/Leah have been doing a best effort case for that, but
again, this is mostly a best effort so we shouldn't expect them to be
looking/picking up every single possible patch suggested for stable.

> 
> On Fri, Jun 12, 2026 at 08:20:34PM -0400, Sasha Levin wrote:
> > On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> > > Any idea what happened to this series? It resolves an issue that I've
> > > hit in a production environment FWIW.
> > >
> > > Series is:
> > >
> > > Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > 
> > Thanks for the nudge, and thanks Fedor for putting the backport together.
> > 
> > We generally don't take XFS backports without a maintainer signing off on them,
> > so right now we're waiting for one to do so :)
> > 
> > --
> > Thanks,
> > Sasha
