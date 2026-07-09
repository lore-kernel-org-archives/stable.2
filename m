Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825004229C3
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600563; cv=none; b=mquSWChYrKVmFgYG4HWWKlQaKONKiTB2ycXH8BmVPu1t1sulijTD7bq5ZIhBKo+938MOq+s/vyjjxQxkTM5TqVyjMXGs2n+JOdcxxzZ05+clYIOyduQErxkAR8NGq8+PJL8WqjlcxghiJ9GvSUN0qyPH+sEkK2fbxnINlugRtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600563; c=relaxed/simple;
	bh=NSo38pDc1eVh2/8p7VPNDCyMGIBx7hC/7KIx3fE8Cm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbHMoONRp4WA6L4utUUOosL0vmOGJb1kN4eZY+pBBLimc+Nc9I+Q/QeX8l6ZDGoWGqzqFCML/36NUSdKY8uJ4bsXss2QyqnOuNfYL58lbYCBil6S7s2AUNLN6qCwf9ZQFMoUiO4MqdyWKOa9JpigZqgDrP9CTI8b77Imk3jJSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASSTiXRu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lDynUwvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASSTiXRu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lDynUwvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783600560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TRaYW74lwvjeB0Mjr9azQ+EOAQDWI3D3JYBl5wHMsY=;
	b=ASSTiXRuYwu84IGwYNXMngC+gZV7K+xdzE3C/CXZ3re4IQWfx0qRuLDVCR34HhzQWZ4TQo
	s/jWXfV7N5NeOmT7XBwb71e+bX9CT5XHLzufaEnMULRIB/4cxfHtI9ZLKv/hoZP1+Ca8st
	TN/ykVxTbdZbSE0FXXSOI0E+qfx/KI4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-6U_tp-s5Ni6iPKxSEpiSXQ-1; Thu, 09 Jul 2026 08:35:57 -0400
X-MC-Unique: 6U_tp-s5Ni6iPKxSEpiSXQ-1
X-Mimecast-MFC-AGG-ID: 6U_tp-s5Ni6iPKxSEpiSXQ_1783600556
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bab443f7so5625145e9.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783600556; x=1784205356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9TRaYW74lwvjeB0Mjr9azQ+EOAQDWI3D3JYBl5wHMsY=;
        b=lDynUwvnGY7hMSFej5zMMOSaoSkHbHpwEudWDqsngDbc33F3zJ1L+NymtiEVOrQC5H
         2qgaC/IwlxBQ0AF2qC8OP4JB/LkUiVgj3cLkN4exTvDAHfQRgNrqKoN31BYTvGqpeuW6
         AMuyG7igYprftK2uq5eIt1fhKmW1jVImHdPvEWVERJnSZAT9JRsh7+ogfAmcq3mw/Cvp
         BXpS3/YI3QgxNDweRFyQ+XXXkMy7ffkPyg+QJx2x3WP9SyGt1WJ9sPPHx6xLoNXdIInP
         fEsGPmQIT3T5XhhVimaOIskFKhbsjTBMGSrgbiwyQ+I4MPpoZ7PGyEJWngdryV8awAyt
         VCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600556; x=1784205356;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TRaYW74lwvjeB0Mjr9azQ+EOAQDWI3D3JYBl5wHMsY=;
        b=ihuckeN7RGPFm+PrVu+keGeki0qK+57RMeEuF+4RFDy/vqmidLt5w2hIwHo8KZLMEJ
         ow4uiany9m4Pzl6KphYMX81WgQnWFQySSm2wxqOQOwWF+X/jspYAXndrQvYPBZnHTbQW
         sRZACAwrROKOu93jlBMgaVrsR6rygE2dMa+XEE36QB0anCQWXifPYyEhQfj4GqcmVwcy
         FsZ/8YMkT2Zf3ZEMFpdfQZWVGJ0DKPKX2OiWh6/Ki/0NCFFw7z9tw6kwTQYY26PY/iOG
         VJ4zvVFi0YHPyusA52ECXJWGoDibJcdHbLEoY3gmh2htE2GeVGUZoCnbH54IuggvzVLh
         1eog==
X-Forwarded-Encrypted: i=1; AHgh+RoWxrldZspkRqaNnkRpXPgQenNlvGZ9F8CpxVUKQG/iaJHNbntQfoxjMIzcqzUcA5F8vU2PGJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUJ2n7UqEX9bVzikKyDcg+gaCUfGYpSWyQ+Xm7NbJ1v+yioLC
	ZCXvWV4OlhNYje0vki2pP32z7omVdvTw5Ra/Lb1P5KBRAZcZe04J8gaUGSFqxHkORfj14tlDm7j
	Ezh7ksXm4v2scoPbzv3RENJtaOfvjV6Aqt3qinxlABJkYYkhwyy0mHcf26w==
