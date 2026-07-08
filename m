Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD2320A34
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504281; cv=none; b=XVbqdg4cBgW5WZt0E+/jZoY/eLeKMxi06fG9SgcwxaslaCN+CkGwxRnqVgMXvvNv9GRk9bq0/zzJotM82xgSHF/L8G+NlIOL4Z4MyAjEiCnJw1KmzcpHxhrQ3sfb4SJ5PD0cQwhrSPprOMVsa6DR+5gCv10Xw/wf/T7fGIP/h+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504281; c=relaxed/simple;
	bh=tcFFxbVsz/5xJZP4KgWa3Ywi+Q+PtPjrGKjFKx7lc74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rt2T4LMKV475Mqgkl3Z6Zi8zesH2RO5L3KBE7uxlZlpWcob9yggwbR/JR1oi9XpTsA16eUEUk/Vyhu/rx3LFoFlvb6VaYTED5UWzuQNysY8R7z87mOLB+EFVMLnP4MwWSq+ug+5H2hqZ7H+sgcDAFV2mHh9nlZS5bXF9Wu2nrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IXJSHjMe; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IXJSHjMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504219;
	bh=vaBIE3lDV52tX/pxDPiqfEDvp4m46XF+Lq3reB+4Y30=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IXJSHjMelvUYq3AEVUwa5cocu96oGGjn3xl8N0v1jlilgRCjpQbawiYRU+LIoWGq9
	 1KwfogUVksd+PYG3j4/m30AityDJ/Ugu/LKSaLNuyJg48jdil/xs6ehiI0nusnhpuR
	 1emyb9hK+DHIbWry4gs0+Nk/YkY1WSveIqhmEcMo=
X-QQ-mid: zesmtpgz3t1783504199ta8ef88b0
X-QQ-Originating-IP: 0TVue/5EKKmn28k9pNpzcEt/Cb2HIHQfCfM9wSWVarQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:49:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12264229583584005717
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 09/11] bonding: fix type confusion in bond_setup_by_slave()
Date: Wed,  8 Jul 2026 17:47:19 +0800
Message-Id: <20260708094710.27047-10-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NSegwrIO7C6EDawdX0G2WwuHWUwSr/N6W71yWlLUhzre2EVs9RIWaYdb
	5T8FBe4zfcT3NwyxWcT21gaEw9na1HF7b/37dvNI0ne2RhBLwwWN6K5usowNqgnwrXojO8r
	0BwDUFZJbL/gXZLSCaNYsj4YmXLNOtqq2cg+J3Xv91ouhJc0ToDsQ3hP2rXN9+/RzfHXJDy
	bjsNW+Mp8EEYfIGqvJhwpCUqHxqLpvhPIcOEA4NnhaTVuFOCjoC/1fSnTo+Y49VR7Sz03Ao
	1WJHzV1uQY8pyBM2qOamoMJXOmrO+qZJzDvm1Me2IoR4N3Ctvd1sxVv37dssFnQgqn2dp4O
	p/1luG+EHBTHFwUO551qbr1OitAF69fmzN0bb3Xelw0jmEbCHa1P88Z5KQq80z6Ew5D4/ru
	p+MD6l7qzbueVRcaoOjiY6eoC3pClW7naKaLJNJeA2FggezDcqkk5gydcNs7qW/e5Dzm5rZ
	8CVpxLR9ztcr0ymnx7PyKmXk5N1+z5JVqxRhUDReSpsz8bTBnf/zmucEzo6gtMkkQisuAer
	K6EzxtLEHhBpg7qA2i66USrwA8nXdtBRec+cHIxNbsH+yrxrM6qSaC6GWsXb9VqnXnCPTK4
	y7aJ8wS/DxbhYxupG62o4jN4pZNm5OxBQVzt12KsgwF8mCd2XzoS6EQjQlAHV5vgKuENqsP
	wZbLxhTTWkjGXdYkIU8vN57R8MaMm/MBpgD0/PzWvFDLfjMw6ustmUHLi4DZAwEcWbcqRUt
	Bd96XYFRBVMDubmXidY4mC/XOZ2XcsGvx/gYWJKYa6I5XOWBN6ozBTiTe9nUQbmHiDkzHOd
	xVXCDjYeBsEgBtrWkRxJ0jK0pT9okva20+I0DUaXJ3iDiK1Fp+shq26mCTajb9i4t11x8oi
	k+9o6oHsoHNrkrzJR/xo+FHsmam7YCrGO5e/fydAHwhjjTdo6nMTKYhFMdxq/v4NOKhu9xJ
	+Iimon8nYUSmDWg4FqJ86C9e94SBrr1V+ITCdgVxFJa2vEAa0iACCblFRZwqVUI/MmmxQEU
	+Cwp7ZHl6RYyU2pWOC9sueTgzhwsCq1IlPWWgCRNA4IsQBVClKdk0fC3lMqs0eKDuniDI7O
	gjMwGt5byD9z4BFlQp8VBh4PxJl5SWZ4MaLNYVB8m/UziWEdUGqUKpUsejmOWZ0JuSnRMho
	1kwAjUDEbvFODwY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit 950803f7254721c1c15858fbbfae3deaaeeecb11 ]

