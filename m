Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B31302767
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322710; cv=none; b=tl43zMAYbNiYLoj0VOW8g0CRqawtyEsibcx/d/PZV4Lv8qbY28bhdZPVE9EU3qQQeKFG6CUjoWnYyFVaSjpykpt69pLU8RL6Dbx7SbKM+ZLkmvxDB9cHrse4W2ptnh9gxGp7cWCHVN1GgCUdPzRUhGZBnaSvkEgtLsPvX3chQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322710; c=relaxed/simple;
	bh=Vuu4gwC8LcqdTJOz5nXgJvtS+rF338aW6f5mJicR3vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rF0bIhI4ErfxNudZrgCxHaCLaLTIurKyoYAQ/SUBPElCi3DeeOwNljxc8L08WppPSUelFFFxH7pntpkNnAUgQgIeYTDu+VWHhDISAw/mONHst3RNDBM8RnNvQPSQoVvnL8vakOd38U6jPGQxegckfnIzE/Q4t0ZFaRmrtsyrGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njcvxe8q; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njcvxe8q"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2dd89b59dccso517175ad.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790322702; x=1790927502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rsnguF0QWu+wCGviIn/1oOF3TR+Pdtv7G15y4cdufc=;
        b=njcvxe8qloYIJ6eVSdOHTXt1mHEvspLhjrJ7g9BLLO0sIGLIh8ubct2QInK8kb8wdx
         rtGmVnl5D1EujeaHW0BlAOpXZ8zi5cj8VRwKrYjOb/QVxOpK22JdxnVNdpWj7BAv4ufk
         yPc6NrqJq/Yzr2JYGmIiX5lySqya0qNuDhYih+JES7CV0U/DzwCOnuGE4gor6GUAcRuN
         cXls7/t5eVP9ozqo9oMfbJjH2G4zSM5aJpODbb6WTlFC5J26nmh8/7iXlyHBOKyyxQI7
         tZfxU+B2XV7ZIUopFbBj1KSlqFZsvYWAbbV7qa3U17auoXN/03+fUfXu2y3yBSpM6tPk
         WKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790322702; x=1790927502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/rsnguF0QWu+wCGviIn/1oOF3TR+Pdtv7G15y4cdufc=;
        b=Pva/uZ9Trat+kRORe0hC30I8VnkGGtW/lgXMAn2asjNlghqHR1jA/n3ufjDRlMfWwk
         jw6iC87mk3L8MHLxTjJRqw2sqRh2+pk0aIFZz43hVcLi5xCU7XqcAM+sEFWFxBs7vX55
         RHTb7rKYMGNWqc0DHrtQxeXVKzsbihYTKe4Bqv/LslK5I4bUyA+d87tWrvUon5x6Bzds
         2FZaXZktFoUhMKnu7AEoiTPAJC+dXWp16K4NTfc8kJ1KZOtzqGv7XN3fSodRg/HZRCUr
         5151x2IIUvXPSC46ODfGpnAAq/zs+9RV2M6r6JnIBcsNG/CdD7hX+lnIEOd1Qu9ZU8+Z
         lK0A==
X-Gm-Message-State: AFuF++lTxSg0M2KMeyBWyAm2Pgwpu53jXoBEfNeg9S0lC/TNmD4h+Uyz
	mFsJ8L89ZHPyaINbcJQF8t4GmsRpQzc91jmwmGNm6dqHzlrYql/pihdLNJNr0FPE
X-Gm-Gg: AYBFou2rNDAkXmw9M6oZER5RZCefHQlsC5rghPABND2aW8sGSwi4/yh7D0i68G/E8CG
	DixO3r4IK9r0QeVdyqX4657K/mPFzKyO8ZZ0ptw07dIXZ5ip8eF0v/L0uQOPrFqYvTmGGMIjhIL
	awMCOq+S8LfAS+jmFXNZ+U5bq4nP86AqhUWgPztL3phGEPLxYVBBXsaPgkvD2h8nxF6NZQY5qAF
	nANelqGVj2l9u7QkzEtxWB+OB85d+9tTXL5WJ2g4r4bTMyyKL1QwQ0tcdGSr3pkUfQ7uPd3dlil
	2SPh1B802ULIOkTwl6DXEONVh8bSQ7RZfs8xB2mffmS8EwjrPf7TCBs3e0bvoQUxcsl+n5hZTyL
	C4eqQWDvd51auGAnPUdAV8TALYUFOEVtkWgka5Lg/4Gl6XkgGSei2vcTMxZC7sQkwAXED7Rlx2m
	iZvQCYuKdI3Q6PnL6wDbXcTUPvJwcT5V+6p7zEzMoI1nY4/vTMU1QZT5vTv6+tAzvOaGG8Iejvs
	zTc+EVs29dzsiJPi7b+Iw==
