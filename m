Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF6149C7B;
	Tue, 30 Jun 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811202; cv=none; b=GGXMbJA4px3RlnC90hBc85wv/cnixmpQqVpJdMnEI14bOlDVgQvl0ju/EjmTVDyDQ/daJl1glf2JjlkMqlhuOx8+cfek71qYW5l4VVifN/+dTRAv1QJx3+yGIcsXLKSWa4mskVv6AJ6RSMQQFDr7MhLMS67Z828EGjwwZh6UYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811202; c=relaxed/simple;
	bh=oyguhuR6LbAqWw4xdToVEIjVc0kEnHRMdTIG+IIQ234=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lleev52wL0FjFyAqg0y6kBr+Y8A3TD52TC6qc4SNuGIL7OFaNJE8PFF7O437l3ruo85SjZ2oDJKDan5cl306jtpgAg6j4X3WRpluQYt73Kb7mh3/Af8dbxR7lFIoIFICFvmJp47v2Pf/4IGmhkEzLzymG4fYL7jkCLrRP27FNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pTSAv86M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pTSAv86M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393B21F000E9;
	Tue, 30 Jun 2026 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782811200;
	bh=P8y26ICau+Zq5nbRu9rFDpHLmiN9lzN8YryMUBW4Z8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pTSAv86MxiMhodCWxanIEFDXajdaw9kKMMAvHEU73DCrhG7+mnBvVResPe4mgebXr
	 c7XNC3u+9iar1gPM5/MH3SBlueeV0XoKt+oCP+UTr77JX4q+2ZxJso/SzltJVCllyn
	 LvwBEEMAYnTzsp0hYbxFfbg8SC4LOJWCNHQ87sMg=
Date: Tue, 30 Jun 2026 11:19:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: thierry.reding@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	jonathanh@nvidia.com, WenTao Liang <vulab@iscas.ac.cn>,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/tegra: fix host1x_bo_pin leak in tegra_dc_pin
 error path
Message-ID: <2026063044-multiple-lion-95fe@gregkh>
References: <20260628150228.47948-1-vulab@iscas.ac.cn>
 <6iIwnfniQ6-oslWmeLae0A@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6iIwnfniQ6-oslWmeLae0A@nvidia.com>

On Mon, Jun 29, 2026 at 02:59:05PM +0900, Mikko Perttunen wrote:
> On Monday, June 29, 2026 12:02 AM WenTao Liang wrote:
> > When map->chunks > 1 triggers an error, the function jumps to unpin
> > before storing the current map in state->map[i]. The unpin loop only
> > cleans up previously pinned planes (indices 0 through i-1), so the
> > current mapping returned by host1x_bo_pin is never released via
> > host1x_bo_unpin.
> > 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
> 
> This patch changes the code around the line, but doesn't look like it's
> the origin of the bug. Rather, I think commit
> 
>   49f821919bb9d45de7f1cde6072de01d36235b5d
> 
> is the origin.
> 
> Aside from that,
> 
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

I did not suggest this, so please do not accept this patch.
