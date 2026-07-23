Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89178471CE9
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817786; cv=none; b=DYDZxrRftOywxV4oCURldmZwGAbezncuULYIkAr8b5S9FNXfDmzrTXPMjA9fqJoyiz8tyUh7pih2hknKgV44UAMOmbJOyFhvK0A0JnM9a3Hn09wusJSzamLNZyuIflXQvjruYpulbGVlpFdwnGslFUOM/7jXC3QPYgfobdmnqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817786; c=relaxed/simple;
	bh=urv3PH0Hu+r4wddZceePn0aPegfOTttLbRnkIj/1jIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BxRUHJ24geyQzI7xE03GErVNu8rWwJIc3BqMQaqXwaovZ0HA/UmyHO2EYcnmVg30niAv1u4+1Tbs78qTSzzeqz4JVXeQUyPLPoTcmhvz5Rqd2at8JbpqUrM4SMXtPMPz1Uz02QYbrCW84Dg8EDgiTBm+nwzZPQpGI3FaIuDmzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9P72l1W; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9P72l1W"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ac0a54110so154688485a.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817777; x=1785422577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=869dHuv35+0J2haNhjZ8z+zDAHoxp/wCA2AeLSdJygs=;
        b=D9P72l1WB8Ha8oJ6Z0SzDlpNJ9HwUYHWqspm/DnAU4hCRl8C9YG4JdGjHW5GMa6BOI
         bXZt2tqvEnbjxIfOYiPe9OE9uF8SfVTooW4ZuOEgPG8fsKKUQcy+bop3cWvrDD77T87w
         GZrLnMHmwRdnnehtQrU2NhP2YugE62FJITo6dzTW1TYsTBgM9Wf5nZp3Q8bb/gLhFAn3
         fFj6NlXpq3zqRpEw41LXKIowrMa6MpIO7c7bXx+/+wP6aFKBjyTJYTUbSv26n6wD8V8k
         tXzUs/polDJaXVnJKOkDuZyxNfvJMNDewsZySNNcFj+qrND7396rBR/4l2Y1TcHDfAj2
         71ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817777; x=1785422577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=869dHuv35+0J2haNhjZ8z+zDAHoxp/wCA2AeLSdJygs=;
        b=l4KpHYqgapxNQxJLtaP2GIk51y7/SihdbwqFMEhTUyYSCU9m8NZOii+25u51inKiWG
         T/d/0IdthxKvWXpfnt0ZcP9z4J2Jh3dBjUAIgJEtSi0V56bcuhyj0nfbG7K5+VHyf/dW
         XA9lKGQVCmafWaU1AzITlXcDn+04Xkt587N4pzFwnAiduVzJQ6x8bBmdNeVhwIgyXlyx
         Y2Se3MzcMF8wweUsFi0tpTJZKFi2kRLmltrUq99ZQTLSL2+F6JMnIyXayg3OXBqiP6P/
         Br5o7/KC6BR31L6yhbLuoBQJW4ITVPsF+umRIhn+81tw5VcFSPwnY9M96HKIMIx85QEz
         R6Lw==
X-Forwarded-Encrypted: i=1; AHgh+RrqS+ionPY8u66v28NDBULP7Ehyjq/p1traLFnip6uy/YCzFTE9BO5AphdYB2887pl9urTmFuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZcPHSqaY+FaQt2WlZwfyYUncoGOBJJlUfMkiCxYNbz3Z1bu5
	Al+vmflRgNgAxUtUnmpSRxBQreKCUeetooyABK5E/ru1KxmHIlUmlYFj1x55YRTUGKB8aQMTLMp
	2Vq5y+XCQU4BMvw==
X-Received: from qkbdp3.prod.google.com ([2002:a05:620a:2b43:b0:921:5ef5:dcd4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:459f:b0:92b:980b:e0a9 with SMTP id af79cd13be357-931036cf744mr365190285a.0.1784817776693;
 Thu, 23 Jul 2026 07:42:56 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:42:48 +0000
In-Reply-To: <20260723144249.759100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723144249.759100-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723144249.759100-5-edumazet@google.com>
Subject: [PATCH net 4/5] vxlan: use pskb_network_may_pull() in route_shortcircuit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

route_shortcircuit() currently calls pskb_may_pull(skb, sizeof(struct iphdr))
(or ipv6hdr), which checks if bytes are available starting from skb->data.

However, in vxlan_xmit(), skb->data points to the MAC header, so
skb_network_offset(skb) is ETH_HLEN (14 bytes). Using pskb_may_pull(skb, 20)
only checks 20 bytes from skb->data (which is 14 bytes MAC header + 6 bytes of
IP header), leaving the rest of the IP header potentially un-pulled in non-linear
frags. Subsequent dereferences of ip_hdr(skb)->daddr can read beyond the pulled
linear buffer length.

Fix this by using pskb_network_may_pull(), which adds skb_network_offset(skb) to
the length check to ensure the full network header is present in the linear buffer.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 10dd19eec09e266197ee51330a652f4e76c9643a..9ccbebda860480f8378918ff360deee1c46f3f7d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2111,7 +2111,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	{
 		struct iphdr *pip;
 
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
 			return false;
 		pip = ip_hdr(skb);
 		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
@@ -2137,7 +2137,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 		 */
 		if (!ipv6_mod_enabled())
 			return false;
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
 		pip6 = ipv6_hdr(skb);
 		n = neigh_lookup(&nd_tbl, &pip6->daddr, dev);
-- 
2.55.0.229.g6434b31f56-goog

