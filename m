Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28708448D03;
	Tue, 29 Sep 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716052; cv=pass; b=liJBlAU+UHlqZ9v/ytaU0onzC/wznDeJKoXphTq6aXI1RZ8D/bYCTSp5n9bvRelyfVD0ds3d48jZE7l+kLrkU8vQ+ud2CiW5fqJTvKm+LXw0MQVqMlKCDP0X4g3BWAowgTsQln/RvVp+N6I9CgIJg4fMiZwc5Y0wkuSeMkoGypk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716052; c=relaxed/simple;
	bh=xlBpmG2S8ktOUfyR9BnjBv4YZtFPuPM4pSpKCik+ybo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfolsE6o0EIY3DO3tNO933u/FKIaRZPh7d1+Vl3ms259kJVTHA1qeoi1JLse1Coo8WS3a6wWiB6EUHecbvsb2Xzwm6x4SRM4zl7ILX470hRHDZh/THT+9UKOE6A4EUEBRX6OxuB3swDNrIvaCfoAgYFVnCOzhh7PJqUakdvOaEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZCYDG2ay; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZCYDG2ay"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E58A4201E6E;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0e4sLg8VRKC7HcEYnp0BWef6sI/CdcfN6PpzxAScpc=;
	b=ZCYDG2ayfVxJTUkQ2p6d0/etGEAKlz1W32zjXs/DePKjHDntjcNXtrE3/ausL2ccXYMgBn
	RLQ6/lAow3uesldbR18PAubVxWvwzJdk9GkrrmK+PziEYtR9JXnrg+UnCuXT7Y7NNKZgwL
	fV+uPbCwx7joL9s2C5zIC9NfwY0na31SWenV3C4ZsThja96jEXKFkTJjHDxCkiVmnxxbYq
	Ug1abTLMH4qPS4mLK2B3uW09+Dnpu5FoeJI3kUveqyrVWxWnnkr0s+Urudv774xbLEqNK5
	Ux5nxATDd7O1UX2zVJtxgOkbKCbJK1PGxC1alRQsXS1w8FJLcZijOWfNKYw+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0e4sLg8VRKC7HcEYnp0BWef6sI/CdcfN6PpzxAScpc=;
	b=STrXbFEQcxOpi27XMlPIG2e1cJBC66LNfDIQahvu5HSFUzGmY1yvJ0sboX4n1rpmAK8+2n
	Igvo9SCibEsW/qEEmJUiWHlkBiHSzAZO8NHNkLDu6DYrQ3/Km2pLf0QPCDs9VJS6QI2ELq
	bQWeXHXAVNl5u4qqMtjk01CoP9ZzMeGzwaghhei2+tdj8ii0bMP/y3z8jNhZRzLLq0fdE8
	QUcrYid9jmjqErHDerIlhhRhS4vOccuE4iCbs7ModwGD4+KGfmzf+2ldOkyVC8h/OZvzcC
	jv76KoT6zexiqSRa8ozlu5WCiYz82yEmcWxqmfpNiXZHwiPe/9zvyyN2v34iwA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=OIM5YzcoltveXhez5ED5wy06zpjwiDlSWo/d72RkpOy8yNjxRIEdnAzAmRFwdneYuH0BBT
	ciiUYLxCSoxRMrJZ//h5vwIfKs/Q3JHs4VHIW7cJUlbst/eCzlt51uqwKCNiaSZMMovUgK
	N8+vZKXsMcyBFFgv06BcgkobLrAB7WQaLcxXz5PHMaiSDcUItYljSNiBHFG0Hq/AoOdvoE
	tA8Kb5wvpKMvnNULU28ZjnLoaOLW/Y6fRfWxYxa/XXMOkLFvAraPcix+uoimCYzVvt19mT
	v99r/ROy3/ojqf8d45hxcORVMcHyK/uM01iTy1wE72TaiVZSDHkTRJOEqGMKtg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3w-2X;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 86F955B4CDB;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 11/16] can: gs_usb: kill RX URBs before destroying the netdevs
Date: Tue, 29 Sep 2026 22:44:01 +0200
Message-ID: <20260929210700.1183036-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

gs_usb_disconnect() destroys the channels one by one via
gs_destroy_candev()/free_candev(). gs_can_close() disposes the RX bulk URBs
on the shared parent->rx_submitted anchor only when the last active channel
is closed. With two or more channels up, the earlier channels are freed
while their RX URBs are still submitted, and a completion in
gs_usb_receive_bulk_callback() accesses the freed struct gs_can and struct
net_device.

Fix this by killing the anchored RX URBs in gs_usb_disconnect() before the
first netdev is destroyed, and in the error path of gs_usb_probe() before
the previously created netdevs are destroyed.

usb_kill_anchored_urbs() waits for running completions and a killed URB
completes with -ENOENT, so the completion handler returns without
resubmitting the URB. The kill in gs_can_close() of the last active channel
then operates on an already empty anchor.

This issue was found by an in-house static analysis tool.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260923070352.487595-1-fanwu01@zju.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..f604358c8259 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1595,10 +1595,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 			/* on failure destroy previously created candevs */
 			icount = i;
+			usb_kill_anchored_urbs(&parent->rx_submitted);
 			for (i = 0; i < icount; i++)
 				gs_destroy_candev(parent->canch[i]);
 
-			usb_kill_anchored_urbs(&parent->rx_submitted);
 			kfree(parent);
 			return rc;
 		}
@@ -1636,6 +1636,8 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
+	usb_kill_anchored_urbs(&parent->rx_submitted);
+
 	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
-- 
2.53.0

