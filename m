Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8633A9FC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659720; cv=none; b=Hgw4o7N+JRffGMuH7PI2VISzP4TKOdCFUs8w6dbQqsegzhelwvtJLgXiLvjIZjKZ5A6sLPTiTEBLDii+Hy6q5t9i76C56Q0Y1O4ukCRUHJkYISPOJACWw2RUBWaeNLbMLbeZ/h7jEQOAprShkkOTDQ+TLPWqZjKaJcKHhVVVhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659720; c=relaxed/simple;
	bh=HkFjMAvBnH8U36QbJ2yCbwI3fc1WRCppuNS4hmWGd2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8EI57NRaSpE51ySRwZstI1NIQMBcZKjI2d/yeAMZvgpyhfUVNqDI+DvNJu7rRYGArL6XijbmyqsZSCDOor82aOBQKGxStnkHs3cQLxF1maYRqKlCcAfWxEQDESq5XzVCdC8N02kjGPKQd3HnCQ0Uyx2zCnxu8VUoJBpKh8eXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb6Q//aD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb6Q//aD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1AB1F00A3A;
	Tue, 21 Jul 2026 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659718;
	bh=vrlLaDx2DOKiSa51zOQAE2KzrJtrRCT0Z1UrtvO/7WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hb6Q//aDup/JG6tux4XapLwhddbGHASJ8ALQaYNZSVYLdq6aN5zw4YQaGEPYITqMB
	 BhLfQVcfBlommgvwx28e53AvQGeNmLj+DkIwf8y63lBz+g9o61ySNbIuo+8i2Kydbn
	 ftjyMsiXaQci4rW3uTy2VEcKCEC34fghjxZv+mkVEe/PLjOsf/14iY8hzvGJyEyEx6
	 VGVZtNLKLC4Io6K3K483zN7ylWaAov6QS7nl3d8eLpMnfmETz4PJOR+e546frCMZXD
	 c6KU5jiwDa7E6JOYj4gXU54+w+RtGxa/heKK5J0Nm4Qoq0jMQULqFYttI31gbyFfop
	 4e6+qkvgW3KSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] i2c: core: fix irq domain leak on adapter registration failure
Date: Tue, 21 Jul 2026 14:48:32 -0400
Message-ID: <20260721184835.382100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071636-deceiver-subzero-c7fe@gregkh>
References: <2026071636-deceiver-subzero-c7fe@gregkh>
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
index f7e3fc0b3a1daa..e639c679d2737e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1556,7 +1556,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1604,6 +1604,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

