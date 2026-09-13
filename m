Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7132571A9
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265166; cv=none; b=K2qQjWlKO/3opCsJBobep5tKiQXRWbrW46ItLCMPHnLuYjG+wlnxo8pvtykJmzAeQ90QCKASL67WQcW1hRYNl/DTU/qAlWfAudUzT+6su6HKe+LwBNI6PruKQSjzhoubmWoQxIfxm0JBUmDsqXOeAaDG8Ukvb0l0e47YPTePMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265166; c=relaxed/simple;
	bh=u9GSM0aa+VAK9DTcZDNOH2O9K7tKZbEzTahPzC8uM54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsS8xOgWjrOnMSZv0xulBj6dmvXhe46NAXddvLxlJHyHOugBCqfi9ZZTh9qYWH3vfEHMJaM2Oyo/88jd07xKHzKCDGdGfp7yLhZ0dqSbz6XBDk8d162O0U8Gp2P3OCbaK40Y0kiIMMoCfJ3ukgGz4wabJ8yxYRLcH+CFYAZg52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwzkJS4u; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwzkJS4u"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92ed3993c1eso142994985a.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 19:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789265164; x=1789869964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tTjkICk3Y9ecBJSXUR8cu0YE3Z/N5m7EH1Ek0T2d8Cs=;
        b=TwzkJS4unH+P2Gd3OizBqc6M13Nio4Fw5S+pFUF169VT02oqVyPU2tjbTrTdBPoofT
         eIEa1izz33Y94nuI311CE7Z2iAT6qkcswwzAs6oPEAr95s1bLrSqPh8+B6CO40wC5ech
         iUTfWxLLtmMDDMBmDCznGWQn1I5liNUk8Agv9S2kfqXmF8XgN7V9YsHBd4d7s01wgNqj
         Famhz/LF9LL13WjO/s02xcAJO99gmoNdwdTT3xE7DP1K1aJDNKDpwTEvioLZG1cNpFPX
         pbzO9/HynbyjY4yFJxduMN+Y42Fsxdr2WjeBVVuHrtKdF3acnJ28A4XGI+WD7F4F7yCt
         5DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789265164; x=1789869964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTjkICk3Y9ecBJSXUR8cu0YE3Z/N5m7EH1Ek0T2d8Cs=;
        b=ivNT7UfPdd3Cl6e7D8WtSVO8Hq9Mw6q1MYPiJslBmzYBzYvt01YWSmMnSqer51aggn
         oPkpzWTEdyHO/HaEQIFD3qfqDJUE5asBSuNTqnp28CgCQrzYmemlX5u4dpm5+wDY0xpE
         7LR3krcVCb9laoP1jaFa1wQ1QM8R6KG+1U01equsD3QLfKTXCuPQ3CbLiv/caIxo0gza
         kopgfl4C09e63asYq6jI1Lh72z1OlSzLyNmOWO+31/bEFToyQMutZtc5sM7Bjjbn3Fwd
         9KcEdr8JsFCyAXjNAx7FoggTIzh4JSne+ArLwkA12CjNuBDoBjTKjwiozURnYONtQPUR
         Ly2g==
X-Forwarded-Encrypted: i=1; AKwUvBxTFX2JY2qxb2OMYyKyBtR7ju12AlbxcBASaWA0MFWkq1wV7fHm6lRZAs11i9i+282TfCVhVbc=@vger.kernel.org
X-Gm-Message-State: AFuF++mBPn1sBkMa0xGTC+xzUJKfQ0U42kRewrsUR3+46MjzrD7DDrRf
	S0sNUCOFeWlepgm4YrMTPFArLRvRVL6CqlNshMmOHEYLB6IXZP8Y+KM=
