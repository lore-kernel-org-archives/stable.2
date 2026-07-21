Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6A39A7FD
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658482; cv=none; b=W4WP0vA08rE3fq7kw6dBmpVz14oeG+sIL/bkTDt/NColYrC6J2ao+6l0WfYN+vWPYt+vua2lrz7Xwkca0nm5mi1QXhVzoes0/kywawpNpjaicJrJ2egZYt1pw/EhXf4rHm3STd0PXAfML9aafbD/wRdRIxwF0rOPqXdYHR4+gTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658482; c=relaxed/simple;
	bh=cVFStgU/aBptCaqLRgBPb6eImGA6rg5dINzSDKHNx9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5by0fBMVzDaXj860VJDo8naChQhfYU/00QnYyTAp1XH+wfg9kMUQkEee4X9Lota0N5qMPhUNUZ2aTw8Jykb8IgryWpPG/jcOcZ1ntwOVkkxyZXlzCf6YbjH+u0vyi2TMm4YLM7Nwu8dbUnaDUpLS3HbpvfacJ0f1/+tVkHwkCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb6xFvUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb6xFvUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D8E1F00A3A;
	Tue, 21 Jul 2026 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658480;
	bh=Wx6IL+dDC35n+ekZ72m9bRvtCS+HVeNF0vkQ7LwP76E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zb6xFvUV1LQ73V4O/kHVapCpn+rzjSE9KSkYpjxKmh7hcbmnCXqkQixGksYyeogv+
	 hj9u+RP2NmZCh0yT51ezEksgDiRq+T6g8i0fcchExKxE16eKWvme3c9UflgiEL4jwl
	 V9JOxGaUA/+nMlZwlnMyqP+FU51eE+F8/KuaPHNrKreryij+bqngAtx/Apc7hJc6Ns
	 vm6gD91dWESCZrQOP1cXZyunY0Flw70MSrCM27fGCRTT+uPjAi0fbr+0BrxDZatexi
	 951Tgd9/fsjsirs5DGsKxvFRdlb5YorEf9Zeew/0gIL272NZyl4N94zUatWGiR139W
	 Mv3/4uEwQIMFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] i2c: core: fix irq domain leak on adapter registration failure
Date: Tue, 21 Jul 2026 14:27:55 -0400
Message-ID: <20260721182758.332454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071636-amusing-conduit-3c6b@gregkh>
References: <2026071636-amusing-conduit-3c6b@gregkh>
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
index 943f0021d6a2c1..4b3bc72ef53ddf 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1551,7 +1551,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1599,6 +1599,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

