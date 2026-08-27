Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BA367B72
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807885; cv=none; b=EVSXFMVhJ2iWgiNKB8Pp+R6oCVgegf2qyxWtnjC+xIeXsX+ZN/dpCg5DI23XGTlkz9M+/FPYkU9NNGdW+lLtbcV/ETImAgfqHw2/UEXHEsOQR5P9VNtIj21e/QCJEKKokr8p1M0OgAS5Posvp/9XFIlr+uBxiD5G2ReOO5mOKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807885; c=relaxed/simple;
	bh=DqqwVq0aparq/g7fXzz9nuMb8+R9WRvnR2lOvoKOPcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn4zSV8sXlVB1fWgBv9rD6RRdkvFZXj1Rq7X65bwoM+IWu6LEr4iTjK1sWD2y3lA9QyK+I3UoG9qhL4NwNk3SDRZap02EdFCeok7Z6DTUDyKLlMqYFYO1RkX2dGRHp+U0rtzrGDio2Aj3O536ukovOjvhC7U2gy8YB3bavb5tFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5ZrO+i0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5ZrO+i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F841F00A3E;
	Thu, 27 Aug 2026 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807884;
	bh=7U9Y8V/igGwRQh5t3V28tkE6h78IyNxtnhJeGHYNdhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5ZrO+i0ezm+pJQ9KoNUVeOvDPTmMR/61+9eFNCBqCQsOMlgdSuWWMn2PkDiGh+bT
	 e804JOSrr3CQOQKkjdMwtwjmJSVZHHuC1Mz+8cdEcc9EPzP4H44Flw+axVefyW0dJp
	 phj0Zg2XxZnAFlFP89EQ6WXrevNvN6And1IWFCX2s2nOx6jTT21Pl0y8vGT6WB/iqe
	 OVrCHTs+6SssL87DJJXhPPKO4V0UM3ra5f0jo26n1/aIWUGXIaq6YO262fQo6/+xZ3
	 /9yPph7VNVNU/PZpRR9+8G9wDnOR0LnpL9VmvmulVe2KXHE9XiCs1S9O0dnua1w0xR
	 kX0Aye6xkWBVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 7.2.y] RDMA/rxe: Fix OOB in free_rd_atomic_resources()
Date: Thu, 27 Aug 2026 01:17:53 -0400
Message-ID: <20260827050834.10003.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825163605.21809-1-yanjun.zhu@linux.dev>
References: <20260825163605.21809-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> free_rd_atomic_resources() iterates using qp->attr.max_dest_rd_atomic.
> Updating max_dest_rd_atomic before freeing the old array can make the
> free path walk past the old allocation and trigger a slab out-of-bounds
> write catched by KASAN:

Queued for 7.2, 7.1, 6.18, 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
