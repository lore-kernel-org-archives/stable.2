Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC7374A1D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138263; cv=none; b=qVFmV6lAJVxQBpCADnP/AaLbQNxWUKKwQrZPQnB8WV3KAby5EQvEPIu8fPyauq1IhFXtaGm+rI69IkhVl7F8GJ4zw46DbgdrOkreFVACLBJ2eEUunUoC0EtIqoQC5hel40eIoFa6SizIqKFVGrGamr2XbtqC9Yj1lKr9NiSyc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138263; c=relaxed/simple;
	bh=clZQi9j9bEofnVyZjwpW5eGfOgxD6qp0znJx/6plyRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLC2ylbml5y2El10nGt23+aqeJ6MHHJB2JaOXtNOn7Pkeegkh05WF6G/iCcjjmX+AFyEewycdUd669PFzYXhMmRdIfN7Su/lF92Fi5EWH8Lay06rPAiz4HLNsumjYeTvxOCoygxqIh06Ad8bE6JR2Rdk6/rsmfSSwlWxXqkbRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJu2FBVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJu2FBVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E011F00898;
	Fri, 11 Sep 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138262;
	bh=Yg3MAZWeH26CZuqho1lO4G6VZ/MnFejd3ogxUyDROZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJu2FBVavrojwlYGxLl2Ar6t18KFIMtmlOUfsdBG1h7q/zWpMBOrzJBKMTpykQ8vt
	 xn/1LYoRo94Ne/3b/GtOCz36PCsTRvHSencD7Vwnfw8gRguwxRVtYCEcpZF3ficYNK
	 8Emzyz5EzkHYrR8Hf+7WjABv+02WTSmLYq8I571rzfxfCHBqyuSV9JaQNHUTkDHzc3
	 PQfWHEi0IVww1+9NmhF7M4rZMb1aszyIfoHb6Q2cyaySg/lJxz5p/Mg0I4fhd0XmHb
	 Bmjc//oO6WyQVxq0CyLA5gUrcQvuqzS2ZyqGyTEQIyt96NQfEiAsDGTy2Br+/dQWrm
	 B5f+BlYK7pKhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hungyu Lin <dennylin0707@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] media: qcom: iris: fix runtime PM reference leaks
Date: Fri, 11 Sep 2026 10:50:57 -0400
Message-ID: <20260911145058.985072-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911145058.985072-1-sashal@kernel.org>
References: <2026090908-wobbly-comply-f1b3@gregkh>
 <20260911145058.985072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hungyu Lin <dennylin0707@gmail.com>

[ Upstream commit f87d7eda07fca21efe4b96169ae59007db46e60e ]

Use pm_runtime_resume_and_get() in iris_enable_power_domains()
to avoid leaking a runtime PM usage count on failure.

Also ensure pm_runtime_put_sync() is always called in
iris_disable_power_domains(), even when iris_opp_set_rate()
fails, so runtime PM references remain balanced.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
[ used dev_pm_opp_set_rate() instead of the unavailable iris_opp_set_rate(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_resources.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 42cc707f5bcd2..dcec4f3460d88 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -66,20 +66,21 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 	if (ret)
 		return ret;
 
-	return pm_runtime_get_sync(pd_dev);
+	return pm_runtime_resume_and_get(pd_dev);
 }
 
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
+	int pm_ret;
 
 	ret = dev_pm_opp_set_rate(core->dev, 0);
-	if (ret)
-		return ret;
 
-	pm_runtime_put_sync(pd_dev);
+	pm_ret = pm_runtime_put_sync(pd_dev);
+	if (!ret)
+		ret = pm_ret;
 
-	return 0;
+	return ret;
 }
 
 static struct clk *iris_get_clk_by_type(struct iris_core *core, enum platform_clk_type clk_type)
-- 
2.53.0

