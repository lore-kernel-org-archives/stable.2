Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161587;
	b=jUgUyjRertlINTBDBQf5iokab5ZwaAA54EAHXY0DRE9iv3fAuJFu6GIdtKcUSWB86lhk
	 hOO8UAGqT7hY9bfBvRijDPhptIrGjDRhNCVM/dqN+K4Aau6mNJgakpRioZct555x6SmcB
	 RfjetVK3tV93rIvd//YVfbKLlM+9v4Kfq+oHivE0XtzR+aoiSKHU7Hv+pWCuGKDrCL6op
	 LnByylwgAI8ib9+GWNk2UzQtroTGTAPiBoQDHs5hPaxjWLWHipMxSCRfxbTWuhXGzg4xs
	 bWXpYoFDDcNBqbarDBaG5QcS9qXzArGwAHe4ftEl3Dki29/63RzYNodkvzRBpVU8LoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BHxSttUyt/DDMdmQXBY+0M0nVJfrKzZZx/1K6D8VwE8=;
	b=ulw5WZFBe1NTUP0aFBnEhTbwYfD+SpPWcIai3gr4G+K2sHwxbG9u3y35itEhbDzb5PnC
	 yqQHzraHUicNK7ZGIiEIh1oFmJCAfDHKdbGGsqGXxtdKwcb7In7S/ZwZuvMe6gXE9EGW0
	 44K91dgaegGhvcgMZkdaU1TagTwhEMaR2ohrJlG3rRuJgNf5uUKTp9SoebZLbzO+apAe6
	 i4oNhjxpLDhy271d6+mxbKCNyxlqjNb95nLI2TesMmaSkjNoN/9eyMTgC3SKIIlhDuD4x
	 k50tFOmkTHRm6TdORAf49hBUV07dnI09AE4GykxVrn/gjhQ3Ucn1S01iSWtc5kDbb+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF3W7wWI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6FE606A325;
	Wed, 28 Oct 2026 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF3W7wWI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FF11F01829;
	Wed, 28 Oct 2026 04:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161587;
	bh=BHxSttUyt/DDMdmQXBY+0M0nVJfrKzZZx/1K6D8VwE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LF3W7wWId59jcmTNAK6MHACa7HHFiCTxZWoKuFxMKJ57qczc2VX4NaCDXWjgF93q5
	 cmAhviR3zb6BgwfA4V4H9AQ6zOh0ffWAWXXFGJTtpPndmKaa6zbIcoqiLMbDoEDIeU
	 n8XJ2FcfuvZrbx0etfiBK1Ozvzgqbtjz2HDdcEMAr6qTWHkdxWtsuw+lsJ8D9fffvl
	 dWKfSXGtJiNiuGgMWyujnFtS7aLDDghC6PIhksE+wol6GmLPToCmwxFGk8F8rQ8xRQ
	 NFGqnava9OpDWqAdTllsAG5ctMPC1QZDzc84ZGgcS35Z3My6AzGLvyR/ip1tZgnYSw
	 AT8bL+V4OKdqQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.12.y 2/2] mm/damon/sysfs: put target pids for apply_inputs() failure
Date: Tue, 27 Oct 2026 21:26:15 -0700
Message-ID: <20261028042617.165657-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028042617.165657-1-sj@kernel.org>
References: <20261028042617.165657-1-sj@kernel.org>
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

damon_sysfs_build_ctx() invokes damon_sysfs_apply_inputs() for setting
damon_ctx object with user inputs.  If it is configured for virtual
address spaces monitoring, the setup also increases reference counts of
monitoring target pids.  If the setup is failed, damon_sysfs_build_ctx()
deallocates the damon_ctx object without decreasing the reference counts
of the pids.  If the failure happened after increasing reference counts
of pids, the pids can be leaked.

Fix the leaks by decreasing the pid reference counts before deallocating
the damon_ctx object.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260730040740.140836-1-sj@kernel.org

Fixes: 74bd8b7d2f8e ("mm/damon/sysfs: move targets setup code to a separated function")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 107a28557afe2..6ae35f55764d5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1486,6 +1486,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 
 	err = damon_sysfs_apply_inputs(ctx, sys_ctx);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return ERR_PTR(err);
 	}
-- 
2.47.3
