Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F83DB64A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656045; cv=none; b=LsOAXOqPVwDGiUUAlFyAyS4SDM1T64wqFg8ZY8qdUFz46LT5p8CwYGObhhuzgriQEIwNVf9Q2xCgati6HrSoipHKrBjvNS2FwpeEHpt0nWkT+tGAHzzv/eVy3GU1vwOUNHd9oT8P9MQdpTaBP5y7CW4oB3LtdlGe0P8obOENepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656045; c=relaxed/simple;
	bh=FbsJrNLWRnA5FZelNcQumZAVr9SQGildHFWErfp7iE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMQLX/9319Jy7k6Jv8fgHY9S283yyUAjYTD2Bl//fYnW1nvvCZWlsIF9vpYoapu2SLoOBkAqjCaATnYgMkcW0i5p8NS8cT4QjYxeTbXgZNn7FwoXHSfxlIBFSdkb6p44JffpGWX9u0mdNfD1/VYJ0nDQQU7emAFyAtvyCmqNAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq6ZO6My; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq6ZO6My"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e7109321dso3336011a91.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787656043; x=1788260843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ygSmQPvZ/Nd116NGGtGNonu+zeK52756mGmLYMo4WT0=;
        b=Uq6ZO6My62FnBKE7nPkf5mwsA9naTz0tJPh9eaoazG5ZLko1o/HI/H6LzTDaHWpY0M
         heou2eemSfYbu5qUMgCWZsrXBZg5eUjkhnC6bVCg3H8TfDNcPX6gN8a0PgvkKIBpweWx
         0pShRP8GfFtFF9kPhowYheCgRJ1/DNR6T1pFvkURafpAeiQgIaa5VuuO7mAduZLbSxRY
         7HmMbTK84EB4z+w1xOGmAlyRrehCVqqMJyue0d/CljLGVNNJ+SrQe7Bg4TVIUr6qrTtm
         /WmJimHNGfblbd+2ZBndzXCGM3GQCV2TVs5nsKT0/mKtbMf9OmIkCnyiOaPSDlUQrUEn
         LBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787656043; x=1788260843;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ygSmQPvZ/Nd116NGGtGNonu+zeK52756mGmLYMo4WT0=;
        b=ssRAnTq+KR+6khvYu8jqY9G1yOExYMAoecQfAo/h+WW54GF7PQocsZu8dtn+1gfB2t
         9Yto0qdv0FinjcZtXpATlU/IBAD0BHJFlRaNfahvrkl3poQFwTyl2AyCVR0S3geukRrx
         V9I1nDC8EXn7rQ83R5rPHxIB+e+/4ijVvQNKxPSv4KZuud3K+jXEbpq3XQp5Q7lWcgxx
         OzvoHmFloeVll+Ecs7srzA0U2EMi9JW3vlo3U6Qru92uiX5pqpwdBtdKIFOfANok/l0A
         SBeqDY2+H6V7mQ1BNDsGdaN/1JuqP9TBOyKIUzdyUavUVZXQdbRLU1HpJupYYyHstO6v
         84VQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7pqbo/orA9+VXdn41J1Jp+gf1KWrF/rkmb0q2FM1edxsW/54mOvFCvbzDbh2sx5OseYTdugo=@vger.kernel.org
X-Gm-Message-State: AFuF++mWseQ/Q7XyhQo8JoXGx+ATiAru47tA1fWl5VSPNOf8Lvi1jHYc
	n8Pwf8EQY8jENHKAe9uB1oxzf3Ji5a8JBbt5BJTUqWQII4nVgWvUB5kd
X-Gm-Gg: AR+sD1238413ojWcerOcFKJ/TmmXP6gU0cNe0uZ8p3zJXHfoZ0ftDgs46ve1dgDASuI
	bdlokIz7TPVzBjgHhYZGyI+MgqEFNL56ACAa4dod9pmGLkfjOXAnED6IorjnYHQIamTMYn1Gjjb
	az76p1mcnJ5xJ3Nhqt5orHdFPdq6S40XK8gj+gast9dFMH8OpZMt1nqM+mXECzDYm3+qsg/nOg8
	jZmkphT+NNkljr96/NxzDtyRLyJ6ULSBNh1Sq++Ce22FjMwjNI8QfdAFHfDsaV+Ymd3VcByiUtC
	tEEazKbdPlZuukWokIPz+sPo1ehEiBPUQvUxebna2nfcLytx310D25Cwuk5fwkPD37Ojltfgg9C
	nCHLC28WeV8BUGZnvHSOiQ2kvgV2k+Pb5zOj4EuOf6GmB75R9yf3shfI+JA3FfPBHmzrkcf+jdB
	mFhWlJT4D2dxD79GhBxwQjg4esca+XPLIAK+FfUzFdEbwOKtJKyWz265nGY7CfFVyLTX55wNdbW
	QcoXIo7o9NogJYYtemaEM45PdlUOqArGiacouDuQYNx
X-Received: by 2002:a17:90b:2685:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-396465587c5mr11510630a91.14.1787656042512;
        Tue, 25 Aug 2026 04:07:22 -0700 (PDT)
Received: from localhost ([2409:40c4:101c:e5a9:a28f:e499:1b07:43b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d36f9sm54570232eec.16.2026.08.25.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 04:07:21 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:37:15 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: jjy600901@snu.ac.kr
Cc: brauner@kernel.org, eulgyukim@snu.ac.kr, gregkh@linuxfoundation.org, 
	jack@suse.cz, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mjguzik@gmail.com, stern@rowland.harvard.edu, 
	viro@zeniv.linux.org.uk, stable@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: fix NULL pointer dereference in
 gadget_dev_ioctl()
Message-ID: <ao128wxaVmFhhohL@eggarch>
References: <20260824113510.1141236-1-jjy600901@snu.ac.kr>
 <20260825105801.319997-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825105801.319997-1-lovekeshsolanki00@gmail.com>

On Tue, Aug 25, 2026 at 04:28:01PM +0530, Lovekesh Solanki wrote:
> gadget_dev_ioctl() reads dev->gadget outside the dev->lock, while
> gadgetfs_bind() writes it without holding the lock. A concurrent
> bind can update dev->gadget and dev->state under the lock while the
> ioctl thread holds a stale NULL copy, causing a NULL pointer
> dereference at offset 0x28 (gadget->ops->ioctl).
> 
> Read dev->gadget inside the locked region, before the state check,
> so the state and gadget pointer are always consistent.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Link: https://lore.kernel.org/all/20260824160022.2378192-1-jjy600901@snu.ac.kr/
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> Link: https://lore.kernel.org/all/20260824160022.2378192-1-jjy600901@snu.ac.kr/
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
> ---
>  drivers/usb/gadget/legacy/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index d87a8ab51510..e9f7d7c1a6a3 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1251,14 +1251,15 @@ ep0_poll (struct file *fd, poll_table *wait)
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
> -	} else if (gadget->ops->ioctl) {
> +	} else if (gadget && gadget->ops->ioctl) {
>  		++dev->udc_usage;
>  		spin_unlock_irq(&dev->lock);
>  
> -- 
> 2.55.0

Apologies, the Link tag is wrong, correct one is
https://lore.kernel.org/all/20260824113510.1141236-1-jjy600901@snu.ac.kr/
Should I send a v2 with fixed tag?

Regards,
Lovekesh
