Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7F3A2E33
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784483456; cv=none; b=TcoJQmEQ/U+yC8uZwP4ILUNCW/3JIYfPNCWQGXx/OLPUjWyJ3H+/lW5v5k6lrpCh917xV3wSbE0kabKmP+f5KcFD8oz1i3zCOTE4osDQFUdtDKu7ppqWsIV46Oln6Or/NL/7VyMANX4dXPnqR+PfMiiSeW2FmXcV9/OWdbfuQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784483456; c=relaxed/simple;
	bh=1pN32S2baW0QTY05fmozR5sB5cIXnuaBLTrX1Su/s9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFbB3qfC+yFyaMvmypo+tVHD4TQw0oG9aZ6Rq6bNtuGsKmhYpa+e/crca48juEQYWGTrQqJY+iOIrujFdEq/SoQ+7MfTdnqEikcgJn1IbFh5kAy3xbLlizI9fbUqHkEzIR6aCrqx9qY1ZAxYmW0gFOMf3XQyqFFXs5GQVNDhOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvJtKtV5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvJtKtV5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso6335600a91.3
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784483454; x=1785088254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6kSz/qjXQ0gTFAPWdJ8WtRiGAzWRY2MZwa0jKAIf2A=;
        b=bvJtKtV5VxaBWBvksjALdqenXnw30sZXqrjneIx2V5yAO6+lBV9ej+jDdbUnobx7zB
         kn35Dwiiv9UORrHfTZ71zX+xjIvGvFmQecbC6v+zBGyFZpRrtvdXhGP+F6dvl9vqpAqu
         zdSbEs5263U0Ni3wQ2x8+xIU6MZZz53L/RbcuIAnRlHgAEI07WJy5W9ifhU4dMfwTxx0
         PwvRBO+uOBzWfQRO2MrOvPd4I4xJrKqWhkkKBrPn6NhELLeF05qsOsBlupQigKog7BhE
         NGPLEOpKOh2ucJGIhQH2zT26yPWDbnzKeE3rT3jbXPVAOhgdkmfDq5eLP8zP0ybR6q0C
         3Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784483454; x=1785088254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6kSz/qjXQ0gTFAPWdJ8WtRiGAzWRY2MZwa0jKAIf2A=;
        b=OlERgBo4516xqqR3teQWHFjvHdXf9ebonUtwfsSzH3r3BhFw3vh6rmqjjsyoK4S+6M
         wrSqj8tPC1M6QQzqwKbyXMkb7Q9comEH8F/Rx8LhRzC6UFqAoOHyIsMRw5B9XO66Q4sa
         Wjd+3zXUEJeB0n3wjnrreLZTBTLzTK3AlzZ4brnziTj9BEe2Qx8EbnrcGSHaWst9tHEC
         3I4ud9fytZhPc2H/X0lps3svEYhysiyde6YJ50rE3CLrTf1nUg4dtyoz8xo4AFHI/u50
         zW+sXx4jHnvL19WxILyJoLhRTzWsaZ46f0mbh72gCOPfU8DNc+xXcHwRrq72vHM+0PdB
         j4Ig==
X-Forwarded-Encrypted: i=1; AHgh+RrJpKwg8s5UXZUbWxZVHXXGOGuuBoH1+Zfu2CpZ8CJigDRj/SXV2YnHOeo+bRzzUVxivX6ieKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynseQjK38nJuTeA8CvikkBaNyytZrqutK/gXPvAZuMAhF2ICQR
	6U6rmGVUqrcgUq6HS83zJBk9G+Y5uBQmccOzHBMhv2QxxGWk1YwwL6Ww
X-Gm-Gg: AfdE7cnYGRVcUpRLulGcj3KUOYAMswyk8OnlDlunhwGI/AxnosHcDzuLDMGrVRQH42n
	0sNAmck1MF/WmRanQkqOcL9FvjN67EOwsmZDVtQ+rqTt/1+9G5GU5n9h3oD2QuMdw7mTlI/ByxL
	qt03y/XsZu6RU8ohVspdK9OLleqkrGcKcZcf7qx21BtTDCz6FT4FzpU7A7KjvzHXHj7KGkD3ohZ
	gP1UQYF8lhUYo2cbVTU7CgCNchdhz6taC6YAas66LcF8WZJWUBn9ymmoq8PXV1aWp9WJE7BJhDt
	stBK4cWtgejtUzGgXjlRAIG+oBAbDewxVOa/s1nqUK0iCPLqGpNqnXHYNRGKI30y8F6lVsuzXIF
	UlYtbw7cyPy0qBF3eIvh2uTASKX8Qz30qZ/zLkinBgKisxwE9wikP9YSLlgC/mVpr69byaybjfI
	bSTbAVUINmSQEeiNUvQYgKj+APziMskxlmxGgEN+VnK01LMjc=
