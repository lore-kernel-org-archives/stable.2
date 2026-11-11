Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411739;
	b=FDu2gCBly5b9dzA9PYu5iX7Xos4drS5xCB84GRGldjuzT1rziiqYeHAJFD7MzAgbZN2m
	 y5zY90N9SkwRs8KL8n1zGC0o6orVtkQRhhAgFQN5vzVGi4AXtTuSIszOKU4spK0ghPoiU
	 RxFal7CWOU/z5vtVdbwiSHiReX4UXYyntVYBZ14FoFCAEUvpB6JVXAtLHIT9sHcI1SuwW
	 W1gKOU7cSKvNAKeQd5j+ZhJ3NAyjJ1IFK3dQyf+1nQdosAom0JiF4C3fDV4lYf+FfxRwI
	 yQQukx46VcYojoVb9rvpNo+BSqHExtwFudPy6ortrrXqcECIcnEBWI3ERZxQlz6f0hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f2svfin22g08o5fv/WK77SgkqAotNAGeVNpe2VRdJxw=;
	b=v9PZ/vAmiXvyyK846Fninzjex2Io+MAHcipfjaJqVWlPDUr/NU2w8wnUk8irklVazp74
	 G5AfAFRBqv40XhdlyUmq8NWyF/3v501IFTOUcOHOoim2eEcxjcgnkZpvECKeHVAFTKQ3Y
	 7cuW1fLPDGjJr618I3fUVAQMfswE0nGSKGDG1u1GR1FXykdDsvWedl9ZOuqRtwRUZKEDk
	 4FK3z//3TR9xVigPjd3uBT57sYpDmioRxCf5tRbqVFJbLlRawc8ArK2pLBYlKXvIFU2pN
	 lPLZaI2+08d82kllaGT6UhLGy0h1Aswzz/w8FkYDKyEUspzQaaFdfOAoeQR6y9DDcug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8RfiqQI;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15940606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15940606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8RfiqQI
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so5008902eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411738; x=1795016538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2svfin22g08o5fv/WK77SgkqAotNAGeVNpe2VRdJxw=;
        b=d8RfiqQI7NwKR9QbEjP1Py9zneis7a35gzFVsS9RbCKQRkWPhs1xV+kOIGKNRamnyd
         usTz00G4WvQKKHfSfblfEWeQ4SGOP4ULurqpdRwFooFEQsBtz1XVAn3hKPrNehSB8yNv
         Gw0FSvkHNy8emHd54jKk6Uv6f0OJjAFueNsOrpp/3l+KzqXCUM34GjIK7Sv8jdt+9jy6
         fr2zVP1o6GiQ5OGb4jI6SY7ek3+RNSLounadoZmIjQ+CFz8civI79x2PpDSzVxuQqy/P
         7WnWpvkHw8j5t5V0HUGiXof8ajjV/Z3s02QBk/LIPhyhI0iaSlPcYj1dpPG8W8+gDXBc
         S6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411738; x=1795016538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2svfin22g08o5fv/WK77SgkqAotNAGeVNpe2VRdJxw=;
        b=jSntLyd0tO/LZS8MwWZLTQ0LmPmm4iNvCyIIJ1VywymbWOoemeVKxOMTCDTRkCXkFQ
         E9NQO8nOYxeGRrojUXZS1R6QTLfatbkst0lWZD5I0zmALFl85gzn6Qn/oTExlLlr8P1D
         sEhGTmiT57TvR6PNpb8dji0ffBSEpWMlQIE082t8ff5krlszKgGMUwjLmw79YFrgh1MZ
         hlTWE4JHntjIS5tbEATYmwRxp50EszaIW5n0yppsejM/K386ogxhlzI6u0qzzm3sSS/t
         ddC8RD8Kmej7WK4pSf1P+tBKgdTs6Rl+reag6cND6MSEecOlmHitgIMJ3fQJrMnwiTGl
         dtfA==
X-Forwarded-Encrypted: i=1; AL+hErHVmpp4X0Os5AiS7KS4IlpmoftMYm1hLYQCDdsSV9Q3uhb3BdNShmj6py2bSo5cVpnQL4nx1mg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/n+hK0Ddvicumk1Hzq4RIfvb1RM5Ru/QeTVQO/DqRy2mV/OMmD
	iNebGEN/toJ2CA/AeNPnITd+Q49e80TrOkdWD0f80yzHOFe7TxLKULyl
