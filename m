Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226793;
	b=CXVGzZYKFbOJtLYFRFzPtcQSaEhcj9Ap9PKmMwGHXlY7u6mndF8Y/bF2mAM1XKGm+ltz
	 Y7WXXgMw6FjxyNjji/eWrmX5iwTV1Q2ZwWZCKbesAY3RyRYpSvUqPtjtS6qmQzZMTtlwP
	 7aCnhqX4zr7C2ZhkNz4hP478tvp+dAyaA+TH797Mv+TUcrOFyn6PJeSiLmN3X7x6RZ+C6
	 mCjm+qZRxoDs98NvrR0GldpKDivtzwkvUgS/aeX5HjLaq/dvvOzZoFmjXUyYUv6FLolDV
	 CVNuVaQ806jLcJGxnVRKBaPrKk/MjBHgRRk/Lh1KEgbcwDWbq7xC9jgf5jy8FB9Vg9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226793;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=TLrnHUnuKxQDgIYEl6JMV7NCbKmlJCyRBq3Hpd3l8qU=;
	b=FKadKWEV0glXCI1uVfupwrdxcsj9ARK2jJfvjZSewt5/A2BCzb6S7ufqRc7X2egB+TN3
	 nWCa5pFaLVdbRGwZwviLSiew6RBVno0x/H40Hi+7gYGFYXQGc6Z0S5FT3gRLHThX/tvE2
	 9+z/ARbf6e5r3ldL0b6QEpYn3OTItUIVNf4Bi/eA762PTfNvGXb8Xe0ddzrcw1GWnCsf9
	 TNaZfKOkcEoMGrEWP5Amj7T1QUjNd/zL0Lq9VviR+OFT+mSbS3tEQNMFyXXVJsIeZo/gG
	 HzsxWhw+DahFUEEgCy8Th2HQDNdCUpEDwc6WWiIAMT+OLvg7AYH/+m2DBL9JzoWCSFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KyGYc/76";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FCC606A325;
	Mon,  9 Nov 2026 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyGYc/76
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD81F0089F;
	Mon,  9 Nov 2026 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226792;
	bh=TLrnHUnuKxQDgIYEl6JMV7NCbKmlJCyRBq3Hpd3l8qU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KyGYc/76GpP5BOnBgF73ZQIJKAkOkBJyhzHx4Ac3QfYr6X0EIaFq/auDlW7eisMMv
	 CybW5T1K81veFCKgaLPoy6WKdB++hUXsaNGE5kWnUJNyTh2QL3ev2lQLGNKZVJEvIn
	 wETeFrjSf1Ydu2J2NAK1Aou7oVmi2yQ8KBwOY33ZzcZxy+3+Ba9aBCFvBVikwfHPZv
	 dT3Vn/aJa92pRJLx0VQvuoTBNNKGIankU5/+ElKinJYWWr0s7/HNpMR7uvxMU56sFr
	 C0nmuzTLIore/qamzALbP8qReUp8QmrjqC5/c2IoWUfAxzG2TOWvfgqr96376iNFs/
	 9amIjWQgqfyBQ==
Message-ID: <3b00799f-2fef-44bc-b798-79273c5c0ca7@kernel.org>
Date: Mon, 9 Nov 2026 13:19:46 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_move() with
 huge page arrays
To: shao.mingyin@zte.com.cn, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/26 07:28, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> mm/migrate: fix softlockup in do_pages_move() with huge page arrays
> 
> do_pages_move() walks the array one page at a time.  An entry naming the
> node its page is already on is never queued, so the loop runs without a
> voluntary preemption point on a non-preemptible kernel; the existing
> cond_resched() calls in the migration code are only reached after a
> folio has been queued.  nr_pages comes straight from the syscall.
> 
> A 6.6.60 x86_64 kernel with CONFIG_PREEMPT_NONE=y and CONFIG_NUMA=y
> reproduces this under QEMU TCG: 50 million entries pointing at a page
> already on the target node keep the CPU in do_pages_move() for 42.9 s and
> trip the softlockup watchdog; with this patch the same call completes in
> 44.3 s without a softlockup.
> 
> Add cond_resched() so that long calls yield periodically.
> do_pages_stat() had the same problem; it was fixed by 8e934ab44389.  In
> current mainline only alpha, hexagon and classic m68k can select
> PREEMPT_NONE and they cannot enable CONFIG_NUMA, so this mainly targets
> pre-v7.0 stable kernels.

I hat that we have to care about this, and I'll probably increasingly hard push
back against such effective stable-only fixes in the future.

In particular if it wasn't even encountered in practice but required a QEMU TCG
instance to even trigger it ...

-- 
Cheers,

David
