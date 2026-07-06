Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98230D40E
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346908; cv=none; b=EapNbZAurSXGi2rzVsVC+CN227ftuO6wgKlPD8JwIlUPRCJczTCnSbrybpGLucYJ89QNX2/IH8C/2hBB0oEzUXND+uzvN+O6eY/TCZQ8NG+ZfqFxrSygE86utjWTl3yzl9wREdq2JU5UhnvP0xlSRyBX0mJpDc6ZGFZJjnbdDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346908; c=relaxed/simple;
	bh=uBd45M7ZY3EjzaoOAbjBdkXbM6HhT1QhIZAbd7+Coak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmyuBCrQYXtECG0R2uG+n9o4bj4U/V6gRKD6ZKl5LK0s+P5jQqi2rjpeKpkvm8IgHKafiCNdcg+Oj+6+HNDf3nqly/ZOCCMPEgP2sKGJ+QFs16NuwUwhKL4G2LBKPYRZWe/0fOtxBsTHq0kaPSLaGpTI+9JoPXfkJCykRPd9mlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3/Ng7ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3/Ng7ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B561F00A3A;
	Mon,  6 Jul 2026 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346907;
	bh=CoZYGqyUr83oGA2048QiyZ2He3N1xYx508goHw7TWjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3/Ng7oukNPfncjCpxTkXP/GjERRzozlvS3r/QmKqju7u/V74HXNBuvpd0sOtOC4k
	 R0aN0BYiSRHcVDGKolq7cOaQcvrquHqMI1P3CHo+FL7KlWljEFi8dg2Bn1r/+wz7vl
	 Cg13gZ6lx3pnzEfnWIRsupUYqL5wh1+ylgo1X3oZi2B9b0g2WHAHfsCIdHxa9LgcG+
	 7P8mWhM0QF1guOyrFM5gd6iyCL2pqbhobfPSPjvZnpDcSilqHaFShywdvQYQTQ42Sc
	 tFnfY3NAAD7/cZIylEVXZ0iig7tsm1GnI7FlXqcsSWGRfCilKEpTLOgxtHIFCttiBx
	 qR/l2n/lUs6ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ron Economos <re@w6rz.net>
Subject: Re: [PATCH 6.6.y] drm/amd: Fix set but not used warnings
Date: Mon,  6 Jul 2026 10:08:18 -0400
Message-ID: <20260706135124.draft-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706044341.1099693-1-re@w6rz.net>
References: <20260706044341.1099693-1-re@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 46791d147d3ab3262298478106ef2a52fc7192e2 ]
>
> There are many set but not used warnings under drivers/gpu/drm/amd when
> compiling with the latest upstream mainline GCC:

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
