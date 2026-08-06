Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE2434E33
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057224; cv=none; b=EJwQbWXYzI41ip3i/WwjNrWqLcCwu31H8zZt1wB99uy7xZ+MangoUJ8mWSUvqR84sGh+7Flr+DnsCoW7zM8bOuvy3xe7lqPFR3tWvEL9N3Ut+VUt/3CAB4yqkLv9RduJWFwI2bghd0WNYsz3CP6xCP6n1dWudn31LmUM5hs3lEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057224; c=relaxed/simple;
	bh=I0wqDwZyoQSIsMb6537lKMySu1ARTn+0eN39hDtnsKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2DHH2wyKMd+hVUhv3j/yWNMOUEC69t8/0VLUoWDBjnmT18y3Pi09ZkGWtuNOTT0dc4irl0AXS0+bUq0nF6S5tslVDhd0CwOg4XG9qIyhU67mpUe4BP20OfxG2FJp3q8+j+W5yJFy7C8Eou6LuaBTeGnT4BfNJx949guonCk6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByvyTw1N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kIcrDmog; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByvyTw1N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kIcrDmog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786057220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/XyIJ0P1Ncw2ZC5RUbuOjY9InJ1Bze3sfj+kDZLJRI=;
	b=ByvyTw1N4MfMpMUK+t96yxbBqXKWefbzfGijHjLv7YxQQlixgy4L2VUEwNABGI9agKSNBa
	tZB2+7gw2o4wQG+/KMNWs7XSCSsGTxDkm8C/S6PbMTCbpqFLJm149P03wKNWRQFSFF4S5V
	2raOUtMTC1cmmaMv3URHB1naKWV/HO0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-QY-rjw1eOFy3ql6yqyEecQ-1; Thu, 06 Aug 2026 19:00:09 -0400
X-MC-Unique: QY-rjw1eOFy3ql6yqyEecQ-1
X-Mimecast-MFC-AGG-ID: QY-rjw1eOFy3ql6yqyEecQ_1786057208
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955d314945so14413625e9.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786057208; x=1786662008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V/XyIJ0P1Ncw2ZC5RUbuOjY9InJ1Bze3sfj+kDZLJRI=;
        b=kIcrDmogvSe+ZPn48xABRzkPuDHwWUGTaco7YvVvKSoUjcbTFtbviWBDZm8ZBogZsY
         sy4pG28HzFuw1gE+h7Ccaf8g/chQOCKEpFjzoAKjOumGrCG/4qouhRqcolR5LyKYRPzP
         Ov2z88E+oJyepXWiQ84+b8JvxMnMShQfMb7vnNIN7fhbJ/GTagZCljXFVvA+lzrfPpNl
         cj4mEytBrnKFdyKBX0RzAFsHUcHYVflwBay/9oAx7Ps/iaY2/0BK4ti7uIginI73WdiH
         1zUIZ58t4+7fLI/sQN1E8ztMBUEyzQ7Vp/47IGtwQgbQRpOyPmBLMO9GY+sQyYdIDSqB
         J1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786057208; x=1786662008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/XyIJ0P1Ncw2ZC5RUbuOjY9InJ1Bze3sfj+kDZLJRI=;
        b=e8qe/7FgPxhljLGGHGPUmP0M49SgiI+hHRy5Qzrb4+5ZN3OJ5TVZmyteNsp4m7e5js
         aTPZj/JYj9tSYuW4Kx45yMAG6sAP4lNeuQ+8LlO7BAcoQbPLF6B8nmexAbhYTKA1qhLc
         Dd3Gm7M4gyAhTimnnMg225A2iTYZejtn+yGPts81Txr4PxZK2b7LkD/nT3dfcmnYs42i
         YYMCVakatA2oolhl5vpIwrqLm4xiez8+oIIwpbPVh8MmeFp6x1o5a11eE/5ib3Hrubgk
         so2x1cOoedig1TbXLSgWspyvVqFuGoJDQGydSr+zwJLqmMW9prsXyScfLyepdYJvXRNe
         gyBg==
