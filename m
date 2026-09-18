Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D1492E4C;
	Fri, 18 Sep 2026 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714144; cv=none; b=mQl1Di1OMioJKGw0O6g8dwaANWg9E9TzvwB4OoH01c3zfE0KqvfiJr6lL1k72S07OyzJkKYzLZzKTpCcs/jQH3RywuIDTUWtN2a6wqek/fZjE3u/p9ZnTa2sGCdUZGZYGhVs18v4vSeHwrDOv8ZS2Hyd/kYlTzUz5y3qA6+rHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714144; c=relaxed/simple;
	bh=tuU1lXMsg9djY1oxn8933Ds5iRxx2Vj+bmS2YhlXJ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXiGJITSp7JUojVhUTzXfvT1SLY6/UlVRJ4tZIcEbzEi62dXEy4DGMLXcNTdaNvQiy4MUAp9+57N8Fjmb1JQ7LClhpJmXwcIcKxBNn3TsLPSr0CbefTIvrCBntSqESoQnl1+PjW1v2ib9NRqPDsqEs3DFgI5Wcyo/0SWZ/CpyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqH+BA09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqH+BA09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359E1F000FF;
	Fri, 18 Sep 2026 06:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789714130;
	bh=siSsbdpVckye/huWju2E+o7+979Fs1UQ0XHbTLmIK9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WqH+BA09dzutR6fAUf9ksNVrVt5pJz800N/NlZO45rpZuTmitCi0JnqLkFgiIOkOw
	 kDodXsqjZM9xmDRV6cjoUXuc1pMJvEBW9lPBEnhrUq8uLe256+uEFvskCT9umvmJ/E
	 xchCM4MfG5GoKVWDlzRdqShADBPbDPKJOZwWopE94osqilJ61VFbJtffz0Zn3lU8Ny
	 DuYcq+tcFGkrbcUqLFP8Os8JjXt4Tc2fXp8lgSI85EtCUQ5Rjl8C8l+wORb26Hp17p
	 3nj86Lv9ZeCfnOWCyzIUzX16snQQyTl/A0KXNMdYh6M87CUI3WGne1rv6IEnHSURTC
	 YeOaU1BiQVAGA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x7SOu-000000003p3-15t9;
	Fri, 18 Sep 2026 08:48:48 +0200
Date: Fri, 18 Sep 2026 08:48:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, oneukum@suse.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdc-acm: Fix urb reference leak in acm_resume()
Message-ID: <aqze0EBONnOb2gNF@hovoldconsulting.com>
References: <20260917161217.2161883-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917161217.2161883-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 04:12:17PM +0000, Wentao Liang wrote:
> acm_resume() takes the delayed write urbs from the acm->delayed anchor
> with usb_get_from_anchor(), which hands the reference held by the
> anchor over to the caller. That reference is never released, so an urb
> that was queued while the device was suspended is never freed.
> 
> Drop the reference after the urb has been resubmitted.
> 
> Fixes: 140cb81ac8c6 ("USB: cdc-acm: fix broken runtime suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/class/cdc-acm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 54059e4fc6ed..399c42b58cfc 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1703,6 +1703,7 @@ static int acm_resume(struct usb_interface *intf)
>  				break;
>  
>  			acm_start_wb(acm, urb->context);
> +			usb_free_urb(urb);

Since this isn't dropping the reference taken at allocation I guess you
should be using usb_put_urb().

You should also fix the delayed urb handling in acm_port_shutdown()
added by the same commit.

And again, how was this found and fixed?

Johan
