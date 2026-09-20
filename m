Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538D23E334;
	Sun, 20 Sep 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928292; cv=pass; b=Sydw81HjT7Cfj8jo+w1bRwHE0wWShbM91aGMBc8CXIM6hdPov4dxPf4TDQQIS0535kmp3LmDZrOg1Mf7iBl8vIAkY+hRFbe96rBsFD3mJpx4D9MLTQmX8Gq2DHAPv9LvHaar1jFLfraKh7QYbjTxmC8jTLoPDHv4JNbZz4ZiXnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928292; c=relaxed/simple;
	bh=S+LOcEE1DbE35+dSTVsPbu8xY6UuKl8h6wobiBS0di4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7fNOhu8xs2+VumgMqSNuisKKLAhAwJzI6nEATiJ5NaBbm3b63iTudQqiMdyx2n039CHUGf8Yy8mHBs61niKGNsKrFZS/NgUomG0iUJapvTW6wTqpr6u8D7eytA81TrcJcPnTrnDxxwgvJsV6w5ozjPj/uIVBFqfY5Ngd5ZgkxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=KH/V+zG7; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="KH/V+zG7"
ARC-Seal: i=1; a=rsa-sha256; t=1789928282; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SAEnyvZpKItdGgtrwdgNDa7dT/EjfXwLBb/WpFBZkReEP/2OIJEJBF5vJea3AdaqUVBqz5dlqjEefHJ3qHjMb0KHNhzhIKiAu9CVmOmxqMTmrPA6oKQrXuPVmbESNam/XZoaCIs+PjiMBv7C5Lmeemtqk/p19rnC4OheZf74zoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789928282; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GFNHSv1bkiLsdkm43V7QlYc8Y5ZyVjeQhgBrgRct49w=; 
	b=HRv+n9CP4ZLkPXKGGWXaXxxNx5rcWeszrsx022R2COaWcXFWAyAqMJrIHp1fzi/QBc+TbfZqRo86UHikxBK529yvemScuE2zo0dhtoy/ZTWlEJ1EJcUh5+j55XpMTTeOFuuiV2yQoj5TdrIHr0j/RMQhEg2hjs+QFLCsMVA31e8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789928282;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GFNHSv1bkiLsdkm43V7QlYc8Y5ZyVjeQhgBrgRct49w=;
	b=KH/V+zG7bQ2krktLE8jd7CGhj2NhGFaNts1+cllKcOQMKu2sv5cbFJ5nOWJoIeaa
	wCOdFpd4k8HX18/wS9MKix/AlUrvg5fE8JnChgUvX+6FEywf+WVPcoIKVMWg+WX5jsB
	2QVPcpgyBFuDwmlFV4zwT8tNBwYv/ObPUWkInSiA=
Received: by smtp.zohomail.com with SMTPS id 1789928281835764.7553887960684;
	Sun, 20 Sep 2026 11:18:01 -0700 (PDT)
Message-ID: <7452e614-91ff-48b8-b2ee-b01285985bf4@collabora.com>
Date: Sun, 20 Sep 2026 21:17:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fix memory leak of fence event on execbuffer
 failure
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, airlied@redhat.com,
 kraxel@redhat.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux.dev, gurchetansingh@chromium.org
References: <D320EAB5680C1411+20260908121323.2405044-1-peiyang_he@smail.nju.edu.cn>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <D320EAB5680C1411+20260908121323.2405044-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/8/26 15:13, Peiyang He wrote:
> virtio_gpu_execbuffer_ioctl() reserves a DRM event with
> drm_event_reserve_init() when VIRTGPU_EXECBUF_RING_IDX selects a ring that
> userspace has enabled polling for. virtio_gpu_init_submit() does this
> before the BO handles, the command buffer, the syncobj arrays and the
> in-fence are processed, so every later error path runs with the event
> already pending, including plain argument validation failures such as an
> invalid bo_handle or an in-syncobj that carries no fence.
> 
> On those paths, virtio_gpu_cleanup_submit() drops the out-fence without
> cancelling the event. The fence is freed without ever having been emitted,
> taking the only driver-side pointer to the event with it. Closing the DRM
> file does not help. drm_events_release() unlinks pending events but
> deliberately leaves the freeing to the driver's later drm_send_event(),
> which never runs for an orphaned event, so the allocation is leaked
> permanently.
> 
> Found when fuzzing the virtio driver with Syzkaller:
> 
> 	BUG: memory leak
> 	unreferenced object 0xffff88802c176e80 (size 96):
> 	comm "syz.1.367", pid 10561, jiffies 4294960122
> 	hex dump (first 32 bytes):
> 		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 		c8 6e 17 2c 80 88 ff ff 00 00 00 00 00 00 00 00  .n.,............
> 	backtrace (crc e1973c6b):
> 		kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
> 		slab_post_alloc_hook mm/slub.c:4597 [inline]
> 		slab_alloc_node mm/slub.c:4917 [inline]
> 		__kmalloc_cache_noprof+0x49d/0x6f0 mm/slub.c:5485
> 		_kmalloc_noprof include/linux/slab.h:988 [inline]
> 		_kzalloc_noprof include/linux/slab.h:1309 [inline]
> 		virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:282 [inline]
> 		virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
> 		virtio_gpu_execbuffer_ioctl+0xbbf/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
> 		drm_ioctl_kernel+0x1f4/0x3e0 drivers/gpu/drm/drm_ioctl.c:817
> 		drm_ioctl+0x5f4/0xc70 drivers/gpu/drm/drm_ioctl.c:914
> 		vfs_ioctl fs/ioctl.c:51 [inline]
> 		__do_sys_ioctl fs/ioctl.c:597 [inline]
> 		__se_sys_ioctl fs/ioctl.c:583 [inline]
> 		__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> 		do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> 		do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
> 		entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fix by cancelling and freeing the DRM event on the execbuffer error path
> before dropping the fence. Clear the fence's event pointer after
> cancellation so it does not retain a dangling pointer.
> 
> Fixes: cd7f5ca33585 ("drm/virtio: implement context init: add virtio_gpu_fence_event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.6-luna
> ---
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
> index 32cb1e4aa425..734b1e976a75 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -538,6 +538,10 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  	virtio_gpu_process_post_deps(&submit);
>  	virtio_gpu_complete_submit(&submit);
>  cleanup:
> +	if (ret && submit.out_fence && submit.out_fence->e) {
> +		drm_event_cancel_free(dev, &submit.out_fence->e->base);
> +		submit.out_fence->e = NULL;
> +	}
>  	virtio_gpu_cleanup_submit(&submit);
>  
>  	return ret;

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
