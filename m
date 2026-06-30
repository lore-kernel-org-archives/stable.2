Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684B2D9797;
	Tue, 30 Jun 2026 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850565; cv=none; b=PvxciGioDu7pkRCmG6370zTsLVHawqBetiT0KmD2LFWT/wHZHY1J3/1+w3Bskk+XdO2RlNlo44koZALl7Qy/00c3ofmN1dcG7FyvNmr5wcV70vLg99yn8cZTgax1QfOi6O8pCfBiaU+rp0/F5d/rmoonHNDgX4qPD8QVtjwwSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850565; c=relaxed/simple;
	bh=UgO41PomFNOgYf0/SpcGC76ti/MQ5n7cHiTK7R9PY2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbiDxIJH2ghaHYseZLvI0OSB8U/9xKul8YvhSdch38zpZaxsTUUTTn3NWI4KjAj+smvvZvRdS6S2h/Szc9YynMggjXmzEvNedn1GSjb/IgbOSv1+sQfH/N8JwYnVVol3HAKTdg3TxKA7KXw/mthS6VIVot+zE5OQmWjLDXUBMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=gW4rFN2A; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="gW4rFN2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1782850070;
	bh=UgO41PomFNOgYf0/SpcGC76ti/MQ5n7cHiTK7R9PY2A=;
	h=From:To:Cc:Subject:Date:From;
	b=gW4rFN2A1qw9+AOeB/Lk9q+2Xl+gelq+LlUAx2dUAsX7XJjhl5XQgbAjcg9wXn18a
	 7fjF2e2mdpgnv3LXKdGcLtDMMk9EicINSJN2ZtlID4kIozrOTrzLqSzxku8PFbkSoc
	 AafRuGt4Lri4pJ86ehuPivyV7hRGxLJW+7tBnuPr9hiLluifoTluYXL+IaLzuhedzM
	 Yif2sOHgorpgeZzuw5PqBJJOxSgDJkEP4g8YoF27jMRcgByYyxB4gkVN3jQVf1z3sp
	 +Bfly4ttqRM7PsWIqoe8zRGkj+LFODMNgKT5ehdtxObSghyBG8kBIDSpX/ZYdKjGX5
	 5d54kFdiSERHQ==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id BDC7D1F9BD;
	Tue, 30 Jun 2026 23:07:50 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue, 30 Jun 2026 23:07:48 +0300 (MSK)
Received: from rbta-spb-lt-115149.astralinux.ru (unknown [10.198.20.253])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gqZ2C3WQYz68r;
	Tue, 30 Jun 2026 23:07:47 +0300 (MSK)
From: Elizaveta Tereshkina <etereshkina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Wenshan Lan <jetlan9@163.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Tue, 30 Jun 2026 23:07:17 +0300
Message-Id: <20260630200717.1994713-1-etereshkina@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/06/30 19:09:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: etereshkina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 111 0.3.111 1434338e80da3ad6056aa2b487308911a6b137ca, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;patch.msgid.link:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204160 [Jun 30 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/30 15:50:00 #28333055
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/06/30 19:09:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Kevin Hao <haokexin@gmail.com>

commit 9d724b34fbe13b71865ad0906a4be97571f19cf5 upstream.

If an error occurs during register_netdev() for the first MAC in
cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
cpsw->slaves[1].ndev would remain unchanged. This could later cause
cpsw_unregister_ports() to attempt unregistering the second MAC.
To address this, add a check for ndev->reg_state before calling
unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
to NULL becomes unnecessary and can be removed accordingly.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
---
Backport fix for CVE-2026-43219
 drivers/net/ethernet/ti/cpsw_new.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 66b1620b6f5b..cc276241f391 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1456,7 +1456,8 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		if (!cpsw->slaves[i].ndev ||
+		    cpsw->slaves[i].ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		unregister_netdev(cpsw->slaves[i].ndev);
@@ -1476,7 +1477,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
-- 
2.39.2

