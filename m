Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259438;
	b=FkUzTpWqKRRqnFrvAc8f5SEnvvirbTrTuLBmpPHCRqprLM94dfBB4JKkuOrTvYwD2eu6
	 vO1JfaiC2HEvy5s34JpesBrKnkSJpH2UG0s/lLdDWwFFfsiYdLlS0QY+w5T9Z0HiQjRFP
	 ebt4ukc/c4YgYckmbRNE42+eYvp0ZNb8tjRPyjut2YY5VNgsyi6bAA8EKNgEL9J/ok0HE
	 QRHO/FKVdUkw1nj18aux0WY23uaGiaHsQFChsx7Mv+KwNSuBahZPgkWwbXu4biiIKkNZY
	 xNvF/SP6LP6k9oYoXaUJ1NI2oUMEBRnW9TFll8gGlQhCyl2GIXT4VBELqLCqSE9fi5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259438;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Ys3XKvaPTyX1fHC0lV0pst+tfGk0hnlCs8SXas4gV8I=;
	b=hVTXgMpTh/zWRKSQm4aizydqmOaqqNJydEVorCXqHFJ0LOyXqvrW28pjkO/DM4eYmirB
	 IHobbs8ycjyRHYC8Reei8J8A0brJYEoQGcwQ3KWhxQspO6Irib91sFlYds9Q5FaCxaqku
	 oO8pGMZtM2coKqgUPKZDux1D15pbWd3dGbAJBxysGHNytdYLVVokj2+2H1qauFSTZD8Nm
	 UEynlGJwSnJDdgeJripGvJEsMJnDgBiQW/V8IrEBO2Io49QzRPbU0WQadG1z8xcIfRjtT
	 7DI2FaPB4OGfNgbmuNBzJNALeVLVpCAxme4zC8kvPJfDsvXVZnFa4TZ+jA9cjVOqQNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=h-partners.com;
	spf=pass smtp.mailfrom=h-partners.com;
	dkim=pass header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=abr1Sa2Z;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437D606A320;
	Sat, 21 Nov 2026 11:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4437D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=abr1Sa2Z
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ys3XKvaPTyX1fHC0lV0pst+tfGk0hnlCs8SXas4gV8I=;
	b=abr1Sa2ZDCOp+djgHKJwfTXizfPE4F8N0k1zXffDKOkRf8YayZhTlvrm8f5MIOE3k2rIO3eYF
	JDE9OahmcFTufkhbCCmcHVStpNSkEtAclvCsU/7RBP25SIAdQa/lC5NquWyD+I/GbwL05XTOLxz
	KegOQ86fmTMfoewnFN3On0g=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jWqHN2M3Vz1prKM;
	Sat, 21 Nov 2026 19:10:08 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 10F8540579;
	Sat, 21 Nov 2026 19:10:23 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100001.china.huawei.com
 (7.202.195.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 21 Nov
 2026 19:10:13 +0800
From: xietangxin <xietangxin@h-partners.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
CC: Dmytro Linkin <dlinkin@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>, Jiri
 Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com>,
	<gaoxingwang1@huawei.com>, <huyizhen2@huawei.com>, Xuanqiang Luo
	<xuanqiang.luo@linux.dev>
Subject: [PATCH net v2] netdevsim: fix rate node leak during reload and removal
Date: Sat, 21 Nov 2026 19:08:58 +0800
Message-ID: <20261121110858.1337003-1-xietangxin@h-partners.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

The rate nodes are also left behind on the devlink reload path, where
they trigger the WARN in devlink_reload_reinit_sanity_check() instead:

  WARNING: net/devlink/dev.c:437 at devlink_reload_reinit_sanity_check+0x110/0x148, CPU#3: devlink/5205
  Modules linked in: netdevsim ...
  CPU: 3 UID: 0 PID: 5205 Comm: devlink Not tainted 7.4.0-rc3+ #77 PREEMPTLAZY
  Call trace:
   devlink_reload_reinit_sanity_check+0x110/0x148 (P)
   devlink_reload+0x218/0x228
   devlink_nl_reload_doit+0x3dc/0x5b4
   ...

Evaluate the eswitch mode check unconditionally, so rate nodes are
destroyed whether or not any VF was ever configured. Note this also
resets a zero-VF switchdev device back to legacy mode on reload, like
the existing VF case.

Reproduce by:
  $ echo "10 1" > /sys/bus/netdevsim/new_device
  $ devlink dev eswitch set netdevsim/netdevsim10 mode switchdev
  $ devlink port function rate add netdevsim/netdevsim10/n1
  $ echo 10 > /sys/bus/netdevsim/del_device

Replacing the last step with "devlink dev reload netdevsim/netdevsim10"
hits the devlink_reload_reinit_sanity_check() WARN instead.

Fixes: 885226f5680e ("netdevsim: Implement support for devlink rate nodes")
Cc: stable@vger.kernel.org
Reported-by: syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6af9824c.920b2b3a.148c65.0009.GAE@google.com/
Reported-by: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Link: https://lore.kernel.org/all/17cc4251-04ae-41a7-a872-fc5cf525b58f@linux.dev/
Signed-off-by: xietangxin <xietangxin@h-partners.com>
---
v2: add reload path description
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

