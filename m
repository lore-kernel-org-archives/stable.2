Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0355D867
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959099; cv=none; b=pPeCJKRphlPwhErm7kdfJGbsRqrrOMkTcyfvIyMYhvUDhSbtApBo9t/ntJ9i4oMQ9SZc6EBotVabKDbAv+dIxC674/gc8Oat5Mv/jhv++A8tB0gdtujYP/cY+G+0HUBnL/L9Nck5PbpF4x51OhqcxtJFQzSS96ELgNiV/p++lF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959099; c=relaxed/simple;
	bh=v4VqNLLxyBFyXPEz+FFatds3IOR4HXZIa8xaMEQCYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqvxMT81BDnbeXoHiqlimPl2x8+Nzqbbuaj/OSJpkR+ebd545cGbf0M7fmay42pqkLdeRnyc2Z/Vd6hGIkyOjyKH+6dBGqVAerkIp2xGSFEacjCtdY52mFzlXFTq2MSNjZ47t8VniUk5b48R5CCjU7fyuwRBAcU6xNqZI5hq1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lK0gX1jl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ea0uzDEf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lK0gX1jl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ea0uzDEf"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D7431400090;
	Wed,  9 Sep 2026 09:04:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 09 Sep 2026 09:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788959097; x=1789045497; bh=Cp+uMzlMK/
	KeNZeKJ5ADKs7kT/O0gbhghehmz59EEgo=; b=lK0gX1jlj7shqNcBP6IRfxPsOR
	fTXHWo4ttPUJXsTI0sy4p0rnGFGcT28hofEYZHYpLBM9HbzPH3/7TW5L08NyWDla
	kAPd+TPgQkz+CtMIRswrdba08qLrgKU05lcHfA5xNQQpJXP+hPYKY+znWGJnFPvw
	E77LZdmlOgvVNecCwEShq31mooMML2us6f6xgiXRopWmSCKUjtVhQtdhuN/hRi7O
	G/yesFmpdJM9ADXKnI2Z4mN023GveOhjv15w07mR+h4feWe04mCciL6IU0/5m4Sh
	jzmIyKm6TwE2Kwv3/0v01RRjVRMv7hGBZZSyiL3oC+dYBtBUlD/TW79BSrMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788959097; x=1789045497; bh=Cp+uMzlMK/KeNZeKJ5ADKs7kT/O0gbhgheh
	mz59EEgo=; b=Ea0uzDEfUCu8/uXboyVhRZgZYdQyZhA/aipLBUSQkY7ZiwEKgML
	rwmyHylezT0T2BaeEMcaBI3B29lwDKGv8OJ3RkOMNmm73yy74cqZmJrNev+xeIXK
	Ciq96yg5ZkmuyQBl6bKoYuk/Ed7RLCscaTjbeRmV8DwOWs7pbEpLnaZ93PFmthn/
	0o4i1KNTfVxlEx7EfctpOQW4TNExe1LfG5HhdiZhpFhgA/FZTey3K35OfcO2Twyf
	yeCnPgJuAI0QizzWVPykKex5xoEk1zZH/9wyZi9JDS7AWzxRsGpWwiK/UlHnGFwE
	cP4EzAv7nMnL+hCtf+OI5Qm8+iZXkByllcA==
X-ME-Sender: <xms:eFmhal1-uMiPvKI3haeLBYhCTkbHOw80UtLTEPw38gyjbxopNuzmxQ>
    <xme:eFmhauo7hY4K6X9vNQjFZ_wj_LOWSOZ3cAdXMaz0R9ulm-uaQEg4nQb5xrIOS2mh6
    9NbP-WAHT11MQ1i2D4xOhnP-QIiQ1VRm8aq0KNTmttpOWCfaQ>
