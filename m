Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25E4E4C2A;
	Fri,  9 Oct 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553425; cv=pass; b=dW68Ed5puLYbDUjjKgwF0Bx8LoC8euf+rFyR0LdLUCRdkPMH85meYoNRNBzu26QisqTFGXiCoID9pOfr3U6L3dsItfWClqUepi1N77rdtvYvkngvNNdfw8UTwqeNEo+vN614RLDkr01z7wjjbFOEKnsN1m7GVNGkDKJG/D/pFdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553425; c=relaxed/simple;
	bh=x1Nd4vRT2xLszxVwrgyCu+Sd6j9q1rdp2tu4kVuYVB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQcezAYuhL77qOJ6MNARKtgFXPoiAvbBlDiqIk9kfrr5zxRZemxLpRXAMoFaiJ+AMbJaToXBTru4QFROSZRE9iuPBh5WO8zOckJ0Ox2ARf+TeDLkuVygmC+5ZTubXcktnzoJPwUa/nZZG4AlQa8oxh/p+C9874fhii/Z2VuoaKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=IpdljkBB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="IpdljkBB"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 08A4E20261E;
	Fri, 09 Oct 2026 15:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYLAgGO5ns+ZsMHHqCh6jyF6z5CM4Swh1FlK9fiv+e0=;
	b=IpdljkBB99QN0c/mcJFmMN+umVKfiuQCx0Drs/lnB+Dt1dN6+u+5VBOQckqgAHXN/2yp+B
	o8dSU37hCs6WC2Oo3fZzv28gKCwVlbga+MgIQttDcqkWtuyAppGZ0dMc8xfJbTlcfHfwhI
	TspH9AUoiArKhXypm3w05B6e3rLmYsRyseLVowV7PCf9vFkr5//Cf9HiLVJAcgKm5e7x0n
	49gKzQJBHv2ZOiSUPUJUGVBLOOFbIz9r71O963gJ22CGSkJB9Mtti/gAyohSf+qFt8D+cH
	WEzycGdu8nQNda+S/SiJN+BEhqjIOAHAKMi3urDvEBbBvEhaCwct132dcmwNQg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553420; a=rsa-sha256;
	cv=none;
	b=JpOJTn/l2lFYH2IUKsX9g/IR35LgWzGNhFBRkUy6gy0EDFe6+i3xSTECOqtgYBfn4XB5Ky
	TXDvm409KGh2xpo7+7an9hS6zzqa77ym+CcSStlynIkT/8cDnvrEKxJ2+NV4TqnOYMsydO
	CMjNbXQWwszUQVMJ84xiyrD1iRDajn/Y7R5EnLQDPvIaYEvrFpLF7mNf26PQC7wXa5Yxml
	L1cS8e45T0g+9k9Hugf13toDcyL9GnOjCcr0enjfesWyRFhTqzzo7YfzSfHD/jqXScinTi
	oUZn3riH2TPdLKsa5aD78uWeODO/BetmyDBh47mvrQ8pXeYB2KLo2NGITnl15A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYLAgGO5ns+ZsMHHqCh6jyF6z5CM4Swh1FlK9fiv+e0=;
	b=GCKMr6hdznxhXDsocm3FvrBlY0TNlsExDxk04dgzrons2rtJKrSO8mXIKE4DqOcY2uEHP4
	LOt2zSFLJLNBsTEDlviRzXRj2ELSc6HAFRHcmEoXfRSwkrKgKinmFC7HXnbKsKt4cv+Og4
	McgHCqiyMz/eyrU7wSspyJlpEGDinTcc0vOz32alB6ePDY6ZsLcsDuqPNIsDmUNbCWRT9E
	+YajAicU8f/gm3+wVL4i1Y8ydxAfTXGXMbCaRnx76Cc374qGhqgt9is3CtBUYCRJPG64k3
	QTTM1opoD8XRAQfbndbMXwWLZgZH7RD9fJkxiRYcoa/DmsFiFLNWl4QsBm6qhw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAst-0053TQ-31;
	Fri, 09 Oct 2026 15:43:39 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7F6625BD8E1;
	Fri, 09 Oct 2026 13:43:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 30/37] can: hi311x: drop hi3110_lock before free_irq() on open failure
Date: Fri,  9 Oct 2026 15:28:02 +0200
Message-ID: <20261009134323.64064-31-mkl@pengutronix.de>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

hi3110_open() requests a threaded IRQ and then performs hardware
setup while holding priv->hi3110_lock. If reset, setup, or
normal-mode entry fails, the error path calls free_irq() while still
holding that mutex.

The threaded handler takes priv->hi3110_lock before checking
force_quit, while free_irq() waits for the threaded handler to finish.
That can deadlock the open() rollback path against a pending IRQ
thread.

Set force_quit, drop hi3110_lock before free_irq(), and take the
mutex again for the remaining hardware cleanup.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260820020631.316418-1-runyu.xiao@seu.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/hi311x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 076a3efa1bff..927555b5d581 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -787,7 +787,10 @@ static int hi3110_open(struct net_device *net)
 	return 0;
 
  out_free_irq:
+	priv->force_quit = 1;
+	mutex_unlock(&priv->hi3110_lock);
 	free_irq(spi->irq, priv);
+	mutex_lock(&priv->hi3110_lock);
 	hi3110_hw_sleep(spi);
  out_close:
 	hi3110_power_enable(priv->transceiver, 0);
-- 
2.53.0

