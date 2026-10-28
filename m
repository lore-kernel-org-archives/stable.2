Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194114;
	b=yYOvdGiJUiM8zdCD8AfFvD6vg74jIH54F3JRehFwSqElEZ6i+LtJmJl25i11Rm1xCsvT
	 hjr3a2EVQje3ggMbNj+UcdHANPls4qjz5ngZP14nIywIO9nzZy6Sjo9xpLzrdfAgW/Fdb
	 7umV19mWC/5NmUFoMAuUpgIKvDV2VuVeP4I17xMLrDFF3FzZR81btBzMS/JJ5c8ZBtTUn
	 Jg5YPU6KW1tTRhmlNifX8wwdTADRvDXpDKQ22wAPGEj6eNgCuRGF5s1ppqNvygmF4TJXd
	 5ALrVAj0izMo52MwbTtb7SbEXJNorhrLSb5RV/7bdO4EFdD56tPcvz7Q0l+rka1tnDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/qtnZvOuU8MhlvJHegjHxSWlFaXlL/NnoXGGQM+IOGA=;
	b=eRKrCtEVenELal9K8+dGcE753HDiJp/l3c3L/i+yoUTFIRS2pYUkVqXD16IhORRHfoQQ
	 FM6n/DL6ZtRTs+UcPS1AdFDc/nOUi/w9iTHyPXapeQ80NT0Akm1WDv0Pb9n01etNZ6aAW
	 UzWuPemI2CKaayeJdopo/FabZunBF6jc6udQeluBUD71yBTt99PRV2Ww138RulMxKsFz5
	 EDfN0/3+462Fe4wcFgkW1Nr2CdVwmRDwGazVLaPzOB+xaS0yHHbLiPNpvdIjrK53HpSaw
	 PdexVwdoGHF3D/rRf2INkWyOFuEt1/4k8aVxBt9ld1/0zxepvGJwwP1GRtGMuNuqEeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jr1r+QIH;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADE606A32E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4ADE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jr1r+QIH
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so644795e0c.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793194113; x=1793798913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/qtnZvOuU8MhlvJHegjHxSWlFaXlL/NnoXGGQM+IOGA=;
        b=jr1r+QIH9SF8KtcfX9BXZIHaTISyWChxSbxtk2nQq/HpZxq55eiafMQmivcjOYIsn7
         h2qTJ6u26kwNCEpWvOqoCy6eXKsRJUtjuvajaCzMcFb9JBIp1tzPDOU62NwP1fpm/Ct5
         M+zBG07CeU+BBuL/0F8Y08csE5QigbGYSElY4VEUohVPJz/qtmyNASR9EC12577NET5s
         eMEzhI+f9wQLdSDxiqHdX6Qw7dpIHdd+Q14xV77sYfPNv2zJgRY12MtqLg0zOzu4hZsT
         CXMAKNko1WX759zarCC5VWO5mf1uOdDt+/b0lA3rulT4dM0LcCWJQ2tYIb0sMtlmFcYu
         iM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194113; x=1793798913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qtnZvOuU8MhlvJHegjHxSWlFaXlL/NnoXGGQM+IOGA=;
        b=TykYIAG/5sb+2F6qFWvm7wqbCY27AESYWp9Lwjf9j8VYV4lwbK1nMPYDMBXyHa1yV/
         jz+GcQg937sVglhykram8ItMXRitHouKCZhbpvl6haTD3Afh6v0jKS72UbDodseR2e6P
         bNOdd/va7ENJQXPudpcc2nkOjd6WGcinJTLgHMQdBW+YKLNEHtSHXvDjeUQDYoVNU5cX
         fapbFzLxOb9BeoFvZmsQAIMs+z1yTf2SX6vJBDslLh+cY0AsbspYnJEHEQYSHKu/YM+o
         D+qQlP2Om/tyqXVv2IHBY8p67RmhiyOMUQPgjZXzImL9FPG8RnEEQkyryZPzWQAxF3Zz
         bw6g==
X-Forwarded-Encrypted: i=1; AKwUvBxA/wQUKetmpdNM8hePr83H3YjOzXaAgJPLU3Enboi6a1zYD7uNHtal3lTQMHyTGHYNNuiSNSw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTs7i1aPAZKlMzlSNH+HWG01eKDFUU1a4x/VU1KpAZfCljwvHk
	gQx8upj6hyQ6RLZQJH/GbfJVuefzYjlKbHOTX1HhruNDB5cf/sdHxOTm
