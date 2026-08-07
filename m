Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00646D2C8;
	Fri,  7 Aug 2026 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090271; cv=none; b=kyTbBeso/sOPc7it7WtV++TNaXUs5bbJZMgGTA8ucoJZDW7NBdVb7jhxZNnu9e594Mkbj6laD4PGNE04hflhwIi9xsDZxIa0LiK1XT65GrOPz4J5dX3LSQJTD1u3XIGB76qMkFtIerHG1CesjJJHFugN6gbNkMAHbE4UpZvMzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090271; c=relaxed/simple;
	bh=jURQS4KhiRezpYm+L4Jm2lOk0iy04uqp673Uj51OgUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q5Jzp06w9ea6HW3cxX7IRypsewLAjS08DsSFHb+2LxKFs3ngmjC61RBEA21kwZHA2IMKeCA4lso4xjNJxTCI5VCvYIKn1lsuvW3rR/5+hMYM3GW97q+HvzaOZtG9ZhDft15+eOax/VA7ou3ZlRMDPqZpRHuDN6mvK1UUA4oXKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sNpCBQ7K; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sNpCBQ7K"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pjvM5JkEvbQU0SRFHfCRDVW50y3/HcS9gtSK2WMzm6c=;
	b=sNpCBQ7KNsE3uCfVmFap6d3NktPCwmJoKKJGZc8X90TukaHvHT7BfJ/W2nPOyFX01LNHs9
	8IbmiLIByTjBbM/q6ui2lp7I/PRnoefsO5wA6M6muCYnxRcaKqKkTk/pqnv1UgUVZSfVIf
	dE4oc7GKG5cYWQ0qveIi1vL7nhMh24Q=
From: Yi Cong <cong.yi@linux.dev>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth backup fields
Date: Fri,  7 Aug 2026 16:10:06 +0800
Message-Id: <20260807081006.240450-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

The .ch and .bw backup fields are swapped; .ch should store the channel
and .bw the bandwidth, matching all other chips.

Fixes: 0194a95cbe721a ("wifi: rtw89: 8851b: rfk: add DPK")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index c63f0e6364dad..71342461f2b30 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -1895,8 +1895,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u8 kidx = dpk->cur_idx[path];
 
 	dpk->bp[path][kidx].band = chan->band_type;
-	dpk->bp[path][kidx].ch = chan->band_width;
-	dpk->bp[path][kidx].bw = chan->channel;
+	dpk->bp[path][kidx].ch = chan->channel;
+	dpk->bp[path][kidx].bw = chan->band_width;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
-- 
2.25.1

