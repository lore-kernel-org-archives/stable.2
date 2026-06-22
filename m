Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C193546CB;
	Mon, 22 Jun 2026 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102692; cv=none; b=Bw4FNoZ2fAX+xVvWPv9MMffUMiJhc7t6Colb6djtcslxbgSrKHD9GjV6MDfD0KzDReUcrvSxygt9WkYMI2oBq6lTFKHZSmllrGrw3yCThE1nYVbB3UCPepE3+0YMC2w5T+/E8p7J06BF/7aWpunBZsRp3/jXmeVFig2u/9lGoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102692; c=relaxed/simple;
	bh=gIYb69HD0o/bJNkcYN9E8bcbAWHVNd+48z8UGWhoTUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Esk6JsMHgZ/RxEk1242KofaUZk4y2vCtkp8+DfVotH+MCHhF23yLLfwD10XENzNG1OKWCUUHe7uML5Vb9gCa2GJQBkDwlu2GnnE19lYW+7LQlt0gJO9sW33G/wdPmCskPhOQFMegoYgd0afRdvz2G1FDHaHkLzDmGAIp6O/TglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f1nHMOCi; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f1nHMOCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+4
	kKS6YbqvXGesLSVmWh/l08m/IHxwWlJ+sqDAtc6CE=; b=f1nHMOCiBxzxEfyJJi
	aOrE4z/kR0g3YkYGMFiwNmVCd0u6s4O1fK/wXhYGDjjwnZxQz/ZSYudNq03JQ6tv
	CpjqkrDKI1SZKxJvt4naOFBDi5/0Vgx0uuzAAcV0eTKb64FPnsfD+5/RRjzmLyPD
	mAo9iOM4Sams5mP8Y8YfFNCTY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHz8xYujhq80jwEw--.53742S2;
	Mon, 22 Jun 2026 12:30:18 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: linusw@kernel.org,
	kaloz@openwrt.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	huangguangbin2@huawei.com,
	lipeng321@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: ixp4xx_hss: fix duplicate HDLC netdev allocation
Date: Mon, 22 Jun 2026 12:30:15 +0800
Message-Id: <20260622043015.643637-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHz8xYujhq80jwEw--.53742S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4rWF4ktFWDCF1rJw43Wrg_yoW8ArW8pa
	n8Ka4fKF95W3W3JwnrWF48uFy5Gw48JryUC34jq3sY9345JF1Fk3s5WFy2vFyUCrZxXF4a
	vr43AFZ2vayfZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRlPfPUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxhpt22o4ulrK-AAA3u

ixp4xx_hss_probe() allocates two HDLC netdevs. The first one is stored
in ndev, initialized, and registered with register_hdlc_device(). The
second one is stored in port->netdev and later used by the remove path
for unregister_hdlc_device() and free_netdev().

This means that the registered netdev is not the same object that is
unregistered and freed on remove. It also leaks the first allocation if
the second alloc_hdlcdev() call fails, and the first allocation is not
checked before ndev is used.

Older code allocated the HDLC netdev only once and stored the same object
in both the local variable and port->netdev. The buggy conversion split
this into two alloc_hdlcdev() calls. A later rename changed the local
variable name to ndev, but the underlying mismatch remained.

Fix this by allocating the HDLC netdev only once and assigning the same
object to port->netdev.

Fixes: 99ebe65eb9c0 ("net: ixp4xx_hss: move out assignment in if condition")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/wan/ixp4xx_hss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 720c5dc889ea..7f4645ff90aa 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1487,11 +1487,11 @@ static int ixp4xx_hss_probe(struct platform_device *pdev)
 				     "unable to get CLK internal GPIO\n");
 
 	ndev = alloc_hdlcdev(port);
-	port->netdev = alloc_hdlcdev(port);
-	if (!port->netdev) {
+	if (!ndev) {
 		err = -ENOMEM;
 		goto err_plat;
 	}
+	port->netdev = ndev;
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	hdlc = dev_to_hdlc(ndev);
-- 
2.25.1

