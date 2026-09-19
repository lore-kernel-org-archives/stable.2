Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB727466A;
	Sat, 19 Sep 2026 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796100; cv=none; b=RgwE7hS9niMFsI1SXhbLsU++oUrDgH+EHVkEVY9Ow28C7FdCX/elSsYCstl0MiQcGRScRo8E/z599S49lOP38J8KL1jtIRKkgEGglPHabbIbm4fbvCdZD8P7ZadbUnBy6Sydx4sVOwnmsvW/t9VriDPGTRfDZZoKuWMFcrELh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796100; c=relaxed/simple;
	bh=DYvVIcMSX+twCdFEgNansvdNon1L157vw6gRnyIaP6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFl+2oMHuE6t7e/iSmlrT3yVsC1c6SygLNsSDQ/sa/LJmNTke3T+lfyl1lcbH2fEdwUR/b4o2ZOSUmopRPuB90mQdR+mA/YcbmbP3op7cgAUrbDAMMf9LsEzfK3EhY0nM4gkCgKHzlgQOCnIbVuvDNGilfoNLMM0kAYyQGjgM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RaCJyXC6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RaCJyXC6"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 89CF940E01ED;
	Sat, 19 Sep 2026 05:34:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uRXZbpIGIPx8; Sat, 19 Sep 2026 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789796086; bh=KnStG6pnCEzakzZVguuXiVXQLoDsRx8afl+WbDexvUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaCJyXC6GKXuGR3HdfEoxBEZIlGYWc0f15Z5aJCr2rbISloV3ZzI/RezhYhdhZKVy
	 um5moiRGorTM6dMhW2Du//RM3Fmjv3aTA3ZgW/rAkJc3WUaSjv839GwVK8uye/iYOU
	 AliWxmL7UfnZBtWFXMIkqLIrrNUUGAllQUOIE3l+5EWGTWU0NcnRt6KbFu+cZyWEV/
	 DMW/i2hyBPyPbXkCL3julihherZQG6ivMJiRnLKdqzVlTHzwhzlDcfh7a771Z+E0tP
	 Chnh6CYwDj5usesm+02lCed2L69L5kQ6mMO5aX6PhgcNCtxCRl4z1iytQlKKCS1v2g
	 jUm1zjlqM6Dgmvikbt8X6FBCdXMvv/RLc1rXSYT/SVvu8l1Clpk6yv3cSeaXET+wOP
	 jzTWkkGto70cPCqGY1hqBVrV99mFL2z9KmQnpQqp4CAkpa8ya87W/xqhwKhLqLW3r3
	 grEVyR8VvwvW6rZ5VdZiWfTWoN6PWc8XLlwhwK8oOkcx6Eks94Zfl0ohYhrF+KhZjU
	 5P89Zkd1Mkm8bg9qs6zdxdVFXN7xUPJiq2215dPjeEHYLh38z6CzlDTyPF/bNA9GiD
	 wtK5UiqYjLMcq+ATiagw9r4OKYFabXgCAeyz46+FtdC3RHxBwKEUSb1sV/EGdvsxWv
	 25JJXRtImi9Iuv3cG74zWPAo=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 269E640E015B;
	Sat, 19 Sep 2026 05:34:40 +0000 (UTC)
Date: Fri, 18 Sep 2026 22:34:37 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, qiuxu.zhuo@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/i10nm: Fix mdev reference leak in
 i10nm_get_ddr_munits()
Message-ID: <20260919053437.GEaq4e7SFEZqRzsjim@fat_crate.local>
References: <20260916091251.1997522-1-vulab@iscas.ac.cn>
 <aqx5UOLpXdDnDsi7@agluck-desk3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqx5UOLpXdDnDsi7@agluck-desk3>

Hi Tony,

On Thu, Sep 17, 2026 at 04:35:44PM -0700, Luck, Tony wrote:
> On Wed, Sep 16, 2026 at 09:12:51AM +0000, Wentao Liang wrote:
> > In i10nm_get_ddr_munits(), get_ddr_munit() returns a PCI device with
> > its reference count incremented.  If ioremap() fails to map the MMIO
> > space of the memory controller, the function returns -ENODEV without
> > putting the reference held by mdev, leaking it.
> > 
> > Put the device reference before returning on the ioremap failure path.
> 
> Applied. Thanks.

this one has CC:stable. That means it needs to go to Linus now. If so, it
needs to be into edac-urgent.

Yes? No?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
