Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30964FB9C6
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774510; cv=none; b=UEn0eabflX8N14NPVzUtXy1ANWve+LeU/4Fpg8qdN3h07yXInJNuALpAYlc1Cy4Q1mevmPCpWaFpbM1k+1FkvBMysho91xE7UxdtoKWU9JBC4rdci7U7WoINPJOEmMoCcbNH8cXEWzexhQ9DoEzsb8zoqX3lMACQxsdQx+rHC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774510; c=relaxed/simple;
	bh=NkJfm7tW/QwWAWG9aMc385Ui6QzhY3F+KO3ozj2cWjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0q4g8yHyupbqu3gjPPpf+bsBnUbD/yahoaB3O0L4g5oKYru7kiSF9fbglA9KhssercYaHTm1Rjb878J8b1gcpcWcOdfHM2IEsZi3Oz3wcCTfT9CvamMdqU1Ta15tpRft7KAAdHcAEtXhZ2HVPJhswN8loXw2MMHTD9ieyEdlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YgM4Mb9H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3Nm3qUw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YgM4Mb9H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3Nm3qUw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F29B97A0769;
	Wed, 30 Sep 2026 09:21:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 09:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790774501;
	 x=1790860901; bh=9XjWkAeTy0bOx43jZ3pattGqsmparqpu3VF27sBPjvc=; b=
	YgM4Mb9HzAKNuUynlfD7qM0zFGK0P20FvoQac1KxF3zSlqHo9eJxW8/OFNuhuWJX
	pBGUUtbTuoOprqfx6fJ8ER7awa2CmbNxEm1HfnQg25Md6PptEO5n4UNbN3E2ETIP
	ftZVNmmOcA4HxixPDG40T9w/l+H4N/1CjrxQjZA2Gn6f4zdnQYwUdNWZ+r6iirqR
	Aftnd99+9DSIy9cxdy3SLie+OVImkBEGUziF8ByITdBsZIeZ1Tp1O2izHSezC+Zq
	HrFPMfRIo1wS+usOFJUR9fT/Sclq0JBj/207VLHa83QpC3e/bL07W0CYOAuaF65P
	ZfA4Hb/YGtlJ25IwI4yw4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790774501; x=
	1790860901; bh=9XjWkAeTy0bOx43jZ3pattGqsmparqpu3VF27sBPjvc=; b=A
	3Nm3qUwX+NepN3haxruXJyVCL6i6jvlJcM4+WiW28pa4sPi6Wygy8jeF8FuZZxTW
	JJaa8XzrxA9KL6q+tvcesDBM2Ev/PKg2AHaoFJF2IhVhFJSrC2TSYp8qeY1pGuLC
	9kfmeXSjJNajTaxrb3D84b51GYsdX5P7nX4HPGr2cwm/q0GPpPMDD/Orzjabjafd
	AkjgWTYbdrfWs6zYIqx+YonlazCef08uZXobozRVs06eIDvouRZ6tyJRccwxu971
	1u+AP892YmgfcnpDihs0XACdYNxJq6IP0ToNRu1MsOGrwhNsUTYmgJhEUjPqUJiy
	kt0C6iqnydnDWXecBfT6g==
X-ME-Sender: <xms:5Qy9aoDl9Q07TjWdpkTSpjbZ-qZQCe0lXlCB1Guz_FpfrwCLp5Ijgw>
    <xme:5Qy9asH0kaIjOHhkoWIJvsgkFG3rvd3YKaQQ_K-qucMppV8syPTJxeVI9ahVq1PFT
    taG6tmSyQ5y4MzK5n6vkdRJI3I-q-9BkM_GcPAHBKWlVCsUGvU>
