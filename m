Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EC46C4BC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659751; cv=none; b=eYxU4hK/wL3JJitr30SHYR15/ZOciP94d9TStY2i9pNU/5HoqEuxyYs7vBBwlg3R+pLIdh8IB9ewONd4XjQZjYfpR4R9kXtcpjqKC1uG5UwDsMoG+e3hC08YtACOY+9eUj05WNttKBADBkUp7GSxtUsc7H5CAoy2kVB/ZqFw5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659751; c=relaxed/simple;
	bh=v22MGEjiNy9gkJNYAgKDzSf85drG2W0vAn9Ca+TDBqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuYmTw2cuyS1BdbJtI6RvzyxWx95uRUQg6OWDzEs0JObVm3IWKcfCAH/1rZ6PWPE9yG5Ry6ZfCz+RiEc91Yx64On8DXlamuqZms4ACtXxjsLuUurcFeoFrUyIlyuXfK5l7WPeMJWtxtaxxSKNMWlDNaE6Cx+VpeVvdrOWg6xavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSqiKbWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSqiKbWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1C41F000E9;
	Tue, 21 Jul 2026 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659748;
	bh=uReOU+YViBbLxmH4h5CdafqcWcVBHQWtVzHPSSm/oLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aSqiKbWKeDpPGpXmA6DNu4GhlGv59Z5MzqRttO4+iYZa7zhq82maw4jVmnCu7uPhz
	 4QqKZsPuE80dB9ePbis9rCl175msjCxzJXDEuMB3cqHcrpYENFjgGjqbikx1e9Ow8E
	 lzvF6erErcd3a4maB09yxpdZqPI7tbcUNUBXuwEXs1jio/BjacvAgSupXAkUBmGkPt
	 sGPsPpxBzEHn0FOT+ifbhdr/afyaR/6vFkOHcmK2V9mHR9+buauvURzHyS58QINMRp
	 Qd4hJMCrFRFBVVsoGP8LKYezOjNTpbXh0PdWPP+pLRJuxyzmcESZ/iNGUvco0DqaBF
	 RIT06FCzju+IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Alba Vives <sebasjosue84@gmail.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue, 21 Jul 2026 14:49:06 -0400
Message-ID: <20260721184906.383124-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071619-replay-composite-2348@gregkh>
References: <2026071619-replay-composite-2348@gregkh>
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
index 6b97c073849ea9..89e922d9f6d583 100644
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

