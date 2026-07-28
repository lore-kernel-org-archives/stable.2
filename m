Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC3330668
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254667; cv=pass; b=CeBwkTZHXmIrYT7+6/3RlvdAzTcuNFl1OKbtpxI9xjmUiGRLHVzxJREtNL3NsCFqP+x5v9T97lSKVSpFA8oZ7R+b08PaFi+td4Nz4sA2BCy7ElOw7Vm2bFnMc+t0q1u+b0hvLXUmcNcJ2up/zFoPdu0rz2MCkFb4HogPaumZyaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254667; c=relaxed/simple;
	bh=f4hfs70ExUJY3/tOTrWVHMmisYSdNWHwYqR/jsz44w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxLkvdhkd5xEfiJZBlYaXgGLytPxLF+wbIXiEV9RuxCnGArd52y2WDhzf3y7JSRsYPKesuGoHXqKhSiLGgN+xgQsGFh+NWac+f+0LknQ2QRoZQrUHM/LaEUmmnnbewx1NdNiy8nqGrWhy3IZTpVU8HA1C7WkQwJ5mvI6QsF7KKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b=RVKh4/87; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b="RVKh4/87"
ARC-Seal: i=1; a=rsa-sha256; t=1785254661; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fCDXW+xN27AwVDADSVJXlgrNdoCsTkPMyAC9P+zNRHe+EC6oClhMfBOzXCP/uULWl0wTAC3u6ZsE2AMvfMPjzYu0E0hCtuWK9kZtompw4/S8lV8zN6denNNtRDRiVgAoVtB4wRd9hcgmF/3d8TqHdZ6eeztcaBVPgGodjk2kc/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785254661; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g2ZNPfP3HNApN5J6GdDW8YjdQ0sYn+p9DH8T7XAMWkA=; 
	b=KOZzSFuV9xkjZDsCdxswAYl+MDtihcdzv/CAEMemYYuNQmbmvlDc1z0m6TX+8T/p1Rg98w8lpnoTZM3bMh0VOw1zNmOIyYMRyRqdzTeG9/w/S8YWJ+E4RDFpA5jUdK9z8AxSqqp+p6NHyetbjjoOwfV5dALGtD/i4bqefUaBe3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=robert.mader@collabora.com;
	dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785254661;
	s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=g2ZNPfP3HNApN5J6GdDW8YjdQ0sYn+p9DH8T7XAMWkA=;
	b=RVKh4/875GX5RPKRF1DAyLryqAiXrckk+E/U0o7iVU2DzXEsvFWYowxghd2py6wY
	1C78Dy+DdVsBM2oYCOJdzKyxToio7O5sSPnEJ7zS+nDvBPNdTHMh2Sb9uYV56thqg1b
	BZ7L3Mp2klATDE4z4rtxbWEQsdKltCOaP91/nmWU=
Received: by mx.zohomail.com with SMTPS id 1785254659532630.9169189760559;
	Tue, 28 Jul 2026 09:04:19 -0700 (PDT)
Message-ID: <bc61b46f-8833-4785-bb1b-7832011caf07@collabora.com>
Date: Tue, 28 Jul 2026 18:04:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] drm/amd/display: Force GAMCOR for subsampled
 surfaces with PQ/Gamma22/HLG
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-12-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-12-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by: Robert Mader <robert.mader@collabora.com>

On 22.07.26 15:46, Harry Wentland wrote:
> The ROM early-return checks for PQ, Gamma 2.2, and HLG in
> mod_color_calculate_degamma_params() do not consider the map_user_ramp
> parameter. When map_user_ramp is true (indicating a subsampled surface
> that requires post-scaler degamma via GAMCOR), the function still takes
> the ROM path, programming PRE_DEGAM instead.
>
> For subsampled formats the chroma channels must be upsampled by the
> scaler before degamma is applied. PRE_DEGAM sits before the scaler in
> the pipeline (CNVC domain), while GAMCOR sits after it (CM domain).
> Using the ROM for subsampled surfaces means degamma is applied to
> subsampled chroma before upsampling, producing incorrect results.
>
> Fix by gating the dcn_arch ROM capability checks on !map_user_ramp,
> forcing PQ/Gamma22/HLG through the GAMCOR LUT path when the surface
> is subsampled.
>
> Fixes: a8bf71649088 ("drm/amd/display: Internal refactoring to abstract color caps")
> Cc: stable@vger.kernel.org
> Assisted-by: Copilot:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index 03d88e78165d..5786ef5787ac 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -1696,7 +1696,8 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
>   			return true;
>   
>   		if (dc_caps != NULL &&
> -			dc_caps->dpp.dcn_arch == 1) {
> +			dc_caps->dpp.dcn_arch == 1 &&
> +			!map_user_ramp) {
>   
>   			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
>   					dc_caps->dpp.dgam_rom_caps.pq == 1)

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

