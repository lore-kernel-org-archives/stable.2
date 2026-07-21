Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65306386571
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660353; cv=none; b=Rrtex8A7y6O/2xegC4v1egQc6XRj38UjrJzy60e4tRNBHacmsa2aNNUoPee4L0R7a0t2ErDnBkbY9g57a26XocAPy218V5Ps2tH4Ca+UR9FZ2RE6vCGfIrnWFCtCbNzgnLMzHybLodwKNJ9WblDby5GrBo13EdEdDQ7tkaj2lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660353; c=relaxed/simple;
	bh=AyX2CXBwN9Y6JiFfYOlXd7kzzSM1hkohZMw+yLO6XEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/ULKxU55FF9AtOUlPRR3tamEDeVyOlymkmd46Hp190pGi/9esNW0Q3ljNdWfuC0902wsjUWQ+OFPCJkPM7x5bheV+me77XpWOyMN4yb+SnRCssXzlZf6VmBV3TFlzrZYSqG7cne62okhTjXGLsdlgD8cwPBaWiHEHdvDHbFavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+Rg7SeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+Rg7SeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810501F00A3F;
	Tue, 21 Jul 2026 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660351;
	bh=qDQnLuNKKHj2/JYQWQGsvti1i7IBHRPdBp0ViYCBM3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J+Rg7SeVLUnJAl37QfGyYO8m9GPsm2PkLemTBeqRS344975q75++hlczv+fOfcbyQ
	 HPNvxsPOyJBXSc8CltUUKudwr7OjeIGfP/99TQXqLYqh46d28q88TJxWtcpbAlrnYy
	 eDhQ5sSZyQ8ZvCxTb9rIQ0gXyMLe7hJn7nYyWq1YbC9h7IXnyMEWilzkEKG/V2w+Wt
	 kW28F2aear9qzWkre9iZw9N8tucJ5Bfp+LubEjXhMj/Klrnwe1HQD8ki3D3kNHh1pS
	 Fg1q2jHSsWwgWTUyw43WnjL27lJ56D1qHlyZSTMFC6/UN9ZWoiVX5vh6Z1Yf7pjGDE
	 ZgeYKAQ1dBq+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Alba Vives <sebasjosue84@gmail.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue, 21 Jul 2026 14:59:09 -0400
Message-ID: <20260721185909.397655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071619-cannot-evaluate-f3ca@gregkh>
References: <2026071619-cannot-evaluate-f3ca@gregkh>
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

