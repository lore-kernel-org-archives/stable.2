Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42C339719
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639101; cv=none; b=WH0XjSqpHED213oar/EBb4XSXPKuOfkCjaHj2qKPTVo3vJilg/ZLFN11VSAwNtMHCbJxXZGTmOgyWr9Eis+qhopbzm1No0LP0vjUQrGcXd/WDbl3hl7Q1RDdKhdA8KRPRaSh7JFV6NjMFZu2EVLKcgpUrWB3B5SQQHcJAehJk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639101; c=relaxed/simple;
	bh=pi6fphJT5y/hBvNzDkdHjGcABVtNUo6ScN1hwiga26s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F51LXvyjiXxOSpq7KiXACcsr1Wh8Q5zZhFozebROehye3oj0jbXR0Qj2PuMwJlhIqE6esbLo6S11bp2Yw6ykR9sphdx1bs9vNY5CLwVJz/JwydfSgvXq2sHQRJnqCYl8zl4TfsbaA5pwlbSIRYmNqNxSyEjtTh5M39mY53ENuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMrUILjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMrUILjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3B41F000E9;
	Tue, 21 Jul 2026 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784639099;
	bh=OwXIxsP1WVTGVWXMd8DdFNkQ9AxeNkUouHrhRy0MYHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QMrUILjnRa+DIeU9IffY0AdL1uhWgX3C0yrAzlslHTFYshRLmLrycIirk1cwokWh6
	 EYgRf/m5gWEuAK+bSB0TgvJ3VHTcsOz4pFtdDeZTCYylI0EcAfX5oEPOG4rooJ/VLo
	 uVdJn25oSkN1xdIr/SQE0CUXTaw1FnpHUYX1yY2I=
Date: Tue, 21 Jul 2026 15:04:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com,
	JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
Message-ID: <2026072110-tweet-comment-9180@gregkh>
References: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>
 <2026070937-unveiling-atlantic-b798@gregkh>
 <21c69c82-f947-49b6-a046-cd0cd3037dce@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c69c82-f947-49b6-a046-cd0cd3037dce@amlogic.com>

On Fri, Jul 10, 2026 at 11:17:19AM +0800, Jiucheng Xu wrote:
> 
> On 7/9/2026 7:04 PM, Greg KH wrote:
> > [ EXTERNAL EMAIL ]
> > 
> > On Thu, Jul 09, 2026 at 05:35:40PM +0800, Jiucheng Xu via B4 Relay wrote:
> > > From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> > > 
> > > commit edf7e9040fc52c922db947f9c6c36f07377c52ea upstream.
> > > 
> > > As JY reported in bugzilla [1],
> > 
> > What kernel(s) is this for?
> 
> I'm really sorry, Greg.
> 
> This is my first time submitting code to the stable git tree, and I'm not
> quite familiar with the process and rules yet. Please forgive me.
> 
> I hope this patch can be applied to the v5.15.y branch. I referred to other
> patches and added a "[Mark: backport to v5.15.y]" in the commit message. I'm
> not sure if this is correct.

It needs to go to the newer kernels first, so that you do not have a
regression when moving to a newer release.  So can you submit backports
for all of the relevant stable kernel trees, including 5.15.y, and we
will be glad to queue them all up then.

thanks,

greg k-h