X-ME-Received: <xmr:5Qy9aq0ygaD8ysGmNZEudChfbIr6T47fqu2UrIMEqI5Zfwvo7sjayCfCplTWQh-5g3iGxgIKi1zy4Ny-9rzvCdcFxwp4ajlPApvkCZHKru0>
X-ME-Proxy-Cause: dmFkZTEp+JKKein/yNkDD1FN5UrDsSzLQeYbwOeakA6Bxg+PFl2TFWArrDVkqjX6TPB/JO
    H8gQJHYjBg+IwqnDdsbJk8GSvy//cf72s9ifFh2VOiNo1le2AvJgL/+nEU0RyDtYRPzT2V
    5wHYJAKDpXnCnuujndrEts9cJBqd2SECWqzeAHfxupHrxTgGVq2OHCZm5nZeKnCX27L89c
    38wPNROgEjRwhycOhPRViu3zaxbmcvBmY7o4zOddnTo9KjX4Mx/ji0zcLVmzRs23KH1131
    +YpjDV64FY5Pw95PijMpLPAtxNsyHPWaugi0/TkMVjI7F9SuFOUrH70+i+yMnfEkrDoEbW
    +3XPWZJ+uz7qa5H31e6EXjtgyzCjjll5/Rq/6kwyYer18Nh37iuOdTBXmFePxtvcy9c5wb
    BkbOvp8rm7dfeW+zysqQCY333EKbdv80daBuPSBjypmNPBbQxBrtUP0jQ0YzcPM4/RavrP
    j+cZEBCyDH/H00SYqDzpGbnCvBZc2mptTNk1wqum2TSBnGZYuXfRuiX6AAjEQwXLVJJO/k
    sgneHUvKw40dWy8A5ZhZ8LHcoMswteIqJbdieg5yZ/s8lEcLqbV1Di7kv7DFlN9vYAMZiY
    KlFjNe9wlHnAmuFi/Lf5IaXML+pWreQ56VZ3sIm6iIcOemdFacYY8ULpo/tQ
X-ME-Proxy: <xmx:5Qy9alPTBFOdEFaVKz2pIMouxHT75Lios5QEdHuxEErVt6-VhbZoTA>
    <xmx:5Qy9aiaaB0N7N1YtmJ6Un1mi7Sz6Bnbrcvgo5zBeaEe4acBixXUKdw>
    <xmx:5Qy9arxELcDrZeb0g5seVSelafJoA4BZ3KCZ0xKQ8BFfFlBb1O1z0A>
    <xmx:5Qy9apNNR2G1gTz0zJL9ZSIIZuI3JxfiO85qtRBfsoOxrrCK43tadg>
    <xmx:5Qy9agEsac1EmOSmc5uANBulIUfAwoCmC5FR5cyx57J14-WXJB8uP81E>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:21:41 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:21:36 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Nemesa Garg <nemesa.garg@intel.com>,
	Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 6.12.y] drm/i915/display: Clear SEL_FETCH_PLANE_CTL on
 plane disable
Message-ID: <2026093029-unaltered-smudge-83af@gregkh>
References: <2026090953-gravel-panama-02e2@gregkh>
 <20260912142353.2927508-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260912142353.2927508-1-sashal@kernel.org>

