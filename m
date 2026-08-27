Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CE30566F
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807886; cv=none; b=ASHnlpJ0KsaVo9uYRc0dk+81x4DGKyuuaXRHzq4XXveMlR6yH4NEXGJYydlNEIrx8otIbHM68M/h7n3tLFxq/8V/MYXCXuHNksEtKOTMsM4vOVHLYAu8YbE2bbI7RrtDNFW5xaRjxfgPvBLxTm6RB9zJgfbtFiEn7n4sbGssXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807886; c=relaxed/simple;
	bh=CWUCNjitEV75q1Bd3YVzQloqBubjs0RELvG3WVz8FdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lII+vi00hREL84qtjHILGKvvh6vFVIMpMGtE+hT6kBwoAAXEOsbups+siLLFfqeWLKHELRFdblAfmYxuHsNh3ttDZj8pG986z33LSWIrFhZib3B5LkoUlcw45bUsC64zMU3bh63U2vIC3k62o3Hzf9bzzcgjqtQgF6fKkhytwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzksqZ5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzksqZ5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B81F00A3A;
	Thu, 27 Aug 2026 05:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807885;
	bh=eIYcgk46Q30+VGtwawVmp4nAzVX6RXrkT8Y0uNj4RPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzksqZ5rc7/J0eNkbnh4PQSgEeoGjcf2hETnhGfQjQs6Kzl+2f8ltfx2Q4xpIthyz
	 DCp1MHxUDC+7i5or5LkLFcBwoDSaZzTn6hsGw2cZ75gyRqodGuP4jW1LLZKHRg8x+j
	 l3BxSnGSkJfbYtl0+f4M3saDNxQFXHCaSJTk8aWCXPpx3DPF3G5Z1SS7iT07FUChRA
	 E/m83LUq297fqU7uK0A96W7TQL45Rcuse+uN4Ji60cgWiOhK+NkrWziqkjEpf2Fayl
	 2+i3KMSB0CB8fIxWLLzlPDWxBCysLecDLYjucZbtT8I5PbnPKswdXaXnLic2E4sItV
	 /cvBoCjYlHbSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 6.1.y] RDMA/rxe: Fix OOB in free_rd_atomic_resources()
Date: Thu, 27 Aug 2026 01:17:54 -0400
Message-ID: <20260827050834.10004.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825201121.1686721-1-yanjun.zhu@linux.dev>
References: <20260825201121.1686721-1-yanjun.zhu@linux.dev>
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

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
