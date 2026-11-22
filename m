Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363382;
	b=FdBMNyuDi+ioMcvgNaIsTSl+wblQgLTdsx6kw2nz9xM4fGwcfatYbtMHSBA4arWl2e5y
	 jzsZeLdO3ZrS3Es4SM8E1PDF0dUpvdOlXj5/codhPGMVrjt2ZxzolF0PV0qvcuTUQ3KRB
	 w8a3hFMl6wd0yYm7ejvVt80LN/3vewW+gcG59ArElpLCGgXESqCZ6L3BcHr7hUOUzAY8G
	 YZKW7wZxi1Z8yS/Q+kmwIrl0Rwmo54pHL7WWz1yqlMP4JWaNgJoEUNEo4Uve7XbkwnmwL
	 dqhfONOeFrjsKAZk2uAdB4WgA3xDmvOuqOpfToRcTF/8rE5QwEpgqVtlfT7vf6Eac9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363382;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=pWrFVk6jgK3PVLqBM+zS8clEjvR/O2D2al0UZuWHR8k=;
	b=CJzumJgxG3IvHmfX7CYzF3gxYYk83zIxn+CCtDfNlm18E7XXHBxdsEzJTbR+FdhWkhkE
	 9FfAlNR4F4AvgGlz71+9eFJxP6XAsOgwmn6lEMPAPcIVQZYT/ztCc3BSJ8D+LVgzk63oC
	 TlraEuEtEVaEHQRbFnFh/dJ4atfXwr4SeIcJ1TBALnIriVSNhysQZKoySt08Amtfm1Zyw
	 tbsRHfouK9kkBZ45ErHv923AaAWK8p63y8iEmq8vJqpEX3j4jgSA8hGY4rOldaoOYr2uV
	 maoYNXW8iHl7+HR4sCn3lQEqQiR8LMKd263jgID3DFbo+pIOlojlvpzAbvAxkqcsr4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yxs9eT9X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C075606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yxs9eT9X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF4D1F000CA;
	Sun, 22 Nov 2026 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795363382;
	bh=pWrFVk6jgK3PVLqBM+zS8clEjvR/O2D2al0UZuWHR8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Yxs9eT9XTC+S/5am2omSG12K+MahuUn2IgzI1Wv2tYqr9H8Tzg1YoK5asUHr4rc2c
	 G6DogWsTg/YRXrVb9WspE52ukHQVmGgjYKS4zc/AWGpu6MdNWxLC/vH8k6KOYtLdkV
	 hGfleRdqUJ/6yLce1Ac9kaFrX+AGZsyEGAVEVwwzu+nQAZqsaJQqVxLM5FHXtSIjN4
	 B6gIaVLhNtctOiEgek95gzk43jUMOZgMWRYiVuQ4r0XHbJSbY6oaX70oTc6Ia87kCh
	 VVC31cxiOcPU3R31J4BVuT+ky6N1meB9/QSmawXajdjK59GB7GIYS22Fabl69Q1hPz
	 iiYV/axftZjVw==
From: David Hildenbrand <david@kernel.org>
To: David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: larips <larips950@gmail.com>, stable@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
In-Reply-To: <20261120185248.823415-1-arnd@kernel.org>
References: <20261120185248.823415-1-arnd@kernel.org>
Subject: Re: [PATCH 1/2] [v3] mm/mempolicy: fix copy_nodes_to_user() for
 odd inputs
Message-Id: <179536337870.3554.2407408081823588964.b4-ty@b4>
Date: Sun, 22 Nov 2026 17:02:58 +0100
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

On Fri, 20 Nov 2026 19:52:12 +0100, Arnd Bergmann wrote:
> copy_nodes_to_user() is broken for compat userspace in three
> distinct ways:
> 
>  - Passing a power-of-two size plus 1 as most normal userspace
>    does can end up calling compat_put_bitmap() with the wrong
>    size, copying an extra 32-bit word from the stack into
>    userspace and overflowing both arrays as compat_put_bitmap()
>    expects the actual number of bits, not the number plus 1.
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

[1/2] mm/mempolicy: fix copy_nodes_to_user() for odd inputs
      https://git.kernel.org/mm/core/c/50d3f729
[2/2] mm/mempolicy: replace copy_nodes_to_user() interface with put_nodes()
      https://git.kernel.org/mm/core/c/995fcdf5

-- 
Cheers,

David

