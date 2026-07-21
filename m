Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD443C7DD
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678315; cv=none; b=sdNpz1Itzsjl5OZyxQ+HaMZVfTQ2ow0zkZ6vD0SmNnRKfpq6m5YsV6d/JiV7ZdpTwcWUvqjQkd9mmZURrav+lmNINuWVEQjs4oMsnIAb0Y0lP11zWM9apiT+Ev+I9EFqpSZgd0KwT4vV0LLMUA6km6sbKP5VSXolug1HUyyEApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678315; c=relaxed/simple;
	bh=/SB10XwRoVzaJzPA5veraaulAskH9QW6xOE9PqOlWZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+lt474xrbtzKvCAZKbUajVlsatPVrK06Tj7AnWfNpTTc0nMQvgMXFfOaF+uA33Oo65esdKqkcJFhotuVN/ky+m8st35lpnHRiGsc6tu5ZaVA2KzxR7WLsR7h5lhyD7h3euISoah1R5P33CQnPZjDQIePx2LZ8vd6tSV+UzLwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UINfonl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UINfonl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4795E1F000E9;
	Tue, 21 Jul 2026 23:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678313;
	bh=cd686CzUgRxiJy6GlcHXkOb4NEVKj7JToHXmlx5wcDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UINfonl++L4WB+NeJQK5jYHts5IfCRhbfV6sFeKiA7MqS23/sCQouKrFE43/oYb+R
	 o9+WS9GDfDstNqvDK3s0Ab9ULxq4Ee1fPD58NVm78vDNLYQq2wsMki2GsET1NIgoCp
	 vB6q6coS6TTgwGm0rkrQCPxjSOAKPw/+pKzhiT02EhokLfDPrPMfkXJaKb8uV59OIa
	 YttZi1r/yoBtWffuIMsGDgi/39sqTkahQc06ge7xaFMj/jyySty8Vs+p8Nshh4iESt
	 b3SaEhEAqmTNNfhhSvMh25hnv16rT6u/iaz9dmlK2BSdSlhLs9L73eXN/hcs3s6TPU
	 bK3o2ku7l2OqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Alba Vives <sebasjosue84@gmail.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue, 21 Jul 2026 19:58:31 -0400
Message-ID: <20260721235831.523583-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071620-thieving-ferret-56cb@gregkh>
References: <2026071620-thieving-ferret-56cb@gregkh>
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
index 753cda4b256838..b85e0624ab8f95 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -707,6 +707,9 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
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

