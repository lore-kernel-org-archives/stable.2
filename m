Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5E34753F;
	Mon,  1 Jun 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299486; cv=none; b=egYVP9EypIBcR0DGAL0aD4dLXgBuWIH5+C2aZdpNhZrllEQvUdk1FUPsEJJqo7JTYSGdr6LMtc3/8OZYWkdyZBqOJFO0jiQzajeVQwyqY09dVWlcs8Vy/w8ZHYIiC/c95Ts2VKxW7TdfC2yFODfaGW8oMrIlq+fjTlsY9ncWfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299486; c=relaxed/simple;
	bh=6f0dwVJGIEbqzR/ZYbyYLldBm2WesUmnI1Bpxd7kvqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0fLUW5JvoneIIVWVyT6DOmILBdItek+0D70MoIq9sKkqxvX6sxulhWB98KbPJW9sawL4NYs+onVfak71AcCqvLY1cZwMRS90hexxzrVuYyS8Qxpt9+sHh0F3wYWvVJXKDpOlYS26tZ5ZzUIXcjxawlfHgGozC46S1IuENLM06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gt6wDJ/N; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gt6wDJ/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gx
	hVj8DLM/GTViv+vM9MIYmd+lg23f6GIVVMOIIJhGk=; b=Gt6wDJ/Ny7m29pFZeL
	hV5FC59ss/da7yDh/Bor5TrENisWPLKiQ5AptEtqbiVFpY8CpDtznnlZTNJvLN+l
	TmDVJiI1kVCbMAaXQ67fPGprDbDoafrbMA1M4S7qdbS3DXnHQ0Fa9zJUoe6EF0Dw
	WVOirWCBsqtp9P7Vru9+ATeXE=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC34ubFNh1q2s8PAw--.55371S2;
	Mon, 01 Jun 2026 15:37:43 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Mon,  1 Jun 2026 15:37:35 +0800
Message-ID: <20260601073735.73376-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC34ubFNh1q2s8PAw--.55371S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15Gr4DWFWUtF1ruFWDCFg_yoW8Cw4xpr
	48Ka4F9a10qr4vqanrJa4UJFW5W3W2q393ur9rCa4SvF4Dt345tF45XFyagFyUArWxGF4Y
	yw1Yvw1vva4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE_-PUUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7AegaWodNscXkwAA3g

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 9d724b34fbe13b71865ad0906a4be97571f19cf5 ]

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
---
 drivers/net/ethernet/ti/cpsw_new.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 1f98044b3666..64f527ba9a47 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1442,7 +1442,8 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		if (!cpsw->slaves[i].ndev ||
+		    cpsw->slaves[i].ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		unregister_netdev(cpsw->slaves[i].ndev);
@@ -1462,7 +1463,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
-- 
2.43.0

