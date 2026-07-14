Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4C3F99E5;
	Tue, 14 Jul 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016709; cv=none; b=KlhAkVCVcz9njbb48ggSYxUEbKpdyesBTmPjLvkJwi7duGMJo+7/1P46F35jZ+9v5eMGLov17ch1aM0iohdCSC5xRd3kltdku/X+5F3SDQGawJEG3jLA0lIPhtNdX584JscoPg2RIzaRvmKNotyJ1+s8NBMKmQWRI8NWGI+ZfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016709; c=relaxed/simple;
	bh=dCLX2OZmnQHZfHD9kLc9OyNRWWK37l6DX3lTNoMemdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsPAel+vPbLLTDscVWXJegPG0+Ne9ZH267WImcLQXmB3U6dZSXe1ijCetlQRjUuj3F8u6HR3C3+O3y7LLBKQczURIC8AN+vo8CrNIorPrf1PP2Lhkbnq1kotd7I6S+6vwEgMIcVUO9BBHNCfnlXwz4hKqHkJ2ij0yaxiLuaAXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=U4lfxtlv; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="U4lfxtlv"
Received: from localhost (unknown [95.24.34.24])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5A8654077925;
	Tue, 14 Jul 2026 08:11:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5A8654077925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1784016696;
	bh=VgVmW8xYosn9eiQExAeU/NJmJ4m2IB5bEc9w8himm7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4lfxtlvxBqvv4zXOJvCCqXRoI/MEwpNB1CjNePGU3E67/CoorkTnoxv1/H745dau
	 tC9O8dXloA/RvxHG+EZn8G8B26BNtcjdsrq/abqTTv3i1b6YAq3QAcW/tKUpGMGzJo
	 AkJi/MBCKrccOfzCB5pXZy8N0lIX2lC7Q0PCfqkQ=
Date: Tue, 14 Jul 2026 11:11:36 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Elizaveta Tereshkina <etereshkina@astralinux.ru>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, lvc-project@linuxtesting.org, 
	Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, David Airlie <airlied@gmail.com>, 
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [lvc-project] [PATCH 5.10/5.15] drm/sun4i: backend: fix error
 pointer dereference
Message-ID: <20260714110040-3d9d1292810372916773a64a-pchelkin@ispras>
References: <20260713175238.715526-1-etereshkina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713175238.715526-1-etereshkina@astralinux.ru>

On Mon, 13. Jul 20:52, Elizaveta Tereshkina wrote:
> From: Ethan Tidmore <ethantidmore06@gmail.com>
> 
> commit 06277983eca4a31d3c2114fa33d99a6e82484b11 upstream.
> 
> The function drm_atomic_get_plane_state() can return an error pointer
> and is not checked for it. Add error pointer check.
> 
> Detected by Smatch:
> drivers/gpu/drm/sun4i/sun4i_backend.c:496 sun4i_backend_atomic_check() error:
> 'plane_state' dereferencing possible ERR_PTR()
> 
> Fixes: 96180dde23b79 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Link: https://patch.msgid.link/20260217014801.60760-1-ethantidmore06@gmail.com
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
> ---
> Backport fix for CVE-2026-53066
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index d935f36a24dd..b3741827c6c3 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -507,6 +507,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
>  		struct drm_plane_state *plane_state =
>  			drm_atomic_get_plane_state(state, plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +
>  		struct sun4i_layer_state *layer_state =
>  			state_to_sun4i_layer_state(plane_state);
>  		struct drm_framebuffer *fb = plane_state->fb;

This would trigger a really unnecessary build warning due to lack of
commit b5ec6fd286df ("kbuild: Drop -Wdeclaration-after-statement") in
5.10/5.15 kernels.

I wonder if that commit can just be ported to 5.10/5.15.  You may consider
it.

Otherwise the current backport should be adapted to avoid declarations
after statements.
