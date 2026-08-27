Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BD3A3830;
	Thu, 27 Aug 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819237; cv=none; b=gyhlWgJgTeeLMr6P4uqSZABcWTrL/fBmDVCrhbquTVZUxxp3ca5u/kHefplKIx6HBW6gPAE9i99gRHuHfee8lqyHmMkKFGgNUdYpNmFewClRAJjAclhoTp8c3dEduOweYXWDLW3Ft8nSYRtTIDpcSqJuqR5FgudM8hcr22/M+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819237; c=relaxed/simple;
	bh=lsZIkzEcjrmcIEtAu9HM+xpvR7gUTF5bSS8k7yfDvxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7XRosOFqpDBWBRaPNiZfIklJuGy8jG3YLxR36HWgJpDYXvxOCNl23+Wt2Hm/VQoP4Mnp1s/qXXGbE7lMMpJkrCK6YOh4LvFQwOZeuJEoxBx6MGWfsQlUMfhre/fYzKbQ2fMDn/z7V7mLA3OlL+dqtdSGKAo7dUoPv5KNH057pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mP1ZkGPg; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mP1ZkGPg"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b890ca46;
	Thu, 27 Aug 2026 16:27:00 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v5] mtd: spi-nor: core: Fix mutex leak in spi_nor_rww_start_exclusive()
Date: Thu, 27 Aug 2026 16:26:56 +0800
Message-Id: <20260827082656.2772784-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87tsoigz8x.fsf@bootlin.com>
References: <87tsoigz8x.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa042545fa603a1kunm50d5e1a85c8a5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx1MVk1LGRoaQhoYHx9OGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=mP1ZkGPgEVq7JP7GWZquTpOr+Vv6+NTWEyYXIVs0wUN3kw0fSZ9l9n5kMUQle+mb+DZYJ6b6BfNxTNe4KAsSItjPWZTyxlUUAmWWvYzhHpfdNV7wQsWX31bRrKzB3YDWIb+D9aAzwNBjpWoqO196wszGkWdsTirceZCDWX5/QkY=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0YHVsFg6BoIIn7D9s6VZmkuiKmYY6gmtcPRgsQPlfj8=;
	h=date:mime-version:subject:message-id:from;

spi_nor_rww_start_exclusive() is used as a wait_event_killable()
condition. When an RWW operation is already in progress, it returns
false while still holding nor->lock. The wait condition is then retried,
but spi_nor_rww_end_exclusive() needs the same lock to clear the RWW
state, so the wait can deadlock.

Use the same guard(mutex) pattern as the other RWW helpers so nor->lock
is released on both the busy and successful return paths.

Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v5:
- Drop the interrupted-wait cleanup patch because an equivalent fix is
  already pending upstream.
- Restore the focused guard(mutex) change for the exclusive RWW helper.
- Restore the original Fixes tag and keep the other RWW helpers unchanged.

Changes in v4:
- Add the interrupted-wait cleanup as a separate patch.
- Convert all RWW start helpers used as wait conditions to conditional
  scoped mutex guards.
- Update the subject and change the Fixes tag while reworking the patch.

Changes in v3:
- Use guard(mutex) in spi_nor_rww_start_exclusive() so the lock is
  released on both return paths.
- Update the subject to describe the guard-based fix.

Changes in v2:
- Explicitly unlock nor->lock before returning from the busy path.
- Clarify the lock leak and its effect on the matching end helper.

 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..8bc117b46e02 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1310,7 +1310,7 @@ static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
 {
 	struct spi_nor_rww *rww = &nor->rww;
 
-	mutex_lock(&nor->lock);
+	guard(mutex)(&nor->lock);
 
 	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
 		return false;
-- 
2.34.1
