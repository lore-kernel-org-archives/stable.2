Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F74A9D44;
	Tue, 13 Oct 2026 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932208; cv=pass; b=VFY1ADXec5ShA83Gh2EacPnUE3yAgsjFyORDEZHwCv2eTQ2WNXzxO79yyhx3lIv/s+jTIJzpfElFmfAVIYkJmLAMkNoBnKlEWRyckQVKDH4rFVgova2NTruCB5S1kmpdYd4WrfzghMY72QmpZCoSGMk+kwd6gzRbR1BPLl35dUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932208; c=relaxed/simple;
	bh=bAB7dsPzcz67xHbWPAM5JI8JnYKNsnf4lQG5iXou8Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBLLOaIRCkw3O0Y3iakDAlwsiFsbNkaYgKutSHVk0mI5fr5BiUCBKPD2mV80KSJjZL63GUwoS1ZorZOxTdt85N5xhBlSdFVlIydH6W+BSvsoYZMnT5c2UkTSOU6aMPrZM91ggGOI/S02raYbwQS2AICDuXUltUHPHqgfPXW4rFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=kHdQx/yk; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="kHdQx/yk"
ARC-Seal: i=1; a=rsa-sha256; t=1791932185; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bNVvhYdc3iC1WLIzS0fZNO0qcM7zrvTBm9pfdKoDA+dxTRkfdxZ02pISKtbT+BzLrYeO2J8AEcGXsYm5GU9j5xnM7/R2UoMGMmX6PA/b1pCkFxUNEjQo6kNQHn47mkxfyzHNWkJKikzFz5zhcFpQouVnvAmepLUuKIHvdLyJrro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791932185; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=is/u4zp7L+bid1uy+FMp9cPkHU9FjH1P79khU+iYi1s=; 
	b=jpMfXxH3wSI0OkaZcD1lHZ2MWkAxUqb7eEgx5BNwsaqFP/Z6lM17Rszj8IRfgnxI3BAuYq/ezE5UnKUFZzvsQV+ccz5UTSc5e1sO2gqtaiFBYmkYKlUXqydc1zg7NzPTJLGotAgvxZyDwrtxT57yu2fFdSl2IIhQaGVfPrI4dZ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791932185;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=is/u4zp7L+bid1uy+FMp9cPkHU9FjH1P79khU+iYi1s=;
	b=kHdQx/yka/sQoYcL1VofEdOgUAAShvGiyVxKxTPRMe/IE6JEaiemAH47QtlGVkz6
	I4uQTtv82fP4bvdZ123YaiAYKd1b3pn9jVbRmrSxChZD8Poippv5dh0i4U70oxlK1Wf
	yl7pBDuKVqWKUAmcaN1z6zNHIyvdCpEw4ILiwgtA=
Received: by smtp.zohomail.com with SMTPS id 1791932183629232.553043639708;
	Tue, 13 Oct 2026 15:56:23 -0700 (PDT)
Message-ID: <05f4612c-a034-4e77-9a00-9cadd9f7e2c9@collabora.com>
Date: Wed, 14 Oct 2026 01:56:19 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Reset device before deleting virtqueues on
 freeze
To: Yuho Choi <oss.patchbox@gmail.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260926202040.1313385-1-oss.patchbox@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260926202040.1313385-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/26/26 23:20, Yuho Choi wrote:
> virtgpu_freeze() waits for the control and cursor queues to drain and
> then deletes the virtqueues, but nothing tells the device to stop first.
> del_vqs() frees the vring backing, but does not provide a generic device
> quiesce operation. In particular, modern virtio-pci keeps enabled queues
> active until the device is reset, so the device is left DRIVER_OK with
> its queues pointing at memory that has been freed and may be reused while
> the guest is suspended. virtio_device_restore() only resets the device
> later, on resume.
> 
> Reset the device before deleting the virtqueues, the way
> virtio_gpu_deinit() already does on removal.
> 
> Fixes: cad6a879a7fb ("drm/virtio: Freeze and restore hooks to support suspend and resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 2aaa7cb08085..52c174f9bff7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -225,6 +225,7 @@ static int virtgpu_freeze(struct virtio_device *vdev)
>  		goto err_resume;
>  	}
>  
> +	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
>  
>  	return 0;

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
