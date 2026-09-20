Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050983B8939
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871497; cv=none; b=fTk4YEoWiUoYfkicTBOL/mfdAMip27iOBGuI0t++u5MSlfTmsctRlqWqWPdofUbOuuVjjcOLu8FP6Aw4pFonATe1/NMuC9Dd04L414OLUkNEF+zc4LbTOgo0uJLwxxYA6x0DdwiW4KyX0X8tqEoHL2pChmBdHQvH80SFhOLajAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871497; c=relaxed/simple;
	bh=4F6gEZ0alLRZ91hl5Uj02k/PBjBZ8DHOpMJkRT/0oVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwyT6NzRLHanKD7gBSUZ/kXyqu+hJd64H4+aPWNSVIL3P7YCpyU+ryVNBwi5mH6hlwBJ1bZHgI/JV+L/YO+KJ3LbKHqYYLDiuWXmzTYPVZM4youdeK323+ZEW9rKuAkgqigGDkPr62g2tUEtkOhQWKxdfHcyEhsBAEoLA8tPKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjZn7A8t; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjZn7A8t"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d20963so1240590b3a.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789871480; x=1790476280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDHeX2pbe5QJ4kKppVbv//QlUrFrGxWdWrRVc+dGwWM=;
        b=HjZn7A8tqyMARksbZ6NyfrlnjD8zAq1+bBDdemxjakEbnFz6tiddqECLdA9sHCMZEJ
         fLnHiCxpjYdyFM+IQ9H0viIn4pxv6VNC+wZI/eODAYRBEme0vG5XN0iD7x/s24ybZrma
         GvLdyK8MlOmLYpUhdsOXFpmSieQdAi5ztpoEPvJrbQ5HLOxyjdvuz6BB5Qtc65zbvRIO
         sopfBBtRlcxiSDTjcV833KGUzF7Y8bi3vqUp7GKpIejbAzusmhMazTU9IoyGlBDX1SCs
         fYNFt8da78t0KwxYS1vqQi1D5UoGKqBwAB+6vVx5anjRojB03ulhpbpmy200YccGjHsD
         oiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789871480; x=1790476280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDHeX2pbe5QJ4kKppVbv//QlUrFrGxWdWrRVc+dGwWM=;
        b=gyI3a9sHNc01n7m4bxd9FZQbr0SKMRxfxGZ8UpoLf9+T/UPG9COYrxAd4/wCLW+Ilf
         xjZlDInhSZyQiX16LyAzoJvJc6b6ygcVS8DWaTB6FJd6qqLeGiVUPGgF64SKKNy6x9XE
         G4oaT61hBPuji/gt5zCYlpztxNg2G3rUWrCAY54ud45gA6zJiKuXQT8AJapubU2pMouP
         7Fp9aPyGgy7J7ov2PsfRkukmYn+oy8rUzAZsGmClaEKhQg3e3hDsEoJThsS3I6Hu178w
         O9zsIWvUfKqt5SD7AWcnRlU0mC9TsllDbnyTzShXoKDNpRnKkjnMbs2QkgZR/Yt0thcG
         c2rQ==
X-Forwarded-Encrypted: i=1; AKwUvByrqdyvzX+9moJwbeKAd+hdQs8KMBDyXm3c0aReE1qotcwIqbmMbXeHHdQGXrRdk8wnXHqXBzk=@vger.kernel.org
X-Gm-Message-State: AFuF++m9zBlh7GLhuTnIRMMcO+bKkze1nBT7REhvVmQbLXyeOTIlU0EA
	4uETGH5FKnn7BVG5kJOjqhiv5OeQA9GDSqWj3bOWRS41dPbofriNBCQ=
X-Gm-Gg: AYBFou13bqIosqf9TuhCFh7Qfh8wr1qHzAq2/NPCfuZco3esTzp2N/dMGyBfDMTBDYz
	YCBObFT0FSnEZWOxzICKP1bknDkUucIf4ZBQXal0/z9uwdAS9Sh/tkAdNxmZ18U0+XqklRCTxJB
	kb4vxifmq1+GdE/Fr4whG0VW2U/W4Ur8xyIWBm1IQvfAyjEsARGNQCkpf5YlVaXGy3JLRMSDTV+
	tFqNh2yL3o3IMA/yhIp2tBU5A0SpWbV7+LiSoHr5LfsMjzEjPjLyEez4KkPRTTQhhyjUrKujJ4t
	4Q8tUrTqt8vNbCce6eWJG4AlbqAsvMTy0JV7+tQzEoDJ729pQQEktkMZ/RdnH00qbzVIq0QgY0N
	LRCh7GiswIl1k44GybsBYCoaRR5fft6NPsksDPtWFBGMuVuQWqmZ/05PEchFgsDrZkbaZ1YnTY6
	wegyai5ze+Vfni4aZMmIUH7nFpNywfSGaR/daW0p6SjW5huSnhMiP8USDichsj8r/sikL3DGXOe
	C7LpRwVxlLVkPmfjPXMlKAD+A==