X-ME-Received: <xmr:eFmhapiTZBGu6i40iJT8ahqPXheRRSRLkFcpZiRn8ip5rwhNTmT9UNsy-FRUZCMgMedwhOnw9fOgNzpEc3DnAE0zUylzqvx7JbFI3uCz424>
X-ME-Proxy-Cause: dmFkZTGaIBFiSoWFVcJthg96Ptn0ECcIsNt8On2fuSuVGv0aVthh/Bd6fQ9fODVCm/pCYU
    Ya6E1Uavd5iuzPHqoNMX5CDmKM74LLXW3sl7D9aTK/mJ0RWHL2fpa/l/i/uS6yxi5SDiPw
    6/7qd2HragC1CKuRNAEN1gQr8cwpbA2IOCnNCY14VGTTtiPGqOVoICIDTnT1q18PfEtzCG
    YS8mbD4YPMvbcotFc1dQWa4/Mq50/pQTUFhKV5OT5Hgfkrmgmtc/2Se2VfcU/4FC4nvL+C
    I+55sW/AsfBiHbLvOOtsQ7LKL7NW2GuYHNz4ORDtuexWHYtl+C4kp/b04XWJ+c7nywDxMN
    4rSlnfT4MtKhCm4x00w3CRFCKw3rL4e7hNUn8Q0w6/vsroy1A0OmAqlWOwBLMD6mPvLxL3
    x7hwhdbFAgtbQOvRF/C2ekEPEzKYHnLprSP5V2FokiyZsXybI0bkJt79buI6WJ2FdUbZXA
    tRQada2WHHheaPwYNSOqbc6Gpy0j+g/tf+PJIz35izJOizoPfy6EgvvADyQ8WCGA1fejYE
    U6zu3bMFGtIA1SCKk5M3euo5idwrscrtV5Isgl6pKx946Hnhc8hEvNkriV6iZ6sSvOV+L3
    Xl5d9mJhSanxDvT965zRCvhyUypb3R5OHDvBZb9FA5j/l4/JSzFZbPqF2leg
X-ME-Proxy: <xmx:eFmhai8dGrLfoc7S16CO2CQWmMTmnaWFjrsFyKiLlh2nJPYTMpYBEA>
    <xmx:eVmhatXWKnZpf068eue6vhs_7auRqTfS3vs0kxrGmcuWaPWOrdgJpw>
    <xmx:eVmhauCMPqG1WVgQEjsanah5qb0ECjDmZtpQKQN-BExzcGePv0VDEg>
    <xmx:eVmhaqE3usHFRvUvxAmn3P5RgRNsMbEGvBfZLsWfik3sNexhNLiuug>
    <xmx:eVmhagEsDWNhZjZulSK-dq9i0g9TB1rwCIzt5tqPzmLIQqY1cCeKbseY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 09:04:56 -0400 (EDT)
Date: Wed, 9 Sep 2026 15:01:49 +0200
From: Greg KH <greg@kroah.com>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/sysfs: read ops_id only once in
 damon_sysfs_apply_inputs()
Message-ID: <2026090945-spookily-leotard-ecf3@gregkh>
References: <2026090858-arousal-getting-ee35@gregkh>
 <20260909032830.119383-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909032830.119383-1-sj@kernel.org>

On Tue, Sep 08, 2026 at 08:28:30PM -0700, SJ Park wrote:
> damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
> ops_id_store().  As a result, the min_region_sz could wrongly be set up.
> Read it once.
> 
> The user impact is trivial.  Sane users ain't update the parameter in
> parallel.  Even if it happens, the DAMON core layer handles the wrong
> min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
> making a min_region_sz that is different from the user's intention but
> still valid, only monitoring itself runs differently than expected.  No
> critical consequences like kernel panic or memory corruption happen
> 
> The issue was discovered [1] by Sashiko.
> 
> Link: https://lore.kernel.org/20260715031002.108504-7-sj@kernel.org
> Link: https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org [1]
> Fixes: 8d009da32f13 ("mm/damon/sysfs: set damon_ctx->min_sz_region only for paddr use case")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 5adaaa28be8a79ddd7e103b171f9d6e14e7fc26e)
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index a6c3e83a3dad5..655e4de69bee8 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1432,14 +1432,16 @@ static inline bool damon_sysfs_kdamond_running(
>  static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
>  		struct damon_sysfs_context *sys_ctx)
>  {
> +	enum damon_ops_id ops_id;
>  	int err;
>  
> -	err = damon_select_ops(ctx, sys_ctx->ops_id);
> +	ops_id = READ_ONCE(sys_ctx->ops_id);
> +	err = damon_select_ops(ctx, ops_id);
>  	if (err)
>  		return err;
>  	ctx->addr_unit = sys_ctx->addr_unit;
>  	/* addr_unit is respected by only DAMON_OPS_PADDR */
> -	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
> +	if (ops_id == DAMON_OPS_PADDR)
>  		ctx->min_sz_region = max(
>  				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
>  	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
> -- 
> 2.47.3
> 
> 

Does not apply :(
