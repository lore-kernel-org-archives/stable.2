Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B746D2C1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662569; cv=none; b=E5kJ5LvidvG1ACgKKL2/Gb8zQLJCXjdgKFuIb+hORdMzyvbt3ZNZhXZ+2U4QHKDOtuNzEdGWyD+V9ZxBlFGAR7bSCIkbEs9EZ6mhEC22s5RmAWEnfVicFeNm87rPRzq72QBNn1eqFiCyoC54pVpKCSh785akeuEi6N/5KlE+9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662569; c=relaxed/simple;
	bh=AyX2CXBwN9Y6JiFfYOlXd7kzzSM1hkohZMw+yLO6XEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYmSjKqeQhhzWOrr4Om0brFqcFlxUyQdAm/vlxUBeNykVeZsduK4hKZM0AwLbMKk+dkRUBunRjLksR+YZWUxkfXCZNUbDUY1MkdBJBlaahGCjeoN5ANGoCT+VSobssTI87fPeZLSxwSPOwnUjBCMaKe1Vl/UUZ3n/Z71SxnzrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWvHSwFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWvHSwFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F541F00A3A;
	Tue, 21 Jul 2026 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662568;
	bh=qDQnLuNKKHj2/JYQWQGsvti1i7IBHRPdBp0ViYCBM3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWvHSwFMmPobLx6+IjDBq65uhyD8+hjDu9APwAIF8QMR3ffZq6itVuTaQXSQKZs2Q
	 mWmLiqokINWzp41KTD84ZlFdHvw8p5rzQ0CfiSMr8NNl/eDe6HNuPxT2fP26l0xmEU
	 8Bpr9QuZWCu9R78xQBdF/7fnuU3F52TlqK4aXSEf6r2ER08ZGhy5kPEXhJR7Sn/tLY
	 1c3wZi1qNxOMbdMtjwHwXGjA+bCb6Rvh5R9rDgyQ0ALOIkm8Yfy2u6Px5oXws7qSYN
	 0BG5hyVugfIpQ0jQkWWCfwDil5ZYyDbnPPOuKsu4/ujHg4yEO+RekNWip7Hh9kpCur
	 udl706A7+JIUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Alba Vives <sebasjosue84@gmail.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue, 21 Jul 2026 15:36:06 -0400
Message-ID: <20260721193606.410353-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071619-credible-manila-618f@gregkh>
References: <2026071619-credible-manila-618f@gregkh>
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

