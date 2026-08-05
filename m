Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C4266581;
	Wed,  5 Aug 2026 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892417; cv=none; b=EKWG5BPtQEJsLvXQLtD9kKm1XKspvfiCZHgPtisgwu4kykUtD0DhRslg/9uARBCrvWa05mBsfKSHmLLEaAiL+sTlcEk/NKM5DukavtvUCI37JG3hb5OA/CWKg+2g1YzYrEDGV03SiEAtFOem383smzZlTyRtVf3R+XX4B5zxRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892417; c=relaxed/simple;
	bh=KjNk9o5V1CYz1Y64aowRMgv6+dhA3GBrATSifnPiZv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUyXtUCTxyzPmakaTO/lNhRCfxhAiBuj7WF0/+gFkzKeqCRNXleYaBIAxRG2kYWsE87153YBpkL5vDL7dtvR/YxjyUmZWZ/12VR/6CJpm1uONVyWaeS0a2UDpsa5+DhcOR3jhk+sPPDZWIRi5YfVo1p6IvIuSRiDPQi0KLjQZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqn/RzvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqn/RzvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057A01F00A3A;
	Wed,  5 Aug 2026 01:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892416;
	bh=ly7Ia3HDtVzmThbINGK1iODAgsKSLPZ4cQ2JGxxMpNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oqn/RzvTGC2TivpKS6PKIQkI/y1WSQqoCuGuByY1FZqYdzXll1ddwWAlT9HeKtsLj
	 xDSsEmSGsQp5Ey8c45CZHyBY7ZxP/KHh3RpSvg+I0OEeEaYNDeoy8FTHRiIlCFz5eQ
	 rN/fVpHcRKozNpSv2we2rWlQAWfglDs7Udd6wA/blHOJMHCvEofIUFM4fq1GOWd8c6
	 /LGbBFa0ibn6imrZWdBUgrVfG78VxwjSGxV+4kKNwA6ac3vySLxQZTtvm1l99PM3Ot
	 TMkkebcNZQ8+hJkngQ+waQe7Zu8I/eE+i9N1GLIDTMkdEKfd5rAMxafENkdCo394J3
	 IOYApGKDyWtLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangpengfei16@xiaomi.com,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: Re: [PATCH 5.10.y 6.1.y 6.6.y] ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
Date: Tue,  4 Aug 2026 21:13:24 -0400
Message-ID: <20260805011000.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804114655.179105-1-zhangfeionline@gmail.com>
References: <20260804114655.179105-1-zhangfeionline@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 07:46:54PM +0800, Pengfei Zhang wrote:
> commit 9facb861dc6b9b9ea9793ef5032a9a826f7a4229 upstream.
>
> inet6_dump_fib() saves its progress in cb->args[1] as a positional
> index within the current hash chain.  Between batches, a concurrent
> fib6_new_table() can insert a new table at the chain head, shifting
> all existing entries.
>
> [Adapted to 5.10/6.1/6.6: return variable is 'res' instead of 'err';
>  error path uses 'out_unlock' label instead of 'out']

Queued for 5.10, 6.1 and 6.6, thanks.

-- 
Thanks,
Sasha
