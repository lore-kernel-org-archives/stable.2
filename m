Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F663AAF60;
	Tue, 18 Aug 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066660; cv=none; b=e1oqaLhmSBtPfYgvwcQDvueNohZuUrvKbLnhV6X8tbvYPAAQ1so3+DKZkHZW/KDTmT6CDLMkegwCV40J+E9iuXr4NvKZ9J14aOaFXrdcuHTUvlSIPUMv0tvuEwQR+q8gaEWUMx4lGOvgKvVLXOSHB93BczNzQD27h3IBzN/9yQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066660; c=relaxed/simple;
	bh=SXc6OHCJ2XEnQ7dB6AGR6IDWnUjrhTVT6Bd7ktvsvso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNAXNkJnZdLhH5vK5jYVwmUrkWw4Q5W1YBRNT9xWe3NQkhfIP2KK2hFjMnlvAyNOTX1aRvmk+rtPiwYYXNi6wFmH1IjcqgVo9EqFEWXFdDpsTj2aZMsuGMKa6jkaFBWuYYi8UtC6D8myA3kWVIh6iMpnSOwagQa3ZTisZtlnNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVOPS/je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVOPS/je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CB61F000E9;
	Tue, 18 Aug 2026 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066659;
	bh=aRbBVPiBjbPz/DYM4ElmJlf9jEULpGpzKo107yoQqcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CVOPS/jeNePyCrHbH2zQU8nXfIW+7tvr8O38pz7xKnYTmqAbFW0grjHreEiei/K3l
	 zn3d+D2ezkHJHWg6M80Cm7pkQ6nbKVftO7RdGmA/x+lfe9b/caEfFhUWX4MeUcWBXD
	 tZyBHreUuA7iCPlb2lM6rvrl9QVtJURqLwtksirek7Wd6TTmPbssbf/0bgkLfLl7TY
	 wRoau6Z+tgGWOw+V4Ndp2Lk59fvUwaUOY0gojnvVs9/SYUc9QblFPW9TLjEUa/SPZd
	 TLmDsbbqO3INKrdJlJHAgFWAFzQcgmY3JsGDlQj6cV8sMq5YfOvjBQHjqyms3GNe65
	 8Swl1XIwwu9cg==
Message-ID: <8b40ff5c-a18e-42e0-9adb-13ee86ab0cfb@kernel.org>
Date: Tue, 18 Aug 2026 18:24:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] media: microchip-isc: AWB, stream-stop and
 endpoint-ref fixes
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 09:51, Balakrishnan Sambath wrote:
> This series has a few fixes for the Microchip ISC/XISC driver, found
> while testing and from the feedback on the combined series [1].
> 
> Fixes only, sent ahead of the enhancements so they can reach stable.
> All but the two pfe_cfg0_bps cleanups carry a Fixes tag and Cc: stable.
> 
> [1] https://lore.kernel.org/r/20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
> Changes in v5:
> - Put the endpoint of_node_put() inside the parse loop; take a
>   reference on the stored endpoint (Eugen).
> - Move the histogram-disable and AWB flush into isc_configure() on the
>   isc_update_profile() failure path (Eugen).
> - Collect Eugen's Reviewed-by on the awb_mutex, WB-not-streaming and
>   WB-masking patches.
> - Link to v4: https://lore.kernel.org/r/20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com
> 
> Changes in v4:
> - Retarget the Fixes: tags to the atmel-isc commits that introduced
>   each bug; microchip-isc is a verbatim copy, so the real origin is
>   older. Kept the Reviewed-by tags as only the Fixes: SHAs changed.
>   Let me know if you disagree.
> - Init the ISC mutexes with devm_mutex_init() at probe, and drop the
>   dead isc_async_complete_err label (Eugen).
> - Drop a stale FIELD_PREP comment.
> - Link to v3: https://lore.kernel.org/r/20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com
> 
> Changes in v3:
> - Rewrite the WB offset/gain register writes with FIELD_PREP() (Eugen). No
>   functional change; verified on SAMA7G5-EK.
> - Collect Eugen's Reviewed-by on the PFE_CFG0 and macro-typo patches.
> - Link to v2: https://lore.kernel.org/r/20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com
> 
> Changes in v2:
> - Squash the stop and start-error histogram/AWB-flush patches into one (Eugen).
> - Store pfe_cfg0_bps unshifted, apply with FIELD_PREP() at the write (Eugen).
> - Skip the WB register writes during the stop window too (isc->stop check).
> - New patch: fix the ISC_PFG_CFG0_BPS macro name typo.
> - Add Eugen's Reviewed-by on the IRQ-sync patch.
> - Link to v1: https://lore.kernel.org/r/20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com
> 
> ---
> Balakrishnan Sambath (10):
>       media: microchip-isc: fix awb_mutex and lock lifecycle
>       media: microchip-isc: take a reference on the parsed endpoints
>       media: microchip-isc: synchronize the IRQ before disabling clocks on stop
>       media: microchip-isc: disable histogram and flush AWB work on teardown
>       media: microchip-isc: do not touch WB registers when not streaming
>       media: microchip-isc: store the unshifted PFE_CFG0 BPS value
>       media: microchip-isc: fix ISC_PFG_CFG0_BPS macro name typo
>       media: microchip-isc: fix PM runtime leak in AWB work handler
>       media: microchip-isc: fix SBGGR10 Bayer pattern
>       media: microchip-isc: fix WB offset and gain register field masking
> 
>  .../media/platform/microchip/microchip-isc-base.c  | 82 ++++++++++++++--------
>  .../media/platform/microchip/microchip-isc-regs.h  | 16 +++--
>  drivers/media/platform/microchip/microchip-isc.h   |  5 +-
>  .../platform/microchip/microchip-sama5d2-isc.c     | 48 +++++++++----
>  .../platform/microchip/microchip-sama7g5-isc.c     | 48 +++++++++----
>  5 files changed, 133 insertions(+), 66 deletions(-)
> ---
> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> change-id: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1
> 
> Best regards,


All,

I reviewed the whole series to the best of my ability, from my
perspective it's good to go.
I will leave it to Hans or others to have a look if it's good enough to
be merged.

Eugen
