Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC1331ECC;
	Thu, 25 Jun 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399488; cv=none; b=CoSxAl7w9MQHZjHKo/Wi4Hxl9EAvrsvyQBdq/dvAvm7ry/Z0tCniyOTYFl6qMGWxwPfDurAjExCnkjKJMa0AMdtAYeIsrzhFQxDvAnB6yuuQq3AQRQkorIIszf9ytUYKx+LgjIbhTcZtHX7GampymjOOCVhPNbF9qDpfYC3Lqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399488; c=relaxed/simple;
	bh=pSb9HlCrDrSyzMM7xZNFv4Kr3g0QpIeruoin5cin0Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0vL4jZageepEEJaQavPVDn1Zq1kzfBKJInyC/c1QLdwvQwteoSQXHsAT/qU7ywYb2TEet08p9V6l7ga20ATrWMLvOac1UMk1c6jsRLQmXD8dVFm1/Xr7DFEN8qflWJ/IClxylnRDMhfQnESMG7snka1WhbCohhjEpmxZX0Fgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXrhJzBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXrhJzBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC04C1F000E9;
	Thu, 25 Jun 2026 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399487;
	bh=MNZWLCYE4VmycRO819/fu330j9HLVM2sZRLtKNHCeqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXrhJzBRb7Y255wkmBApyv01HkNQ9rk0oy7SBnqs6NdpMt5Ua0F2wEg9cOsFGmaK8
	 t7vhgvS+AHqSFqICcfnNNGns6SqCG7iIBcfQaXWmCMbQ4DwhZ0DMYm10y1R351fPfm
	 859XO0OoUz/+jpt8Vg2LqpzPGD+AFOWZVAgvt7WE=
Date: Thu, 25 Jun 2026 15:56:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: digi_acceleport: fix hard lockup on
 disconnect
Message-ID: <2026062550-facelift-happiness-7279@gregkh>
References: <20260623151110.315126-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623151110.315126-1-johan@kernel.org>

On Tue, Jun 23, 2026 at 05:11:10PM +0200, Johan Hovold wrote:
> If submitting the OOB write urb fails persistently (e.g if the device is
> being disconnected) the driver would loop indefinitely with interrupts
> disabled.
> 
> Check for urb submission errors when sending OOB commands to avoid
> hanging if, for example, open(), set_termios() or close() races with a
> physical disconnect.
> 
> This is issue was flagged by Sashiko when reviewing an unrelated change
> to the driver.
> 
> Link: https://sashiko.dev/#/patchset/20260610132232.356139-1-johan%40kernel.org?part=1
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
