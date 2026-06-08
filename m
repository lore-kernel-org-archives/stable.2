Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40D330305
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931279; cv=none; b=bQYspAoughWqUzpkuYeopn3SHzVG7HjDJN4omSizVx9VqMU76pCWbxjosb36ZEqcbJmyKkpfet3IFTCo/sjOjzZnDTLmVIWtqOtogzQiXs9UcP+pQqd25wCuRAZ1IxXvSTndmaIhHfeR7S8NXyP2+7PiTnUqe9J20voCV8w/pM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931279; c=relaxed/simple;
	bh=GVeaFmDl3Zv2NMxAhA6o3DrDcWESPgBn6yuhNtSkhDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDUb/Sgm9RgklUb2ny3b7plBydMoh2ShpXALPRb7FCffwTozk8tP+GS6eV8d1ShasrdIHLszZqEp2yNOTe9r/jTeoJi4n0ClnDH1hxikC2vrqoYo9G7bkrRvoxQUSDaEBHwSXunCmuC9Ar4vEVVsj9s9N5jYNvEm1VrOvTUJHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dw4yIfJh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dw4yIfJh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so49152485e9.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931276; x=1781536076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJCy09ESTxEx8Ki/esNqRYV/Y8EcyDPn5yaJERV6vkI=;
        b=dw4yIfJhnAfXw5XRCcd5+1zSfTSDJb4oC9IuZWz6PbfiZjVD1XVGxkprEtJD7PbJrD
         fNaWFH/fTF1JdmDNRdcoAXSsNz504eJvXxYSJISRNrv7ME1WmMIlFEii++LrAyKrv12M
         deuyf+SLspdLil90DBmAx0CusP66V8hzg3tP/igegHZ7nWLC9BO7IJZwvAc1Vw1q8YWP
         /YFcxXkyIuLeaNumtxiXeLYVJVSuDYL11dCM5j/FeQNNMUKxfqmgQo91OJ2DZ595bY2V
         zcOuVW30AYK6pJ8XvQpwNVxM+KNgAp9XjFeFY1r0voY7H6CcQoRmByHihFMMQ8MiWvZj
         /S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931276; x=1781536076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJCy09ESTxEx8Ki/esNqRYV/Y8EcyDPn5yaJERV6vkI=;
        b=qtj0+f+hrDVZSawuKlD4cjviv/yxGJMUgYtNLWtJzXWk0LUpBlXg09q2c3SU/JPCAS
         l5qiGKCkyu3AvhQHg+ltBFLNcRn3ErnMN62vjJ7JCVMzIAH6aiifdonMpEq3zp6k1EQr
         aIh5gt8Z+Et9VbjKB4tedJzad/Iq/GhWWsLIHA2McAldv5qP9ObqhddADLtr6wyRrUn1
         zgIJfP+j7xGP8PZy8vYbU7Gv2arEZX2dGqYxNo8jcKKrsmYuglD5XHilGMl5MonLXmvw
         P5AciQWNpJJu5gNXlLyIdjG/Gw81iIFfy5boi6955NEJ0G7k979ykrXA8M7exClomBSw
         Xtzg==
X-Forwarded-Encrypted: i=1; AFNElJ9Vp+YLVyFUF0VI9xffAW95pHPdvlMU+i8JxgL/DvICVb0/HAPuUgv0A66tJXpXKGB7beAzF18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbIJgPtGXrmmifiEGvb32JzHvCWu6Mp3GwjHyVQ7fk+5Z+XuF
	+jYNudGu0s52Isvfqj1IpgfDuI1G/XzrkpLs17veb2t5rzOsxEY6e65InNuB+aGDmQQeapBlSaN
	UElkxVlGDWbB8NbPM02mwBxJhLPik9eIO+gImnuQ9ogwYDdqd07qtq79UFfwPziS99Yw=
X-Gm-Gg: Acq92OG7f5paZ0hNsD94ZT1QsvUqWolHeCyyfJWY2jkcEBPx3TIrtQc6cXqIjoqA5yE
	MyrUV1sjU3sGws8UCKTmu44kuhDQm8PjAdFL5njvEUTZiG/DrE8jAq6HIiKtBplVU+l7xzc58Ar
	TZRP8NSyFV1RFYMqKUAMvn1xsFHxvRDR1Teu+qPe6EwNYr+DgjKnC9FhFTxodXNP2Xc5S+99ywf
	Hw63oohAV+sXt8N3+cOV0SQK9+bsKDy819228etpWJzwIhYli1iuJN6ZA1/WN9Z9q4F8Acr6l7l
	4nx8QEQAGkYQKm3HqdWtewesrHe/IEy2te4N4KqPMgLz4enLHKmVVl4/sB8wnsiPTOTs8QC7EDN
	4tMN+pzX4MU/xgh93zXt+sW/Qwv12r4b1dQNzHp8qTpk5uU0Rwa1Uqd4vIz52sBOr90CgHPq1vG
	MjRqBgUP2xbf5l7PODTeHnmr1dHgzoRXtlCFVW6DIe6q4p+EfrUFYI9KoD+A==
X-Received: by 2002:a05:600c:3ba4:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-490c2525dacmr289221285e9.0.1780931276284;
        Mon, 08 Jun 2026 08:07:56 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:55 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/6] ovpn: fix peer refcount leak in TCP error paths
Date: Mon,  8 Jun 2026 17:07:33 +0200
Message-ID: <20260608150741.3320919-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
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
2.53.0

