Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06CA30D40F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035478; cv=none; b=ceXJuy+ii/EEOVMgllS4MmmaJVkDa+bQHv1TTRnmONbwIfqemvpib9sEkYqoL4lowWPnCnqjRjjmcVZCE1ye9rCTDXWDYKM85PiD0DQYII9nPauKWxTDA9mcIhiFDDt4OG2pHPmHfoHLWPkh6KbqrQZLlcNonZKLUrFDPN+4+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035478; c=relaxed/simple;
	bh=9l3q0B/E0FjBFxb2LJmMKlw9pl5hcTfSNOB811iBgVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwpoemSkHMoqr6VxeVX5KOZHlCLovF5uUXqp6wsGxFIWoORx3Q/kQe8PQqHgoCS+QYFdugAU1J/JbXXFWuc8YJHITow98aQNRpRuiR7eHIqd2TVTvPoKfpLtq0krPOq9Q9gtF8ycVRm18A0nglUwVfPu0DG86YBEJ94y+D3bXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCY38rmv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuUMXQnM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCY38rmv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuUMXQnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784035475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CpLHRy6/20YstfcDyrkyOratDSzuro/7QBC+7w5m58=;
	b=WCY38rmviGa2bbBEX5YlQWLXF2Fl9FLA5/DapYBxPGvwKdGg6UJaY7lfns7Acj1/icljnU
	7o3Tk1hesyal+0FnKZ6N/zMec4BiTXuRS2HGf5Xx2jcPxNnSXCfY25dFo0zg6PKvyRVzIt
	zUk0A8+320F31s2maTr95haWDsVexpQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-yM5evj-fMnua2rEhdLf3bQ-1; Tue, 14 Jul 2026 09:24:34 -0400
X-MC-Unique: yM5evj-fMnua2rEhdLf3bQ-1
X-Mimecast-MFC-AGG-ID: yM5evj-fMnua2rEhdLf3bQ_1784035473
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso20837815e9.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784035473; x=1784640273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8CpLHRy6/20YstfcDyrkyOratDSzuro/7QBC+7w5m58=;
        b=LuUMXQnMaB2m16c1eityl/8mmNpZ6/tmGg5sfaAVj3WUSsqj7rnGzwxLuI44FXaB/Q
         nLnGqtwF2GgsTfFN+WLPM4B9FFbXm/mxUQsdJrPcGnJ6/dL34qDCHaoIcRcoMEB0ZgqR
         /SdqCEiY0bu7XdgOgo6iJqfF+EYXbDPDNHPwT9T7l4PBVJzxr96/MivphgrPNB5jpskq
         h9zyvphH4+sJcRX1uvp1nPlOZz+GLn7tkhU+UvioBA4eBoK1hs/AHDBSgCEB5G4+pCdH
         vJDakUDOIXnSIst4imsYpuyEemCuB8N20hTVc0LzRQBuiwnuuTv7b+WrEG9GjvYulNKI
         Z58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035473; x=1784640273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CpLHRy6/20YstfcDyrkyOratDSzuro/7QBC+7w5m58=;
        b=SbUtqatBXoqDspA8zDGa+cADvzySxd41g85xVrWIBhM4f1a/36fG7D6a0Jg/cgoqvk
         5K+NjgvFz36Imz0DJYd2o9sygKKMGv3Me+r+K5BICkcTf8ccz+agOqeCdJB++fRS97qF
         d0zBukpIkSy1pU1qzpg0bBXlXWu5JIETf/acRHAr5FKtQePW2JMFP9EKw/MLZJ0PQlNI
         qeXDRw3JisR6Af4ULVa5KORtgNlVU9jixoXTnXCMLdqM2GTwUxeh9A7y270MV6HctL5F
         0AK6qxRt0tEsO51Q+KpGMXqUmYXZ21THRAB3DRE1nHOMhYGntLW3Zhz06HXoetwMx1Or
         T+mA==
X-Forwarded-Encrypted: i=1; AHgh+RqoW0Hx7Vhl/mHEwQ1kNegv3RcjgZ77RGM4yzSR5lX56LV3p4ZjdE1rwH5k+NZhuXAn7mRcZq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLmdP6uhSyZBY3mOAKDSFI0IxwkEraAEg1E7PDtzrDVdF/Y3f
	JWxxOldZg0UkoRsudwUY3C4o8bqXxs0Hq+mc9wmM46YaTy5loSYpG0rstMGsvVUUDUAvFYNcI3G
	Xsup6XvBX0NuRj8m/oQV7sKpKAVZYGnd8cksIQOT7aHxteqp7cVB2wkR+ng==
X-Gm-Gg: AfdE7cngerky4zgGub3aYShssCmbabgEPG3tFAutMJddSD0bnEOv3SVMgkvweY7z3XD
	TTc56XdXzsyHbVp7rND9kW9zMDahJLqQPD38Kw6UVslYYZlMdIyAcn6eihoSdxP0XU57zx5o4mf
	9DaoWQmB8/AbSjMhvyM14C8tDGI5bw9wM52ltL9PDGQBl/ADhJ0IhKRQAfehfJaD8lvz8BRyybK
	B0xNVZc6jauwbYpiZXFLSmkdrSNzemEUae5+aJiayZxSQUZlbTr2NDHcrRTIsmVt5NSWo58Z5qH
	i5M65XUluH9R/ZkauTCKfzYa3p+gAPm45xclZ/0CWBYectmKLzciqXwDPYBHJJ47i8pd+ohI/p/
	GQSUy3+c9RIFHMEQDDFFt8zhrLfqw3OWm/lg=
