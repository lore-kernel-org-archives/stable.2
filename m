Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311048;
	b=ZeHrjm6rf4qC4sVhujr+W3xqx4JcX9TzMfAC/zKRf0O9Fjl7b2F3OqKqNAbRIjxD1jBQ
	 bqhdUAIj2tPBWMr2DWGzz3Q0/S9zjLJF1RWq3AI8wRItniuOIa4pgvId88ba9lGaX/l51
	 8VyH8/qTPTbgxJReeD1EV4vYjW1Ro2uMg1XQYLvmF7Qz8x0znH3lINryMZtmMX42qwkXa
	 jwRfNN0Z+boyzVRLrHasXpiVwStWZAAy2d8rVat3iwlCauUTOWA0TKce2sT+1jUIVdUR2
	 8lvr3xTqcPcYSOLicY83ZvJsa2Jvq8OkDgT+4I9KshQu3DuhA4iM4XkZ7ZsGuLaH4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sTrsrtp/N3MsoFW0Udr/uhsvW3buCcp/9OPmY8EXS9s=;
	b=vqKGVXe4zsscukjojO9ZpEb3FkTa1hE8h9zgra0LvRVUNOZsRl1ILNHPkCPzstAuFAvF
	 6REcYtdnKSyB+dlOMc5agvNGd9k2/uqMgAaL2M6SL8C0l3cdQynKt8PiHNL9ll+63OfpF
	 M/OHXSvFyKdhIV93rch7TqmIK/a2kHyxUolf4KkKFWiU6gsAT7E1WiZGVr59cWSkC0DSp
	 wzCAZKqrIEUyS2ylylrIo749NCQ6/IJ4AUvAH+4119qumE+8bqOxVeKxZZY97jzYpXJlN
	 +it3cw0dqF5kOsqFedkqQOR18DzNdbXk4YPV9QyE45z69pSt/TW71i9KClfI/69FG3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O6HMWVBV;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8252C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O6HMWVBV
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2890378c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311048; x=1794915848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sTrsrtp/N3MsoFW0Udr/uhsvW3buCcp/9OPmY8EXS9s=;
        b=O6HMWVBVln5XP80c2bMEK8+zD7RjvqUj8izRi31qCuDgXZ4dYDMjCL+gRh4os4IzmA
         1nuQGss7B7ZgejBA+qzsIHKjGh3cxcTB8YsHbxCAIlBIoqIt2Wevjo2asv0YjOZqt+w8
         EcKbYVGSvRzodNPjM7fVMqfBsMwVx08e+XX1vYee1/0joE9wbdyvnyC4IPBK7ngcY2tN
         LkxmqpQZvLKJntF6zADGKa8xXba7omnUSlsdABiro03BZVe96JK5NPFwV6c0QN/yfl1r
         LpA9286AFWzQkEoK1qBW8jt0CwB5G5PVttu/ree8u/aXOU/odXxkkMfF+UFKnBM+2HYA
         KJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311048; x=1794915848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sTrsrtp/N3MsoFW0Udr/uhsvW3buCcp/9OPmY8EXS9s=;
        b=bJTU4IIS2cymyxBG1wVR3U5FMuSDAM9C/p85c8Yyhtrcr+d0/0ZQcMrxRY5MTdRFZU
         tftHwcFx2KnO9VRhBtR297kw9t/C8p3jEtRt8+UnL4T/1agZ0ixr4Ybo4Uz90UbW69nt
         Pg+6shPXWdjNW/tdV6vslBsKIGgRhWR/UfAzW9g7gm2FgeXxU24g2U/MACTucqtRAeIj
         2NtsTREYtpZI6QXPC/5od1tsvYEa3AApjjIru3ku8Xo5jgVFDiw8ZVaMhZfovsg5GZq4
         8v2oQQV27MO90AuwGUW1ZnAi5quz2YoPg8A4KWEUHr79lw4HUh7jcmXz+OOSmstD6P71
         kkIg==
