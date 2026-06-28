Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8231716A;
	Sun, 28 Jun 2026 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782632086; cv=none; b=u3yPUOoMp5ZYXIHL8uLBtHVZglpamD3yPLkS4Y1LimgZAJ8J06GiVTiT2Uz3rOWpVrjkBmKzSOEimZHHNzM2ygxSCWVogkhFK0GEJ0IG9YnVhySIewrYxbAVsgilOBVTtshR8YJkXkndqwBrGesPTdszdW5jEt/6usdoO82ptIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782632086; c=relaxed/simple;
	bh=OkaeamBGsVLAuYRbIgqS1XrmemmCfSeAVuk86wku4L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP47g9n7mqUnYK9oPrT5O0swjGOTMMrgA9phcXVVngnRT9+3ibNLX3q7y7tUCuJrK38Refn82HAt2Ho+IkfXgs2C7cHpbpDrzNfJCDoq/NDCvtKpXI2JgXIN5n/1f/ERIPBT3F0+i5tLBsnuMUeIu/PB8T3HuRHdioUuPI2+aWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Afr0EmOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Afr0EmOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F061F000E9;
	Sun, 28 Jun 2026 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782632084;
	bh=Ln2Tw+sGy7ydx3N8w0OkVCZpqvk/JGyFu6srxkz+XKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Afr0EmOa6NBBjm3Xh270RvPlky6vA6jlGxZXo7PE0y/xZUUsuNbJz84uzMsThfL/J
	 bF7+54lJR1rxvyTr7aW4T1SvwPGMDe6Ehat6J9FOAsrrK3twV7tu8GanRDy3aPwPKn
	 x3Zk+L4JHEeYovpICqR9MCQB9G0COGKtAEwy/OgY=
Date: Sun, 28 Jun 2026 09:33:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/display: set new_stream to NULL after release
Message-ID: <2026062816-contour-womankind-1646@gregkh>
References: <20260628072740.8884-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628072740.8884-1-vulab@iscas.ac.cn>

On Sun, Jun 28, 2026 at 03:27:40PM +0800, WenTao Liang wrote:
> In dm_update_crtc_state(), the skip_modeset path releases new_stream
> via dc_stream_release() but does not set the pointer to NULL.
> 
> If a later error (e.g., color management failure) triggers the fail
> label, the error path calls dc_stream_release() again on the same
> dangling pointer, causing a double release and potential use-after-free.
> 
> Fix this by setting new_stream to NULL after the initial release.
> 
> Fixes: 9b690ef3c7042 ("drm/amd/display: Avoid full modeset when not required")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Correct Fixes hash based on reviewer feedback

Did you forget to include an Assisted-by: tag?
