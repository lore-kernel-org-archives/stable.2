Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9143499F;
	Tue, 29 Sep 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688730; cv=none; b=oF7BzcTFdEGVXWWLN3RC5crEMP7v+2kHL0IZC2H33YtpSMxtmJa3Ry8mQwJ2bvrcj4xjgZTAgpX40TPMqHBVmNDqVBwvw+VOndl1fqyl/WcYKMem5EELd+8zbnVDkN+mxLJQx4DLknRQgILJ+LyOTF6hckQWnaK5YlbiDxoSKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688730; c=relaxed/simple;
	bh=mnR880LfQrU5Da8bd4cxMAw/FyvJhSMFDtMv/KYdWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruxJhEMkOxt62m/LGrD7DTbg66VxBtPvfn/r5nJmzhzLLtlhVZLYS2Vn1SXbyA9fEUJjXqZuyoatdUgNBHRbClIKLPfhxNWxB7uiiJqggGiCCNK3uwIcc6dbh/6o9m1JXnk9OYKUmWvFYvIYdTYCPRBk0mEua5G7ZURw05MECd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L6sH4xqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L6sH4xqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532DA1F000FF;
	Tue, 29 Sep 2026 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790688728;
	bh=jtbR6LzwwJ3f7q3ueEGAF3rph9maa6+Lh5jtWajzKRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L6sH4xqZ2W2PYKLW8LS9J7tHVqL//icVQrVvXd8wEKnmHTOonqOTjozMSCxTKG+g5
	 nssriJDplH3kYbS9FhW+AwIUBHvil1QCb+XLLTSZEUceeuKEPjEzLcn0dbhF9W6GoD
	 BBtHZTv79tTbNBMoplshkUk9d1ct44ZR3mzcYoOg=
Date: Tue, 29 Sep 2026 15:32:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: aliresool567@gmail.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for
 GameSir G7 SE
Message-ID: <2026092941-antacid-primer-20f1@gregkh>
References: <20260927-master-v1-1-96ff85291b25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927-master-v1-1-96ff85291b25@gmail.com>

On Sun, Sep 27, 2026 at 06:54:01PM +0300, Ali via B4 Relay wrote:
> From: Ali <aliresool567@gmail.com>
> 
> The GameSir G7 SE wired controller first enumerates as 3537:10a0 and
> then re-enumerates in a mode it picks from how the host enumerated it.
> 
> When the configuration descriptor is fetched the Linux way, 9 bytes
> followed by the full 80, the controller disconnects about 1 ms after
> its string descriptors have been read, before SET_CONFIGURATION, and
> comes back as 3537:1082, a generic HID gamepad without force feedback.
> 
> When the configuration descriptor is fetched in one 255-byte request,
> as Windows does, it comes back as 3537:1010 in Xbox One (GIP) mode,
> which xpad already supports, including rumble.
> 
> Skipping the device qualifier requests (USB_QUIRK_DEVICE_QUALIFIER)
> makes no difference; the configuration descriptor request size alone
> decides the mode. Add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for the 10a0
> identity, as is already done for the ShanWan Wireless Gamepad.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: claude-opus-5-5
> Signed-off-by: Ali <aliresool567@gmail.com>

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
