Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535136;
	b=tSwEmFgLMxnzuWgPHoMlE2AjXLMJ25TjnEFjtNeyxz+M3JBh1E0zu2OY5dBouWzh6fsB
	 OUn10qsqB0jLRb3UKIvoEkh+kiz52kVjrNx8e5AgDRJY8goz5tedu5ClmszGmwvWba5/O
	 osPGZRteMhLbVROGPF6HFj2aLZADFjeXHPCKku8paOpIP9N8kgPvy2TQZrJhjP+1NuARK
	 P4tLxjZch+Z8t4H/HTohQ0gGfxC8PgltZDmnrayRWDxzqgFwKjjhlZiq1xfK9GporsZpM
	 LK3aFjbhdHEsCdKVlcsKhm25seZsYq7gP3Ku7hZ9gze8+t8xBI7E+RTZgF4N81LtbTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5N56MgLFon8GdL7QzFpPjlEu7rx1MbvlYKRTu5FbU1I=;
	b=R1h/9b7tyi2+KHOi6MkAo3L3ZYTSXWnf7WeMLVFK1kbcYrSDtXWBc3qcu+ygzDx/TVeb
	 jHnTO4CJTPLbdbqyzkjXzrn4+4HPHGzyseHP2qJWeyfR35gN4QwgRxDE8F/FD1NSR6jd5
	 w3U47xEpFVsWCTDJF3z3qtc9/M0p9EunrK0VaJl9WcKP6Yfv+b+Qdyw05HDDdJgk9ATnb
	 axXO6ua4PZ+pMGwW+Vd6t0Nr58dwb5j8ORqOaafVoX13hbeDwReJ6X0frICG0yOjvlnVR
	 S7Mgswwi1pnYYg6Elr15GVJ6EraGkOCMkRXjRMSBvHxLTzT1lE92y2PC5ECXnb4yCsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=002ECCbG;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E138606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E138606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=002ECCbG
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so3038771a91.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795535136; x=1796139936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5N56MgLFon8GdL7QzFpPjlEu7rx1MbvlYKRTu5FbU1I=;
        b=002ECCbGoe4UvZrDiR8+fQIJbNmAxO8iRI7uDaM42niaGUYPgQXdlnHjkyX0nsDLrU
         Ze7K68D7fIBGkDIT4B637oXrGl2E+23Id/8+5WhhbDOrcw8sJYHHS55Evjw0mn3/pWT8
         JeeIumNTNxU5+BuLGul4WQ24pKlA8Qe8StoOFxVBTnbs0xLQyn5mXVZ0hurTXG4TslUS
         7BTXqdBGAvHNMZ31HHj7xrYnMeiLP2MCuGzud64zEKWg7GkswqHF1gJhRrcvX/sZjDrv
         iHy2tYdjan2IKlC81Nf036sgN13ZnQWwjClgHP2de8BtHSqxOl/PSlKAHVV6KJhdL4PV
         810w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535136; x=1796139936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5N56MgLFon8GdL7QzFpPjlEu7rx1MbvlYKRTu5FbU1I=;
        b=HjfnOtgW1jcub0XR5F11h+briryZsYNlhwQuS+kG40Up60raQzXLIqo3pC0OkWWJN3
         5AxUdjSgR3hmKzNdLCOm/Rcoa9ETyUXb8FYb+bOCUgqSMnYUIH5ZHuqkDn4t3yz7YdT0
         QSqlKI7lRxyGFNPq4ki6qnCamajtwEloDmtqTxWbJVPnmX1weUf/x8Pr21ndjwtRE/aN
         jQmhy8bO6VGweBkh00JGbxbFqURhoz4ghszlUP4p6xuU3B/e3hKtEiV09FXUybMzyg6w
         gC6yaFpvj7GcJikaUjyEnBSNywMgeYA90WqCKng5CnQ/ycBzKvYnBCI7rIfVgb/FpeGP
         4WJw==
X-Forwarded-Encrypted: i=1; AL+hErEnTzktb4WcguJgYGfjSzNPMGuIpyibnbqgMMfEvcGJ9G8aLzhtJ5ze7UfAt7Xp1c/h+PpMtB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z94FZ3VHrSXodz692qjx1tRXjVFIEvoMc/1cJddMOrHZe9Da55N
	9IREmivYfxV5e1v042GiOdvH6kJquvWi549waPoT5zVQtC8kRNf7FLU=
