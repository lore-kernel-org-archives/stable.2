Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541B377EA1
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570782; cv=none; b=BhKMf4PfdftyVO5+wdkSHleyF6ZDuJC4XjCdlqoDoYoqK5OwJWJPoe+DnnDcwcg3JY+M9kgVjCGx0G96QGPvPwgb+XLRIMC28tpnwdb9enZynP9mmw01zT7dDH0MjRachFkKzx/vKI5YyVzHiNqh37YhH6L0XV8C5ibTHXGEyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570782; c=relaxed/simple;
	bh=ps62Gf7Mv3sXmQAAjGyDFvVeL9B5x+Y9bRGuEy8RPng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBaXq1k3EorPjVXK6NDweQSCb2SSD8Cfj/qTZcM9VsB3LgKHKzooUY3Yq4Ey3Ku8sR67ACaCtoMBLdpyOMItA4tF84UIZiBqmeiH2RyYWA+2HLHjWFsHTF1nIV1v2iVTYuGLcy8iebtIbLYHLxMZxDrnL/Ty0VJugX8SX5M9vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWK9AmOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWK9AmOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCA31F00A3D;
	Sat,  5 Sep 2026 01:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570781;
	bh=6th10HybpKsJg4sKWII+uw8HSlJ1fZZVjvF4PXBecbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWK9AmOroQZwWx4urNFsCTp1GRt0vlvcM8r/KKPQ/inRPWxYxiaebEK0Ex6M+SfUt
	 0bZwKA/qmBtqJ8H9RoJQSwzqpUOsuQ+hZdGPWOEiGR64tyhiS5G+S24nJNO/Z5i4eZ
	 CoVNI9zG5jijObA6ENEXg7mbe0WFmfLJKAjNQ305ddxY1XxyE2TWt80ma98LtU8nUw
	 lvyJnIEMIjh/XdC60/hXTN0wTslkYu9JFhNgSgRyP2ba3RMnZQ6Rqeu5qKLZd5OzA3
	 Q5wxUd57+UVksBbA6aMjNV3CpFKdsznjuuvrmIWhTpKeDitERjsYdXV9fu29vY9r3R
	 3gsVDTYgdVReA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuwen Chen <ywen.chen@foxmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] zram: fix the issue that the write - back limits might overflow
Date: Fri,  4 Sep 2026 21:12:55 -0400
Message-ID: <20260905011257.1770985-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905011257.1770985-1-sashal@kernel.org>
References: <2026090323-gumminess-earthy-c60d@gregkh>
 <20260905011257.1770985-1-sashal@kernel.org>
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
index 8e99f453371e3..64a1136447cf5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -412,6 +412,16 @@ static ssize_t writeback_limit_store(struct device *dev,
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
 	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
-- 
2.53.0

