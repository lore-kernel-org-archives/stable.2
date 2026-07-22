Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE940F733
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716235; cv=none; b=fueIMtcBiAnrBXmtBxCp+S5Q1VE/eCsGA2qS929NuZF8zpxO9oXd0lA6RySH3p4Htyhhtcg4uEy//neOYAyZzksf3y35g+lPCECrg6nfF3AlOLlvjFTNgNLEi6SpTt0Dy60HjlTntI2DgIzd/OtV3xGGinXQ0e+7lHlI4eftKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716235; c=relaxed/simple;
	bh=QspVuz/a5U+pD4jd//cWY/AV/dtLkXGZqV94464xDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMnxtoRS1lpOJ8BodukskLCkkohdfbu2qQYDLtX0kNP9LxFAg2VZsUggr9fGkGx+Zl/DVmCh/FC+EHYZFQQCIlOK0AZQU6GWymrvJXaRDqe8G3lPO+0DPMJnG70nH0qOS1pcPBCqvkeQ3urXV4Z3s23LD4uwxKZFlW9JxNgJ84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciHEb/Fl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciHEb/Fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB91F00A3A;
	Wed, 22 Jul 2026 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716234;
	bh=Uh/v6z3A4S8rIZwoE+UBqldZQFFSrAbBDuXrso65w+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ciHEb/Fl6cs8kSWeZSGQqMKoPUtEh6t8EhFTh7p8hviGmI+jp8cyORghQV4eE2I7W
	 AdQmTcN9oiD2caqyiWoy3j6zNCtovT1O5VTtojwIsknJC49tVd4w05u97H4BCB6J7c
	 2xeSUTyloXalhPEdCr5f3eD5Wa6NdrsLWUoYm9ARmNrMNF7ipNvFkHfi+7vQhsF8lR
	 nRoI/Ds8GKK/veDfR/PF/5ZyxFGaauK8dAFuZlIvAzX8+82zUTBIeVSxVXBJamlZlG
	 mpZSpHnz1ozDpjHTexCqP7hXTyDbVrsTG2Gy1q0V+KgzZbrS2bSMZIvWHdGMUgU5dp
	 SMwe/V2iWtdTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] i2c: core: fix irq domain leak on adapter registration failure
Date: Wed, 22 Jul 2026 06:30:26 -0400
Message-ID: <20260722103029.890864-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722103029.890864-1-sashal@kernel.org>
References: <2026071657-book-manhandle-a0e6@gregkh>
 <20260722103029.890864-1-sashal@kernel.org>
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
index 4e7e8af87750fc..04fbbe35b9ffd0 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1472,7 +1472,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		put_device(&adap->dev);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	res = i2c_setup_smbus_alert(adap);
@@ -1512,6 +1512,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

