Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2922E6CB8;
	Fri, 19 Jun 2026 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861108; cv=none; b=bj9SEGJVqQz5xZUXb5P6KSDvDvkDoEHYlBtExA2lJHTJtas508Muw40fKU5DS0oJx/tZduf4qwFpPB/Y9WRGmeP0TNzM5KHoZeTUcQwJMO5+O/dv24OprhXsESedcZ74XM8/CwQyCgV/ugPqJlawKpDH2n403+WJicp32LaNEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861108; c=relaxed/simple;
	bh=NPdCIlVBxk6IZFlI3QELtBBymmuObA2TL9GfWuwRbW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tP0b2VCwjPzAsnm19oUGCT8ILCcCJd45IMRc5twhQHIt2DnX0fMgjMYyXK2FgNyux1rss9bdku3xD3Nl+xKhnV7ISl2O3qkmfx3PfT8pdldbR3m18MBQeo2kjzAKgPqH0uNI16Hwq4IZ0hCocNVe71jKxBa92NRHXgeuS3lZ2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=qjzf1dx1; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="qjzf1dx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781861094;
	bh=NPdCIlVBxk6IZFlI3QELtBBymmuObA2TL9GfWuwRbW4=;
	h=From:To:Cc:Subject:Date:From;
	b=qjzf1dx1H0321OrgxAFYySl6erG9WCivRQGSrwrgt040ly4g8Y3sf38SO2hRNFC22
	 00OYW14t7NEcCuN+xibH8S8Dv+e19ZjX8BCKDfTzlSUzQX+9Y17wQwqL/rtZ39J3OL
	 FcuN3Brj3z+BmyJbkGkTBYpxPG3keqvgnUYufj3vxfLzpz5dwHpSw51WZFxrJX/Ko8
	 xouYftgx1jUuLtbeWQZA/dqJLyMplXgOkFjbGsKZLFU9S+rOZC5EVdyhEUAHuddTHM
	 EYKORSQio/vAnDw3puBqTvRi1kql9tNsbJWLd1MG6mO+GGHmUweGpwuINOoMfgaqqW
	 sJa8vqv+/iUXg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 24EF01F96E;
	Fri, 19 Jun 2026 12:24:54 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 12:24:50 +0300 (MSK)
Received: from rbta-msk-lt-169874.astralinux.ru (unknown [10.198.51.153])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4ghXHQ0J2vzZdxN;
	Fri, 19 Jun 2026 12:24:49 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	lvc-project@linuxtesting.org,
	Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH 5.10] netdevsim: Fix memory leak of nsim_dev->fa_cookie
Date: Fri, 19 Jun 2026 12:15:06 +0300
Message-Id: <20260619091507.95142-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/06/19 08:52:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 108 0.3.108 b3af89ff4c48cefaff455d02ab4cd72c6de3312f, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203942 [Jun 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/19 05:29:00 #28253113
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/06/19 08:16:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Wang Yufen <wangyufen@huawei.com>

commit 064bc7312bd09a48798418663090be0c776183db upstream.

kmemleak reports this issue:

unreferenced object 0xffff8881bac872d0 (size 8):
  comm "sh", pid 58603, jiffies 4481524462 (age 68.065s)
  hex dump (first 8 bytes):
    04 00 00 00 de ad be ef                          ........
  backtrace:
    [<00000000c80b8577>] __kmalloc+0x49/0x150
    [<000000005292b8c6>] nsim_dev_trap_fa_cookie_write+0xc1/0x210 [netdevsim]
    [<0000000093d78e77>] full_proxy_write+0xf3/0x180
    [<000000005a662c16>] vfs_write+0x1c5/0xaf0
    [<000000007aabf84a>] ksys_write+0xed/0x1c0
    [<000000005f1d2e47>] do_syscall_64+0x3b/0x90
    [<000000006001c6ec>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

The issue occurs in the following scenarios:

nsim_dev_trap_fa_cookie_write()
  kmalloc() fa_cookie
  nsim_dev->fa_cookie = fa_cookie
..
nsim_drv_remove()

The fa_cookie allocked in nsim_dev_trap_fa_cookie_write() is not freed. To
fix, add kfree(nsim_dev->fa_cookie) to nsim_drv_remove().

Fixes: d3cbb907ae57 ("netdevsim: add ACL trap reporting cookie as a metadata")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Jiri Pirko <jiri@mellanox.com>
Link: https://lore.kernel.org/r/1668504625-14698-1-git-send-email-wangyufen@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The context change is due to the commit 5e388f3dc38c
("netdevsim: move vfconfig to nsim_dev") in v5.16
which is irrelevant to the logic of this patch. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2022-49803
 drivers/net/netdevsim/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index c8834ea84732..a106365ce485 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1173,6 +1173,7 @@ void nsim_dev_remove(struct nsim_bus_dev *nsim_bus_dev)
 				  ARRAY_SIZE(nsim_devlink_params));
 	devlink_unregister(devlink);
 	devlink_resources_unregister(devlink, NULL);
+	kfree(nsim_dev->fa_cookie);
 	devlink_free(devlink);
 }
 
-- 
2.47.3
