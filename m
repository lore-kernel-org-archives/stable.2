Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55843148D
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558502; cv=none; b=GFdalzBckVuI9l7y5MTru+BlqsNU62twnlYV2y/nUDuQ1hP9KMo/vg3EOfSzpqlSyL479DgYZLV2gZK/1O0IckFzpury07/2uVWEOU53ZMGjRwV0+F0zf+Y7/YNCKvGfppun0ZVXsnlcB3/cvljG66o9onybR3HNvE/j/8TvEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558502; c=relaxed/simple;
	bh=Rjxfbu2ixfmE3fwPBjdfM6C2AhLtSjZOtOTJpe6Rb5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxGqGIz8D77wtpX49Nn0osUQieHvnNhhx+a5PVI4aVvOFDajEsDuzwfsHGHVw7IUrg+6ZmV1PrLAqTbzMZroDbZWZQXwpQ3SqhKz0rH72n/0QfbalUfmJ+2ODY3MvzH1YTvMn7W6L8QeXKkyJtWJfVTbsdElBfZHm8FVSktuNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FIXZdNkH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FIXZdNkH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-476d8e647e9so9307296f8f.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558499; x=1785163299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJvZ8OaZnVOpXl7ZjbrUXHLy3L3qYJCT4vrhru00Elo=;
        b=FIXZdNkHTBgRthH7GIbAAPb/ScdYI30JvnKs4XQjV6S/R99XlSMqQyf4b2fFiZcNo2
         mpuwIGjm47/ixxB1q4Xq/jw2lwZ/S+y1aKPzInHZIAfru0biodL5SjsvfqhFV1v3X079
         Y1Sz2oJboJa1mceTpNrrSBFRYh8LbQAi5Bln3494XbDfK5nzgw3q24mTzBvOQkPHJ+qm
         vdgpi+vzWS6JP7TsQHltCIuxLSGAK9th30DH/u1/urLI1M0SpiQYZnXePbQgDur0Utbd
         50WGZGxGaycpJnL3KhwiS0Mhv34ZSI1WG7wWummEywwdy7z6VG+U5XF5C85vh4dFrjmZ
         u4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558499; x=1785163299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJvZ8OaZnVOpXl7ZjbrUXHLy3L3qYJCT4vrhru00Elo=;
        b=g+dYE0MfgPluEhJzHNcO0gkBvefVrFgEO9lQxt7ZX8j6Kao5C3FUt1XteDSxI2roOY
         zpGQrEzlZImNmggZwjVwwm0uc0kiqmoBDZTYbBCMFoFdngdC6XsC7cHxZJw5+0WooLSn
         vxMzB+gHuviyo9BrXrgyLeF5fdNF65d07S7eJlJzixpwS+XhfDPGnUt9Y/hTl/Ashkse
         XvyPGzsfHAu61xAemhS854nkC2xLiOzDX+K/d3aQgNEeOBhicGeSwX1xt5snrDmL7Uy0
         GsQ+NZw1yZGl0ydRwiteob9oOCjZoaBJGU9uY/3M/6C52RJSvXCAc9SA1rQdow1iDHtx
         8/tg==
X-Forwarded-Encrypted: i=1; AHgh+RoCImJcCoe8ELsLQv5S4J3IiFbqbWq3lA7WbVryrmx4kCAjCTPQZpsiHOT9LEhe9QmoYWuESHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUbpuGcTxD915C410UqjcTLepPs/miH3nz/TVjWKPgUOVqsw3
	ZT67BKFBC/J8ubWsJ/W8EnCjj/+kO4RCDHpR5ncxQVglN8+Gz48DkQJdPj1q4mDIo4SGgXnaTl9
	BM/Rx+/KwaNcLpZpEBzE/y/rc5m0oJZCeInlNXBzYiWOn4wdVpwk=
X-Gm-Gg: AR+sD10VRs2pkQk6dbQKFcgTy1rK7Rz/AwcWcPfNM9IudnfjVBEHkZySwyuiIxzlOT9
	uXMbGWnX+1zSMPKFGBdy1XUHxq3kzvDM7q3pnJ5CxIg7fx33Hx4u6buN0Ek6dpqPoYePHb1zYRb
	TXXvOe2dUyqz7angHcHdRWa39O0FLuqZFGIShkv+KhBY2MxvhuLjvNUC7kZptuNXVykMRHOZii+
	770e7DMTIhBi8TreItKG1wCx2lVmu4itrmhVzcwhOPMjrdgFbe9mUegPUdA2nZJ/vtlHTGw+5kk
	m7WMUGzFKeJJ9g4xXAdPjlYiNV23JTjIPiuhKRrl1IhPKBW0ynMlqQGLf0J7Rt+No1iyzBV4heR
	2yltuv5uE8vcU6I/mN83lFDJrr4dVaCvEQ0MDDxsgsx7Gxk4MUdABJQTbAqQ+ew1h6hY1gxziUB
	MZHdDY6XykbSZOykC/vPzLYrW5rA==
X-Received: by 2002:a05:6000:2582:b0:475:f0d1:eb67 with SMTP id ffacd0b85a97d-47f6233dafdmr19217690f8f.52.1784558499003;
        Mon, 20 Jul 2026 07:41:39 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Pavitra Jha <jhapavitra98@gmail.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/6] ovpn: fix peer refcount leak in TCP error paths
Date: Mon, 20 Jul 2026 16:41:27 +0200
Message-ID: <20260720144131.3657121-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720144131.3657121-1-antonio@openvpn.net>
References: <20260720144131.3657121-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavitra Jha <jhapavitra98@gmail.com>

When either the TCP RX or TX error path calls ovpn_peer_hold() followed
by schedule_work(&peer->tcp.defer_del_work), and the work item is already
pending from the other path, schedule_work() returns false and the work
runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
exactly once, the extra reference taken by the losing path is never
dropped, leaking the peer object.

The race window:

  CPU0 (strparser/RX error):       CPU1 (tcp_tx_work/TX error):
  ovpn_peer_hold()   <- refcnt+1   ovpn_peer_hold()   <- refcnt+2
  schedule_work()    <- queued      schedule_work()    <- NO-OP
                                    (work already pending)
  ovpn_tcp_peer_del_work runs:
    ovpn_peer_del()
    ovpn_peer_put()  <- refcnt+1
                                   <- peer never freed

Fix by checking the return value of schedule_work() in both paths and
calling ovpn_peer_put() to drop the extra reference if the work was
already pending. ovpn_peer_hold() is kept unconditional in the TX path
as it cannot fail at that point.

Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 433bd07a4f1b..0af14055c39a 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -151,7 +151,8 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	/* take reference for deferred peer deletion. should never fail */
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
-	schedule_work(&peer->tcp.defer_del_work);
+	if (!schedule_work(&peer->tcp.defer_del_work))
+		ovpn_peer_put(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -283,7 +284,8 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			 * stream therefore we abort the connection
 			 */
 			ovpn_peer_hold(peer);
-			schedule_work(&peer->tcp.defer_del_work);
+			if (!schedule_work(&peer->tcp.defer_del_work))
+				ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-- 
2.54.0

