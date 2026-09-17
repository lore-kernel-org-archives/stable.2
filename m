Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF43644B3
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607607; cv=none; b=RbyTxkCUS+hQ2QtgTZ4XeSpx+1eVGW6qDlEXE8rNE8EIpLCzQ9Lr0ZpZlK/8d+Rg84nvZSTsB1P8zbk1GY8DR6XXoYkZx0+cRd83KswrJFcHAKlky7UNzMUyg/3quIEMyCxjUdYpx5Lf3s3s1fm/YKYa42EDfIs5wLqRKzMi2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607607; c=relaxed/simple;
	bh=OcbcXIIH3ynNM9UVN9tH1sfJLUj5V7wQUeCIpRDMRXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnRvFVBAZiYyCkGWw2jOy34JE1ZdlKoplqe8Mzhc6TQxklpaAdS//NGYEpDhyK30WoH5GOScvQur8NSFbi0m5fWs92GIjXbH5aa1AHV+qL0MpXdydPWAzpoq6DnDG60UwLbwwfyXXvXhCwe6BhSjN7aJPohGq0fYIggyTwx1+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HidDjegL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HidDjegL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4301F0089B;
	Thu, 17 Sep 2026 01:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607602;
	bh=2jIrXc/UPfexJFOQXnwlgHsDqxmWyLCT5nR7OszkQX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HidDjegLcJbTuy/Tib/JkaFyEqbcRA+UiCaRIyrDQaA3x84goV2eyr/lJ69hMx2PZ
	 IRGRMGeSdc6R2rR3/0CDlv4HFcX9VJSkbeHKx8ubl4iNAjvHUioRhJXjINVsEVdM2t
	 lNEaOnsKGVyFUwIw/4GBU0yPhHFw57BQh5Bg5x1mb1hElZCLVLWc3MEDEf2Uz89IOz
	 v2pcnL33rGpzmylS+NcWxIHoRzOsBSIBEWdasD/kW92y+59AzlYUbWYHY2g0xhUISb
	 kChObi6GOWmxFXlRYVHfPLst6VpPNGnUvon5kIv+i3KQykr3HcSFYmYA2N10CMoV+X
	 Dw1HTu0CJdZQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] netfilter: nf_log: unregister loggers before per-net teardown
Date: Wed, 16 Sep 2026 21:13:18 -0400
Message-ID: <20260917011318.3530857-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917011318.3530857-1-sashal@kernel.org>
References: <2026091608-unstaffed-playpen-7696@gregkh>
 <20260917011318.3530857-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit 2c018cc4842c33f0c732962e2ab58635e8ae5823 ]

nf_log_syslog and nfnetlink_log unregister their per-network namespace
operations before unregistering their global logger backends. This
leaves a window where a sysctl or netlink writer can rebind the still-
registered logger after the per-net pre-exit callback cleared the old
selection.

The race looks like this:

  CPU 0                                 CPU 1
  ----                                  ----
  unregister_pernet_subsys()
    nf_log_unset(net, logger)
      net->nf.nf_loggers[pf] = NULL

                                        lock nf_log_mutex
                                        find logger in loggers[][]
                                        net->nf.nf_loggers[pf] = logger
                                        unlock nf_log_mutex

  nf_log_unregister(logger)
    lock nf_log_mutex
    loggers[pf][type] = NULL
    unlock nf_log_mutex
    synchronize_rcu()
  module exit returns
  module core frees backend memory

Later, a sysctl read or packet logging operation can dereference the
stale per-net logger pointer.

Fix this by unregistering the global logger backends before tearing down
per-net state. Once the global registrations are gone, later writers can
no longer rebind the logger. unregister_pernet_subsys() already waits
for an RCU grace period after the pre-exit callback clears the per-net
selection, while nf_log_unregister() continues to cover readers of the
global logger table.

Apply this ordering fix to both nf_log backends that combine per-net
teardown with global logger registration.

Fixes: 5b023fc8d8e0 ("netfilter: enable per netns support for nf_loggers")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_log_syslog.c | 2 +-
 net/netfilter/nfnetlink_log.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index cce8f282b0eda..bf902b1fe2aac 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -899,12 +899,12 @@ static int __init nf_log_syslog_init(void)
 
 static void __exit nf_log_syslog_exit(void)
 {
-	unregister_pernet_subsys(&nf_log_syslog_net_ops);
 	nf_log_unregister(&nf_ip_logger);
 	nf_log_unregister(&nf_arp_logger);
 	nf_log_unregister(&nf_ip6_logger);
 	nf_log_unregister(&nf_netdev_logger);
 	nf_log_unregister(&nf_bridge_logger);
+	unregister_pernet_subsys(&nf_log_syslog_net_ops);
 }
 
 module_init(nf_log_syslog_init);
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index dbb226aa4c0ea..e576c5417433d 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -1179,8 +1179,8 @@ static void __exit nfnetlink_log_fini(void)
 {
 	nfnetlink_subsys_unregister(&nfulnl_subsys);
 	netlink_unregister_notifier(&nfulnl_rtnl_notifier);
-	unregister_pernet_subsys(&nfnl_log_net_ops);
 	nf_log_unregister(&nfulnl_logger);
+	unregister_pernet_subsys(&nfnl_log_net_ops);
 }
 
 MODULE_DESCRIPTION("netfilter userspace logging");
-- 
2.53.0

