Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E657386C1B;
	Thu, 27 Aug 2026 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807729; cv=none; b=KLwK1+QeD+3lF6sYFFP9K8MgGt9GzDmpJ4rKqFqaa3mNKUm1rJkTQRPoPPdmnyUCDi48Sftj+T0T/5sx3+hcKIdUrmv2Xa/cnVTYc4ozV544ul9AA5Fz8GoyxkyLsmwwgFVcJNmjsLmRpS4NMsV4NQ9zsmg6uxYbPHXtgzCjUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807729; c=relaxed/simple;
	bh=HcA3EQdpSLoEjmiEDaV8sfdP6zRnx0I9TMQxWKkHxFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfprMIQg4Rj+JvYCpgMavpEPquxjTGkIXOCUe0uUQG82o8OPVJVDbpSIKxzODvCf1SUwX0FDF3dr72LdvQN856qHX7Lm5WTRdt4nnw+WCaaq4W9GOLy1DloUd4W96LBGzPia5bsjj0oej3PNBHR7jL9WzOAuDyfF2OMxJG8PL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Didcb5an; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Didcb5an"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6AF1F000E9;
	Thu, 27 Aug 2026 05:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787807728;
	bh=bezzwm4Auh8nvduDCLWIKTWoV899IdCOiDXfO8TE1YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Didcb5anLpyve2mnQysvi8IGYm1kyq41x39H2+y6TFlp7QlZZyDTZL7xM0PQJwssM
	 AWDf4bPQFPfiYnBitl5RxP4eSDXiqmeqvSpPPVMHaIhKy1R7Mk1J0AaJf/93KP/Hf/
	 JlXoxhmpZPDGBRpkp85vf9eENZnx35v6AN9xTWfU=
Date: Thu, 27 Aug 2026 07:15:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shengzhuo Wei <me@cherr.cc>
Cc: sre@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org,
	Andras Domokos <andras.domokos@nokia.com>,
	Carlos Chinea <carlos.chinea@nokia.com>, stable@vger.kernel.org
Subject: Re: [PATCH] HSI: hsi_char: Fix use-after-free on device removal
Message-ID: <2026082735-unbend-laborer-ec4f@gregkh>
References: <20260827-hsi-char-uaf-v1-1-4f824216a541@cherr.cc>
 <2026082727-hacker-flaky-2578@gregkh>
 <ao_Gi6O2VQw7RUQd@pve>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ao_Gi6O2VQw7RUQd@pve>

On Thu, Aug 27, 2026 at 01:09:31PM +0800, Shengzhuo Wei wrote:
> On 2026-08-27 06:48, Greg KH wrote:
> 
> > You now have 2 reference counts for the same structure, which is not how
> > to handle this at all :(
> > 
> > Please either make the cdev be a pointer, or use the correct cdev api
> > for handling this type of common problem.
> 
> Right, adding the kref on top of the embedded cdev was the wrong call.
> Thanks for catching it.
> 
> I'd like to go with the pointer option, because of how this driver is
> structured: one hsc_client_data serves 16 minor numbers through a
> single cdev_add(&cl_data->cdev, hsc_dev, HSC_DEVS), and cdev_device_add()
> pairs one cdev with one struct device, so switching to it would mean
> inventing 16 device objects for no other purpose.
> 
> With a dynamically allocated cdev (cdev_alloc() in probe, cdev_del() in
> remove), the kobject reference that chrdev_open() already takes on the
> cdev would keep the containing object alive until the last file
> descriptor is closed, and the final release would go through the cdev's
> kobject release callback instead of a hand-written kref — no second
> reference count anywhere.
> 
> Does that sound like the right direction to you? If so I'll send a v2
> along those lines.

I'll defer to the hsi maintainers as to what they wish to do here.

Also, how do you remove a hsi device from the system?  Is this on a
dynamic bus?  For some reason I didn't think that was possible.

thanks,

greg k-h
