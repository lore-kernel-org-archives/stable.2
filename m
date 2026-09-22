Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317433F59A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080486; cv=none; b=XmzPneDdPB5fkocLCnGyBsk0PK4Y45qmGS+zQfkbGgwwdaLdZok3EB71nRlcD6/sgYrgw4ZTEPTqD9gNS4eMTC+pYvr1oeyzssQQ/euqdjqBKaiCpjq8HGkcdTh1UAzC2Co4yVq+6kiZ1anylWissg14PQMB8OkzElFoS7+JIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080486; c=relaxed/simple;
	bh=Ijl7Y/rIyY41yI08xTz90zNQIx1T4gJuJcqGIkK8qsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOgGppkCPvBUDpAntMIbcldSGgLWNmaMEjV6sUc49kyYg93aL0cn1g8iuhGAiUt153PBJx+t5cjqvmhBdu3gnTo9IdkO/6lgVk6Ux+A105V9wNB6oh+xgCgsn5wXXXZEDQA2GXFa3YwrzzDAAOZem6g7iQNDslrgRh+BgEbQK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COEEpChV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COEEpChV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DCD1F000FF;
	Tue, 22 Sep 2026 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080484;
	bh=dxQjsSFS/9OJbt5iat0mqBF5Ht6PKOg2lkT19M71wrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=COEEpChVNC2O3I267UYjHtQ2c+MzDCPj98B7pfyUwyGEGHR0VIHx4i2dB30UirXph
	 jfbh77ZzN7OVqvit+kY6ByLpp3wBzrXF8oB5cQmV8DBtpw3pJFMOx6H7kgsH1wQzHX
	 uaRKT7XOM2M24k8x1J8qu6cnnatgg5Ay1DW94MZpeDGdZ7U3QZGW2Kj2BMVzVQDe8c
	 ES/h7X45ZOAYhUVHGnlppDX8a68FJjAE1xI1eBBkrMHkKPO4EeIUs+gBKV8VNAELZq
	 jbzhEwl+4MaJOPVnGDsZCETQOuu/A844v5PIkU2DyU0Lq+WNa1ND5xG64Sw/EhSEcT
	 2C+sUaM6mO/dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
Date: Tue, 22 Sep 2026 08:34:42 -0400
Message-ID: <20260922123442.2257247-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922123442.2257247-1-sashal@kernel.org>
References: <2026092255-disaster-skittle-8855@gregkh>
 <20260922123442.2257247-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 0d1cb83337f13af082afb68b28d3fdfe29cde7fb ]

of_find_device_by_node() takes a reference on the port platform device,
which is only used to look up its port regulator and is never released,
neither on success nor on the error paths. Drop the reference with
put_device() once the regulator has been obtained, which covers both the
success and error paths.

Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://lore.kernel.org/r/20260915065933.1733061-1-vulab@iscas.ac.cn
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 50aaa82d4971a..6ed700a02df43 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -622,10 +622,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			of_platform_device_create(child, NULL, NULL);
 
 			port_dev = of_find_device_by_node(child);
-
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
+				put_device(&port_dev->dev);
 				if (rc == -EPROBE_DEFER)
 					goto err_out;
 			}
-- 
2.53.0

