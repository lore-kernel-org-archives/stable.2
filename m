Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579946D2CB
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660349; cv=none; b=stD5wabqKkOyvX+yYtwdsHCPMotvugtR+ykpGnEVkeTRJLlmJngrol5xtlKPQqjcMqcKnq/u5dwzwPoIc+8TibpO+QZHOFK2aWFiJaWnvUGvwvShFueKq3yjN/29goveooS5IBZbK1TuswHs3OaTJKQVX4/pu2j83ulydDGKiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660349; c=relaxed/simple;
	bh=V/Cf4Vc+DbL5SPmtZIS93It9QLWM9omwyfdZAsKsBaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTjh7e8J+IHR73WLXCD6P2vOJX+UCOM5QNaQfPTyWeXemJ/U4dSuBlnMsRM7ZWDd+5U5+2iFHJhBNn5fCu7/yeD3m/14buWvazqGWRFZ1pnGIFVphUb3p2oPGSPAw7A4ZoSJvKrFo8y7gI7XWBUENkFlWJZaZRadDj85aup8Yew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXsMjvPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXsMjvPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA38B1F000E9;
	Tue, 21 Jul 2026 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660346;
	bh=4yZ1mSxtPkm0g+iZgxa72jkUiMo1fdD0WbKFPq2Vk0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXsMjvPNfivYXsG+7UdqEaKFbJM151rdILwehkGxNdmYvvNNs+71z53WsIWdEKfqy
	 3mLsSH5P41A5+iGW/F/TDPdl7m7AUxax63wRTk0hpTQWilZjn+4yvG1PgcfGPAumjF
	 P2BJctjRN+CfeedGrZDgdXDz5hVNeEFT56fJWwBnFqFv8JHq61vxxe/lt5pAsC69gN
	 4UKQ16zuLMiLuB+eTUnTz11w9GhBNrOaew2vCe6gVjo5J87gN52t0DB+qArjR8aT+g
	 F51v/3a4gDq5tWykPt5xVZWg6fdB+2X/9QwjC/rFGqcHtNfXMUSJifdqzWkK6+WGEU
	 3l4eTL7dj3CHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] i2c: core: fix irq domain leak on adapter registration failure
Date: Tue, 21 Jul 2026 14:59:00 -0400
Message-ID: <20260721185903.397573-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071637-frenzied-roundworm-4d38@gregkh>
References: <2026071637-frenzied-roundworm-4d38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8ce19524e4cc2462685f596a6402fbd8fb984ab2 ]

Make sure to tear down the host notify irq domain on adapter
registration failure to avoid leaking it.

This issue was flagged by Sashiko when reviewing another adapter
registration fix.

Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not alert")
Cc: stable@vger.kernel.org	# 4.10
Cc: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: 07d5fb537928 ("i2c: core: fix adapter debugfs creation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 265b7f7f38c6eb..3761c922d01fff 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1554,7 +1554,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1601,6 +1601,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.53.0

