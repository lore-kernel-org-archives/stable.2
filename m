Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14F2222D0
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681815; cv=none; b=KASnjqOjqpk39szfxz550Vw3Y5TT6P2Qsdn6mkFV8uHn8XwV+hGuSN+CKsQ6GxTTteRw6YsvfaMPTfKidAG4mEExw1V0c9iHvcmAPz2D3Lg9gpVMich7wnhcAwvuF31BVtZfomV4EbcdC380Co8LAZKWy3EMlqo5QBUAzE8/nYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681815; c=relaxed/simple;
	bh=prJxKKLTb4OJxv6UKEnT0NjRxLM+dLDHfdbUjkT4Y4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXmL1lNiyl+ydhsPEC06Y2Z1bCuzCFneIlq4+qWZ2MLGUBhYdtgD41IzweL7xgvsAUAxkKNr9KksMQrvR8DovKvveY5vvOmhH28eRl4oG0W2rYltrpOoy3ksj4FXkmjLhQpPT05+bfB9LUaPoojofSyA6rAwNqYWzomDjEM+Pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=aZtQRSsg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="aZtQRSsg"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9063b380982so1727806d6.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1787681813; x=1788286613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sFZRjz2wLY/AkBicQAOs86n2bj66y9AJ0vIklW2hwqM=;
        b=aZtQRSsgY0iINVMiZdpCmnWDAjfSibsDNh3y90FuOdIPxCk0weOdUZkEHIyIaYA+Nz
         lgRYi/J56VHlCxGeSJ/f4c/pHFp7RUJV30L4HN73ZOAc9tqrDd/0dS9cFtwYurXWMCSS
         /wXA2jSBdGJPkOjZZTHBFkvJntvXpHg/1g45ZB3wApRjrONV6r462tzRRlKJreXS6Tje
         IF2MqDtNZKX9eY0oVmjTGxGSBk1rTqvt+kNvAFS9NpR5Pa3hZ8RMYBWKR5jDbbw5mSi9
         /qU6ImPARGqLscyMP8JzPR3n5tZOcQWQub0H+OSx4eNhYRcrIP+1POlkvEMn4jceTiMx
         +lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681813; x=1788286613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFZRjz2wLY/AkBicQAOs86n2bj66y9AJ0vIklW2hwqM=;
        b=QGpKk9dCHfbcgsoSFQY7vo6WLEVxOJKm04DYRtyErQNESAgBt871Fp87+bWvzSpk/l
         Br08K+NZTqcUnvseFoItSLk/SUv+Xgi0zhM4qE68tykVWpCJof6jHnTzZYBqZ0LNPTEf
         eYgcPiJN4J4CV7GMi3Xhwvm2QvgaWnnEgd7Aw57AZ9BKAW7yGeyAxLckJDF+GhmPTA1S
         LJZsys/h4ty7DI4DQFDtScC0RoYRVkmEoW3tNynZLlVX8M4Ab4MXGnI7S1JybAIdk+jr
         48lZfbPgYUIqw9b0ireRh93fUjhdTg+xROpJPi+B08AqXbFi8t3gaJOrn+HX/jeG7kVI
         jzBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqUUrYMk/TxAnRuidk4E9vesv2vE9FWrpOHYiEjpQe8F1hvaYX168UW5JWWGBxPUE8g51fheI=@vger.kernel.org
X-Gm-Message-State: AFuF++kDfIGZr4w2OfEbWj+LNRX3bF4BSZxLqSyXSXlGc/2m5BWAVb2K
	Z6fylFLFxSOdrZohlNHpZ6oUOBg3wGp79bJyKRUU2GkudTnmQQVC0I/nObKzrgRHBw==
X-Gm-Gg: AR+sD12xx6YoMcwEupJ0Q0sX2UiHBHVuRiF6JQ1KKTnk7TqNH5dNq0Dx0huUww9FHAO
	lhh5/+7ahWXZaWXWasK3JKO/B2RSm3iIK+/CbFa0DEjZ2pEoeXrJBF9g5pgp2qlGAru+1ROYgjz
	7qd74887NcJInbW6dTtxO3dUh7GNM8mzReY23rz9JhAZ81xgyInBDNhETgeXbeEusApHlt8A9PH
	2FwgHs2V8h1OF3KolWD9/YBA0ka7pkYVJ0ne3JzvpmmT5q81NLO9zGdGEbCnQ4Uj+z4IWxAI0b6
	8fDJHs6Si2OIVqR7ZJBqXctzbh2P9E2gw1E8N5LmHFoCZwnfz5fKetfmTP0rOwVgNREwUzFsX7q
	zFVW/Y6pS6DtMO0uqvVURcXSRZpfp7/1eGkV4gpHg+SrNBc8PoJ2w2R6JPQth7b+LWNlsL4qc2V
	A6YdDIcnvS6I+5H0dcXuULDv1tuu6a7TAzdi04AX0yC1ZDZJg6gFKFMQIVfikT4g==
X-Received: by 2002:a05:620a:2981:b0:923:8612:f15 with SMTP id af79cd13be357-9378016ef19mr43282685a.18.1787681813128;
        Tue, 25 Aug 2026 11:16:53 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::dfd8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e6c2eefsm31617285a.46.2026.08.25.11.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:16:52 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:16:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: jjy600901@snu.ac.kr, brauner@kernel.org, eulgyukim@snu.ac.kr,
	gregkh@linuxfoundation.org, jack@suse.cz, kees@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mjguzik@gmail.com, viro@zeniv.linux.org.uk, stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: gadget: fix NULL pointer dereference in
 gadget_dev_ioctl()
Message-ID: <f25ef64e-0197-4d23-ab2d-9568bfd3711e@rowland.harvard.edu>
References: <20260825171343.459630-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825171343.459630-1-lovekeshsolanki00@gmail.com>

On Tue, Aug 25, 2026 at 10:43:43PM +0530, Lovekesh Solanki wrote:
> gadget_dev_ioctl() reads dev->gadget before acquiring dev->lock, but
> dev->state is checked after acquiring the lock. Therefore a concurrent
> bind can change the device state between these operations, which can
> leave ioctl with a stale NULL gadget pointer and causing a NULL pointer 
> dereference at gadget->ops->ioctl.
> 
> Read dev->gadget while holding dev->lock so that the gadget pointer
> and device state are sampled consistently.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Link: https://lore.kernel.org/all/20260824113510.1141236-1-jjy600901@snu.ac.kr/
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> Link: https://lore.kernel.org/all/20260824113510.1141236-1-jjy600901@snu.ac.kr/
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
> ---
> Changes in v2:
> - Fix Link tag pointing to wrong bug report.
> - Remove the unnecessary NULL check.
> - Reword commit message as per Alan's review.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/legacy/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index d87a8ab51510..12819e8c265d 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1251,10 +1251,11 @@ ep0_poll (struct file *fd, poll_table *wait)
>  static long gadget_dev_ioctl (struct file *fd, unsigned code, unsigned long value)
>  {
>  	struct dev_data		*dev = fd->private_data;
> -	struct usb_gadget	*gadget = dev->gadget;
> +	struct usb_gadget	*gadget;
>  	long ret = -ENOTTY;
>  
>  	spin_lock_irq(&dev->lock);
> +	gadget = dev->gadget;
>  	if (dev->state == STATE_DEV_OPENED ||
>  			dev->state == STATE_DEV_UNBOUND) {
>  		/* Not bound to a UDC */
> -- 
> 2.55.0