X-Received: by 2002:a05:6a20:db90:b0:3da:1e2f:3be9 with SMTP id adf61e73a8af0-3dd8c49e92dmr13033406637.22.1789871479726;
        Sat, 19 Sep 2026 19:31:19 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:36d8:54a:e0bc:3e5e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aee03efsm1481341a12.24.2026.09.19.19.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:31:18 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 11:31:09 +0900
Message-ID: <20260920023111.2466265-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
basis points with "quota->esz_bp = quota->sz * 10000", both unsigned long,
and damos_set_effective_quota() divides the result back by 10000.
quotas/bytes is unbounded; bytes_store() hands it to kstrtoul() as is.

On 32-bit the product wraps for any size quota above ULONG_MAX / 10000,
that is 429496 bytes.  Documentation/admin-guide/mm/damon/usage.rst
instructs "echo $((1024*1024*1024)) > quotas/bytes", and 1 GiB * 10000 is
2500 * 2^32, so that documented value wraps to exactly zero; 256 MiB and
every multiple of it do the same.  quota->esz then becomes zero while the
goal is not achieved, the trailing "if (quota->sz && quota->sz < esz)" can
only lower esz further, and damos_quota_is_full() is true on the first test
of every charge window, so the scheme applies nothing and the goal is never
approached.  Other sizes are wrong without being zero: 500000 yields 70503.

While the addr_unit parameter effectively mitigates the overflow risk by
scaling down the values written to quotas/bytes, it does not fundamentally
solve the issue.  Theoretically, an overflow can still occur if the scaled
value is exceptionally large.  Furthermore, because addr_unit is exclusive
to the paddr operations set, vaddr and fvaddr contexts remain fully
exposed to this overflow since they take unscaled raw byte values.

The 64-bit boundary is reachable without any scaling: bytes_store() takes
whatever kstrtoul() parses, so a quotas/bytes above 1844674407370955 wraps
the multiply there too.

Bound the conversion, so a size quota it cannot represent falls to the
ULONG_MAX the function already writes for a scheme with no size quota.
Widening esz_bp instead would reach the consist tuner, which runs the same
field through damon_feed_loop_next_input(), unsigned long in and out.  On
32-bit a large size quota then behaves like no size quota rather than like
a dead scheme.

Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Measured on i386 under QEMU: one paddr context with a stat scheme, the
temporal goal tuner, and one unachieved user_input goal.  Each size is
written to quotas/bytes, the kdamond is started, and
quotas/effective_bytes is read back after
update_schemes_effective_quotas.

  quotas/bytes    effective_bytes    effective_bytes
                  before             after
  4096            4096               4096
  429496          429496             429496
  429497          0                  429496
  268435456       0                  429496
  1073741824      0                  429496
  500000          70503              429496
  4294967295      429495             429496
  0               429496             429496

Everything the conversion can hold is unchanged, and 429496 is what the
no-size-quota row already produced before the patch.

Patch 2 pins the same boundary at ULONG_MAX / 10000 and so runs on any
word size.  Without this patch it fails on x86_64:

  # damos_test_esz_goal_temporal: EXPECTATION FAILED at mm/damon/tests/core-kunit.h:1970
  Expected s->quota.esz == (~0UL) / 10000, but
      s->quota.esz == 0 (0x0)
  # damos_test_esz_goal_temporal: EXPECTATION FAILED at mm/damon/tests/core-kunit.h:1974
  Expected s->quota.esz == (~0UL) / 10000, but
      s->quota.esz == 1844674407370954 (0x68db8bac710ca)

 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2258b72da7a78..16d4145379a2b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3274,7 +3274,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
 
 	if (score >= 10000)
 		quota->esz_bp = 0;
-	else if (quota->sz)
+	else if (quota->sz && quota->sz <= ULONG_MAX / 10000)
 		quota->esz_bp = quota->sz * 10000;
 	else
 		quota->esz_bp = ULONG_MAX;
-- 
2.53.0

