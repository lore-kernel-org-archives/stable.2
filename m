Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59187339377
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716218; cv=none; b=CypNmvc5EquuItof6MCia1qmWlpXoU+pR9gLcBnw6G+1j238FalF/nJXTXj+2U6Bm5VFBd+dIo9Fzn8/orysBmsVD0gPvMVmKwuu/t4W7QUdQ4TFcOzhZhqyidm84s2wDDndDDiUIk3tuUuI650BVWkm6xvsaedpemX1zy7fn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716218; c=relaxed/simple;
	bh=CQchp5jPf3+otDU680vkYygY9y9oUrQmkBhJ4bOb1oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHysgFfVqkvgZozc7yKpPHhPJ1eF0KpjzEsbvz1/+jkn6+V6cIw7bWlS4pnkJ2vl4NRNv1nxBnGwP4u6SO5LFeDcAQ0L1b4+KRfgCBNPhiPW/wi6Y+T9OL3nJuZguuk/ODprZf1G69yb+yiKp7aOrAauC3t+qSz1XaTzphXfLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3WWJE8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3WWJE8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A01F000E9;
	Wed, 22 Jul 2026 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716216;
	bh=0n0DPtpx2moPv+GLe7xytA3RR6R6UbN+3odOnxv6q9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3WWJE8VEA+eD8ROM3yk3iMdroLUKztdojbBecfoGlfY2Wg9Ce1w6uI3zTFnJSxTi
	 /HTN/p/JL4WCbm0vsI/UjXS6sM9YfKvw8jBEZd+5IOYAwb/F0xF2U3y0F3j0WCIEek
	 ic4R7ggN5aAt8eSbyW4xaPIGtCA2oDzDeS4yHp7PlnETurTc/b0mu8JcB99EihTsgZ
	 CC1tS4zpEvLmBwP4ddH6jHqAVTFKw/7nTyL/2xJ4CvKuEm5dvgNWFDPtC8IjGPWY9D
	 F8/8uKmd9jAW2VYXxPEdRbQmjgE/kk3t8pCiQSKzxQAlrfTHP+FEiLI7UFzpqnCVv8
	 AmF6dHa0Ecdpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] i2c: davinci: Unregister cpufreq notifier on probe failure
Date: Wed, 22 Jul 2026 06:30:14 -0400
Message-ID: <20260722103014.890315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071620-pantyhose-primarily-45ab@gregkh>
References: <2026071620-pantyhose-primarily-45ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit e43f32816a1b1fe5a86279411626fe3a9be56d45 ]

davinci_i2c_probe() registers a cpufreq transition notifier before adding
the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
releases the device resources without unregistering the notifier.

Add a dedicated error path to unregister the cpufreq notifier after
i2c_add_numbered_adapter() fails.

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Cc: <stable@vger.kernel.org> # v2.6.36+
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260610030513.2651018-1-haoxiang_li2024@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 232a7679b69b89..c965a3999698bf 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -877,13 +877,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);
-- 
2.53.0