X-Forwarded-Encrypted: i=1; AHgh+RodwaxbmxlPl0D6Gu/+djmdb3jDMPk0sc1ZieCPAaXMjM1wBcDhR9c5sY2IZ0P+FTcp1+5wMbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4pcRtrBztA7vV5z34LZXTc6z+EYQmkGblWQvdT/pKUFrXB+EY
	2tu9YSkBf3MkjbsD6aFh9h6QYA/VvgpwK46x38jp22YrRnE9wOWRT4vRDQZ94mk5Q2MDTngcXmP
	EFuu1OrSVhZsC5G9SY0CylMM+hIzjVwgIjd3cCEYK/Z0g81rFm7WV1RcXlg==
X-Gm-Gg: AR+sD13/UgF+tINqfI5Z09K/3XtbUFN5hQ5IJt5KBASG0yMDqanisxdCliWR+riHA/q
	326R0tW+FTM5NnaTa94sE+MMgVkcs5Lp6FEDXetyQyVG/ZC9qJ6gi6Iy+4my1l/VjcNeii6z/df
	dViaWZlebpOCBj31LmLzMi9yQxnNOdsLw+OeTTsPhGKYnYi0zVwdDc5fZN8VPDlLx9Po7tXtbz8
	GOZwb1ylKUps669kZOmUwnplDuU7dVlBxHOF7heYNSYNQrsVi8z6tynapivorGrZxWNZcwzxt+I
	e98cOVhAe6zlrtPkg+OUEByhjUmkuyQoTiq09YRIOSHZ9EmbQJkjB9G2MPWzZUx2/ng4KqpL4oM
	2P5E2/jhxaBpJgRF7BX5B0w==
X-Received: by 2002:a05:600c:3b04:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-4994e7baa85mr237163445e9.12.1786057207636;
        Thu, 06 Aug 2026 16:00:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-4994e7baa85mr237162725e9.12.1786057207114;
        Thu, 06 Aug 2026 16:00:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995d85254asm1707125e9.1.2026.08.06.16.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:00:06 -0700 (PDT)
Date: Thu, 6 Aug 2026 19:00:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jiaqiyan@google.com,
	ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>,
	Taylor Scanlon <tayy@google.com>
Subject: Re: [RFC PATCH] virtio_balloon: add
 VIRTIO_BALLOON_F_REPORTING_PM_SAFE feature bit
Message-ID: <20260806185414-mutt-send-email-mst@kernel.org>
References: <20260724014605.3377283-1-linkl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724014605.3377283-1-linkl@google.com>

