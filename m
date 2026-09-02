Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29514A0906;
	Wed,  2 Sep 2026 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359032; cv=none; b=Sn6poH8iTBIoLUcHQXsyGDQDiRGdJTG2wh2+ZXl3dLZHCpqkjWtEwKJbXgV0IUFGgg/LcB9sd5fz/dFUAalW0C+y0pSaq241NO0GxRStUILrKi5mC5TFYp5TQ1jdgL/ZhRQA+hyy4DbmJtSg95zUeCc01L1IOGxS7iNJEkYWQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359032; c=relaxed/simple;
	bh=G+5iLF2EpPq889xKGqaxbuxTwbku0pNzH3CmMhC2184=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDqlR8ALQ4SzTjDjWG1fR/j6c9Es81ZMAmUjL6T9HTyWUwVURP6NPq7eN5ZqfqEdZ0T8uk57JN1cN3AjY03bj97iaAkFgxIDvsBkWr/fkWOmUQzJ79A+4u+4tXlmzDv8sm4fKrrxxNRp++TkXLHuC/nVvtJi8S5NnuHXe90nf0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XceFYCkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XceFYCkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BACF1F000E9;
	Wed,  2 Sep 2026 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359030;
	bh=om+MNqUxN/33bSJrKK9AMyB00XG1e22iQta6RdD44JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XceFYCkWoPM5mKujykC1r/IrtNDtFN0WQaxzjdNmFfANhDxwRkeAcKEJewYRieJg3
	 kPA4Cga/waZkjoc6jRUr/gNroO1z613dWxGub9caE7/GqDCsxP+X3/RBhthdNbkwuw
	 QcrMVTlbUDxrCvTevhdT33+2FZzCTzGhhkIjL4QGDAk/dPC2Gu6FE57h4L8xidnzZm
	 BpH06xE3B16yU2ckhRzKUNKItxFm6rX03lxAIyaygR3KJ8PLZXkJOvJW6JeK1XA8Ad
	 b+KnahFAUM6WT9FjlahU6FcW8BPAbrytgE+8JssV/4Ky31aLeHtoU8EpGqaKzrXnD6
	 ISqYQDjV67IKQ==
Date: Wed, 2 Sep 2026 22:23:39 +0800
From: Gao Xiang <xiang@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] erofs: add sysfs feature entry for xattr prefixes
Message-ID: <apgxa_Lnsg738c5e@XiangdeMacBook-Pro.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260902015039.54190-1-jefflexu@linux.alibaba.com>
 <2026090256-impart-headstand-7d29@gregkh>
 <apgAHPzvGe4bEPJx@XiangdeMacBook-Pro.local>
 <2026090249-rework-vividly-5abb@gregkh>
 <apgLrJqst_kGUq1D@XiangdeMacBook-Pro.local>
 <2026090258-zealous-oyster-2874@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026090258-zealous-oyster-2874@gregkh>

On Wed, Sep 02, 2026 at 01:54:08PM +0200, Greg KH wrote:
> On Wed, Sep 02, 2026 at 07:42:36PM +0800, Gao Xiang wrote:
> > On Wed, Sep 02, 2026 at 01:38:16PM +0200, Greg KH wrote:
> > > On Wed, Sep 02, 2026 at 06:53:16PM +0800, Gao Xiang wrote:
> > > > Hi Greg,
> > > > 
> > > > On Wed, Sep 02, 2026 at 07:36:13AM +0200, Greg KH wrote:
> > > > > On Wed, Sep 02, 2026 at 09:50:39AM +0800, Jingbo Xu wrote:
> > > > > > Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
> > > > > > supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.
> > > > > > 
> > > > > > Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
> > > > > > Cc: <stable@vger.kernel.org> # 6.4+
> > > > > > Reviewed-by: Gao Xiang <xiang@kernel.org>
> > > > > > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > > > > > ---
> > > > > > changes since v2:
> > > > > > - add Reviewed-by tag (Gao Xiang)
> > > > > > - update list in Documentation/ABI/testing/sysfs-fs-erofs
> > > > > > (https://sashiko.dev/#/patchset/20260901062243.109172-1-jefflexu%40linux.alibaba.com)
> > > > > > ---
> > > > > >  Documentation/ABI/testing/sysfs-fs-erofs | 2 +-
> > > > > >  fs/erofs/sysfs.c                         | 2 ++
> > > > > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > Why is adding a new feature a stable thing?
> > > > 
> > > > It's not a new feature (Also, this patch has 3 lines diff):
> > > > This is a bugfix to address the missing part of
> > > > commit 6a318ccd7e08 ("erofs: enable long extended
> > > > attribute name prefixes"") since every on-disk features
> > > > should be shown in `/sys/fs/erofs/features/*` according to
> > > > the definition of:
> > > > 
> > > > What:           /sys/fs/erofs/features/
> > > > Date:           November 2021
> > > > Contact:        "Huang Jianan" <huangjianan@oppo.com>
> > > > Description:    Shows all enabled kernel features.
> > > > ...
> > > > 
> > > > IOWs, this sysfs entry should be part of commit 6a318ccd7e08
> > > > to indicate this feature is supported since Linux 6.4+
> > > 
> > > Ok, but as this has not been present for a very long time, did anyone
> > > even notice and need this now in stable kernels?  :)
> > 
> > I think Jingbo needs it (btw, I'm no longer in Alibaba Cloud
> > anymore).
> > 
> > Also it would be better to port this into stable kernels so
> > that users can get the supported on-disk features in a more
> > unique obvious way.
> 
> Ok, that makes more sense, sorry for the noise!

Thanks for your suggestion and time too!

Thanks,
Gao Xiang

> 
> greg k-h
> 
