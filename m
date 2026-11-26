Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702322;
	b=HSBsfYbyvDoBpi5yMtB9eu0qyo7zXCi75dbuQzZl5WjWVSwWBCq7dgHnCGeEjoowPhm6
	 D4Atf7gx30wzdTgMsmPngkl1idMmwTL6/utvaue59Q2sPvnG4+KzpP6t5xIGpzKBWT7vo
	 WVtSKxF7IMGZT5snEgjO1PuktfDkQVAyGBFGpQJKlychyaz5ancltfS8wO1GOOYwNj68E
	 vQVmiJ83qesroxM5zWAhOMQLdwXY9MC7gLiQTqsvmdBv4Hsq/7ihJeK2lsbo0yGlyOrpI
	 XH0z/xfAT8GhBP75y0Kd8Ju0r5xed5ZLFNUI1pNQldQs/849ymNLgm/0kh8YnWf7w8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702322;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FwaNABeY5k88QflT1EgsvAh17X27gm7f0HrYMY1bXw8=;
	b=iulEi3Ppq4XFw9xuegR+xoY+O4UYtp2UHq/b5x04b8HpVi8j3dF3e27RJtBi9EttyyPX
	 GqvRf70nE5rQHkvGxeTxqMdsq1bQtgUqDdSKQqof8XTf3upx5FBgYkIzsNKhp1pIDaBo9
	 /vmV7U4xuJWaoeuYBY7yVRXqi4SxCkYf0MCMrxZR5w9wpnWIj5CrdD9i2Ys/Eji/xRKoR
	 +1dczp5oxuD5jorQ3aJD14RCtqsh6/i6sxpkgKXN728s1K1GXJ/J2wU6dYH0rWui5Km9V
	 5Ym7z7babtRep8IzowaU6bAfeSKCE/m2WhqVG0MyMVKiGDqTNzoYUF6Uyee60EN6Ntg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=U7Vtblm0;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775C606A31C;
	Thu, 26 Nov 2026 14:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5775C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=U7Vtblm0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FwaNABeY5k88QflT1EgsvAh17X27gm7f0HrYMY1bXw8=; b=U7Vtblm0t+0b+NPy/BG+0q+YNu
	5kYYxbx16TC9X/Yy0NTvZZH+4NFRQTx44CRXxOAE4/r8vriKQmDmPSVQ55FdecPGUIwFudzm3hmQg
	eBxGxbC5qhzi75zLJGM2EezVmPKdJENNpSNNGRY43U7WbgC1YIWjkOCLHdMXJRw52qlA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xWaCZ-001a50-6F; Thu, 26 Nov 2026 15:11:55 +0100
Date: Thu, 26 Nov 2026 15:11:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] net: ethtool: do not call get_regs() for zero-length
 dumps
Message-ID: <5e76388e-e88a-4256-9324-aff0c9625aba@lunn.ch>
References: <20261126015239.6038-1-25031212351@stu.xidian.edu.cn>
 <366216bc-ccc3-4547-8587-87cdf35f552f@lunn.ch>
 <20261126082144.3295-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261126082144.3295-1-25031212351@stu.xidian.edu.cn>

> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >
> > Who does this bother?
> 
> The zero-length request itself is harmless, but it now trips the
> direction check in the USB core and, in setups with panic_on_warn, turns
> a privileged ETHTOOL_GREGS call into a kernel panic.  That is the same
> class of issue as the plusb fix (CVE-2023-52742), which also carried a
> Fixes tag and a stable Cc, so I kept both.

Maybe. But how long has it been like this? Nobody has reported it, so
nobody is bothered by it.

Linus has been pushing back on the number of Fixes: which get
submitted. So we have to push back.

> > Some of the kAPIs consider passing 0 as being special.  It is user
> > space asking the kernel how big a buffer is needed to hold the full
> > dump.  The kernel sets the value in the structure and returns.  User
> > space then allocates a buffer of that size, and makes the request
> > again.
> >
> > I don't know if this API actually does this.  You need to look at the
> > logic and decide.  But by returning this early, if it did, you have
> > broken that.
> 
> I checked.  ETHTOOL_GREGS has no zero-length size query: the uAPI tells
> users to get the dump size from ETHTOOL_GDRVINFO.regdump_len, ethtool(8)
> does exactly that, and ethtool_get_regs() only clamps a too-large
> regs.len down to get_regs_len(); with regs.len == 0 it does not fill in
> a size.  So the early return does not remove a size query; it only stops
> asking the driver for a dump that cannot return any data.

Thanks for checking.

       Andrew
