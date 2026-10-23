Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792757906;
	b=S4YFqWmA6LPfXvajvR5niMVx7Tb0/42Q9/IH0zOin2akndRsmWWlPRo42Yg0ScSkBj3L
	 KwBbARzwOAT7bBr2KE3fvHZo5L3v4rXQJEoKtwXuJ7U6/nsG9d+9g/sYz+lqB3kIyAUt4
	 1S+oyV+6nd8Yr7u1hqjtzxmliB5Dk2cJPPVvMDB8GzarLZ4Z52g7uDWf1EmIN20ihB4Yg
	 wq4Bf74nKpHM3L2TPr0oRDW/VHBQx75uDpnsIbIwbIoZ2t3GqScuVQWYp1Y4pHCpMEbnI
	 PpJWM0IicN/XkPg6JmqfZckPmVo1tKSa7K/XlfU7P+nxVH6/5b//dbXBFphorxzJMFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757906;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=CQGfUn15Wlyr4AzRSl6StuOzwdvPKva5yjGDsjCQ328=;
	b=haraFAT0LSZ5rr+lD/1MVvTozdV6sCfRHyJXh0zn2rdk8QfXA9+apb9wzLUdgAA0Gzlr
	 OE/niVNCgQtUOfFTAi0MGuem/gKqbw7NHyK6xm7dYcx1Y7XsLR2oSTwBY+53NhxWvmhDv
	 gC775oi1oX0vxOf5unEsHICogaDfqIwfUmWX/xvJtLxE9sxAKL3bdHksdJzABapq//QHe
	 vqTWWBxssn3Su1MYStl0gN2wetVda52pZLiXNJJ8veheTWJP+stO27GBojMxd69t0kLti
	 W3mY+0wJsBYHKRoChS/O1HiILeWg0r9m5SsFBnoZcoFhWa4JrKE2c+eJvzZc+VPvcaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CPDrlfPO;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="/hw2HLrG";
	arc=fail smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28D606A320;
	Fri, 23 Oct 2026 12:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A28D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=CPDrlfPO;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=/hw2HLrG
ARC-Seal: i=1; a=rsa-sha256; t=1792757896; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HVw1iofPKjKqqCWBY34shdKIE+ILXTTwz/FlitZsrDiNVYWYPSR3fVMGK3wkpT0GFf
    XZiKWZsJYrIFcDskbXu+L/3i7fglhBDed9XUIPRMjs1T+F1DlRKA9us+NA90C0rBrij/
    MqY/gqZkz51/hE0EFSRGDVyqFBPT3h6rMeN+GI6l4tGcvAf/ifvgVtjvmEYdFiAl5x5p
    RPVLgIu6WVrNpN3VzW4gP9X4APojMKdzxqrLcnuDbQCXRVfnPkoLa2ITvxuXDDEoC1Ik
    HizsFiaoWcNwkKsGc2TZjCSbttFMqFN7MhDaNwf7muVPtDg+dB1NsxroTM5gQA8B02l1
    YVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CQGfUn15Wlyr4AzRSl6StuOzwdvPKva5yjGDsjCQ328=;
    b=rTSVM9oVuLqJgVWWVO/+ENAYkYzKzLOC2ut1sd1E8XeEEPmLRa6YWbd1nmBefkTv8i
    oS2VHPF88J/hjouHku6UfcOkd3XOftIGTUbq7JOyTFsVofHzsaEQ1+vjD3Nql45OpGzC
    aJLJIsx9XVFoCL40QRvkITmFXDj92YNfpVhB5JQ0zZGURy9yYtLkR8dsi3QDar7zsoQ+
    ArrtxGtXjLD3p5pI47SZv2upLUvDxfNF+qqWdUPlqeNVXkuJ1qYSJxJRpP6y4XsC4IeC
    xUS76vXUD+bS8lxa7WGGuOQWTnj8CbqXvM0JiJVv/lwJcOj53CO79rJ8b1gx+3theQ1K
    gu5g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CQGfUn15Wlyr4AzRSl6StuOzwdvPKva5yjGDsjCQ328=;
    b=CPDrlfPOOF+LFzXmL0pGIAlcP540c8z4u0mlzXKdyyXi6QN5BxzlqUdu2B+Xoq8W97
    x7SE4+wVUAG4/eUb85EAGMaPX5Jcqbnay1YWLqb/7Po/2W5UGLk/rY4qUXbSEAPrJmOM
    jYeGQroFAoSAWz/IWZl/7V+3nqj8lz/N4l1ISa1K7CQPqfhr9h6Hid9wyduLdaDgKJlP
    Trwo/U78kB/A5gSyXPnqfP1A59Jyp//GyjfaHmk1Q5sOrm3lAVpuNbjoS2l/7FeIkvan
    7vCIk6D1t+vHiRXxpltQb2MtvT2rDerHEDjVu0CtcdjRawvsuHwU6mB1GZnBRDpSwGID
    zJcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792757896;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CQGfUn15Wlyr4AzRSl6StuOzwdvPKva5yjGDsjCQ328=;
    b=/hw2HLrGqX6WIYt2n+A6ZQPQQvC3hLLn3OyLvvxH/iXhvVJlbjKjHaJf2lmSxzXTDy
    M8LzLW1xA8b5En8JKwCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29NCIGt5o
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 14:18:16 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org
Subject: [PATCH v8 5/7] can: isotp: check the return values of can_rx_register() in isotp_bind()
Date: Fri, 23 Oct 2026 14:17:59 +0200
Message-ID: <20261023121801.3052075-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023121801.3052075-1-socketcan@hartkopp.net>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

isotp_bind() ignores the return values of can_rx_register() for the RX
and the echo receiver and binds the socket anyway. When a receiver can
not be allocated, bind() succeeds without this receiver, so the socket
does not receive frames or its transmissions time out. isotp_release()
and isotp_notify() later try to remove the missing receiver, which
triggers the "receive list entry not found" warning in
can_rx_unregister().

As the device has been checked before and RTNL prevents a namespace
change during bind(), only -ENOMEM can be returned here.

Check the return values, remove an already registered RX receiver when
the echo receiver can not be registered and return the error.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1a272ce6a2bd..da80ef606ce0 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1622,20 +1622,29 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
-	if (isotp_register_rxid(so))
-		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				isotp_rcv, sk, sock_i_ino(sk), sk);
+	if (isotp_register_rxid(so)) {
+		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
+				      isotp_rcv, sk, sock_i_ino(sk), sk);
+		if (err)
+			goto out_put_dev;
+	}
 
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
 	/* register for echo skb's */
-	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			      isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	if (err) {
+		if (isotp_register_rxid(so))
+			can_rx_unregister(net, dev, rx_id, SINGLE_MASK(rx_id),
+					  isotp_rcv, sk);
+		goto out_put_dev;
+	}
 
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
-- 
2.43.0

