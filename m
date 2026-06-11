Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA70176FB1
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189219; cv=none; b=qD/w9Pb57MjvFSSAHuH5tPSznPaohr923YoEC75RG9UhD/skq8bzaiS3jDQh6Egkg3wmlsp5s+rUYvwYU5IVkf2eDen6nAbc5Ryqu9Hs89vzjF/Ta/OUmWJLgWrvPG1DSuDBsWZm7jVKcb3DfOASdrdVrNZBy8HESBykk9Tov3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189219; c=relaxed/simple;
	bh=g6bROWU/w+beWWhMI/E8y0Zj2Vltr07b8bQTQCHGSxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pt0Xrs0AQQ2nLqEUNj/91zF+c6EoAQKzS2TCcqyTY/PzrSRK1YBSF4+YPlNVjOelaLtc8XZiKloFXjOEukAmOyeQ5hwXufxa9HntqkzmYm9jAAkrk579xpuDd2CFadLU+/0bfHvQUi460G8xB0LVp9IEbqFyCWjH8WkhyLuV6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=j1Cc6G41; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="j1Cc6G41"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=BLq8QwBnW6aRyonTh8EpUWUPio44/d/QCVz8r1i2VV0=; b=j1Cc6G41ExU2Pxbr51wNtc9FNd
	UswJZCWltiL84O/ak+OER4nNjQDK2Nc7g1l00lR/A10a8S2f4MoRVPFtuh7W06zL8tahSk12yTvdv
	eZM0xSOKAErKUaSihtSDOupO+6MhpVFerHFebosGCw/S3s615trnSevuJxB8G9Irhjd9Q3yYnyb18
	ArqcyE/vPtGaMALlnnCVD+Q+dK43XU/ya77PV7qn2XREuDQQGmEZdkAJP62I97VJy3N8YOuPEpEnG
	Cm0RnYSeZSLv70iI9JM4rtKND+2sOaazbuQ12rYyNpgLO0lIxL40X+aAnlvLe52KWgZRhEvPh7mQd
	RiEUrgWQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y] wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit
Date: Thu, 11 Jun 2026 16:46:15 +0200
Message-ID: <20260611144615.478035-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

[ Upstream commit 60a25ef8dacb3566b1a8c4de00572a498e2a3bf9 ]

wg_netns_pre_exit() manually acquires rtnl_lock() inside the
pernet .pre_exit callback.  This causes a hung task when another
thread holds rtnl_mutex - the cleanup_net workqueue (or the
setup_net failure rollback path) blocks indefinitely in
wg_netns_pre_exit() waiting to acquire the lock.

Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
Add ->exit_rtnl() hook to struct pernet_operations."), where the
framework already holds RTNL and batches all callbacks under a
single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
window.

The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
because all RCU readers of creating_net either use maybe_get_net()
- which returns NULL for a dying namespace with zero refcount - or
access net->user_ns which remains valid throughout the entire
ops_undo_list sequence.

Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=cb64c22a492202ca929e18262fdb8cb89e635c70
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[ Jason: added __net_exit and __read_mostly annotations that were missing. ]
Fixes: 900575aa33a3 ("wireguard: device: avoid circular netns references")
Cc: stable@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Link: https://patch.msgid.link/20260414153944.2742252-5-Jason@zx2c4.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/net/wireguard/device.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 45e9b908dbfb..055ea3877156 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -406,12 +406,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
 	.newlink		= wg_newlink,
 };
 
-static void wg_netns_pre_exit(struct net *net)
+static void __net_exit wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
 
-	rtnl_lock();
 	list_for_each_entry(wg, &device_list, device_list) {
 		if (rcu_access_pointer(wg->creating_net) == net) {
 			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
@@ -424,11 +423,10 @@ static void wg_netns_pre_exit(struct net *net)
 			mutex_unlock(&wg->device_update_lock);
 		}
 	}
-	rtnl_unlock();
 }
 
-static struct pernet_operations pernet_ops = {
-	.pre_exit = wg_netns_pre_exit
+static struct pernet_operations pernet_ops __read_mostly = {
+	.exit_rtnl = wg_netns_exit_rtnl
 };
 
 int __init wg_device_init(void)
-- 
2.53.0

