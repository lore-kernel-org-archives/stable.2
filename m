Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094006;
	b=2eTwscDFKzvU5Qwp0GPNKahf42vF2H1Ji0HOwft/br7O/dlI0LEmzI6mPBlXaiDGPrYu
	 Wfuv72lPV+txJDFQuV5jzaiN8smBpY88fFPQHep9D8TiAXynTa1z6mhLT831Cog1moHoi
	 b86VXfyRMnb4CUN6A+XUYWab4O7ICi+DxTklT2yrK66S/wQW2xdz4v3ndnpuquUZMMDB+
	 a6wG+KYAImkvhwAZ9KymfC5uGa/JIKbhy5/VMv9NC9XKZeK3vzAlrg0nmY3PgqK+m3o4k
	 OcyvJMoMqGBK0QKa0ytvt6LXVMiBtQkC8UQFRr+xEXyZi8b8xWzJAxbUU0ddxEJaKXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094006;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aKEt6iULzL7jMnjmqye7t+qfKz7cYWw/RMaonjxYMlY=;
	b=ALFSHXozI2YWJi/XWzBNT0Es54ENwZMM7E88IGUT2dmnH22dJ5/yPDTeWM39x9spOMj5
	 xYgPQDxnrtAkiP1N38Q9CIxzvpjrZ79cJUC0AR4CIGhxwFB2NmnKAUOmcy0KNHC2k1gJW
	 vCZRplRw3oHDIidUtiCg8EksDTZa8dKL+DLF3YzEy82ivwMnon+TEXV+TDRUCHa5BYGP3
	 4IWYIsP99iB2NQbVDYM111wJ9YsLhjvmkL/YjVG05FpDHk8i+43Ik69PrIw34XQ+ThxCc
	 7iePX/UIMcQmwokuxfcg+XQgy9liDASXj59pfYHYK6LFSaXDcj5bXjt48eSNg6wOASQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HPQgxrGB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB21606A320;
	Thu, 19 Nov 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HPQgxrGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24B71F000C6;
	Thu, 19 Nov 2026 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795094006;
	bh=aKEt6iULzL7jMnjmqye7t+qfKz7cYWw/RMaonjxYMlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HPQgxrGBiOe92moUwB3EHNM8T7v64WbWYJzpxi5p0+IK9+0dYAl/a0q5lczeOoONd
	 VuGzruE84WW15Pd75s4CrNQHswFrFHWQvqFzIWL+Cz9T65+mRnz7/jLIu+708zkZv8
	 ESkE77vMIHEdkJWJpAWsJuCIv5VYdL3D+G4epXOU=
Date: Thu, 19 Nov 2026 14:13:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Guido Kiener <guido@kiener-muenchen.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: usbtmc: reject a short READ_STATUS_BYTE control
 transfer
Message-ID: <2026111913-hulk-attempt-905f@gregkh>
References: <20261119083959.1599898-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119083959.1599898-1-hj351016@gmail.com>

On Thu, Nov 19, 2026 at 05:39:59PM +0900, Hyunjung Ko wrote:
> usbtmc_get_stb() asks the device for three bytes of the READ_STATUS_BYTE
> response into a kmalloc()'d buffer and only checks that usb_control_msg()
> did not fail:
> 
> 	buffer = kmalloc(8, GFP_KERNEL);
> 	...
> 	rv = usb_control_msg(..., buffer, 0x03, USB_CTRL_GET_TIMEOUT);
> 	if (rv < 0)
> 		goto exit;
> 
> usb_control_msg() returns the number of bytes actually transferred,
> which a device is free to make shorter than the three that were
> requested.  When the interface has no interrupt-in endpoint the status
> byte is then taken straight from the third byte:
> 
> 	*stb = buffer[2];
> 
> and the caller hands it to user space with put_user() from
> USBTMC488_IOCTL_READ_STB and USBTMC_IOCTL_GET_SRQ_STB.  A device that
> answers with one or two bytes - with the first byte set to
> USBTMC_STATUS_SUCCESS so the status check passes - therefore leaks one
> byte of uninitialised kmalloc memory to user space.  Both conditions are
> under the device's control, since it also decides whether to expose an
> interrupt-in endpoint.
> 
> The same leak was fixed once before in this driver: usbtmc_ioctl_request()
> bounds its copy_to_user() to the number of bytes usb_control_msg() reported
> instead of the number requested.  usbtmc_get_stb() cannot be fixed that way
> because it reads a fixed offset, so reject the transfer unless all three
> bytes arrived, matching what usbtmc488_ioctl_simple() already does for its
> own one-byte request.
> 
> The check is not limited to the branch that reads buffer[2]: buffer[0] is
> consumed on both paths, so a short response leaves the status check itself
> reading uninitialised memory.  USBTMC-USB488 4.3.1 requires the three-byte
> response, so a device that sends fewer is not conforming either way.
> 
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> Cc: stable@vger.kernel.org

This is a "fun" one in that LLMs keep tripping over it, and they
generate a patch that is usually wrong, like this one.

Be very careful here, and test your changes with a real device please.

thanks,

greg k-h
