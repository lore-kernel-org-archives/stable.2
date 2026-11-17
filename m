Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897234;
	b=I0Czt8keAVQQ2du+XYBySfYyzZbD2EbQv43ErnorBO+T/Lz1h16FB4TV1JnpctQXlzMG
	 9+NfY60/w9nH+FDaq+XzZ5VsMi4tjyHdLCFgQG1vVIdEvPqnQGTxgKy3vukTjBLrUax8Q
	 RIiS7IsTQA5ag/icecKU0M4DXD/KbH/6+ZvIQQbzzPdHFF6yGnIFlfd+1J3QlZrtVYAGQ
	 pgKslenbQiQPepDSig7NDuXmT2qPWz0KsmC9JtlVVRlDCRPBejPQjyPcHscQCE12ygNZb
	 P02L7L5JpqHtDPyggHmGrcafz4+rP8Lq0OMATQqtS/HCzhVloIPvCpRBsmaVyaXwJ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897234;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=YnlME4NSWr73vdj2f9LnC+6k0GH5g2x5meC+XPL1Jh0=;
	b=bLF2+wQVsbEE/ROh7UCAhjR4FdrPsV9cb+hPu1zxLcBYHEGExm5pkWLhMJtBxBJqeDQ0
	 hh6n88ECW15d1SlndTdYXp8+TMoNCqVi2VG7Q/alcST325NVC68hXL4BJP9207YBV5BRx
	 pXPw2/HRPdCt2qNO5a6qdqWrubCHAgvERLS9gLHWdHw7Ov8fuXBSctC1UTZIFjPI3sGVm
	 4eaIGVK58m1J9dhKS36a/HfcJ1flm0aAAJ7A8Di1SfIT0UjAb1dMnZmIS68GEyL0uWLB2
	 1pfowIgx9bdu6XJVuu7ZhjehKPAuksc5f7MpgNFUz0kJCOTp22tFkBLH01NCIuJOcpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=h-partners.com;
	spf=pass smtp.mailfrom=h-partners.com;
	dkim=pass header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=jj515hhJ;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B977606A31C;
	Tue, 17 Nov 2026 06:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B977606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=jj515hhJ
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YnlME4NSWr73vdj2f9LnC+6k0GH5g2x5meC+XPL1Jh0=;
	b=jj515hhJ40QLAjkq/K9reOZ6Y0vUHq5koxh7CMRJfcIS8EkJi/6YFWWN2ABZHNHgom4u0t9S2
	KKfL6OYLWEAPHKN9Ed6XgAEuE04EeSy8Qx9IVWPJuVv4hRfLf15s0+l87hZ+47nIo/cIR7fgrUT
	VD/6G/NgzWNFu+drDxawiII=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jTFKL3G4VzcbPw;
	Tue, 17 Nov 2026 14:32:54 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id F07E040684;
	Tue, 17 Nov 2026 14:33:44 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100001.china.huawei.com
 (7.202.195.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 14:33:44 +0800
From: xietangxin <xietangxin@h-partners.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
CC: Dmytro Linkin <dlinkin@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>, Jiri
 Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com>,
	<gaoxingwang1@huawei.com>, <huyizhen2@huawei.com>
Subject: [PATCH net] netdevsim: fix devlink rate node leak on devlink_free()
Date: Tue, 17 Nov 2026 14:32:37 +0800
Message-ID: <20261117063237.865953-1-xietangxin@h-partners.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100001.china.huawei.com (7.202.195.168)

netdevsim allows switching the eswitch mode to switchdev with zero VFs
and creating rate nodes on such a device. However during device teardown
nsim_dev_reload_destroy() only drops the eswitch back to legacy when VFs
were configured, so the rate nodes are never destroyed and trigger the
WARN_ON(devlink_rates_check()) in devlink_free():

  WARNING: net/devlink/core.c:544 at devlink_free+0x18c/0x26c, CPU#2: bash/5032
  Modules linked in: netdevsim ...
  CPU: 2 UID: 0 PID: 5032 Comm: bash Not tainted 7.4.0-rc3+ #77 PREEMPTLAZY
  Call trace:
   devlink_free+0x18c/0x26c (P)
   nsim_drv_remove+0x9c/0xb4 [netdevsim]
   nsim_bus_remove+0x10/0x1c [netdevsim]
   del_device_store+0x110/0x190 [netdevsim]
   ...

Evaluate the eswitch mode check unconditionally, so rate nodes are
destroyed whether or not any VF was ever configured.

Reproduce by:
  $ echo "10 1" > /sys/bus/netdevsim/new_device
  $ devlink dev eswitch set netdevsim/netdevsim10 mode switchdev
  $ devlink port function rate add netdevsim/netdevsim10/n1
  $ echo 10 > /sys/bus/netdevsim/del_device

Fixes: 885226f5680e ("netdevsim: Implement support for devlink rate nodes")
Cc: stable@vger.kernel.org
Reported-by: syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6af9824c.920b2b3a.148c65.0009.GAE@google.com/
Signed-off-by: xietangxin <xietangxin@h-partners.com>
---
 drivers/net/netdevsim/dev.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index c6b17b387327..b483c25dfecd 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1700,11 +1700,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
 		return;
 	debugfs_remove(nsim_dev->take_snapshot);
 
-	if (nsim_dev_get_vfs(nsim_dev)) {
+	if (nsim_dev_get_vfs(nsim_dev))
 		nsim_bus_dev_set_vfs(nsim_dev->nsim_bus_dev, 0);
-		if (nsim_esw_mode_is_switchdev(nsim_dev))
-			nsim_esw_legacy_enable(nsim_dev, NULL);
-	}
+	if (nsim_esw_mode_is_switchdev(nsim_dev))
+		nsim_esw_legacy_enable(nsim_dev, NULL);
 
 	nsim_dev_port_del_all(nsim_dev);
 	nsim_dev_hwstats_exit(nsim_dev);
-- 
2.43.0

