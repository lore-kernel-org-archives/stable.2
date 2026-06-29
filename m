Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD703AE6FC;
	Mon, 29 Jun 2026 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724220; cv=none; b=Rfnba5p8Oq5trGEvRwUdwJlY8ML9k6EYyz/R//X4XmuzOfArdiY5fblwxR4BwH3/PRA3Xz5UHqCYYphkLjJ+yUi5LMFYOiary3USBqi+QrRLU1sxMpJWF4+08QsWPEZZDWUK9D85fOMlFDtcmzQaCZDBbmGB9otcm70OHq1Kd3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724220; c=relaxed/simple;
	bh=povc85UVv+5LlwQxVhr/2WFdvUrT48AyilTw7tKdE+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQzCGXpTn8K7ltik3siflUT+ods2mslZqM+Ck2f37aMZ509qzVFNoQXUKgAu4l0rOhs8ZmjFRbJ5zKoK18Bq/xf9ot8EcZm7GJr0tz9C5ZiPtH/FHI1rCckUhK50vDd+ns5lii6zpgZaCbILPRvuJX/dIqfAceW8AYt/WqyQ0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWDN9wd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWDN9wd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA411F000E9;
	Mon, 29 Jun 2026 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724218;
	bh=Q1Xbv92hEzMaNyKYgMGj5PHmAJfN+Jmm5zBL2m0w2uI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OWDN9wd8hUApq+Rp12Fk5iWNU/xLkrxU+gycOiiaZJp7Nc19BlGJCmFw7YLfIsVVs
	 rCA4coVSb8wyI22/OvdiLnb4k/cJzMvx2TzBQzEABVRZxVOFsesU7MKsiEJAGFgabN
	 M/MLO/QS4HEX2xubnoS+hGNWKCZGy0qeLAFKzVgcA2fwHyp7uBw12bze7r//lvWL5B
	 uRQNicgp+RrH+kiNBrbDkJqepBnUpfwSej3D9uHqtNYhALqNPL9+/LkHich8BYGl10
	 AVmjuI7JpYyVX5UliAMCuT/6Yu2/b9oPWVHE673/Gcj9LDwsWeg/mVN3eUrh8UkopN
	 n83rdn8VLFvgQ==
Message-ID: <4692ae04-1873-46c8-9e6d-819e4e46f885@kernel.org>
Date: Mon, 29 Jun 2026 11:10:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer
 dereference
To: Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Gary Guo <gary@garyguo.net>, "Paul E . McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260629075636.2513214-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260629075636.2513214-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 9:56 AM, Philipp Stanner wrote:
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
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
