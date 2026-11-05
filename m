Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872230;
	b=Tz6tDd5SuwQQxoFYAzIGRFaDDb3CwN2ivCK+6UUXb939zPNWybQ1Hc4m5wc2IYKXO7TW
	 1uWxqXnkrZINA/uJGn1nuS5SB1I5ZaQgg4iyVaBL8XS3j0xoU6pgICwdgChEImDAgwJtj
	 wTpQT1YroNFziDCvZAPVYisPCkdIWKn3sDd2ld3HbqMqqGlBgNfgu2KU1Ss6+aOrguB8P
	 GyoepjcywDrzgiX0EagiU5zf/nJA0zrfhYKSv2hQlF5/rBDgAuq10gI1t4lFgE0ZaUkoe
	 BQJZVK50TU1bw3KDNBTLtt8aEti3QX3V+ecBSwD4lKBTIJZ8sAvnvMYDLTKUQZjZviw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872230;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=eKvOk6hqjka5HPdZ35CJThnwv8GeMdInJ5jOI/7/YwE=;
	b=1ws7oqi0d2gKi0WM3BP2nsfvzzgwGKbAPfJEWi80LKAz8zXorxGl9sq0+xPN+P9tZf3y
	 J55rPKQGb5/tWtXKvMO7Kdqs+MV+36Apj3vBhyeKS6ygnTfahYSfe5u4Cv2+mpGQtoy99
	 JNpmsfPfAblh5tP8hua7NllPL9mGF60806zVOzeGEHDD2KtB/cWmm03H7JksiJ3sHWjCK
	 1pE2TJAdn7pu4+Gx6TKG3uMZbPyBVoKJ5dIycewJm+KwLo6ID6tFb32VWM2yRUmFWI61e
	 FpT3IrwUFk9zRYkcgfzf6F2+KEapY9MjwgNSZRYQLqgcV1kp68qigCt7yMrRrOiTAzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLKKX8Wd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FA606D81D;
	Thu,  5 Nov 2026 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLKKX8Wd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A51F0093A;
	Thu,  5 Nov 2026 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872230;
	bh=eKvOk6hqjka5HPdZ35CJThnwv8GeMdInJ5jOI/7/YwE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gLKKX8Wd//E5jldGnKbwM1rC476RYrG/9KK0TriRxzreefZGhKF9PtPjB463sQJ58
	 0fI4jd7HL1cKiQPGquBTp1BEiIDgx69fOkdw1+jEUuli/DXjug9cKpVlSyvfNrRYQx
	 iJVmxDfVbUwzt6uSkuGnbcOv7f7DPipHlbPCRJkabT2oV/8TWL1W6sp3yWpc79r8jd
	 CcRi78X8/yVqJjSU3m9ZYj4uOhZmle4STN0OCNzqfEvNEwCqLMxG6Nm78F1dmnitdJ
	 BrMIf7cJcCl9lyjHZ1H9dd0buPQPvAmeQLKjHyYifPhZMLM/maLUZKtckm5Y/VsBH1
	 8lcp07Nn/N2hw==
From: David Hildenbrand <david@kernel.org>
To: linux-mm@kvack.org, "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, 
 harry@kernel.org, stable@vger.kernel.org
In-Reply-To: <20261030161234.1505367-1-gourry@gourry.net>
References: <20261030161234.1505367-1-gourry@gourry.net>
Subject: Re: [PATCH v2] mm/mempolicy: recompute automatic interleave
 weights on memory hotplug
Message-Id: <179387222742.14716.9173968610487237394.b4-ty@b4>
Date: Thu, 05 Nov 2026 10:50:27 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Fri, 30 Oct 2026 12:12:34 -0400, Gregory Price (Meta) wrote:
> In auto mode, weighted interleave derives each node's weight from its
> bandwidth, reduced over the nodes in N_MEMORY. HMAT and CXL report a
> node's bandwidth once, when the node first gains memory, and nothing
> else on the hotplug path recomputes the weights.
> 
> This can result in a major skew in distribution and overload tiers
> with more data than their respective bandwidth can support, resulting
> in a performance regression.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: mempolicy-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/mempolicy: recompute automatic interleave weights on memory hotplug
      https://git.kernel.org/mm/core/c/ece8f7dc

-- 
Cheers,

David

