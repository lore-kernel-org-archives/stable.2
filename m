Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48748352000
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907787; cv=none; b=MVxPA4PX3K4LGNclBEThc1cEAa704l0rfp64Ljh8DsED9z1U5LpFgWpVSLvCumi4ItiqNUkASNlGWTsyP2VchOM4FGnY3mE9VoHxAV+BMY3q+klgSrJNxDxXIiRGfOqqFYrp1JI5s2jzwBTt+iCZxO1P8m61HIMDarPJpPJx85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907787; c=relaxed/simple;
	bh=tou1oMvJ+1xi7K5Ayg0UJnhYTWNqiNkGHykmQO0m2n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+m5v2HeSHYojaE8Le3MT7peEjPLqjgxMK38ocHdR7RcVt4sU+a1MkFO494/5bC2VzFmFiV3aYgvWdkSaqZQ1AO+yEze19Qzdbb/wO7Vx+E9fSS8AEGABQXXOVhBr9A1LsFak4/m/pu6TbvsmNPpvS5Y18k1eBFSf0eoNuk9zTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAZCjuFP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4klHWUk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAZCjuFP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4klHWUk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785907785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoYUbeJfzYbnY0HKD2boTZCl0qawjKDIX6lvEivFnzg=;
	b=EAZCjuFPkFVxooCq9VlZ1n2Q3+b9EVkL29Ha11zD+jNQsKHgteE0o5KO/kpcaJa/xM5Bj+
	d4g4Jfo2m4c4zAns7H0p05WRHqOljfKQwkricpVpbXrloU2tq0TIpvbCNXVZJWuJxyS8bg
	Ag8kaBjz8Rgk1Jj97ptwXSKSuAeou0M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-TBQOVFGeMtmFS0OGJhjwzg-1; Wed, 05 Aug 2026 01:29:34 -0400
X-MC-Unique: TBQOVFGeMtmFS0OGJhjwzg-1
X-Mimecast-MFC-AGG-ID: TBQOVFGeMtmFS0OGJhjwzg_1785907773
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b408a5c0so2813285e9.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785907773; x=1786512573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uoYUbeJfzYbnY0HKD2boTZCl0qawjKDIX6lvEivFnzg=;
        b=F4klHWUkTjotiyaingIojdFVQTtcNHO8RN/IOT4HnPc8C0ke4lw7BwYQWpprMhAMYO
         pPGv1FDg6EGW7hLPVFOKx3fjpkpR10YCSzd5ujjRRNKMIuBZNsIeUsXUQvR9t4+M6rGz
         6M2gFPcEDJyN+PaQKmqrlb/a8I3WL2b1Awof8VmgVuKwYJM0pgN4kw81k7Wep94TnyKv
         Wb3ZfYeJIZLXd4omCRjICr+wuXGeeeEMB/v3h/5YMURQRNAHtAlLwABoNUDuFO7qeaVx
         z/c+JQmPsblUCx0C6PegHv1/HyXpnH9Zj4YRYP1LPK434TjK2DIRW/VqXfbL42OL1p1P
         qzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785907773; x=1786512573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uoYUbeJfzYbnY0HKD2boTZCl0qawjKDIX6lvEivFnzg=;
        b=dqySSwXyJYlDMiULXI/encRcToaYXGg4UVP8//hoQr3HTUObH6l+ugrl+3gUtubPNX
         IG1SYX5yciM1/oBCTwofeEJs57pyEJtwR+ELXucDxPEeCZaJX2Nqhy4NKuodYbroq0pn
         ukKoWRW3Q/9fe/oO+FUqY/vbNxDfIJew/wh/1Dizmf8w3yGX0q3rCF7tU1jhyvL7Nk2b
         qXuRP9jmTbHFP7UbuOw0fdeI3YDeDBEgty9kjWxnbzV63ivY5jGfuep0Lqerg3XqOszD
         bhbwcNzGf4bPvJdqCw9q7lceIcOz1j2WiiTwtrlOPdmPlme/KSDxiimN5Nzd5qOtWIDy
         wV7g==
X-Forwarded-Encrypted: i=1; AHgh+RpJGDyBWiU+y2KqCh90M8o49LDHjcRIvxQhIfQWecYdS9uuznGLQ6jr5kbN/+nlCNYn0+pcG+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtZwSyJfPEX0o8UrEuwAe8lpBK8+yU4E9dn/Y0d6JzA03M+QO
	LnZwqAaqAbArJ4Sx+dwrLxuWy5wxBHpzB56GA7gqL5sR82o7a7e/DZfmCtBBpxLud7PwD8nCyBr
	I8HdH3aT863Ju/Shm4fF2KwJ//F1B1Ik3t9JikyFSR0YuqCMc95rlmA7XSw==
X-Gm-Gg: AR+sD13Tk59Se+u8GNIorskzH3Cc2aD76mufECX1FB+qax/OxS6mBObiFdNx7wfFxtd
	JOdhxzALp1e5fYxfVa+R6Vef++akiHjNAwvkVmh56alslv7ybAHoKq7KxeOLHNYwqXPyZSaEYp4
	eoVxz8zXHL2GfPe3AjXWVIPd72gK1RVu/G8SgPSLHazSosemLBpUY1kvggFZldPcmG4MAmChFGc
	O+WqFcTAE6lHb+hM6eL+fBZey2Y8m8NHWBtTiTXCqz2wdfswCyvdVzzp9/w6JxnUQEZ21qk29OQ
	BGdlBSsZvyi2qizFxMFg2iJxBo+KevtSq6FQtWTXZkhLHtNI+xREFFNMYd8cuoK2zPf923whPGf
	RC4Av53W5n824gAwNzrtnsA==
X-Received: by 2002:a05:600c:1d1f:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4994e71d2acmr37754705e9.5.1785907772751;
        Tue, 04 Aug 2026 22:29:32 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1f:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4994e71d2acmr37754275e9.5.1785907772318;
        Tue, 04 Aug 2026 22:29:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994df7e025sm63769205e9.0.2026.08.04.22.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:29:31 -0700 (PDT)
Date: Wed, 5 Aug 2026 01:29:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio_input: reset device if input_register_device()
 fails
Message-ID: <20260805012846-mutt-send-email-mst@kernel.org>
References: <20260805032931.1606652-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805032931.1606652-1-xiongweimin@kylinos.cn>

On Wed, Aug 05, 2026 at 11:29:31AM +0800, Xiong Weimin wrote:
> Probe marks the device DRIVER_OK with virtio_device_ready() before
> calling input_register_device(). If registration fails, the error path
> cleared vi->ready and called del_vqs() while the device was still live,
> so the device could keep DMA to queues that were already torn down.
> 
> Match remove/freeze: call virtio_reset_device() on that path before
> tearing down the virtqueues.
> 
> Fixes: 271c865161c5 ("Add virtio-input driver.")
> Cc: stable@vger.kernel.org



for each of these patches: is this a real or a theoretical issue?
stable rules preclude the later kind.

> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/virtio/virtio_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e..1a87be4c8 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -331,6 +331,7 @@ static int virtinput_probe(struct virtio_device *vdev)
>  	spin_lock_irqsave(&vi->lock, flags);
>  	vi->ready = false;
>  	spin_unlock_irqrestore(&vi->lock, flags);
> +	virtio_reset_device(vdev);
>  err_mt_init_slots:
>  	input_free_device(vi->idev);
>  err_input_alloc:
> -- 
> 2.43.0

