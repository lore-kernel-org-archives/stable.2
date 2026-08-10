Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375840243B;
	Mon, 10 Aug 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372109; cv=none; b=Cn/xoIs9ukTW0jr7Va9fyZRIdnWQPNhNK1XIxI38bK72zX5cXbC8uZyyNDXhP6zMTDEuBDPRH6qZ6wMGw3WX+ALR0MNE3h5uA65J6OE7CrUK1tQtfMJQQ6l8wMy1EtlVUSTqUmvI2yTi5mCJtcLucxRys07ks/fV+r1v5SoO/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372109; c=relaxed/simple;
	bh=fR4vyEuSEH9ckuCSquN5BLjeY3tmL0kI39OKYsj0Whk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mP4LKZkaDIJV8e2KzI6osL3hphKgUeXsiVn0oWiukSY828fwRzR+pKx3NKNOoAENPDEwAlXjSHI1RQySF2PjqfC1J04kGs8ukwE7iDPJChM+wLBOw9nFYrCu3DrQT8sVhUcNPAwnzNyOfv+jCL5CgYKmHz+Iyu7dtULRb2zf5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPeSCJYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPeSCJYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57E91F000E9;
	Mon, 10 Aug 2026 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372104;
	bh=6WeQQuxDaUZFR+cOqa3FJtIBcJWTyL8o7aGbUBMcfao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bPeSCJYWY1MweaXJihWfloWrui2AKt3po7gRnzUMcZs/yE2nsC5qT64jLcNeUA6nU
	 5EzrB1efUgh66hj0xHv7tc2gd5ZCaVZjXeEvQg/id46/HYYxEsu8atSeljT45qbybE
	 DuSsh5KPZ/KnnDz8euWtZImBR94+hrSHuUXVMMdOofoYqzU423ZgbWmd9UtTvZOizY
	 I/Zg2pAVX/X5XKFKNwn5OfmqTLVstokIk6N1zMX78/BBZFwti/7Wr5RgtudgFEOtec
	 DR5ncDtEjxjQvOocifxSA9rbZjKT4B1fCzpxPttUEWgMqY5EUgKceYkTc5C7zV94LO
	 4RIYMEvsRNtFQ==
Message-ID: <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
Date: Mon, 10 Aug 2026 09:28:22 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
Content-Language: en-US
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260808120934.2813010-1-lgs201920130244@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260808120934.2813010-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/26 07:09, Guangshuo Li wrote:
> amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
> amdgpu_pci_remove() does not call the matching
> pm_runtime_dont_use_autosuspend().
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Also applied to amd-staging-drm-next.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1aed121f4ddb..e814701bc8fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
>   		pm_runtime_get_sync(dev->dev);
>   		pm_runtime_forbid(dev->dev);
> +		pm_runtime_dont_use_autosuspend(dev->dev);
>   	}
>   
>   	amdgpu_driver_unload_kms(dev);