X-Received: by 2002:a17:90a:d40f:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-38e4b4461e1mr11236442a91.12.1784483454468;
        Sun, 19 Jul 2026 10:50:54 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2a48sm20625345c88.2.2026.07.19.10.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 10:50:53 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] netdevsim: tc: serialize access to nsim_block_cb_list
Date: Sun, 19 Jul 2026 10:50:29 -0700
Message-ID: <20260719175028.988301-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nsim_setup_tc() passes a single global nsim_block_cb_list, shared by every
netdevsim device, to flow_block_cb_setup_simple(). That helper does
list_add_tail()/list_del() on the list on block bind/unbind and walks it
in flow_block_cb_is_busy(); it takes no lock of its own and relies on the
caller for serialization.

The tc control path calls ndo_setup_tc(TC_SETUP_BLOCK) under rtnl, but the
nf_tables hardware offload path reaches it under the per-netns nftables
commit_mutex only. Two nft transactions committing offload chains from
different netns thus run flow_block_cb_setup_simple() on the same list
concurrently, corrupting it and freeing a flow_block_cb that the other CPU
still walks:

 list_del corruption. prev->next should be ffff88801f18ff00, but was ffff88801de82b00.
 kernel BUG at lib/list_debug.c:62!
 RIP: 0010:__list_del_entry_valid_or_report (lib/list_debug.c:62)
  flow_block_cb_setup_simple (net/core/flow_offload.c:369)
  nsim_setup_tc (drivers/net/netdevsim/tc.c)
  nft_block_offload_cmd (net/netfilter/nf_tables_offload.c:394)
  nft_flow_rule_offload_commit (net/netfilter/nf_tables_offload.c:585)
  nf_tables_commit (net/netfilter/nf_tables_api.c:10490)
  nfnetlink_rcv_batch (net/netfilter/nfnetlink.c:577)
  nfnetlink_rcv (net/netfilter/nfnetlink.c:649)
  netlink_unicast (net/netlink/af_netlink.c:1314)
  netlink_sendmsg (net/netlink/af_netlink.c:1889)
  __sys_sendto (net/socket.c:729)

With KASAN the same race is reported as a slab-use-after-free read of the
freed flow_block_cb (kmalloc-192) in flow_block_cb_setup_simple(). The
trace above is from a 6.12.y reproduction.

Serialize the list with a mutex. ndo_setup_tc(TC_SETUP_BLOCK) always runs
in process context, so sleeping on the mutex is fine.

Fixes: 955bcb6ea0df ("drivers: net: use flow block API")
Reported-by: Xiang Mei <xmei5@asu.edu>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/netdevsim/tc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
index a415e02a6df1..30dd7f924b71 100644
--- a/drivers/net/netdevsim/tc.c
+++ b/drivers/net/netdevsim/tc.c
@@ -72,11 +72,13 @@ static int nsim_setup_tc_ets(struct net_device *dev,
 }
 
 static LIST_HEAD(nsim_block_cb_list);
+static DEFINE_MUTEX(nsim_block_cb_lock);
 
 int
 nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	int err;
 
 	switch (type) {
 	case TC_SETUP_QDISC_TAPRIO:
@@ -84,10 +86,13 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 	case TC_SETUP_QDISC_ETS:
 		return nsim_setup_tc_ets(dev, type_data);
 	case TC_SETUP_BLOCK:
-		return flow_block_cb_setup_simple(type_data,
-						  &nsim_block_cb_list,
-						  nsim_setup_tc_block_cb,
-						  ns, ns, true);
+		mutex_lock(&nsim_block_cb_lock);
+		err = flow_block_cb_setup_simple(type_data,
+						 &nsim_block_cb_list,
+						 nsim_setup_tc_block_cb,
+						 ns, ns, true);
+		mutex_unlock(&nsim_block_cb_lock);
+		return err;
 	case TC_SETUP_FT:
 		return 0;
 	default:
-- 
2.43.0

