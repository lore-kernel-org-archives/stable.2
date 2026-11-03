Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666902;
	b=rXGemYPj6vx/+cOMIwnF6V5StstyTWwtS338LssWNrSjE0hcSa1XKqZQuW5GWuY/I/ZB
	 CMTchIku7ab1t3ohPCFByvsOLDpFFHJL0s2B72v+i49pGOnmWz2aLKe+sjtp5fvMWbiOY
	 8ZYWoq0098+r6xfC1tn4+Ih7LuekKqgE8+FbEXPcdBLYHphsqlmgrM1VvGrMxfQ8vz4n5
	 cLc8a1uAFt5w+hanSzpaDT7MAPrDVmlbmeU7hw4SnWRqStUw/+fkyX2k8u6wpvvAbbKYs
	 RG7CGYxuEWK+joPwVUGd0znwqpVjydqiJwNjchqTNbQbRCu9TLIdPk8mBPs4zDAfAUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666902;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AHyUZ3Ijjty0pNOeStNJjcLtYTK2J89cjjSDYe4hkGM=;
	b=JpL2CgoXUme91LOuF+YccHiJfr0sYF+zRSKeQWoj9GoqNo17hv+zCBltcr4Yz6d7fo9R
	 gj0221iSoD+M1r75O9xqF8hLXxSv4N1mZlebpjctBTkTELpQ7q+Jatr/H3QOqmh+7kS/C
	 YQKDjuObSEl9KlHSYMwU/TyyB5VmtKSF0oveRN3L5K774uq+A620kETyDMSLC0A/1qg8X
	 V4qKs680C5mIT1ajbb/hgbBMXQDsFAeZtEOUAtwNe7gYP8TTPGyWja5TP+A4hCMFw/WWr
	 j2z5oVQOYo27cMj8eDXC7rpae5XX1f6eSyEGJNmsDF3cP9Fzt6mN6bvEsorcA6lpq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDLhF0cF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DC606A334;
	Tue,  3 Nov 2026 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDLhF0cF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835551F00919;
	Tue,  3 Nov 2026 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793666901;
	bh=AHyUZ3Ijjty0pNOeStNJjcLtYTK2J89cjjSDYe4hkGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TDLhF0cF+F4pH6d21El1u9nEpQroY+RKEgJ5HGEIT+hhO5sku3YGQWRadYk5RAgc0
	 zrvH33OMlwUOyKC+ZyQIpbSE0v+8QNTaE1V0ZkBEb3Zai+M0C2Tftofoq3vyobX1zX
	 1B9qqcCOV8Cklc1FLnAFbevj+xF8392omZADQCz0/fRXoq06vMsUqPGqGLqbDoHRFG
	 Fkox8dqFUTkfcw1YHgMpMmMqtGh7URu35d9a2eB6uncfhnxkr8bpaQfEv47qtBYFez
	 SDc0BnY9Eq6N3Aes682GGTzdHoyI/18TW+0iF7R/NZgXhac+5p2nFle/UDToqEB3yB
	 iPE82wgdSNbag==
Date: Mon, 2 Nov 2026 16:48:20 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Don't free overlay pages after a failed unmap
Message-ID: <20261103004820.GA1862133@liuwe-devbox-debian-v2.local>
References: <20261102025754.257856-2-oss.patchbox@gmail.com>
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
In-Reply-To: <20261102025754.257856-2-oss.patchbox@gmail.com>

On Sun, Nov 01, 2026 at 09:57:42PM -0500, Yuho Choi wrote:
> On L1VH partitions where the VMM can provide overlay GPFNs, the kernel
> allocates the VP state and stats pages and supplies them to the
> hypervisor as overlay locations through hv_map_vp_state_page() and
> hv_map_stats_page(). The hypervisor may write intercept messages,
> register state, and statistics to these pages. Only a successful
> HVCALL_UNMAP_VP_STATE_PAGE or HVCALL_UNMAP_STATS_PAGE confirms that the
> corresponding overlay has been revoked.
> 
> hv_unmap_vp_state_page() and hv_unmap_stats_page() free the overlay
> page regardless of the hypercall result. If the unmap fails, revocation
> is unconfirmed, but dropping the driver's page reference may still
> allow the page to be returned to the allocator and reused. A subsequent
> hypervisor write through a retained overlay could then corrupt an
> unrelated kernel or user allocation.
> 
> Free an overlay page only after the unmap hypercall succeeds. On failure,
> leak the page rather than return memory that the hypervisor may still be
> able to access. This matches how the rest of drivers/hv handles pages
> whose state is unknown after a failed hypervisor operation; for example,
> hv_free_page() leaks a page that could not be re-encrypted. Log the
> leaked page in both helpers, as some of their callers discard the
> return value.
> 
> Fixes: 19c515c27cee ("mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH")
> Fixes: d62313bdf596 ("mshv: Introduce new hypercall to map stats page for L1VH partitions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Applied. Thanks.
