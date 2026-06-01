Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7912571A9;
	Mon,  1 Jun 2026 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299505; cv=none; b=HmYyDUQXQshZ+PRl/RAofeRllQNJmG9VIILQu7/oDKWQ0lA19WadPyWNsp5RPISMt5wUL6pw82MmBv8Vp2uZ7arR6T6aC3tLp9PIUeEXnkb4tBZXV++NJkAwhWANQo4n7i77ilpSipjmUx21KTOEntU3TQrxIvv07w0heb17+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299505; c=relaxed/simple;
	bh=2YE2wZOllCBIEKpAf/uC5durFePtRL+ejaci32+1IWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CP1Zfzqtcdet19xEMsivFUmRkXsD+OO7ZUOfctXZtRyFDmCJGGd/g6ZOJVnPnowgPXfdlWIQHqMzkGNnSW9qlxrCmC7Es5mdoLQkYk1NWxjO7oGFs65POLSeBTGdydlvagtxH4VHWHHbCIpZGvd+XZ4a/P9uZPQthpi8BFJf1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hb8Rjc1x; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hb8Rjc1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bn
	bP9kJmQts+3i4uAyu6Sx/r3PJOOQ+PzeiLONN5+XI=; b=Hb8Rjc1xLR8mqRAPdg
	lnepEcO3h7Z+gVOVvgot3k27DCkStVBGXrotI4jwNUUyuSfJGa6+Z/zEIumdp70A
	7Y9DNn0M3BMbzJxlMj/xY3+yxoMVv3BEal3+djlReQ3/fOo9cWrgakaVZdqCXxap
	s7qa6r8aN+7fgg4KezEw//Dxc=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAXH8zWNh1q+tkPAw--.54045S2;
	Mon, 01 Jun 2026 15:38:00 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Mon,  1 Jun 2026 15:37:56 +0800
Message-ID: <20260601073756.73404-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXH8zWNh1q+tkPAw--.54045S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15Gr4DWFWUtF1ruFWDCFg_yoW8Cw4xpr
	4rKa4S9a1vqr4kXwsrJa4UJFW5W3W2q3s3ur9rCa4SvF4qy345tF1DXFyagFy5ArWxGF4Y
	yw1avw1vva4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pij-e5UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7BilbmodNtgZoQAA3e

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
index c99dde9dbe77..17c267f6d79a 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1437,7 +1437,8 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		if (!cpsw->slaves[i].ndev ||
+		    cpsw->slaves[i].ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		unregister_netdev(cpsw->slaves[i].ndev);
@@ -1457,7 +1458,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
-- 
2.43.0

