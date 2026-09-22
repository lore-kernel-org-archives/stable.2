Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30500550DC9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083125; cv=none; b=k94mRJRVWHZWUTiIyz0DwZ6LPCwV/+9QqsS6JRUkNgz4pq8RsKYFCdxOKbnkiB5aJLBOhH/SHcLfkOU6OhCbYuE/rP4VVKV8nllRfz6ZyOsg76tUHpkxBLw0zIxAJK6Q8EMTFrkFJOqkM9lOpE/j2Z7QlFgBLvRVIe/D9hQlb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083125; c=relaxed/simple;
	bh=jSZAJmPxrsrZPa29BOc1hAEq8Uu2Gn0x9yt5GHPrFRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ0OE0LIBT9MOe57TBzdAR1kMFS5dEhYmby+nCXiBiXOMM7Ls0jA8gNJrguXblKddNowJ9ooOkNFMkyyPHAhiq928TtRwVp7rex9ZZmptISwe3CodhChz08z+QeZpO9iQKIEaoFamIoD6pG+wcSryX9TtvI7vlhOyCgmB5rJY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXtNEtwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXtNEtwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C211F0089A;
	Tue, 22 Sep 2026 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083123;
	bh=ZdN2aCS+bRwGwNJQxDr0/CCynY/3eYJ2fzzZ9aeRjKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXtNEtwWK548fIppKF57kS4jaJzU+RfNq1ci/DeTRmbsHoIcujY7/Hl3f/vJrreZq
	 W2D2SJjgobQXP21g3d/iMEcMvrxTKn7B1AUa3C3PKAb8HirLG43eZOqDMLAvgdEDew
	 gOnFZuX75w02Q0pFfWQiiHUxFtHz5/8aJf38yIwk56AIJqIbZZ08oTgsBaxTLDm9AI
	 6Q3rskrdC03nKCjtotXAKIxkqoevh8CKgJXSgp8qnDSBw14DgGkJOUf96GjehMxISp
	 OSbUk6fNbj9/oKEGDZY44lGi6aMVhxjjrAnb/JJiwmNImO/ytkaOta2jyk+Nq9Pcqs
	 2n74b9WAOt3nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()
Date: Tue, 22 Sep 2026 09:18:40 -0400
Message-ID: <20260922131840.2444454-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922131840.2444454-1-sashal@kernel.org>
References: <2026092256-flyer-contusion-4709@gregkh>
 <20260922131840.2444454-1-sashal@kernel.org>
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
index 9b8e30fd6e865..44eb9ff68dc1f 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -543,10 +543,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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

