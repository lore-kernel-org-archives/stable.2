Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D31A316E;
	Mon,  6 Jul 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359022; cv=none; b=s0sDXIMCKCuQGzaOlDwwv3UVBFaSrDRHtOEh2ZApT9VPYHS+pxY8cQtHCc3C9eJsYz8kKXDUoNMijjz1SAg2c5lG4nXm3iFUEGDmi3zjg3z5TAxaDzyCXk2GU9+OcRT/8o/8Np5ySNNCVE+d/2AzzJG9e4NNnOXQgrjazwNqZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359022; c=relaxed/simple;
	bh=n8CrQ2oFg6l9PiCKJKi7eQ0l04aMQnpEaSMal4Wsqcw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rLcXJ7LjW1LK8SwvUIm958Q87ZYa3+ZRuDxsUjI60AMt1cOnpCwpe5VIEfru5l/695wfnB5O81ZmNJ4a0NEYE/qyrdbtiUglGnmhfRzOPMyqhK7ihvTpKaairgZk4uTH7jvjFdokNNT1AUpij/LKwp6jWjOFs/867vDNELDKEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd6dZxqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd6dZxqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3FE1F000E9;
	Mon,  6 Jul 2026 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359020;
	bh=Odrk/M0uzEm06cV07YV8KYxA41sO4LNg6nGCO1QYWbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Wd6dZxqfLTij3E3ieK9/A/CoDuen7mpydkFdkhqPhOg0DaeBl60WQuThd6GsVfabH
	 IOaX4v5EHfYicBSXFw40C0eLYNv0OIl/Fr0GxAqLfg9R7uMk3YATC7VxRyoZNSUnyx
	 LMaGMJgC5cRSjkR6USf/b31dzx1lvebBQ+ejbtf3icth/WsE97fPukMT/F1o/+jrVw
	 iX0yhdUXUzHEjHJISW+32BRRxMjke6TBaCSckth2NXTu6EUzXgDsIyoidO8NqLhpou
	 XiFPb2Tyihcxn86x4DlE3lCGN/j+O4EAvTyjE4wOm1zqNn1gGcqxTtUVJpMOjOQI+i
	 xqNbsUC+zHPyA==
From: Chen-Yu Tsai <wens@kernel.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 jernej.skrabec@gmail.com, samuel@sholland.org, 
 Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260607030950.83636-1-vulab@iscas.ac.cn>
References: <20260607030950.83636-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] drm/sun4i: fix refcount leak in
 sun4i_backend_init_sat()
Message-Id: <178335901812.4027169.1529206377701282403.b4-ty@kernel.org>
Date: Tue, 07 Jul 2026 01:30:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 07 Jun 2026 03:09:50 +0000, Wentao Liang wrote:
> When sun4i_backend_init_sat() calls reset_control_deassert() it
> increments the deassert_count of the reset controller, and must
> pair that with a reset_control_assert() call to decrement it.
> In the error path where clk_prepare_enable() fails, the function
> returns immediately without calling reset_control_assert(), leaking
> the reference count.  Other error paths, like the devm_clk_get()
> failure, correctly jump to the err_assert_reset label which performs
> the missing assert.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
      commit: f7a56ff6240e6fd0cb36a3c0a911a1cd54789ce2

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

