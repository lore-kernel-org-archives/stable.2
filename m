Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DE3563E8
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551824; cv=none; b=ZFTh7LWqQwCPDuVInLd3wERuhgILjmstM9c/GCkPuay9RIbd7l+8OQkgI84pbHpsUSjFdz1uY0AFTKQVH12/0WpEiLABXf7JfN0E0OxkGqe9ABdZFN4CSJoq5Xr5COmUwt9saoIAvAFRv6yK+kRLdwm6eml2iZ02dtpkl6ebong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551824; c=relaxed/simple;
	bh=dTnj/2VDgStGzVH3QyxyMDij3G7WSzg4I53PPRDbOTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ16wZdLQxvem6SanwJ2YKXyjkNFQaCQ3aqMv6hgGme40VH2HZxuL2cjAiKRYBw3p46UpgvYWGxNqdf5YLg78UfZ9OUCSFop9QdB/9TnOYTgxXJVCaC6aszHQxuNpFFMIinikRF8c0VFOCdji/snYnek/93RKoEf64np0Wgd7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B6EF/bCt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B6EF/bCt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=x09cVUmbjUsyEQozm05jQQnrP22oqKc98mmcC4suX+0=; b=B6EF/bCtTAnDBLM/0HgeoLpE/U
	tHoequgwkaEFSNWvs04Wfjr5W8g7n82XJAbxx32I+UahX4UAl7VJ1LZNrzu5cUY3pWoNwHVndFXop
	qxuU/gDw/56SvyzcWig+3VnUMUuv4XiXgEl40Y9ZUivkbI6USgplZKP89B+gYOWgUft1iUkIAckhE
	YnzM7AydlwRgAQM2FPD8om7+fF9NBD95hXGFP6sn/pRIgKCjJYDdzl2+IWiT5FQvhYDHvqlbSCpyp
	rbbx5cWwfhFziMB12YImehEFi2BjTVaTX/DMKHxY/O8UOyavH7kHfhDuDAiY106iZm1jPr4WiFz7V
	0qz2rlng==;
Received: from [31.4.134.207] (helo=[192.168.1.126])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wuBjt-0009rV-5O; Wed, 12 Aug 2026 18:23:37 +0200
Message-ID: <217a3dbf-a02c-4dd0-9edf-4a9500206a9f@igalia.com>
Date: Wed, 12 Aug 2026 18:23:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: validate plane degamma LUT size for
 private color prop
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260804210405.278934-1-harry.wentland@amd.com>
 <20260804210405.278934-2-harry.wentland@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260804210405.278934-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/08/2026 23:04, Harry Wentland wrote:
> Unlike the CRTC degamma path, which is guarded by
> amdgpu_dm_verify_lut_sizes(), the per-plane degamma LUT size was never
> validated before use. __set_dm_plane_degamma() passed the user-supplied
> size straight into __is_lut_linear() and, for a non-linear LUT, into
> __set_input_tf() -> __drm_lut_to_dc_gamma(), the latter always iterating
> MAX_COLOR_LUT_ENTRIES entries regardless of the actual LUT size.
>
> A malformed AMD_PLANE_DEGAMMA_LUT blob (e.g. a single entry) could thus
> trigger a divide-by-zero in __is_lut_linear() or an out-of-bounds read in
> __drm_lut_to_dc_gamma(). Reject any plane degamma LUT whose size does not
> match MAX_COLOR_LUT_ENTRIES, mirroring the invariant the code already
> asserts a few lines below (and which the CRTC path enforces).
>
> The AMD_PLANE_DEGAMMA_LUT property is only exposed on builds with
> AMD_PRIVATE_COLOR defined.
>
> Fixes: 980f8710075a ("drm/amd/display: add plane degamma TF and LUT support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 26e5c89375a5..d55dc06167a8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1495,6 +1495,13 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
>   	degamma_lut = __extract_blob_lut(dm_plane_state->degamma_lut,
>   					 &degamma_size);
>   
> +	if (degamma_lut && degamma_size != MAX_COLOR_LUT_ENTRIES) {
> +		drm_dbg(plane_state->state->dev,
> +			"Invalid Plane Degamma LUT size. Should be %u but got %u.\n",
> +			MAX_COLOR_LUT_ENTRIES, degamma_size);
> +		return -EINVAL;
> +	}
> +

LGTM

Thanks!

Reviewed-by: Melissa Wen <mwen@igalia.com>

>   	has_degamma_lut = degamma_lut &&
>   			  !__is_lut_linear(degamma_lut, degamma_size);
>   

