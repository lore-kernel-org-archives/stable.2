Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A500339872;
	Mon, 13 Jul 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959510; cv=pass; b=brfFeYoQyEKp6ID6U1ioLZs07hqJdtvqULU0j2i2urIfJnoD07xg08cBBxSaY72T9OAsO0izDPEhvXRxeERD2OGdYLlAIOyxVv47P2oPfwc5yHDIPXzZPsu1oEP+dGnZDmRX5Mbvzn9qPOG9AWMqvpmBSdd5B6bdwEqOy+ufc0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959510; c=relaxed/simple;
	bh=MDnJQKJbccup7eQA9NUb0j+v7/4PCyahAr6LdgyYPTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1R4At8jx/LEVmRrAJ9p88D1c1Fhyk40cgtebo1mDPNstRVvxXk4i8zoWzX+LurxHY7rIsW5vfDyXy+Qn8UfrcmkWEvtIF/rchng0A9LnGaqo6u5OvE692laKDgNMxTnuwBSTSh8iI8S5gW1xgBB4CflUJEeGTu50BLf6fx+GCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=VNlQsw9J; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="VNlQsw9J"
ARC-Seal: i=1; a=rsa-sha256; t=1783959498; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lgDVtytGLlN0y8fHBEBHfbb5uHP8X5/45bErC93a/x2Jl2INqbyqaJSSdeNibrMh3Y/0o1kMJAVDC10a1YdBXZ8dS8MK9ulVWmIFGNYqHX/WiAYoY+RBw8t2mDj1k3IXoYMHjgvNoCnIvxgwluCoEbUo+R6UPFwQr58PFG6GeWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783959498; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lniYWsZgOOiMUaNjxoy7acQxun7Tot8w2aRKqsFovEQ=; 
	b=cp+FRW+rAJz4X5Rs2ONRmYNEIq7aQ/5EXjTqqT2EQc38TbEPfp1IKAPYkqy74Kr9K1ne4w4p1SLyzgXftuCCiqwde9psGhHIa2K0mOUouv2ri9EeMS8UQbw18GnH+5YISPOHCWAtFAIPtdVK+013hRbotL+M6y7Ep+jyyiwce3U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783959498;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lniYWsZgOOiMUaNjxoy7acQxun7Tot8w2aRKqsFovEQ=;
	b=VNlQsw9JLVxFTTdLCKyoWOZ93rVmHAwcnDA5foFdXSyePo8dWUovv3S9r977h6Ig
	Y/11SLmVjJjaQ3fShVCf9Smpm2NGMCut9O2lBOyytTyXDHt5DhbuR8CvMXEh5ReY/3a
	1ZcPI4JDF74M0NjBgfZP2UA5Yjr5doCDt1nxVfRM=
Received: by mx.zohomail.com with SMTPS id 1783959496461525.9083738973383;
	Mon, 13 Jul 2026 09:18:16 -0700 (PDT)
Message-ID: <3198148a-0343-4fcd-b671-809d33f541bd@collabora.com>
Date: Mon, 13 Jul 2026 19:18:12 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Yiwei Zhang <zzyiwei@google.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625170828.3335431-1-natsu@google.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260625170828.3335431-1-natsu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/25/26 20:08, Jason Macnak wrote:
> Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
> Don't attach GEM to a non-created context in gem_object_open()")
> to virtio_gpu_gem_object_close() to avoid trying to detach
> a resource that was never attached due to a context
> never being created when context_init is supported.
> 
> Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
> Cc: <stable@vger.kernel.org> # v6.14+
> Signed-off-by: Jason Macnak <natsu@google.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 435d37d36034..66c3f6f74e9c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return;
>  
> -	objs = virtio_gpu_array_alloc(1);
> -	if (!objs)
> -		return;
> -	virtio_gpu_array_add_obj(objs, obj);
> +	if (vfpriv->context_created) {
> +		objs = virtio_gpu_array_alloc(1);
> +		if (!objs)
> +			return;
> +		virtio_gpu_array_add_obj(objs, obj);
>  
> -	virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> -					       objs);
> +		virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> +						       objs);
> +	}
>  	virtio_gpu_notify(vgdev);
>  }
>  

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
