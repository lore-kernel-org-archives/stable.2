Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FA37E5D9
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872231; cv=none; b=Dwm9ISy4QJ0/eaR/BLTK2zB7soY7DOX22T3iv/q9FtXU0gKrADO60GZ+xxHnXnI0VJMCzaakI/YBqI6j6LUeQIwHnoynfmMZ13TIOSTZkNAsQ4YEZC9lrrNA4KlQXUb1NvR9fFkO7FSvWStc4M5jSFyPG8u82ArRxyqMYKanl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872231; c=relaxed/simple;
	bh=rZNdMBonOSqe8wZkGbSxMoFlOD2WiR5QegtZdYHmlf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClvZX2CJ6JqACG0Or254gIwpxA9osUznEt2SRcTIKZA25kg5Xw/aA62REIIypEsI58YxazHDm2c7CsoAT374qTCm8rtihg3PXeTnSjFgELXxZ0Uhh1zzyoddmILWXh4gNQpSGkGIdDYoTveRRqZ1JZ+XBMzaGmz4+Srfhy6Bpm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2X7duwCA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2X7duwCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1271F000E9;
	Fri, 24 Jul 2026 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784872229;
	bh=oC5sPSbAeyD7eaIBCMwoVmQlpdfOwzN8+xv9lirGses=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2X7duwCAr9HsTIG0PLf6KEUiEo62rulxI8tpEi9j+x+EWgGq9+7wTH633aMsTzEbj
	 juQufDyzFdmtMDRHOQwjGw9cwKy1OjRAygujOE0pKVsH/KoZcraYML++N38DvItSRu
	 GJ9vjnP3YqFVPUUFJSdJR2q89qKKIdGTGV3ZVzyI=
Date: Fri, 24 Jul 2026 07:50:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com,
	JY <JY.Ho@mediatek.com>, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
Message-ID: <2026072425-felt-tip-surgical-e442@gregkh>
References: <20260709-origin-5-15-y-v1-1-5ac64636d2e8@amlogic.com>
 <2026070937-unveiling-atlantic-b798@gregkh>
 <21c69c82-f947-49b6-a046-cd0cd3037dce@amlogic.com>
 <2026072110-tweet-comment-9180@gregkh>
 <aff1295a-6de5-4276-826b-f447a44cad0a@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff1295a-6de5-4276-826b-f447a44cad0a@amlogic.com>

On Fri, Jul 24, 2026 at 09:46:39AM +0800, Jiucheng Xu wrote:
> 
> 
> On 7/21/2026 9:04 PM, Greg KH wrote:
> > [ EXTERNAL EMAIL ]
> > 
> > On Fri, Jul 10, 2026 at 11:17:19AM +0800, Jiucheng Xu wrote:
> > > 
> > > On 7/9/2026 7:04 PM, Greg KH wrote:
> > > > [ EXTERNAL EMAIL ]
> > > > 
> > > > On Thu, Jul 09, 2026 at 05:35:40PM +0800, Jiucheng Xu via B4 Relay wrote:
> > > > > From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> > > > > 
> > > > > commit edf7e9040fc52c922db947f9c6c36f07377c52ea upstream.
> > > > > 
> > > > > As JY reported in bugzilla [1],
> > > > 
> > > > What kernel(s) is this for?
> > > 
> > > I'm really sorry, Greg.
> > > 
> > > This is my first time submitting code to the stable git tree, and I'm not
> > > quite familiar with the process and rules yet. Please forgive me.
> > > 
> > > I hope this patch can be applied to the v5.15.y branch. I referred to other
> > > patches and added a "[Mark: backport to v5.15.y]" in the commit message. I'm
> > > not sure if this is correct.
> > 
> > It needs to go to the newer kernels first, so that you do not have a
> > regression when moving to a newer release.  So can you submit backports
> > for all of the relevant stable kernel trees, including 5.15.y, and we
> > will be glad to queue them all up then.
> > Hi Greg,
> 
> Could I ask for your advice? When submitting patches to different branches,
> how do I mark each commit to specify the target branch it applies to?

The simplest way, and what I would strongly recommend, is to put the
version in the subject line, like this series did:
	https://lore.kernel.org/r/20260724012519.3833356-1-sashal@kernel.org

Look in the email archives for this list for thousands of other examples
of this happening :)

Also, please read the stable-kernel-rules document which explains that
you do have to list the kernel version a patch is to be applied to.  If
you haven't read that already, there's probably other things you missed
as part of this process also.

thanks,

greg k-h
