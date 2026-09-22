Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF19477E4B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099766; cv=none; b=QIFFCPmCKxjIko5VWP1su6SGsm/4yNRR5VhY8rLnznf2D+prwcw1/QKUbcGQXJTpf4XtHQgibsQTSXzrUvzci1TS+sspDPNFQbNMhDuaL+e0R5kFtKpEt7UDw1LJWWhkatfQaz7CMHKXuJvDdEDHwgvIrNlr++NPY8ooGq1h5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099766; c=relaxed/simple;
	bh=PaF/EALxS3Sbz806kOztHbdgMQXUdGqf4RPM0ER0iWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI5A2nALUhLbTgpS0getHB0JNe1fczths2fx60X/ZwdwDZBFSqxtEMpZ3qlN4VlhWnrtqrR0HBNvYU3/eWJDaInlF45a+eoo4gpQOC0EyRSI0z9HWIds4300qjCzhtX1LiD2pf5bci4ayJ9H2VCwV21iR2JPxh32plBzCZcogNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCE0DYOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCE0DYOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1511F000FF;
	Tue, 22 Sep 2026 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099765;
	bh=sz4R8ypnGIg7v3GjOLhf06xUdjJbbOZL/plusNplutQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCE0DYOFwtuPcWDYI+4oVJjyJ4K79bCMG3Jorvvqquzh4nnKHr/A24e9+Jk6uyp5z
	 rVCn89NgDwUBxVl6FRNyCLYLiNaK0hdhZ6pj6S1asJ38CX6dlmyDdxxNLrXOzEYqmK
	 rA8zTuQZ6nxdwnyD/4UNGT73pDFPjk+OHfuSIMzEH2jshB4+o1Bwz52MOpgoSb4zm7
	 v+GcgFxunrwbJXWE6yikNNsFaV14h62NurGIo5Z7Q84uPwwY53058BT0bjWbEVUrj3
	 dhy59qfpWoCq9xELfThSBeyaguyKwGNEtir30Yn7lT03vh5YlzqOrGXd1N8PjRxazr
	 EHgInNz/FZu2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] i2c: qcom-cci: Remove the unused variable cci_clk_rate
Date: Tue, 22 Sep 2026 13:56:00 -0400
Message-ID: <20260922175601.3321063-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175601.3321063-1-sashal@kernel.org>
References: <2026092212-macarena-tidings-7d83@gregkh>
 <20260922175601.3321063-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit b88c79699d72caa947ecaae85839b3563662ccce ]

Variable cci_clk_rate is not effectively used, so delete it.

drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
Fixes: 8284750a1829 ("i2c: qcom-cci: Stop complaining about DT set clock rate")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 7362a1553eb0 ("i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bfd722b5be353..8c9ad30d7364c 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -523,7 +523,6 @@ static const struct dev_pm_ops qcom_cci_pm = {
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	unsigned long cci_clk_rate = 0;
 	struct device_node *child;
 	struct resource *r;
 	struct cci *cci;
@@ -594,14 +593,6 @@ static int cci_probe(struct platform_device *pdev)
 	}
 	cci->nclocks = ret;
 
-	/* Retrieve CCI clock rate */
-	for (i = 0; i < cci->nclocks; i++) {
-		if (!strcmp(cci->clocks[i].id, "cci")) {
-			cci_clk_rate = clk_get_rate(cci->clocks[i].clk);
-			break;
-		}
-	}
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

