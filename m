Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473077;
	b=1PTUrm7+Srr2v0j3mxDETGhB2bD8Pp5kXpdvGiHnN8bJ2hoFKcgzwE2+k0eKwbJKzWvE
	 dblA9UTbPhPNyIr0ieeHLgbPYtSCDWZjUPJpb58UNsxa6CNYnQA60QLhAyucoqY/f63EA
	 ejT6gNTSx2KCk1lg00zVY4k2lwt8GqBleewUMwOC7JoySXQZWwy/2xAhrsrRVVuZ9tJ+0
	 rzn++GKw8rU3J57p48Lm3H+L3qbmTN3lwzirQYAiBDm/q3Son9zEytQHV0aTZWS1EUyPh
	 BgVZmmk4H6z0Txd58gDmwIeecUUmoXm/DQxE2KvkqLLhB4ucxvZw0slzCOwQpdUz3wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473077;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pRDfDi9w39w7WSWPejzMl2NAPLZdQXQs1cadPzSxwYI=;
	b=l5YBP62qb3I/migxCddsvdETrMBcW0uUA9d2ZKYyoW1bfLztrLbySeJqALcboZ7Hxf3N
	 VpG6WrcBfKmkTtl94q5lK1Ux/4INTAr+TpQOQcnmI3mrDZARScdLg4c/ZljgSbr5WQk7D
	 S/1/ZFSL4+vPaCKKB+mUINjg4cTYhSUGFBHCfy7RbkETcyYRIA+MBKuRscFyOTMXO0+x6
	 JRNx8e7kTtYFKHPrL9BfNBKFmtPd/Eeb1oj3NTxZ47UIgo/VZSzUdZvz0G1vegFim1nJj
	 qnd06LPyk4NpemcH5Fm8Adicf4m0nK5cF6046dcFi5JZd644zal6GNYHSgfXDQuLLWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/V9S+UT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311A606A333;
	Thu, 12 Nov 2026 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/V9S+UT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A2A1F00A05;
	Thu, 12 Nov 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473077;
	bh=pRDfDi9w39w7WSWPejzMl2NAPLZdQXQs1cadPzSxwYI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Z/V9S+UT7lp7DTr98K42zRejsPHSjIVa+ZIiJ68eEfBxctSBgUeQLFlSwg5iuMvxb
	 Anin6on1+Uy8m2C2cuz3m3HDCD8l+R6ev9JSBwDnuD3LR+LQ09tRtCHynCZ13ND6LY
	 FAISHSg09Sn3XY9udYfCscgyz70RsL0OmgSA2fjkEjNTHzqilGPzUnqNZUsdqYBRAF
	 PD++jq8yqqwnI8emJYpepQVNNLTNV4iNbelgxkFLwhJjawcsE+msP0oVGJ1Rg4vNoP
	 uYVCKx4ti3j15BM1IWR/KwF9hql5kfwDqMF+U3OeEO1CrR/Birzeb3ZTZUJWb6DlZy
	 02gSjGnU5C4sA==
Message-ID: <a19fa548-32a2-49a1-86ce-c93fcab7f729@kernel.org>
Date: Thu, 12 Nov 2026 09:44:33 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v3] media: dvb-core: skip disable_source handler for a
 released entity
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261102131907.8922-1-25031212351@stu.xidian.edu.cn>
 <20261102143415.26942-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20261102143415.26942-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2026 15:34, YuanZhe Liu wrote:
