Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B409392C2C;
	Fri,  4 Sep 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534593; cv=none; b=NDCvV0fJQJIcpWX/r+S8durIa3dn/FjVEcDoMo0I3tKRCOnez7fhTq5FShbclkIEz1VQrWiFH3sQU+zQkLBajV1ThhTR6Biwv0IDGvdeZiN2re/aE071WVEApcXLOjEInXBALts4kNnh92w97EHqEc7wHG1WHJm0oRNcVKGQb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534593; c=relaxed/simple;
	bh=QmNzprKXZh4+iI7cSDE2hifDsxIRU6zxTLm/qtKLRHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPnc9XH/Nlp8GjKVCyvOKILcTcTHGX67m7hTt0i9Clxw1qhFeGYibuTzbCr1exGDBUFNi/YbkA/dg3k1kps4zvBLSlxOEzS7jQqHg70n7zflQjDlxWOu9jcOj14cqlbf76WO09vIOpXG0HNsF66iBEzsRMpWqShGxcMyovn1bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0mwNE7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0mwNE7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64F81F00A3D;
	Fri,  4 Sep 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788534591;
	bh=TuEsNH+Lnxv7kGDav5fMZ/5rXCKlZAVjboMGQAGZlyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=t0mwNE7UdWkBzBxuqcyKPayRVxa6cGBENLTuMAG1WMTNX01Us2IPSHfybYKLtC2i2
	 5zklfC0Z96UBW9ufG5IzY7s6pfmg+g3nqH1z4B33lfLwLdAa2dWPKy0NEjblQfhTCE
	 w/5J7ZWiBtXEei3qblC+Ndwg20g+NfUYNs1GHUoM=
Date: Fri, 4 Sep 2026 17:07:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	stern@rowland.harvard.edu, stable@vger.kernel.org
Subject: Re: [PATCH] usb: storage: sierra_ms: reject short SWoC info transfers
Message-ID: <2026090452-appetizer-pacifist-57e5@gregkh>
References: <CAF4-o1c6XLbJr5umK+FRmMetcRkxH5JnRjMUpWw7OpnkUWbvVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF4-o1c6XLbJr5umK+FRmMetcRkxH5JnRjMUpWw7OpnkUWbvVQ@mail.gmail.com>

On Fri, Sep 04, 2026 at 07:52:59PM +0500, Syed Labeeq Sajid Bukhari wrote:
> sierra_get_swoc_info() requests sizeof(struct swoc_info) (60) bytes
> from the device via usb_control_msg(), but its callers only treat a
> negative return value as failure. A device that answers the
> vendor-specific GetSwocInfo request with a short IN transfer is
> therefore accepted, leaving the tail of the freshly allocated
> (kmalloc(), non-zeroing) swoc_info buffer uninitialized.
> 
> truinst_show() subsequently prints swocInfo->rev, swocInfo->LinuxSKU
> and swocInfo->LinuxVer from that buffer into the world-readable
> (0444) "truinst" sysfs attribute. An emulated/malicious USB device
> (VID 0x1199, PID 0x0fff) can exploit this to disclose up to 5 bytes
> of stale kernel heap memory (kmalloc-64) to unprivileged userspace,
> once per sysfs read, indefinitely. On kernels built without
> init_on_alloc this leaks recently freed heap contents.
> 
> Only accept the transfer when the full structure was received.
> sierra_ms_init() already retries failed queries, so well-behaved
> devices are unaffected.
> 
> Fixes: 32fe5e393455 ("USB Storage Sierra: TRU-Install feature update")
> Cc: stable@vger.kernel.org
> Signed-off-by: Syed Labeeq <syedlabeeq@gmail.com>

Did you forget an Assisted-by: tag?


> ---
>  drivers/usb/storage/sierra_ms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
> index 177fa6cd143ab2837640c26f8336781ddd3cf9cb..8755fda42eed2afd3235283e990a35aac14cb829
> 100644
> --- a/drivers/usb/storage/sierra_ms.c
> +++ b/drivers/usb/storage/sierra_ms.c
> @@ -76,6 +76,12 @@
>   (void *) swocInfo, /* void *data        */
>   sizeof(struct swoc_info), /* __u16 size     */
>   USB_CTRL_SET_TIMEOUT); /* int timeout     */
> + /*
> + * A short IN transfer leaves the tail of swocInfo uninitialized;
> + * only a full transfer is valid.
> + */
> + if (result != sizeof(struct swoc_info))
> + return -EIO;

This is corrupted and can not be applied :(

Also, are you sure the device will not send "short" data?  We've had
bugs in the past where we have added this type of check and it turned
out that it broke valid devices, so be careful.

Was this tested with a real device?

thanks,

greg k-h
