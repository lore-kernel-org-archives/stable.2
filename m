Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271FF4CEE6D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573300; cv=none; b=J0YGYyj4Jq7dWnyJQwnJDUiPpQ3u9+bdq6ueerInDUcF/pu35ui3o6JlXXo5K0WkiU/A3HnD/4iE3TWcvzjANuuuqCCHGXiuUuwX58LIKhiFmmf2aI4PgkoKEyy7SHEaz3zpM3ivy8+HCDRic9pFh2Kws2X0/iujDGZFS93MkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573300; c=relaxed/simple;
	bh=VvJLfaFK7+kmnDTsG502PaS3LdKqtbVnAKpNXbc/tZU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hG1ejHB3zx34aAgBr5FJfRwKHVDNL++InlqFDq3gguvaHRAgHH06i99DKoa5zykusEdKX4dK/dLe7hUpsyS5Skg/tTr3VI61c5MG1Pxsy1+9eoLllF7RnRTjrPCrDnNzNHMEyZg8aY4VNVBktwG+jlWBwkCVwEdmIc885J5a5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjoXbcfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjoXbcfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0040B1F000FF;
	Wed, 16 Sep 2026 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789573297;
	bh=EMydG2c5UH40lyy+8UU2+uaOTa1fOEt4qaxP1toSYco=;
	h=Subject:To:Cc:From:Date;
	b=jjoXbcfy+PLnap/fjVUGM5QHbdtM2vNN2FloSIzMK+EUweVjoSTHzV3W6Gnc7ccXg
	 oILxqD3a0fTuGX8WeqT/JOJUNP14owyiZCyIJlPGwYQLGss6noZESateN8QpCJy9gG
	 SdKfpZZdpLK0Xo43NXkkQxihtZCzlHpXsewZWPYk=
Subject: FAILED: patch "[PATCH] netfilter: nf_log: unregister loggers before per-net teardown" failed to apply to 5.10-stable tree
To: nicoyip.dev@gmail.com,pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:33:09 +0100
Message-ID: <2026091608-unstaffed-playpen-7696@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2c018cc4842c33f0c732962e2ab58635e8ae5823
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091608-unstaffed-playpen-7696@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c018cc4842c33f0c732962e2ab58635e8ae5823 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 01:05:38 +0800
Subject: [PATCH] netfilter: nf_log: unregister loggers before per-net teardown

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

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index f24288088c0d..c3fd398ffcd7 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -1073,12 +1073,12 @@ static int __init nf_log_syslog_init(void)
 
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
index 6c7fa2ed34f5..9d7fec570abe 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -1233,8 +1233,8 @@ static void __exit nfnetlink_log_fini(void)
 {
 	nfnetlink_subsys_unregister(&nfulnl_subsys);
 	netlink_unregister_notifier(&nfulnl_rtnl_notifier);
-	unregister_pernet_subsys(&nfnl_log_net_ops);
 	nf_log_unregister(&nfulnl_logger);
+	unregister_pernet_subsys(&nfnl_log_net_ops);
 }
 
 MODULE_DESCRIPTION("netfilter userspace logging");

