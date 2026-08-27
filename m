Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980BA30F543;
	Thu, 27 Aug 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808034; cv=none; b=bOe9fm5a9czglOwFKWaPYySHS8nsWyrVIYry1/ct7oapaioQ4bloSWFsDfSKbHuFs/pPAuLGBNeD+TcFCXqfr/kYNlSTG6H5rAeVRYDmw/qpvq6LfHTMADLpVrzwH6R9clZRR6X9IloSEVLU6tWTV0QbsaXi96512hWu9ncEfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808034; c=relaxed/simple;
	bh=NwvmLZBB5FDCrhX9KcmQC98f16VXXpblOu6ah0ssUM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmHbSX0WZJyVuhmWl2zeU6dbQCiWKJxrUaDkiwmLOpIswPsf/A/OSuS76l7FYIoi7Qxy7KGDPZ2nKVYbNXY77tPhuagPnCcYsGfq+U7grKa+r+zAmTcbo9oXCL+FL4C6CHfI5EyZ+v233CiOJpcHSmg9J4qDdikQkrYZ4Jl8q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yU4TJXco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yU4TJXco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E771F000E9;
	Thu, 27 Aug 2026 05:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787808033;
	bh=vLBb6HhqmhPJ+9yrEnnJou4XlhOnsykA1SP0EOkS2bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yU4TJXcotY7tgwIjdLlEW92NJfj/z9OPzct5awmZ8G+qKISedXXHbhJSr1gx9UobE
	 jALugNVyov/2ai1uOoNnubxtJ541lyRURov/rUG7gocAIOBVfMqX3Ww9izLove/GCw
	 WNC7C+xbKE35iJBjgDNuj7yGBfBqVTFrhIRPgpI4=
Date: Thu, 27 Aug 2026 07:20:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: dwlsalmeida@gmail.com, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, mchehab@kernel.org,
	stable@vger.kernel.org,
	syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] media: vidtv: fix uaf in
 vidtv_bridge_on_new_pkts_avail
Message-ID: <2026082710-curse-hardwired-baaa@gregkh>
References: <2026082737-traitor-shorter-a4cc@gregkh>
 <20260827051508.13989-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827051508.13989-1-jeffinphilip14@gmail.com>

On Thu, Aug 27, 2026 at 10:45:08AM +0530, Jeffin Philip wrote:
> On Thu, 27 Aug 2026 06:51:21 +0200, Greg KH wrote:
> 
> >While "fun", this is not a normal path that users ever will hit.  See
> >this thread where I propose tainting the kernel if you attempt to do
> >this:
> >	 https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org
> 
> Thanks for the reference. The task hang is not possible
> then. However, the UAF will be triggered anyway as we are just simulating
> an unbind. Even if the driver's .release is called naturally, if we are
> streaming data, it could cause the UAF, no?

I'm not saying your patch is incorrect, just that using bind/unbind in a
way to justify code changes isn't ok on it's own (we are seeing some
crazy platform and pci driver patches being proposed because of this...)

It's up to the maintainers here, just wanted to point out that this is
NOT a normal codepath that users can ever exercise and think it's not
going to possibly cause problem.

thanks,

greg k-h
