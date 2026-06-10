Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED53126BC;
	Wed, 10 Jun 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099757; cv=none; b=EWRA3gfCUiLBUpIcQdv8NagEfheOSVRasjwahiYQXc5gQensKyG/Y8uhxcG8+grSxP16TZX0xo/pNIrcqhgoJ+3d1SMJ8dwLtYKjYv7ggCVLBbT4D1twOiKOqHjWtFXxTEtgn4J2BqANTgLdxbomDx0UA66k6NGfdBIcuOKhDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099757; c=relaxed/simple;
	bh=bnXCxmXajJ3DovngDEr7KY9jYu+IE5TRRqVhNOpLMGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUWeR4VmQs0/zW/ZqhkqQgT3FV/GbQdDd3UZtaDCYMPUgj84vR2L9DnWwZarth6ulDnxe97C4uG1BajDddZLRr7vQT/DnN2hg6sw1SDxy/okS6qSYm7HIdYzl8nYnbKgZTXFHZuLpWDtTYHx6vLksR4blWmZwUXVo4cIn9/5uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxjGmrz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxjGmrz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1301F00893;
	Wed, 10 Jun 2026 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099755;
	bh=QkcNeccX3GDaT1+8qzrbll8lI3ayPx76hs8xzuucw+M=;
	h=From:To:Cc:Subject:Date;
	b=LxjGmrz8aAeDCcGDnVRRCm29TcsCIjFSmrJYduHfx3OH1L2cQyP2BXv3bhOhl0y2F
	 r3yYaqPPVJa5sKHH9VGFM3lTYWCqa9w/akkQucPYxiJldSXC2NWImOpHA+dCadRxeW
	 Y5gvNRS0RUrX/j8TBrtUuCb8MNaNhIn5on/aVuDIBS6I9IXW2oX+NNffxJrg33qGHa
	 fkJ6svkJyujN1T1azb8EoXUMdLxoUW5GhuXtVZTPOCqLrmE96e8HMqy1ADMSCXoD+2
	 0jCGw1YIZNnJtP4Oe6IjEnohZhBaz+aS/RJRL94M5TxNX6ySMTowyuUvnJy3LzkaZt
	 jFRHr2Q3DPOBw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 0/6] samples/damon: handle damon_{start,stop}() failures
Date: Wed, 10 Jun 2026 06:55:38 -0700
Message-ID: <20260610135546.64943-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All DAMON sample modules are not correctly handling failures from
damon_start().  Among those, mtier also has an additional problem for
handling of damon_stop() failures.  wsse and prcl also have a problem in
their damon_call() failure handling.  As a result, memory leaks, next
DAMON operation disruptions, and use-after-free can happen.  Fix those.

Note that only the damon_start() failure caused issues can reliably be
reproduced.  Reproducing those issues require the admin permission,
though.

Changes from RFC v3
- RFC v3: https://lore.kernel.org/20260610011420.3018-1-sj@kernel.org
- Add damon_Call() failure handling fixes for wsse and prcl.
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org
- Add damon_start() failure handling fixes for wsse and prcl.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
- Add damon_stop() failure handling fix to the series.

SeongJae Park (6):
  samples/damon/wsse: handle damon_start() failure
  samples/damon/prcl: handle damon_start() failure
  samples/damon/mtier: handle damon_start() failure
  samples/damon/mtier: handle damon_stop() failure
  samples/damon/wsse: stop and free damon ctx when damon_call() fails
  samples/damon/prcl: stop and free damon ctx when damon_call() fails

 samples/damon/mtier.c | 14 ++++++++++++--
 samples/damon/prcl.c  | 11 +++++++++--
 samples/damon/wsse.c  | 11 +++++++++--
 3 files changed, 30 insertions(+), 6 deletions(-)


base-commit: 1fe919b2e7b6455d0b976d75dcbe44324361a83b
-- 
2.47.3
