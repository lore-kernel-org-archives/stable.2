Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8835E95C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681454; cv=none; b=t6LfEt2ToSyyg6hq2L/S+Ee/vHiPNH/Q6Mq4u92uaIt+XuS/WnMnPPs5y4wgqf8UABAQY5X0LglWfHr/t+vmJ3Re4xA02W2M6LiPDVfTfRd6ZzAdZ5eYaaEsPteCgyu88upEn2tzoMKBj9D5zz1BSAkafMUvKwYp6ek6w338qbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681454; c=relaxed/simple;
	bh=rLYUDfBHDF3O1UKqU4F7hlluOoL8B2jFhqxKG+W4ZJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3qa+dod7mhX1/xwUlHyd63A8Y3/YIKmuSgJUwV6xvSdGSwwNpVjd8U54Zo5u8n8jOuHUiDZYc9jpQc0z6pGAtqiISDRovDNbdY/XndwktniDjF8A/MTWJPtlHB4lUYqtHNW1FToa6L431OIgYJ2HE1T94MBafgywToQnoEREdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INACW1gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INACW1gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3F51F00A3D;
	Wed, 22 Jul 2026 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681449;
	bh=FsoohFSMB0t/mr3xHvyb7p8VKWCJnHmCu/I3sephhYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=INACW1gh9BIDqMuwER+WB3KexI1AmJomgHzRrSxIXpjNgdZ5DcmHwwQ8hXqtwebir
	 tiGrynjXqk+jOnopm5XjIkL8OlSuheYFDDqiBA80zUVzqj2xd2NAJ9FFZzFSG/8dSc
	 2jrW4gobyJDuqI8Q+PeuuGdOkVMm7a3mAz0qGe6MNWE3Jz9we902dLf42ouxrdUbMk
	 6Lu0y7Uxq4s41MixOeHjUYjIMfZeHsdTPOdolE8fj1THFD5d/T4o5+V563xiGoQIf/
	 hHXMwiGIwxkG+R4H1EUDKVx0a9H0Zo5Xa8icjhGBlRFp2Br3HBwDXYnQK5KhjYPP2n
	 MZo7kUAKXeLfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] i2c: core: fix irq domain leak on adapter registration failure
Date: Tue, 21 Jul 2026 20:50:44 -0400
Message-ID: <20260722005046.603973-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722005046.603973-1-sashal@kernel.org>
References: <2026071656-dullness-penalize-0e99@gregkh>
 <20260722005046.603973-1-sashal@kernel.org>
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
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 4b3960fa35f7bb..24eedea1ba409c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1565,7 +1565,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		put_device(&adap->dev);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1608,6 +1608,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

