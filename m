Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E82353A70
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136545; cv=none; b=Ihc26sGIGegzRK+bLC4Kjqr86O+SKdQA6G2BBUxgX3B4pag4ijNO7L+u1uMwWQKwGo1Sld0tbttboTsyNBnqyN4VF5xC+oI36PZYc4HycS93F+ODF0sEQApyLN37o2zkXoddtNf7rramiOQTllI8UovUCne/6cwZAY1LNIWcSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136545; c=relaxed/simple;
	bh=ESTvOwDBNctqxMZ56ycvRSOKIR9nIQAQ3PBouQ6VRxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5ieki/wnX5pzw9UDqrmVkqO0yM7lEPBpAygBec+P+mNyWeu3P8AbnfM3B6ArDE10r2A8ej7LW779fJhuQoN9rg6WGre0DlyA5RAg/WCQejZqmRSWoBOT1/R+CVJVGGNIBRYglIOtXSsW1u+A6RcXUIlNM3H2EQTjkfjBMlANw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wasz1ziv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wasz1ziv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912121F00893;
	Fri, 11 Sep 2026 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136543;
	bh=ISo6noYq8A7RV6V8I6Bj4Afu+1lncjgCunQGdwE4FrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wasz1zivUiWDsN/VzkfjZ4NZiGHdrw+JgnPnuca169McpJnfElsusFi3ulLD+KUpV
	 k3cqyWkYfvSGvjAcR29TGkEp0djJ50UAqT2HSC0hDOJV3IcHhkmo2OCu2dxBEbR5k9
	 YqDppCaYwJsgHSSW3D8WLUS/5oYWIbevF1Qify8ySj+nMIq3ZquyhJuu8IGgrE4Yer
	 u8ZDcjKKlbE/3CDqlU/zNaLF1fwms165yqlMzkttYfrxJYK1VT2gMYJPwTukY4bm28
	 tOHL+5X9ei27m+aBrHo3hxVpkEkkBVew5xXWttN3LpVJhYLm5iiMfa036r6KnxLT9s
	 Rds1WpFu55rKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hungyu Lin <dennylin0707@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] media: qcom: iris: fix runtime PM reference leaks
Date: Fri, 11 Sep 2026 10:22:20 -0400
Message-ID: <20260911142220.889653-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142220.889653-1-sashal@kernel.org>
References: <2026090908-modulator-ascent-3261@gregkh>
 <20260911142220.889653-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_resources.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 872bd09656b15..6d3339423eec0 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -78,20 +78,21 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 	if (ret)
 		return ret;
 
-	return pm_runtime_get_sync(pd_dev);
+	return pm_runtime_resume_and_get(pd_dev);
 }
 
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
+	int pm_ret;
 
 	ret = iris_opp_set_rate(core->dev, 0);
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