X-Received: by 2002:a05:600c:699a:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-495389bcc5bmr25894955e9.20.1784035472826;
        Tue, 14 Jul 2026 06:24:32 -0700 (PDT)
X-Received: by 2002:a05:600c:699a:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-495389bcc5bmr25894565e9.20.1784035472269;
        Tue, 14 Jul 2026 06:24:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm86514755e9.13.2026.07.14.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:24:31 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:24:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Link Lin <linkl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, Ammar Faizi <ammarfaizi2@openresty.com>,
	jiaqiyan@google.com, ahwilkins@google.com,
	Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting
 during PM freeze
Message-ID: <20260714092146-mutt-send-email-mst@kernel.org>
References: <20260709224330.946683-1-linkl@google.com>
 <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>

On Tue, Jul 14, 2026 at 03:17:42PM +0200, David Hildenbrand (Arm) wrote:
> On 7/10/26 00:43, Link Lin wrote:
> > During system power management freeze (e.g. ACPI S3 suspend or S4
> > hibernation), virtballoon_freeze() calls remove_common() to reset the
> > virtio device and delete all virtqueues via vdev->config->del_vqs().
> > However, unlike virtballoon_remove(), virtballoon_freeze() fails to call
> > page_reporting_unregister(&vb->pr_dev_info).
> > 
> > The comment in virtballoon_freeze() states:
> >     /*
> >      * The workqueue is already frozen by the PM core before this
> >      * function is called.
> >      */
> > 
> > While this comment was accurate in 2011 for balloon-internal workqueues
> > (such as balloon_wq, which was created with WQ_FREEZABLE and is paused
> > by the PM freezer), it is invalid for Free Page Reporting.
> > 
> > Free Page Reporting (mm/page_reporting.c) schedules its delayed work
> > (prdev->work) on the global system_wq. Because system_wq lacks the
> > WQ_FREEZABLE flag, the PM freezer (freeze_workqueues_busy()) explicitly
> > skips it. Consequently, page_reporting_process() on system_wq remains
> > active and unfrozen throughout device suspend.
> > 
> > If memory is freed into the buddy allocator or a delayed work timer
> > expires while the device is being frozen, page_reporting_process() fires
> > on system_wq and calls virtballoon_free_page_report(). This function
> > passes vb->reporting_vq into virtqueue_add_inbuf() / virtqueue_add_split().
> > Because the virtqueues were already destroyed by del_vqs(), this results
> > in a Use-After-Free / General Protection Fault:
> > 
> >     [  250.709271] general protection fault, probably for non-canonical address 0x7f728084daf08d5e: 0000 [#1] SMP PTI
> >     [  250.732967] CPU: 2 PID: 38 Comm: kworker/2:1 Not tainted 5.10.0-44-cloud-amd64 #1 Debian 5.10.257-1
> >     [  250.751575] Workqueue: events page_reporting_process
> >     [  250.756665] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
> >     ...
> >     [  250.867678] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
> >     [  250.883446] page_reporting_process+0x225/0x4f0
> > 
> > (Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
> > from an identical lifecycle flaw and are also vulnerable to UAFs during
> > S4 hibernation when memory pressure spikes. This patch focuses on Free
> > Page Reporting, which runs periodically, to ensure clean backports to
> > stable kernels).
> > 
> > Fix this by:
> > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > 2. Re-registering page reporting in virtballoon_restore() after the
> >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > 3. Unwinding virtqueue initialization via remove_common() in 
> >    virtballoon_restore() if page_reporting_register() fails.
> > 
> > Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
> > Cc: stable@vger.kernel.org
> > Cc: jasowang@redhat.com
> > Cc: xuanzhuo@linux.alibaba.com
> > Cc: Ammar Faizi <ammarfaizi2@openresty.com>
> > Cc: jiaqiyan@google.com
> > Cc: ahwilkins@google.com
> > Cc: Greg Thelen <gthelen@google.com>
> > Cc: Alexander Duyck <alexander.duyck@gmail.com>
> > Signed-off-by: Link Lin <linkl@google.com>
> > ---
> >  drivers/virtio/virtio_balloon.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index a1b2c3d4e5f6..45a90fb3abf8 100640
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
> >  	 * The workqueue is already frozen by the PM core before this
> >  	 * function is called.
> >  	 */
> > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > +		page_reporting_unregister(&vb->pr_dev_info);
> > +
> >  	remove_common(vb);
> >  	return 0;
> >  }
> >  
> >  static int virtballoon_restore(struct virtio_device *vdev)
> >  {
> >  	struct virtio_balloon *vb = vdev->priv;
> >  	int ret;
> >  
> >  	ret = init_vqs(vdev->priv);
> >  	if (ret)
> >  		return ret;
> >  
> >  	virtio_device_ready(vdev);
> >  
> > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > +		ret = page_reporting_register(&vb->pr_dev_info);
> > +		if (ret)
> > +			goto out_remove_vqs;
> > +	}
> 
> Hm, that failure handling is rather nasty.
> 
> 
> In virtballoon_freeze() we document:
> 
> "The workqueue is already frozen by the PM core before this function is called"
> 
> Your report states:
> 
> "Workqueue: events page_reporting_process"
> 
> 
> I assume that workqueue is not frozen yet because ... it's not freezable :)
> 
> So could we queue to system_freezable_wq instead, or define our own freezable
> workqueue there? Then a driver doesn't have to worry about that.
> 
> -- 
> Cheers,
> 
> David

+1.  Just system_freezable_wq will do the trick.

-- 
MST

