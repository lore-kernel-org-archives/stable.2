Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0F3D8902;
	Fri,  7 Aug 2026 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108224; cv=none; b=DbJMJO9csK0i29WPy3cpyburAMzmqG9oQzRVCFJ2A99IMNWLBg5EyYS74qN/OQIajG0TS+cYeAn75/h6sUuwDSjfx/B8Wj10ozfnlyRxohp1V45g1oyAcaLsADpG80aTHW6IPpOVn5VgL4T6Rx0LUKRlWw0V4fFVtyycfDzEggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108224; c=relaxed/simple;
	bh=F9tyFJ7AsnLCIXOnoQwU3jgcrGF5Qf17qF8BfNwdHtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmBlyh5urtXf56Xc3v185jk2e7KXE3VUZDCukAf76aVodSojxrCvL7rqrDxTIVGQZtoDJdq2QxdxThx2bAvFqON4LXEz5JDYVKZfV+7iuUY2ILWvhq0okMbUmW+ibdeJGUF7QuyBedPOxQcdhWfYnboFf6TJv2Sckgl8mmkEun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNvnk46V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNvnk46V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E71F000E9;
	Fri,  7 Aug 2026 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786108214;
	bh=BIOmtshyHI4va/YFB4MXJEIC8RfQo/XmVGTozPrf7no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VNvnk46VUXSA1Hjq8oPBFtHw2epzJDf6USb8sG/Mpl6fZ+l/KeffahxomCmrZ24Ya
	 X4fX32DgzEMrdxPq8dP48r8F3a++KOt1XusQIpgWuWgi44pOM543zQf6Kjn1sh5vcy
	 v9NPdCrR54sZH/a58CuAc2X06irSggoVwCfajHug=
Date: Fri, 7 Aug 2026 15:09:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: i@zenithal.me, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	shuah@kernel.org, stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH v2] usbip: usbip_host: fix null pointer dereference in
Message-ID: <2026080737-drank-trodden-16e4@gregkh>
References: <2026080734-carnage-pointless-9781@gregkh>
 <20260807101822.20922-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807101822.20922-1-jeffinphilip14@gmail.com>

On Fri, Aug 07, 2026 at 03:48:22PM +0530, Jeffin Philip wrote:
> On Fri, Aug 07, 2026 at 08:00:31 +0200, Greg KH wrote:
> >On Fri, Aug 07, 2026 at 10:07:59AM +0530, Jeffin Philip wrote:
> >> rebind_store calls do_rebind which dereferences udev without
> >> checking if it is NULL. If busid is registered using match_busid
> >> but the device is never bound to the driver or it is never present
> >> in the first place, it triggers a null pointer dereference when we
> >> attempt to rebind the device. Fix this by checking explicitly for
> >> udev first and returning -ENODEV if udev is NULL. Add usb_get_dev
> >> in addition to the null check to get a reference to udev to prevent
> >> udev from becoming NULL after the check. Drop the reference after
> >> using it in do_rebind().
> >> 
> >> Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
> >> Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> >> ---
> >> Changes in v2:
> >>  - Addressed concerns raised by the maintainer in v1 discussion
> >>    - Added usb_get_dev() to get a reference to udev preventing
> >>      it from becoming null after the null check. Drop the reference
> >>      after using it in do_rebind()
> >> ---
> >>  drivers/usb/usbip/stub_main.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >> 
> >> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> >> index 79110a69d697..c911626427dc 100644
> >> --- a/drivers/usb/usbip/stub_main.c
> >> +++ b/drivers/usb/usbip/stub_main.c
> >> @@ -256,12 +256,21 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
> >>  	if (!bid)
> >>  		return -ENODEV;
> >>  
> >> +	if (!bid->udev) {
> >> +		put_busid_priv(bid);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	/* get a reference to udev to prevent it from becoming NULL */
> >> +	usb_get_dev(bid->udev);
> >
> >So what happens if udev becomes NULL after checking it and before
> >grabbing the reference?
> 
> I looked through the driver and could not find where udev becomes NULL after
> checking and before getting the reference since we do both of those under
> busid lock. There is a small window between releasing the lock and
> do_rebind, is that what what you are referring to? If so or otherwise, 
> could you please advise me on how to move forward in correcting this patch?

If you do not hold a lock when testing and doing something based on a
field, it will race and is broken.

Again, step back and try to determine what you are trying to fix here,
and how that can be done in a race-free way.  If you don't know, that's
fine too, I sure don't!  :)

But we can't take a change that doesn't actually fix the issue, you
wouldn't want that, right?

Why are you looking at this issue anyway?  Did someone assign it to you?

thanks,

greg k-h
