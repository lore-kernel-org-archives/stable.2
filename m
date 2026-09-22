Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70639314D1F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084461; cv=none; b=tzbXdJpZlYCvszF1M9dpuotKO7BeECzErYcE7xgsY9GAfZqUmVOjtMEVUdEN588rqaKt9jaXeCyUJM+lcoXdcDOPSfun3GNfTM1TeHkbcg8c661jAAR50iN0B1YPA6LGWeKnaykIk9ERy4672qgeMbfeVI9n99XiR+NTx6U3ds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084461; c=relaxed/simple;
	bh=FQJ4eEKZWLe4/ReuN2Q9s2XGLjVV+uJUgYmVhFExO7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ1485Vcfq1gMFXOTOjCHtWKG8GIicGNrPDCF32x/t+lLtXuPFx1uD1e3310rHslgTQ1iWjjfuqU4Dl/gEjW2XnqJ+WVYlfXcb6Cq6oBexjBwYwA0Iqm1PQowke1yu9ehXC5NIz4VaUW24PD75P5yowc3pzKeV7Llg4iW/Wxa1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3DfSnCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3DfSnCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CB21F00899;
	Tue, 22 Sep 2026 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084460;
	bh=gEkmcAN3k9ADPMGx/uEo8HgPHN3m+fZ4RtwWE/MKolw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3DfSnCWfqTiAfsMckgZVlQcvosGLIUzucm7y0bilif1wbfBns+pdx5CUNUSX8qd1
	 j+WLRXTMuzhrzg5r43U6mdm887AgjWDq3E0xgxGmj8OyhJhRYj52XCsvBdm7WEMq35
	 1h4xO5I4ifMGpPQA5IdPk5e4sjhOdavKwQyokylZfbWWMRCKdtGRkT+P12wQY/oKh4
	 bjCmH0P08hnqUgIJzn0dRG75wBrHi2QLWCATngZ7LzM+vHaiOypbKYnntu8fet+t31
	 gonXreFE4+S2uUXAAGYHaFmDI0Dt6R/JmSNc3qp/Q/SEXJHXOX2PeWA3QkAYGUI8ZV
	 TpC9lpvi5eDng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
Date: Tue, 22 Sep 2026 09:40:56 -0400
Message-ID: <20260922134056.2503713-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922134056.2503713-1-sashal@kernel.org>
References: <2026092256-genetics-desecrate-9b80@gregkh>
 <20260922134056.2503713-1-sashal@kernel.org>
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
index d79e8d46d30e0..ae78665247c08 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -510,10 +510,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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