X-Forwarded-Encrypted: i=1; AL+hErF9nL5nXjNcTKbUBz+QpaTvzqW3xoLaSfvyxY8HLBVuYZ853wt6ONSHricKFG2R6W89gmqHcXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/27vlrmnb49wNUyWJeHCgjMpUtLWortJa5m6S/nW06NL0s8sZV
	oY2DqB8+iN/QRxBtwVHafNV69yB/wLxTyZmBdj2loiISHMB8PYaAiN6e
X-Gm-Gg: AYBFou2Ww6Z0c0R03U1dlX2g92o86leAXtzoXleGIMSW85IarH91CFUCjatiUYQcjKC
	N44IbAVge0AbEXeGdYxlHsieoNY1iO7mg7b5qTXWLBk4rY0oqoP7kNEF2lnk564uxgvKQfUWP6k
	mV8sn+ABBozJ2iIqseTXGMDyGPWudYjvZ0S99Na0tSFidKQGvj/w9Z8mxCzDOqgS1ipVMslo7EE
	6NPANikqLkFUGf1a77SP+kAK7d9iGPfxHFqq086YvVpSqKn/2gCWtGuMfPvVH897gzB8eMchv6c
	4pkhQd5xROL4qiIXfd8kidOHMK4UE1fKBtuFeEd/FhxWSJQkpXzookRzCvy++VtB3pRaMSyTgb9
	9jfLzwZ1DVaYkyjHas1My6/srGCVnRDnovuSvipWjpiqRftARNXtkpDccN8KUEwall87kVWQYbX
	G6UprzfmvqlkoC0hysMJWUx3DIrb4trJMOklQLkf5PytTxqc+aeEndR1xrww+jUaU/5eEbd/lMR
	kZJc9SjTXYZZ0NrAthzqV8PmmuZ3q7KV5YLtsvXRVhUvKnF/iuMwP9ok+YJ/ry77ZhENjbyJ3zr
	ta3zKmg7FHWur83G7Rv1Q4RigUHRW1TUOlArbOSCa3XIiRxg
X-Received: by 2002:a05:7022:3a86:b0:1b3:a881:4d9f with SMTP id a92af1059eb24-1b3b60249b4mr3330257c88.20.1794311046423;
        Tue, 10 Nov 2026 03:44:06 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b1003fsm6648791c88.6.2026.11.10.03.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:44:05 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: gadget: lpc32xx_udc: drain the pullup work on removal
Date: Tue, 10 Nov 2026 20:43:51 +0900
Message-ID: <20261110114351.2524921-1-hj351016@gmail.com>
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

isp1301_pullup_enable() schedules udc->pullup_job to perform the slow
isp1301 i2c pull-up access from process context. The work handler
(pullup_work) dereferences udc and touches the isp1301 i2c client.

udc is allocated with devm_kmemdup(), so devres frees it after
lpc32xx_udc_remove() returns. remove() calls pullup(udc, 0) -- which can
schedule pullup_job -- and also puts the isp1301 i2c client, but it never
drains the work. A pullup_job still pending can then run after udc has
been freed (and the isp1301 client put), dereferencing freed memory -- a
use-after-free.

Cancel pullup_job in lpc32xx_udc_remove(), after the final pullup(udc, 0)
and before the udc and its isp1301 client are released.

Found by static analysis; not runtime-reproduced (needs LPC32xx USB
gadget hardware with the isp1301 transceiver).

Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 94355d3..210fa1f 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3186,6 +3186,13 @@ static void lpc32xx_udc_remove(struct platform_device *pdev)
 	udc_clk_set(udc, 1);
 	udc_disable(udc);
 	pullup(udc, 0);

+	/*
+	 * pullup() schedules pullup_job to do the slow isp1301 i2c access; the
+	 * work dereferences udc, so drain it before the devm-allocated udc (and
+	 * the isp1301 i2c client it uses) are released.
+	 */
+	cancel_work_sync(&udc->pullup_job);
+
 	device_init_wakeup(&pdev->dev, 0);
 	remove_debug_file(udc);

--
2.43.0
