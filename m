Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6A502575;
	Mon, 28 Sep 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624012; cv=pass; b=eknvjvPTHQYBQ7Wxxciv9VuTt3iHdd5N2oeBv0Ra/EKnBTnSIKlqBvhAboxeuQvxBljo+LclNzNCbJcWe8ky47+/+qJsg/0WnwyJ1yZbCu86korhI1ylNvhVZiXjBrQWhDrR36ueSS6cmaPqV0YHMla3Ius0gZktsVg8yCrnl54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624012; c=relaxed/simple;
	bh=GzsTedIp/U7bLZDchwdlS8BV7pxZDQ/KvGK8jj6Qw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLm1FEf6wT7pz449Vc0VDs20kyF2K3pnrHBlhsMOOz4Q2LM2uEGJvE+ZGXidamrJJvaLq213pNC/+G8EHoZWwzvZAya/XQ5ejUTLP10FVK5Cl62TxbIU1k9TgyNr6HmCCJA+wVMSZzkcz0SFah2xmJeH0oAyN2ULq8LCUb4MtpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZIO/+g7G; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZIO/+g7G"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 96D802022C3;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPRu+HAH8vyoN35jGPt55l03yl8QX1Iz4TTjeqzaFxE=;
	b=ZIO/+g7GHUBbKfaaOw99ghZ/30n933R6aRpqElJdnnB6p77ZnBQzJEHkNF3rb46djvbFHj
	zdLmh9iatVS1A7C6Xmp3e5uaiD+fiSFLOhiWUHEiuVOJyOk4EE6F3gNbzP43l92sPzlafD
	6u5qaCrMyNAOrgH7JAwR6i6FSSOpn/MOnXd6/EDDRwnQ+53UXXEcx+jaupYf3Y3LZ9RusJ
	WfdDa7jUUKOvZ15BISqWT/x2Nds+bpm2kPANfqzOQXuld6/OG4VfnepXqVAFy6owPCee3+
	shM0vVgcdMsejriRKo/YPr9xDayFeWeJGBU1xFVC5x0vdTStjSeZGrCEh54Pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPRu+HAH8vyoN35jGPt55l03yl8QX1Iz4TTjeqzaFxE=;
	b=Cgafsd71V/2SM8RM+hKsgQtjPaefGN+zyn9CaRycusxXsB+ORHpLV87z0jyXdm6mAqgFS5
	l6knU+ZGEZLu0Ss7dSKD6X0h04xKKV7YXauht+5z6Prjbla2fHCRJEguzKE3Fu8u4CnWxh
	ORmy+fOpzKv+tXGhAsrpkzob/znZ5Pzlg+Jqtzeslw/MroRcpad5HpuCiPaMPUsDfqtBQE
	oypMaDZMOr7eKeJZHzFTt1m8M1VBYqKURx2xaT+Aqd4RvUK3LtBpUgvGe77GC+zjSslZ28
	N86Nahwr8OIi1ERktDvxNgd2MyKErXzuOvqOSsLHkFPi5QngR7LZzGijArXlXQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=gL2NZHTbZHj88hk13PSfNgLGM52lWjnqlTi+MyuR0SjjzsWJSUDPiCpoCVK1fWiQ/BEe/P
	iv2x5wFWPQi7S/vHoxCrKkpV2tIL0pLopi0rSWpnOWjT/kC6j78+EqCpAqxLYkSO6d/3es
	9VdyvWfE6HoTjIG1OyJtdr+1YZgs4+vt+L9NjG3//UPklrZQjWnFc8U2xMhxbjWEtKGwfy
	IHRECulcWysSdpVLj3Kw90COGjFzAnSFl9b0Tp4tBqu3LtM8UEh6M3sIpta981C5LXTK98
	u3In9svepNGeTwZpfLS8CKs68z64J0Joz2RCWnJzYTg5mF2pokKtPB1vCqWY3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6U-1O;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 271655B1557;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 16/22] can: hi311x: drop hi3110_lock before free_irq() on open failure
Date: Mon, 28 Sep 2026 20:45:23 +0200
Message-ID: <20260928193312.553632-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
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
index ae90e6716de5..2be851e8907d 100644
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

