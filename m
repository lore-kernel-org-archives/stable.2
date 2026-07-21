Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC14248DC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663319; cv=none; b=I1dCx8WiDTc4S/NSTZpfP4PdaLdSU4XyyYy7Xw7Zup++IqXmQEgQ1WyUBXpJXe8mMBV+yXe3AtEptF/cEfAe7K+ewx71pdYVPMW/4KZmZW1itIuoQa296ZE3kTSdM32JG1tE3Y7BHTP7q7s6Fk4jvght1ZrXBksrwwjGbIpUyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663319; c=relaxed/simple;
	bh=AyX2CXBwN9Y6JiFfYOlXd7kzzSM1hkohZMw+yLO6XEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBi5pJh3o7mm7RRwuddWaG7y2kiMEgSn47VzGeBE4D9ktE86PT/yPu5zc9TZEJ10D0zcrfBkLloe9ZZAPU1GLH73B/X7Js76fpSAGMQFmzvzIvzhAsvRzokBxdE/1oesBwqbuS/9KgwatGBzkuU1MtoMkXJOCdlvJTbfBgHf4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gworHBeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gworHBeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69931F000E9;
	Tue, 21 Jul 2026 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663318;
	bh=qDQnLuNKKHj2/JYQWQGsvti1i7IBHRPdBp0ViYCBM3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gworHBehi63OrIHq0GXBavokFDgE20xjFA/fxkgFC/KvFbVcb/iLb5P+bVzWAsR3G
	 MjLn2a2VWTxvA4eTgyeS49xxMMkljLAIIDWYuCww4MPbJOn7XYtzKIKWgewTWbYlyG
	 SOrDPdeqY3DVWD3TtU9+JP+xZc1hLUf1eZLqytWmi2AG4y5KQS4HNxviJRP/SDJcsj
	 bFicns/jYtzP7X1h5BP1UvZcbRyKyuD2oS7AcL1Z/HVV61GXidKQogItjqAldGTaH8
	 Oip0TLudbjjBRo51xyMWyr4m4S2vRgSmbqWXiCL6afoN5zRszBXWWV4vDBaUYYZnJe
	 vRDlhgck4Nlhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Alba Vives <sebasjosue84@gmail.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue, 21 Jul 2026 15:48:35 -0400
Message-ID: <20260721194835.416843-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071620-drained-crate-54fa@gregkh>
References: <2026071620-drained-crate-54fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Alba Vives <sebasjosue84@gmail.com>

[ Upstream commit fc3b071a7c8dc0f5d56defddf6e6fd5aaa3e1e27 ]

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Fixes: fa8dda1edef9 ("fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20260518190742.61426-3-sebasjosue84@gmail.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8d8..dd4107ffa7158c 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -720,6 +720,9 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(pdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
-- 
2.53.0

