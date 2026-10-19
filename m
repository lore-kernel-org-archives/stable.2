Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6C4DEC05;
	Mon, 19 Oct 2026 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415148; cv=none; b=ZkhOVeO+dnk2PJ8t608CukumVJvzL6f4eiAfmz991vf+On37db7eSObeElq+kT+Q9XeWgfrEJUreR5ngjzx4X+Uq5Wp+NCzm9n6zRstgxUPlaia8P+Lx+pkHuDssPAIi/sO5xO7PGqWdH+A79qF9MERvMew4DQ8qdIv92/PGSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415148; c=relaxed/simple;
	bh=bxzKPXpygUF8aC3sfurRz0q6iNQo3y4NA15tF8BO49s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrSrExm7Ah9h3PXwHwd71aXzbKLhe98Yo+NtFxN6XMEKHdCNJPluKrF5hOoYFqKyRcQ1d5heR9X0mMYz+ZD3Q4e9zh7HJiG8rfj+oVp2c629nse1c/27dfucUCULGR7xzMV5YR3syD1mPxNMKxPZW+2Kay72B7n42BWfRKtaGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEfiqCb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEfiqCb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0583B1F000C4;
	Mon, 19 Oct 2026 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415147;
	bh=tK2DVDzNP0ddyRgP5h5BkO2SQZsbh9vJOE5tm8VDsGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KEfiqCb89xC8sUQAdm//tKepMCmC8qfuhU3obu4l8qds0zJ3dDUynIvOj6BA3W6ra
	 SVG9ojQ034h9Tk9VrX8o8eoSEdiAHN2zpwwRqa8cyjLb6Zr8sZhv0+iSTeMZk/nXYa
	 QWUQSbHtBhM2dByLoOltMFuRwALK6wj7KjJRJKVWYPzy9Di/ryH9HorjxNB/V396bA
	 5Y3C45d5+eMsCeyDuJgP6KCmAizQXZ9vO0HtOrvaprtJGYs2LQrfu7GKKyHuoVsNCR
	 wzwCHjherkHto7pLyLOsDP/TVhw9RjY6PLy3SUWA9jBVldNTv+jpjMN6rE3VEiyNeL
	 F2VNohG+ArWfg==
Message-ID: <25a35fa8-9540-4892-8375-1788e6795dfb@kernel.org>
Date: Mon, 19 Oct 2026 15:05:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-mem: only mark the device ready in kdump mode
 with vmcore support
To: Yuho Choi <oss.patchbox@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261016023521.747447-1-oss.patchbox@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261016023521.747447-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 04:35, Yuho Choi wrote:
> virtio_mem_init_kdump() marks the device DRIVER_OK before it checks for
> CONFIG_PROC_VMCORE.  Without vmcore support it then fails with -EBUSY,
> and virtio_mem_probe() deletes the virtqueue on that error path without
> resetting the device first, so the device is left believing the driver
> is ready while its queue points at memory that has been freed.
> 
> Before commit a9403425b3cf ("virtio-mem: mark device ready before
> registering callbacks in kdump mode"), virtio_mem_probe() called
> virtio_device_ready() only after virtio_mem_init() had succeeded, so this
> path never exposed a ready device.
> 
> Move virtio_device_ready() into the CONFIG_PROC_VMCORE branch, right
> before the vmcore callbacks that need it are registered, so the -EBUSY
> path never sets DRIVER_OK.
> 
> Fixes: a9403425b3cf ("virtio-mem: mark device ready before registering callbacks in kdump mode")
> Cc: stable@vger.kernel.org

Which kdump kernel exists that does not enable CONFIG_PROC_VMCORE?

IOW, why should this be stable material?


> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index e18dd736f2ec..b28d2da7d5b6 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2817,9 +2817,9 @@ static int virtio_mem_vmcore_get_device_ram(struct vmcore_cb *cb,
>  
>  static int virtio_mem_init_kdump(struct virtio_mem *vm)
>  {
> +#ifdef CONFIG_PROC_VMCORE
>  	/* We must be prepared to receive a callback immediately. */
>  	virtio_device_ready(vm->vdev);
> -#ifdef CONFIG_PROC_VMCORE
>  	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
>  	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
>  #ifdef CONFIG_PROC_VMCORE_DEVICE_RAM

LGTM, but I am pretty sure it does not make any difference in practice?

-- 
Cheers,

David
