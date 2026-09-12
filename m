Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC83630AE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233755; cv=none; b=U2GH5XuuMjvzmxqo/UYjDhMvqm6rTEXRPtOE4ZEzeNOCv2zI5tAqkKszw+xpo5RM5lGSjj0k9+ruH6XTAErXbly5b5x9SIujss5lVEze4W0AJBi4KP/JwKwJN7CHY9+ZGW9ALqHoF03dtXpmY6QuxfB5K+tizoEyNJp6XMdthPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233755; c=relaxed/simple;
	bh=GEIa8yeTfBDKfm0+esAvYxmkhSG5yBhHVHX+Q2lvzg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnEilbiaoH6GxpenLzs2e0321YYqmR3ni7pqR/IORxi4H7j2/pEwqST2mG8LKb7qcV0uKoFCZG7lXzaf8RUorvuhuyb1UA2u8XnKIVpppFS+KnOn4doTDvK98aAERUw2wJQaiFfQ56kA3D1Wntw1Rl89BnnpABlAR0sW2Mniuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxm8wNB7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwRau+Xk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxm8wNB7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwRau+Xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789233753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDIk7QPciUhOZoKe2zZLtnCcqNHQ6ULI7Gtb5/oDKCk=;
	b=dxm8wNB7wM2bqGvvaCrkpSNdHlSK2gVPIlJE36EvNlLqpcQPrgOCjD9xhmuY3xOGyeJ9Rh
	KKoizG1Xy2VwtMCRj7Ns1T6+ZDNvL+7fxjkvuuoX7uJ/WkD6KBi1x9vmHAxAFvP2O8nnlZ
	zZpvyomi+o+Pu+Ojb8p/bZwInQ4WPck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-fRq4Q6xeNZG9Bdy13BpECQ-1; Sat, 12 Sep 2026 13:22:29 -0400
X-MC-Unique: fRq4Q6xeNZG9Bdy13BpECQ-1
X-Mimecast-MFC-AGG-ID: fRq4Q6xeNZG9Bdy13BpECQ_1789233748
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d156c917cso19627775e9.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789233748; x=1789838548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WDIk7QPciUhOZoKe2zZLtnCcqNHQ6ULI7Gtb5/oDKCk=;
        b=OwRau+XklKpcvKbmCFw7yeRi8vJFoKh1FPVfaBzWikOx0mwNwB/UoABzk11iQfWZpS
         7cGgsPH7e6EvM40aPFKMd3m34CDeOKM00OXd8Q/miP52O1ryfHUXS+FXQlG8Jz0FItPa
         fE6cit8GLxId7uMWvDijM3dlss64BzdjP0uaR5rdhfGsFgilf91QRkdS33mE3SNdPXbm
         RfL/JvM40t7mzFAtCByi7FRgm7yv2CRJ1x9CxOXQ3Uarnm5Ht2hbSEOIXGb+Dzeiw8vt
         5uy1BZp1VIJoqxLsh1FTfPMDPuvYz9YR8fxQn5CGyczn4I5Om7X72MFQTbj4RulcwZCF
         pGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789233748; x=1789838548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDIk7QPciUhOZoKe2zZLtnCcqNHQ6ULI7Gtb5/oDKCk=;
        b=XQFWki5dqsE0DklvZWZ0M5gXE9zanNjETPOmtqxAP4vxT5KStsLRu2gbmgMD95CuTB
         p7FHWFVB3JI1lYoDFd6JoGVKlnlxS4k2lTbF3H2MN9qcFcRKwfRq7mGD2qHSSJJ4tfIC
         j6EIvqJBAqoQcQEedlHcCa8rsEKYHU3OPcQqTZrmOa9m4Tkak9vRqhyzeJU2nM2PvZku
         Yj/Cenf3fSKaYVTAUYeg6cMIFZM97GtqhhhKezRJyw7KZjQAwQqn6/MghQaCl9BskdI2
         KWPjIHjE/xAyXwtQhyEjb2Y/Sg8iGEtHLdKpwtUwt+Hzs+xVFKeD9awKz8JArIt4zcZU
         5XDA==
