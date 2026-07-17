Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCA3AEF53
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279875; cv=none; b=hWXgbHEaRRdDzPFIcwH91EDqBPtpsHLSRvk+l1GDmEUb63Y/5+3KEmFh4mT59evywzw3Pf+cJJqJ789Qc4PZ+0JisQIyaCwRz1YwECV8dtmXH3FMs8m3co4vdy1wyG4L0uvkM02qCvwLW8BkUGC74CRDA3vmT7+A8V35BsbugLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279875; c=relaxed/simple;
	bh=opKalTvfBSXyILj0RJsThfYwW8d3Q9Qy1589DrgLROI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZpy9+fm73788PBlH43W0FDjXRIW7bkjwFzoK6olalHjPXUuqsYZDVeEnuqpi0mgRrYQScAlrAjQfOvIK5EfU3WzdU28vONg+uaYVAYcbEY/weqR9IK63k2jEwjTGV1RRoVzCVeDFoWQGdEYW4D7HZ6xPF5n7T1T21gETe8XrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsfRQEQ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kjVlQJzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsfRQEQ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kjVlQJzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784279869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3388yjdx5mxv0Xwh51fsD72bz8HgdGVi3PgcMelqQI=;
	b=bsfRQEQ6IfwH0KlaGluGujcXxhPeUtlO+EglEhM3YPqk6QWuiBjHwriK4UJPsFGCaZBxoB
	z7Eu3qROQQlE1ty81+r+ouJHli4FRLmkNAVYuX/cbfrSMqWaQTDCKbFpVjq4tSIuL0Q80f
	2gI+QHIfsQ1xpXnD5U/ZIDEWh/Xs4yA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-cPVRFSGRMHCuvwa86gsm4w-1; Fri, 17 Jul 2026 05:17:48 -0400
X-MC-Unique: cPVRFSGRMHCuvwa86gsm4w-1
X-Mimecast-MFC-AGG-ID: cPVRFSGRMHCuvwa86gsm4w_1784279867
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4729d2a64efso798705f8f.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784279867; x=1784884667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3388yjdx5mxv0Xwh51fsD72bz8HgdGVi3PgcMelqQI=;
        b=kjVlQJzfcVkCLFkRTWkuOS8tp+jKbqJZvVN8UBxN21+LG3oUcZo0NzVRklg0t4rXP9
         oO+plIKenBe9wCM5nKosDkKW0lgRcRo2TDL0XI5XzQ1cSSbOF1DcODFtnR8RcCQ3MPfN
         qYJcZ6a5aBOTc6qmrQUxVNj4YGYt1ZiSCqpSDQHHoXegk9ktseCsHf8vt7kH1tAI0y4r
         dfc1GOXZSVkOD+PBOvoC/YY+NQkd6xF2Lh015cFiEb2Hi73RM+y6lhJiOVrSszhl0fTu
         ocVD+oQTt+aV6B5VAuG9l3Xsozt5zSbfW3zKKUIE7/3pijDjRCkZ5Eelvzn9bFhIm+H4
         rgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784279867; x=1784884667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3388yjdx5mxv0Xwh51fsD72bz8HgdGVi3PgcMelqQI=;
        b=HpglzMXfG4ztYM71vUIopM7nlPuLL2pmxyRE6+hn+oyi+U+R1jq+tUP3v/svtMDbEb
         wwEAi8Gzy42IDJu9Vc/IKqxZB/OKxgtBF+Eo2hQyKjC+MLKXDLTBgatOqZywWV/pQV1r
         fH4vHpPtxhwTPjSyz5c33q9fBPNo4dA/pfBI2VK50YlnYl0s3JC//3lVDIqC0qLQu/qJ
         LLrrzjh7cKnp2L1kuQlwgTpfXmsfgEC814kTwofS/FWyPZs/RuYduuAJg+1tT5JczNv0
         yRjwI/h8fH1uLlpVB6b4S8y8erY5R7haXdbMJxv/uh0Cc9rpMCsm74GP9Zj5NP7JSGAD
         BvZg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6txCyTC7KsXuNqQr7jayU1yTViF28TGQdOxCdJJA2VlG7O17Uorsb81vMZxV8yhbx4UizKVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypExTp6zD4nHg51ZFi1CJlpVRYCCHA2Ai9+UZXN0vuVVaDrgk
	62J3TzbN4KUBAcvYXWAUMgtyQ2MtT/W6hIt5ufS68TjbA5cA0w0lXywSn8VKF880pzkaPVCB8w+
	5V0nBCRmTopeiEL6pCdGdI2l6WGxzmzZg3UF8cHVPMUqbCTgcTb/g/0c65g==
