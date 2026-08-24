Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F97E423A85;
	Mon, 24 Aug 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577491; cv=none; b=tWvQrAmxr0hSF2YpJzzuEiSpx3lsjpqroRmBElYRtho1y7vk+2vPySy+DeY+fF16wKov+UorXkpRla6TY1qK6ahjdkdMF0smYfnmjRVQji8l4zWErLiRbPmjU8XFxK2qix6gOuEakZsbOkbRs9no+1y2fZVAO3W6hfAkDJwcRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577491; c=relaxed/simple;
	bh=pS9bdie66/LruxFHpoKE7eytML9TkYpKGpinajQOOhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BszEggTIsJKtFOqcBl/W+SHTz65/7ms0dWeoiJIQCJAcahyV+qPSEJeEG2LvLlF2/iXUxoR6JGxhroE3qLYFAj3++HGamkLv+4HrvIE5MJXRuyhkqleBCxeGjf2V9vlk00uEAHBHpJz4N/L7qv8I6Mj4azB49CHoNN9+YcEaMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=e3Qv+3kY; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="e3Qv+3kY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qfsd8L9bhmC1V1C6GuAqDvfE6+3TNd9aG07fpcq1BZc=;
	b=e3Qv+3kY58BLKHgAw0U0VQV9rGspUOE/uWlbnlImkf5TtmOeQJJ15WDHVYwmuNEwPKR2+oYHy
	0FNqhj7n7vg4WGbhWzqkR+7h9rnQf6qw/NmvNncC6v6iEklECq+BQA9txdXm7yJ1xIaXuRtl5JS
	MLLVwMDk/ebzKkQy03wgRks=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hTB5Z1CnkzKm5t;
	Mon, 24 Aug 2026 21:07:14 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C6B14048B;
	Mon, 24 Aug 2026 21:18:02 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Aug
 2026 21:18:01 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>
Subject: [PATCH linux-6.1.y linux-6.6.y linux-6.12.y 1/1] ndisc: ndisc_send_redirect() cleanup
Date: Mon, 24 Aug 2026 21:38:52 +0800
Message-ID: <20260824133852.328978-2-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824133852.328978-1-lixiasong1@huawei.com>
References: <20260824133852.328978-1-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj500018.china.huawei.com (7.202.194.48)

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0784d83df3bfc977c13252a0599be924f0afa68d ]

ndisc_send_redirect() is always called under rcu_read_lock().

It can use dev_net_rcu() and avoid one redundant
rcu_read_lock()/rcu_read_unlock() pair.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250214140705.2105890-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/ipv6/ndisc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 585a9135cf26..7d703a66c0a3 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1671,7 +1671,7 @@ static void ndisc_fill_redirect_hdr_option(struct sk_buff *skb,
 void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 {
 	struct net_device *dev = skb->dev;
-	struct net *net = dev_net(dev);
+	struct net *net = dev_net_rcu(dev);
 	struct sock *sk = net->ipv6.ndisc_sk;
 	int optlen = 0;
 	struct inet_peer *peer;
@@ -1686,8 +1686,8 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	   ops_data_buf[NDISC_OPS_REDIRECT_DATA_SPACE], *ops_data = NULL;
 	bool ret;
 
-	if (netif_is_l3_master(skb->dev)) {
-		dev = dev_get_by_index_rcu(dev_net(skb->dev), IPCB(skb)->iif);
+	if (netif_is_l3_master(dev)) {
+		dev = dev_get_by_index_rcu(net, IPCB(skb)->iif);
 		if (!dev)
 			return;
 	}
@@ -1725,12 +1725,10 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 		goto release;
 	}
 
-	rcu_read_lock();
 	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr);
 	if (!peer)
 		goto release;
 	ret = inet_peer_xrlim_allow(peer, 1*HZ);
-	rcu_read_unlock();
 
 	if (!ret)
 		goto release;
-- 
2.34.1

