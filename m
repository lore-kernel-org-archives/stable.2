Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5F3B3894
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058980; cv=none; b=YetbpexScD9HjCHDohD0jYp5fdRKxgNDIuiu15dpjLbwm9SolU1PSWckQ6UlDPaRiRnL71ENNaB3vdfzNErqXhNv6ITTarWXz5I0pV60FjPPz8ICXlbIKCN6Djusx248kIK6mdItnBTZ8KMfpZ/TCLrNhxL2hJbQqtZjbAGF5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058980; c=relaxed/simple;
	bh=OhRQZhGtmwOq+s1kzkdls0WifB1pHPGcQwnTnFw1e8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbVuc4aMzu7rZK/723cGKkkFQm8e0hZwY80/qDGCF3CdGU+vxFJzLRBCdGzLVJ6+5UccOED6ZHrPegeEOcEq4jh6FtnOO38EEmZ4+T2LJcGtve3Wqceq6IqyihHdxsaDaKb1wCEh/FEga29Ds9rSfiCEv44fAWSrnvWWDMCneMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+HKRjtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+HKRjtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D702B1F00893;
	Thu, 10 Sep 2026 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058978;
	bh=RSx497K3CbVlsuikAtmtsji8yA5jwz5pqJVV0mQYb1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+HKRjtGfJa9aGkS9aTplNGuDKW0oz2mN4Y/WO2zGZfVLYDBn+Gco11iUh8ovmYk6
	 BoIOPZkVzb4MHXzhfg2jvYFcEKD7YIBl/pJzkOejATULAXS7uNvcYvU9vY2xA9LJOL
	 0SVADCwnQiGMvsBQhVQ5zQgDjAdV+/lcf8xEO4bSMMfUO7aDo7X0TxbDw5bJ2mdzQT
	 chnOGa2tjuz9RvuE5DCMWgm231qxZkubZQrE6Ml3pqA+dqFb1OzUYLT8fE64mLMmiN
	 FOhXZ63cZiWEHJ2T7b8ZA9qphnZxe+sDgGjmap+jtxiK4CYChkkYwBxAGr7yzSuwpF
	 XCxhk+yDOA3CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] i2c: qcom-cci: Remove overcautious disable_irq() calls
Date: Thu, 10 Sep 2026 12:49:34 -0400
Message-ID: <20260910164935.1257325-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910164935.1257325-1-sashal@kernel.org>
References: <2026090908-parrot-escargot-18fb@gregkh>
 <20260910164935.1257325-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit f0285c286bca5a1e018ba25040cef6c7806c31ef ]

In cci_probe() the controller's interrupt is requested using a devres
managed API, and in cci_probe() error path and cci_remove() it'd be
safe to rely on devres mechanism to free and shutdown the interrupt,
thus explicit disable_irq() calls can be removed as unnecessary ones.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260515234121.1607425-5-vladimir.zapolskiy@linaro.org
Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bcc67427b6c3f..2cbf47052d8da 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -630,7 +630,7 @@ static int cci_probe(struct platform_device *pdev)
 
 	ret = cci_reset(cci);
 	if (ret < 0)
-		goto error;
+		goto disable_clocks;
 
 	cci_init(cci);
 
@@ -662,8 +662,6 @@ static int cci_probe(struct platform_device *pdev)
 			of_node_put(cci->master[i].adap.dev.of_node);
 		}
 	}
-error:
-	disable_irq(cci->irq);
 disable_clocks:
 	cci_disable_clocks(cci);
 
@@ -683,7 +681,6 @@ static void cci_remove(struct platform_device *pdev)
 		}
 	}
 
-	disable_irq(cci->irq);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 }
-- 
2.53.0

