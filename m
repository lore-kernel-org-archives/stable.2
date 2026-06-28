Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4223B71D7;
	Sun, 28 Jun 2026 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683694; cv=none; b=E03eSEJMSJp6Zr891zbpIoskBkEOQKAqfkqJBtdJaKGH5VTWJQ6cw+IJw+ofrAw1dcIlia0ATPC2Ri1W//rBBT2Ga+9JGzk4TzczHut4dqpwWxXDSLVrOC6WzzWTczop82bCcs2rRsAI89PjU2Nw93sPh9xCeCQi9cJ8d/+erjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683694; c=relaxed/simple;
	bh=RCTr6WzinCBRJCf76iFIZiBNOnNNLIMbUYmMVNswliY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fr7TdGB4AIfqmxEDSYReYxUrlhInTfe24x/tGudSsWMeIWC10oEkAczqcJq6VfU7UF6bXKE7e5zvSOC3CcVYvJzD7JljFffG1C/3AUSOXd7/vzjcnvEEMG58LGggS8BaIndQpFPYQjOiKuGpE+cHBIWb+evYTvU8mr5MR2C7Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odQNqTH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odQNqTH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E499F1F000E9;
	Sun, 28 Jun 2026 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683693;
	bh=wb/G2WI6U+bmHwkuU5P84fH/ZMN31r6Got3AOveygXo=;
	h=From:To:Cc:Subject:Date;
	b=odQNqTH2ZMrhe7ZozN5h/oAQeRqYWv82de3+V/fqJgmGDBk4t48gPKmL9/QgDbl3O
	 hFyMymvuoOnpaWxR5Qg5jdHIU8rv7ZTf2fJUom07/pKHToC8vka2u23rxOUJUQ5TRg
	 F0X0RE3Wl1TOgopWvBD075KKymx+dKmtqlbGxm3PrPDERUwc5ojjy8piMxg1fkRzK/
	 HSkLXPUm/qb8YSM5yN5WDE1RCcvuAhjNB/1Pk6K1DJ99Xcs4fcEwSqb6TXH7LUKKUm
	 LnGig2acjXxO5jfQ4/0ej89esSErXW2DdRqMWI/gWdnfLnGTPg5V9UVeE/7ytF6ueK
	 JUxZyyoShCbFw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] samples/damon: handle damon_{start,stop}() failures
Date: Sun, 28 Jun 2026 14:54:39 -0700
Message-ID: <20260628215447.96166-1-sj@kernel.org>
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

Changes from RFC v4
- RFC v4: https://lore.kernel.org/20260610135546.64943-1-sj@kernel.org/
- Collect R-b: from Zenghui Yu.
- Rebase to latest mm-new.
- Drop RFC.
Changes from RFC v3
- RFC v3: https://lore.kernel.org/20260610011420.3018-1-sj@kernel.org
- Add damon_Call() failure handling fixes for wsse and prcl.
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org
- Add damon_start() failure handling fixes for wsse and prcl.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
- Add damon_stop() failure handling fix to the series.

SJ Park (6):
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


base-commit: 77fe35dfe005f7d55c8e729e1543b87cfc805a21
-- 
2.47.3
