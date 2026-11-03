Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716458;
	b=wzNndmRw6zhvChu909Zl993LuFgusCN9z8j+gA3pBeC/Qm9Ze8VqCbl81hU5kjMKv14N
	 BxwFie37qTad0kzdDWNbJl4OqlUfMrB+DXrTIQfUBNmh7KSKOnejixH4d4B3XIfwZ4Jm/
	 hlNoFuZrLouZa9eR33MZMfT6dxY9PQE3Id4x3JNbmWjN/P3MAOfaz4msY73TtiTev/c7T
	 D5WV3ciVt0X3zKXBwzRF4PSNWuedbdOXPejYPXTgwmma+7PhU1rf2L9DyPI1/PHzGRhmI
	 kJ9kFDHzfa0F2P7imKlfCnS3PaYrhY4VBbdBZUwKvNRZmYzT0FmQElaf4R2rOGxFtpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716458;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0ajyy7n+0qSH1YTBPHJg2ZBD7XeUrxHy6Kcj1EJImYg=;
	b=d4qipvW2A4OYPJiwkHIbLdVR93dTIQWGh2tPxIBWRgTGg4VIooNs3B6wTRNdoFTE/D+/
	 Aa0MJEGEAWNvN3OGOshlsKlnsT8YjbQfKs9bqIKkxGFsSu/+Kt9EnX8D36P6h2a1rBviK
	 0vLB/qfOXWFHb9zFgLxXEL+xzKzokRjdpyh5wW0+1OVaIZrNAizkibanymrkJt969DdcT
	 Z4m9YtnoBoFeKN8erZkdYKlCMcPynxgkTvyRy0LTa5crDTeSIFcdEY7faJLrogE9cdom5
	 8eyGrRrNCRChTpf6el95pyZwgK5gXMAJGS1IaG1OWGjNPGcHp8HvD+uimuynbX/FBvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPTCykYL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F0606D83E;
	Tue,  3 Nov 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPTCykYL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC6E1F0093A;
	Tue,  3 Nov 2026 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716457;
	bh=0ajyy7n+0qSH1YTBPHJg2ZBD7XeUrxHy6Kcj1EJImYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPTCykYLb7YyiJfftqIjfbRil9UPgYWqaphUQv4SNzGMIybk7zut1L7O8CycL0PEv
	 Smo0NgFZGhnE+mBm7d9Btecxf57Ahxs29iz8mkXeRHCPAETLHr85sZIyWoN6caU4eI
	 Ol7GIqDjsQJNf1roys0/r/YwrfJP37d3aGtuBGDBHiKYgYoKHl7VVo5s8XPI5BOU3q
	 Jlv+0oj6r42VtAZvavVTNp0T2saIeiOJ1iLja14RovmpDMdwqr8eAnzS0XW8QkM8Lw
	 887397wb8fvNkInSWSXM7qeWGxayhLmWhlLO+BDB2X2DhcHaVwnIi73BFArxarkNqm
	 vJrNG4eH9MRIg==
From: SJ Park <sj@kernel.org>
To: Wang Guangke <gkwang@linx-info.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/stat: avoid overflow in estimated_memory_bandwidth calculation
Date: Tue,  3 Nov 2026 06:34:09 -0800
Message-ID: <20261103143410.87235-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103034034.7978-1-gkwang@linx-info.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wang,

On Tue,  3 Nov 2026 11:40:34 +0800 Wang Guangke <gkwang@linx-info.com> wrote:

> estimated_memory_bandwidth is calculated by access_bytes *
> USEC_PER_MSEC * MSEC_PER_SEC (= USEC_PER_SEC) / aggr_interval,
> and users read it via
> /sys/module/damon_stat/parameters/estimated_memory_bandwidth.
> 
> On 32-bit systems, access_bytes * USEC_PER_SEC overflows unsigned
> long once access_bytes exceeds about 4294 (U32_MAX / USEC_PER_SEC),
> so users get a wrong value.
> 
> Fix it by doing the calculation in 64-bit and splitting the division
> into quotient and remainder.
> 
> The issue was reproduced on a 32-bit system (qemu-system-i386): the
> parameter estimated_memory_bandwidth reported 362 instead of the
> expected 1926150; with the fix, the value matches the expectation.

Looks good to me.

> 
> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wang Guangke <gkwang@linx-info.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
