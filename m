Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5C37416F;
	Wed, 14 Oct 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954005; cv=none; b=sjq6pI4Zceo2mTrdd0Df+KVIGy0YGUrqGo/UgYD8qKNEYXhOx8kfcwlrPpdI2VimIc8/M5RhHv/rqPMQSdgHjOGJrzyg2ALXYyz0lPT0sGxa29JFaIE+xz74gdQKYEOHv8LOZ5ZPHL06QDpY7fuRRaMNatHcbgjuy4DpG0X+I/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954005; c=relaxed/simple;
	bh=KU+EoPX+Yq88Up8AkRMKYmhG8QzaJM6I9m0xF3TnhFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOL/fJqv1xeuPRWnO9rWQNvEJmgir9ocSL4RWn4oBsDMlAXQ1SCuWvUa4eLqoBJ/COUD5h5Jn4Bod6XlLcZq+6gzk5aooteyL9VmCVGwUKMUjCNCED0n3ZKdxHV8Sya9CoC9TLVJ6bLI3al4R+/MVtz+XFRJbOnyGz/4CS6TfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bh7NTVYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bh7NTVYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0DD1F000FF;
	Wed, 14 Oct 2026 05:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791954004;
	bh=fXIs9ekj66ZBix1q9Z5865T/YtxWnwsc1T6fGlLjdAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bh7NTVYCZWWamxV4NFgqwYbcstOplbNhbTswoLkfXrPg0GGMCOiSjqnGIhJagdTXG
	 Xbk/DeHIk8kUqT17fvi1Z+l5KyN9l5nEUg1JTV+ZsuM16GQ0jaHuuVQXB53Nx5KpHs
	 qcQ14cKrWLrHTmWXjUN+o4N5GH0W8E/hnBx1IcIY=
Date: Wed, 14 Oct 2026 07:00:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
	usb-storage@lists.one-eyed-alien.net, stable@vger.kernel.org
Subject: Re: [PATCH] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
Message-ID: <2026101442-slacker-hypocrite-33b5@gregkh>
References: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>

On Wed, Oct 14, 2026 at 12:19:44AM +0200, Olivier Kaloudoff wrote:
> diff --git a/drivers/usb/storage/uas-detect.h b/drivers/usb/storage/uas-detect.h
> index 4d3b49e5b87a..f0d9748b0194 100644
> --- a/drivers/usb/storage/uas-detect.h
> +++ b/drivers/usb/storage/uas-detect.h
> @@ -78,6 +78,8 @@ static int uas_use_uas_driver(struct usb_interface *intf,
>  	 * ASM1051 - with broken (*) uas support
>  	 * ASM1053 - with working uas support, but problems with large xfers
>  	 * ASM1153 - with working uas support
> + * ASMT135x - broken uas support, shares the ASM1153 MaxPower == 0
> + *            signature, identify it by its product string
>  	 *
>  	 * Devices with these chips re-use a number of device-ids over the
>  	 * entire line, so the device-id is useless to determine if we're

Please always check your patches before sending them out :(

thanks,

greg k-h