X-Gm-Gg: AfdE7ck6iM8cUv+mO3dhl68lWfpukh/gjRZQ504ScALGpOy4zxblegFCfzYLlcIVl9B
	JB3PQ+2qx3Eb1AVxK6OgjDciBtXcd91xTDLjhkE3CA9GQv5PJI+mtw19ZPgPy5xr+iI5WckR7bE
	7XDFkfx6zuAGqRhGd7J2CP1xGPo5chyGU8nYpdoEsjFCOwOnjtkgTGPDZHAZqFbRFn02nYKpDQH
	wdPkQc8RPdg4sMfi9Rn4YNEZGuBinDOgK5CIXo3t4NS6NafIJAz+r9WAYK8vJexSpeJEoh3Vabb
	ZDwt0Zr9cPhfmAAElhz+kIAJQmsCtaBflZL/qGq91YWF4TrdWQ5oWfpoSN7bcoug6+I9456fo2I
	RYN6qfwH1Zd5B6AlcmhicBA5NuNAm/NYW
X-Received: by 2002:a05:600c:8b23:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493ec561498mr27273285e9.4.1783600555628;
        Thu, 09 Jul 2026 05:35:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8b23:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493ec561498mr27272735e9.4.1783600555065;
        Thu, 09 Jul 2026 05:35:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm58554585e9.8.2026.07.09.05.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:35:54 -0700 (PDT)
Date: Thu, 9 Jul 2026 08:35:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
	error27@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <20260709083103-mutt-send-email-mst@kernel.org>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709114745.4030794-1-haoxiang_li2024@163.com>

Thanks for the patch! one question:

On Thu, Jul 09, 2026 at 07:47:45PM +0800, Haoxiang Li wrote:
> virtbt_probe() allocates vbt before setting up the virtqueues, but some
> failure paths return without freeing it.
> 
> The probe path also registers the HCI device before the virtio transport
> is opened. Since hci_register_dev() makes the HCI device visible and queues
> power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
> so the transport is ready before the HCI core can use it.

Sounds good, and yes it is a spec violation to kick vq before virtio_device_ready

> On failures after DRIVER_OK, reset and close the virtio device before
> deleting the virtqueues and freeing vbt. This also cancels pending rx work
> before vbt is freed.

what "this" cancels pending work? And how can we have work since device was
not registered?

> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Rework virtbt_probe() error paths into an unwind ladder.
>  - Free vbt on probe failures.
>  - Reset the virtio device and unregister the HCI device before freeing it
>    when virtbt_open_vdev() fails.
>  - Close the virtio device before unregistering the HCI device in remove().
> 
>    Thanks Dan for the suggestions. The blog is very helpful.
> 
> Changes in v3:
>  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> 
> Changes in v4:
>  - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
>  - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!
> ---
>  drivers/bluetooth/virtio_bt.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 140ab55c9fc5..e7e79ba3c1f7 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>  
>  	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
>  	if (err)
> -		return err;
> +		goto err_free_vbt;
>  
>  	hdev = hci_alloc_dev();
>  	if (!hdev) {
>  		err = -ENOMEM;
> -		goto failed;
> +		goto err_del_vqs;
>  	}
>  
>  	vbt->hdev = hdev;
> @@ -383,23 +383,28 @@ static int virtbt_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
>  		hci_set_aosp_capable(hdev);
>  
> -	if (hci_register_dev(hdev) < 0) {
> -		hci_free_dev(hdev);
> -		err = -EBUSY;
> -		goto failed;
> -	}
> -
>  	virtio_device_ready(vdev);
>  	err = virtbt_open_vdev(vbt);
>  	if (err)
> -		goto open_failed;
> +		goto err_close_vdev;
> +
> +	err = hci_register_dev(hdev);
> +	if (err < 0) {
> +		err = -EBUSY;
> +		goto err_close_vdev;
> +	}
>  
>  	return 0;
>  
> -open_failed:
> +err_close_vdev:
> +	virtio_reset_device(vdev);
> +	virtbt_close_vdev(vbt);
>  	hci_free_dev(hdev);
> -failed:
> +err_del_vqs:
>  	vdev->config->del_vqs(vdev);
> +err_free_vbt:
> +	vdev->priv = NULL;
> +	kfree(vbt);
>  	return err;
>  }
>  
> -- 
> 2.25.1

