Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3B47605E;
	Wed,  2 Sep 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349107; cv=none; b=szILnrlipQhs5jg0cucEsYBjKu93xOdDWQHx5x9s9Tg7ZBSnMDr3b7o838a1RM2dadQkZMz9K/Cx85vkuXZXAhJA6ogHTEM2szFPO8n386ajpGZfhtZ1l2SQuDDT/waT+AOQd37EH4VaTMmB1MAd+mdIoCCJUb+ims3h4Fcqip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349107; c=relaxed/simple;
	bh=doDnI6rwsSWWio8oIbX8zb9YOr5fzCfyqcGJihaY0sI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/g5cdSh3qscWK8iWo5Wfz2d8oLMv4uJ3GAUfEWD0ojNxFJ0GeoL1Kq6gH3mo+8l2g5IFh6/cN+QXaozKCqWdZnnOf1VbesYO/zVJocwfdShMXRW1F/T11BrATAhE0IejlxgvriJraqU5S8Ea1EjEug5rtXmA9+zGSvoNwx3jXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Vq2wmeLN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x5tvK3g2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Vq2wmeLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x5tvK3g2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C4BA7A011F;
	Wed,  2 Sep 2026 07:38:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 07:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788349102; x=1788435502; bh=Iwg7l0aLAL
	uI+yLPRPrGWa0SNB2q8wRta51mQ71v7Ak=; b=Vq2wmeLN1tBrpuKzf8+MPBhpz+
	JRHG1S+c+rAG0JiD5wMTbKr3LZUWQ1XsQczqz9//iZ0+LePvvAqCmRUbW8Rpspb0
	wUkqt8Co0OoyQYCMAN+vHs7gscAhHX/5DGVkz1ZZ78BPg6P7dMBRoEyi/QMdD9S8
	jJw3WU+WL3tA+Ya7mm8QS7+laFjB0+o3M/LRHLVRBnbcoRKT+92tr7vSs2aC7nR3
	Swn91Hza/JDe0GQsF1FHXhdk9iWiiARoJ6A/D0wIAdynm/P8+A4dIkJJrFVqVfNs
	tbt0BPokEgP0VtBd5hIGjkr22epiiFeosQEQP2g1fdk8xVM+6kikrWImvwgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788349102; x=1788435502; bh=Iwg7l0aLALuI+yLPRPrGWa0SNB2q8wRta51
	mQ71v7Ak=; b=x5tvK3g2l1X2S8t3h9bLzJOx9X8jW1RDRCjPibMc9awJLzzfcsj
	kavbKWXHoxCDo24nf3xQAhPw8iy00BkUWoV2lhBXEnDqRXUjNp4n/YFcFz2fAlEc
	k8L5Fly9e9270i8TocexBDr4TKSpoQ8PXXSkr2SHzJpQwkiyP2zLvRc+a8x3MCsa
	laqOaR5yHaYW4MJWWY6xR91rWSO0Gqure/9yepnhb92PQHOJEvtRKmHerc3K9++m
	x7n/r2cDFSU1JzNbFPnWQDCkjnp8iGCezv7zKA0SJtsIJjNvXzkD2wikqMrTG0h1
	0lhnq0Bb4Gq9AoOTFLh7pay0SzrGL7Nctrg==
X-ME-Sender: <xms:rQqYag9F0-uVTQif6waws7g2b6T3Q-dwSGCg1EqKSiJWs5qX8GDBGQ>
    <xme:rQqYat4oVBUD4mICNmgz-umWiOijfSg6vYh0tXjK5UYj0R8afavslqc6UUdldB0vK
    aDnyq9JKgUNUs37Y6EcftnstZoSSa5bLfrLnj2C_zRO8WXDKA>
