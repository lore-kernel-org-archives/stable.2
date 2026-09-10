Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96348F03F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058812; cv=none; b=bKxqgFY6acMMA0/iJUmEOmuruuVNPdHzfzSiLzjTStjkyGlKl8JkFE0yXATBdIOdDJKwqO+ehHCfeVIYTS8P8DsT+PjJiKXmhdbgnNRBZQUPMWoyw8eRRMNz4JN5p1xQ0gwicK4vbwpT3XjJOjVt8UpW3+3eTNxnDkZKtPDDcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058812; c=relaxed/simple;
	bh=xfheNJ3QJ2uHfDtXUWUBEOSyIh82cVbAezVFGb1LgCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URAhSjfKsnynBA4/r4emtjBdvTqX7mFJlh1vZsN/u7Lsj8EDuylgp0b5RguL69emOPasM+2+LqpdKdWDMMWtRFKLgJWP9YMZVu2rpFSe6CE7fUli9mkYaHoAVek0QMuD7F/OHYBY0oaf+2tT8mfft+T7gOY4d6PTIqDLuZ+HPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP3HAqzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP3HAqzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280CF1F00898;
	Thu, 10 Sep 2026 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058806;
	bh=MY1SGRkcIJ+VrNLl+7J+qcFLuFRIpnsyCPe8P8/D2oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CP3HAqzhLzj8SLO15oR0SQurMNzGzPI+Bmy+k1/hGPEqBqz10zHZa/wQFTAF4H7aT
	 rQ33qpUJzrJh5IHt2ct9BzoRq7zz7eUomvd1MBd1LJ6pyilXu6lXohQKeTuC/x8iol
	 H7orEzatz3K9GYYkLoHb1q6XxKa/0BBUqbkiSQjtmq+JYLO+xjfdYbrMbRJOrnW0C4
	 8ScuzYrgkKQrEsn1tsOP9C6lzXl+tV6iGAnvY/U785qNeds87hboq0FIMYJ3u9ZXVN
	 mjrgoMtlg+rPvP/nVPXmhjeFRrf0vZiWg9plKkv5eNa4BSecIUqY+hi/v0Nd/hwOyj
	 YJ1E+HRutW6JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] i2c: qcom-cci: Remove overcautious disable_irq() calls
Date: Thu, 10 Sep 2026 12:46:41 -0400
Message-ID: <20260910164643.1250786-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910164643.1250786-1-sashal@kernel.org>
References: <2026090908-bobbing-backlog-313f@gregkh>
 <20260910164643.1250786-1-sashal@kernel.org>
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
index a72455dda58c2..57608846a98a1 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -594,7 +594,7 @@ static int cci_probe(struct platform_device *pdev)
 
 	ret = cci_reset(cci);
 	if (ret < 0)
-		goto error;
+		goto disable_clocks;
 
 	cci_init(cci);
 
@@ -626,8 +626,6 @@ static int cci_probe(struct platform_device *pdev)
 			of_node_put(cci->master[i].adap.dev.of_node);
 		}
 	}
-error:
-	disable_irq(cci->irq);
 disable_clocks:
 	cci_disable_clocks(cci);
 
@@ -647,7 +645,6 @@ static void cci_remove(struct platform_device *pdev)
 		}
 	}
 
-	disable_irq(cci->irq);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 }
-- 
2.53.0

