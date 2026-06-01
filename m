Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D4386562;
	Mon,  1 Jun 2026 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299470; cv=none; b=gw43LAn44tjZKcr28kjxcNx+T1Q0DpxPaHasFF1L9lassml3eEDMg3oDeK+eDjTVHSol6Vgp/Dhjlu+NBoqawt+sW+OPVZbFKrrYtdg0ucrawM1fzo73JRJu6DkzICqYlzaW9J9ocUqGjowsgS4xDPuA6tt3o6Dm/YFnxBxn7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299470; c=relaxed/simple;
	bh=Ek5wNeDlKunRjqC/tClcZ3RLaBRyYn1c+CHkgJJhjqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edG8KY4Eu+Q9KhRY75THnd4F5JIh6ujXhgMwi1vOCTAv9F192aIp+8fEYR57hmcOPNnlv2Z0QFvp7MKk6aMLySVfe8f/K5KlMiTlT7EpfS7Hwp4SYc6RtQ6CeqCPRZxQllA3M0xRU7OyOd+PPx8zwErBckRj7rH1ZAKpmy8VBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aEFePCCJ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aEFePCCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=a/
	Zs5f5xEHSrlBtGPZN2d57ff2u+NC9NESUkRBygjqI=; b=aEFePCCJQsn37OZJ19
	ZlvbRhk1UoyOswMGhgU+r088MLad7Y8CNWQqI6vebXEIpHHV/YZg0I8BnZvBcr1r
	0/o3/PO+THRB+RE0iR61vBoTVK4cepQCHio0bxpAY6twYbf7wMcRJ9hCX5EcdCVY
	6yK/EzjXSymOk8CYCsQZcJd90=
Received: from China-163-team (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHeqCsNh1qQDrnFg--.47777S2;
	Mon, 01 Jun 2026 15:37:22 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Mon,  1 Jun 2026 15:37:08 +0800
Message-ID: <20260601073708.73350-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHeqCsNh1qQDrnFg--.47777S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15Gr4DWFWUtF1ruFWDCFg_yoW8Cw4xpr
	48Ka4S9a10qr4vqwsrJa4UJFW5W3W2q3sxur9rCa4SvF4Dt345tF15XFyagFy5ArWxCFWY
	yw1Yvw1vva4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWrW7UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7BScZWodNrQVRwAA3m

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
index a74caaca94d1..fa161a109604 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1443,7 +1443,8 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		if (!cpsw->slaves[i].ndev ||
+		    cpsw->slaves[i].ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		unregister_netdev(cpsw->slaves[i].ndev);
@@ -1463,7 +1464,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
-- 
2.43.0

