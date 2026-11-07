Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045982;
	b=VZ1ES8Ph1Ld8XRocmxT+YMfY4Rnbq8LM+9Sr8U/nw5jX/pVLPca8IBHLYBpccUqeKdt6
	 zSlFGIELP477erpmf/YVR3qJ5xLFu2IcaSKgwsZstR42KecUDAFMabjd7BMFQ60iWAbki
	 SNv4Xxk7uLunnzAKIIE8aBz9TdBbFKMtprk4S/t6k3lhtRZd/L0ofFdsipN8Chppg7/ZT
	 Yw/l60BKROiNVRq+C7GtSzy0g/IFpqKIngZWrjLtLQgHyAHn7+DKw4gvcQapQUOEgJ5uB
	 xitqx9FPpf9hepZnl0jozODBUSDDLxwI7+pXjBzdm+ceZuCWB7/xAF5J+pl7J171Tvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DTjmfm0YFsc6IPt9Uk325eN1mOz3ofnAF0awSjTJCx8=;
	b=pCdqpn558s2Nwp/s3xtHIiuUVDkklhjPuCNV9BOqKavpzgSKtVMjzY5Oj1ny5cEFWAUh
	 i5r2yUdVCKsP/6C3m/soOE/oyvRpm2EOCykCBuAtzhYN3YHkJ44i/2ysUnn2J7SJFGGRx
	 Ij3mg3ru5VU61W+6v1VCo3nBFm9YnVXEWrLwY/hTv1UdoT2CtpMJ0bZWfNKTimNULRO0p
	 lZTnsyQPx1dPDaBOiVAXk+uUyVaaRL6wbG+oGqD/jQKHOFvm8/aH60ApPOVH4voyPSSW4
	 nPV9KL14wo2ujsLASJ1EbuEErHu5koLXS/yPQ6fI5yLQKbvIi2HwPVL6ndbwohFWoQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqfXqkVC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB50606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqfXqkVC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2444E1F0089F;
	Sat,  7 Nov 2026 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045981;
	bh=DTjmfm0YFsc6IPt9Uk325eN1mOz3ofnAF0awSjTJCx8=;
	h=From:To:Cc:Subject:Date;
	b=RqfXqkVCX2g/p75XvAyaV7gf00d4zdXCmPMfTDgzhcTg1ln9NW8l6FWNrmAdr13hE
	 nwtOpQWUaT2RHYm2pFn1nVQbX/dFhJgGjVgHAC6/lCWdu/hv8UatNAR5F8iWLkWfYt
	 IY9ltEd8ITLEzgMGraNLLt9ZjIV6xvlunXbkrTtd/XYSNj3d01wzyZeevjwamEEKi1
	 n5NYCTxnPhvj60SCI0oGFuF5tth2OTB/3qqMNVeAXWkeTRBG7GzkapCOjnq1rSpTAs
	 ovLcvGvDNoZbPqmyR87LsytTDtl1g9/I/3sbMHVDKAUZc3jclTIhpia7kEKl4rsCHD
	 LxwFO67FSLd0w==
From: Sasha Levin <sashal@kernel.org>
To: johannes.goede@oss.qualcomm.com,
	opensource@inspiredexperts.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: int3472: Increase handshake GPIO delay to 200 ms" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:19 -0500
Message-ID: <20261107050619-failed-6.18-844982d3b993@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 844982d3b99340c21dd2125f44e1ad04ace6a38e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050619-failed-6.18-844982d3b993@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 844982d3b99340c21dd2125f44e1ad04ace6a38e Mon Sep 17 00:00:00 2001
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:28:21 +0200
Subject: [PATCH] platform/x86: int3472: Increase handshake GPIO delay to 200
 ms

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
---
 drivers/platform/x86/intel/int3472/discrete.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 1f8751a7db0c0..749e2e323583e 100644
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
@@ -273,8 +267,8 @@ static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3
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




