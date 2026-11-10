Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272196;
	b=OroXJxArkijZ61Ctc25n+YpQg5wRoSaaUQWN56pnHI0Ia8pJEc969Oaxk1iAJlz8w15i
	 /VLIB2AqzGo4YiDx6J+NKSx/pl29U7YmYxyid01GiTJSPm58D8YwSl1Pg1OluzxUvC6Ro
	 CQyAwYksTfLsylqojttlDT63T2hV2tkswHVZeFEZexBsl7VAIK5rI8c0synV7jb96sho4
	 V+QkBT0LIYSpp6c3YTnEg4ADWY+acwafLS1RRdb3t+lknnHaW6BMkSndoZXun6F9IYTvH
	 lhh2qOTs3xfVItC1rM5c7YLebmUhcBFcWf7KmpbDW/kU39yaIXG6WkYYLwslKfDmw8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272196;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=POYNQ8UFORjsZSBOAZpmVOdf956zxHeg9590atUMmfM=;
	b=4Jw8fOy7aZTLt8ueMTuh07gfyMC8HAXWd5gOATwS+/kmJ2h2vTXa9Cbp3+n0hoW+ZZeU
	 suSF41DMLmd5urazu576vPLDBhgu7B8zKfmPQSKTtrsOArHlvdVooHFs6o3+mkst4PJuT
	 KezqMmdXaj4TU2P6oa+mCIW14pre71WootUI5n9Q8iTmniFVpPD/G1UvqqCkAKNooCav1
	 iHrVlXz09gyC+nQ3jZOLBlgSIzHOtfgqgXdsmRMBVPhhTjK5dEooqemnN+MsUCNs5E2fc
	 /Cxy2H9eo+AxOVEZi1TQyl+EsE2yKHBG7KstO/MkQemNERC82zTkNg7MJXAdGZtowOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DLwdMFW/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED637606A32A;
	Tue, 10 Nov 2026 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLwdMFW/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F921F008A1;
	Tue, 10 Nov 2026 00:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272195;
	bh=POYNQ8UFORjsZSBOAZpmVOdf956zxHeg9590atUMmfM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DLwdMFW/60LVnTLa0yQmFg0tJx5vXiCHVmG3eQvGbHS3Idmk3+SseDFBk4e4QF6db
	 QGhyDVdv2TP7uE6I7XG/AK58MazhLRnlCZ5IuW+IA6DhA5bLWD/ACaImWurFZy0tQz
	 lG0sil3FGULB2pGRmHFZtabyVEjLG1JEgXDwUhr7Ds+JfrM4HvX/XQnnIh6+HycLwT
	 PjlB5wVDGsd8SFJO8h51aceVX/oB5ajpAbcSzJ1OiF2SPzAMsPLPlO4hwHFHxz2rJF
	 tOrhtc7ad9zvKgBlPUII/yBcXSRUtAqULMSVRHxrRdbVxmN/lbj6eJxUfYj0lJyQdy
	 SPIVp3mRgcmJA==
Date: Mon, 9 Nov 2026 16:56:33 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
    boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] xen/pvcalls: destroy the per-socket workqueue on
 release
In-Reply-To: <20261109122324.30134-3-yhlee@isslab.korea.ac.kr>
Message-ID: <604a9832-80ac-107c-b36f-4bb338519cbc@kernel.org>
References: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr> <20261109122324.30134-3-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Nov 2026, Yehyeong Lee wrote:
> pvcalls_new_active_socket() gives every active socket its own ordered
> workqueue:
> 
> 	map->ioworker.wq = alloc_ordered_workqueue("pvcalls_io", 0);
> 
> and nothing ever destroys it.  pvcalls_back_release_active() flushes
> map->ioworker.register_work and frees map, but the workqueue and its
> pool_workqueues stay allocated, so a frontend leaks a workqueue per socket
> it connects and releases - a loop a guest can run as long as it likes.
> 
> Destroy it after the IRQ is unbound, so no new work can be queued, and
> before map is freed.  pvcalls_back_ioworker() takes no locks, in
> particular not fedata->socket_lock, which the backend_disconnect() caller
> holds here, so draining it from this point is safe; the flush_work() just
> above already has the same requirement.
> 
> Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>  drivers/xen/pvcalls-back.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
> index dcefa91a40cd05..27aa06289a7b92 100644
> --- a/drivers/xen/pvcalls-back.c
> +++ b/drivers/xen/pvcalls-back.c
> @@ -456,6 +456,7 @@ static int pvcalls_back_release_active(struct xenbus_device *dev,
>  	xenbus_unmap_ring_vfree(dev, map->bytes);
>  	xenbus_unmap_ring_vfree(dev, (void *)map->ring);
>  	unbind_from_irqhandler(map->irq, map);
> +	destroy_workqueue(map->ioworker.wq);

Please move the call to destroy_workqueue() just after flush_work().
With that:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


>  	sock_release(map->sock);
>  	kfree(map);
> -- 
> 2.43.0
> 
