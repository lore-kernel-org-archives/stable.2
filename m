Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137D78F2F;
	Fri, 26 Jun 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500540; cv=none; b=h5xsAz9TOLDuS2gO3u71J0+7b0GvfLTnhPM77o9eR+9iJ5n8ufncU6utIpiByEiWx/MrK0ZwN3ZxpAAaYg28Vr/lWH40vPzSWHpvkHe1QYmntflZ8m3oqYQHysefba1M85JOwMe2lBIUufHkuF+zpMtziFXtydZyCD0cfEc1xN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500540; c=relaxed/simple;
	bh=4ulhjQOPoFSOF5+tIsxC8bCDVBvg+u6gurSEwkxYMnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDDqIIhMz9wTY0Nqf+MnBAE4XOxOGeopO2GXgwTzCSoMBMktC1RuvA6JzDxgbAFDdChHAUJBnygoHk7BWnY9NXQKjmtrxGf7b9R3eFUgFCv4gBvHclwfFHP5Ap+hOlv/1iREX8VWKQAeuVzCQbBzylM20s8AZCKTWmOjeEyEgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FstiwF0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FstiwF0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02B91F000E9;
	Fri, 26 Jun 2026 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782500539;
	bh=UUIgku0dEeTkAIbEWbmP2c4kgTyRAbCcRnpJ75y3OUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FstiwF0N2TKXY0zUW6qxHZC2DhJ7UIsuxklD9FRC7G5Ub6nedrarR5rIBl62qwf81
	 DAzynZykkyWrvW5K7JOzHlBQLiTqUUaBhY17H9d5DsRO1PjBifTpMzGM0OxuLlJ/FG
	 3m7PYebotrPF7kBpbtauyfrSxcbJ3FLCxiB1bQQPoe14IHV5tbizpn8RPexr6OImz8
	 CN4L3Ve3hxRFNYHDsWNoi9XykmXOopwmIhQU/q6KoqMQUrVX9f6gYm4CAE2dzcM/7g
	 bzb00ieDYhxGq1puMyvJkrkAwRWfMqRR2GTqqKQUJwv/IOMJ0MGU9ZTxFoS4+sQtHg
	 mOku3Cru3MR1w==
Message-ID: <9b3b135c-0e9d-4439-bbe7-877ac9824249@kernel.org>
Date: Fri, 26 Jun 2026 14:02:17 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: drm/amd/display: detect_link_and_local_sink: DP alt
 mode timeout path leaks prev_sink reference
Content-Language: en-US
To: WenTao Liang <vulab@iscas.ac.cn>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: siqueira@igalia.com, alex.hung@amd.com, timur.kristof@gmail.com,
 wenjing.liu@amd.com, Relja.Vojvodic@amd.com, Derek.Lai@amd.com,
 srinivasan.shanmugam@amd.com, clayking@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260626124555.36910-1-vulab@iscas.ac.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260626124555.36910-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/26 07:45, WenTao Liang wrote:
> prev_sink is unconditionally retained via dc_sink_retain at function
>    entry, but the DP alt mode timeout path inside SIGNAL_TYPE_DISPLAY_PORT
>    returns false without releasing prev_sink. All other return paths in the
>    function correctly call dc_sink_release(prev_sink), making this the only
>    missing cleanup.
> 
> Cc: stable@vger.kernel.org
> Fixes: 54618888d1ea ("drm/amd/display: break down dc_link.c")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied, thanks.

> ---
>   drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 794dd6a95918..03bb210ebab8 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1069,8 +1069,11 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>   			    link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
>   
>   				/* if alt mode times out, return false */
> -				if (!wait_for_entering_dp_alt_mode(link))
> +				if (!wait_for_entering_dp_alt_mode(link)) {
> +					if (prev_sink)
> +						dc_sink_release(prev_sink);
>   					return false;
> +				}
>   			}
>   
>   			if (!detect_dp(link, &sink_caps, reason)) {

