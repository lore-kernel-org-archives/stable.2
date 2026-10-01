Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95282492E48
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886567; cv=none; b=WY9cvnpcMYjmAyChdjqvO5yuK5bsGBQNHKhKpeSzX7ITQc9QXzBDlBnYx3mI4iZmSU5MXPRlTKUvTGjqXAvIjIzJVxExKpi48WEJ3/uKkVZRS9DXozDdtEn+MCwoV8UkBSpI5+2ZzUNZbkRi/54LaMcn72vVXSiqI9bhnQy7xmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886567; c=relaxed/simple;
	bh=cNzMFgEjieaz9zl5rXlk4ye1Ut2AxlMaToY3MXxg6DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkYOIWlab+Y8ry4EFfeQc1mJBhHIHcGAISnZCueAW8Pntex1mHsTuJxmwP/1ZkxNG6uTR5NoZYDEdAxMs7085wYDB5wBOi2iEgqCfXqNn/XHFyJwpUy3EfxUbw5UQOqYIYFI5pGKdj1AR00Jv2mlCqL9LsbMsIOW4F6LgGkWbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjE6EV2D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjE6EV2D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790886564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Byn2vYVxVM2zX7HqHro8W77S+GvekDCAcWSAeTMj660=;
	b=IjE6EV2D2B3FMafF+nKkJuGUrv89EIbjBzWM7YMprZOoIdY9QMLlNbv1uakvRPZOqU5xSp
	TlapUOFnlJfa9a7DCPjz1WZ797983H2hX6DzWVC/dbtLvVh+/kkb1m5+yRkL1MX/ybDn4+
	ByTpb0El12RlimzPGanUSC6gyw2oLFY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-0tLfxaTsNXyxIX-pmQWXeQ-1; Thu,
 01 Oct 2026 16:29:21 -0400
X-MC-Unique: 0tLfxaTsNXyxIX-pmQWXeQ-1
X-Mimecast-MFC-AGG-ID: 0tLfxaTsNXyxIX-pmQWXeQ_1790886559
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0D851800619;
	Thu,  1 Oct 2026 20:29:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1F3E1800446;
	Thu,  1 Oct 2026 20:29:17 +0000 (UTC)
Date: Thu, 1 Oct 2026 16:29:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1] virtio_blk: Reset device on probe error paths after
 DRIVER_OK
Message-ID: <20261001202916.GC378684@shajnocz.csb>
References: <20260922211207.523999-1-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922211207.523999-1-oss.patchbox@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Sep 22, 2026 at 05:11:41PM -0400, Yuho Choi wrote:
> virtblk_probe() marks the device ready before revalidating zones and
> adding the disk, and either of those can fail.  The out_cleanup_disk path
> they take goes on to delete the virtqueues, but nothing tells the device
> to stop first, so it is still live when the rings are freed.
> 
> Reset the device at out_cleanup_disk, which is only reachable after
> virtio_device_ready().  virtblk_remove() and virtblk_freeze_priv() both
> reset before deleting the virtqueues for the same reason.
> 
> Fixes: dbb301f91fc8 ("virtio_blk: add error handling support for add_disk()")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks for the fix!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9dc..ed97dafebe164 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1547,6 +1547,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return 0;
>  
>  out_cleanup_disk:
> +	virtio_reset_device(vdev);
>  	put_disk(vblk->disk);
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
> -- 
> 2.43.0
> 

