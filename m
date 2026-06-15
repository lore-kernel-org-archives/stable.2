Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD91346ADA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538275; cv=none; b=VFPiRwERYLLhNXZSGPnjFB5kv1vIZRhdb7k0RCw2xU3OO7qMMX30vu+f9qh7BO55h1hXfAhI4vS2vYLlTbQ/0iowJTCrIdJ1/X9fvphTgZ9Y0iz0BkNMFs4xNmxPuVQ7kktwLpXXmy6wp+qNxV/D9MqWFU/x9KZxf/spB/Rm7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538275; c=relaxed/simple;
	bh=RlBnfAliqbP4FcoiBfjxsuF7Fu9O+6q2THt4APbSfyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+7T2F/wbNRoGIrNC+CsDdsKZQjLKDaCtYlOcSQtYW95BwlKUiCZ/HTl1BJlA4t853pM3A7b0TTc2gz2jhuWOVAzdOEMi5yg0OtLAAE+u6rvOMFHxOk67PlPYSMN0ozoHEJ4AZQfIs36TCV1QL37ouQRP0HbTcw79uh/TRDEbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TLNnb9Md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TLNnb9Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162E21F000E9;
	Mon, 15 Jun 2026 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538275;
	bh=2lAlWzA0z/BMYwqjAtRXH9BfDI2Ta2x/ByHdpWMcz6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TLNnb9MdszwpN1Pw4VHaTywXqawmjoKjgDL82wgGDgL1CnoXDMcQRjKkdAnnV/kma
	 XbFMUVUIX7fqV3wfKCRODLVCZm6s9ImGvRwORf7eqvvyhU4Q3+Moivb4HSzkgvBVYH
	 gpWwSTW2Pc0ask8/CuK+1KiTmcW/cGH6jKQB2P84=
Date: Mon, 15 Jun 2026 17:21:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: federico.brasili@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: don't truncate end buffer
 for bundles" failed to apply to 6.18-stable tree
Message-ID: <2026061553-kissing-overstate-399f@gregkh>
References: <2026061524-overtone-renovate-0e4d@gregkh>
 <8a4f0b60-0333-493b-b59a-eeb4a605fc7b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4f0b60-0333-493b-b59a-eeb4a605fc7b@kernel.dk>

On Mon, Jun 15, 2026 at 08:39:00AM -0600, Jens Axboe wrote:
> On 6/15/26 8:18 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 6.18-stable.

Both now queued up, thanks!

greg k-h
