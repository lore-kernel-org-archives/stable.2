Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384243CE79
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817784; cv=none; b=EsoW6cWfcATQPWQDQzOQLdkqHgKJqcsKBWbs/wxwFhFMoToFdxsYw8Un+KvtXqnpgUgZLILVu0ZxtqB5taVX+plWz/qhCj1F4eSjlEWZNvkCOHy+yzSGjVsyfczIcJWDZUBH6vlcIkpKIsMa7SQX5B7r3cJpTWNhzd+yR4G/0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817784; c=relaxed/simple;
	bh=SaGT5/k0Hq7us1Xh96BcYHTQxGZSs402OfH8hNSQErY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b9lTY0NF2W+7iL5BtVexfn/ERUHC+bYIyMZFpRMbLjLkD6jlOenksTeYWClhWKY/yo4edSa4opY0g0PRkgEC7RL5QZlR1aFPytzy5djSEVtTubbWGHKLHsH0phsTbtOFCa7TCkXnS8m3FQY7yemuNoj2kapcsvPyk7UqvZ8RCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjkyRkmd; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjkyRkmd"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91931144870so138025585a.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817776; x=1785422576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7G6+WmalGeshMr5rrbPWKhucx6Kb/G0FkKHu8ELLz48=;
        b=GjkyRkmdjlx0WuRJ2NpsCYJypkU2QOcewKBHWz+aVDgWwHBDc8G0WeQP+SW9NOUVvH
         cx+0hlT788gmTvuGLgxRhMHekJjEH9/qL8sx/1JJsT1DOsoH7Sp5lQtrOZD3c0mBzvk0
         3iL5xnStIVLUTQRRb+TEIeISfNXUKZw4td1a5Tbj5hdJqO/iuJ17946sdv5OPiFxmM2c
         HXGk1mJin1J0Vktxk+kOZ8iJSalWrTGaffpuwEb8fTYKNaagcU7mh0q63zeQqz0YyL5q
         oUg4i1n74/+NEG15gzbX9gLaRhziqFBjJpQSCJozdXxsQZDWBakbjvNULLDBFBHdsSwt
         wI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817776; x=1785422576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7G6+WmalGeshMr5rrbPWKhucx6Kb/G0FkKHu8ELLz48=;
        b=MVrZ+/zOG9Sg3Yr9KmWqtV/S8TApfkz8Obqe+YydJHAlbYWjStMIAg/tr/K2xZDNVn
         KILnwHtqX72IXwE7a9z33x0ZYRGHv7XEAiVXyGkZOglX5h+vlddZco8IyDd5/TK/CWgN
         oAok4CIcZBkt2NupIswGm+dETHm4aYt7dYABES6skIDjgX50k7+AOm8f/fSLQkK7yTBx
         4WXwy/oxPbH921lMaVRkleII5089S52/KgCYcBob5N0AvrItT3X7yiiwzvGiBC8Yudeo
         2aGpBSV1c7M78ekc7vIlLxHHcmpHdSuzTL9/vtfman1eypc4crGqRXrNwjdsOuOt9RLr
         kWUA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2MW6umkp7dFK0ymfPsmuSlySEj/nrLu8F06IXOziyyKQFZamPZxOBGekSYNSseA3GCXLxp4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWIWz72VK2ReieLdiZ6T5L9RM1ZRGw9USK+TvCz/ezWWBG+PI
	pP7O10jfLzBafRxuESINixivok/eqefeDM48wY1m4wRLD7tV1gnjZNZzuIMp0tMd480IKK2CYOa
	nJgFTDn9tVdaByQ==
X-Received: from qkww19.prod.google.com ([2002:a05:620a:953:b0:92e:e46b:a01b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:480b:b0:930:f9a6:11ac with SMTP id af79cd13be357-93103a59d1dmr315209785a.71.1784817775196;
 Thu, 23 Jul 2026 07:42:55 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:42:47 +0000
In-Reply-To: <20260723144249.759100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723144249.759100-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723144249.759100-4-edumazet@google.com>
Subject: [PATCH net 3/5] vxlan: use neigh_ha_snapshot() in route_shortcircuit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The neighbour hardware address n->ha can be updated asynchronously by the
neighbour subsystem, protected by n->ha_lock seqlock. Reading n->ha without
holding the seqlock loop can lead to torn reads or reading a partially updated
MAC address.

Use neigh_ha_snapshot() in route_shortcircuit() to safely copy n->ha under
read_seqbegin()/read_seqretry() lock protection before using it.

Note that arp_reduce() and neigh_reduce() seem to have the same issue
left for future patches.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index fb4a706cd5786d1937b1922acced31ffdb187c2f..10dd19eec09e266197ee51330a652f4e76c9643a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2159,9 +2159,11 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	if (n) {
+		u8 haddr[ETH_ALEN];
 		bool diff;
 
-		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
+		neigh_ha_snapshot(haddr, n, dev);
+		diff = !ether_addr_equal_unaligned(eth_hdr(skb)->h_dest, haddr);
 		if (diff) {
 			if (skb_cow_head(skb, 0)) {
 				neigh_release(n);
@@ -2169,7 +2171,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 			}
 			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
 				dev->addr_len);
-			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
+			memcpy(eth_hdr(skb)->h_dest, haddr, dev->addr_len);
 		}
 		neigh_release(n);
 		return diff;
-- 
2.55.0.229.g6434b31f56-goog

