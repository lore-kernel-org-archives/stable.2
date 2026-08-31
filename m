Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8030FF1D;
	Mon, 31 Aug 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170691; cv=none; b=F6lh5n8WlRww7p802rags2yix7S64lZSWCk75k5ic7r269zMUpR6z2BJVctUqZ+JxmPlMZ3XmMnNe8fDB2i38EvPfiymt9enUrryyzFOjATOxa8bkh5Y3Lvj+nsl8KHrw/Y994nF409/n4SbH7MlAuhXzw3JqyRBgb7RMFwufN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170691; c=relaxed/simple;
	bh=qRtxFABuXVR+lfXJle7mIINfLcyyQn2W0MSmLBiu0jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQWzqye5gt5l1bzlhAKDWfTDG8hJgNsTjuxu3RvxVH1YYa0EGq2UCcg1gi7QhkJK5kqS5rtRryoXOXcCQxPUI8mYig0ImoNpel8R8lFg4ixiNXaHhuJxuvHlYw99KVQ9iDDUv8ypZsTpkbyPaRMAWRDaEL+TbSQm8YNeXziuNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TfmGxr7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TfmGxr7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4163C1F000E9;
	Mon, 31 Aug 2026 10:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788170689;
	bh=m/Rc6H+Wu7UQgFEA5w/PiZ+tl8YoSd9dAGuLIERz6ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TfmGxr7VyuRAMWItPIuYvUlHv+4vddKh88bRd1/abi/oSyhG4p5YCVNQ4ePYXx5wM
	 xbmohvtiK0zZ2ThRaifyDtwZbBIjYpIPRQwBKwlUc/U0pQSpvqqpHXRW3JK5i2M5w5
	 zoYn8QmxuGpcCjmr9VaUTjmU4j/l/sZYuuc14bZE=
Date: Mon, 31 Aug 2026 12:04:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] usbip: usbip_host: fix null pointer dereference
 in rebind_store
Message-ID: <2026083141-morbidly-swiftness-9f8f@gregkh>
References: <20260811160541.29461-1-jeffinphilip14@gmail.com>
 <20260811160541.29461-2-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811160541.29461-2-jeffinphilip14@gmail.com>

On Tue, Aug 11, 2026 at 09:35:40PM +0530, Jeffin Philip wrote:
> rebind_store drops locks to execute do_rebind which sleeps
> during which time udev may become NULL due to physical disconnect.
> Since this cannot be prevented and spinlocks cannot be obtained
> in do_rebind, we turn towards the function that performs the
> same action, drivers_probe, safely. Remove rebind_store and print a
> warning to the user to use drivers_probe instead as a safer
> alternative.
> 
> Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
> Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
> Changes in v3:
>  - Addressed the race condition proposed by Greg KH in v2
>    discussion.
> Changes in v2:
>  - Addressed concerns raised by the Greg KH in v1 discussion
>    - Added usb_get_dev() to get a reference to udev preventing
>      it from becoming null after the null check. Drop the reference
>      after using it in do_rebind()
> v1:
>  - Initial patch with a udev null check that returns -ENODEV if udev
>    is null.
> ---
>  drivers/usb/usbip/stub_main.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index 79110a69d697..013f1563b1e9 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -242,32 +242,7 @@ static void stub_device_rebind(void)
>  static ssize_t rebind_store(struct device_driver *dev, const char *buf,
>  				 size_t count)
>  {
> -	int ret;
> -	int len;
> -	struct bus_id_priv *bid;
> -
> -	/* buf length should be less that BUSID_SIZE */
> -	len = strnlen(buf, BUSID_SIZE);
> -
> -	if (!(len < BUSID_SIZE))
> -		return -EINVAL;
> -
> -	bid = get_busid_priv(buf);
> -	if (!bid)
> -		return -ENODEV;
> -
> -	/* mark the device for deletion so probe ignores it during rescan */
> -	bid->status = STUB_BUSID_OTHER;
> -	/* release the busid lock */
> -	put_busid_priv(bid);
> -
> -	ret = do_rebind((char *) buf, bid);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* delete device from busid_table */
> -	del_match_busid((char *) buf);
> -
> +	pr_warn("rebind node is deprecated, consider using drivers_probe instead\n");

No one will ever notice this, just remove the sysfs file entirely if
you really think it is ok to remove the functionality.  That way
userspace will notice and handle it properly (hopefully...)

But, are you sure it is ok to remove this user/kernel api?  What about
workflows that are using it?

thanks,

greg k-h