On Fri, Jul 24, 2026 at 01:46:05AM +0000, Link Lin wrote:
> Following up on the fix for the PM suspend Use-After-Free race condition in
> mm/page_reporting (merged in mm-hotfixes-unstable: 
> https://lore.kernel.org/all/20260723003650.CAAF01F000E9@smtp.kernel.org/), 
> we face a hypervisor-side deployment dilemma.
> 
> Cloud hypervisors want to safely enable the Free Page Reporting (FPR) 
> virtqueue across their fleets, but enabling it indiscriminately on guests 
> without the recent suspend fix exposes them to UAF crashes. Relying on 
> out-of-band metadata (e.g., OS image tags) to selectively enable the 
> feature is fragile for custom user images or live-patched kernels.
> 
> To address this at the protocol level, we propose adding a new feature bit 
> to the Virtio Specification: 
> VIRTIO_BALLOON_F_REPORTING_PM_SAFE (Bit 6)
> 
> This establishes a formal device lifecycle contract for power management:
> If negotiated, the driver MUST guarantee that all page reporting operations
> are halted and pending requests are flushed before the device/system
> transitions into a suspended state (e.g., ACPI S3/S4).


> Deployment semantics:
> - Hypervisors operating in a strict "safe mode" can offer Bit 6 exclusively 
>   (suppressing Bit 5 / VIRTIO_BALLOON_F_REPORTING).
> - Older, unpatched Linux guests will see Bit 5 is absent, ignore Bit 6, and 
>   safely skip FPR initialization, preventing the suspend crash. Standard
>   ballooning remains 100% functional.
> - Patched Linux guests will recognize Bit 6 and safely initialize FPR.
> - Note for fleet deployments: Non-Linux guests (e.g., Windows, FreeBSD) 
>   that rely on Bit 5 will temporarily lose FPR if the hypervisor exclusively 
>   offers Bit 6. This is considered an acceptable trade-off to globally 
>   protect unpatched guests without relying on OS image tags, until those 
>   respective virtio drivers adopt Bit 6.

This makes no sense to me. So there's a bug in the guest and it crashes.
Patch the guest.

There's just no chance we'll add flags every time some guest drivers
on some OSes have a UAF.

What makes this specific bug special?

Trust me when I say UAF issues e.g. around hotplug are a dime a dozen.
Now what, let's add another one around hotplug? And so on.

> 
> Implementation Note on Upstream/Downstream Dependencies:
> --------------------------------------------------------
> Because it is critical that downstream Linux distros do not accidentally 
> backport Bit 6 without the core MM UAF fix, the final upstream 
> implementation of this patch will enforce a strict compile-time dependency. 
> We plan to export a macro (e.g., PAGE_REPORTING_HAS_FREEZABLE_WQ) from the 
> core MM fix, and wrap Bit 6 behind an #ifdef of that macro in 
> virtio_balloon.c. This guarantees that compiler backports must consume the 
> entire dependency chain to advertise the feature.
> 
> Below is the proposed Linux proof-of-concept based on upstream master. We 
> introduce a helper virtio_balloon_has_reporting() to ensure virtqueues are 
> properly allocated, torn down, and validated if either bit is negotiated.
> 
> If this architectural approach is acceptable for cloud deployments, we will 
> formally submit this patch and open a corresponding issue for the OASIS 
> Virtio specification.
> 
> Depends-on: <Message-ID: 20260723003650.CAAF01F000E9@smtp.kernel.org>
> Signed-off-by: Link Lin <linkl@google.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 15 +++++++++++----
>  include/uapi/linux/virtio_balloon.h |  1 +
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 581ac799d9..00e8273dc3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -39,6 +39,12 @@
>  	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
>  #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
>  
> +static inline bool virtio_balloon_has_reporting(struct virtio_device *vdev)
> +{
> +	return virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING) ||
> +	       virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING_PM_SAFE);
> +}
> +
>  enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_INFLATE,
>  	VIRTIO_BALLOON_VQ_DEFLATE,
> @@ -598,7 +604,7 @@ static int init_vqs(struct virtio_balloon *vb)
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "free_page_vq";
>  
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +	if (virtio_balloon_has_reporting(vb->vdev)) {
>  		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].name = "reporting_vq";
>  		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
>  	}
> @@ -635,7 +641,7 @@ static int init_vqs(struct virtio_balloon *vb)
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
>  
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> +	if (virtio_balloon_has_reporting(vb->vdev))
>  		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
>  
>  	return 0;
> @@ -1013,7 +1019,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	}
>  
>  	vb->pr_dev_info.report = virtballoon_free_page_report;
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +	if (virtio_balloon_has_reporting(vb->vdev)) {
>  		unsigned int capacity;
>  
>  		capacity = virtqueue_get_vring_size(vb->reporting_vq);
> @@ -1099,7 +1105,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> +	if (virtio_balloon_has_reporting(vb->vdev))
>  		page_reporting_unregister(&vb->pr_dev_info);
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  		unregister_oom_notifier(&vb->oom_nb);
> @@ -1162,8 +1168,10 @@ static int virtballoon_validate(struct virtio_device *vdev)
>  	 */
>  	if (!want_init_on_free() && !page_poisoning_enabled_static())
>  		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> -	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
> +	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>  		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING_PM_SAFE);
> +	}
>  
>  	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  	return 0;
> @@ -1176,6 +1184,7 @@ static unsigned int features[] = {
>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  	VIRTIO_BALLOON_F_PAGE_POISON,
>  	VIRTIO_BALLOON_F_REPORTING,
> +	VIRTIO_BALLOON_F_REPORTING_PM_SAFE,
>  };
>  
>  static struct virtio_driver virtio_balloon_driver = {
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ee35a37280..d206f156d6 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_REPORTING_PM_SAFE	6 /* PM-safe page reporting */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> --

