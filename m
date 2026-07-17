Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673921F4181
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279855; cv=none; b=suIzdmfE8KD0jQTpymD34QHl9p4kEp3BrwmBRjwtVVWoR0yhwJsALWVnelwC9eZQRZDb0X2cplIoqLqoYH6o3pTkuPImhf9DkSu/bsrZQRWte3kftWZpJxBp2niFGWHyz0W1Wqmw27h4FlM9ntjz1OIjQnvoncZlaQ2KWYfCQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279855; c=relaxed/simple;
	bh=TcvQs6F2v9EfyD3bmkH2ZJNuDwiXRYvlBdAb+UIR3+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOy7Oh7rpClyJueEut3ohGXqABm7dv0/ygLxfO1w4obxgLyj0AQ3txsikXnryPBtxNyxddjiWw1d0p+vF/+Vkv0YPvtkxRJ0WPQc1JAcQzhOtD3RfBWw+OcFL2ag4gZqfROotprgOXlRUij/Zdh0PK5W4V/dwGp+IxeFMy6V1kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWJf5kHi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw31evUp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWJf5kHi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw31evUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784279852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NW+VUNQqci5Qpk0bUufyRvpeFY5npnr0jdisr26TODw=;
	b=YWJf5kHiWN5WoCkd2UrgPPd5a9Xl2Js1pScz0Tgw3Wa6WZ1gHkHXbnlHvN7Z+AWGCtgVan
	VcDXPmZbXG3br8cvRQla+jCAFLCSbLat/9jG0MRzp5AydbxjikIj9qKRUNNVdyuADjj06m
	K534Ii9lhHWJ8k3HKmJtMl0IEXdWnMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-KhApwO3cN02Iv3mhy4XULQ-1; Fri, 17 Jul 2026 05:17:31 -0400
X-MC-Unique: KhApwO3cN02Iv3mhy4XULQ-1
X-Mimecast-MFC-AGG-ID: KhApwO3cN02Iv3mhy4XULQ_1784279850
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so57925915e9.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784279850; x=1784884650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NW+VUNQqci5Qpk0bUufyRvpeFY5npnr0jdisr26TODw=;
        b=Bw31evUpt2zyJu6ucFWAlcl5XXqkbur/EQRliO4KSQj45LA552iVnz1GSgQaSkEA8u
         ViZDJGX5kY3qIUGeH2G0pJbz6nJXwOTOuLQBV59Qv3dFinUomI4whyK6sMSU3daGk6Fo
         qCm/aG4k2ylVG+BxteuVQGTquQ5LabYrlcCXKUqOCJwHM1JjyS5A/+3VupKyQV8UTFhS
         UDqqA6Ee39xQ+XKtD1pSb4MJZMHBvC81QL+8aEaG7VyQs55kTJxBo8RgainblNRRhRLX
         ExRXalhlBgT3zGZiaC1ZwvRwGHfHESxaYJ3sa7opUAUXIN0fYBtyiBQYF59Yk83rJqvj
         o9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784279850; x=1784884650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NW+VUNQqci5Qpk0bUufyRvpeFY5npnr0jdisr26TODw=;
        b=hoSWO7aMqAXyCfi+uMrMvs4Xg0pzyDXuCfQ1VLyPCRuA5bnX/b+nKxX5uORc1TqkcK
         WC7etJrZzQAaVdr7kp6zQ+tZhWoBcXM4zEWdohCs2DH/d+HNDiqIGpMCCzhCfMt768LX
         WHImX/MrC6UGwCAyvQrdSLbdC/+tqtm3lgvjDuyM+UVEWYiJD7uDRARfh2RS/MKNDtLM
         aZ3mvJEwcnvCRIBZGQ5BmN3JGZDCqESGS6ACS+tcF0vZ+ug6pJPAJcIq3Gi40JpUOSL3
         I/kijOZ1GR09yDZcNiTTGVq1/qOL5Ko+7ijr95emacFCB0GrMiiM8obVQIBuyidvYGU6
         85Ow==
