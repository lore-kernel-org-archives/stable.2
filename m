Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6639C012
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683651; cv=none; b=rkCLq/bbBCi8aby9wtX5x9YOwfISAGUv5sOsKDGEwo6jTVG57iIz5JkQXCkuDyYv4rBlPstSzISaTa3CkcKDMnwPV6W13p3ltMum+QtgPRk0OUSDpTc+/QFn2o1gh2kWKJ53mpqYjOUS2Y2gzrlsqPcaWMoiaUyQhnafhVJIxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683651; c=relaxed/simple;
	bh=XKpGSa6s9nYxBV3HfdYoox7LOBsWfxOOqZMTSRQvqWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3yM9x3UbYdsI0W9TdNebFcLpSpgnQhVWValZPj5Yg+kmANPGw5E9LNNxJYDNUxgspWLhKBHZIOjwvTUUTnFqOl7c3R8IL4d9+Uc464NNB/gjsZqgf0syO6I3leqkjsrW0UCSDphDFC1CIUh7sAp8FfxsA1JaJY5zi7wABc7xgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SkNn4ga8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SkNn4ga8"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ggGfz4thKz9tj1;
	Wed, 17 Jun 2026 10:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781683643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FV6IM4KCjzU8Nri99bizZIL0/rsYHQAHHa3Ku0rk3M=;
	b=SkNn4ga8hPcw+TLmmURZZzLBKHqVKPgVIZ5T81DqCyl4WrUzlsOrKeRFQK42fx2bFXTfVw
	fg9eSDwoOaxGgItZ85xtQ43NpBelnXkITHKMiVSpm5SXYEOyHl/YY7CCwHR8A2dcXDzcEF
	fal39LYEn3SB1160RXMqyTx/+fEhAGuUNdMLHK3R1SWcR8nvTNQJ+h02BiwRk3JnifKqk5
	lSTg6Pp4gvjaD5vUKv7DbAC7FtmIfpd26T6hx5zp/5XDqVDJ2NUP3mFRtNM2y4s4NeqjPb
	v7zAhBdMt6TEfgW2SQDW/W6VR/FY9iO6qEpuZi0MdOzgsRBAqhWQuEb+p1oNgg==
Message-ID: <a74f1233-d63f-4bcb-a379-3c9a6332cfb4@mailbox.org>
Date: Wed, 17 Jun 2026 10:07:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: sunpeng.li@amd.com
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260616201828.389985-3-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6ez34ap5pxe6rjbhzeti8hgwg5so7pzo
X-MBO-RS-ID: a1cf01ddf613d54a14d

On 6/16/26 22:18, sunpeng.li@amd.com wrote:
> 
> * Add a flip_programmed completion. Arm it (reinit_completion) under
>   event_lock together with prepare_flip_isr(), and signal it
>   (complete_all) right after update_planes_and_stream_adapter() programs
>   the flip. It starts in the "completed" state at crtc init.

Is the completion really necessary? Wouldn't moving the acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED assignment after the flip programming suffice?


> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 00f7a3b445ebf..571198c46c0c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4384,17 +4384,17 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  		 * from 0 -> n planes we have to skip a hardware generated event
>  		 * and rely on sending it from software.
>  		 */
> +		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>  		if (acrtc_attach->base.state->event &&
>  		    acrtc_state->active_planes > 0) {
>  			drm_crtc_vblank_get(pcrtc);
>  
> -			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
> -
>  			WARN_ON(acrtc_attach->pflip_status != AMDGPU_FLIP_NONE);
> +			/* Arm flip completion handling and event delivery */
> +			reinit_completion(&acrtc_attach->dm_irq_params.flip_programmed);
>  			prepare_flip_isr(acrtc_attach);
> -
> -			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>  		}
> +		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>  
>  		if (acrtc_state->stream) {
>  			if (acrtc_state->freesync_vrr_info_changed)

Pulling event_lock out of the if block doesn't make any difference (other than locking it unnecessarily when the block isn't entered :), does it?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
