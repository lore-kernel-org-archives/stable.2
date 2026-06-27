Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E651B6D08;
	Sat, 27 Jun 2026 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782556187; cv=none; b=IMrcJ49kp+fKUIlkgmndfSaes2ubFSOmJmh6uDO/NCwHBV0GYXxL1pak0Drux49IJrjC08ByIbE6S3JO58IPnLRif8+Py1FVEcHG7lJfpn70gclMpAit5d4b91YIGiDisQIVLhfSSr9ydoY2wxQNA19dV6sXelIae92qY9j0B9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782556187; c=relaxed/simple;
	bh=g93cUTne0VQhZJHwIqDX8zOPeMxUhLHtPXX5/lqhJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld091WJqyB6pdqRR7rpRXDGpEmuP+bl18Tw5lPeZp+TbxWiCo0KR1SRVqTUmjhdGec6FNTcEsYz+lU/TlLAj1L/LBRFDkmBBtYUBb9juearRydhEhlFyQxm+wSfjWi3USPO+N9kl8jqvAKqpkRid4uT/HeimxvAv3kbG6wPDOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Td/Em6wY; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Td/Em6wY"
Received: from localhost (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 60E1D40F9A49;
	Sat, 27 Jun 2026 10:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 60E1D40F9A49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1782556174;
	bh=HefoXOaX7iDWeVdJoA+Z44Cqogqv/SbYCDDilQ/lrZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Td/Em6wYzVFSgEpJlmiCF/PlqhNZH96DvffaHrobgmo5aEnGrHjXeb/Lu7trF+LZE
	 cejW6hLiRlcFB0/xqxg0WQ5O21pR+tNCxBcZUj4CDkyYwxB/QHfVwVG33reJ16I5M9
	 Lp206/2msW9GRs8eaNr/Acgj6p2b/MhStzCLRR6E=
Date: Sat, 27 Jun 2026 13:29:34 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org, superm1@kernel.org, 
	dri-devel@lists.freedesktop.org, mario.limonciello@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	ray.wu@amd.com, amd-gfx@lists.freedesktop.org, chen-yu.chen@amd.com, 
	aurabindo.pillai@amd.com, Alvin.Lee2@amd.com, kenneth.feng@amd.com, ekurzinger@gmail.com, 
	siqueira@igalia.com, HaoPing.Liu@amd.com, pierre-eric.pelloux-prayer@amd.com, 
	srinivasan.shanmugam@amd.com, sunpeng.li@amd.com, mripard@kernel.org, mwen@igalia.com, 
	Dillon.Varone@amd.com, chaitanya.kumar.borah@intel.com, ivan.lipski@amd.com, 
	Tony.Cheng@amd.com, dmitry.baryshkov@oss.qualcomm.com, chiahsuan.chung@amd.com, 
	timur.kristof@gmail.com, harry.wentland@amd.com, linux-kernel@vger.kernel.org, 
	alex.hung@amd.com, tzimmermann@suse.de, alexander.deucher@amd.com, 
	christian.koenig@amd.com
Subject: Re: [PATCH v3] drm/amd/display: Fix dangling pointers in state reset
 functions on allocation failure
Message-ID: <20260627131809-033f104c2b15b742e1ba441e-pchelkin@ispras>
References: <20260626191314.29933-1-evg28bur@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626191314.29933-1-evg28bur@yandex.ru>

On Fri, 26. Jun 22:13, Evgenii Burenchev wrote:
> Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
> Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
> Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

Having three different Fixes tags implies the big patch could be split up
into three separate patches which do one thing at a time.  They can be
combined in a series for ease of handling.

> @@ -8151,33 +8151,41 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>  
>  void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>  {
> -	struct dm_connector_state *state =
> +	/* Remember the old state */
> +	struct dm_connector_state *old_state =
>  		to_dm_connector_state(connector->state);
>  
> +	struct dm_connector_state *state;

No empty lines inside local variable declaration block, please.

> +
> +	/* Allocate new state */

Well, all the comments added with the patch - IMO they duplicate what the
code is doing - that doesn't add any real value and just bloats the
codebase.

> +	state = kzalloc_obj(*state);
> +	if (WARN_ON(!state))
> +		return;

It's not common to WARN on memory allocation errors.  If this code is ever
fuzzed with fault-injections enabled, that'd be one of the first issues to
pop up.

I think if the system is in a state when it can't allocate a bunch of
GFP_KERNEL memory, there'd definitely be some noticeable activity in
dmesg.  Some (random) assertion triggered inside amdgpu won't help much -
that will only halt those machines booted with panic_on_warn=1.
