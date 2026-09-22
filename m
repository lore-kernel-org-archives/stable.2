Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AB541453
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079574; cv=none; b=cA070+zFCHln6Y0TaN+40dELsiDLdTQjiHRuvsJdC/7Df8wbDgG7GjmbkUCRuCiIQfCSQfewgw0N8983aqcxu+p9QluzDb7mov5r8HBWRkIcIbh8KR7fGEtY7Duny7fjkYuhipLONCPlpoJ5oCDomK6Lb5HBAjCej4qdJ99DsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079574; c=relaxed/simple;
	bh=M311Q/bCQ2STix4lASbuXIARIEegVM+lxY2rwn1Exxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9mZ/Qg3yJeaV/78TnQxnhZzd2JPbCNSe2mCr2aWuw5Vd/MYdkGmtQ4Ocby4FZbd2EOMd+fhdKlPmh/t5Rp8Y5lwIZLW3w8SLy74Ypv1nCch1vbPGkvAe3ZfEpu1u16lp6NGyuepxhOx8SgjKLcb/02cD5JbC6SOEvTTZhACwjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmd4NaJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmd4NaJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C901F00898;
	Tue, 22 Sep 2026 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079573;
	bh=ytUtpscty8oK4fp/0amyRNC8RN+/i4fV8oiprzc0oCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cmd4NaJ8jqRKJxR5J20fZtZ+/yh/Ijaa2oFtr6rudvN7+9+za3aGsPf1HSMjTnYku
	 JWs2LVvF3I8bW+PkTNzpLmNqCfY9S+lntSIdVBfcYJ9CCimOHgtQMqU3zjcUjnJZfU
	 P5eLau/t9Im8dAMlhPBwDOuNm9Ovuvahd1J8cBa5HK/4N27GDTd8//hmy9/Cnh6U6S
	 seGv/z1feWlnhDSg0CfCVbbj8qCwUdY5VJOCKG5dcURUNMn+QLMx4t9rVkltNFQstF
	 l0bmvPTfwQ8WeqTs1HhvQgNA7uuBNJsOPWgdxoL3KRIZu/UrKF8AV6stDSavVgzpDR
	 BKXYGDSR/oIdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
Date: Tue, 22 Sep 2026 08:19:30 -0400
Message-ID: <20260922121930.2214519-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922121930.2214519-1-sashal@kernel.org>
References: <2026092255-unstamped-imprison-dfc7@gregkh>
 <20260922121930.2214519-1-sashal@kernel.org>
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
index 91d44302eac92..7308d48cf748b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -623,10 +623,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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

