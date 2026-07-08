Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6731D757
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504230; cv=none; b=QGJVVf94cjXVt+eEbLOPzCVvwtVkoh+CVmpS2/8FWrrP+Pnp9e8zL5a+++t+N6jSxvbfAF2U/zw/qFhwZB0jLLWopWIfghyV3XGwkk0pjzzoAMboouM5XKLQEJdoQylkHTCdoGm80NpCcbY95lXL0UPEWG1CpTk06bs1YjzPAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504230; c=relaxed/simple;
	bh=wvhpOHWqq7MVni/QkoO+h3IQWg7oy2hjmRHMhH7PRPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYlXoTRCgxtJM+wNx8vmJJUO0TvycM5phtQI8dnYQNhM+Qk7Fl+Ha6QaNyZ4/ktTX5qHLkYHVLWo2niCk/8eIzFKl/issQgCDqXitv1XCpVAgK5CnJ6C3BSYNYrtGFrxi61s02Nk/OMr8kfZ8jXQWYZBveoWekZkmvOb/yRBkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=D6nyRvVp; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="D6nyRvVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504189;
	bh=zzCaLGI0qvCalvHjWbifgrSHeHiWep4X3s159hw0lIs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=D6nyRvVpHWjT/vyQWkE8at4ep8DXvUuWJ/dKmxKLgJE7pv7LMUVogfMf1DLcRqbZA
	 +ZMMxMSMWwsgbVjRPGFz7cPxcNmjN99uQ2o1RewQxbHldqlUxBl+owZbtgpv10mejd
	 v4JtD6u0eqkCsVrzsnQb6LuU76ykJfyuU59H3x0U=
X-QQ-mid: zesmtpgz3t1783504183t4d3628ba
X-QQ-Originating-IP: yAEl3bDBkeh72eNUMcyG1x1kAvVUGiQfOqvsJkCNHnI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:49:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14071937880604546317
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 08/11] bonding: fix xfrm offload feature setup on active-backup mode
Date: Wed,  8 Jul 2026 17:47:17 +0800
Message-Id: <20260708094710.27047-9-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MDSqlvH8sYTtuZTZcnr+HJWiyR+sxp+TgJzsL/x2vMh6jzJTrhkegpZ2
	inKU1jJRWL0uwt2jB71eqVtcsvkhdcuoXpIU8PgBEz7FVAqz2AeRhPtUHTbslsSCTKXXyzY
	VI6gCD8kKK0gu+D2hG5PqFYZxlZ7J0nU2F3feP42VTpaq9lRPHFVPCmr5qfXKRR05apwN44
	fqZL3ulE9WuEOJjyErqigMuengJOCclW54D5AzbZ3uW4uzhvrsbvJHHCU/SrvsceoFDZMO6
	g2fVQ3u8qFgH7joalkBLVXVIp29QijpCmAhBFPhQIb9hX23GthcJY2/ml11z3+1KxaZWNev
	6CbKKJRAjvFKybQZYJ3xPKQQcSV7lfUWTyHbwwxMyIPTW8J/BgGO9CSrnAdB0HntYOg3s5a
	BcxqAMT8ge5I3Zu2OsZi0K8ntR0YPbKwOD+kIsQtDVbVp3GuzgJFrTAB/feTweGrgx2VhX/
	og848FV4a+ac3ykBZmZ3qwX35lTWOyLzd8NcphkO4OKHvrpJMRl37QN1qmBbdP3Qe1a25kr
	vqpWjqWHsjpqIfh4X2PvVIo4j+fqG88anS1BD+6pO9ZZQt61OYj9thshJXzvM+RwAmTbTmi
	FdnA6YRr3hs/dYzMmcoPYxKU0KsZjrjPnx0HxFR4vxW1npqzTRIKvtSae9kF7XCcss0OZ3L
	zH4XVAvmwbCJJ1mif5ejT3WfU/6qmfpTqwtH3UCzQ9pZBOahwzNkfnwhUVD09s3MWpWYt4Z
	tGaVlsM58PeVS4E1MbSrYYHXUXZ6gVwxu3nbqTKUiTH+yk2zEmqrXJm7GkdIl8TG+PYId0+
	Gvsgrx5EQVpAXSI4UhvR0oFhMqUQ54LcDqwHUZb8q/edM/ZRJSmqn+HDh7SWzYftATLyqfc
	v1ikEGNS6XX8suwJzqbNxN+hFkg+nS3Zuh25KFkRQBpKh9hZiy80PocpPE+fp+NElp6s4QN
	qVSuAlmQzaeooDcaI/D3toQ8MNqFquBBThcxFnjgZki/0L3TG1pr82aRlAZ3fGAgjwLwJt8
	oZComYuBsf7LTe4kvO392BYqlbu6C2bzUr0ZscZlswlANKsAuOemQQONZWgsoA+obowR1Rh
	fvA+bVkvWm4befSzprU+1u4CLbM2qRcaR9g2UbaGx+JMFMVVUUw4uvpFGUNsVx/YMhHKVIk
	DHwe
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Hangbin Liu <liuhangbin@gmail.com>

The active-backup bonding mode supports XFRM ESP offload. However, when
a bond is added using command like `ip link add bond0 type bond mode 1
miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
disabled. This occurs because, in bond_newlink(), we change bond link
first and register bond device later. So the XFRM feature update in
bond_option_mode_set() is not called as the bond device is not yet
registered, leading to the offload feature not being set successfully.

To resolve this issue, we can modify the code order in bond_newlink() to
ensure that the bond device is registered first before changing the bond
link parameters. This change will allow the XFRM ESP offload feature to be
correctly enabled.

Fixes: 007ab5345545 ("bonding: fix feature flag setting at init time")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20250925023304.472186-1-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Conflicts:
	drivers/net/bonding/bond_netlink.c
(cherry picked from commit 5b66169f6be4847008c0aea50885ff0632151479)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/bonding/bond_netlink.c | 16 +++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4f2c03f52a310..8c156f71c7066 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4260,7 +4260,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 0eaf4b0e06ffb..f771d569524f3 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -596,18 +596,20 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	int err;
 
-	err = bond_changelink(bond_dev, tb, data, extack);
-	if (err < 0)
+	err = register_netdevice(bond_dev);
+	if (err)
 		return err;
 
-	err = register_netdevice(bond_dev);
-	if (!err) {
-		struct bonding *bond = netdev_priv(bond_dev);
+	netif_carrier_off(bond_dev);
+	bond_work_init_all(bond);
 
-		netif_carrier_off(bond_dev);
-		bond_work_init_all(bond);
+	err = bond_changelink(bond_dev, tb, data, extack);
+	if (err) {
+		bond_work_cancel_all(bond);
+		unregister_netdevice(bond_dev);
 	}
 
 	return err;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 0d9c1eb40d12b..8f5507ef5c0da 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -713,6 +713,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.30.2

