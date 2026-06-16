Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD63C13FB
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585478; cv=none; b=WXZGzzP2GOHzIeoEUfsOKcCYfnrniRjkKAHde+Zcl/BfGf8VI5/CFD7f6Z/e5hg1xrAHty8+FsPP08cy7NupyKS9ERjeqeNtBGUlCOtz3w+Pq48udbSIlGhJ6whrmJMPw9Ao3UFMve3BOxwG8iW7ybkUSAVf0HbySaQNYKUSj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585478; c=relaxed/simple;
	bh=86RZviP1Y54FCsoRguikapH8/mKUmhmhjoDAtftY9Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UidcAFaQXuQmksKPTrT1aj/DZzR8knxPQX++YXCbBaQyvkv92bbObojICbxs1TT8k3GEH3HdB47DEchnTRm/jmdAqQ8HngEA3EpesS8pKGwDIIeQgZ9u/ovae/2uDmiOApV4BYBtb+XL3zKS3LwlV/Gevv6dGKlIU7BEp6JUWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ywM0SPYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ywM0SPYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E3A1F000E9;
	Tue, 16 Jun 2026 04:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781585477;
	bh=UhdJGMkuJuDqQp7U2xv66IDTZktjFS+131Oks1JmnyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ywM0SPYptq0l+gcwkxMpuwmjDI8g+3+/4nDX8LYKqyYH3zsoDK1s74+DstdLSSMi9
	 xQWsFvDC52iD0jE1P4pQ6L5XrdaKSwjYOFicWYsEXu97rPxlrV6RLIGcG8g/ijoK7X
	 QLJ/hMJzH7vzU4S0uef8J1H6FB8oQv8ubkkseGK8=
Date: Tue, 16 Jun 2026 10:20:12 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [6.6] fbdev/vt8500lcdfb: Initialize fb_ops with fbdev macros
Message-ID: <2026061605-barley-bootie-0b2a@gregkh>
References: <ahg8Ocvb3UFV6Vdl@decadent.org.uk>
 <3f2908646639f4af8844cb8f5a9b4d2d4f904631.camel@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2908646639f4af8844cb8f5a9b4d2d4f904631.camel@debian.org>

On Thu, May 28, 2026 at 03:03:28PM +0200, Ben Hutchings wrote:
> For 6.6, please cherry-pick commit 63a11adaceb8 "fbdev/vt8500lcdfb:
> Initialize fb_ops with fbdev macros" as stable dependency of commit
> 88b3b9924337 "fbdev: vt8500lcdfb: fix missing dma_free_coherent()". 
> This seems to be applicable without changes.

Now applied, thanks.

greg k-h
