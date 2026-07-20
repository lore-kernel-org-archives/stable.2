Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9B431A33
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558505; cv=none; b=KzIrdHz6/hI+xbQcyyPv4ljDDTxBWh0P6of9IQ8N5o2MwQAcYvbyNSM6wFdaYBNwd/PvPJen5uLHxa6IimSunpBbhhV1dbTcUqHMqUkiWRE7/ii9HUxtt/2kG5AC6nU2T/hdohoUz9w2ZWFv9i3dIhqPpYN8JlGSW1r0yJqk2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558505; c=relaxed/simple;
	bh=ZN+Gspagq1DSI1BqGu1pGiRI/0LJs+zTie5Lx5uTn7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQgpcp4aitNiW1qSCuIX9tGcZIbY6Zr/UHdUr4iz4fKMieBUYldjYdGEl0dAznA7lFxs2gORd3MQ60YD1TR4mSAmUZaRJqHw0mASVRXvhhJthL4Tmqwk7A9b6PBVLQzH3vZ4a9KncNl6oN56H1CBEOlvNyO74l3hbpFHVjDaT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=P3RTaZr7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="P3RTaZr7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso32035695e9.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558502; x=1785163302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uy38S7j197pJcEB3NOA9lnctPRrRAYWG2UNLZRWX3ns=;
        b=P3RTaZr7TGtZu1ZquYsL69eM4B7OZ0URflBEthzLENIbccSdZrdzmZy+cNRD9Ef3nX
         E67NmaRto6cTj0UPafzAHF9YFxOcRnS9SiUpzogZH/X5FLg5cnfi94vapNS9c7CV+AXR
         5V4JFIc6CghhoyBEcfqWP+Xm8Re++gsYWdyKKCb1px6Pl5tvGmcme9LcXzrLdiPbUivA
         lmfXoAsdppO8bEwojz3vGLaZeD1mO6QzSSFRofGbNThmedI+KTE0BHTpXc7u9DLuO88n
         rO4ssq+WHLQXMcfZClZG7XyV4TP2RxFjkpzic4uvgwXsZrLvhQ59AJC20+PnXEWstESx
         XTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558502; x=1785163302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uy38S7j197pJcEB3NOA9lnctPRrRAYWG2UNLZRWX3ns=;
        b=gUJnxT3kwdCjQr089QB2UhtJl8ewUv3eBJDSd2RxlVxRkGZMIa82q/mQpaodAZKG/Y
         4YZl+GDBywIqN9E5CffTeGhjOnX0aD6GaxB1W/SQ+LsMRrLj+Dq1yZdGyrpjMwvn7z/T
         3fbKxByrlRIx/RfPUdYMgSVqoqH8FUHKd4KR45oLzCM529dmtCYR/sxdRoEkWvqUrH84
         a7dxSMoIapVtGASEuaFZ3S4Z2Mmk88Moa1FRSweE1aLyfC59NuVinnEY1ihsWC+vix+d
         hQsbN9honTGLDlYTfaPWuVG5dj7Y1TZe5aT7iv7Mj9RFOeY6i1YbcaBUd1IAfMQXIYiH
         wxZA==
X-Forwarded-Encrypted: i=1; AHgh+RoBQTR8QzLfGaQl/qvy2jtNsIcSsDYwpwlP4XW1NYOa41gMEPMwDbBtLWUIl8HYxYbL1k9rjNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIbDobojpWvkfmk3W4ksN3nri5QRjTshv55Fb39QunDdt3mHt
	noIIo3dnFT6028QR7qgF7Z0nMcnBEXYg9NZ8w8k5AIzSJxcZtuZe9tvwAhYq8jAFuVFpudOYIKn
	XZePhfz/2GK4a9d+9UW9luqbqAh+YiU1gM4oPKsdvlTZZBLSi1eU=
X-Gm-Gg: AfdE7ckGri7tjYKcndrRFJs2X+bAE1ds63LuDmdnGm6rLDaZhV+lQP7yIK8rPX9HLgi
	4lcGDnA97ngc5a9RoqbKXtyDxTPhhbGgqbtc1GybWLrdi45Udzg52ziP6K0uvLvgcKVat6RBft/
	4qT9cQ4Dd20Z4A30ycnEHQbF6IbgS6zPZJkOpVd4kGej/Jmy/o3WHl+/VWvL8g2vSdjWtjAERGl
	Zsw35YwgZH12NfKyh25P/mhqkC+BfRY8fe00w4QaI6hpzSl8wIu/u4CXKnttEMnZRpnhj+6b+xk
	YsuKp673u885th18X0pIKUDpjGwAlKtMUbxsjbNJsDfWE4FoCo9br/zBks6fU4b6xrefAwik6xM
	/BNpm47dk2aZ4n4OQUzMp6ZC2KfDnQ0YtHJngqnS7zvikxudFkNHyUT8DGoBcXsHx+JDRUMAbZQ
	0Ndy5WtMv2n0TDGAS0HdbyvS64EA==
X-Received: by 2002:a05:600c:4ed2:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4955fee6628mr38242785e9.0.1784558501713;
        Mon, 20 Jul 2026 07:41:41 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/6] ovpn: hold peer before scheduling keepalive work
Date: Mon, 20 Jul 2026 16:41:28 +0200
Message-ID: <20260720144131.3657121-4-antonio@openvpn.net>
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

From: Shuvam Pandey <shuvampandey1@gmail.com>

ovpn_peer_keepalive_send() passes its peer reference to
ovpn_xmit_special(), which ultimately drops it. The keepalive scheduler
currently queues the work first and takes the reference only after
schedule_work() reports that the work was queued.

Once schedule_work() queues the item, another CPU may run the worker
before the caller gets to ovpn_peer_hold(). In that case the worker can
consume a reference that was not acquired for it, corrupting the peer
lifetime accounting.

Take the peer reference before queueing the work and drop it again when
the work was already pending.

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1844d97154ce..2b6096d8b1cc 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1284,8 +1284,10 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 		netdev_dbg(peer->ovpn->dev,
 			   "sending keepalive to peer %u\n",
 			   peer->id);
-		if (schedule_work(&peer->keepalive_work))
-			ovpn_peer_hold(peer);
+		if (WARN_ON(!ovpn_peer_hold(peer)))
+			return 0;
+		if (!schedule_work(&peer->keepalive_work))
+			ovpn_peer_put(peer);
 	}
 
 	if (next_run1 < next_run2)
-- 
2.54.0

