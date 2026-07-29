Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E29397942;
	Wed, 29 Jul 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336746; cv=none; b=Lk3pUIFlzF4HBM+7asLSUi995gYTgjDE5xmgYWNyF0WM7xikYTut0aqXLogP4A6JW21G7GNUz8v/BNryBqtyZ3vH5gtTDAsBWi/ebntPo8vnnZUVClgjSe8PfpkIrRpTjU34YFbRn1b6Guzbpdy44hIftsOIV0ooYUobqjIgGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336746; c=relaxed/simple;
	bh=5dyhrCn4RqDuHCMYrqO4tULIXM6lcP98/g+tCfcUi6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2NBNKwHJaOHTeqXMAb0jkhFlQ44njq4a1oha64xbvKOp5bGIYon8p6H8usXVINkzk1gr6m2lbxCjFMuEkCiLz+p9PtHrpc3tGHfAFIHY6NHMfMWZXXFKKl2Rs6N3mk48d14rNcbpgDOM6yfTUbyk3t0weqrhLmsnAP7oD9/BHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vGEDjAwi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vGEDjAwi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271A81684;
	Wed, 29 Jul 2026 07:52:19 -0700 (PDT)
Received: from [10.57.87.210] (unknown [10.57.87.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EFEA3F66F;
	Wed, 29 Jul 2026 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785336743; bh=5dyhrCn4RqDuHCMYrqO4tULIXM6lcP98/g+tCfcUi6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vGEDjAwi89aRlUzQ3mfiWbSWNlrGmUv/7IGhSBWUFYI6OWksy8jsREfF2YO7DtbNy
	 unPQBWRKfowbM2L23xRKkqV/gDUw4Yca7eEF2Qpz/08C5CNV6skwFyJK4HRrxMNno/
	 DKoTa7F5L6XPhl2GeZaun5VmQqo1WT+2OBwcbFro=
Message-ID: <f1ba920e-a5a8-4e70-a107-297ac3b6bfd1@arm.com>
Date: Wed, 29 Jul 2026 15:52:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: harden firmware build-info bounds checks
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260720113212.11981-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720113212.11981-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2026 12:32, Osama Abdelkader wrote:
> panthor_fw_read_build_info() checks whether the metadata range fits in the
> firmware image with hdr.meta_start + hdr.meta_size. Both fields are u32, so
> the addition can wrap and let an out-of-bounds range pass validation.
> 
> The function also reads the "git_sha: " prefix without first checking that
> the metadata is long enough, and meta_size == 0 can underflow the NULL
> terminator index.
> 
> Use subtraction-based bounds checking and reject metadata that is too short
> to contain the expected prefix and trailing NULL byte.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 6335893d3f16..9d0e1fafdce2 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -709,7 +709,8 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
>  		return ret;
>  
>  	if (hdr.meta_start > fw->size ||
> -	    hdr.meta_start + hdr.meta_size > fw->size) {
> +	    hdr.meta_size > fw->size - hdr.meta_start ||
> +	    hdr.meta_size <= header_len) {
>  		drm_err(&ptdev->base, "Firmware build info corrupt\n");
>  		/* We don't need the build info, so continue */
>  		return 0;

