Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510692;
	b=ZxiEZGWLChv9rkqYibWvA5G+VIGDbuETA0OSkST43rkrCk1B6g1y14WOgkQqOFmQ0XHi
	 DAVjgW4+7V12RqYp96eUET06jnxXfOP8wZjncskASAG8v0lRbSVaBbnpJJW+KX1goKxE7
	 9GGkfY2A7G1D09lJC0KMyac5PjW7sLBbfbcvCZo35XtSTb3urxwNWIm/txX83tWnW8Ldm
	 VNzlsD+cwjO5XfxwcDZmFcjSPydcXcu4ii7GoF++VqabykxHkyKW5/4D95IxzhM6BEZ0v
	 qaoS3VbHdAOx/da9MAh8JPU0sSAMsI+ldE3B8CcX+MgtSuKhdqIPFObNRsUs+PFmI5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510692;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sfW2tbmWaZxyyxEoA1wluudOlezM1GvW473v8XzFwrY=;
	b=5e7aqs3fCredezDQ+Br2DMglu5ZRgkzuQMmiec6pSSghh57zT1lkOOO13wEyRWp02DfQ
	 wHatazOyAECRfiA5VM7afA3d8TxZZ3Bwb3DSIzuJ10A1n2CYnckjy7Lt4w0/3Aj/CTiTY
	 aGMGCK1+lPae0CqRLMVh6VNSYsp4Ha6mueN7o8kFdrkL4s9iD9ltZrhRODaRLUqTfjvC5
	 1dZvkcT1p/d2gl6mbWL2n/bJrVNnTsk6H/by7ODP0yVFBwR8apsp3Ma75GBcEF1TgCTZD
	 2iKMQo7SxjlG2wzPE1WDwaamg2+tSr7Ddhqv69slJVCsOlp4t+m1rapMwBOJEPFfbaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gxUwHuuI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640060A260F;
	Tue, 24 Nov 2026 08:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7640060A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gxUwHuuI
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EE949205A2F;
	Tue, 24 Nov 2026 09:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfW2tbmWaZxyyxEoA1wluudOlezM1GvW473v8XzFwrY=;
	b=gxUwHuuIQjXpzBbnK7dEC4y9ET/0t264+tkISBXjGvhmDQS3ha69GganwgZ9q4QE7DMkav
	fJHB/bmzE4nMqlxdHiLi3RZgaImWQEk+MdpDoArdHmLMBxESixXK/iqFAnS1ju0+MEA9lp
	+H7Saa6VAX2xCuRenDFneKgg/wXNWsasSkDfj/0OEAvyazU0j5/QWl/OVnxCmQMYerqyXK
	vIQ3IpKDMOVExOj/guAy+ouaLBmGzAEScmJ7HGn45AAAFMhwZ/+rizu8ovUw21eg8wh7SA
	ByJowxES5qZNaoEy5GvmDtzG4GrB3FNJ24IRL3PqP4P/0Wp4ivN5T0G9WT6YAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfW2tbmWaZxyyxEoA1wluudOlezM1GvW473v8XzFwrY=;
	b=LLV+lGfc0qFGaK89XW4KRoFqjUAnFAUxSgwGD5GCWENHxBDPOvk3fsxAsK4ZjIWuegimgl
	slOev00Z8czo/2FTesp8p8GtaXj1IjBMdGhSgmdrRAnmyLOZF+MiqGMk5SyjzIufxxJu71
	hoIDd9y+2ahad2LYIs449FM9tvyzt1LEV/lGhSzHHUh6bb++tOYjk6m4ebBmLJUDkWeAUw
	5wZ+GHgvHzQn7byrnoslk0FgoA2ybDW+6icfdaL4ShOzViao4T87OEeIvxdVzzj7HUsy+8
	gwmX7QY19qWNFGXfKKwufRMc80P8ErC2cud9M+AJxdodXjOGPXBvY/tERvpKww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510688; a=rsa-sha256;
	cv=none;
	b=IYunNs0FVJugs65FXGx52CsvWwaFdHi5IYxnu3qtZc87s8P0eEZNbC5Luc8pyFrUMkAgOz
	qAVQL9BSNlUtAX46cm1F/IgbdbiuFfJR4gLqBhccRtt2snBo2F5G6eAoGZowc1sh41REyp
	j3xvjwqRBfKipFEgj2+n0YsZOu2MvcjH7EFg1FHENJ54LQr54xptod04bhZVzbmR/yNo/V
	1dMTgykNYhU/dFKl4Znwe5nxfifm+23yNi/YnD7jl6GoICD2/Jc87bANIhtuMKkaBP57qv
	nBORz3Q9pBKfkFM/+umdHMXX9mck2vzRliQVtYC9kZKbnLqM25p6Ujoe/oah9Q==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	stable@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH net 12/12] can: flexcan: Fix probing for m68k/coldfire
Date: Tue, 24 Nov 2026 09:51:39 +0100
Message-ID: <20261124085757.1093632-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

When determining the device details was reworked in commit 5e6c3454b405
("net: can: Use device_get_match_data()") there was no replacement for
the previous handling of non-of instantiated devices via the device's
id_entry which then results in a NULL pointer exception. The only
in-tree provider of such a device is arch/m68k/coldfire/device.c.

Given the id_table only contains a single entry just hardcode the result
of `platform_get_device_id(pdev)->driver_data` and drop the unused
assignment to .driver_data from the table.

While touching the id table, drop the unusual comma after the terminator
entry.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/20260618140147.142489-2-u.kleine-koenig@baylibre.com
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 86b40abe9e76..e9b822678213 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2077,10 +2077,9 @@ MODULE_DEVICE_TABLE(of, flexcan_of_match);
 static const struct platform_device_id flexcan_id_table[] = {
 	{
 		.name = "flexcan-mcf5441x",
-		.driver_data = (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
 	}, {
 		/* sentinel */
-	},
+	}
 };
 MODULE_DEVICE_TABLE(platform, flexcan_id_table);
 
@@ -2148,6 +2147,15 @@ static int flexcan_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	devtype_data = device_get_match_data(&pdev->dev);
+	if (!devtype_data)
+		/*
+		 * If the device was instantiated via the traditional platform
+		 * mechanisms (i.e. not by device tree), device_get_match_data()
+		 * returns NULL. The only remaining such device is mcf_flexcan0
+		 * (defined in arch/m68k/coldfire/device.c). Pick the right
+		 * device type for that.
+		 */
+		devtype_data = &fsl_mcf5441x_devtype_data;
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !((devtype_data->quirks &
-- 
2.53.0

