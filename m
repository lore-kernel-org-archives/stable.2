Received: from mail-ua2-f30.google.com (mail-ua2-f30.google.com [74.125.226.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442C3C0630
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794652; cv=none; b=iyX2wkZNrg4PxH1CyaPpgPP9Nx6jd1B2WNlXgkDwp6Y/3YgZfP4t/b1A1qc4Zu8ZLzi9XTCU5pRFuc7B5ioxQMPsoTsdysd48ZMB/gzHxYNO2bM7J5fHXZMSs4Pa3BaQrXWKSIR5gZc4x+yC/Mq8OGXx2VC2N+iUGcNpPXLM+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794652; c=relaxed/simple;
	bh=3YipfBbJyYdWfgmMsJACajHIATDtDZV6pXG9BR40l5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnCw5bdjk3I4zs/68MMR6MLgJDHVMs/9NxVsj1WlcXPQ11Zc2MAsPa+5WgVnbesfthynyQmPKTOYCN2TmRGdKaj1+cL2Mzvh2p8iHvp1XoCqf8e6SLuNgjRPqM8YDmDJNovvbjP9a5Wkh/tJS80YwDCjXW5E/oH2LXsZg+tvgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQfJ75Mk; arc=none smtp.client-ip=74.125.226.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQfJ75Mk"
Received: by mail-ua2-f30.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed1so3216540241.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790794649; x=1791399449; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ZtFG6FaQjG/i5XO1LEXu5NyAdlTlgZvpK3ElwDNrH0=;
        b=TQfJ75MksWUYsr5uGwEruOFhOPPn1+84TsuGgNjFp6nMjeRBlhxjIe/GvU19eb8Ldx
         WnVBfWrOarkn6ng9CY5fypdTUbJ9KVukk8sv1CS3mVB1e9rME6pYos4lUVuCG4gKWS+J
         K0SafDZl50PIzJ5G4H27N2wRTqjyu/Pq5RxZ+Td+E9RdaEDTFvCEfv5xB4Ov3L6YuCxM
         KtZqGpBFV2CsA+6PlsNBAIfvXAEpPf/D/X6HHx9o6zZNrivycx6N+qXry2I+hqQC63Sd
         2r2Q1TB1DLSPCQvxK/uFJAlAW9vCq3fxFTBRJIqJHl5omi/vlCd4uLr65aTR4HN9xvPn
         gtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790794649; x=1791399449;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZtFG6FaQjG/i5XO1LEXu5NyAdlTlgZvpK3ElwDNrH0=;
        b=lbdYIxo5E2D7fzvddHtR6cJgZ0stAJyEUPjmOGhR5mJ6gqnnSGbAdUpKr7rB/JuQ/4
         8VujGQSI0Yztnu+1R2ZgXOUy4nf9ESHqk3JSWoKgYrCTggcGChSs5EbSb+iq7HocmMeJ
         hoR8mfBUWACooiQjyyYU3zqk1TGxSqsDXdJvk6IpOCKY7qJw2Y1xy2TzOETyWXPEl6dh
         hkCHTy7rqGZ/zROs74SLMqFUyD5SPAJe2VDsJfOQIqEPBFF0v2TZ66A1pkqWfkLjLI8M
         ZroxEuMBcg+9gEW3pp9VcZY6wi+9YaZ7fHubldoBCh9haniHKqSZLvoVKROO1777JrJL
         +HJw==
X-Forwarded-Encrypted: i=1; AKwUvBworrwl3T/leO7qL1TZi0OaxRy87VlykBiqvu8Iue4x46rykp+zcPCwCfjyl8tnkb1Ek3+fIKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9xn8dOoVJj1PVsBXnZBE8XF4cH1+ecYrdP9sUCRaK/kuCYWKB
	Bvs6uXpwlXH08T5XjXcnv+ldifQlP2rjowvIwzJqre8wMZ6bzCVQ21D60oEBLg==
X-Gm-Gg: AYBFou2Fyo5vdpFoNoKax8B+2Bq+/kQGZh/KQ+5mDi8I8BxuM6SOOThs4xeq4yPlCij
	XCGFrv7LxybWvzd4hLRkCCy0L9ZjiL6y3uv1VIc/XNYOfRXUXH2d/IM+NknflxbQLv/tw4nKe1H
	8CgZvRw7JitHsTRmFKCLV9ViDsTuHZT5Ezr68JFxzPtWiy14CBoVygSVZThThear/Aq6155U4nA
	SbGFHNIG2eRsUZKxvf8LwiXMwcvCmOiabDGviMSXt0o0S0kOjnNHe7B2GB2grc+zsIiHiR76wmi
	wjI5Z6h+BgtGyZBVtE+iDwXhUPjeqxqHgCWT63lnCPqysBxrh2ZXdriNwGrGWfG3oroFqRPGECD
	sLZLrA+ACeqVeBebHXFZxW/Ew8BzgfzcSezS37Vdp+RIZ9kD797ylHSK4TqGZJUTMCeWJ2Ey1xe
	/egsSPfEixx4f+Ey4W3nxM5R8RY8bMiScPvHQv8IwMcnGPkv7SQPneOYxNDGQnkrufFAo9K7XWQ
	vh8kS5KpdOCoq6Svmjuw6cQm2pKAj+9qEvT7kaeAZifSFkqqrEI11bGqa5kwHMb2JiierIE4hqH
	/TgcpJKZpQ==
X-Received: by 2002:a05:6102:6448:b0:7a6:c647:cf50 with SMTP id ada2fe7eead31-7be72eab3bdmr763211137.8.1790794649316;
        Wed, 30 Sep 2026 11:57:29 -0700 (PDT)
Received: from timur-max.localnet (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca. [142.127.77.63])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7bfa70d3ec9sm176452137.11.2026.09.30.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:57:29 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com
Cc: harry.wentland@amd.com, alex.hung@amd.com, chiahsuan.chung@amd.com,
 ray.wu@amd.com, Leo Li <sunpeng.li@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: disable self-refresh on tearing flips
Date: Wed, 30 Sep 2026 14:57:27 -0400
Message-ID: <4c1BfmguQ8O9e4vVyhq5cw@gmail.com>
In-Reply-To: <20260930163222.557757-1-sunpeng.li@amd.com>
References: <20260930163222.557757-1-sunpeng.li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On 2026. szeptember 30., szerda 12:30:52 keleti =C3=A1llamokbeli ny=C3=A1ri=
 id=C5=91=20
sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
>=20
> [Why & How]
>=20
> Immediate (tearing) flips breaks self refresh state machine assumptions,
> so disable PSR/Replay for them.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Patch fixes tearing updates on Strix Halo.

Tested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> 6e5dbe0bd82e5..d4c814eeb56d6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3764,6 +3764,13 @@ VISIBLE_IF_KUNIT void
> amdgpu_dm_enable_self_refresh(struct amdgpu_display_manage struct
> amdgpu_dm_connector *aconn =3D
>  		(struct amdgpu_dm_connector *)acrtc_state->stream-
>dm_stream_context;
>=20
> +	if (!acrtc_state->base.async_flip) {
> +		amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
> +			psr_event_immediate_flip, false);
> +		amdgpu_dm_replay_set_event(dm, acrtc_state->stream,=20
false,
> +			replay_event_immediate_flip, false);
> +	}
> +
>  	/* Decrement skip count when SR is enabled and we're doing fast=20
updates.
> */ if (acrtc_state->update_type =3D=3D UPDATE_TYPE_FAST &&
>  	    (psr->psr_feature_enabled || pr->replay_feature_enabled)) {
> @@ -4218,6 +4225,18 @@ static void amdgpu_dm_commit_planes(struct
> drm_atomic_commit *state, spin_unlock_irqrestore(&pcrtc->dev->event_lock,
> flags);
>  		}
>  		mutex_lock(&dm->dc_lock);
> +		/*
> +		 * Tearing (immediate) flips cannot work with panel self-
refresh
> +		 * features. The event is cleared by
> +		 * amdgpu_dm_enable_self_refresh() once async flips stop.
> +		 */
> +		if (immediate_flip) {
> +			dc_exit_ips_for_hw_access(dm->dc);
> +			amdgpu_dm_psr_set_event(dm, acrtc_state-
>stream, true,
> +				psr_event_immediate_flip, true);
> +			amdgpu_dm_replay_set_event(dm, acrtc_state-
>stream, true,
> +				replay_event_immediate_flip, true);
> +		}
>  		update_planes_and_stream_adapter(dm->dc,
>  					 planes_count,
>  					 acrtc_state->stream,