X-Gm-Gg: AYBFou3Cgx8BfDbpWenbzfI9eOeKXzH5xSeozCkGWpOwYWfU8HH3QIa/ONI15dxjo9y
	gpeZgIDzmvVrhe0iRZIAgw65UtQEFns4J7wUFwgSVOi/Nf5/DMBjJq0LI10d6qBA7ryVzVm8eUI
	KfWHOwwJTAfDdCeOZ8Zoj7pmjoDRh6Rs9TEUgQ6endGNZ0o7DxIwulGRPqWu3jBZd/nb9rKd7tI
	I9LTIjhpgmuO+Tf5oCBUqryvwoHLwWDDCLsLtvnWkTBmOpX4NXbDsfrzG57otH8f1N45Nakqr9i
	WpyHKSiEP9M2PsGqWx55veZ53mCIQH72rO5sToi17//5wB+Ny+y0T6PhtN3PxMRq00JkLLSsyIe
	89M9jRrmE4r/I0S1GB9vtnprZqeIYJkEtt7zHde2jrKQpq9Hsp9WavjnR2DI7sMl+IcRZL5yPwo
	DdGPyhzZNT0VLEp3Un02ejMb0aNhJ2Gl1YK9EQhR5exRUtspU2DDwH28r8YlsZST99owjjOq4L2
	7m02h1p4MGuw76TyUGghxF2mrK5dLFc5XAxhjNIjsh9PMl/Wld0xjw4hVEdzgGKv9ZysUnYI9GG
	HndRc3sl66+AWVHpHcbT1tnpGDkOALK4KiLkigcXYJ1KE66HhiFlgosn06lhEZBh7h4nhyFuC3W
	QEv+R/10jZpawVpPGpKVAQiI=
X-Received: by 2002:a05:6122:c93:b0:5ea:c37b:450 with SMTP id 71dfb90a1353d-5ec4cc5343cmr1027395e0c.20.1793194112610;
        Wed, 28 Oct 2026 06:28:32 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a801:e068:c468:5e04:829b:4378])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f99442fsm1720000e0c.15.2026.10.28.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:28:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: herbert@gondor.apana.org.au
Cc: horia.geanta@nxp.com,
	pankaj.gupta@nxp.com,
	sahil.malhotra@nxp.com,
	gaurav.jain@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: caam: jr: Use dedicated shutdown callback
Date: Wed, 28 Oct 2026 10:28:25 -0300
Message-ID: <20261028132825.657546-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

The CAAM job ring platform driver uses caam_jr_remove() as its
shutdown callback.

The remove path refuses to shut down a job ring while crypto
consumers still hold references to it. This is necessary during
driver unbinding, but causes the following warning on reboot:

caam_jr 30903000.jr: Device is busy; consumers might start to crash

Unlike driver removal, system shutdown does not require
unregistering crypto algorithms or releasing driver resources.

Introduce a dedicated platform shutdown callback that shuts down
the hardware job ring without checking consumer references.

Keep the reference checks and algorithm unregistration in the
remove path.

Tested on a i.MX8MP custom-board.

Cc: stable@vger.kernel.org 
Fixes: c007e720989e ("crypto: caam/jr - add .shutdown hook")
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 drivers/crypto/caam/jr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index cf725a6ac0fb..75be668b74b8 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -178,6 +178,15 @@ static int caam_jr_shutdown(struct device *dev)
 	return ret;
 }
 
+static void caam_jr_platform_shutdown(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = caam_jr_shutdown(&pdev->dev);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to shut down job ring: %d\n", ret);
+}
+
 static void caam_jr_remove(struct platform_device *pdev)
 {
 	int ret;
@@ -812,7 +821,7 @@ static struct platform_driver caam_jr_driver = {
 	},
 	.probe       = caam_jr_probe,
 	.remove      = caam_jr_remove,
-	.shutdown    = caam_jr_remove,
+	.shutdown    = caam_jr_platform_shutdown,
 };
 
 static int __init jr_driver_init(void)
-- 
2.43.0

