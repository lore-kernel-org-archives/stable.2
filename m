Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C3436374;
	Mon, 13 Jul 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950983; cv=none; b=nFvYDSRtTcwZMJ3NMSGCL+RKZXbw+bVksGRkZYUXlH/B6HtXKRl2RkQN2FF1qKY+jtXTVJY3qRBL0N2Q6HbtshZuixWOLBAyM9UTu6rBdk0A31mofE0jnhtfolS5InLKKDRyHwDnZ++hHyykHpnLdufCCpM9S1sYRL5amNnir9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950983; c=relaxed/simple;
	bh=ctXtTx3qimC8EAxLk6QfcovSqIz+Q0zr+wiWw4PtNkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjnzfoegSwC0L2sBl57j48BM09CQg+5aEmjRTdS489lbwWWvHAD6fcAfcpCmsIvthaQRb0aG/SNOzbhwklblMHZjyMPa4SuUQQeSVwORK7CrUP1Vv6qBoN9qIWbmjSsZqMKlqqQ3xuGvaKxavQ0lw7vqgP1C5mEoDEIr0bR7CoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzJ62VPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzJ62VPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F661F00A3A;
	Mon, 13 Jul 2026 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950981;
	bh=jN2Uqyqlk4BlB1zGW5Bw3R7JyKk82NVHi1lz3053mrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FzJ62VPZgdUAUQmiLBMA+9B94QtywjBJVEiCmeTsr5MglH2TgGMUQpuPtxjxtwlbH
	 9MQA6kk33gFAdx2LG8KWQAQcjMWaLnqHI370mEp0J44O6UaKFLSyrpJkp9AhHPMKvu
	 vFt27QaijnH6K66ijOMHSS7oqiA0xDP+HJJ/RAGLx5I6mz0zLQUZ+jc9TroeaU/GxY
	 KuiFHu9WqX95/NNMxDqB1uZA/7RIuuUotFj6rAQVAwwraZpkl7acyV1RYmbl8zmmRH
	 znCPiEDJVsQ/nklC2VsRzVjPUBc6meF1hdkWmCB58n8Dmw+2MZWZNOoPfEc4uNTZ8R
	 OPAra+BHvl9sw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wjH8t-0000000527P-02yL;
	Mon, 13 Jul 2026 15:56:19 +0200
Date: Mon, 13 Jul 2026 15:56:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in
 v2
Message-ID: <alTugxmHG_s4kY4E@hovoldconsulting.com>
References: <20260713112957.884640-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713112957.884640-1-lgs201920130244@gmail.com>

On Mon, Jul 13, 2026 at 07:29:57PM +0800, Guangshuo Li wrote:
> mtk_hdmi_common_probe() gets the DDC adapter with
> of_find_i2c_adapter_by_node() and registers a devm action to release the
> adapter device reference with put_device().
> 
> The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
> adapter. This is not paired with of_find_i2c_adapter_by_node(): it drops
> the adapter device reference before the devm action drops it again, and
> it also puts a module reference that was never taken.
> 
> Remove the extra i2c_put_adapter() call and drop the now-empty HDMI v2
> remove callback. The common devm action releases the adapter device
> reference.
> 
> Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
> Cc: stable@vger.kernel.org
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - Add Reviewed-by tag from Johan Hovold.
>   - No code changes.

No need to resend just to add a tag. It will be added when the patch is
applied.

Johan