> dvb_remove_device() frees the media entity of a dvb_device through
> dvb_media_device_free() and sets dvbdev->entity to NULL.  The media
> device of the adapter can still be registered at that point: au0828,
> for example, only clears mdev->disable_source in au0828_usb_release(),
> which runs after au0828_dvb_unregister() has unregistered the frontend
> device.
> 
> A file descriptor that survives the disconnect then reaches
> dvb_frontend_release() with dvbdev->entity already NULL and calls
> 
> 	fe->dvb->mdev->disable_source(dvbdev->entity);
> 
> au0828_disable_source() dereferences that argument unconditionally:
> 
> 	struct media_device *mdev = entity->graph_obj.mdev;
> 
> which faults:
> 
> 	general protection fault: 0000 [#1] SMP KASAN
> 	KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> 	RIP: au0828_disable_source+0x27/0xb70 au0828-core.c:445
> 	Call Trace:
> 	 dvb_frontend_release+0x2eb/0x500 dvb_frontend.c:2946
> 
> The error path of __dvb_frontend_open() has the same call.
> 
> Skip the handler when dvbdev->entity is gone.  For that check to be
> sufficient, clear dvbdev->entity in dvb_media_device_free() before the
> entity is unregistered and freed: both frontend paths read the pointer
> while holding mdev->graph_mutex, and media_device_unregister_entity()
> takes the same lock, so a reader either still sees a registered entity,
> for which unregister waits, or sees NULL.  Clearing the pointer after
> the unregister would leave a window in which the entity is read after
> it was already freed.
> 
> Read the pointer only once, into a local variable, while the lock is
> held.  dvb_media_device_free() stores NULL before taking graph_mutex,
> so re-reading the field to pass it as the argument could still observe
> NULL and hand it to the handler.  That store is not serialised with the
> locked readers either, so publish the pointer with WRITE_ONCE() and
> read it with READ_ONCE().
> 
> Stopping the pipeline the handler started is not done here.  Only the
> driver knows how to release the link it owns, and dvb_media_device_free()
> runs for every dvb_device, including the demux, dvr and ca entities that
> never own a media link; calling the handler for those would deactivate a
> link owned by another entity.  The au0828 driver stops the pipeline and
> clears its saved link in au0828_usb_disconnect(), before the frontend
> entity is unregistered, in a separate patch.
> 
> Fixes: 68ff5767ddc4 ("[media] media: dvb-frontend invoke enable/disable_source handlers")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> Changes in v3:
> - Publish dvbdev->entity with WRITE_ONCE() and read it with READ_ONCE()
>   at both frontend call sites, so the clear in dvb_media_device_free()
>   is not a plain data race with the readers that hold graph_mutex.
> - State why the active pipeline is torn down by the driver rather than
>   in dvb-core.  The matching au0828 change is attached to this mail.
> 
> Link: https://lore.kernel.org/r/20261102142508.24277-1-25031212351@stu.xidian.edu.cn
> 
> Changes in v2:
> - Read dvbdev->entity once into a local variable under graph_mutex at both
>   call sites.  dvb_media_device_free() clears the pointer without holding
>   that lock, so re-reading the field for the call argument could still pass
>   NULL to the handler.
> ---
>  drivers/media/dvb-core/dvb_frontend.c | 14 ++++++++++----
>  drivers/media/dvb-core/dvbdev.c       | 16 +++++++++++++---
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
> index 0286da57f382..bcee88e16576 100644
> --- a/drivers/media/dvb-core/dvb_frontend.c
> +++ b/drivers/media/dvb-core/dvb_frontend.c
> @@ -2826,9 +2826,12 @@ static int __dvb_frontend_open(struct inode *inode, struct file *file)
>  #ifdef CONFIG_MEDIA_CONTROLLER_DVB
>  	mutex_lock(&fe->dvb->mdev_lock);
>  	if (fe->dvb->mdev) {
> +		struct media_entity *entity;
> +
>  		mutex_lock(&fe->dvb->mdev->graph_mutex);
> -		if (fe->dvb->mdev->disable_source)
> -			fe->dvb->mdev->disable_source(dvbdev->entity);
> +		entity = READ_ONCE(dvbdev->entity);
> +		if (entity && fe->dvb->mdev->disable_source)
> +			fe->dvb->mdev->disable_source(entity);
>  		mutex_unlock(&fe->dvb->mdev->graph_mutex);
>  	}
>  	mutex_unlock(&fe->dvb->mdev_lock);
> @@ -2941,9 +2944,12 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
>  #ifdef CONFIG_MEDIA_CONTROLLER_DVB
>  		mutex_lock(&fe->dvb->mdev_lock);
>  		if (fe->dvb->mdev) {
> +			struct media_entity *entity;
> +
>  			mutex_lock(&fe->dvb->mdev->graph_mutex);
> -			if (fe->dvb->mdev->disable_source)
> -				fe->dvb->mdev->disable_source(dvbdev->entity);
> +			entity = READ_ONCE(dvbdev->entity);
> +			if (entity && fe->dvb->mdev->disable_source)
> +				fe->dvb->mdev->disable_source(entity);
>  			mutex_unlock(&fe->dvb->mdev->graph_mutex);
>  		}
>  		mutex_unlock(&fe->dvb->mdev_lock);
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> index d753d329502a..bb6369c3abde 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -208,10 +208,20 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
>  {
>  #if defined(CONFIG_MEDIA_CONTROLLER_DVB)
>  	if (dvbdev->entity) {
> -		media_device_unregister_entity(dvbdev->entity);
> -		kfree(dvbdev->entity);
> +		struct media_entity *entity = dvbdev->entity;
> +
> +		/*
> +		 * Clear the pointer before the entity is unregistered and
> +		 * freed.  The frontend release and open paths read it under
> +		 * mdev->graph_mutex and pass it to the disable_source
> +		 * handler, so a stale entity must not stay reachable.  Publish
> +		 * it with WRITE_ONCE() because the store is not serialised by
> +		 * that lock.
> +		 */
> +		WRITE_ONCE(dvbdev->entity, NULL);

I think this can be simplified: just take call mutex_lock(&fe->dvb->mdev->graph_mutex),
then set dvbdev->entity to NULL and unlock.

In __dvb_frontend_open and dvb_frontend_release you can just check if dvbdev->entity is
non-NULL before calling disable_source.

You basically say that in the comment you added: the store is not serialized by
the lock, so just add that lock here.

Regards,

	Hans

> +		media_device_unregister_entity(entity);
> +		kfree(entity);
>  		kfree(dvbdev->pads);
> -		dvbdev->entity = NULL;
>  		dvbdev->pads = NULL;
>  	}
>  

