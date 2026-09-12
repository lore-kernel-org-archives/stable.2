Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4C3F23BE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204195; cv=none; b=DCsiQxnKJCrOpjcY9wFMZdCNeLAR+0o4iF8R52Na17T1KCRIX2V2jtI4wEsxMJOPwvRhTsYOgppkZiaxO2aO5apT2SeCB5v/UjPzBkMzvUIIwjGGOBBTgz4fpA28wRW2indzREuwWsC31Kxi0CavjNmrZbGnwiYeLrDRHShQT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204195; c=relaxed/simple;
	bh=Udoo0U8Eun6RScJdgOh2tTlkvguARmiSlB0JzgpGvvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9kz1M45YI35PWHOhgC8TlEoEH8qBfgKK6pM1ZRCEKRg5wmu3ZVfZtx002exKbhv5QpRJR0dh25A2bPuhefGJurPNVl2ccoW8kb/K1Khmyi9IzaWekoL8mS8JrP/DNoLoi+B6dYiO/MdneKvJULbM5k1+Qn3aCytZBb+4ds5KTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A36Rsk1/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tjCJ44WR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A36Rsk1/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tjCJ44WR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789204192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fTpUU0/C+r9b31rC+Uhm2IpvHL/cIjBJckoMkgqczM=;
	b=A36Rsk1/JGGPKhqUdkP2Uzb4X8kroFJyAcjL3JxOwzivEpPtDlCP+nSJ7VBC/8ec7Y9H2W
	CDeUtp1448Stg6uCGlbG7ZgmoWG+m8zKRGllb+kGWs0c+IWzYlrSiZAv0lStp5YHmBBwsa
	DSAArsG8P2ke6W7RIQPr7MTTAN0W9YY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-b_4w89EfMv-LS2071vRWmg-1; Sat, 12 Sep 2026 05:09:50 -0400
X-MC-Unique: b_4w89EfMv-LS2071vRWmg-1
X-Mimecast-MFC-AGG-ID: b_4w89EfMv-LS2071vRWmg_1789204190
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-485afdd5079so1404266f8f.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789204189; x=1789808989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2fTpUU0/C+r9b31rC+Uhm2IpvHL/cIjBJckoMkgqczM=;
        b=tjCJ44WRixS3c8wTvizTp2GmGaw6sxq2Adp4xYIfq2XzbTwj4hYNLotvo/ee9Ry1CK
         AKsv+XZQKkNwOnmPZK5t0sg2+uX7kDQkLIEwf3GZw0Cm6Y7bOeLHQPel+AIUBiqIoVoX
         SgVzQ4waqpFCeWFjKOQdA1/GUCNTP+M1OCM7anF3zbNacoATipImGmOLL0QpaX0NyCuM
         RQWmo/qSWrt4KnUrB8BrKhdQkVadjuViCyuHOfS0RNv9wkt5FewICpfegdsk6xBhj6Mm
         Zj/H32a/zaUo3vstzCcf3AXl+F7qxJAwA90k/+dFXRkO+MS39KjcRyAU6g5hjlpWGJ+N
         sUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789204189; x=1789808989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fTpUU0/C+r9b31rC+Uhm2IpvHL/cIjBJckoMkgqczM=;
        b=ewHDrl7u2NtRPuXE27cdzayMYDYNu97vfQHlfHK20TffFWG8+RhFCxVDKb7VEfzvjY
         g6AMGavJnVjMT7CNuH3QBLorwODvt4w09vmktUOYZJM7wlgnS5ry9tP+zzddBzsCsPfa
         aWw7cJPIfZXUmN6BkzoHd9OSQlDa7jmSHfBdvqirnQVHudseNHyS7K9zg3nHl7FSZmVW
         ZVIugxHTcv28kRKFH72bN8ilBvUJKTMsB8Fijy8LB1AEkj2x4upD1fKJixZgOUCB9gbW
         CiyQqxp9FwNAq97KOYFs3q5J31TJppUMzqEKCu1LDlXg7ybMXv1O0NzbotE2i1ajEuJd
         nDQg==
X-Forwarded-Encrypted: i=1; AKwUvBwKJYD8BmUlGA7vcEXxRm3ZMajHqo341ERBBu3j+6AAAOxwH9SeC+mcAyiCZwPf7y19Og2ILm4=@vger.kernel.org
X-Gm-Message-State: AFuF++lyG3AFHzn2mVrQybY3wwg8u1biMuxpsM1JRTnzOMASwQJhPfEE
	0HN89eeWOwmN5Gtb2zFwo8BGA/vgoP3dhn919kF+C/FpRGTcsOU/rFP9jujDb4LUgQA6utDPS2l
	WMiQUAs3Kx2cICscGGykC2z1vr4eXNev2+ap6Cnkk7tUoOWKNyDiKA8SgAA==
X-Gm-Gg: AYBFou3KuPH+WQD38c0XqsJjAJcnlR1mRBioeUmw3M1EZGLLCBdz0JmeLqQDg5Qt7sv
	UxAIyXiUYF4Z5qqD4P6URoxCuRFFkwScUx3Qypt0ZCrnD4SICWNRLS4ZBISi5oXYQFDU0FcECAi
	hdd7tYk3R5HGe+CDFYSS/a5Q17diGYnQ1mm6Yu5qvj8eQ0Qw2zIYQ1lFABP+AYhJcfwvdBoNJS3
	LwfrAdUlJvmGpKMSuz/RSFu29bBeGPYX1tVuxh2d0ZTNgXnvSrfJGXT0KT6XkMsKVQiS9QzZs2/
	a52B/pV/F6ws+haoa/vTOSpotw5ebaEqkj7gqWnSRjNE9cyyOcLn1/Nfy5E2Dc3pYi8=
X-Received: by 2002:a05:6000:4008:b0:485:8c16:a32d with SMTP id ffacd0b85a97d-486eb329a0amr8768532f8f.34.1789204189452;
        Sat, 12 Sep 2026 02:09:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4008:b0:485:8c16:a32d with SMTP id ffacd0b85a97d-486eb329a0amr8768508f8f.34.1789204188889;
        Sat, 12 Sep 2026 02:09:48 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm11666697f8f.24.2026.09.12.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:09:48 -0700 (PDT)
Date: Sat, 12 Sep 2026 05:09:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, linux-arm-msm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Message-ID: <20260912050459-mutt-send-email-mst@kernel.org>
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>

On Sat, Sep 12, 2026 at 04:52:44PM +0800, Cong Zhang wrote:
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
> 
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().



This repeatition of the code in english is not what we need
in the commit log.

Suggested format:

The following issue was observed by ...: currently .... because ... this is a
problem because ... and we can not ... because ... to fix ... so that
... tested by ...: before ... after ...




> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>

no empty lines between tags please

> ---
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.



this kind of thing belongs in the commit log.

> ---
> Changes in v2:
> - Cc stable@vger.kernel.org.


which is no longer there?

> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..7a570591e040 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	/* Ensure no requests in virtqueues before deleting vqs. */
>  	memflags = blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue_nowait(q);
> +	blk_mq_quiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);
>  
>  	/* Ensure we don't receive any more interrupts */
> 
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
> 
> Best regards,
> --  
> Cong Zhang <cong.zhang@oss.qualcomm.com>

