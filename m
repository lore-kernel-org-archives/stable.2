Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C54766A6;
	Wed,  2 Sep 2026 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349369; cv=none; b=RoP96BlfsDxlWv4d7v7vIcSmQFSPRhjWI5TP4fIC38Apsi8tiTAFKK0SdlN0cAxt6KfrqTSvKfbSvf05toOujNxBb2Czg1D8pEbw1xVMG9aKXmYnf9amjd78d3Fp6UvC5Y9LT472ggTEkioP/6IJl7o6m4yAzo6jz3LvovuWBiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349369; c=relaxed/simple;
	bh=cOhOX6uZKlbmXxScLPKfL/HWlAEx46ZVmWRg4qmf85s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+lN112ikLwvuhfsC4kND/waHznm6X/ZDnN+p/zrPX3O7nbko/ukSM3F6fBWOroCR/JETXGjaDddSQUZaqdZ5PMEpbRg9R9UfbsGoDIssdGzHyfjqarnNW6k2PO8oIr5zknLOzYmd2xR53qor6O1KP82nqhcj0jNfRgOxJCf6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFtbLdlB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFtbLdlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A051F000E9;
	Wed,  2 Sep 2026 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788349367;
	bh=cFFPJ4hUOzzDlJRQ41DwpLzXzqerXelk+5anGyTnowc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UFtbLdlBlM7WFQSqLSMx8+G0ECZNG+Be0uAM9IlweuG2hYWsKyA4j+qR0N/5Bby7z
	 HLgCBNH5fVk4VklCspvFJi1JsBmwiVhP4kvM5E0+9XDmwJlMzYz6lpe6b7hwzYvGJ9
	 bzNjDnk2CRifv45QmtsHP2sqQA4ZDtyQXWq+kog4CMq1IZ0socfUmOYcdAliw8fcaU
	 DQpxB6gv+l2RY1T9seDTbDH2gLKEK76ZnQK/g937Tvyg7Ev4BjorPNQQeZ5MZ2Udg1
	 gMQwr1FXxk6SmJyGqA8Ig9p1qhN7DQbHk9oRHk8NzbAXdOt6Ac/PNOYnP0y98Q7JSC
	 mVo2Dpbs5duFQ==
Date: Wed, 2 Sep 2026 19:42:36 +0800
From: Gao Xiang <xiang@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] erofs: add sysfs feature entry for xattr prefixes
Message-ID: <apgLrJqst_kGUq1D@XiangdeMacBook-Pro.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260902015039.54190-1-jefflexu@linux.alibaba.com>
 <2026090256-impart-headstand-7d29@gregkh>
 <apgAHPzvGe4bEPJx@XiangdeMacBook-Pro.local>
 <2026090249-rework-vividly-5abb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026090249-rework-vividly-5abb@gregkh>

On Wed, Sep 02, 2026 at 01:38:16PM +0200, Greg KH wrote:
> On Wed, Sep 02, 2026 at 06:53:16PM +0800, Gao Xiang wrote:
> > Hi Greg,
> > 
> > On Wed, Sep 02, 2026 at 07:36:13AM +0200, Greg KH wrote:
> > > On Wed, Sep 02, 2026 at 09:50:39AM +0800, Jingbo Xu wrote:
> > > > Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
> > > > supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.
> > > > 
> > > > Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
> > > > Cc: <stable@vger.kernel.org> # 6.4+
> > > > Reviewed-by: Gao Xiang <xiang@kernel.org>
> > > > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > > > ---
> > > > changes since v2:
> > > > - add Reviewed-by tag (Gao Xiang)
> > > > - update list in Documentation/ABI/testing/sysfs-fs-erofs
> > > > (https://sashiko.dev/#/patchset/20260901062243.109172-1-jefflexu%40linux.alibaba.com)
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-fs-erofs | 2 +-
> > > >  fs/erofs/sysfs.c                         | 2 ++
> > > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > Why is adding a new feature a stable thing?
> > 
> > It's not a new feature (Also, this patch has 3 lines diff):
> > This is a bugfix to address the missing part of
> > commit 6a318ccd7e08 ("erofs: enable long extended
> > attribute name prefixes"") since every on-disk features
> > should be shown in `/sys/fs/erofs/features/*` according to
> > the definition of:
> > 
> > What:           /sys/fs/erofs/features/
> > Date:           November 2021
> > Contact:        "Huang Jianan" <huangjianan@oppo.com>
> > Description:    Shows all enabled kernel features.
> > ...
> > 
> > IOWs, this sysfs entry should be part of commit 6a318ccd7e08
> > to indicate this feature is supported since Linux 6.4+
> 
> Ok, but as this has not been present for a very long time, did anyone
> even notice and need this now in stable kernels?  :)

I think Jingbo needs it (btw, I'm no longer in Alibaba Cloud
anymore).

Also it would be better to port this into stable kernels so
that users can get the supported on-disk features in a more
unique obvious way.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
