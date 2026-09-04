Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCD3B71B2;
	Fri,  4 Sep 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536870; cv=none; b=tqwSBIcfirptSAsB74zmOF/k8gux83fa5NV8jnxqWkvPf/NlMVLXsMUZ3xk07feecLla8fcdBe3q6Wj9ypYfC1PEEupSmvSqhQ/9X4RWpzigebNlCVtdvHmIgR/JE9QOwlPw6fCWdnd7lIOA9Dl1UgOxy0jNNoGCRkHNQc1gGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536870; c=relaxed/simple;
	bh=MrtDPdKK6+y0wKBVfyAfce9pIfxUCbofuyPis37UJuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6eHoyjP7YaqAC0N0r12wJrUZeQwE2j5/fjUbUe93fEbo0dmXlNyODBG8b7nePRljQUG6tI/pTbC+Dl7bTOgA/O9L3+BBzmD+ha8AO9I2alWgQmGdaArzF9eKAHm9BSn2DhQfeF6Wy/eyFeStqOv/EoaKp48LWk0EalCvEWyIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ojE90wuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojE90wuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100801F00A3E;
	Fri,  4 Sep 2026 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788536868;
	bh=EjdSb+K10ky5dmPg7vs00e63TFoxXUI10QkkhzPXUY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ojE90wuKhmvUgXyMF7xHuX1bmV+ITNcrtxp4p4nyb88qQ0ueF1d3BP83ug04rSJvG
	 +SYr+p3Bb5yWc4BoJzArt/yRk39kIW015J3g0JjX9iiW7w2fu3GyOhbV3RtaZIQtsb
	 yW1QTti8JFJWYzKx4sJefTLB//ViJ/3vBgyRLsMk=
Date: Fri, 4 Sep 2026 17:44:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	stern@rowland.harvard.edu, stable@vger.kernel.org
Subject: Re: [PATCH] usb: storage: sierra_ms: reject short SWoC info transfers
Message-ID: <2026090423-trifle-employee-129d@gregkh>
References: <CAF4-o1c6XLbJr5umK+FRmMetcRkxH5JnRjMUpWw7OpnkUWbvVQ@mail.gmail.com>
 <2026090452-appetizer-pacifist-57e5@gregkh>
 <CAF4-o1fTYbxEb95NVsvcJ7=jdJB+vXpzspqcgwhNn=+FBsOsNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF4-o1fTYbxEb95NVsvcJ7=jdJB+vXpzspqcgwhNn=+FBsOsNg@mail.gmail.com>

On Fri, Sep 04, 2026 at 08:27:46PM +0500, Syed Labeeq Sajid Bukhari wrote:
> Hi Greg,
> 
> Thanks for the quick look, and apologies for the corrupted patch -- I sent
> sent it via a web mail client, which messed up with the whitespaces. I will
> resend it properly with git send-email, with the patch also attached.
> 
> On the short-transfer concern:
> 
> The SWoC query explicitly asks the device for exactly
> sizeof(struct swoc_info) (wLength = 60). This vendor command has a
> fixed-size response, and the driver already implicitly assumes a full
> answer today: containsFullLinuxPackage() and truinst_show()
> unconditionally read fields at fixed offsets (bytes 9-12) that a short
> transfer would never have written. So with a short answer the current code
> already makes its mode-switch decision on uninitialized garbage. The
> patch only makes that failure explicit instead of silent.

Ok, that's a good "proof" that this should be ok.

> Two further points:
> 
> * sierra_ms_init() retries the query up to 3 times on failure, so a
>   transient short transfer during probe is tolerated, not fatal.
> 
> * There is core precedent: usb_control_msg_recv() in usb/core/message.c
>   rejects short transfers with -EREMOTEIO, i.e. the USB core itself
>   treats a short control-IN as an error.

usb_control_msg_recv() is designed to work that way, it's not any sort
of "proof" that this is ok for this device :)

> To answer the testing question directly and honestly: no, I do not have
> the physical hardware, so this was not tested against a real Sierra
> TRU-Install device. It was tested with a fully controllable emulated
> device (raw_gadget on dummy_hcd, VID 0x1199 PID 0x0fff) against a
> self-built 6.12.108 kernel:
> 
> * full 60-byte response: enumeration and truinst reads behave exactly as
>   before (attribute created, values printed);
> * short response: the query now fails with -EIO instead of exposing
>   uninitialized heap through the world-readable truinst attribute.


That's a fake device, real devices are what really matters for testing,
you know this :)

> If you would rather avoid any risk on some devices you mentioned, I
> can respin this the other way: allocate the swoc_info buffer with
> kzalloc() in truinst_show()/sierra_ms_init() instead of rejecting short
> transfers. That closes the uninitialized-data exposure without changing
> behavior for short answers (the unwritten tail becomes deterministic
> zeros). Happy to send whichever variant you prefer.

kzalloc() is good, and is what we have done for other types of issues
like this:
	https://lore.kernel.org/r/20260819-usb_misc_random-v1-1-43a0dcee3a32@kroah.com
but as the data is being accessed, this should be ok.  Worst case, we
get a bug report and fix it afterward like we have for other times we
have messed up.

thanks,

greg k-h
