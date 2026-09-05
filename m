Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357549EC6E
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612435; cv=none; b=R1d6W95nUBPV1y9oNsLlFmsu3SdKkwuW/6Ui2TVqchMEx91jH/KcPP/ID1AQp/LrtAQF4sILrYHZunHcdQEQboOkSDpnusAwKCbzpFVAHzZPjp04g6zdGelC9l2W1FwDNoli7/CNsITmwlnFI/4avoXfH0Ga0yg1yemjUBg4fLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612435; c=relaxed/simple;
	bh=HyoJEb4h13ThEffr3wFJxPnbY3zePrqVNCcnR3fUkBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3M2hA4qFYfQ/yB7r2DPZBtd5tOo1RNRtwhu3ZythkcMtYWkHGC1w1ceHwGdPnCnLkcF2JGrIDEx06vSm8IYhJ0zCxbGvvYjC7M1qpTwHQJ9i1p68f9vFwl+1MAXT1w9zr7kKLkU8dl+bmlCFcBzLm36sJF9hC5vLdJtkEiaMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X17bLVH7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X17bLVH7"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39b52169dacso283a91.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788612434; x=1789217234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ziQh4+EYTP4FJ/w1XHqXZYM290fo3MHX7d8c+O4yS34=;
        b=X17bLVH7WVrqODMy+02A+TUtTwt2J2Bo+uqELrP3nNUbkV73PLYnrnwYGroRsXW9S0
         ms+sYNruxZcapn0tjYm7CppdMGMFavJ8ZCOSeMVx4fbP60+sf9vXnvdx5aZsH0k4rQTx
         qMQSn/wb/e9BXVCIHnhOq0kN+3B5UZj5Ei4vvyHqQhOubo53g3mrGYnfd8pi1TPq98Ez
         3dh2TSr7LQufCDqthExLQINWzlivFzJINcd6Ig4Uz6fnF/fmUWyiofN80dLRvx4WXm+q
         cykNgB6cQQwkceQYG3al/WhJRHrdTq/RcNvTS/O9GJ307gHiTRl0+ypKJxjy5NhyekK/
         56Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788612434; x=1789217234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziQh4+EYTP4FJ/w1XHqXZYM290fo3MHX7d8c+O4yS34=;
        b=KK3ChPa99lzStxuCx1Aus6b00ingEH8VNKMFN8WhrZavNfd/v+VL1H4j3AH4ChBYQ/
         xD0IB2dttLvrIQsPQF848wM/KLY+l4yg85AFToO6AeYaK1a3+vrg5jC0m53AD7FjdNio
         UZlNvy3l4LEYgKVWxAM13/eUmjxoi9FBm+2XcxDmMwwawFUTWn0EdktkltwX9mveYYL6
         RH/i1ruz7YEiFfSo3iSfzljUhg1bXJDeBnUopyI+sVvWbtRe4D9daJhH+7ikECgGDWOT
         u37sjXpxuIyDJ7hrjCk6pfgd4alx7DZQg+JBwYSWmd73jOrMY+lxE1qzNeSnzPFmjE7g
         3XFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCT2FO+WlDEaLM9kLS7wDTgWzEEeGG1xci3LOG3DhMul3U3RioF00n5miUqfXSCDHDe5lxGEU=@vger.kernel.org
X-Gm-Message-State: AFuF++nZq3ka9LJOxODvOhQH72Al9BRZd+ErBvsj7c5uU0j2IJhnV0dD
	12oYoV5LouLZGFNoqTaEB7TKYZg05qeHVHM10dY1II9TfAhacLaXUoo3
X-Gm-Gg: AYBFou1FEeG5JrQPPiBuo22ubWH53wZgdgDQhUU8WH9jdyGBfa1sVw0XK5u+in/6llE
	h3Dmfw1per0cRT3f4Zv451CX4dkIE6OEa2qgJlcKuWob1U1ON+7vR8n+hc9px6pYSEqV4XYvaKd
	IjD8OnMdpQFz9WsOTHcn+AxmGNTR7zFyOoqezSzTm3Xx8sAMYBYrI3rMshy2ht4XsD1BY/gTdBu
	eRKn/sWwSTfV541isSgzM3QHAcSoJEmBbsYQjbAH57kJkDr/uYCsrYHgyF6de2v8IEY68gNcwI8
	Cp9VyOOO40z0iP8kjgxMLVCsf+2qz5CsUQmRSu1VhfgpTy4dPk1oZEGvCLEg5uCUD8w4eRSe/bk
	69v7EEHdvtcp01lWjxmDO7onVeaqxVYIYRilEQjVKnTXgn9aWHeJSxiAHOeoLlvoulaCcUX5TZu
	4KnFwEYB1Yz0ocNJ3ngoJAkQ7E0bXkIXlE93XgjC1RvwIPzbNdbdbpzBwNyDene37UmA==
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr18020789a91.23.1788612433720;
        Sat, 05 Sep 2026 05:47:13 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([115.164.90.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm9929306a91.4.2026.09.05.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:47:12 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/damon/core: allow esz to be set to zero
Date: Sat,  5 Sep 2026 20:44:58 +0800
Message-ID: <20260905124706.3398-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the esz
becomes zero.  However, damos_set_effective_quota() clamps the esz to
min_region_sz when quota->ms is set.

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which state that if the goal has
already been [over-]achieved, the quota will be set to zero.

Fix this by set quota (esz) as minimum as possible.

Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Cc: <stable@vger.kernel.org> # v7.1.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v2:
- v2: https://lore.kernel.org/damon/20260902082050.19566-1-aethernet65535@gmail.com
- Changed implementation, more general implementation provided by SJ. [1]

[1] https://lore.kernel.org/damon/20260902150301.88535-1-sj@kernel.org

Changes from v1:
- v1: https://lore.kernel.org/damon/20260901105951.106246-1-aethernet65535@gmail.com
- Changed implementation.  The initial solution skipped the
  min_region_sz clamping when esz was already zero.  However, this would
  revert the fix from commit 8bbde987c2b8 and cause a regression.  This
  revision fixes the issue by adding a specific check for a zero esz_bp.
- Changed patch title, original title: fix quota could not be set to
  zero

---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..2b294fb46648 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3091,6 +3091,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
+	unsigned long esz_time;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -3111,8 +3112,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 					1000000, quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
-		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_region_sz, esz);
+		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
+		esz = min(esz_time, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
-- 
2.55.0

