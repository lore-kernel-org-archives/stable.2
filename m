Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=137.74.80.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525225;
	b=DF+fy8MnSCI1+w3rOQ1bftl91tWpc8Ek1ZtmOede0zYgP5gpiZzlrpIROBAIDdAyqTJ/
	 iMAqQ8asBraBv16tC5PN+IfD5+2tTKUaQPVUac4ki0w248Y4UO0RXqJhDcP+ncJ8VlZJS
	 toy6PvVcbkLpGRZwtCyi66HucZmrgdjGSuzblrY6gUHVwIg4GGofPLu7ehX9LBgfjdWi6
	 oTiBYQKybVXRgnMt3iSAXZOFE/0QIbX6Lb4Rw0b3hGB0G0j1wIqRMDoEYesnlOBbqI55U
	 Mjoqo7RjajGOltFiVV54WLKM+v/YhqQbhkGdNbmMbMbTs0krVUSmjvTknJJtC+oZ9sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525225;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Server:X-Rspamd-Action;
	bh=Wc0FriMqtdGfYFNx0DRDijwtuOHKoQ6sLdI34ZDJgWg=;
	b=IkZ9wzMUVDLE1jIUf+agoEhZ2aGx35xa53OC/tRrRfePgwek7FzT/B4vWpk1Q3ReszHm
	 DFwPIJqaQN84r4bylmlIzhQhEvIaTFCC8Sodb8uZ3J26KAYlygCv4OnEg6Db9FDX7yBN1
	 xAWPCu3IN9gaeHvTDmdC2i4WQXpxy5XzB/yDnfvAYxiySzSJDX4VCgdmeWTndvAQqBWQH
	 EAh9gHJlm2nuA+eJaouZ4jTUjsxcQoiABQjY1/aR9hDQR7tFIXhVomRgmqu6+ZPMdrXMd
	 PpwqyUF0SyfQ0zA73to5JLebhBY/eNeXVsJdL67Zw1oRjbFMQ32/BnQf+Gg8N9UZ3HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aosc.io;
	spf=pass smtp.mailfrom=aosc.io;
	dkim=pass header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=Tbe7elIv;
	arc=none smtp.remote-ip=137.74.80.154
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ABB606A31E;
	Tue, 24 Nov 2026 13:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60ABB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=Tbe7elIv
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id E3D7D20189;
	Tue, 24 Nov 2026 13:00:16 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.38.223.107])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 80E3D4009B;
	Tue, 24 Nov 2026 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=default;
	t=1795525210; bh=Wc0FriMqtdGfYFNx0DRDijwtuOHKoQ6sLdI34ZDJgWg=;
	h=From:To:Cc:Subject:Date:From;
	b=Tbe7elIvYAPaXWKXhV+0LcgXq6j6CZ+fCPdIGpsee2BKBWjAjQskfWVqMsJJc8cFm
	 iM6mIVI+Fn4d1AC64zLJdSduBoXVuLxt18hRoJPlNQOzZ1VxHBPHF6Fv8URDV0DOMC
	 bfctKITNlxbIEnfWZLrQPbZIfuqbEkUQUCQHJKp0=
Received: from avenger-XINGYAO-Series (unknown [111.202.72.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id AA950E1E4A;
	Tue, 24 Nov 2026 13:00:07 +0000 (UTC)
From: WangYuli <wangyuli@aosc.io>
To: andriy.shevchenko@linux.intel.com,
	westeri@kernel.org,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shinya.kuribayashi@necel.com,
	ben-linux@fluff.org,
	WangYuli <wangyl5933@chinaunicom.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: designware: demote arbitration lost message to debug level
Date: Tue, 24 Nov 2026 20:59:56 +0800
Message-ID: <20261124125956.755858-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.55.0
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
X-Spamd-Result: default: False [1.20 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	R_SPF_ALLOW(-0.10)[+mx];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	LOCAL_OUTBOUND(0.00)[];
	ASN(0.00)[asn:16276,ipnet:51.38.0.0/16,country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+];
	R_DKIM_ALIGNED(0.00)[strict];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 80E3D4009B
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action

From: WangYuli <wangyl5933@chinaunicom.cn>

On a MECHREVO XINGYAO 14 (Ryzen AI 9 H 365) the DesignWare controller
behind AMDI0010:01 repeatedly reports arbitration loss on the touchpad
bus while the system runs on battery:

    [162434.524491] i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
    [162437.878670] i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
    [162452.208445] i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
    ...

Up to 94 messages within one hour were recorded, while the touchpad
remained usable during testing.

Losing arbitration is a defined part of the I2C protocol [1], and the
I2C core already handles it by retrying the transfer [2].  The driver
logs each aborted attempt before the I2C core determines the final
transfer result, so at error level these messages flood the log.

Log the arbitration-loss reason at debug level.

The driver continues to return -EAGAIN, allowing the I2C core to retry
the transfer within the adapter's retry and timeout limits.  The log
level of the other abort reasons and all return values stay unchanged;
in particular NACK-type aborts are already reported at debug level.

This follows the practice of i2c-imx (commit 1de67a3dee7a ("i2c: imx:
Check for I2SR_IAL after every byte")), i2c-mpc (commit 1538d82f4647
("i2c: mpc: Interrupt driven transfer")) and i2c-synquacer
(commit 0d676a6c4390 ("i2c: add support for Socionext SynQuacer I2C
controller")), which report arbitration loss at debug level.

As a consequence, the arbitration-loss message is also hidden for the
last attempt of a transfer whose retries are exhausted.  Arbitration
losses remain available through dynamic debug, and the final result of
a transfer through the i2c_result tracepoint.

NOTE: The cause of the arbitration loss on this machine is still unknown.

[1] UM10204 "I2C-bus specification and user manual" Rev 7.0
    (1 October 2021), section 3.1.8 "Arbitration": "No information is
    lost during the arbitration process. A controller that loses the
    arbitration [...] must restart its transaction when the bus is free."
    It is the I2C-bus protocol specification, which NXP maintains as
    successor of Philips Semiconductors, and which the kernel I2C
    documentation itself references (Documentation/i2c/summary.rst):
    https://www.nxp.com/docs/en/user-guide/UM10204.pdf
[2] Documentation/i2c/fault-codes.rst: "EAGAIN: Returned by I2C
    adapters when they lose arbitration in master transmit mode".

Fixes: ce6eb574a1d9 ("i2c-designware: Tx abort cleanups")
Cc: stable@vger.kernel.org
Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
---
 drivers/i2c/busses/i2c-designware-common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75..93256f3786a5 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -783,8 +783,15 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 		return -EREMOTEIO;
 	}
 
-	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
-		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
+	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources)) {
+		/* Avoid arbitration loss noise. */
+		if (i == ARB_LOST)
+			dev_dbg(dev->dev,
+				"%s: %s\n", __func__, abort_sources[i]);
+		else
+			dev_err(dev->dev,
+				"%s: %s\n", __func__, abort_sources[i]);
+	}
 
 	if (abort_source & DW_IC_TX_ARB_LOST)
 		return -EAGAIN;
-- 
2.55.0

