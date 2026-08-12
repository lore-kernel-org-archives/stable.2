Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341621D591
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529632; cv=none; b=gKGWObgCzTP1wddeC5YRJFP4pca674hFG6V1oVBn7bZ1dQnQRmIi9pWVf3o1nDLadiDww8tgdScoKqDmgMoIbQkz8joq5KkcrWNmgmO6YhoqJ+WDSOb7pFAkYkDzwqXVSC7OSD8zTJU/VvkTy7rXJvIKwWJN0CauYBOaM4YD+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529632; c=relaxed/simple;
	bh=1A5tfYTSTudLvfx9cUJKAeZhLSclewZJYwQXA0r8Udo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKVVzuj8jcyhkxSRIDlUoQw3dvSnl47w+iPQXXjoQOrQNYBK0E3iwKSdAMPx6XbCQmMCfooSB/1sLVhFEqAmTttMVO0LW+N2EsdQDMeD9sQksmZ1IBYsuOb+H9y8fhBfU0+BMI9wSp00KlxnqY1kew0zFVIrB6OtrdXQnaW+dlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvnnOJMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvnnOJMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2081F00A3D;
	Wed, 12 Aug 2026 10:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786529630;
	bh=QsOwRHchJXfchfcV3NSxd4dgu/UY9FTQyqG3NHnU6/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WvnnOJMAZQp5kZgwQyE6kt7M1YXCWnyRIgOoQoMYpd7GTYSPvgS+4eZFP/UGe0xO1
	 YOHH/bGWHEHoa69JN4rPnFcmSSL7Uk6y3xGcCuoMC1UDDkqt+NjgPjxt9vCxnlaaxb
	 lyzymK2WIkJtHkTG/IMHFlnDugrXPOl5xkBinw+eGs7sK9yfp9DgSvfCbKAQX+GFxy
	 wjCI0CEb+L7yjn0XKB5XUY4/7FAqc79nG6IRIaHpqrj3K5b3OmOLa+PSIi0gBOItcX
	 JcbMiBWrcvhU9hriWclZpfJGmAFb9eZQk1n1ZIeQ9qquVyQ1hM4hQtRbJlTdFTaxWg
	 Io3ll9/u2Jj1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] i2c: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed, 12 Aug 2026 06:13:46 -0400
Message-ID: <20260812101347.1638816-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812101347.1638816-1-sashal@kernel.org>
References: <2026080542-curse-dispersed-597e@gregkh>
 <20260812101347.1638816-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit ae11e08c3d0c78d08dac4cea30bf39ede2130b03 ]

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: b08c9857aa1f ("i2c: qcom-cci: drop custom suspend/resume and rely on runtime PM helpers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 85de659bb3627..1afba8b02ad2a 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -509,7 +509,6 @@ static int __maybe_unused cci_suspend(struct device *dev)
 static int __maybe_unused cci_resume(struct device *dev)
 {
 	cci_resume_runtime(dev);
-	pm_runtime_mark_last_busy(dev);
 	pm_request_autosuspend(dev);
 
 	return 0;
-- 
2.53.0

