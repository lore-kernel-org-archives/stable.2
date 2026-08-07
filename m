Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F44446844;
	Fri,  7 Aug 2026 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082451; cv=none; b=B2VuKXi0gr+O49671jFSCl5hihwg8P4HcnadGVSkf9jmZXgcU7q9TWntKqW3vkETqvBvI1WUvqVuEQ7ICfcVazgODSUI8/t+0f2TXuppPpzCv2YK9d8uPzf8KsacldMBq9kol+/a4j6fa7zQjuujj+8hH9GtdZczVnIGmZds+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082451; c=relaxed/simple;
	bh=mTyJvuHtgA5D9He5ZWUPsg6jTMY3vexGtgAr7yvVBHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHee14D5HQNz44PJNxWeDVwha6y1S7qUDJ/syg5EML403xi5iTkztRQLQ7gdoTJYIyMhdlTPFMl6t26Hn7iY5+S2mFnQ3vEJnV/4NLi1Az4tO8Nncmjkx0G0Slu1r+Y05YpQ71xhfZ2GRyxxMd+2qpxqito6LkJEAGuBGWt+iJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EErDr1TA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EErDr1TA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544AF1F000E9;
	Fri,  7 Aug 2026 06:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786082449;
	bh=LAJ39TwcMAdgtD0Y82iVU3GahasJe2+Axv14/P8Kbp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EErDr1TAVCfKL2gg67Lm2NwTVV4smsx9HiBSCX6ilW6UEBrC0OQzqyuBOOCeHOei/
	 mMJJKsWXX037jB94St23ymcIn7+sPiU/rI4h8dIou5Kj03MSuF33RaCkie3+3t4O/r
	 ltwi0h9EwbVDpBfVvFJbopMEEjYRvSZWNO3dYrz0=
Date: Fri, 7 Aug 2026 08:00:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
	shuah@kernel.org, i@zenithal.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] usbip: usbip_host: fix null pointer dereference in
Message-ID: <2026080734-carnage-pointless-9781@gregkh>
References: <20260807043759.12218-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807043759.12218-1-jeffinphilip14@gmail.com>

On Fri, Aug 07, 2026 at 10:07:59AM +0530, Jeffin Philip wrote:
> rebind_store calls do_rebind which dereferences udev without
> checking if it is NULL. If busid is registered using match_busid
> but the device is never bound to the driver or it is never present
> in the first place, it triggers a null pointer dereference when we
> attempt to rebind the device. Fix this by checking explicitly for
> udev first and returning -ENODEV if udev is NULL. Add usb_get_dev
> in addition to the null check to get a reference to udev to prevent
> udev from becoming NULL after the check. Drop the reference after
> using it in do_rebind().
> 
> Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
> Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
> Changes in v2:
>  - Addressed concerns raised by the maintainer in v1 discussion
>    - Added usb_get_dev() to get a reference to udev preventing
>      it from becoming null after the null check. Drop the reference
>      after using it in do_rebind()
> ---
>  drivers/usb/usbip/stub_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index 79110a69d697..c911626427dc 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -256,12 +256,21 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
>  	if (!bid)
>  		return -ENODEV;
>  
> +	if (!bid->udev) {
> +		put_busid_priv(bid);
> +		return -ENODEV;
> +	}
> +
> +	/* get a reference to udev to prevent it from becoming NULL */
> +	usb_get_dev(bid->udev);

So what happens if udev becomes NULL after checking it and before
grabbing the reference?

This is not how to handle this at all.  Please step back and look at the
root problem here and address that.  This is just papering over the
issue.

thanks,

greg k-h
