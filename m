Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5A3C8732;
	Thu, 20 Aug 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257581; cv=none; b=Cg0zau0nmje2N+V6Z2I0DZSrAWcawbpfsaO7FHZOiYEnV0az5vQMaRY3rR2kSHk1YoujXdEbtyFSh3GhoV2pe4fVCST4/pwMN1XFIWJLHSMEnmbSl/tPDwk2EAdhkyfZfT9xlsZRLz43TeZ7Z/PmWSb56PmFrWDRf4iKady9+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257581; c=relaxed/simple;
	bh=bSt1Sf9CiVGfPE37Poa1eiN/W6EKEfp2el0ne7f3URo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnTznZ8PZaThrgeCcMP+rwpSlKPAoLGhsXK5dKYKok7lNsv/uL2T16NIu/v1hpGX4CLyoVOeN9wf8GykwqyrLh1c4pzNU9G9PyIECk3tdQGALdWsNSa0FsQHgfVbF5+Q9PdCX2hwlZHyfu8Vjzt5mZq/6wMR+LLu4YQltjfDdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB0RLw5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB0RLw5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C19B1F000E9;
	Thu, 20 Aug 2026 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257580;
	bh=GLhngrtwsmPKoPQxSaIufqnOylyEAivx9wbGDMn5D74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WB0RLw5brvcDh8ew03PZsYURAfiGVwzd0Z75LsX6EzKZLG8EHz/ShSPgvwTQPMS7z
	 Jx9XlPIFd+IqooiIwup2Bk+7rNqKx0Uj6BmldWLrfxTsI8yxrRPPCAmY/+tvXw9UD7
	 M/Ma3X0PqnN/azPfsb3N55uLXwAlMcmCE5H7yE5nsPt70zj38PcUEpwBfLDFL+sgst
	 GUsKXMozRhIgLBAx5KudHP85lcQ9KNSPjMQ0mxbrH6zvcURzv4lZ20LZH9pubiuJJc
	 g/5VK39uY5zK3V7fUz7SSXDVUqBjn0/baFYlka+kRIUOfqYITPNsuWcP7kcW6ChzYF
	 KATJIspIlKXRw==
Message-ID: <fc704cf9-4bc5-4c67-9705-1eaf84c41102@kernel.org>
Date: Thu, 20 Aug 2026 15:26:17 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix dc_lock leak on GPU reset error
 paths
Content-Language: en-US
To: Linkai Gong <gonglinkai@kylinos.cn>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Ray Wu <ray.wu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 00:47, Linkai Gong wrote:
> On GPU reset, dm_suspend() takes dc_lock and leaves it for dm_resume()
> to drop. If amdgpu_dm_commit_zero_streams() or dm_dmub_hw_init() fails,
> the function returns with the lock still held. The matching resume path
> is then skipped, so every later dc_lock take hangs.
> 
> Release the cached DC state and unlock before returning the error.
> 
> Fixes: 3cf7a0bc87f0 ("drm/amd/display: Catch failures for amdgpu_dm_commit_zero_streams()")
> Fixes: 2b6943df5413 ("drm/amd/display: Pass up errors for reset GPU that fails to init HW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Great finding and fix.  I'll get this added to amd-staging-drm-next.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 941c1a312824..214aca906fe1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3511,6 +3511,9 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>   		res = amdgpu_dm_commit_zero_streams(dm->dc);
>   		if (res != DC_OK) {
>   			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
> +			dc_state_release(dm->cached_dc_state);
> +			dm->cached_dc_state = NULL;
> +			mutex_unlock(&dm->dc_lock);
>   			return -EINVAL;
>   		}
>   
> @@ -3824,6 +3827,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		r = dm_dmub_hw_init(adev);
>   		if (r) {
>   			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
> +			dc_state_release(dm->cached_dc_state);
> +			dm->cached_dc_state = NULL;
> +			mutex_unlock(&dm->dc_lock);
>   			return r;
>   		}
>   

