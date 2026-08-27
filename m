Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FA346E43;
	Thu, 27 Aug 2026 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806120; cv=none; b=lCQlREqZq83rPFJqjR5BwCXdUgQvgozY4stm609vEvcj6mrE5ZmAkIzgJmFwrzoRtu/DWsWd5zFxe5r1Gs1/389LgWt+xD4q4MsDMymTe5a0CoPMBzOlYu2UiQdoiNqwvkDTOqHv3a8RlbTugvx2rnp5eOzM/qeLab/0jEWorKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806120; c=relaxed/simple;
	bh=wKgxFytNw3ZM+KBhSPlNdjvetj1OVSp/cj1I8MvLbfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVbRoP3g1JsUOlTd1HjvXw8MyDLVer5CYq04gtW1jvnTzQEeRrGZPozZx0s+VeGQq8aKnWhnAPoMBATnN71ZW19X9UHpD4+iSVRvDGsiUEe17xYr/wE8GjdtaTnPwA0WuVFF6BwUq0MyoqaKY3m/1M8oRWWeGoo2AValMdh331g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=003ojOKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="003ojOKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEE31F000E9;
	Thu, 27 Aug 2026 04:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787806108;
	bh=8yg1ILjNntpTPiz0h5KBdGdpzTzsnWd1kPiVEaP2kFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=003ojOKLAolppnEV0se6b6gH8UzSTMu20pkhx4D7H67t+eW0x+0FGGl5ejm8iALlF
	 quxUxelWjO0F/Ruz+r6poOcx2AeWWTG2JwT8s8fXdxlauQNjVmNfB2mnkRQoTADQU9
	 B7zqJqzBD0g7vcCmcxmRGUSMV/cr2OVJoKtW0hOk=
Date: Thu, 27 Aug 2026 06:48:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shengzhuo Wei <me@cherr.cc>
Cc: sre@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org,
	Andras Domokos <andras.domokos@nokia.com>,
	Carlos Chinea <carlos.chinea@nokia.com>, stable@vger.kernel.org
Subject: Re: [PATCH] HSI: hsi_char: Fix use-after-free on device removal
Message-ID: <2026082727-hacker-flaky-2578@gregkh>
References: <20260827-hsi-char-uaf-v1-1-4f824216a541@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-hsi-char-uaf-v1-1-4f824216a541@cherr.cc>

On Thu, Aug 27, 2026 at 04:43:08AM +0800, Shengzhuo Wei wrote:
> hsc_open() stores a pointer to a channel embedded in the hsc_client_data
> in file->private_data, but hsc_remove() frees the whole hsc_client_data
> right after cdev_del(). If the HSI client device is removed while a
> channel is open, the next access from the file descriptor (a read, an
> ioctl or the final close) dereferences freed memory:
> 
> CPU0                                CPU1
> hsc_remove                          hsc_read
>   cdev_del(&cl_data->cdev);           channel->cl->rx_cfg ...
>   kfree(cl_data);                     // use after free
> 
> Fix it by tracking the hsc_client_data with a kref: each open file
> descriptor takes a reference, and hsc_remove() drops the initial one,
> so the object is freed only after the last descriptor is closed.
> 
> Fixes: 4e69fc22753f ("HSI: hsi_char: Add HSI char device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
>  drivers/hsi/clients/hsi_char.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hsi/clients/hsi_char.c b/drivers/hsi/clients/hsi_char.c
> index a31cc1466dd3ddf73762ce3d0213c96d64a190fd..479e5d6e94c8c03489464c4b39d81d697d104ce0 100644
> --- a/drivers/hsi/clients/hsi_char.c
> +++ b/drivers/hsi/clients/hsi_char.c
> @@ -96,6 +96,7 @@ struct hsc_channel {
>   * @usecnt: Use count for claiming the HSI port (mutex protected)
>   * @cl: Referece to the HSI client
>   * @channels: Array of channels accessible by the client
> + * @kref: Reference count for the client data lifetime
>   */
>  struct hsc_client_data {
>  	struct cdev		cdev;
> @@ -104,6 +105,7 @@ struct hsc_client_data {
>  	unsigned int		usecnt;
>  	struct hsi_client	*cl;
>  	struct hsc_channel	channels[HSC_DEVS];
> +	struct kref		kref;

You now have 2 reference counts for the same structure, which is not how
to handle this at all :(

Please either make the cdev be a pointer, or use the correct cdev api
for handling this type of common problem.

thanks,

greg k-h
