Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272A448BBE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292469; cv=none; b=oNp51BZCyNmIJBW/+zh11afeR6h6fxAGtRYm0i0BnMztU2fUdggG2Qq+4ITJmeGkjZxvIjMeMwmKFnF45S+nbcltuQfGQnoXqgA72Y8n9/yZM67HV6ukOOH15qB5N/iE8itkHlWInMPwa/sENpXYX4A2u4HCfA2/SMzhK06t0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292469; c=relaxed/simple;
	bh=xSNFw5hVSBhxR3kd7ODvaAsCER/Tvv7xz8x00IXviLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yy9nb4ClsGXibg6l3gCgJF+Tvv01G3HQkvCuxM9W4V7X+7R/eAMxQfq8MHCDvtx9yT8hZ3VA5yI5NjND876UPxeEPDI2SZloRAlfC9ye1cO2VQzrfuae98GzWP/HOQqtmtrPpkDphfSebVp/rQaygHqo66F6xsp+pL+xC4y83b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HblNsMl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HblNsMl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4D81F000E9;
	Tue,  1 Sep 2026 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788292468;
	bh=Wm1h3HP26DaHTbgdoOIcwZSsjHNKMzsmgy2tDsAuIeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HblNsMl3ioEl8olBglu+zpy0sQaQgbnPS57wiiFUUgNarafNtcClcYBXpAz6NRi5x
	 3QRsKTETjq6hichtcHK7SktoTkCZ8FnvRdV8vZlgr6RKbL7y2pSnHIkq2X4/7kUxYs
	 llp4dDGgw4y8da2UPXd84IaqgX/Jk0cQb/OTwD6cMOsnsCswEKpQTKwQWSuogCLTpo
	 zZvLnZAn15bjfUy7gXbc6t0/uCQIDrx3gi0oGEBl7UhdCDwMiSFkU8YQDfD7+40Qnc
	 KitcevtVtj2vcWnR/CaQ0eexJajblTtuwYt7LdZ5BbLi/Gn5fYYkRhwhh08JmD7YHW
	 8VKMMb0TiULIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] netfilter: nft_set_rbtree: Remove unused variable nft_net
Date: Tue,  1 Sep 2026 15:54:24 -0400
Message-ID: <20260901195426.1450757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083157-plexiglas-pouring-6a0f@gregkh>
References: <2026083157-plexiglas-pouring-6a0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 67059b61597c004e23b074547b40604222bee3a0 ]

The code that uses nft_net has been removed, and the nft_pernet function
is merely obtaining a reference to shared data through the net pointer.
The content of the net pointer is not modified or changed, so both of
them should be removed.

silence the warning:
net/netfilter/nft_set_rbtree.c:627:26: warning: variable ‘nft_net’ set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7103
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

[ sashal: Reduced backport -- upstream 67059b61597c0 touches 1 file(s), this
  backport carries 1. Not backported here:
  net/netfilter/nft_set_rbtree.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 7904b94768e9 ("netfilter: nf_tables: don't queue packet path object notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b6f74fa699f22..5fc2296d48c46 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7842,9 +7842,8 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq, int event,
 		    u16 flags, int family, int report, gfp_t gfp)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	char *buf = kasprintf(gfp, "%s:%u",
-			      table->name, nft_net->base_seq);
+			      table->name, nft_base_seq(net));
 
 	audit_log_nfcfg(buf,
 			family,
-- 
2.53.0

