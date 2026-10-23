Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760416;
	b=rmO8HrNyft6PwQahzGy/6ghwe7xYxT3a2YNvzKL3QrBtw9aGAlKK3EuFeM8UDbDyYwtD
	 dIhhG0kPbras1f5/Um1Po0KosGeBnDLeHL3jdjzTAGObrkozZW4zIo9CO+Cj1duOsdiSQ
	 keIQ8I4L2nbm8FE/TNEQQrYcfpfNnMl9ilOGYgEl/VPikP43NoaxGNW4F1jSAyd/dQ0iz
	 1XBgU0568uUwMaNEMU3ucda4cIaXvDsDby+eCW9TJWRrQ3DzW4gvDYyue/966zEFeCIJb
	 snf11TuR2cajXGyjz6N5C9UwzD6G16yYBCANhL4gDAulPNqebI9ndL8su0I42BlL9pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DKApxC4aEMo5gabI1x2hU+JWNWLgoRM+Y9op4mRr65o=;
	b=SeVXZeTOEc571e7c3QcxpwLxVrWD0MzkZ2w/WKj35r1O9N2oca8IX0EXEa/e3V6yQLLM
	 wz+I3cGgGUvybkSSGb4HABy8aI8GOmnrFl9kwnnow0RPxji06OowVp3gfo5fX+F1iTBgZ
	 XX6zvlmJq0xtUr/tiIpUJiKG/QCmkP+2RWOCLpBUw/na8jPCxINdANHen8lgkEFhj29Sf
	 Y64AwNCZQ2iqdIIudOJ3UoBbdlrmbYJdf9rTmjYlZTz0BiTdq1410l3istxDmOVmN0gT0
	 90ERlKcXE7G2wD/RnLhxVvHnPj5RdrybicMKSnrDon5/YTwpXcEnCGCz1yxufbP7n5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iiNftLvc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7CE606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iiNftLvc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC461F01828;
	Fri, 23 Oct 2026 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792760416;
	bh=DKApxC4aEMo5gabI1x2hU+JWNWLgoRM+Y9op4mRr65o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iiNftLvc9haemm4HDS9/A435rxdN6jasHNnx64onG5SCCxWnipeIVTN8U03Lsnrl7
	 FbEZS7dhaTrCvXOzD/RDfjKVmeQ01EfA3UlOvhX9OyS2nNRy4OJP/xqftXYEkFdFXN
	 4i8gajfXxF0Ba+9l0yS3kce5c0nROUmTJEbVx8t0=
Date: Fri, 23 Oct 2026 14:57:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: pablo@netfilter.org, stable@vger.kernel.org, fw@strlen.de,
	security@kernel.org, w@1wt.eu, sashal@kernel.org
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Message-ID: <2026102330-rockslide-brunt-8616@gregkh>
References: <179235055956.10524.6485282696272965887@gmail.com>
 <atU2brRgmeb6ght2@1wt.eu>
 <179236182769.4914.3317139682579833845@gmail.com>
 <atWvQFXJzJ434qGd@strlen.de>
 <179239012164.14465.16534329674629579851@gmail.com>
 <atXZxmkU9Yrv4h_b@chamomile>
 <179258686469.28311.5894488032414438351@gmail.com>
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
In-Reply-To: <179258686469.28311.5894488032414438351@gmail.com>

On Wed, Oct 21, 2026 at 03:47:44PM +0300, Abdifatah Suruur wrote:
> Hi Pablo,
> 
> I am not asking for a CVE for the upstream code, and I am not disputing
> that bb061d3 fixes it in 7.1. I have not sent a cve@kernel.org request.
> 
> The only reason I mentioned a CVE is that 6.12.y still carries the
> pre-bb061d3 multi-register path, and with CONFIG_INIT_STACK_NONE the
> marked-but-unwritten destination word is exposed to a later nft load.
> That is why I sent the 6.12.y backport rather than a mainline patch. On
> the default CONFIG_INIT_STACK_ALL_ZERO builds the same oracle reads
> zero, so the affected population is narrow.
> 
> If you and the CNA consider a stable-only infoleak that is already fixed
> upstream not CVE-worthy, I will drop the request. The stable fix is the
> part that matters to me. If you do want it tracked, I will follow the
> documented process once the patch is queued.

What patch?  What request?

I'm totally lost here, sorry.

greg k-h
