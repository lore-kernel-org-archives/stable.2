Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706221;
	b=gzXCAifuj+sV9jnBSQ7jvJXnXStQw/XaSkBah7af6W1eSQ6fD7p1IigdHGup6ELMwyWg
	 ESYmcXP4gCoG1KOWzS3gLzNeRihw5Gv3Eb4yBqkYRQdv+5kIG92HlWrE4hqtRnc5YSc2G
	 kD4hWCJ/kE1Cyl2P9DItba+cE5kC5zQ8Rm9iE2PX3JuOPrWt0x1ZF6YTu7LHdvbkG9gxr
	 9nybjzovwP90xDS+WGBEHozVJD9TaMS6jASBCj8Ui47ru1EPGXd1H5mRabvVp30fyjB0s
	 MACm//WUAUw9uJF+213l34hKWUmUzoddwwjSeNGPX9WvabIid6qakhvB7FW1JRGCVsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZKSEP3+/PcST9o58HFuWpOsPhP57g1jdoiPcpSylqH0=;
	b=1yuNv+vxSvc7wVFWbNWG45/v1HkXTa1sFbMpkgOjcmVzeXjUn3X6ile05LYvqfjgEBLy
	 XNlT/hTymH9PlgK9wWIh97az3Pvo+s8Lf9NNuk/6gKkiUExdl74KhETcYNb87/rDSQ5Ya
	 HG50bpJSU3V5UwLVNEUzOnq1b/t+SAawqEg116udKVVrCJu43kSNYwYSPGtnYuZGYsmQ7
	 EPde8peIxS2QiciSnIwMrUXsTgZ4SGNvE9jYaLpbf5VOUoSh2SaUGcmEOeqlN7hCHGSbf
	 Db2A/ajf4Nki1nueOJ5u3KgfiBiQo8f+k4qBw+q+Qc86XyloPd9hDqqvFh+B5hHdq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZfp1Nvg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F26083608;
	Tue,  3 Nov 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZfp1Nvg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C671F000C1;
	Tue,  3 Nov 2026 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706221;
	bh=ZKSEP3+/PcST9o58HFuWpOsPhP57g1jdoiPcpSylqH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZfp1NvgntwSxvPaNI+cFq/sI2rMD1VCnCQTTpZmIPiSbkJm3yj/HWbv8TQGPIePI
	 btnGiLXOvb4gGwItG+UDHZFugtQA2CJeFHbXO99tXq7XX3X52el8BK4TqtBLRkR0hq
	 i3UH1xdjsy7U2M+d379DSIKrNzSccQ/uSPm46YZnuFXJ5Lg1n3xCYarV69oT4KeHZi
	 Y/fL7RLvkvuwP7DCBRVjzaZJCDWfNeteLWepasM2sAoJSz1GQHvOftLYfNFnVtQfqI
	 QdX+On8gH4yf5FL/jt7Wf1005lU1NoFeO7d3dbvhWMvHJDyR6YvcgnAc7qTJUrHbwZ
	 pEgmCcYDLj5kA==
Date: Tue, 3 Nov 2026 11:43:35 +0000
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, lkmlabelt@gmail.com,
	parri.andrea@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH net v2] hv_netvsc: Stop PPI parsing on invalid metadata
Message-ID: <20261103114335.GI865646@horms.kernel.org>
References: <20261030093459.4004663-1-ernis@linux.microsoft.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030093459.4004663-1-ernis@linux.microsoft.com>

On Fri, Oct 30, 2026 at 02:34:59AM -0700, Erni Sri Satya Vennela wrote:
> rndis_get_ppi() uses continue when a per-packet information entry has an
> invalid size or offset, or cannot hold the requested metadata. However,
> the remaining length and entry pointer are only updated at the bottom
> of the loop. Each error path therefore retries the same invalid entry
> indefinitely, repeatedly logging the error and preventing receive
> processing from completing.
> 
> Return NULL on these validation failures instead of continuing. This
> terminates the lookup when malformed metadata is encountered while
> preserving the existing behavior for valid entries.
> 
> The issue was reported through an internal bug-tracking system and
> confirmed by manual code inspection. The pre-fix hang has not been
> reproduced locally.
> 
> Fixes: 44144185951a ("hv_netvsc: Add validation for untrusted Hyper-V values")
> Cc: stable@vger.kernel.org
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wei Liu <liuwe@microsoft.com>
> ---
> Changes in v2:
> * Add Cc: stable@vger.kernel.org
> * Clarify how the issue was reported and confirmed in commit message.

Reviewed-by: Simon Horman <horms@kernel.org>

