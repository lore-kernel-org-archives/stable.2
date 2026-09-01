Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74787431E4A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260385; cv=none; b=FdtOII2NUMJjh3TD1B+EsJrsCCoHXaE/XDY/DfT65HS4ergRMjpExTKfShKS6lHHO7E8XcuPp8ujwBt2YTbJgoICxaZIiS8UJwwtt9b7DUA/M3/dyT43pYx+V+fpL08tTEh7hdOGTfPg368afn2L5wapPibaFlyBXFWn7JD20ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260385; c=relaxed/simple;
	bh=v3cXm9aO3Rd7JzKEU3sl/gy92NwMmpNDErCtcvlmbAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sq2pbWza2NOz2MRpCPDF6+QylUEceyX2VUg2Y409oveLafte6w1fmxMfMeaMaLOx4MeAgK3MocSP2qWA5CMQHrInQdeQf+Y3GZj5zqD9Jlhy0DSUkUUCfNIPUQ6pGF+GYDa9E2gT83zr6B0169+ZAoCGU2BgLh3leF4cFTmEr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m57ZV8qQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m57ZV8qQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39647184c73so889905a91.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788260384; x=1788865184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5kRAIEtptDuoDIWPjplgkKnNy7su8uVe41K8WELHNS0=;
        b=m57ZV8qQDJIlHzUXmd3vBOJibhmFwKeJSIoo7Oa4dKKPwLm390IFsJVzMn9aRv3zc2
         EKCoeqxmEazGOLRoxl/t4QZvBWzMusFpwUI/cfOAaaCU5pIHjoX1nVCxDPqGKwVLUIsY
         4YHvDk7EstsqXsXUjRRj7jdYAKe/AR39GXGeachC+OZqzd6eeT7mBsQMUVZhcMAjlZm2
         EBvQTWUp80Mj/aHkcYuaUjwfDATjk9upC7zFvu37BT2VA5oecEz4+/L25SY5UlUAbfQ7
         0y/HHuEHW7DIXBmSE0W+OjD0WO8+CKlg6m1RnAG5o/8obZjdYrCuMFtBwBih9kkNL+qY
         p3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788260384; x=1788865184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5kRAIEtptDuoDIWPjplgkKnNy7su8uVe41K8WELHNS0=;
        b=NL6bowEo2wcD20k5RmcethhRZBZcpi09BV24W7fJMQrjlpdrNiWBrl/nKbha1pnLFr
         4VAVA+7BkUA8DnarLi+pXGnxbVtCuOW9Gz9Oo15+W+BXfw7WBPOTYAqZtKIgN9xGpAGU
         A6HShhFgy/KCf42HVth+oX8zxDQKK6U1fuCbBHCNfuwFQPUX6wtzPvjLPdivlcjBCgO5
         gZb2krDYSrrmQy3mSm2iy8+5XwExl0hjBaW+YDF4LTiL1pK2EOw2ZeFEc+nRN6JcOxW1
         eQj/S5ucsNfDzNWwZf5rWfr7YcS/APrOrj6+eGU7sD2q5JhZyAkLVOGB+HntEIE43KSO
         qpmA==
X-Forwarded-Encrypted: i=1; AKwUvBx0PBW3onupadZ6kWYKPpqOJDk7lm/qvcFBO7dhB1FPBRIkRMhgWgdauYeqZ87rw0Dfzn2mhtw=@vger.kernel.org
X-Gm-Message-State: AFuF++m8vePSG6CwwRmKYPBo+Hjrmwxx5EYDH7Ej7cpLCjHJv1NIFLiB
	nFNm72vaTqycNyGSx6nIurmwDjpIkfZWu6iZy0hbZ9xvtvAG+SEzrauu
X-Gm-Gg: AYBFou075M2p9AqvMcr7qirkyzaAwRSR+I5ijE0N5RxkwoQlq49xq7ci36AALDap02m
	ib+6gqQhHhNxeFZI41M/0cXtbky3WfNoeUsbwrQKoUBqRbHsYFd+0b//a4QDJdrCLZeOGeKO+uD
	M7lDQhmrJhMZJggXtqezOgP2K14IjdDHNdYDNNZBLtBl6Ml1kp+z6yxq8A2apXK3b42OKQOCPT7
	M3KI8j3TXsw8TVxKkX08iZi74HioRizOUHcW3HjGAaJxzT4vDSHcY65yl7SS7Rm6NW+DFfOzITq
	tkFTnrZDI/F18rlTe9/8D8KJaJJ1HuhaFupNk4lGs+liaMT63wpzXBa/EshYVk515p7sha4FahD
	T5boFO4W5N8aUQRvQJ8NVs1oEg2M+iK376QU/uRxoPCO4NiyYeuIXh7FCSEBk0XF8J+qn6XEbdv
	Y9c3CSenuXrC/Bo28nJELGSxdtP3JSKkidyqYAz34zER6zxLci2HPwco3tm3lIzGOn
X-Received: by 2002:a17:90b:4a01:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-3990f772f5emr3422761a91.4.1788260383779;
        Tue, 01 Sep 2026 03:59:43 -0700 (PDT)
Received: from celestia ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d499811sm6303184a91.10.2026.09.01.03.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:59:43 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: fix quota could not be set to zero
Date: Tue,  1 Sep 2026 18:59:51 +0800
Message-ID: <20260901105951.106246-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the effective
quota becomes error.  However, damos_set_effective_quota()
unconditionally clamps the quota to min_region_sz, preventing the quota
from ever reaching zero.

Fix this by skip the min_region_sz clamping when esz is already zero so
that the temporal tuner's intent is respected.

Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Cc: <stable@vger.kernel.org> # v7.1.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53cf32f1d515..0258769b8727 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3114,7 +3114,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_region_sz, esz);
+		if (esz)
+			esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
-- 
2.55.0

