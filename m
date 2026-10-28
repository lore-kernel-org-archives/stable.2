Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164347;
	b=o2YP9J5pzeuyDKb9kdOroWfKEm7+yTSF1VZJpiCkxBPHuAMOaAA7o7B/CVscVbkWnYh4
	 zoFRksEQv7AumCXZ3lVPeojLi6DMApYqb7DaGKlL6B1VdSV0EXUPcLvOEc7jAIu2WjsFT
	 6fmVa4FY9wHZDSV1wYYMD73iKQsd436paPqJ5t6rXFfE08L/fLU8XGC7Iwp+xaT/tQES4
	 lfqE250x5smkdPdwv6tczAibYJ3WUBb+3JRUBTd24sSC5YpDF/PFZsLu6luuj/oSM3Tum
	 pfJPeFzJ8CO2g7KQ0stkfHky68WTcxA5EiMOaTI4CCESfkeQO00yKGl8azOHmulvPKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164347;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Qle6PKpbLiG+C4WiRNBNTT2whjds2n+JexlNVDlzam0=;
	b=xLJFNpW9mJmmEYDpTPUu2iGS9XPD8wn7s9cHwrnDRQYHpsPCMhMMTyXJXX7GxwlvrDIR
	 a/KiqmgT+OnVeCFedDcToe2yoWWyyI+rt54fQ8h0EcvciZ5Z3M31zJ1U5nRYkaOC7uWcQ
	 7NwpFWU20HQAtS3QyldGMEaLIYdswh18Mq0Ovy0XQnYC4bTkl7KEE3QzZKNzFANEf8TDS
	 uJtvp888P9InHJEF/3Zsmzc252mdK0cmQyigbM8IMUr57JOsQKzfcH3l2FLsnrVTCtKEd
	 /mlB2RUay/mSVudAxMb0cK6CMqYS6wCUJCLPT1nVq0RB1LzZKJsTv2vuAg80wh6+AlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SMpyOY9X;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63983606A31F;
	Wed, 28 Oct 2026 05:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63983606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SMpyOY9X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ql
	e6PKpbLiG+C4WiRNBNTT2whjds2n+JexlNVDlzam0=; b=SMpyOY9XiuxziwuxBY
	LWxECFcL9dIrTKqWavTlPrUF2FX49M3bdiikBAUOxCJADxdqHaHNfm48lWjQwGXC
	4Py/H9Z5iiQt2PszEztO3mlzOLRxSW5Qbfi5vGUug5nIVGz4oPD91bSqp7L1M4bp
	tXORyYKcBGxmusq/rG9+YiFI4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDX_wMghOFq5BQxDg--.58804S3;
	Wed, 28 Oct 2026 13:12:02 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] platform/chrome: cros_ec_uart: check ACPI companion before use
Date: Wed, 28 Oct 2026 13:11:59 +0800
Message-Id: <20261028051200.145621-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028051200.145621-1-yaojiale02@163.com>
References: <20261028051200.145621-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDX_wMghOFq5BQxDg--.58804S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkWw18Xw48ZF1DAw18Xwb_yoW8Gr17pF
	97Ka1DJa1jgr1kGw4UJw4j9FWY93y2yw4UWFWxZa43Aw45XFyUtFyYya90yryFy3s7KFy2
	vrWDtF1UZasxXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiqXdUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgI8dmrhhCIRLQAA3X

cros_ec_uart_acpi_probe() passes the ACPI companion to resource helpers
without checking it. A serdev force-bound without an ACPI companion can
therefore cause a NULL pointer dereference during probe.

Reject devices without an ACPI companion before parsing their resources.

Fixes: 04a8bdd135cc ("platform/chrome: cros_ec_uart: Add transport layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/platform/chrome/cros_ec_uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index d5b37414ff12..779aabd16674 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -223,9 +223,13 @@ static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
 
 static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
 {
-	int ret;
+	struct acpi_device *adev;
 	LIST_HEAD(resources);
-	struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
+	int ret;
+
+	adev = ACPI_COMPANION(&ec_uart->serdev->dev);
+	if (!adev)
+		return -ENODEV;
 
 	ret = acpi_dev_get_resources(adev, &resources, cros_ec_uart_resource, ec_uart);
 	if (ret < 0)
-- 
2.34.1

