Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BE43CE4F
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907073; cv=none; b=Au7X4E10HlZIL8M0TA2MAo/+OsVow8nAT/Pj5uBkHz84Y42y1VIJVPyI4ThvWxObsHujwQieQmLPbIGbjRw4DMh8XhXgTqCuSnN8D7d5tQP+WsU9oNFlz1mtEN2Ypiuw35uUta9HvoemRNmDTUZEWrN4UQrPCFZn/dfTf2t2+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907073; c=relaxed/simple;
	bh=X9og+gkcKs3FqJesjCqjxPxucohjf/RASztug2OUqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcJSXUQWpDX52eOR8zjjcMSYWUXOd+EuiPQkZ6QaTNHobM+c6TxtId9wGfRcuUZjEroZB/j+bB8o/OnY4LLZo7w5ezL66kEYv5GiX1ZTMN3pJ7AElhePW51yyZnJcbMEg8W3/SmMzCTwcQxY1krtjwTaIxgoHViAz6Ilyq/1Kgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvv9xhdB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvv9xhdB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398c066106cso1693169a91.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907060; x=1790511860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ONHA4wMDILxcRZ+Lg+d1Nlct6hNZeNgcOdxBA0gn77s=;
        b=kvv9xhdBSn+K4HnJhB98/4alaFtUSKqDKoCdI5PO8XQPIs4o1wIyDSZtu2sy2KlSvM
         taTKtVLigaxWd4lALeCSo0uc6/Jn+BKA2MybQbvU1tLbYQexa+EMutIgPODL+RK3I/eK
         Onbm9IeJLdczIXm8em/cGP7BBTLGsZw4NdaY+ALlqAtl/risfK9X0c75HSlBYtNlJNFK
         8D8jCLI9jbIRCs3dSLrnrR06HipRT220n1Anu5xdI9X8xo6FX5asj6NOxxXG/6jYflwg
         EhbL0hHDOtiqnGZ7sUuenZnpr2CT74IgeNqPx3B++NirXZ7WOgTOllbOZKZRiZuDo7s1
         YCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907060; x=1790511860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ONHA4wMDILxcRZ+Lg+d1Nlct6hNZeNgcOdxBA0gn77s=;
        b=fPG0bja2pRrLFoa6b1Ngs0WtfJhmHHWSzguis5jeBFZvgWF13wsrLPADc48wS5ot0y
         Yr2P8KOM+AiRYkAMWiY/csGaTAXqKTdGPKjfCTq/D9rP1+wy0aSUfp2sYONf1o4QmpvR
         kRGzJt9TtLOO4OCapvMW/zx2tgIiIJ2fMl00cKcQRA+8QKo3GAdhxDwtAJ88NpK/1Ef+
         weOqv2u7IqVv542xEGFXwGd0gBumI6mHdW0dBs47d7UYQwCDN5XMzceJBCfRtT54fJw2
         ABDuhoU+IVcW1Q2SKFWK1sY9OXbVwBStHFiB7TBDmqu+Bpu69y6/S2U1F4K1SiFuHjz3
         YCXg==
X-Forwarded-Encrypted: i=1; AKwUvByoJRQpkmgSqZy2A0kh45jT6GPMA84S6D/8XcFR69qBgsd6S6TDK8l0dyUi7LCkHVO8zMI/zsw=@vger.kernel.org
X-Gm-Message-State: AFuF++n7atQvNSkHR1WXrTliYlZhWgK8td0x+V0nNdGAH6xpZ+J3AQkO
	C3hcZZJwdzKo+dRdkcfS50maXdGWqzlFeSHq60+YU9greFlzZDbPSs8AIqedgLY=
X-Gm-Gg: AYBFou1SeMt651To6a4W/HfBxq3iJBmJu6Fbl/yJC6+Ml5KirpElhxGZfPwwtFNibTg
	eqLSlCzFSRgR8oGoNBedJZsApnlPvJmPcOEBPxOZkQ/e22CBGRR+qRHDjV/4qZnHCRV+FzO30St
	wbdFu2k59CCeRQhAnJqysKYChtUhF7Jyqy6tM5uGuWXmVG6E580zHB5ZV/w/MBmNI4bPKlYq9wx
	yOtLFApGWD5hQunC4kockWuj8Q/j+rgb3+PfQBMKXxLbg/ciwVmRkFZ95JDkKURIeg+i1ACiZl9
	OTbupeMEf0t6yoJHwNjscZ8bkq3Pt4ejO/iztznMQ6oejvJja85aY3N8x7pu3r9V84JccZbgb6o
	uMttYfl7TKhLU1dDwXGxL/DusBsyutYtvJjAdW1ZRdiRAQd+HDcMvxgDq0gd27RYo4naHRsAfQ2
	9ZyIbvtj/uo93josGmiJ8DIdA4RPMuZZqrFaNy6VIUSb5sSEmFDTtZdiGw+HqeEFCny0yslYoGS
	Cuxbw4fAgRsGjOO+BSphidRbgc=
X-Received: by 2002:a17:90b:1dc7:b0:39e:6c68:1553 with SMTP id 98e67ed59e1d1-39e6c68331amr8421991a91.27.1789907059964;
        Sun, 20 Sep 2026 05:24:19 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm8753943a91.11.2026.09.20.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:19 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 21:24:10 +0900
Message-ID: <20260920122411.610213-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
References: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() converts the scheme's size quota
into basis points with "quota->esz_bp = quota->sz * 10000", both
unsigned long, and damos_set_effective_quota() divides the result
back by 10000.  quotas/bytes is unbounded; bytes_store() hands it to
kstrtoul() as is.

On 32-bit the product wraps for any size quota above ULONG_MAX /
10000, that is 429496 bytes.  It lands on exactly zero when the quota
is a multiple of 256 MiB, which includes the 1 GiB that
Documentation/admin-guide/mm/damon/usage.rst uses in its example, and
a zero effective quota makes damos_quota_is_full() true on the first
test of every charge window.  The scheme then applies nothing while
the goal is unachieved.  Other wrapped values are simply wrong, and
any product below 10000 divides to a zero effective quota too: 429497
gives 0, 500000 gives 70503.

Triggering this needs a scheme with a quota goal, the temporal goal
tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
32-bit, 1844674407370955 on 64-bit -- so it is unlikely to be hit on
a tested setup.  Nothing is corrupted and nothing leaks.  The scheme
makes no progress for as long as the goal is unachieved, which is
easy to notice, and writing a smaller size quota restores it.

addr_unit does not cover this.  It only scales the numbers a paddr
context writes to quotas/bytes, so a large enough scaled value wraps
just the same, and vaddr and fvaddr contexts take raw byte values.

Bound the multiply.  A size quota too large to convert now takes the
same ULONG_MAX branch as a scheme with no size quota, so the
effective quota becomes ULONG_MAX / 10000 instead of a wrapped value.

Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Measured on i386 under QEMU: one paddr context with a stat scheme, the
temporal goal tuner, and one unachieved user_input goal.  Each size is
written to quotas/bytes and quotas/effective_bytes is read back after
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