On Sat, Sep 12, 2026 at 10:23:53AM -0400, Sasha Levin wrote:
> From: Nemesa Garg <nemesa.garg@intel.com>
> 
> [ Upstream commit 7f1172a2ac0d7e50850785e2e65789c8aac8411a ]
> 
> icl_plane_disable_sel_fetch_arm() wrote SEL_FETCH_PLANE_CTL = 0 only when
> crtc_state->enable_psr2_sel_fetch was set. If a plane was disabled after
> selective fetch had been turned off, the guard fired early and left the
> register's enable bit set in hardware.
> 
> The bit is harmless until selective fetch is re-enabled.  When it is, the
> hardware resumes fetching for the now-disabled plane and keeps its old DDB
> range reserved.
> 
> i9xx_cursor_disable_sel_fetch_arm() has the same guard on SEL_FETCH_CUR_CTL
> and is fixed the same way.
> 
> v2: Add same check for cursor also. [sashiko]
> 
> Cc: stable@vger.kernel.org
> Fixes: b1f5279b5981 ("drm/i915/psr: Move plane sel fetch configuration into plane source files")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8739
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
> Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
> Signed-off-by: Animesh Manna <animesh.manna@intel.com>
> Link: https://patch.msgid.link/20260818095149.2172935-1-nemesa.garg@intel.com
> (cherry picked from commit 600a7c9d40e5e0c5544f42d1c9592c8d15224dc0)
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> [ Adjusted context for missing pixel-normalizer code in icl_plane_disable_arm(). ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/i915/display/intel_cursor.c       | 15 ++++++++++-----
>  .../gpu/drm/i915/display/skl_universal_plane.c    | 15 ++++++++++-----
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
> index aeadb834d3328..104009cf5f412 100644
> --- a/drivers/gpu/drm/i915/display/intel_cursor.c
> +++ b/drivers/gpu/drm/i915/display/intel_cursor.c
> @@ -530,13 +530,18 @@ static int i9xx_check_cursor(struct intel_crtc_state *crtc_state,
>  }
>  
>  static void i9xx_cursor_disable_sel_fetch_arm(struct intel_dsb *dsb,
> -					      struct intel_plane *plane,
> -					      const struct intel_crtc_state *crtc_state)
> +					      struct intel_plane *plane)
>  {
>  	struct intel_display *display = to_intel_display(plane->base.dev);
>  	enum pipe pipe = plane->pipe;
>  
> -	if (!crtc_state->enable_psr2_sel_fetch)
> +	/*
> +	 * Clear this whenever the hardware has selective fetch, not just when
> +	 * the current state uses it. The cursor may have been enabled with
> +	 * selective fetch earlier and had its enable bit orphaned when the
> +	 * feature was switched off.
> +	 */
> +	if (!HAS_PSR2_SEL_FETCH(display))
>  		return;
>  
>  	intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), 0);
> @@ -588,7 +593,7 @@ static void i9xx_cursor_update_sel_fetch_arm(struct intel_dsb *dsb,
>  		if (crtc_state->enable_psr2_su_region_et)
>  			wa_16021440873(dsb, plane, crtc_state, plane_state);
>  		else
> -			i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
> +			i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
>  	}
>  }
>  
> @@ -699,7 +704,7 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
>  	if (plane_state)
>  		i9xx_cursor_update_sel_fetch_arm(dsb, plane, crtc_state, plane_state);
>  	else
> -		i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
> +		i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
>  
>  	if (plane->cursor.base != base ||
>  	    plane->cursor.size != fbc_ctl ||
> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> index 7f77a76309bd5..52a38d3ada24d 100644
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> @@ -770,13 +770,18 @@ skl_plane_disable_arm(struct intel_dsb *dsb,
>  }
>  
>  static void icl_plane_disable_sel_fetch_arm(struct intel_dsb *dsb,
> -					    struct intel_plane *plane,
> -					    const struct intel_crtc_state *crtc_state)
> +					    struct intel_plane *plane)
>  {
>  	struct intel_display *display = to_intel_display(plane->base.dev);
>  	enum pipe pipe = plane->pipe;
>  
> -	if (!crtc_state->enable_psr2_sel_fetch)
> +	/*
> +	 * Clear this whenever the hardware has selective fetch, not just when
> +	 * the current state uses it. The plane may have been enabled with
> +	 * selective fetch earlier and had its enable bit orphaned when the
> +	 * feature was switched off.
> +	 */
> +	if (!HAS_PSR2_SEL_FETCH(display))
>  		return;
>  
>  	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id), 0);
> @@ -797,7 +802,7 @@ icl_plane_disable_arm(struct intel_dsb *dsb,
>  
>  	skl_write_plane_wm(dsb, plane, crtc_state);
>  
> -	icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
> +	icl_plane_disable_sel_fetch_arm(dsb, plane);
>  	intel_de_write_dsb(display, dsb, PLANE_CTL(pipe, plane_id), 0);
>  	intel_de_write_dsb(display, dsb, PLANE_SURF(pipe, plane_id), 0);
>  }
> @@ -1512,7 +1517,7 @@ static void icl_plane_update_sel_fetch_arm(struct intel_dsb *dsb,
>  		intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id),
>  				   SEL_FETCH_PLANE_CTL_ENABLE);
>  	else
> -		icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
> +		icl_plane_disable_sel_fetch_arm(dsb, plane);
>  }
>  
>  static void
> -- 
> 2.53.0
> 
> 

did not apply.  Also is not in 6.18 :(
