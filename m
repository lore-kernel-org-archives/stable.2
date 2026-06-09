Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618F3FE35A;
	Tue,  9 Jun 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024527; cv=none; b=PVHI6MSO/0HOerRw/A2LZA+NvjrDArNhOiOxwtOgIXBrCFrXjDsohlJIZpjuMO7nvitZh+mEqNbuM2/32xrZvKcbvqs8WNOA/R1ZPQyzYAnt9Wav6iH4SLaCpYVYcq/sYbjYUzn75g3YKhoUomdpBeE4jwjkxq3W0NFOWNzKWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024527; c=relaxed/simple;
	bh=VlT2GQMtF09lMcl1qD1/OfmoD7I5vnZUKdTaawBzjGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QT/68BNoYlSfw9++8Q3tqW1dS7LDDWxIYWupHpSsuiiLZvx1z6VqkLj+gnerAu4qB4sIbVbT0CGsqN1KgZ0PZqdcuWxKyqRM57a66B4VeoZj5AcebXbBmD0rtEkgi/CrUQ1Whyv8MkKk0UF1lA+/KcquSnbTvPFWdiWMKEr63Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=m/OVoJhq; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="m/OVoJhq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781024519;
	bh=VlT2GQMtF09lMcl1qD1/OfmoD7I5vnZUKdTaawBzjGM=;
	h=From:To:Cc:Subject:Date:From;
	b=m/OVoJhqsTfi/TSwAIck8cWNLWIPxKsJqTlE+znqMrZYI3PVXba8iNtUWsxLE3u5G
	 g5sTOta1vnyPHxwlD7ug6u/NfltyuMQTvaF6WjDrE2H+emL2pGph5sScQ40GJuSBJ5
	 h6rOKtrVzfg86KyN9f8Qujalf/aIGhzwbuMGgIs1acziybrDeF5QvxqaHQC7fqUGkB
	 4MYWUw2wXFMk+m7E/1P2dEZYAXY40a4CFEAL6NwwMS8+a63RYFtTvxpf9YL6/aT5AZ
	 9IpWrmgRaivKpevhCYHJ2HFayRpkFQXAHKFb/TCGDcmeSueB69hyCK9vXX+HTGBBUr
	 UtC9K3kYxSJOA==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id F39BA1FA76;
	Tue,  9 Jun 2026 20:01:58 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP;
	Tue,  9 Jun 2026 20:01:56 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.198.18.49])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gZZc83NQ2z2xd5;
	Tue, 09 Jun 2026 19:48:40 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Veaceslav Falico <vfalico@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	lvc-project@linuxtesting.org,
	syzbot+9c081b17773615f24672@syzkaller.appspotmail.com
Subject: [PATCH 5.10] bonding: limit BOND_MODE_8023AD to Ethernet devices
Date: Tue,  9 Jun 2026 19:48:35 +0300
Message-Id: <20260609164835.32573-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/06/09 15:41:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 107 0.3.107 575e75fe8e3b9d45c142d144823c5de38605099e, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203763 [Jun 09 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/09 15:23:00 #28224840
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/06/09 15:41:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Eric Dumazet <edumazet@google.com>

commit c84fcb79e5dbde0b8d5aeeaf04282d2149aebcf6 upstream.

BOND_MODE_8023AD makes sense for ARPHRD_ETHER only.

syzbot reported:

 BUG: KASAN: global-out-of-bounds in __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
 BUG: KASAN: global-out-of-bounds in __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
Read of size 16 at addr ffffffff8bf94040 by task syz.1.3580/19497

CPU: 1 UID: 0 PID: 19497 Comm: syz.1.3580 Tainted: G             L      syzkaller #0 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0xca/0x240 mm/kasan/report.c:482
  kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
  __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
  __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
  __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
  __dev_mc_add net/core/dev_addr_lists.c:868 [inline]
  dev_mc_add+0xa1/0x120 net/core/dev_addr_lists.c:886
  bond_enslave+0x2b8b/0x3ac0 drivers/net/bonding/bond_main.c:2180
  do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2963
  do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3165
  rtnl_changelink net/core/rtnetlink.c:3776 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
  rtnl_newlink+0x161c/0x1c90 net/core/rtnetlink.c:4072
  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg+0x21c/0x270 net/socket.c:742
  ____sys_sendmsg+0x505/0x820 net/socket.c:2592
  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2646
  __sys_sendmsg+0x164/0x220 net/socket.c:2678
  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
  __do_fast_syscall_32+0x1dc/0x560 arch/x86/entry/syscall_32.c:307
  do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
 </TASK>

The buggy address belongs to the variable:
 lacpdu_mcast_addr+0x0/0x40

Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
Reported-by: syzbot+9c081b17773615f24672@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6966946b.a70a0220.245e30.0002.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Link: https://patch.msgid.link/20260113191201.3970737-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Alexey: Replace SLAVE_NL_ERR() with NL_SET_ERR_MSG() and slave_err()
  because SLAVE_NL_ERR() is not present in linux-5.10.y. ]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Backport fix for CVE-2026-23099
 drivers/net/bonding/bond_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 812e1792c232..86f0f155e986 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1763,6 +1763,13 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	 */
 	if (!bond_has_slaves(bond)) {
 		if (bond_dev->type != slave_dev->type) {
+			if (slave_dev->type != ARPHRD_ETHER &&
+			    BOND_MODE(bond) == BOND_MODE_8023AD) {
+				NL_SET_ERR_MSG(extack, "8023AD mode requires Ethernet devices");
+				slave_err(bond_dev, slave_dev,
+					  "Error: 8023AD mode requires Ethernet devices\n");
+				return -EINVAL;
+			}
 			slave_dbg(bond_dev, slave_dev, "change device type from %d to %d\n",
 				  bond_dev->type, slave_dev->type);
 
-- 
2.47.3
