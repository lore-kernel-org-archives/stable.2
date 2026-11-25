Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613484;
	b=SKm6fNRTbq87UsHgEmv5BPH4ShdoNGR76ONDFaEjBZqlCwpg+eptA9c9WW7MhIku7/x2
	 eXWsAKhrvX5tALEnobT7uj6NoowdylPj0NIXxZAz5GNkmGmSqBIlZPFGvpNyNQ0FUCS2L
	 XB5ZHdG52YJAZUVNxeUwPmluLHnVyEPw5JppirINi87W5PqXyzV4eyhcqDYB3c6UmPbFV
	 AKRtj2hxaqx5EkWDvOAFt7n/VyNLostElxMeBU4seQ2DQ175QMD6WdvmmL7PKAOmqRJhK
	 JBzEQ3HUuCscEB/rXp4rd7QuQFqjCuMpIiGjO9gLoTjgvZgMkgU7piaSZBZ1Z823vMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613484;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7MpGVH6JxBaEYsTz3M77QvkXN1h/5S+Cz7tG5myU998=;
	b=M+KvZJoGk+BLenxs0f7BQRSOfrWKTj3cO+b4gKZQA9vBi2xJJJ/SzjYXf9WW0D4XVBtX
	 pygNESXX8LHf+nu9rCXvR9X5BW8gBohF+ypMb2fD/9UXE4uNtpAybmRfiATyz1RmgX3z3
	 2E+OiTf1eSp/tXtJuwZBSTx64nech8Atinf0QlYngvqxTlovVJQgWKcwjPFOvLuqTfxHb
	 h7S3+Eyyc1tmpSe73jN1dIJFLI/4pVXYeBe0MqlV9rsYhnp6Nh4YoZf0RMvAcVr0aTX7h
	 1ifwcQexmt82PxdJ1xGOC39f1vgDmYBasXpxPHnDR6pxg9If5LvlO478aaTKTC7wIjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l6/Z+scq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10405606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6/Z+scq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284231F000C6;
	Wed, 25 Nov 2026 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613483;
	bh=7MpGVH6JxBaEYsTz3M77QvkXN1h/5S+Cz7tG5myU998=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=l6/Z+scqXG1hEPwMHeJ70ClMOtY/y8Fq6eMLfQqugHBzb8ZMAsNVpIFVwr/kOKI6U
	 G2XlMsUlZZKB6ISPO/yJ1chGapzLNaSy5tmBSyxyVL+XBVOLYapgfNwSCnhoOLssE2
	 mpGLcAJuor7H48FcnwdFwLULd75tXRpZCFgFAKARA7vLphAYePRqx4wcp9DVWYWFRh
	 CkeEyaaWeQ9UOG3QjadOGK4pAwy1iTuPoJtgHTIapX6ea8L0QEiZkbULsJu1zAk4/y
	 czRuM2tTriGZzQvIJaetVY3DK8B12kvuHm2IntKF7FCeXS3X5cY602bpW3BDgsKMdq
	 Xln1bVcqYZedA==
Date: Wed, 25 Nov 2026 14:31:19 +0100
From: Carlos Maiolino <cem@kernel.org>
To: hch@lst.de, sandeen@sandeen.net, dgc@kernel.org, aalbersh@kernel.org, 
	bfoster@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] xfs: force all shared extent swap to use rmap shared
 path
Message-ID: <awbjAAgmIEE7Qtfx@cronus.toxiclabs.cc>
References: <20261125132634.113144-1-cem@kernel.org>
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
In-Reply-To: <20261125132634.113144-1-cem@kernel.org>

Sorry the noise you all, I made a typo in the list's address, I'll
resend it.

On Wed, Nov 25, 2026 at 02:26:27PM +0100, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> This series fix an issue while swapping a shared extent between two
> files.
> 
> The first patch moves a trace point earlier in xfs_rmap, where it proved
> to be more useful at least while tracking this bug.
> 
> The second patch is the fix itself
> 
> Carlos Maiolino (2):
>   xfs: move _right_neighbor_result trace before erroring out
>   xfs: force all shared extent swap to use rmap shared path
> 
>  fs/xfs/libxfs/xfs_rmap.c | 10 ++++++----
>  fs/xfs/xfs_bmap_util.c   | 29 ++++++++---------------------
>  2 files changed, 14 insertions(+), 25 deletions(-)
> 
> -- 
> 2.56.1
> 
