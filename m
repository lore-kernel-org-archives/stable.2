Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D9322B8F
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413105; cv=none; b=LLsMQ4BjuDDh0JN5FkcpNbGC81kGfTT88SUtCsvjoI+Bwy8p9MG5Qckih5d+thNV7wxIGRaGnAETTNlfdxNSb1ZSDIznkDA9EPAVfIHTMlbgQOS4Zscx2KEFTI7dD6WLHBa7N/mZEW9tnT+5dZad1OsZq2w5Fm6FMpbDBveFr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413105; c=relaxed/simple;
	bh=o5TlCe16qoetQL4Uc3WOc1ZnLAh2hwBZUxAUSkYXSYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESw8ZN0ZQcPFs5flLCIvZJ56sxMle88lAJMwjV1veGXm/+YALbcpsndv7z+iYN68Ic/+PkyGaaSDwQn8OxleLI2lKW2PnpJsUSZAaGSZIjODBs/E9f1VYHnKkU+ZEVGhGngXMuu5GvHNkI56jTsm/lKfqJEf66QGAT+jmdAYblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTema2QK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTema2QK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783413102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO/CLQeGrRneCKqmDtYKMQxIBN6nL5tFljCHjkfDvkE=;
	b=aTema2QKR4Dxso3I2OKX4erf53i0DkFMYvgiSgcvIkIdzERO31yMR8DOnQ16Bs7GtmJjRl
	vR73ZmgWRgShxuBZRNwBDtmD+WBWKSBGdZ/8aEF7JqiZz6r7WF8NLOdfAcqy53EpbVuyNp
	9tujCdSglFJZDQrPxLIvTFTHlhevCmU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-Lu07oMRDPFKwJA2MHx-R0A-1; Tue,
 07 Jul 2026 04:31:39 -0400
X-MC-Unique: Lu07oMRDPFKwJA2MHx-R0A-1
X-Mimecast-MFC-AGG-ID: Lu07oMRDPFKwJA2MHx-R0A_1783413098
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD2A81955DBF;
	Tue,  7 Jul 2026 08:31:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A87D23000C06;
	Tue,  7 Jul 2026 08:31:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	tactii@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/4] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Date: Tue,  7 Jul 2026 10:31:29 +0200
Message-ID: <20260707083129.53988-1-pabeni@redhat.com>
In-Reply-To: <20260630214404.930923-4-anthony.l.nguyen@intel.com>
References: <20260630214404.930923-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
idpf: handle NULL adev in idpf_idc_vdev_mtu_event

This change caches vdev_info->adev with READ_ONCE() and returns early
when the cached pointer is NULL, so that device_lock()/device_unlock()
operate on the same captured auxiliary_device and do not dereference a
NULL adev field that was cleared by the teardown path.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index b7d6b08fc89e..9f764135507c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
>  
>  	set_bit(event_type, event.type);
>  
> -	device_lock(&vdev_info->adev->dev);
> -	adev = vdev_info->adev;
> -	if (!adev || !adev->dev.driver)
> +	adev = READ_ONCE(vdev_info->adev);
> +	if (!adev)
> +		return;
> +
> +	device_lock(&adev->dev);

[High]
Does caching the pointer with READ_ONCE() actually make this safe against
the teardown path, or does it just narrow a NULL-deref into a
use-after-free on the mutex embedded in adev->dev?

Looking at the teardown side, idpf_idc_vport_dev_ctrl(adapter, false)
calls idpf_idc_vport_dev_down(), which calls idpf_unplug_aux_dev() on
vdev_info->adev:

    idpf_unplug_aux_dev(adev)
        auxiliary_device_delete(adev);
        auxiliary_device_uninit(adev);   /* put_device -> release -> kfree */

and only afterwards assigns vport->vdev_info->adev = NULL.

The MTU path runs under rtnl_lock and the vport_ctrl_lock, but
ig3rdma_core_remove() (which drives the IDC teardown via the auxiliary
bus) does not appear to take either of those, so the two paths are not
serialized against each other.

With the new code:

    adev = READ_ONCE(vdev_info->adev);
    if (!adev)
        return;
    device_lock(&adev->dev);

if the teardown path frees adev between the READ_ONCE() load and the
device_lock() call (it can, because the kfree happens before vdev_info->adev
is set to NULL, and there is no get_device()/put_device() or RCU barrier
on this path), then device_lock() operates on a freed struct device and
its embedded mutex.

Would the correct fix here pair the load with get_device()/put_device()
across the locked region, NULL out vdev_info->adev before the
auxiliary_device_uninit() in the teardown path, and add a
synchronize_rcu()-style barrier (or a shared lock) so the MTU path cannot
observe a freed adev?

>  iadrv = container_of(adev->dev.driver,
>  			     struct iidc_rdma_vport_auxiliary_drv,
> @@ -172,7 +175,7 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
>  	if (iadrv->event_handler)
>  		iadrv->event_handler(vdev_info, &event);
>  unlock:
> -	device_unlock(&vdev_info->adev->dev);
> +	device_unlock(&adev->dev);
>  }
-- 
This is an AI-generated review.