X-Gm-Gg: AYBFou3kZU4aueC+HDdMfGWY7mNfv6Nicqu1vbAAdCkYPfE+X1m4sWz2xiBYvzxD461
	0g+jCETEHBsz2Ynhc8DYf+es6J5q8eKXGM+lBJiBkoaQfBstL1esypmr2hA1mT+fXxXcuvtpCOM
	9haPlXOd+rlNhuJtVztC0V6gLwgADcw392i9uidme7XtMKnG+/nake6dMXB7TG6rNmN+m5XZ334
	MOLCz1/zDFtI6EH3lH/feDpSLsK4QIJnJQ70Sa3kMvXH205WGNZowJlLFvtVUxKB10c8+bRb5dj
	rQr7DYLfgBsjxlsJc31K87AO37bO6vxjgSVnaSnfSTrduDnePBgVxUiwVoQWbNcsShXq7uZsMtD
	L6Wxk5VX7v+Uelvyv0OSAgQ9YB6sqIqT0WIlzDI2QO8AAkHyGLomiW1jSGS7SPW6+/gMDkkvEMN
	NEyI1U5qx6dnMzyMV4FozAmwsuPMKeD/v7oJuE/Ry9oYQjA8C1gUMrCOJNwp03G7x4JrjcTX8n0
	1k6NJGAn8t4NqZ2LZf5Dq8zLnfOZfYdHqBBinfgJCnphtMrU6aM+N9S8Xl9vaecInPBuY1kLc9a
	vbyGXpJFXIT0D61EkMQCuw2mXg61KXxOAtbZIfptGrzUfSEA
X-Received: by 2002:a05:693c:80c5:b0:369:f182:8e99 with SMTP id 5a478bee46e88-37686d33267mr3130321eec.35.1794411737783;
        Wed, 11 Nov 2026 07:42:17 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm16762001eec.11.2026.11.11.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:42:17 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] HSI: ssi_protocol: cancel xmit work in the stop path, not ssip_reset
Date: Thu, 12 Nov 2026 00:42:10 +0900
Message-ID: <20261111154210.3178313-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ssip_reset() runs in atomic context on several paths: the rx_wd and tx_wd
watchdog timers reach it through ssip_error(), and so do the HSI message
->complete callbacks (ssip_rx_data_complete(), ssip_rxcmd_complete(),
ssip_tx_data_complete()). cancel_work_sync() has an unconditional
might_sleep(), so calling it from ssip_reset() is invalid on those paths.
It is also called under spin_lock_bh(&ssi->lock), and the cancelled work
ssip_xmit_work() -> ssip_xmit() takes ssi->lock itself, so waiting for it
while holding the lock can deadlock.

cancel_work_sync(&ssi->work) was added to ssip_reset() to stop
ssip_xmit_work() from running after the device is torn down and freed
(see the Fixes commit). Move it to ssip_pn_stop() instead, which runs in
process context and is still on the teardown path
(ssi_protocol_remove() -> unregister_netdev() -> ndo_stop), so the
use-after-free fix is preserved. The watchdog and error reset paths do
not free the device, and ssip_xmit_work() bails out once main_state is no
longer ACTIVE, so they do not need a synchronous cancel.

Fixes: e3f88665a780 ("HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v2:
 - v1 only moved cancel_work_sync() out of the ssi->lock section. Andy
   Shevchenko pointed out the ordering vs. the timers; looking closer,
   ssip_reset() is also reached from softirq (the rx_wd/tx_wd watchdog
   timers and the ->complete callbacks), where cancel_work_sync() cannot
   be called at all. So remove it from ssip_reset() entirely and cancel
   the work in the process-context stop path instead.
 - The three timers never queue ssi->work (keep_alive only re-arms
   itself; rx_wd/tx_wd call ssip_error()); the work is queued only by the
   xmit path, so dropping the sync cancel from the reset paths is safe.

 drivers/hsi/clients/ssi_protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 7c6ca83..aa2d6ed 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -401,7 +401,6 @@ static void ssip_reset(struct hsi_client *cl)
 	timer_delete(&ssi->rx_wd);
 	timer_delete(&ssi->tx_wd);
 	timer_delete(&ssi->keep_alive);
-	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
@@ -950,8 +949,10 @@ static int ssip_pn_open(struct net_device *dev)
 static int ssip_pn_stop(struct net_device *dev)
 {
 	struct hsi_client *cl = to_hsi_client(dev->dev.parent);
+	struct ssi_protocol *ssi = hsi_client_drvdata(cl);

 	ssip_reset(cl);
+	cancel_work_sync(&ssi->work);
 	hsi_unregister_port_event(cl);
 	hsi_release_port(cl);

