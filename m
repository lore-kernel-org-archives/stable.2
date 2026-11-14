Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794661041;
	b=fEcR5deNt8r/ndpooBVvCjzWV8Xgeu1VK6d3st+9m3WfTxNtcR4L+weIJBIcVTRzyzE4
	 o30dP8VrKF9A6XXxS7L9FPamGuyDQevOYKPJRzacIXB6XOWqHQ9T7y+rpWy59SEIHNpdd
	 9Sdh8JY70Yr8NtvrGfl04ZLMbov+sSubnl/btnkDBYuEoNOd/OY3UzRys/KMPgnbKGGmB
	 XNM6J9X3cnOYgSMDljQ/XEUYFPovh9oMOsiGo8a4Fh+e7miVYbrTokEI/PhdJC1Gj0P0m
	 T6mow/vs6UiULo/Y/RUlqg1Q2Z8Imfh+DDnjO4acEHxi7zQByGEM9R1cODTubDJ5UKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=9gKGnztOczuNd4xvzEZ+s0v96neMAAhFQuwPjwgllc8=;
	b=yDA6qXhY9qbYXtPtPe33+tHKLOrq0kQ57Us10/yUgEJtp+3uj/53agAEOSNzFQAiHtR2
	 TRKBpJ9z1g1YvAxGstHwSiRRK6J8fqFXP1mELKa4q5tSYfzNohlzg7PfvBQfl0+KClu9/
	 yN34idVw3FEyYgCkdpjQ+eWlNU5p0etccpQ3rnIGiJvocolJhh7/+PD+OWSnjC0CU2fB5
	 hiDMEyG0v3a7I5h2Z3yxB0W7DY/PInGLQ/GfmWPAnBnMYHJkW1bkJUozDYX0d5X+SHcOM
	 0Yj7F42NUmxQxS/GV+7VQ+HOF03ZtQPWjXHFJLbRZnhKc35hWX8YikDXYW4d5FBabMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Bvw5LNZT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802B606A330;
	Sat, 14 Nov 2026 12:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B802B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Bvw5LNZT
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E331B2022F0;
	Sat, 14 Nov 2026 13:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gKGnztOczuNd4xvzEZ+s0v96neMAAhFQuwPjwgllc8=;
	b=Bvw5LNZT3LIMcWhg6Z5zlEYJIpLrF2WXb6ahmJFG/DF1NsLVVy1wyhd1CowDPghL+HPyTn
	zImFi1qwQKcJWJei24swhHuyS5OXhWusWZ6SfTtpmbibqe59a8/FLQQP8U6fQN4PFXu8d5
	/BTL/9OmE7JuZ/SwMfMeXiBcVkGdsNyk/ouF0bM7yeD0nLdzDsP05I6b+bEjUGke2ds9zw
	zzEwnjVy2He7q1beYOjEahQMgl8wfqpmkl3MatLHWXhDnBXk/YtoQqIiAy1t+fVvi1IMup
	M0kUiQ50ljTQdxBXzKhcpd2Rhh/gx1KEJQFo+NMtMHr9O1vEPKuZ35/tg+fRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gKGnztOczuNd4xvzEZ+s0v96neMAAhFQuwPjwgllc8=;
	b=IwH/ZkVOe9l2nM+F/FE+S5mxd8OI6zAaBPvsP13ilSAPcjQ0lUyNP8AlH2cLPZPmE3HJSY
	DltqBp3ZqdugaCe9weugssE0lBVmyWVY7oQl4xrgQ1KllgZquu2NEFxdTWQT8DTUirYNNr
	T2pGK8ue1dm4Y3CblBvGW5hMomt+7lwOvBY782WmBkri1VsnrsMZ+bHDOVZj3KflNyFHLl
	1BY3enMl/eVz9KytmOgBJ2733z44W51ZXaplcvJ1KZFiky6mPyfjcMqpE/KtipWAjNx8Qn
	lTg2Gnh4Le93uKcSVE/z+NpkilT5fyrJQEZrs8K0u48aUZFVwQJosM7H85cA4A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794661037; a=rsa-sha256;
	cv=none;
	b=EbjRPEJTPdZcSSpHG7CQeiBrUNj/78RW8BAz0FJ90aVuJJgpIfzOhWV/2zShRLKSQ0k1AP
	ZzBIbVUy6oVQg3bQjNZJFLc6nmiKCLkn2JoeJpJpG6c9lfRdm0KAxQ9L1use568E9+Foeo
	IGJWkzaufcfSxVp4dvpnJFrw9nVchtS+71GJLVwdeKH9z7qCV/2T65s1mbvZ0Ghl4UaqFH
	K06Fq+VdYpQOjIol1UTWYyBUKbt2KZMqkXKJH0QibayrFKLTSP7y9nYYgMcNz1RBMrS17g
	fAHX2OMDeUWQSFncLPtLfX/NGo9OJXSftaR59nQU3Tz7EZrV6S3ZANQ6tRyX7Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSDJl-0048pU-2N;
	Sat, 14 Nov 2026 13:57:17 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7BBBD5EB9A9;
	Sat, 14 Nov 2026 12:56:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 13:56:15 +0100
Subject: [PATCH can 2/4] can: flexcan: flexcan_probe(): fix probing for
 m68k/coldfire and reject devices without match data
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-fix-device_get_match_data-v1-2-2d82025e9646@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
In-Reply-To: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=x2DoOAMK8qYYiTqT7rP4+/o++VZfdsYk6nV6J+hmNmM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6EVX04eNjRq7F+xbm96Z8qZO02jdpa/H6Xj67IpXjw
 q89A977dJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAi84sY/lkKzc8tOrKKL45L
 /htbg1dZthH/NSFenTS23zz/Uq4dtGf475uXeKpMaJK28NzK0wqFhjn8KV0iqTqnfh1U+fj6urs
 aMwA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

When determining the device details was reworked in commit 5e6c3454b405
("net: can: Use device_get_match_data()") there was no replacement for the
previous handling of non-of instantiated devices via the device's id_entry
which then results in a NULL pointer exception. The only in-tree provider
of such a device is arch/m68k/coldfire/device.c.

Restore retrieving the devtype_data via platform_get_device_id().

Also a device bound through driver_override need not match an entry in
of_match_table or id_table. In that case device_get_match_data() returns
NULL, but flexcan_probe() dereferences the result.

Reject devices without match data before continuing probe.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Cc: stable@vger.kernel.org
Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Closes: https://lore.kernel.org/all/20260618140147.142489-2-u.kleine-koenig@baylibre.com/
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20260528-fluorescent-sage-ladybug-43261b-mkl@pengutronix.de/
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 86b40abe9e76..2bb9e4184eb5 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2148,6 +2148,11 @@ static int flexcan_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	devtype_data = device_get_match_data(&pdev->dev);
+	if (!devtype_data && platform_get_device_id(pdev))
+		devtype_data = (struct flexcan_devtype_data *)
+			platform_get_device_id(pdev)->driver_data;
+	if (!devtype_data)
+		return -ENODEV;
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !((devtype_data->quirks &

-- 
2.53.0

