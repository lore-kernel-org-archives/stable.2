Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34F38F950;
	Fri,  5 Jun 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672133; cv=none; b=YvIHnvhxa6wEm8QF7UTf7v0qVXOuKsVkbCuHMo2gbBIInjWQTZfu8B1MyjdPjezaLpFvyYvDnW3O1mgs2CtlbWerKohgaQncmcSHetCyC0pDky5d6vOILx6ZsrayFeqr8oeKCm6Q/qVAfFCkTX269tuGJMWpfT1sKvjbFZFp1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672133; c=relaxed/simple;
	bh=Ka+Eb/FEZvD5N6ORxhXDgUwD0Fv1aSsd50rN1HNpq3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZExpprn4s6QnkkzGwjP2g3iGkrdAeKj09w0ujxKcoHuEQXq1SsXwOn1TA2C41D6+4U7nHSLoOjuxHNztKsXTWkiZt1eCj+BITOGAKCCTrJ90uv4SfvGW4Fg5cYjP3XbqE1cur5DU6hfv/HBhTjS4EbU+EqV7r3VWCYJ0uSMOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gk698xd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gk698xd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398D61F00893;
	Fri,  5 Jun 2026 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780672132;
	bh=xnZ8VJR/NtJ4iVq439h37B8f7/qDJZDqnfWnma9gDqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gk698xd8jPUog/7tZiu9YM3LI4fC+ZvUEZ28kWX6wX4GPbL0VOlIUqnN70uH50dpg
	 /ljRPLPcKbFo5ebX5Jnb2se7tJhCAjdzvx2l4Cl0M8uLRY2yTEbTtSAwOv6U4l0SfD
	 9pKrVJwzaDN+Wa/06KmEOsUmWfnIpdr9ax17Bj90=
Date: Fri, 5 Jun 2026 16:59:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vishal Kumar <vishalmimani008@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
	stable@vger.kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, digetx@gmail.com
Subject: Re: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
 unmap
Message-ID: <2026060548-bakery-supply-f9e0@gregkh>
References: <6a227a57.b453d089.3d0874.3012@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a227a57.b453d089.3d0874.3012@mx.google.com>

On Fri, Jun 05, 2026 at 12:27:19AM -0700, Vishal Kumar wrote:
> From: Vishal Kumar <vishalmimani008@gmail.com>
> Date: Fri, 5 Jun 2026 14:08:54 +0900
> Subject: [PATCH] usb: gadget: tegra-xudc: drain EP pipeline before DMA
>  unmap
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Something went wrong here :(

thanks,

greg k-h
