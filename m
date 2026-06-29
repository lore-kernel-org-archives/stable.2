Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08E3ED5D6;
	Mon, 29 Jun 2026 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722485; cv=none; b=szmMotaC0qEBeCLzmbxYw4jz80cWyrFP3LN7aYh0ooNJhL9PPSyrVZzYyy9ETS+JijXW9nMyRrHsxUxq2MMiEMNIVYol5G0dtEuF/j+H/HJNAMq8AVB4OENoh7R/XGMszWWc/f3dN194q3ld9JNzZ+amkZfz1eCA6QHhaXTirNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722485; c=relaxed/simple;
	bh=tmVYMQLt6w66eKgeMnRYtDFyZlz9JTeXyaU4pBlZwO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivzRg1aRXSc9iKuZMub6ROKtdKJejE7CpAExsP0mLnDdT7daeURdXtMoUWVeMlGvgmQDXceBQO81fPBFWiV3yWGa48Y8zjXp1g5rphEVS6gLnwJZGZ7p0b2EnjnAowXoVG8pq0kwLhkS/bdptiR9QytU9qFwwTvud8bfN/oT6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wja8IEen; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wja8IEen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782722476;
	bh=tmVYMQLt6w66eKgeMnRYtDFyZlz9JTeXyaU4pBlZwO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wja8IEenS+49sHofjDn58Z2mmMXgQ0UGP4Xy+VAT6HtfYogNC3vjzjVSW6w+ubSFD
	 X/FOKiHUU8JM5qyFEA8ylxQANgiPQJdBGVld6lxNz652ueAMTtUhexR5HT7HbR9cu0
	 LeBAAXsXcUC5tAETWzVc6ygHBav2izO7OmwlXYn4DFP2c+xhoMPqttDv2yim2uQOtk
	 vezEbp6jWQOx4C8aZXuCJxxHWZDaLYT0s/vl9EPzv9AGhffYYo53fyvp4h4a3Y/2L7
	 B0TKpWTdG/Xh5T5HE4pTbDdod3muymIr1S7Ae/i9QqLOKZYCksQ1RMDLWF6JA6MYvA
	 a/zHXOWnc8PJQ==
Received: from fedora-2.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B45E217E0246;
	Mon, 29 Jun 2026 10:41:15 +0200 (CEST)
Date: Mon, 29 Jun 2026 10:41:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Danilo Krummrich
 <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer
 dereference
Message-ID: <20260629104112.72d58bf5@fedora-2.home>
In-Reply-To: <20260629075636.2513214-2-phasta@kernel.org>
References: <20260629075636.2513214-2-phasta@kernel.org>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 09:56:37 +0200
Philipp Stanner <phasta@kernel.org> wrote:

> The commit mentioned in the fixes tag below introduced a mechanism
> through which fence producers can fully decouple from fence consumers.
> This, desirable, mechanism is based on the fence's signaled-bit as the
> "decoupling point".
> 
> A sophisticated interaction between RCU and atomic instructions attempts
> to ensure that fence consumers can still interact with fence producers
> through the dma_fence_ops (callback pointers into the producer).
> 
> This is the desired behavior: to check for decoupling, the signaled-bit
> is first checked. If it's not yet signaled, RCU ensures that the ops
> pointer cannot yet be NULL.
> 
> Hereby, dma_fence_signal_timestamp_locked() first sets the signaled-bit,
> and then sets the ops pointer to NULL. Readers first load the ops
> pointer, and then check through the signaled-bit whether the pointer can
> legally be accessed.
> 
> These set and load operations could occur out of order on weakly ordered
> platforms. This problem can be solved very elegantly by using the ops
> pointer itself as the synchronization point. The pointer is either NULL,
> or cannot become NULL while it is being used thanks to RCU.
> 
> Replace the signaled-bit check in dma_fence_timeline_name() and
> dma_fence_driver_name().
> 
> Cc: stable@vger.kernel.org
> Fixes: f4cc3ab824d6 ("dma-buf: protected fence ops by RCU v8")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> Changes since v1:
>   - Use ops pointer instead of memory barriers. (Christian)
>   - Rephrase commit message.
> ---
>  drivers/dma-buf/dma-fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a..0a025dfdf131 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1170,7 +1170,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
>  
>  	/* RCU protection is required for safe access to returned string */
>  	ops = rcu_dereference(fence->ops);
> -	if (!dma_fence_test_signaled_flag(fence))
> +	if (ops)
>  		return (const char __rcu *)ops->get_driver_name(fence);
>  	else
>  		return (const char __rcu *)"detached-driver";
> @@ -1203,7 +1203,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
>  
>  	/* RCU protection is required for safe access to returned string */
>  	ops = rcu_dereference(fence->ops);
> -	if (!dma_fence_test_signaled_flag(fence))
> +	if (ops)
>  		return (const char __rcu *)ops->get_driver_name(fence);
>  	else
>  		return (const char __rcu *)"signaled-timeline";
> 
> base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7