X-Forwarded-Encrypted: i=1; AHgh+RoGqTNHGjZwxILbVoigOk4Y0eo2EsmQGS980R4IeqJRnZjQ+xiHyq2NJB590reZiz72FP9rbFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vIY5mYKJ1WfFHzAm+vTHuAENtSrrnTiZLdcXLzNPkxo/QErB
	tN0hpYTQ/ZD+aZCUUzTjTp0MDMQcZUNueq23VYJQXjEQPCr7MZ8i2TRPAKOq8/kdRDXZaa7W036
	g3alvEtHYUxbE6cRGPlcSXkDGmI8mGbBuSH+T3FvzlFLUBUeqlpEnOVwsqg==
X-Gm-Gg: AfdE7ckvdNGt4H0eYaggvwlSK4Y3iunvAE3N4ragW7p4yEzXAOtg0toyA3CiPir8Rvh
	Yw1j1XiG/S2C/+l4qCYEfyCxvDsbcltrgKNezqgKVROEZ0J95OUSZHmUCFMkOt8BHpQl9IS1H6I
	EypQOVLVvyiMZJU0GgsltELflyxi1lDXYZooGIFzkEAOPuyd3WylUTecUFuZJ/XvjUTh99rVMG9
	Hk6Hc52M7sOvLy6QGl75v2zbXAmO/J9jYJmv+B5y07CSmtFpGEJ6V1n0FHPIAEZBbJinuz9VZbY
	Zu6OPODOTkvJMITuVDSRLZk5y2r5e8YZze8gAb5jiWWE9bEaMh35MJ71pcZ5i2MgFpGtF8u2R3w
	EYhegR5tN8OWc48XeJWgwaqLx
X-Received: by 2002:a05:600c:1c20:b0:493:e97b:3b9c with SMTP id 5b1f17b1804b1-4954b560583mr11786675e9.29.1784279849569;
        Fri, 17 Jul 2026 02:17:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1c20:b0:493:e97b:3b9c with SMTP id 5b1f17b1804b1-4954b560583mr11786175e9.29.1784279848835;
        Fri, 17 Jul 2026 02:17:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm34107625e9.12.2026.07.17.02.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:17:28 -0700 (PDT)
Date: Fri, 17 Jul 2026 05:17:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, Ammar Faizi <ammarfaizi2@openresty.com>,
	jiaqiyan@google.com, ahwilkins@google.com,
	Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: avoid shrinker execution during
 PM suspend
Message-ID: <20260717051241-mutt-send-email-mst@kernel.org>
References: <20260717002311.681748-1-linkl@google.com>
 <20260717002311.681748-3-linkl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717002311.681748-3-linkl@google.com>

On Fri, Jul 17, 2026 at 12:22:21AM +0000, Link Lin wrote:
> During PM freeze (e.g. S4 hibernation), virtballoon_freeze() calls
> remove_common() which resets the virtio device and deletes all virtqueues.
> However, the balloon shrinker remains registered with core MM.
> 
> If memory pressure occurs during S4 hibernation image creation/saving, MM
> invokes virtio_balloon_shrinker_scan(), which attempts to reclaim free
> pages. Although return_free_pages_to_mm() only frees pages back to MM,
> reclaiming free pages under memory pressure can trigger page reporting
> which might access the deleted reporting virtqueue if it is not yet
> frozen, or interact with other parts of the driver in a teardown state.


i feel this is the thing to fix then? not the freeing itself.

> 
> Avoid this by adding a `suspended` flag to `struct virtio_balloon`. Set
> this flag to true in virtballoon_freeze() and false in
> virtballoon_restore(). Check this flag in both shrinker callbacks (scan
> and count) and return 0 if the device is suspended, preventing any
> shrinker execution while virtqueues are deleted. Wrap the lockless reads
> in READ_ONCE() and writes in WRITE_ONCE() to prevent compiler
> optimization issues and KCSAN data race warnings.

so you prevented the warnings but did you fix the races? CB

