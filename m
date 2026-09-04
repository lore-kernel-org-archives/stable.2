Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45525483BFE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553941; cv=none; b=TAiXciSHqZ0bjcfkGAnfrPUO6nXYxMbsSopmb2LFZubrTjcM2iZl+H9wEVDE2JF9IzbNNmKqoGBfipnbYr1qCZGtSym+eBmbur4hBRjda4kkAtbGbMly4PXQ6QAiTPazub1tsgd3+qSVLolQK9py6QZZ5HUxgu55e38hELqMbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553941; c=relaxed/simple;
	bh=nhFSZhtKZEO2Rz+ajvk3cQPm2xytjUdpIBE9U4fdF+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umHQvyMn3nQ5IxjE3gb51JIRT20NhrhfKxKCwfWALvJ2C+J8eLnPUpHkwViEPK0j/tvXjo++SWB1RZpDRy5pFV+bfOlWIDvLEUV4b417JYDlIiLNXuSkrs1gtBgEESwiD7lG3Ekkr8zDuj1JSbRNVcS8eZ5tmUd1tmiGViagO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfZBe/oe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfZBe/oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA7B1F00ACF;
	Fri,  4 Sep 2026 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553928;
	bh=jVLIsMywX1xX1DaZRPjE6Sf8AnTBqpHp3oh+AC4NY3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kfZBe/oeyYdnjpExUkTge82NY/GeaumnmG9kG2ZQxFNWFsZXFDlel4lsoyWxGgD+d
	 Z5YOxqyQvz/CxlUTESFQFltiQo5WFxvT0oGZOnU6icVtBBV/cs2p5eV63Qz46cbsVw
	 7tQAjeQcLgvKZkGEuWmk41up/8CAaNRRL8Vp5CWOTl3l0bxQuXAEjVQI9o1u6LGOtO
	 KpoFyNrJBL1B+Vx3BF5zclZ9Huv9sQA1ig0yOdMUKr3+scaLMV6tTIuBTtz+Ca0krr
	 qdor3+j6cKmxL5uFCRweX77pvzZ8OjxEat4GpAPOZIf+SGlK1FGJdTsY+uZHKoLkNv
	 Q6jn+IohVXqbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] zram: do not leak page on writeback_store error path
Date: Fri,  4 Sep 2026 16:32:02 -0400
Message-ID: <20260904203203.1546745-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203203.1546745-1-sashal@kernel.org>
References: <2026090305-dimly-backboned-037d@gregkh>
 <20260904203203.1546745-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit a6d2193b3ef53d5c5a2c56d397227f5e891f2df3 ]

Ensure the page used for local object data is freed on error out path.

Link: https://lkml.kernel.org/r/20250303022425.285971-19-senozhatsky@chromium.org
Fixes: 330edc2bc059 (zram: rework writeback target selection strategy)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 894913e2d35c ("zram: fix out-of-bounds access in writeback_store()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3b87e89a9a496..cf02efcbc47cc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -799,8 +799,9 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	__free_page(page);
+
 release_init_lock:
+	__free_page(page);
 	return ret;
 }
 
-- 
2.53.0

