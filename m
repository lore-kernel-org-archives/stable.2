Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7D23EA84
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787504762; cv=none; b=CEOp85zib4h/ftEBY7NR+8UqmFZqujmXWrO1tH48ZboiP7ecfLsdCdEsezZBFL/LHkDekMMkTZ6ZQ4Kc9DOlrsrKJf4glCjHNjq9JU84ZvOZ83Q/crHTl0PKRd7tIaf/xA+M+U4FESEDyjs+Wwr9nStAQFvS6hqeV8Apf8l+1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787504762; c=relaxed/simple;
	bh=MOSoskfPWCJYTRcElhbU7017zaNB/Jrp/HctCMM0yCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kq721No4uHcvEZjvBs0u2WYUWis2V/5W4i1t/yQ9umb8JWC1F/Cl73JWzTnCRGr9PAWghCoeu+3BcISsXJVw9YEcnJRQyrauJptmvlxIJKxQYVqKOsu0a4ZPIZLtQG88dCgwsh7Kt/ljIcGqt5bBZ6jt/BFympbdeyMjpupBphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfE6OZiZ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfE6OZiZ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c70effc23so293647d50.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787504754; x=1788109554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=esjqTaDB5DT6wtV4Y9AzgjqpTCrwMQJOjGYCKVsLIlo=;
        b=jfE6OZiZqfBaNW0nhyP/lZjc7Vog5R1/gxYLbRc13QdcVBI7eds/P9Pb5JpKM0zngZ
         /3frcuK4JN0d1jA+BOqHB7fcUqsGngxxSre8z5e6OjZyydlAWnE4E2ygbVYSnAnYUKOn
         S8Ft960HzFsHi64gLVrXkpGWcN6osyWlz2g5E3WmgvVwVeEilwBaXJtSCDpTIm2wp1H0
         J8z7KF90hfu7q9M3M/v5zu4UzYivx8f/CMp8sB7jUGDCSxabchvfkpTyUZOOLUbRaQ69
         FRs7kOiAyZWpmY40cE2ybtpDJ8oJLma6BKZucmO/wozU2lEQoQXQw4ZajemHcbuNHUEL
         5wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787504754; x=1788109554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esjqTaDB5DT6wtV4Y9AzgjqpTCrwMQJOjGYCKVsLIlo=;
        b=Caa87gqOywP3JJleXKQ3WhpuUs1dflY22iDqxcfHImI5g1/mm4c3evVn1pfO2Bt/28
         N+nJSIfnaLYuWShhvs2UkUqqqR79kkNJKi9BxYRbsVO+jTpsCnk04eIv9ZrXeGm/mURO
         Wp0I0IZnF27u5fvuIPpV0RrgVIVYHjOE+w1I2W810l799yjA/ngfQy6pxVuya3U0xUBg
         0ZD9+jO7NJhMiCpcy0KuI+Prc243iNXQm10gyhsiwBD5P68er3RyDjXT0WWrFOST5Bwa
         x591KFdOxakch7RnV/r5KNbe7hFFjEeBl9DWUAH1+RipTiKXEwTIg5Dvb9gIwmoV4ItN
         mxhg==
X-Forwarded-Encrypted: i=1; AHgh+RqR36VEZdVDZuA00Ey8ZUpcxHQVXKBDb8Ow5qfoQsx3gAbOwlNeIsKuzkSV2/nQBZ0e1kZ2fqs=@vger.kernel.org
X-Gm-Message-State: AFuF++k3S3vjMlgpVPv+dMGSxJaP322O/U5WCJUwIw58sP6lqeOYj0yB
	HpP1ovJSXfIguCRmijMb86BDLLXfGq09knILdYLP1bO++DeCW5/mTu9r
X-Gm-Gg: AR+sD12SkfqCMTWGaZR3bUAx03laa2MTR6e58oPGfYYI3gmw+5ld1MUluwkSY7XEM1I
	/stc54mXA+BrmFJcCgjUECo7r32I4VuLPMsjTu1X2x+VqkLZnnGOigtGC/K+Ujf2tt8L88n6RJx
	iLqStDxahHSvDjunuV+mYr5ff+sciJe6EZm885++OcNeRmJEdbP16UDTo6QvftjUjzrH7sx4cj9
	jLC3tOFJoc9lEaMJux4eEpfD3Tpcv6s5l/0ow76HT6z4GGkHaOtwJdqpV93kYnIt4WNaCO+74Kx
	5/kZ6mk2umPu+1fORgA28bYGM/q9fpRJe1RiWG/Asun7fkVqX27hBHr312EhFrHEPC7FONRpHXn
	DdvN4BJG7h3COhWqUesAn5OuHkr5T7kv90gWjh0ZTdETVGClzUTBCHi9oGKvFW1da+nNIDqdQ18
	pJ4fc2kkUyUUgrkzxK+F91yeZjenSi5adi+jJtO5lsDVmf9ySugBJ4dy3+4TSkWWcQ7FQgrlmBu
	aVwJRX6K9i7v6L1FxCdKue5HUCRGacR8KSoev+xPlDMJWHZvVvbO2Q=
X-Received: by 2002:a05:690e:4849:b0:668:99ce:a033 with SMTP id 956f58d0204a3-66ce4a9b51fmr4978933d50.2.1787504753689;
        Sun, 23 Aug 2026 10:05:53 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4a2c3c2sm2333298d50.17.2026.08.23.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:05:52 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Gao feng <gaofeng@cn.fujitsu.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] netfilter: nf_log: unregister loggers before per-net teardown
Date: Mon, 24 Aug 2026 01:05:38 +0800
Message-ID: <20260823170538.3856770-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes in v2:
- Rework the fix around backend teardown ordering instead of clearing
  per-net bindings from nf_log_unregister().
- Apply the ordering fix to both nf_log_syslog and nfnetlink_log.
- Drop the redundant trailing synchronize_rcu().

Link: https://lore.kernel.org/netdev/20260822184658.3787672-1-nicoyip.dev@gmail.com/ [v1]
---
 net/netfilter/nf_log_syslog.c | 2 +-
 net/netfilter/nfnetlink_log.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -1073,12 +1073,12 @@
 
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
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -1233,8 +1233,8 @@
 {
 	nfnetlink_subsys_unregister(&nfulnl_subsys);
 	netlink_unregister_notifier(&nfulnl_rtnl_notifier);
-	unregister_pernet_subsys(&nfnl_log_net_ops);
 	nf_log_unregister(&nfulnl_logger);
+	unregister_pernet_subsys(&nfnl_log_net_ops);
 }
 
 MODULE_DESCRIPTION("netfilter userspace logging");
-- 
2.43.0
