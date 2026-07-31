Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BD2B9BA;
	Fri, 31 Jul 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507484; cv=none; b=PMB6ezUQ8F8CPyPwGMtJPcPL1W19tyUVHv+22FN1hcVaDP1jItnAXpV9LJQIHJYujWPMRGCgJVLAzC11eydRZZNzmsbe15jgeGJnsn8Ut8RmtIpWxIxGvccP07U78Sf0uHF7Vaai7EHfhl1Aiu5LaiezsCv1xbbr4RQSAIWafJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507484; c=relaxed/simple;
	bh=btYBu9G5gSovFjFgW5LNafsjLpNwQgZaqNO2sl+Va3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsdUznB7YyK7BLOITFBjJI8qoAdduRS4SxSoUmgkGcQuSmvGmxh2/e3XLUtQn2sqcfX9m6amH1LnWcY66VUz4WmVHvSJ1WTDoK+U6HzR7q/4y123gGFPii/bSzO+pvbUS8mHIkA6rx+ngoH8J/+4sjrWThnC6shAEJnMj9LzRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cf2/bXgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cf2/bXgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5A71F000E9;
	Fri, 31 Jul 2026 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785507482;
	bh=ZAvdbexAENOePq4UJ5Y55gMOj7mcp/5oCXcaeQwIE58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cf2/bXgEEany/9qRZxjBttBzGPM2LT5LH6TjAf1m+dUQFDPz87mqa6CyBk0MqNeCP
	 5PreTJ4/q5IvBSErEmOTgebXtQxvhGMFRX90OQPOA6NntLt5ksmgcdMIm/B9WZhlLZ
	 iWLwkmdz7LdZA3TR0Vgy9sTk5F0ci4vqnXFtPcnw=
Date: Fri, 31 Jul 2026 16:17:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: arnd@arndb.de, kees@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 1/2] misc: ibmasm: Fix static out-of-bounds MMIO
 access during probe
Message-ID: <2026073114-staff-turbine-9864@gregkh>
References: <20260718073253.96741-1-25181214217@stu.xidian.edu.cn>
 <20260718073253.96741-2-25181214217@stu.xidian.edu.cn>
 <2026073120-deplete-bronzing-481c@gregkh>
 <ce868846-52a6-47d7-96d5-1f14f1e9b5f9@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce868846-52a6-47d7-96d5-1f14f1e9b5f9@stu.xidian.edu.cn>

On Fri, Jul 31, 2026 at 09:57:15PM +0800, Mingyu Wang wrote:
> Hi Greg,
> 
> Thanks for the review.
> 
> > In thinking about this some more, isn't that what the "authenticated
> > PCI" spec is for?  We trust this hardware, right?  If it gives us an
> > invalid BAR, bad things can and will happen.
> > 
> > So does this ever happen in a real device?  And where are these real
> > devices?  What types of systems are they and are they even still being
> > used?
> > 
> You are right, a physical IBM RSA device would likely never expose an
> undersized BAR. We found this crash using an automated QEMU device
> fuzzer. In a traditional bare-metal environment, the kernel's trust
> in PCI hardware is well understood.
> > Where did this value come from?
> 
> It comes from the `display_depth()` macro used during ibmasmfs
> initialization (`drivers/misc/ibmasm/ibmasmfs.c`). It calls
> `remote_display_depth(sp)`, which reads from:
> `sp->base_address + SCOUT_COM_C_BASE + 0x1fc`
> 
> Since `SCOUT_COM_C_BASE` is defined as `0xAC000` (in lowlevel.h),
> the highest fixed offset accessed statically is `0xAC1FC`.
> 
> > I feel like if we start taking this type of patch, you will need to do
> > it for EVERY PCI driver in the kernel, right?
> > 
> > Again, Linux trusts PCI devices, so is this even needed?
> > 
> You make a very fair point. We definitely do not intend to patch
> every PCI driver in the kernel.
> 
> We targeted this specific case because of the severity of the crash
> during `probe()`. Since the driver unconditionally accesses offset
> `0xAC1FC` (approx 705KB) without checking the BAR length, an
> undersized BAR provided by the fuzzer causes a page fault while
> holding the `idempotent_init_module()` lock, leading to a global
> soft lockup.
> 
> However, I completely agree with your core argument: adding defensive
> checks against untrusted/fake hardware into obsolete drivers is not
> a scalable strategy for the kernel.
> 
> If this hardware is truly dead, maintaining these edge-case patches
> is unnecessary. Would you prefer I drop this patch series and submit
> a single patch to remove the `ibmasm` driver entirely?

I do not know.  Do some research into when the hardware was made, what
it runs on, and try to determine if it really is even used anymore by
anyone.  If not, then yes, let's drop it!

thanks,

greg k-h
