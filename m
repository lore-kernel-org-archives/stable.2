Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF23E4C6B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099472; cv=none; b=obgxIfxFaSfn6+//meJMLmJk513348DiKZfjxQp3z3+suLMMoQcfvXdMIzVk8s4fK8qRxg0duv6bBDuoujWnRoxz7mr65/HmDkWkf2q3SXw5i1DIi3N1iz76s+mXfW7kTmrKXVVWWeKhFSH5xG5IiKfmINKUxqS2JIp7saO776A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099472; c=relaxed/simple;
	bh=bhrxK4T06tHicbUlMqiQE47mu1eDknnwqap75IlEqok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIUTV2nYlvzzaPsU1kJ49J4kd+qifgB1/uoe/aZiIdyflyod7UPGksgyqdPB84awuVNzJArvhJJpQGvyLji76byHk3iCWOXLC0gD7oFbGURz/qA5YwUoSH1EOVzlkBJ2j4ynY7rlNngwXs1wAFzbbpP5TLPXUUDwJKpDeqCrnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLBbf34H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLBbf34H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CF51F00899;
	Tue, 22 Sep 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099470;
	bh=e82pv+4jbzMlj6xAhqJHXkvD9JgiO96fXVtWpsiwals=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iLBbf34H1zPbrwTt2GP5iM8bNnRyQDlmjlcXCcoO0ZLWuE0Y3Qxb8w0QAR1tgVpq0
	 +594XwBOJkr6qRxrqYh6ebpOJTuavGhW5aSR00Wzh9lmqD6GnthNsKAMvUb/Gmqjq4
	 1Pyd825dfY0tR/uNi/eiW4iK/LN6AGP08gSQFHC9a6N3pGfTmg5kWSANnKW5AFJdHi
	 rikADWW6XCjGlDv4RLejVC3Z+NIhUwx5aDEV24U+35ae7NEAEAkGt5Yop4aTEX875T
	 a0qzm85kJvHLzzo0FAnV0cs7gVBf9Y6/Hh6P7Z/0/GiIJYoqHZ7F/6rgtAwpkq2fF8
	 +LNVmXTsCNxaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] i2c: qcom-cci: Remove the unused variable cci_clk_rate
Date: Tue, 22 Sep 2026 13:51:05 -0400
Message-ID: <20260922175106.3308111-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175106.3308111-1-sashal@kernel.org>
References: <2026092212-fruit-deploy-01d6@gregkh>
 <20260922175106.3308111-1-sashal@kernel.org>
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
index 657840f5639c8..6a4d8a546fa75 100644
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