X-Gm-Gg: AYBFou2THekJyTdFoZT1j+3uOnvYUQq9Y9Rl+XzzufUMN04LkHvhxdNBT4ELSwY01T0
	5wcupZOQFAwuUAjyxO8uNPZOeMb9yJTqg+aDt0UWj2b81E610FoDWNPpUG3X9MvAnlc3Ml42fii
	PvcSfGHitxjvfW3hjW52y4tQOLAtBnBE8BhGiNfSgqFP3+5TZC9PVNF1wSlDTbWKeoD7HSLlULA
	YOeULSFSyH5XCFrlgzsypYn5DAKbQZc0N5sKQcfFXS38oAR59KRtxlpyr81CVZKWgLCEIcVmcqk
	ZxL0NebwB1o/LBRNkaozL5pSHoKl0XSYWRmCBogI1sdxWkifRXkECJWg9pRMs5tt6H1yxf1cZNW
	l8OjxtjREu3NT1CZfKob3firx46H6vj5BvVa2YJ0C0zGUiGZXSqCqkw5w8UyWmsptNVEYQQ1lV2
	4YrHoRyDBGLimw9jg1tFzdL7da4cveudNopa/arr4iRSIiUevzYS7wA6w/kk49L6UgOZ8TnAj2e
	TSYzqREXm/c7wSMMPcpT4+2DxFxxUI/q7l/MyRpq0DafM7rSWJCRMZj7oHQY8qIrx9sqoi/JRYk
	5RFK+LFyZYHcoKxYXRWZRPnzCyMzv1kqnQ==
X-Received: by 2002:a05:620a:6191:b0:939:3b56:c416 with SMTP id af79cd13be357-939ea0e6c8fmr1489184285a.8.1789265164106;
        Sat, 12 Sep 2026 19:06:04 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ed67a93dsm540462185a.43.2026.09.12.19.06.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 19:06:03 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] media: cx23885: unregister DVB bus when SP2 CI setup fails
Date: Sat, 12 Sep 2026 22:05:54 -0400
Message-ID: <20260913020554.55506-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DVBSKY S950C, DVBSKY T980C and TechnoTrend CT2-4500 CI paths register
the DVB bus before attaching their SP2 CI client. If that client cannot be
created, bound, or pinned, the current error path removes the I2C frontend
components and only deallocates the frontend list, leaving the registered
DVB adapter behind. Removing an I2C demod before unregistering the DVB bus
can also expose the use-after-free ordering fixed for the normal remove
path.

Unregister the DVB bus immediately when SP2 CI setup fails, before the
existing I2C client cleanup. The bus helper empties the frontend list, so
the later frontend deallocation has nothing left to release. Keep failures
from vb2_dvb_register_bus() on the existing cleanup path. Also release an
unbound SP2 client and propagate the actual I2C creation or CI registration
error.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 2b0aac3011bc ("[media] cx23885: move CI/MAC registration to a separate function")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/pci/cx23885/cx23885-dvb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -1158,8 +1158,12 @@ static int dvb_register_ci_mac(struct cx23885_tsport *port)
 		info.platform_data = &sp2_config;
 		request_module(info.type);
 		client_ci = i2c_new_client_device(&i2c_bus->i2c_adap, &info);
-		if (!i2c_client_has_driver(client_ci))
+		if (IS_ERR(client_ci))
+			return PTR_ERR(client_ci);
+		if (!client_ci->dev.driver) {
+			i2c_unregister_device(client_ci);
 			return -ENODEV;
+		}
 		if (!try_module_get(client_ci->dev.driver->owner)) {
 			i2c_unregister_device(client_ci);
 			return -ENODEV;
@@ -1202,7 +1206,7 @@ static int dvb_register(struct cx23885_tsport *port)
 	int (*p_set_voltage)(struct dvb_frontend *fe,
 			     enum fe_sec_voltage voltage) = NULL;
 	int mfe_shared = 0; /* bus not shared by default */
-	int ret;
+	int ret = -EINVAL;
 
 	/* Get the first frontend */
 	fe0 = vb2_dvb_get_frontend(&port->frontends, 1);
@@ -2587,8 +2591,10 @@ static int dvb_register(struct cx23885_tsport *port)
 
 	ret = dvb_register_ci_mac(port);
-	if (ret)
+	if (ret) {
+		vb2_dvb_unregister_bus(&port->frontends);
 		goto frontend_detach;
+	}
 
 	return 0;
 
 frontend_detach:
@@ -2618,7 +2624,7 @@ static int dvb_register(struct cx23885_tsport *port)
 
 	port->gate_ctrl = NULL;
 	vb2_dvb_dealloc_frontends(&port->frontends);
-	return -EINVAL;
+	return ret;
 }
 
 int cx23885_dvb_register(struct cx23885_tsport *port)
-- 
2.47.1
