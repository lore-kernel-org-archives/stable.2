Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415779;
	b=H4NMlJm8+unC7aFLZnyOUSVXUqMh61/v4UdEGqHrzjytM84U3v1klpUfod0zt2NVVn18
	 bwg76ji4P9pteiWuGD8P/sz+utJostUIYnxvnI5gO0Z9tAmlIShzKvoAbL1FW1PueFcDw
	 3vqJy1Zs+CHuGOKgx5CSfrRcK4v4KF+jq64sibrKFs59fD0tBHdaVFWA+HwE+XMtSuGvl
	 5eg6kK18c6eThKTXihBi+yo+OJrJWghX0WsLDkuHfan0ialev78S4P+mJ/uT2BhZj2PD6
	 bEOs1+Yqw0Os12U9JFhn8+mA2vOLQUhI/giTQiltcl0/8BDIKiAjROpQHi/b66mjz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415779;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pevBU/rlfJSoDW3Vu0lP8WWy0qlqRQdREZyXJom2sIA=;
	b=erST36QSKFLuGrqYz1pqnr5nQ4sAo94Us2nObp8opGCM+Vpz7EYLFWDbf42f8Ls85a5A
	 +p2YsxNcnRYCxEYtfmXnkPgoXoi87BDPMbumh0bFPulc2EidurrUdA1UZc0l7H5gwQg5Q
	 sqagIPkTpiPE1TFSuPSBm5IRL0KpILeJDx0PpfIELDwOuubIeNXQ+MqKIs2EYNLScsoTV
	 pnYyfAhWPOWE3Adw0Ws51m2k3WbDLrCTeQEpx0xhIuqFB0nsmGqSE/+G3z92L31LFIMLi
	 5L9sCQYUQheBopko9Zl8YHqiYDC58WKKmCxePow/OfpzaMHc9NOKQzvNBMXGlJEWzOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIbWOpZd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41169606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIbWOpZd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6427E1F00AC7;
	Wed, 11 Nov 2026 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415779;
	bh=pevBU/rlfJSoDW3Vu0lP8WWy0qlqRQdREZyXJom2sIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIbWOpZd80Us2HCZxDxQTFP8fo8AucxfZguG9hjQenRcrJJdZgAbiHXvhAwmF0C9b
	 RCYevln1kkly+qCgbCfnu1ggp+HgcSTB/51StUpsd6Bk66tcfK6EoEeODjIqNThSHZ
	 EEIyb5y0p/4FmIdhyUBUNiVdcw7JNep+yrT40R9PwIkYu29g/77W9kX0ZopscWBtYE
	 DDj3UiPgQEZiDnj3Me2QcjEtgA4bfi7wjamH5qzQ+fBaB/5D3nAiHltT7a3Fr48q7f
	 q8O1naeBNSft1W6/83YM0z75Bu9mqX6PExokrEMaoKMEphrIZv8RGkU27dSwxsyvfC
	 2Aagjsg2pOAgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>,
	Charis Stratakis <c.stratakis@proton.me>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ACPI: battery: Evaluate battery methods exclusively
Date: Wed, 11 Nov 2026 11:49:36 -0500
Message-ID: <20261111164858.3300811-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164858.3300811-1-sashal@kernel.org>
References: <20261107050526-failed-7.3-645f370c932d@kernel.org>
 <20261111164858.3300811-1-sashal@kernel.org>
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

From: Ali Ahmet Memiş <aliamemis@disroot.org>

[ Upstream commit 645f370c932db2cd3893f7fee61aa8b9debc8ac0 ]

On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
without taking the AML mutex the battery methods use, so _BIX and _BST
running at the same time can read the wrong page. Since commit d33e89d12295
("thermal: core: Suspend thermal zones later and resume them earlier")
this happens on most resumes.

Evaluate the battery methods with acpi_evaluate_object_exclusive().

Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
Reported-by: Charis Stratakis <c.stratakis@proton.me>
Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
Cc: All applicable <stable@vger.kernel.org> # 80892972ff23 ACPI: utils: Add exclusive AML evaluation helpers
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20261018122220.678822-3-aliamemis@disroot.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 670853ec3a4d7..7169ac7e83f31 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -583,9 +583,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 		acpi_status status = AE_ERROR;
 
-		status = acpi_evaluate_object(battery->device->handle,
-					      use_bix ? "_BIX":"_BIF",
-					      NULL, &buffer);
+		status = acpi_evaluate_object_exclusive(battery->device->handle,
+							use_bix ? "_BIX" : "_BIF", NULL, &buffer);
 
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(battery->device->handle,
@@ -624,8 +623,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 			msecs_to_jiffies(cache_time)))
 		return 0;
 
-	status = acpi_evaluate_object(battery->device->handle, "_BST",
-				      NULL, &buffer);
+	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(battery->device->handle,
 				 "_BST evaluation failed: %s",
@@ -675,8 +673,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
 
-	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
-					    battery->alarm);
+	status = acpi_execute_simple_method_exclusive(battery->device->handle, "_BTP",
+						      battery->alarm);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-- 
2.53.0