X-Gm-Gg: AZFdTZe3MHM64vvxLIRujUDnnbfW3yp7EtuGxF33Bxfjz/nxqGqmnK4P86Pc2/cAtZy
	iUVpP5DcmDEb2jcgLjjDKJ1rJG5mCedPffYPBaSrIWZDtT8AnLFwGePrisjf7k6MmuzYhY/eit4
	TXqHIE2+2grMBrE65Sr3bmi+DAjOgJIsvWL3x+Ed2LbLmRidN1Vr0NhiPBCvd8OIDx5H5Tz+Lde
	66xbg4yLsU4jYqktB05MxJmatPGgYl/T7zsQpCbdtBwxoOgQKIR6kf7phsG2DnkkTJoDmIfkXnn
	LDxH0XmaLxoItCqcFUAtRwPIy5ttHjrT3JZwgDY+iTv0Z9Ab0O5Qnf5VLjj+68CcA58yZynsQQ2
	+kxxcY/PCVEQjza6JbHwEnYsKi0fBvfP8UNgUmer2ebIsXsJAxaJWNLYodSjwjpFR1Pypfk6zsn
	tfAQ41tdyQsISDcxxZc3NVc3V/V2vb0ntrn3+pzdPuiv74UZDfLpx/jMFg9/UCPB9QxJY5Vsaug
	f7kj11OtyVJaldmNEa0eMao3ygLAj1ZYUOdk5QjYYgcnM1i+DA1UgTULoiDjnzv5s+qglpYvj/5
	koi03vLICxlx/CHOam8ijUejEwgprvYGv3ylsZTH8Y3WtqwlYggMcz7A/dUYvAMvAaqc
X-Received: by 2002:a17:90b:380e:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3b41c9493ccmr14751455a91.50.1795535135546;
        Tue, 24 Nov 2026 07:45:35 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:5da8:85f0:b5f6:2eae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm26290347a91.7.2026.11.24.07.45.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 07:45:35 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: saa7164: Keep the frontend alive during DVB teardown
Date: Tue, 24 Nov 2026 23:45:30 +0800
Message-ID: <confirmed-20261105-31-0973614e74b7@gmail.com>
X-Mailer: git-send-email 2.50.1
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

On HVR2205, the frontend is embedded in the si2168 demodulator's private
allocation. Removing the demodulator I2C client frees that allocation,
but saa7164_dvb_unregister() subsequently unregisters and detaches the
frontend through the freed pointer.

Unregister the DVB frontend before removing the I2C clients, and detach
it before removing the demodulator. Keep tuner removal before frontend
detachment: si2157_remove() still accesses the frontend, and on HVR2255
lgdt3306a's release callback can free it during detachment.

Also clear the published demodulator and frontend pointers when HVR2205
frontend attachment fails. The existing error paths already remove the
demodulator, but leave its pointers set. Since the PCI probe continues
after the DVB registration failure, a later remove can otherwise tear
down the freed client and an unregistered frontend again.

Fixes: 504b29cbb0cc ("[media] saa7164: Add Digital TV support for the HVR2255 and HVR2205")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
Compile-tested: x86_64, GCC 14.2.0, W=1, drivers/media/pci/saa7164/saa7164-dvb.o;
baseline and patched objects built with no warnings.
Static source review; no hardware, boot, or KASAN test was performed.

 drivers/media/pci/saa7164/saa7164-dvb.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/saa7164/saa7164-dvb.c b/drivers/media/pci/saa7164/saa7164-dvb.c
index 3eb749db1ca76163c1b16578ce858a4b54a4e82f..76fe0fc56867434eef87a86d869bac343daeaf47 100644
--- a/drivers/media/pci/saa7164/saa7164-dvb.c
+++ b/drivers/media/pci/saa7164/saa7164-dvb.c
@@ -492,6 +492,13 @@ int saa7164_dvb_unregister(struct saa7164_port *port)
 	if (dvb->frontend == NULL)
 		return 0;
 
+	dvb_net_release(&dvb->net);
+	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_mem);
+	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_hw);
+	dvb_dmxdev_release(&dvb->dmxdev);
+	dvb_dmx_release(&dvb->demux);
+	dvb_unregister_frontend(dvb->frontend);
+
 	/* remove I2C client for tuner */
 	client = port->i2c_client_tuner;
 	if (client) {
@@ -499,6 +506,8 @@ int saa7164_dvb_unregister(struct saa7164_port *port)
 		i2c_unregister_device(client);
 	}
 
+	dvb_frontend_detach(dvb->frontend);
+
 	/* remove I2C client for demodulator */
 	client = port->i2c_client_demod;
 	if (client) {
@@ -506,13 +515,6 @@ int saa7164_dvb_unregister(struct saa7164_port *port)
 		i2c_unregister_device(client);
 	}
 
-	dvb_net_release(&dvb->net);
-	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_mem);
-	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_hw);
-	dvb_dmxdev_release(&dvb->dmxdev);
-	dvb_dmx_release(&dvb->demux);
-	dvb_unregister_frontend(dvb->frontend);
-	dvb_frontend_detach(dvb->frontend);
 	dvb_unregister_adapter(&dvb->adapter);
 	return 0;
 }
@@ -735,6 +737,8 @@ int saa7164_dvb_register(struct saa7164_port *port)
 	return 0;
 
 frontend_detach:
+	port->i2c_client_demod = NULL;
+	dvb->frontend = NULL;
 	printk(KERN_ERR "%s() Frontend/I2C initialization failed\n", __func__);
 	return -1;
 }

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