X-Gm-Message-State: AFuF++lZ06S9wrOFmT4FYWGUtFbIQQMoQ+vQlXEkwuyu8zXQxvbz4wT4
	WOkJSO5zgoQg87x3ZsKkhZsVowvLfD2g+92EuC4be9GB4WklYUN4fcZeD3UjXnkx++EgdegrtYy
	KhegAMrMlvl3yP+YvBU4mVq1aMY/7SjT9xLBJ793f0gU2xoIM6iCI1xDV5T5X32FmsA==
X-Gm-Gg: AYBFou1e+Ct5bFTy3Psfsbb6BFowrngOu9ONdnYS5kdnGtqcBcVyPCfiedQnOHDkPnB
	8mcI/+fso1AMDjud8kugrynESVF0HBamsKtpIsL3vRh1zqw2mbffswlBDH7GpT0y4bbw5BnQg9d
	WGx2/EehOpg4gXPoGDvHBvBLEtTviy3MsRvU+4C36GjKyjRXUksXG03NbAxmQ58PfOwbEjdnI8P
	GKgUFeloH3z3Gqqy/DyQxcO9S9Y2IA5dXPd2Wj1km/A4LF66klBA4VvwWw3ywo8Iv0yfYRNV6XR
	CmxOJj+0ktv8RNy/8lXExtsOr4qlxgulqmaf5OLGIWdHc1BsChzv3SSjZ68D4+Ao+R8=
X-Received: by 2002:a05:600c:628f:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49e6b2a07c1mr49084665e9.0.1789233748323;
        Sat, 12 Sep 2026 10:22:28 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49e6b2a07c1mr49084445e9.0.1789233747833;
        Sat, 12 Sep 2026 10:22:27 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e706d0c1fsm56847975e9.1.2026.09.12.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 10:22:27 -0700 (PDT)
Date: Sat, 12 Sep 2026 13:22:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1069/1191] virtio_balloon: disable indirect
 descriptors
Message-ID: <20260912132127-mutt-send-email-mst@kernel.org>
References: <20260912065548.086904252@linuxfoundation.org>
 <20260912065612.183814840@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912065612.183814840@linuxfoundation.org>

On Sat, Sep 12, 2026 at 09:03:17AM +0200, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Michael S. Tsirkin <mst@redhat.com>
> 
> [ Upstream commit 281eb4732aae5473141b84e106fe906c69b2ff3d ]
> 
> The page reporting callback submits an sg list to the reporting
> virtqueue.  With VIRTIO_RING_F_INDIRECT_DESC negotiated and
> total_sg > 1 (which it typically is), virtqueue_add reports it to the
> host by allocating an indirect descriptor via kmalloc(GFP_KERNEL).
> 
> This is not pretty: the reporting worker isolates potentially hundreds
> of MB of free pages from the buddy allocator (reported pages are at
> least pageblock_order, and the sg can contain up to
> PAGE_REPORTING_CAPACITY entries of varying orders).  As the result,
> very theoretically, the kmalloc might trigger OOM when we have in fact a
> ton of free memory.
> 
> Clear VIRTIO_RING_F_INDIRECT_DESC, to avoid using indirect descriptors.
> 
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> Assisted-by: Claude:claude-opus-4-6
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <73fac8a629fd9aca7bb3265ac243a769c28af25d.1783232420.git.mst@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

this is, as the patch description says, theoretical.
Doesn't that make it ineligible for stable?

> ---
>  drivers/virtio/virtio_balloon.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 41fa694d82577..e9abd958f69e3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/virtio.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/virtio_balloon.h>
>  #include <linux/swap.h>
>  #include <linux/workqueue.h>
> @@ -1095,6 +1096,11 @@ static int virtballoon_validate(struct virtio_device *vdev)
>  	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
>  		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
>  
> +	/*
> +	 * Disable indirect descriptors to avoid memory allocation in
> +	 * virtqueue_add during page reporting.
> +	 */
> +	__virtio_clear_bit(vdev, VIRTIO_RING_F_INDIRECT_DESC);
>  	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  	return 0;
>  }
> -- 
> 2.53.0
> 
> 

