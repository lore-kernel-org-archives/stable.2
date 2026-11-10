Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322641;
	b=qFV8XHocLpc+p+XYLhx9wL+3g20v80AHSTlfxdmz9j3VEHGJg8LDJBM/NK8NWTQ57qPU
	 KyO+R66jvMB3IAt5xkGjbwwerRLeHGFz0M0/YScqjOLCCkK6LsICdq7Bc3abjBW4xtbyQ
	 vjJgPdAqumd9IXEwyrLPR2R4zZWWPLCmj4p50O+Mc1LrM3pmEm92NkTw4OTmgipG71vyo
	 wE9mLnE3vdMhaslQAP1qxDY0G2Hlnuqq8Agp98/FhKScvnbX6MqjxSLvMPmDivoKkP04W
	 mkrVVhO6KDWUU2q7CWAo8VRKUQMfIaG7sWSzJaoJG369gJC9EIBtHMwVQYeLPTtbo7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dcDl4Y6p1rvwfIMGu8NxMOGIoZ/CqwcjTuTZUUg2HWM=;
	b=2ODcgJEzX/1j87cBKj16BKum3P6in3ZVh+9TdiAuSPbWyFSkqCePp94vzpLODiJB+nJG
	 Lwo2TV4JPqMcm3WJhJ7pN28E3UQ1rja2Pu0jkxxSSqGX7rJ3etD+BHsdfpigtz4ia68/u
	 fn8yGmtQPdMPlsG0UTy+Ui8SYzIL2NvsbwBVJTD3Qy7FcDKrs/tufTmfa7D4FxyW+6RxD
	 xwRJn+5kZegxZ8A0aOq/JL1iI6KkBJooeBUIq426QsyU7D2CLekX3byofv+zphBM57XTR
	 ScjbNSbwATT+PDZeWsMwYcXgfrynIsWHIzyye5aemw+sOUQg2QHFaAHPxgsoBplMuJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9jrMkc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE14606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9jrMkc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCF81F008A3;
	Tue, 10 Nov 2026 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322640;
	bh=dcDl4Y6p1rvwfIMGu8NxMOGIoZ/CqwcjTuTZUUg2HWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C9jrMkc2fikU1EGSY8TygDzVUivmNvxtR0P841y9h3dyt25CXKjsRsEvJGsbZ9O0N
	 aqh5wc5Yw3bJedVnDXbe9lUlbYymKBZyvIdokgYrjKktLExqOxiN6dKOSHK6vm/Hr4
	 zRRMHtMDG0j13ERPU4QUitPPYH0rBToCBfoSfOthLDyFbp3z+5dpnxt3+gElo1cgoX
	 MPgOsxWda4R8H00vGG3IS1tb9QVsocAGYA87GJqaYVk77nn0hy0KuVp8chPNgv4PuP
	 aEtGwrD9lpN0GtOOF2moeGfHik+icy7CkRpGFm+NLgu38hyNQcXFkNYJRZvJQExeLS
	 wOo7c1KUhHOMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mfd: ab8500: Fix child device leaks on probe failure
Date: Tue, 10 Nov 2026 09:57:18 -0500
Message-ID: <20261110145712.2008098-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110145712.2008098-1-sashal@kernel.org>
References: <20261107062311-failed-5.10-5bf2ae8b131d@kernel.org>
 <20261110145712.2008098-1-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 5bf2ae8b131d4ae9c0ed5f7aa02532645f512022 ]

ab8500_probe() registers MFD child devices before completing the
remaining device initialization. If a later MFD registration or sysfs
group creation fails, previously registered child devices are not
removed.

Use devm_mfd_add_devices() so registered MFD child devices are removed
when probe fails.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260924144355.1604369-1-lgs201920130244@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ab8500-core.c | 44 ++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index bad4cb684da36..62741923440bf 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1221,39 +1221,41 @@ static int ab8500_probe(struct platform_device *pdev)
 		return ret;
 
 	if (is_ab9540(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
-				ARRAY_SIZE(ab9540_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab9540_devs,
+					   ARRAY_SIZE(ab9540_devs), NULL,
+					   0, ab8500->domain);
 	else if (is_ab8540(ab8500)) {
-		ret = mfd_add_devices(ab8500->dev, 0, ab8540_devs,
-			      ARRAY_SIZE(ab8540_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8540_devs,
+					   ARRAY_SIZE(ab8540_devs), NULL,
+					   0, ab8500->domain);
 		if (ret)
 			return ret;
 
 		if (is_ab8540_1p2_or_earlier(ab8500))
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut1_devs,
-			      ARRAY_SIZE(ab8540_cut1_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut1_devs,
+						   ARRAY_SIZE(ab8540_cut1_devs),
+						   NULL, 0, ab8500->domain);
 		else /* ab8540 >= cut2 */
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut2_devs,
-			      ARRAY_SIZE(ab8540_cut2_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut2_devs,
+						   ARRAY_SIZE(ab8540_cut2_devs),
+						   NULL, 0, ab8500->domain);
 	} else if (is_ab8505(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab8505_devs,
-			      ARRAY_SIZE(ab8505_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8505_devs,
+					   ARRAY_SIZE(ab8505_devs), NULL,
+					   0, ab8500->domain);
 	else
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
-				ARRAY_SIZE(ab8500_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_devs,
+					   ARRAY_SIZE(ab8500_devs), NULL,
+					   0, ab8500->domain);
 	if (ret)
 		return ret;
 
 	/* Add battery management devices */
-	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
-			      ARRAY_SIZE(ab8500_bm_devs), NULL,
-			      0, ab8500->domain);
+	ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+				   ARRAY_SIZE(ab8500_bm_devs), NULL,
+				   0, ab8500->domain);
 	if (ret)
 		dev_err(ab8500->dev, "error adding bm devices\n");
 
-- 
2.53.0

