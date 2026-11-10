Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287358;
	b=cEwwR2mZg2xSQY0wb3zgYYA+CU/1hZHnVtT2c5bLPdt8fmikjBWwusGYQ1CN5Irp7EOz
	 TojdrTgrM/bSWyrlVSrLf1/f+ttg2IMulXZPZTQMYER/wsfl8SjplU883ymu0r+4rS7vq
	 vwRaWZSdP0NyIwH3FEfsP4np8+nPzGeCIr93ktSFn+pkZyzNsMiyjLKKw1zlsanxe2UF5
	 GejD2v/E5VNRiXVQKlF+k3D0LRwQmN8IVqfYFRyVI7OxZbUHECbdbjAt+4PlrcC4x4atH
	 DpxngxFrDsYaGbdExqS3ooglRQdnkx1vsEFPhfLkobRwOCi3VmUQthlPyYHHVu18MLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tIwxjc1XcF7cwC5sY73c/5RFH5CWJFmaUfeVezkR1lM=;
	b=5m87oFfONCA6Nm0/pA2SsaoP6dJKiwTqrGmVmbRsYo6pdpdvEXH+s//lDETaPFxonU9C
	 1jxOmrGJ/8e3tc8QzFv2xqjpd4C3TrxhEii+nR59DerTpyK9OmE0QvY3RQ9/jqy45/UBF
	 K88thCB1WiFhfNFpQob2iNWC7ztluq5mSkSl36uA8+zq/uvysgP/rabGLBtsSbv4dRLWh
	 opqGAqUlc4pxPuG4+hVVeqAqQbicr3GdsAyB57EMFKuqrnKSN0AtuE0BMrelqoyotOtKf
	 AhuWeBDbtDUPsNN8z/cQWmVd0SB/wqUA0rX1127qzQf4eGTvkhfM5sbDfqR4rXywWUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1cScd5X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208F606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1cScd5X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA21F00903;
	Tue, 10 Nov 2026 05:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287357;
	bh=tIwxjc1XcF7cwC5sY73c/5RFH5CWJFmaUfeVezkR1lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V1cScd5X3e0ZubL1HiBAudK29pQpUJO7iLPisfZIQ0E5WPYFoAwK/UPpl5KdpWyUT
	 qx5l8hediYohP2i/tJ4XzZ55xLcKctg+imY13cwLX5FnFkYzuL2bO8K4HhrUyJBHxS
	 FBLQWmjZL+MH+3WiR6ivefAEgP3oUq687ZUBse5bOKFv21/6FJWc88MchIlb3a9X9q
	 9yYqVB15Lb4YIl4XpOBNE9+64jpCiMOmvaXvqpds6GmvDKvQAH2g4yPDRZpp2IrrPN
	 tmhTMR0dCV3upRr1SeWbsL1tridLRTVN9jcF3bh9Gy3iExQoQ4FcvAbV/EUbEMLC42
	 viEMvAEBDXz+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	James Alexander <opensource@inspiredexperts.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] platform/x86: int3472: Increase handshake GPIO delay to 200 ms
Date: Tue, 10 Nov 2026 00:09:13 -0500
Message-ID: <20261110050908.407088-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110050908.407088-1-sashal@kernel.org>
References: <20261107050619-failed-6.18-844982d3b993@kernel.org>
 <20261110050908.407088-1-sashal@kernel.org>
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

From: Hans de Goede <johannes.goede@oss.qualcomm.com>

[ Upstream commit 844982d3b99340c21dd2125f44e1ad04ace6a38e ]

There have been several reports of the sensor not properly powering on,
on laptops where an INT3472 handshake GPIO is used. Both with ov08x40 and
hi556 sensors.

Testing has shown that a delay of 200 ms is necessary in some cases.
The handshake GPIO is typically used to signal an extra bridge or other IC
with that IC running the full sensor power sequence based on the handshake
signal and also possible controlling I2C pass-through.

It seems that in some cases that extra IC takes up to 200 ms to before
the sensor is fully powered up and ready for I2C communication.

With the default handshake signal delay increased to 200 ms the quirk to
increase it to 45 ms for the ov08x40 is no longer necessary and is actually
undesirable since some ov08x40 setups also need the longer delay, drop it.

Fixes: 30359c239ba8 ("platform/x86: int3472: Increase ov08x40 handshake GPIO delay to 45 ms")
Closes: https://lore.kernel.org/platform-driver-x86/20260816204247.2844986-1-opensource@inspiredexperts.com/
Reported-by: James Alexander <opensource@inspiredexperts.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333331
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333647
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index a4c24f1cd0a4d..6ebfaa141a42d 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -15,6 +15,7 @@
 #include <linux/platform_data/x86/int3472.h>
 #include <linux/platform_device.h>
 #include <linux/string_choices.h>
+#include <linux/time64.h>
 #include <linux/uuid.h>
 
 /*
@@ -178,13 +179,6 @@ static const struct int3472_gpio_map int3472_gpio_map[] = {
 		.type_to = INT3472_GPIO_TYPE_RESET,
 		.con_id = "enable",
 	},
-	{	/* ov08x40's handshake pin needs a 45 ms delay on some HP laptops */
-		.hids = (const char * const[]) { "OVTI08F4", NULL },
-		.type_from = INT3472_GPIO_TYPE_HANDSHAKE,
-		.type_to = INT3472_GPIO_TYPE_HANDSHAKE,
-		.con_id = "dvdd",
-		.enable_time_us = 45 * USEC_PER_MSEC,
-	},
 	{	/* Sensors which expect "vana" as con_id for power enable */
 		.hids = power_enable_hids_vana,
 		.type_from = INT3472_GPIO_TYPE_POWER_ENABLE,
@@ -259,8 +253,8 @@ static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3
 	case INT3472_GPIO_TYPE_HANDSHAKE:
 		*con_id = "dvdd";
 		*gpio_flags = GPIO_ACTIVE_HIGH;
-		/* Setups using a handshake pin need 25 ms enable delay */
-		*enable_time_us = 25 * USEC_PER_MSEC;
+		/* Powering up the sensor through the handshake pin takes up to 200 ms */
+		*enable_time_us = 200 * USEC_PER_MSEC;
 		break;
 	default:
 		*con_id = "unknown";
-- 
2.53.0

