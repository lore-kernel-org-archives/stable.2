Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBBEAC7;
	Tue, 14 Jul 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035067; cv=none; b=SHJLHQTz4nlhum8mHTn5O1EtRne3DtrIR8Aza/M1kHl+pCnK3LZB3lepMBgrpvlseHiSfKVvIc+YobagcnwoteOVQE5fVlVkBH/xerOxHWs5AjQyNHXuxn4yKjEAh2Xzh8wOEDq5mFi0nAw82CIGVMx09EfSEufkdnbHdBdQAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035067; c=relaxed/simple;
	bh=w1ZUj1749/I3WMkB1bXQWcYiLYcInm+Txyh34c/H1cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeyZeGuH8ZaYdlQaxQv05wMoiIxrHOSId18Mx3/nBa4JCN9SurSq+Ci2xaMgjz5px/GTllAaKQd5ihZCXsmnlxlONZZQPI378Yw4pxQU5Qwyj+MbgYwocXt0+hXr4gX3R0ZVSAOqCw8HWSCjpDMqq8rfFhrEib0+dIjrPEAyb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FED4vNrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FED4vNrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887CA1F00A3A;
	Tue, 14 Jul 2026 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035066;
	bh=XPP2myTGPA5lMKiNw+TtdOeHCWrcAC/vqmt4XlyULw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FED4vNrCvRA+E87/OHhMTv0sfCp09VAGYZiCGXNOiE/pu8OVC+5T3j135myCIb0B+
	 HyytLmY+Zx+54l8JqAbasXFFpi4S5Wvw45Hyr3VUpIrati8G7aqxEqOIwPHfmZDNlM
	 WWJIeDXiIWaWuTZ88BGzH1cfhWqwQQHEHu0p9yjTXmw/Am4wTsLlVQuzpZofqiFlW0
	 AD+aQnQhQCtuAJkK/rd8PGJjcdPzRLRFWEm7QIwUMLdDEDo3j0ey9lq/HkjI8UL5Wt
	 tbhorm20fDX8meWpCOhymc5mNvLYAPYcYIUtkesKWymOv+FhcI7oF58MmI83iUWW2L
	 bq9WyWLH+mVnA==
Message-ID: <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
Date: Tue, 14 Jul 2026 15:17:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
To: Link Lin <linkl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com,
 duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
 ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
References: <20260709224330.946683-1-linkl@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260709224330.946683-1-linkl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 00:43, Link Lin wrote:
> During system power management freeze (e.g. ACPI S3 suspend or S4
> hibernation), virtballoon_freeze() calls remove_common() to reset the
> virtio device and delete all virtqueues via vdev->config->del_vqs().
> However, unlike virtballoon_remove(), virtballoon_freeze() fails to call
> page_reporting_unregister(&vb->pr_dev_info).
> 
> The comment in virtballoon_freeze() states:
>     /*
>      * The workqueue is already frozen by the PM core before this
>      * function is called.
>      */
> 
> While this comment was accurate in 2011 for balloon-internal workqueues
> (such as balloon_wq, which was created with WQ_FREEZABLE and is paused
> by the PM freezer), it is invalid for Free Page Reporting.
> 
> Free Page Reporting (mm/page_reporting.c) schedules its delayed work
> (prdev->work) on the global system_wq. Because system_wq lacks the
> WQ_FREEZABLE flag, the PM freezer (freeze_workqueues_busy()) explicitly
> skips it. Consequently, page_reporting_process() on system_wq remains
> active and unfrozen throughout device suspend.
> 
> If memory is freed into the buddy allocator or a delayed work timer
> expires while the device is being frozen, page_reporting_process() fires
> on system_wq and calls virtballoon_free_page_report(). This function
> passes vb->reporting_vq into virtqueue_add_inbuf() / virtqueue_add_split().
> Because the virtqueues were already destroyed by del_vqs(), this results
> in a Use-After-Free / General Protection Fault:
> 
>     [  250.709271] general protection fault, probably for non-canonical address 0x7f728084daf08d5e: 0000 [#1] SMP PTI
>     [  250.732967] CPU: 2 PID: 38 Comm: kworker/2:1 Not tainted 5.10.0-44-cloud-amd64 #1 Debian 5.10.257-1
>     [  250.751575] Workqueue: events page_reporting_process
>     [  250.756665] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
>     ...
>     [  250.867678] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
>     [  250.883446] page_reporting_process+0x225/0x4f0
> 
> (Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
> from an identical lifecycle flaw and are also vulnerable to UAFs during
> S4 hibernation when memory pressure spikes. This patch focuses on Free
> Page Reporting, which runs periodically, to ensure clean backports to
> stable kernels).
> 
> Fix this by:
> 1. Unregistering page reporting in virtballoon_freeze() prior to calling
>    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
>    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> 2. Re-registering page reporting in virtballoon_restore() after the
>    virtqueues are re-initialized and virtio_device_ready() has been called.
> 3. Unwinding virtqueue initialization via remove_common() in 
>    virtballoon_restore() if page_reporting_register() fails.
> 
> Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
> Cc: stable@vger.kernel.org
> Cc: jasowang@redhat.com
> Cc: xuanzhuo@linux.alibaba.com
> Cc: Ammar Faizi <ammarfaizi2@openresty.com>
> Cc: jiaqiyan@google.com
> Cc: ahwilkins@google.com
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Link Lin <linkl@google.com>
> ---
>  drivers/virtio/virtio_balloon.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index a1b2c3d4e5f6..45a90fb3abf8 100640
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
>  	 * The workqueue is already frozen by the PM core before this
>  	 * function is called.
>  	 */
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> +		page_reporting_unregister(&vb->pr_dev_info);
> +
>  	remove_common(vb);
>  	return 0;
>  }
>  
>  static int virtballoon_restore(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  	int ret;
>  
>  	ret = init_vqs(vdev->priv);
>  	if (ret)
>  		return ret;
>  
>  	virtio_device_ready(vdev);
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +		ret = page_reporting_register(&vb->pr_dev_info);
> +		if (ret)
> +			goto out_remove_vqs;
> +	}

Hm, that failure handling is rather nasty.


In virtballoon_freeze() we document:

"The workqueue is already frozen by the PM core before this function is called"

Your report states:

"Workqueue: events page_reporting_process"


I assume that workqueue is not frozen yet because ... it's not freezable :)

So could we queue to system_freezable_wq instead, or define our own freezable
workqueue there? Then a driver doesn't have to worry about that.

-- 
Cheers,

David
