Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96D47126A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553960; cv=none; b=GYiBc66ejUYWsjxHStySMEtYsyLpuLttUADxTR+wiW36tP1ErTPd7sBMAQi41pSwSWgJA0bwiZQN0GynGelfvmFV3DhF+iDThohxD+H7cy+nu95oOCtqw4Hj+DD4CH7+zuSNchdCxLkBKXSngwajEJ370eQfAprW/2r/7cIKR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553960; c=relaxed/simple;
	bh=pFFhZOKx+NMIiXBu9N7zgAIkYctbhKt+oP7CP1hmLRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDCwMYcFdLGIVqQrjm4Gn17H1LowvUexCDHovOkVBPRpHDWGOnUAY2Er3ZS/vw1GDxAN+vUI+WOS0EeKki771gcut2QnEI8miZAEpELXTZqOWOzyq3dV65ok9ewNCh0WFCtPhL+XzYvmA6BTjXgMDpHbXBykUBTXSsrBcpCbsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVtSEpDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVtSEpDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6651F0155A;
	Fri,  4 Sep 2026 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553937;
	bh=aeKv02Z7kIOlNYI+m3tGIzZpzKsyXnxNiLyJ7ggENuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KVtSEpDuaC0FbWwwmRT4I5xrZ60hPlBbG5bYfuJmc2vDFyFhJ+XuNmbaI60vwBXGw
	 ACDFMpNHFbV9ty2ch79ImmgzLmsbXwU7nn58pZlRAbnUMvVINTIWFZbDEZ8/QyirSE
	 +SHWcvA06MLfe7bU9Djksndi50PCSdvCbDbQLWZOa8n5NJOV/zmmdD19nO3Zxx9Imp
	 4W9d/YgTXBtfVwubuy7ADRGDeAkB2K+kVeBlJfVgle1stnRolLubyx/x9LwGLab9H/
	 szW4H8ArXrbkuQv8MPUcYyNxG2qxODixixXKJ0x6k7gGq2zQUXgY3RjO7of4F7ZRER
	 C7FHkPY+wQ5gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuwen Chen <ywen.chen@foxmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] zram: fix the issue that the write - back limits might overflow
Date: Fri,  4 Sep 2026 16:32:10 -0400
Message-ID: <20260904203211.1547892-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203211.1547892-1-sashal@kernel.org>
References: <2026090323-dreamboat-stable-993d@gregkh>
 <20260904203211.1547892-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuwen Chen <ywen.chen@foxmail.com>

[ Upstream commit 04d31610a7221cca624646241b1f6b3edd6c99fd ]

When the page size exceeds 4KB, if bd_wb_limit is set to a value that is
not aligned with the page size, it will cause a numerical wrap-around
issue for bd_wb_limit.  For example, when the page size is set to 16KB and
bd_wb_limit is set to 3, after one write-back operation, the value of
bd_wb_limit will become -1.  More seriously, since bd_wb_limit is an
unsigned number, its value may become as large as 2^64 - 1.

The core reason for this problem is that the unit of bd_wb_limit is 4KB.
For example, when a write-back occurs on a system with a page size of
16KB, 4 needs to be subtracted from bd_wb_limit.  This operation takes
place in the zram_account_writeback_submit function.

This patch fixes the issue by limiting bd_wb_limit to be an integer
multiple of PAGE_SIZE / 4096.

Link: https://lkml.kernel.org/r/tencent_5936CFE72BAB2BA76887BB69DCC1B5E67C05@qq.com
Fixes: 1d69a3f8ae77 ("zram: idle writeback fixes and cleanup")
Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Richard Chang <richardycc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: dde75313eed0 ("zram: set default primary compressor in zram_destroy_comps()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 29c6ca1586630..2e26f40e70f34 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -544,6 +544,16 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
+	/*
+	 * When the page size is greater than 4KB, if bd_wb_limit is set to
+	 * a value that is not page - size aligned, it will cause value
+	 * wrapping. For example, when the page size is set to 16KB and
+	 * bd_wb_limit is set to 3, a single write - back operation will
+	 * cause bd_wb_limit to become -1. Even more terrifying is that
+	 * bd_wb_limit is an unsigned number.
+	 */
+	val = rounddown(val, PAGE_SIZE / 4096);
+
 	down_write(&zram->init_lock);
 	zram->bd_wb_limit = val;
 	up_write(&zram->init_lock);
-- 
2.53.0

