Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD639020C
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551665; cv=none; b=QE6UsPaO2TmCZKbwdzHYejqYZ80ejZjJm5D0zy9AOEv/dgYe8jqty4HBxrOyM+rPiUiEu1rft2TVLOc4ga9hUPGcqM67IaJY+nGSGok/ugZWsfeDuN9lsZodqX7riZKYjNT7SzSYdtzMsaKYtflwEfpgdZKEwJi6mUKFRboGaM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551665; c=relaxed/simple;
	bh=61Cig/iItHGXB+ps5S2ixP3KbBrMC0sV0qUuwmtcmOQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F9ZQ64IWe0z8QsnD1t5etMFg0chtDJQYWbwlrcsrKL1R9hb5MNAzAvPcbZw0Un2GpMBlFQ6uC/n7ZfLHn5qEJJAW2HZ7m8eq/iH+G79Ow7dwBw6npJLif2OBd9HpZic0oYJstvE6SxhWJ413/7U5H42eJ6FV+q+QAms6pt8z0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AcMed5AY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AcMed5AY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=RCGHjLq991hzKf9SIxopw6vv85Z4pDkVFoa9AcUOVfY=; b=AcMed5AYL/aiXrVMBP+Ppv1JlK
	Qx5Lnjhd2LVhsbOY3H1aP/qjQ3ZyHICgMMKw1ukp0gGQb5il4j7PrjjVq32/lkMtmnj0QXvnvtKsX
	oD32h8WuH5DKx4Z8+LS9JZp2z7rUt0eSIGMAK1DiqxByQeLdoBFyQtawgugpYeDzYo+RpobjMfgX3
	GmR2fz4lJ8muZ1Hcwlcxt7kiXO1viqfPH5PFzmhdAZsFHjlpJ2ZWerFp3n303Tmr9u0E1I2rv5hEt
	y1SX701KWP1/ywJBWfTmBNMe+Pv7P6ktWepkQUIdtlJ6OWhiAglk0h0l/7Wgn76X3xx8SxYzgx1hs
	EGFaAdVA==;
Received: from [31.4.134.207] (helo=[192.168.1.126])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wuBhK-0009gG-Am; Wed, 12 Aug 2026 18:20:58 +0200
Message-ID: <8d7306c8-94b8-4e8b-b9e0-5f8d43a67be4@igalia.com>
Date: Wed, 12 Aug 2026 18:20:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 1/2] drm/amd/display: avoid divide-by-zero in
 __is_lut_linear()
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260804210405.278934-1-harry.wentland@amd.com>
Content-Language: en-US
In-Reply-To: <20260804210405.278934-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/08/2026 23:04, Harry Wentland wrote:
> __is_lut_linear() computes the expected value of each entry with
>
> 	expected = i * MAX_DRM_LUT_VALUE / (size - 1);
>
> If it is ever called with a single-entry LUT, size - 1 is zero and the
> kernel takes a divide error (#DE). A LUT with fewer than two entries
> cannot describe a linear mapping anyway, so return false early instead
> of dividing by zero.
>
> Fixes: 086247a4b2fb ("drm/amd/display: Use 4096 lut entries")
> Cc:stable@vger.kernel.org
> Signed-off-by: Harry Wentland<harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 7b68c6846039..26e5c89375a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -471,6 +471,12 @@ bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
>   	uint32_t expected;
>   	int delta;
>   
> +	/* A LUT with fewer than two entries can't be interpolated and would
> +	 * divide by zero below (size - 1); it can't be treated as linear.
> +	 */
> +	if (size < 2)
> +		return false;
> +

LGTM

Reviewed-by: Melissa Wen <mwen@igalia.com>

>   	for (i = 0; i < size; i++) {
>   		/* All color values should equal */
>   		if ((lut[i].red != lut[i].green) || (lut[i].green != lut[i].blue))