X-Gm-Gg: AfdE7cnc4k1yvrm/nGKrX32xLiZjD2kSCV/xzyp18p846NsqQF67c6iSZTafruOWGP5
	sYllYnXYu5KXQSQUZJBFEvTd4B2EC3igbF8gssrJ/OH0+kagmMxLXRe4MrA9ybURAVKusDwBxDp
	rTaggLMbQ1zIlt5UtcvnPNMek0BJrgtkIktSJdpX2jv+kP8zVoJrFForUmdqfEW1Vddi9a3LKdU
	az8D7LBe92My/Gt3xPc3K76qZGtrTxMJIblkmxHuvdpx3IR6SwfKLoW1llN5Q7l44a+BtK2wQ+W
	hV3Jn33MB1PaejKwimv0DhmMR3ypQh/2lN9c36PZB/R6PXjRLFP8/+Uta9kxHQcXrTBTkad7VxM
	GvCRwwZ9Fb2vDvo7bSTL462ba
X-Received: by 2002:a05:600c:a210:b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-4954a341bcdmr11164645e9.18.1784279867141;
        Fri, 17 Jul 2026 02:17:47 -0700 (PDT)
X-Received: by 2002:a05:600c:a210:b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-4954a341bcdmr11164265e9.18.1784279866477;
        Fri, 17 Jul 2026 02:17:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm30866345e9.0.2026.07.17.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:17:46 -0700 (PDT)
Date: Fri, 17 Jul 2026 05:17:42 -0400
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
	stable@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/2] mm/page_reporting: use system_freezable_wq to fix
 UAF during suspend
Message-ID: <20260717051734-mutt-send-email-mst@kernel.org>
References: <20260717002311.681748-1-linkl@google.com>
 <20260717002311.681748-2-linkl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717002311.681748-2-linkl@google.com>

On Fri, Jul 17, 2026 at 12:22:20AM +0000, Link Lin wrote:
> During PM freeze (e.g. S3 suspend or S4 hibernation), device drivers like
> virtio_balloon reset their underlying virtio devices and delete their
> virtqueues via vdev->config->del_vqs().
> 
> However, page reporting work (page_reporting_process) was scheduled on
> the global system_wq. Because system_wq lacks the WQ_FREEZABLE flag, the
> PM freezer skips it, leaving page_reporting_process active during
> suspend. If pages are freed into the buddy allocator while suspending,
> page reporting invokes virtballoon_free_page_report() on deleted
> virtqueues:
> 
>     [  196.795226] general protection fault, probably for non-canonical address 0xaa1436fe70dae6df: 0000 [#1] SMP NOPTI
>     [  196.825967] Workqueue: events page_reporting_process
>     [  196.831038] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
>     [  196.927073] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
>     [  196.946943] page_reporting_process+0x370/0x4f0
> 
> Fix this by switching page reporting work to system_freezable_wq. This
> ensures that the PM freezer pauses page_reporting_process before device
> drivers destroy their reporting virtqueues.
> 
> This aligns with the driver's existing design. The comment in
> virtballoon_freeze() states:
>     /*
>      * The workqueue is already frozen by the PM core before this
>      * function is called.
>      */
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Link Lin <linkl@google.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  mm/page_reporting.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 7418f2e500..4dc6f4b852 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -80,7 +80,8 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
>  	 * now we are limiting this to running no more than once every
>  	 * couple of seconds.
>  	 */
> -	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +	queue_delayed_work(system_freezable_wq, &prdev->work,
> +			   PAGE_REPORTING_DELAY);
>  }
>  
>  /* notify prdev of free page reporting request */
> @@ -343,7 +344,8 @@ static void page_reporting_process(struct work_struct *work)
>  	 */
>  	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
>  	if (state == PAGE_REPORTING_REQUESTED)
> -		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +		queue_delayed_work(system_freezable_wq, &prdev->work,
> +				   PAGE_REPORTING_DELAY);
>  }
>  
>  static DEFINE_MUTEX(page_reporting_mutex);
> -- 
> 2.55.0.229.g6434b31f56-goog

