Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D555471264;
	Wed,  2 Sep 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346424; cv=none; b=s1+64I1ljFa3QR2DANZ/gQVd0HhWAtdimantcTGpNyVli8MioYj4OTMHQWU70jyve9+74i1QfqNLqVU3RpBwrr8rnU800UBwCrhu7NN9i7eZS83ey5UBBZBtGS8O/1Sba29BOFICQBKJ5wIOhqpnaZTHiwTUjDoveffC3QDmX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346424; c=relaxed/simple;
	bh=u9PF9mU+yHXq99mQ1ySN+MjvBsn4S75e/OZFwVFT/vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxPX/Y/8kbCEmkODBpb8oZfFcjcXjSPeamCvrbkgmwilm/vup1GffHrVYPh1MIv95WFQMWe2xG/7Jph/oOat1pl2UVQN/2iIuLmqsRWKRzTatgaxm4BamPcLFYLj+rVPkSq/kKYHi6rabAZdqNp1Ly60GToc+CEk6Aw79n2fwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2WBDTT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2WBDTT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801A91F00A3A;
	Wed,  2 Sep 2026 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346404;
	bh=PDMuxGaclIhCULVHM63Tu//SkyV5zPfhxAoYuBXM7BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2WBDTT70K9lE3liIgDZbfk+4SVP46QKijOy8ctdllC6rnUG/W+hH+yzsmtcQ4a+S
	 VIkHDt5iLylXqH4GkUAk5zinW712PvmN4plLvSHMW5nfbHc0U8iXbE810+u71TZhl2
	 jDH69m+LdOuDJAElhG51pVNUT8xkCPqUfD18dlwbnJBU6vDkL0Lp+3mcLiRzLd2pYd
	 SN5uCGwN353CRhkho9AFKqukEbPDRcK6SZzVrc3BzgC/SYrRii1l5MjwrlxWYdrpK5
	 BjFtk2qZpGOKPXKeE5DDm3Wf0YipvHINjp9cSBg/nQRvmmkpYLOE3weIeTctZ9Nev8
	 0DI4Ir3r73Y0g==
Date: Wed, 2 Sep 2026 18:53:16 +0800
From: Gao Xiang <xiang@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] erofs: add sysfs feature entry for xattr prefixes
Message-ID: <apgAHPzvGe4bEPJx@XiangdeMacBook-Pro.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260902015039.54190-1-jefflexu@linux.alibaba.com>
 <2026090256-impart-headstand-7d29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026090256-impart-headstand-7d29@gregkh>

Hi Greg,

On Wed, Sep 02, 2026 at 07:36:13AM +0200, Greg KH wrote:
> On Wed, Sep 02, 2026 at 09:50:39AM +0800, Jingbo Xu wrote:
> > Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
> > supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.
> > 
> > Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
> > Cc: <stable@vger.kernel.org> # 6.4+
> > Reviewed-by: Gao Xiang <xiang@kernel.org>
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > ---
> > changes since v2:
> > - add Reviewed-by tag (Gao Xiang)
> > - update list in Documentation/ABI/testing/sysfs-fs-erofs
> > (https://sashiko.dev/#/patchset/20260901062243.109172-1-jefflexu%40linux.alibaba.com)
> > ---
> >  Documentation/ABI/testing/sysfs-fs-erofs | 2 +-
> >  fs/erofs/sysfs.c                         | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Why is adding a new feature a stable thing?

It's not a new feature (Also, this patch has 3 lines diff):
This is a bugfix to address the missing part of
commit 6a318ccd7e08 ("erofs: enable long extended
attribute name prefixes"") since every on-disk features
should be shown in `/sys/fs/erofs/features/*` according to
the definition of:

What:           /sys/fs/erofs/features/
Date:           November 2021
Contact:        "Huang Jianan" <huangjianan@oppo.com>
Description:    Shows all enabled kernel features.
...

IOWs, this sysfs entry should be part of commit 6a318ccd7e08
to indicate this feature is supported since Linux 6.4+

Thanks,
Gao Xiang

> 
> confused,
> 
> greg k-h
> 
