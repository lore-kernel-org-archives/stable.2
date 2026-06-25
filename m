Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572F2E7394;
	Thu, 25 Jun 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395884; cv=none; b=FZ4Do9VHEXTD5MWApe4RvmSt4DXKy2EW6+pEXJatmtfOaRAUhaWM4jodce2qTXHLFLWt72dpF6xnX+vbDyMIDwuPJVH+Kh4/i0WN5Qa34qDjiKPUcjWnurACNSvVLW2qQ8V/tCI4+F10GGCTNP7svAMnl1mHLoq8jHQayw2LL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395884; c=relaxed/simple;
	bh=WkpX74Apm5zS3j+opCUVdUTkZMu1z3vSVuewr0vE0WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxLjhtqkBrDeLN+SQQabYPjRSUmjee0jL9n4ak1KWMwZFeWBM6TaDPXB4t68MYjcYECWurRJ78tqvTXS4CspHSIBWXDvJRBB+T0d6oUulDXaoYM5uHsRA5Es2MCKGzGhLB9q8jA392LZ2S+R3UOAXEb2VdlrTTJBCg8H0EfFCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rXYrCJdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rXYrCJdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D751F000E9;
	Thu, 25 Jun 2026 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782395882;
	bh=tc+ZdzXRZteGRMtjR4CniifwuVl4SgWaauwfcCEypNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rXYrCJdyjnxpsIjwNB43it0OboJBvuFr+8wBU+n4wpKJm7PthsSxs3TNiqbzuPMio
	 MXr16C/loNOeILGs/+sQkc1Qt7p9YIRRZeCU+Sox80JuYSIEN9g9S1jCg51k3LDUOz
	 S4Z1x57qnuswWmB40dldCGZ7ldwZyTtFN85xzlOA=
Date: Thu, 25 Jun 2026 14:56:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <2026062551-irritably-monotype-a70b@gregkh>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623161035.5792-1-nikhilsolanke5@gmail.com>

On Tue, Jun 23, 2026 at 09:40:35PM +0530, Nikhil Solanke wrote:
> @@ -912,6 +915,13 @@ int usb_get_configuration(struct usb_device *dev)
>  	unsigned char *bigbuffer;
>  	struct usb_config_descriptor *desc;
>  	int result;
> +	/*
> +	 * Devices with quirky firmware will stall or reset when asked only for
> +	 * the configuration header. This variable decides which size to use in
> +	 * that case, if the quirk for that device was set.
> +	 */
> +	size_t usb_config_req_size = (dev->quirks & USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE)
> +		? USB_CONFIG_WINDOWS_REQ_SIZE : USB_DT_CONFIG_SIZE;

Please just use if () lines for code logic like this.  Don't abuse ?:
stuff as it's not needed.  Remember, we write code for people first,
compilers second, and in this case the compiler doesn't care either way
at all, but an if () line makes people much happier.

thanks,

greg k-h
