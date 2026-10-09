Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1764E4C32;
	Fri,  9 Oct 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553427; cv=pass; b=k+4lvlI/nCy4gk9u4gwJxgXt87B1q7Eb7gitriIu9MvawjL16GvlY0QBRKhQ28Iz2GHMtwIlkA7VRQHZKqD6rFykBIbZIhMe5Mpz1pARswSBf6txNmhtBa08FRYU0Gu1z4cWw36pxW8cAwKiBFBjBajcABIJcWg5ZPPjg2XaIE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553427; c=relaxed/simple;
	bh=06Az96UGp7SzCP6JAbNjGNMeQGAIKbq9O+FSQ6JWOfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clroU5zWsIJ71+R6qP31i3zRarTjLPipXR5Q4M0WKu+7iLusGyMw7TuvCzykUtmcvdn1/hh/JEGZC4miQumgALje3D/osK3mfTBG/FsfUkOIWAH7dlRIQAa9+61KX+eEcTeGFKcn301nv1V7cRwk+Wzoo+veiqZha+lTZWR7Xdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=L0N+6+0E; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="L0N+6+0E"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B8E2620261B;
	Fri, 09 Oct 2026 15:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Gpnwf7g3tzX2DIiALPLpBsH0+1WppuuG2QHFVECfI=;
	b=L0N+6+0E6d5K83lC7xcbFxH3ReSfyRDGbJTxlD1ocKyUHzJVEbgk8ZcQya+Z20tnG9GL5e
	ttfc2wyQnGhzQNb3Mfw6GacWIhI3JCblrDVxBAmvKlYSCaqalpEtGGtJUgWtObQ9mU1rcN
	SJPZK2NcelZQ4kBZZRhKTidvRoC8b1I5mprEdXGqm18EF30tRKo9oXaukQwDYP9Fb5OTBU
	Uj82K+qPW+VLv8sKIgIaN47onRid39DfFxF376fpjxfAGoewAh07HwUZP2VJFULhsUcZf1
	x4IGu8DDJgvtDy//IEnIlBpYhEUpfgYt71ShYwCX+TEMdbxOAX/y2Os/lWfUyw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553419; a=rsa-sha256;
	cv=none;
	b=GII/3cUKzfroqO4jeRGpLf3VclCWbxEe6S2Q9ecnCWqIQ9QhCSopRJeqS6xCcAGpDZTy32
	1jLBtu1GJrQ8wduZc6n1GggQImZcpBr5rTmPFAqVT9NoAUqDz1xFbhdCyjXdke0ulGY7nf
	pJgCX3d0J66vwaS7rAJ39aExk6WLn1ljmO1lxcRTIT6WTBdwK093LEei94/pR2S1+5dBlO
	pAlrJkBZ/8E3VzrDLb56i56yGYjAfzCWJtqYvShmHLFq43Yiu7e8bkbpanxKGCJSmYkFXs
	uZoy7S3pkwvICZMrdS2Cm/JhNfFYuaRuJ+Ts29Uvj6b1VahJ8W3Tm2mNERYlvQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Gpnwf7g3tzX2DIiALPLpBsH0+1WppuuG2QHFVECfI=;
	b=dotGzo094Lkoqz/AaXbe8HtmIwTvQEkqjvjNO6TofJ89F2hvXi7KJvkW3UnehYnf9ZKbZ7
	E/A3/5OHYOeF9y48JqghWT2z2F14K91/wfDYW2z77DIv6Kg2gjQtb/n9gX7GbRqHnlnXAH
	2iSF4jhcw7CVGZPPcO/faX+yZwXPAhqbEEYBHehElvW68HhX4W48yIISCBwHOhHBzsyBFx
	7uPOBIcUViNy1HUNO8PCe5ECKjIslvVf8Qg+HcZ29gv+sHyOXWN+4X+/TRTqweg4zLKaXX
	4pt33HIc4hpVqWUZIGNITqbGljk411tFoSgvtk9OsvB0I5V1Mts1cqj44or3CQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAst-0053TM-26;
	Fri, 09 Oct 2026 15:43:39 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 401A35BD8DE;
	Fri, 09 Oct 2026 13:43:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH net-next 29/37] can: f81604: f81604_close(): fix use-after-free on disconnect
Date: Fri,  9 Oct 2026 15:28:01 +0200
Message-ID: <20261009134323.64064-30-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>

Unregister the URBs before cancelling clear_reg_work to prevent an URB
completion handler from scheduling work after cancel_work_sync() has
returned.

Otherwise the pending work may run after the netdev and private data are
freed, resulting in a use-after-free.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20260824133009.CF85A1F00A3A@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Link: https://patch.msgid.link/20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/f81604.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index 4c147b9d6d69..bb155b876924 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -1075,10 +1075,10 @@ static int f81604_close(struct net_device *netdev)
 	f81604_set_reset_mode(priv);
 
 	netif_stop_queue(netdev);
-	cancel_work_sync(&priv->clear_reg_work);
 	close_candev(netdev);
 
 	f81604_unregister_urbs(priv);
+	cancel_work_sync(&priv->clear_reg_work);
 
 	return 0;
 }
-- 
2.53.0

