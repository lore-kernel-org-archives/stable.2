Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646172;
	b=sJd3JpbbjxivWCqZY+jBtIyXIYoNcF9nbGX0uae6jnVwMqt9t5ZcuTZv3a1rHjFrS9OV
	 AS6326jKjeKbdhWN+rDuImyDmvSMWMleLDW84+07Js2XxSht4QlD4HAvdVwUJvL17QfJ3
	 AbvTRT3bPDo0z90UX4C2S0RnBANpDT2zawyZdah24d7zLxblWnJejtvWMuqw6WfxCkATn
	 SUnv6aIS36TDczuSFcVknMfnnCQNXR2TNqCMYOlZ4UHzeThyzBHMeuBPH01niN4h9dvk5
	 StYvo7bmWZZolRNX7oEIN1zfkvkKHYMY2Qau3yr32Qpmi4NoQeiuiEho0kwsqonIJhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646172;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp;
	bh=LP7BoCVBxPhUMUPhfbr+aqt/RVpa7D36N1hv0qrlJB8=;
	b=FbkukaxxBmyOJEcPE4sDPbccTuqstY1PnXiQjXsTJpOhCqDrg5iQ3hzys5ujyTFjqGBP
	 dPGsT781cZ3h9hU2r8jNfk2yWqg9YK/EM/8E5WgAMJTCBehM9u1VzYmLQ+IZq21/kqgfW
	 Q4iuViS8gYAqTPUl4re8mWUdl/LSfbzN0Xn/0KlqGjDvJKp5gxTDlRn75WTohSV5IF29Z
	 JKyQxPVtGNz5d6TQNsYaLdiS9RS4L/p3msxB5avLH1KtwSPF81LtHuk9Rp/MwG0TEhyrP
	 NxEAGy5GStlRXn9NQeuGZ+nBnqNagxenFZhOm4CbVFaJU7Wt+ufNpqdGj104ZP/pP5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Nkw7FBPV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0E606A333;
	Mon,  2 Nov 2026 19:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CF0E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Nkw7FBPV
ARC-Seal: i=1; a=rsa-sha256; t=1793646145; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lyHtN/OQf4/fEDUPE3VjR823ZkCGOXg72KDOm9A1D46sCf0q6TWJ4Jl0j4vIUhL6Xu5b/Wyrn9qvQAf63AZLeZ1N76QSQ6v6LLb+O4Us9dvfXwDllSqaFAOmokN9x3bS296QLtJrpotZcGMfMjrQTZGcGl/zX0605ktgHLLz7x8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793646145; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LP7BoCVBxPhUMUPhfbr+aqt/RVpa7D36N1hv0qrlJB8=; 
	b=NydjsdqOJODl7ZA2fSTfScuEHlCb6CysohZ3JuC6Unom+k0SQm9bf6sJya36VmRtqQ5InqLpdAmtg64Dr+4HS7qE5D48YAIfAs6cH0Omv9E8LtWq3GRTCmNdudw2un8KZt3UkhUF3QESU609ujAs07lsrprT26etfkVANgqwrjo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Nkw7FBPVJRMUR6fW9lpzirC3izgdA1AaVoeeVrTALRrPIBCiCh+TKCmsIsizkpbndSEiGoMnPv21C5qyAsz+lO9z3t6fHv8SEgfG1fE1dH6n9RNQ9tK4aumMJf1xl6LrWa4ELw1x0RpssjuzINQwok9t+qMFP1SK7pIDpRR7IBY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=LP7BoCVBxPhUMUPhfbr+aqt/RVpa7D36N1hv0qrlJB8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793646143102219.22841726208105;
	Mon, 2 Nov 2026 11:02:23 -0800 (PST)
Date: Mon, 2 Nov 2026 19:02:19 +0000
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, boris.brezillon@collabora.com, 
	dri-devel@lists.freedesktop.org, eric@anholt.net, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, 
	simona@ffwll.ch, steven.price@arm.com, tomeu@tomeuvizoso.net, tzimmermann@suse.de, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Fix runtime PM leak in panfrost_remove()
Message-ID: <aujeIGwhGjLo4thb@sobremesa>
References: <20260916180813.2090648-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916180813.2090648-1-vulab@iscas.ac.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.627.56

Hi Wentao, thanks for the patch.

However, a fix for the same issue had been in the making for some time. It's already been upstreamed:
e9672bf9382f ("drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove")

Kind Regards,
Adrian

On 16.09.2026 18:08, Wentao Liang wrote:
> The pm_runtime_get_sync() call keeps the device awake while the
> hardware is torn down, but the usage counter it takes is never
> dropped, so the count is left permanently elevated once runtime PM
> has been disabled.  Drop it with pm_runtime_put_noidle() once the
> device has been marked suspended.
> 
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 074c0995ddc2..6d047ca7e208 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1029,6 +1029,7 @@ static void panfrost_remove(struct platform_device *pdev)
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  }
>  
>  static ssize_t profiling_show(struct device *dev,
> -- 
> 2.34.1

Adrian Larumbe
