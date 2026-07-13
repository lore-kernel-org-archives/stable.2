Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C0438028
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953841; cv=none; b=rO/XzUaMm0Kknki7Y6QTXYxnlKX2eia4V/oZujIb2bnQYCggO+fGqyt/wobh46fcDWjriwf+0EVDQvPjYJAZzEMcX0fJwxGiNMRLEwmCM/W5Lg6kB+GcCr6llY1WeOwOeMigK9byPQBu/i99uuslWMA00W3XdEmN0BCZ1fFA4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953841; c=relaxed/simple;
	bh=QFScjVTqoh4F0Ect2GX8qD5z7jKyTtnc9qxCnA67yGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lltOyyHfRoWVCcA2fu3fZASYS7YorwvgvrM7VHA2rur/XgBZHBKqq9IgmnuiYYP841TrorTrfW1ENnILelVShmHqP14ODKfcd/+xLD5HD4DWSvQOYrXGAaoegW+IwMSNyUW6hTVG6PaSiBpsod222WPJl4559SqHePGOBH/VJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D5WpgTSH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D5WpgTSH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1540B1A0F9F;
	Mon, 13 Jul 2026 14:43:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C763E60345;
	Mon, 13 Jul 2026 14:43:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1393411BD05B6;
	Mon, 13 Jul 2026 16:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783953831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mgoRmfCNtNFVeeYwLQYefomCmpA70gvR/bkP8iy2YoI=;
	b=D5WpgTSH/+zxYt0fMiG8fUyIRa92WBF0B/56UVukU+YWHH5IgOsCpJPm/FS4b/ETVcM3Xw
	ITl/b84y54UNQ89WbObtUz6AeOEj/gDJFVexg5uw+A3AWqK8S6od9poK/beIXK05foNU80
	nZ7GS0B1Ss28OQysXqPEQVGgBeUOZhydKh7n7x75HKJh2lxhT9BCp2B2ZL4LRgaDZBJcAC
	y09MZ6rgM9MtvKf8oaaYClsuK/tp1Gv3sBlLDiWs76fH6dIvvISuM84rk5moINhzXokuLQ
	kktd2MoiGp7bFNYjkmzM1ygGqm+r03YMP8MILC0kZARXPkVBGxo79Pmgn3jwdA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 13 Jul 2026 16:43:43 +0200
Subject: [PATCH] mfd: cgbc: Fix teardown ordering in cgbc_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJ75VGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0MD3eT0pGTd5PyiVN20zAoIryg1N78sVdfUIDnJKNXSwigpMUkJqL+
 gKBWoBGx2dGxtLQCxK7IWawAAAA==
X-Change-ID: 20260710-cgbc-core-fix-cgbc-remove-50cb2e982bab
To: Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Release Board Controller session once children are removed by the core.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/cover.1783507945.git.u.kleine-koenig%40baylibre.com?part=19
Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 10bb4b414c34..2becaf797646 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -364,9 +364,9 @@ static void cgbc_remove(struct platform_device *pdev)
 {
 	struct cgbc_device_data *cgbc = platform_get_drvdata(pdev);
 
-	cgbc_session_release(cgbc);
-
 	mfd_remove_devices(&pdev->dev);
+
+	cgbc_session_release(cgbc);
 }
 
 static struct platform_driver cgbc_driver = {

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260710-cgbc-core-fix-cgbc-remove-50cb2e982bab

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

