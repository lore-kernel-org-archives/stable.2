Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE9039CD14;
	Wed,  9 Sep 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975082; cv=none; b=X8wuazN8rzBBUko4CPjKNE+7UNNbywWypWq8HZbfxgUIF2wT0IeIJea9ffqxbXPz1bhUPnpy+MlyEEi57tuBZIugwuFlaD+zgjsnpJyVuxbInFMOFuMQC9E9PPLQJ8NjZ7j2+36OhGujdNawx7Jy64aiPr6ta9uAneqZDseYyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975082; c=relaxed/simple;
	bh=fOLMYKi+nbgaU8spr87cltPjB56CXayMVROFNlqZH/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsf7IJTCT2y5mhZ2CNAkjrKe7/RV0jVFrnPHtRZCJ+Fr/XNv3ZhtXpDACvvFmJxo8rc+XiVhIfx95Y14cuqq4+IeolDfR54qx0CV42Y53DjnJVsVwbRXvYa0mjHCFPus8jP4aFs2KacQ9NAinC571ciAEIYH8HxOpl3NirLFRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=ptwxU3jS; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="ptwxU3jS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788975072; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aOQCNzihXEftM2gN4JZ6DNSjPsRK5i/nabKuwuh9rR4=;
	b=ptwxU3jSs4btt9eLyxk81TB8kpTVz8u7VJ2yfUbSvh6V8IPwXb5rnmq11NR0s3rxeUJqQpxHqA2bZdmLPZ83HfCHZKZ2dJ0/V+nywCb5qhDRBzSxUz2RzS0lxoa23zROWWodYPGOWhMLjUt6YDEbOHZaJHBttDYAy/KpvuIM01Q=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07544608|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00433042-0.00078299-0.994887;FP=9821315156926840689|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.j9p79sU_1788975069;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j9p79sU_1788975069 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 01:31:11 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH net v2 1/2] can: j1939: reject TP RTS with wrong packet count
Date: Thu, 10 Sep 2026 01:31:03 +0800
Message-ID: <20260909173105.158202-2-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909173105.158202-1-liuc63@xiaopeng.com>
References: <20260909173105.158202-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_xtp_rx_rts_session_new() computes the expected packet count as
(len + 6) / 7, then unconditionally overwrites it with dat[3] from
the incoming RTS, even when the two disagree.  When dat[3] is smaller,
the session completes after fewer packets than the buffer was sized
for, delivering a short (zero-padded) message to userspace.

Neither direction of mismatch works today: a smaller dat[3] completes
the session early and hands a truncated message to userspace, while a
larger one makes j1939_session_skb_get_by_offset() fail once the
offset runs past the buffer, aborting the session anyway.  Rejecting
the RTS up front does not break any transfer that currently works.

Abort the session when dat[3] doesn't match, similar to how
a4fbe70c5cb7 ("can: j1939: j1939_xtp_rx_rts_session_new(): abort
TP less than 9 bytes") rejects out-of-range message sizes.

An alternative would be to silently keep the computed value and ignore
dat[3], but that doesn't actually work: the sender only transmits
dat[3] packets, so the receiver would never collect enough to complete
and would hang until the rx timeout fires -- a worse failure mode than
a clean abort with a clear log message.

  # RTS: len=100 (dat[1..2]=0x0064) but dat[3]=1 (should be 15)
  cansend vcan0 18EC8090#1064000103002301

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/can/j1939/transport.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5..c40db4337 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1672,11 +1672,16 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->pkt.total = (len + 6) / 7;
 	session->pkt.block = 0xff;
 	if (skcb.addr.type != J1939_ETP) {
-		if (dat[3] != session->pkt.total)
-			netdev_alert(priv->ndev, "%s: 0x%p: strange total, %u != %u\n",
-				     __func__, session, session->pkt.total,
-				     dat[3]);
-		session->pkt.total = dat[3];
+		if (dat[3] != session->pkt.total) {
+			netdev_warn_once(priv->ndev,
+					 "%s: 0x%p: packet count mismatch, calc %u != RTS %u, abort\n",
+					 __func__, session,
+					 session->pkt.total, dat[3]);
+			j1939_xtp_tx_abort(priv, &skcb, true,
+					   J1939_XTP_ABORT_FAULT, pgn);
+			j1939_session_put(session);
+			return NULL;
+		}
 		session->pkt.block = min(dat[3], dat[4]);
 	}
 
-- 
2.50.1