kernel BUG at net/core/skbuff.c:2306!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:pskb_expand_head+0xa08/0xfe0 net/core/skbuff.c:2306
RSP: 0018:ffffc90004aff760 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807e3c8780 RCX: ffffffff89593e0e
RDX: ffff88807b7c4900 RSI: ffffffff89594747 RDI: ffff88807b7c4900
RBP: 0000000000000820 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000961a63e0 R11: 0000000000000000 R12: ffff88807e3c8780
R13: 00000000961a6560 R14: dffffc0000000000 R15: 00000000961a63e0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe1a0ed8df0 CR3: 000000002d816000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ipgre_header+0xdd/0x540 net/ipv4/ip_gre.c:900
 dev_hard_header include/linux/netdevice.h:3439 [inline]
 packet_snd net/packet/af_packet.c:3028 [inline]
 packet_sendmsg+0x3ae5/0x53c0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa54/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
 __sys_sendmsg+0x170/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe1a0e6c1a9

When a non-Ethernet device (e.g. GRE tunnel) is enslaved to a bond,
bond_setup_by_slave() directly copies the slave's header_ops to the
bond device:

    bond_dev->header_ops = slave_dev->header_ops;

This causes a type confusion when dev_hard_header() is later called
on the bond device. Functions like ipgre_header(), ip6gre_header(),all use
netdev_priv(dev) to access their device-specific private data. When
called with the bond device, netdev_priv() returns the bond's private
data (struct bonding) instead of the expected type (e.g. struct
ip_tunnel), leading to garbage values being read and kernel crashes.

Fix this by introducing bond_header_ops with wrapper functions that
delegate to the active slave's header_ops using the slave's own
device. This ensures netdev_priv() in the slave's header functions
always receives the correct device.

The fix is placed in the bonding driver rather than individual device
drivers, as the root cause is bond blindly inheriting header_ops from
the slave without considering that these callbacks expect a specific
netdev_priv() layout.

The type confusion can be observed by adding a printk in
ipgre_header() and running the following commands:

    ip link add dummy0 type dummy
    ip addr add 10.0.0.1/24 dev dummy0
    ip link set dummy0 up
    ip link add gre1 type gre local 10.0.0.1
    ip link add bond1 type bond mode active-backup
    ip link set gre1 master bond1
    ip link set gre1 up
    ip link set bond1 up
    ip addr add fe80::1/64 dev bond1

Fixes: 1284cd3a2b74 ("bonding: two small fixes for IPoIB support")
Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Link: https://patch.msgid.link/20260306021508.222062-1-jiayuan.chen@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 9baf26a91565b7bb2b1d9f99aaf884a2b28c2f6d)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/bonding/bond_main.c | 47 ++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8c156f71c7066..af8cdc8d26c91 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1468,6 +1468,50 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
+static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
+			      unsigned short type, const void *daddr,
+			      const void *saddr, unsigned int len)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	const struct header_ops *slave_ops;
+	struct slave *slave;
+	int ret = 0;
+
+	rcu_read_lock();
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (slave) {
+		slave_ops = READ_ONCE(slave->dev->header_ops);
+		if (slave_ops && slave_ops->create)
+			ret = slave_ops->create(skb, slave->dev,
+						type, daddr, saddr, len);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+{
+	struct bonding *bond = netdev_priv(skb->dev);
+	const struct header_ops *slave_ops;
+	struct slave *slave;
+	int ret = 0;
+
+	rcu_read_lock();
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (slave) {
+		slave_ops = READ_ONCE(slave->dev->header_ops);
+		if (slave_ops && slave_ops->parse)
+			ret = slave_ops->parse(skb, haddr);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static const struct header_ops bond_header_ops = {
+	.create	= bond_header_create,
+	.parse	= bond_header_parse,
+};
+
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -1475,7 +1519,8 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	dev_close(bond_dev);
 
-	bond_dev->header_ops	    = slave_dev->header_ops;
+	bond_dev->header_ops	    = slave_dev->header_ops ?
+				      &bond_header_ops : NULL;
 
 	bond_dev->type		    = slave_dev->type;
 	bond_dev->hard_header_len   = slave_dev->hard_header_len;
-- 
2.30.2