X-ME-Received: <xmr:rQqYapZinwEO6BQGuxjKV6NYRbwl4ct4Iih_XxUlih5Aybw-nxCi5gbN2pZYjQpMmiN70X0FlS8mRUlc38QFxdo7o67oML0OphbPu3sMohA>
X-ME-Proxy-Cause: dmFkZTEMpFQ98LZPBUG17vrzvlM19lhS5ODp97hDutOhAyyK/kUiBgOjrN+oH1Z6cpkAHz
    33FeSDQz96XitUU7f6VtUIwLmqCjeyTMz+/lVH46Q9KrTVy3BpMQ/v1iMdSFRncSZQHwlm
    0eXNssoFd6dBkSxm1nQjr1xN3XWr/r9IfZmIrBniq4cg2HoqSQjHCnrDTov+8Adl9cFGUu
    rHuv5dluN9SNaojvKsBv1Mf6a+jOaYXX80TG+HS3kbE45tPPAmAzar4LzkPTqmyjt00+Gc
    4Igl4NYlAhlQSArmmIYKoqcSqsRvUhuEtfrHew75pg7GJ5pMshGuZzhpLiFbBjwrK1lPrK
    OD3VyOIw1KvLYRF9tI66p5xLuq8U8ftwl9kyWCnxGl/i8pE166R7oE3FzQHifLtq6sgVEA
    wqo2ToNqc9zNxZJPi3O+hNLz7yJ4QjacDGoWuuUxA8UwIMh2Ox032pFX5xdwvgnnA1JweZ
    1jQ6GnLcNEQRbva4cNCSWmqEQUni0LBjNE49p9xdyGMbGStcpGz/tbxKKGnj2Y551ZubbF
    YAxq/qtEjQF/VrKy8BH6Jh1+25nizwEy10voY4ZgTMKwF9aTiHIPpdM5Qxj823/KesZxuk
    7dUSYGqEDyUGLTGDH3ldfEfcrmZnte+RcvukHBXcRzVAPfe91jVgLHErT9xQ
X-ME-Proxy: <xmx:rQqYav_81XdfZyoXzQ90NV4ip7fPeuUQ33dstMKfw4AZUC3O-FZHWA>
    <xmx:rQqYagRm-YYlwCnwrgI8xoIH__pHA-5ODFVodCNBKxiDb5lAf8tirw>
    <xmx:rQqYaqKHaE6H-_bKpGSvfTnEtJ4nhQwIV816-HcXCpJWYceZykDiwQ>
    <xmx:rQqYaiTdcBTJno4m0JjoMhmK4sO05mAVMS5_oG-OeQjuziR0C5XUZQ>
    <xmx:rgqYavIyU_w72zpLDMecmXfJkLJNI9Z9mCwF1ugRSDG2F2siSCKTrma5>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 07:38:20 -0400 (EDT)
Date: Wed, 2 Sep 2026 13:38:16 +0200
From: Greg KH <greg@kroah.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] erofs: add sysfs feature entry for xattr prefixes
Message-ID: <2026090249-rework-vividly-5abb@gregkh>
References: <20260902015039.54190-1-jefflexu@linux.alibaba.com>
 <2026090256-impart-headstand-7d29@gregkh>
 <apgAHPzvGe4bEPJx@XiangdeMacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apgAHPzvGe4bEPJx@XiangdeMacBook-Pro.local>

On Wed, Sep 02, 2026 at 06:53:16PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On Wed, Sep 02, 2026 at 07:36:13AM +0200, Greg KH wrote:
> > On Wed, Sep 02, 2026 at 09:50:39AM +0800, Jingbo Xu wrote:
> > > Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
> > > supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.
> > > 
> > > Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
> > > Cc: <stable@vger.kernel.org> # 6.4+
> > > Reviewed-by: Gao Xiang <xiang@kernel.org>
> > > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > > ---
> > > changes since v2:
> > > - add Reviewed-by tag (Gao Xiang)
> > > - update list in Documentation/ABI/testing/sysfs-fs-erofs
> > > (https://sashiko.dev/#/patchset/20260901062243.109172-1-jefflexu%40linux.alibaba.com)
> > > ---
> > >  Documentation/ABI/testing/sysfs-fs-erofs | 2 +-
> > >  fs/erofs/sysfs.c                         | 2 ++
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > Why is adding a new feature a stable thing?
> 
> It's not a new feature (Also, this patch has 3 lines diff):
> This is a bugfix to address the missing part of
> commit 6a318ccd7e08 ("erofs: enable long extended
> attribute name prefixes"") since every on-disk features
> should be shown in `/sys/fs/erofs/features/*` according to
> the definition of:
> 
> What:           /sys/fs/erofs/features/
> Date:           November 2021
> Contact:        "Huang Jianan" <huangjianan@oppo.com>
> Description:    Shows all enabled kernel features.
> ...
> 
> IOWs, this sysfs entry should be part of commit 6a318ccd7e08
> to indicate this feature is supported since Linux 6.4+

Ok, but as this has not been present for a very long time, did anyone
even notice and need this now in stable kernels?  :)

thanks,

greg k-h