> 
> Fixes: 71019de8219b ("virtio_balloon: Add free page hinting support")
> Cc: stable@vger.kernel.org
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Link Lin <linkl@google.com>
> ---
>  drivers/virtio/virtio_balloon.c | 49 +++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 088b3a0e6c..38e1166a64 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -68,6 +68,8 @@ struct virtio_balloon {
>  	/* Prevent updating balloon when it is being canceled. */
>  	spinlock_t stop_update_lock;
>  	bool stop_update;
> +	/* Prevent shrinker from running while device is suspended. */
> +	bool suspended;
>  	/* Bitmap to indicate if reading the related config fields are needed */
>  	unsigned long config_read_bitmap;
>  
> @@ -471,9 +473,9 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>  	return target - vb->num_pages;
>  }
>  
> -/* Gives back @num_to_return blocks of free pages to mm. */
> -static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
> -					     unsigned long num_to_return)
> +/* Helper: must be called with free_page_list_lock held */
> +static unsigned long __return_free_pages_to_mm(struct virtio_balloon *vb,
> +					       unsigned long num_to_return)
>  {
>  	unsigned long num_returned = 0;
>  	struct page *page, *next;
> @@ -481,8 +483,6 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  	if (unlikely(!num_to_return))
>  		return 0;
>  
> -	spin_lock_irq(&vb->free_page_list_lock);
> -
>  	list_for_each_entry_safe(page, next, &vb->free_page_list, lru) {
>  		list_del(&page->lru);
>  		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> @@ -490,11 +490,27 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  			break;
>  	}
>  	vb->num_free_page_blocks -= num_returned;
> -	spin_unlock_irq(&vb->free_page_list_lock);
>  
>  	return num_returned;
>  }
>  
> +/* Gives back @num_to_return blocks of free pages to mm. */
> +static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
> +					     unsigned long num_to_return)
> +{
> +	unsigned long ret;
> +
> +	spin_lock_irq(&vb->free_page_list_lock);
> +	if (vb->suspended) {
> +		spin_unlock_irq(&vb->free_page_list_lock);
> +		return 0;
> +	}
> +	ret = __return_free_pages_to_mm(vb, num_to_return);
> +	spin_unlock_irq(&vb->free_page_list_lock);
> +
> +	return ret;
> +}
> +
>  static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
>  {
>  	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> @@ -871,6 +887,9 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
>  {
>  	struct virtio_balloon *vb = shrinker->private_data;
>  
> +	if (READ_ONCE(vb->suspended))
> +		return 0;
> +

what if vb->suspended is set right here?

>  	return shrink_free_pages(vb, sc->nr_to_scan);
>  }
>  
> @@ -879,6 +898,9 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>  {
>  	struct virtio_balloon *vb = shrinker->private_data;
>  
> +	if (READ_ONCE(vb->suspended))
> +		return 0;
> +

or here?

>  	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>  }
>  
> @@ -1089,8 +1111,11 @@ static void remove_common(struct virtio_balloon *vb)
>  	update_balloon_size(vb);
>  
>  	/* There might be free pages that are being reported: release them. */
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> -		return_free_pages_to_mm(vb, ULONG_MAX);
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> +		spin_lock_irq(&vb->free_page_list_lock);
> +		__return_free_pages_to_mm(vb, ULONG_MAX);
> +		spin_unlock_irq(&vb->free_page_list_lock);

this is remove, taking locks seems futile - if something will acquire
the lock here, we will be in trouble.

> +	}

>  
>  	/* Now we reset the device so we can clean up the queues. */
>  	virtio_reset_device(vb->vdev);
> @@ -1133,6 +1158,10 @@ static int virtballoon_freeze(struct virtio_device *vdev)
>  	 * The workqueue is already frozen by the PM core before this
>  	 * function is called.
>  	 */
> +	spin_lock_irq(&vb->free_page_list_lock);
> +	WRITE_ONCE(vb->suspended, true);
> +	spin_unlock_irq(&vb->free_page_list_lock);
> +
>  	remove_common(vb);
>  	return 0;
>  }
> @@ -1148,6 +1177,10 @@ static int virtballoon_restore(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	spin_lock_irq(&vb->free_page_list_lock);
> +	WRITE_ONCE(vb->suspended, false);
> +	spin_unlock_irq(&vb->free_page_list_lock);
> +
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
>  	update_balloon_size(vb);
> -- 
> 2.55.0.229.g6434b31f56-goog

