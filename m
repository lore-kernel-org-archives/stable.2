Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6032B10E;
	Thu, 13 Aug 2026 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649928; cv=none; b=SlRltt4tvwdWlI9bzVeR3QFnGsu3xCGVM1v2vTV79+tuoyx2y1M00cvc/Q+MoY+SKj0oNCHtBfvU6pXY8ZitKPb2+En1xqCca1EGnEB9PSJvkf8vve3TEuo4iEjKuo8lbVgjIllvTlDJNHENoXXo722rjwa+RVwxDkBxNontATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649928; c=relaxed/simple;
	bh=A+a64mQm97l5HbSVkJn9AZG/kupkozWuzXhfYLdNiMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akxvP9m94h3Y1lv3pGmErBWzJhAcCG1sllk0H4XrFl0GqpUL+GKHb/MoiNjrb8g0zOpxkCxyIx9wtUI5i8yzsPl7mTaNVbhsllYPWeH6SF2OUlBLe/+WcnHPJqYEsU4Z0gUoDmhst8RMvcHh8RwT4xqLPVcE89Txl/1oqlYPLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KITOZQWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KITOZQWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586351F000E9;
	Thu, 13 Aug 2026 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786649927;
	bh=dICXO7+0Rud/oDHZkiYIFj47TYUXR2epDxTQFHgDpGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KITOZQWQIcY6An7SP/U3Ps20OvV4uGM2z2NIyyNaPDmCscBhflgTnTPXXRei/1o9H
	 p5IJVxF3lJ+LJgdX5awscIHjsFzT8knBVxOFwEZ5yZbhFp19/UO4fWnaIw0CoDw51K
	 tTCCdhkFdpjW1dTACsdxXgCG6MYRZ7niEbXPj/6Agvd6dxxdNKC5ok6pudIgiO+fEr
	 kVMRh4OwWCKckBaYMNSfDGGBzQR7A0KqU0Ga1Bx9kYNU1EMan203FSBND2e8v2cNj3
	 QRqi5Y7vrudDkN4bXlU+aK8XZtMyDN45M2t2X8CPg71MA2ZdO3u17k07WHHLZH6NlG
	 XccyWdOIBvAyw==
Message-ID: <7bb4075c-4186-4f20-8006-2e414429463a@kernel.org>
Date: Thu, 13 Aug 2026 14:38:45 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range
Content-Language: en-US
To: Akhmed Zhitaev <zhitaevakh@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260813170959.22073-1-zhitaevakh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 12:09, Akhmed Zhitaev wrote:
> Custom brightness curves use an 8-bit input signal.  After exporting the
> full PWM range to userspace, the curve normalizer still divides requests
> by the physical PWM span.  On panels with a nonzero minimum PWM level,
> this can produce a curve input greater than 255 and send an invalid
> backlight level to DC.
> 
> Scale the userspace [0..max] range to the curve's [0..255] range
> instead.  This retains the full advertised range and keeps the reverse
> readback conversion unchanged.
> 
> Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>

Thanks for this.

We have moved the code in amd-staging-drm-next

https://gitlab.freedesktop.org/agd5f/linux/-/commit/6c2b46e9774f13e45985f6da9f7d5f8458767b98

As your changes are trivial, I'll adjust while commiting.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 40d82a3ee..533c69f0b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>   	return 1;
>   }
>   
> -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> +static inline u32 scale_input_to_fw(int max, u64 input)
>   {
> -	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
> +	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
>   }
>   
>   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
>   				      unsigned int min, unsigned int max,
>   				      uint32_t *user_brightness)
>   {
> -	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
> +	u32 brightness = scale_input_to_fw(max, *user_brightness);
>   	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
>   	int left, right;
>   