X-Received: by 2002:a17:90b:5804:b0:39e:b778:2b2e with SMTP id 98e67ed59e1d1-3a0b25d6920mr2965301a91.5.1790322701879;
        Fri, 25 Sep 2026 00:51:41 -0700 (PDT)
Received: from localhost.localdomain ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc790c80e62sm255962a12.28.2026.09.25.00.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 00:51:41 -0700 (PDT)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: [PATCH 6.6 6.1 2/2] netfilter: nf_tables: Simplify chain netdev notifier
Date: Fri, 25 Sep 2026 07:51:28 +0000
Message-ID: <20260925075128.646-5-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925075128.646-1-junzheyu1@gmail.com>
References: <20260925020025.616-1-junzheyu1@gmail.com> <2026092558-grime-yahoo-6b34@gregkh>
 <20260925075128.646-1-junzheyu1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

commit 375f222800bc001bb9cbd2baa1daec006430aeba upstream.

With conditional chain deletion gone, callback code simplifies: Instead
of filling an nft_ctx object, just pass basechain to the per-chain
function. Also plain list_for_each_entry() is safe now.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index e48de5a2b..867ff860c 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -319,9 +319,8 @@ static const struct nft_chain_type nft_chain_filter_netdev = {
 };
 
 static void nft_netdev_event(unsigned long event, struct net_device *dev,
-			     struct nft_ctx *ctx)
+			     struct nft_base_chain *basechain)
 {
-	struct nft_base_chain *basechain = nft_base_chain(ctx->chain);
 	struct nft_hook *hook;
 
 	if (event != NETDEV_UNREGISTER)
@@ -331,8 +330,8 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 		if (hook->ops.dev != dev)
 			continue;
 
-		if (!(ctx->chain->table->flags & NFT_TABLE_F_DORMANT))
-			nf_unregister_net_hook(ctx->net, &hook->ops);
+		if (!(basechain->chain.table->flags & NFT_TABLE_F_DORMANT))
+			nf_unregister_net_hook(dev_net(dev), &hook->ops);
 
 		list_del_rcu(&hook->list);
 		kfree_rcu(hook, rcu);
@@ -346,26 +345,21 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct nft_base_chain *basechain;
 	struct nftables_pernet *nft_net;
-	struct nft_chain *chain, *nr;
+	struct nft_chain *chain;
 	struct nft_table *table;
-	struct nft_ctx ctx = {
-		.net	= dev_net(dev),
-	};
 
 	if (event != NETDEV_UNREGISTER &&
 	    event != NETDEV_CHANGENAME)
 		return NOTIFY_DONE;
 
-	nft_net = nft_pernet(ctx.net);
+	nft_net = nft_pernet(dev_net(dev));
 	mutex_lock(&nft_net->commit_mutex);
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (table->family != NFPROTO_NETDEV &&
 		    table->family != NFPROTO_INET)
 			continue;
 
-		ctx.family = table->family;
-		ctx.table = table;
-		list_for_each_entry_safe(chain, nr, &table->chains, list) {
+		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_base_chain(chain))
 				continue;
 
@@ -374,8 +368,7 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 			    basechain->ops.hooknum != NF_INET_INGRESS)
 				continue;
 
-			ctx.chain = chain;
-			nft_netdev_event(event, dev, &ctx);
+			nft_netdev_event(event, dev, basechain);
 		}
 	}
 	mutex_unlock(&nft_net->commit_mutex);
-- 
2.53.0

