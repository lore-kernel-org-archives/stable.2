Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331137FF41
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260057; cv=none; b=G+vWGsAIf9PfxgHFZ7HHpQamYHS3RBLm06Dizqv2WIbvI4/NQWzZrO1h0TXez1vvApB/mcVYxqXaDH84QC7iRrTuiADduZkSRYESgeqWExIRlT14rolWEKJfUq/5hkhd0SSVLTt0JZoN4HEjm/+ivkzUzln1ruFcnWljwYxKfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260057; c=relaxed/simple;
	bh=RdlPr4+JE2jE04W/vsLY56hppuZpSliKc+yNgJ4JNOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzsMm0W2/KvHxJ8s3NvxTVOfKWR4LH1lcMo8ypaZQg5BT6EHKZ/vOj3zgo09veG+IAUpvAM1ASpjgGKCHB1YS969E9z/vB/c2WigoDLYQijFujGAyDmcVruOA0lx5PNzscFxI4KnMj/l0PzCK5tKjN6n88eaHUVp9/61pewnEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAuGOIf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAuGOIf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4C31F000E9;
	Sun,  5 Jul 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260055;
	bh=Ybr1dN1EXPIf5wNDLnNkjiooPtzd8YIIEpbK68Ao5p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XAuGOIf9pdtDUMmAKiS9uuWRf5PQ1n5YxiTYKgqyHyyPlu3AWmMnKDrJUCSGzWmXy
	 fGYFvEMbrXr5vx1ie1acqNuMHzwfD7RBiZhp5DdWEhbkUvxIr2pv2LW2mDQwQVIix2
	 6/hx76clsKhA2vfI9ojtOYRCLDIwdk1eth62v+vUbpcJc3dBRCSdmnHERml/lxCaxm
	 fsSky2YCVoowREzcGGOEiJ0OH5cMo9rSeZoe0CvYB2GDSpYw9U3WlDoOlmwe7V/r+s
	 3j+e4Ky1xwNWoGKMkutEIWamvII1piiBOgS7v4XQNxE58YteXg1WlTV2gd6D8Ii+6b
	 Kj+1+4fl72fQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] i2c: core: fix irq domain leak on adapter registration failure
Date: Sun,  5 Jul 2026 10:00:49 -0400
Message-ID: <20260705140053.1744489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070232-opal-musky-5819@gregkh>
References: <2026070232-opal-musky-5819@gregkh>
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
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
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

