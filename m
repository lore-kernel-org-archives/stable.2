Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70F4848B6;
	Mon, 28 Sep 2026 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585305; cv=none; b=SZxXTsciJmH+Il5UhvrjLKA/1AW+FwVovBPFevmxQuiA32DVumUPSyUO9LMTIzfntRup8Jrlex9zbduIWqLf2ldgIhDmi3FoPBC4IcD1+ZC5N89JG0BgIJAFK6lBb5W3veE/B4pLY6boZdaSAZ2PfAtEN8WE3CZEfgfkE842W78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585305; c=relaxed/simple;
	bh=o8ybOedh32j23wSzSzyd4G1EPrINANiBMUEOtQ7303U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLT8lc7ZO1+TfQodniN+lOnc5sAhOPSUJsCoWssch828PggtqFTSs3p/W1KAfinR55jyFAT4mX54DDKDoPthIUDAK6zFXKjyYueVX0gaw7pooXGHkXXobtFHrwVB/MveNkRq4vcOyxPXdteWhuxj4j8JMJ5hMRValOk3woMHg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy0Ja1Gl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy0Ja1Gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61B01F0089B;
	Mon, 28 Sep 2026 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585303;
	bh=l+XUTYe6hm3kxfI8yuA6zaaLnG2sroAqD2TflRvrQMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wy0Ja1Gl5W57VgNDPaWrMrZoejn3vl/3qftaheyYiODpvqNaNAyn/ZXtL5SEFz40g
	 mjir+nu2FumbFHeOBwM4Z3mvJrN56x0y8T1TiiWU3/KEOqmkKXfeIgoT99g5Rzoe/S
	 Jsa/fLtMR0kJJ/WN9j8RbtBtVL7xvKqIM3hPQQgR629aqS7JH6tFF1mJPGM8ai1sBu
	 b6nw5Q7+e+qZYuod6NSBeMvS8lpl7y45XI9zx8jSupmSPE2l+EStLCMcxYTLF6Iewx
	 wUvi2v1wDWW8wBomt19BfInZ0Vlg6+19cD+Zv2ltxdwklnC2E43qCH8XFwPGwwubve
	 j3yZ01TwQNmgw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Mon, 28 Sep 2026 01:48:14 -0700
Message-ID: <20260928084816.5575-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928084816.5575-1-sj@kernel.org>
References: <20260928084816.5575-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

damos_goal_tune_esz_bp_temporal() converts the scheme's size quota
into basis points with "quota->esz_bp = quota->sz * 10000", both
unsigned long, and damos_set_effective_quota() divides the result
back by 10000.  quotas/bytes is unbounded; bytes_store() hands it to
kstrtoul() as is.

On 32-bit the product wraps for any size quota above ULONG_MAX /
10000, that is 429496 bytes.  A wrapped product below 10000 divides
to a zero effective quota: 429497 gives 0.  damos_quota_is_full() is
then true on the first test of every charge window.  Other wrapped
values are wrong without being zero: 500000 gives 70503.

Triggering this needs a scheme with a quota goal, the temporal goal
tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
32-bit, 1844674407370955 on 64-bit.  The scheme then makes no
progress for as long as the goal is unachieved, which is easy to
notice, and writing a smaller size quota restores it.  Nothing is
corrupted and nothing leaks.  This is unlikely to be hit on a tested
setup.

addr_unit does not cover this.  It only scales the numbers a paddr
context writes to quotas/bytes, so a large enough scaled value wraps
just the same, and vaddr and fvaddr contexts take raw byte values.

Bound the multiply.

Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e375f4445fd..60e4233ed23c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3291,7 +3291,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
 
 	if (score >= 10000)
 		quota->esz_bp = 0;
-	else if (quota->sz)
+	else if (quota->sz && quota->sz <= ULONG_MAX / 10000)
 		quota->esz_bp = quota->sz * 10000;
 	else
 		quota->esz_bp = ULONG_MAX;
-- 
2.47.3
