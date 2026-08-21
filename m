Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800504CA273;
	Fri, 21 Aug 2026 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324416; cv=none; b=MHBLJYyseRqg20m2uABmAS5o229WGjg9u0QHqJtaayYSxpVxN4NI5rv7XqfTJT0tdjs5QEml6JU6r9Yt1doJ1PMovTITqU54Rr4R1Pwq/y2ASg4oMJXK3Vg4GLhdAe3HPUosJUwo+0gju03N9Tl+/WqarwSMfEKSWKenTntrODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324416; c=relaxed/simple;
	bh=SFvGAJY6M4OQwPrUyavzm7LqFN+y2KyaghjeHWtyQ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDoCToariWs/q5VTpq0mU63qZSWZqDV0mmy1vc7CMFetqKqioQul8E2ob4pmMx5z9a7ith2JCj1ZeKv6uHC00zVt1e9Q+LOvP/f5BAcZ+L1HYoq1AJLIkSs7fWpAZx37/1juywKsrxcldpAtRKz43IDPZOs41TW6SQh6ClF82+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=otJMwGxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="otJMwGxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773AD1F00A3A;
	Fri, 21 Aug 2026 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787324415;
	bh=6DjI4soCMIDwNqMTMWKQugO73OjvV4APG0EaDtiaXSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=otJMwGxLIuAz4nWAKdA0tCc066eNS+IlsOp1wcA58koPSYbWe7qvporUHbj9seBeR
	 gmCbivVPHMxMybR4WottAlNiZLIlpAElPBEakVDY3SPbSh+pIkyDtPT11dpCjl4fwE
	 Ww02zZPqTtbSgBG9kckNScAhCAb7fg6sLvzioQWs=
Date: Fri, 21 Aug 2026 17:00:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: heikki.krogerus@linux.intel.com, mika.westerberg@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+520d7648a0d934061fb0@syzkaller.appspotmail.com,
	syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix null-pointer-dereference in
 wcove_typec_probe()
Message-ID: <2026082125-getting-upstroke-a146@gregkh>
References: <20260821135246.17907-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821135246.17907-1-jeffinphilip14@gmail.com>

On Fri, Aug 21, 2026 at 07:22:46PM +0530, Jeffin Philip wrote:
> dev_get_drvdata() on the parent device can return NULL if we attempt to
> bind our device as a root device with no parent. This causes a null pointer
> dereference when accessing pmic->regmap later as pmic uses the parent
> struct. Fix this by adding a NULL check for pmic and returning -ENODEV
> if to_platform_device() returns NULL for pmic.
> 
> Reported-by: syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1a01783ea233350598b5
> Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
>  drivers/usb/typec/tcpm/wcove.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index 0e5a3e277c3e..80bca8edeba6 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -612,6 +612,10 @@ static int wcove_typec_probe(struct platform_device *pdev)
>  	int irq;
>  	int ret;
>  
> +	/* check if we have a parent device first */
> +	if (!pmic)
> +		return -ENODEV;

How can a platform device NOT have a parent device?  WHat system is this
broken in?  Why not fix the platform definition properly instead as
something is really wrong here if this is a "root" platform device as
that should never happen.

thanks,

greg k-h
