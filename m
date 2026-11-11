Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364968;
	b=vFBkjZlw97mVA22fxAS5Tl0SviOdUoPG76MaJt7SzeBForFijwgWcPqUVw/I8t9bB9h2
	 cQ+nvfPdH66LdkvSSTAjPtbZqo+evLkmNeVZqaz9/kNF+LsXDB+Fmq3bOEh9YdYmf3EkG
	 UhdnnDz+RdKvd6ZWs9IHUpr6usW4scFgf8ROXeRG6xgvDG+PKji8OqB9ydM1GOOpCrWoS
	 OS707uUY9qWeqgpYOewkUPs+eWirgJaBOjPUVmb2Wsz67M2nMEMaBqGmzE3qRsKeRJr5C
	 foZftTQZcMBruVp3EiRzc+bfM6PBxy1TYHaLurpZCCgpH3hGZogkyEBQdDg2YqgCYAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364968;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WW29g4WNV1Hk+OO7jhC7hXp6cgcgf9Oh9pPH/J6mlNA=;
	b=GyH4ti3snnjPD7EvvkQyGc2c82VJaEonUiQESJYiqk4eVXiNWzXdhu1dh8wjySNUrkS4
	 h5Mz5dxG5uAJr95ef0uhCDoKKBBFdVGOGxWFn4NEtEY3zuP4ovadhMkPyT+RTLhMotOP1
	 sqXwGx1xjufbXPgBgluNXtdOz+QDydZrU9+qffc5xy+tTZ8FVHfrSRwEZCaLJNzoi4MBm
	 L6OmD7ksu+zivKvG6aALs1sSxH83IbNazQC7Q2+ma1tYOFkvbYbrfcON9VtCn9QkC9RxT
	 eWZ84SFjsP0B9psq4+H403tdWoyApIwtGcDUsGQmicyPBRRUTKOWZVUKadrQWdnQkNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uBj0QRCX;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F1606A31C;
	Wed, 11 Nov 2026 02:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uBj0QRCX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=uBj0QRCXadf9RQef/555MnLh4WP/qLqqUaw+Nq4GuJC2rv6PWEISyo6qMfMt4XCmhNv7/9F7jr60j
	 XBux7OSBcdxPtAdDriWEzzc2F2Em2DAPuNiCDpEg5+zZmTO5DbY2OlXhOFpOD13IRuYaaeORZY6TIF
	 WUM9iE3gbRJCNIQ0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af3d61dd36-9f549;
	Wed, 11 Nov 2026 10:42:38 +0800 (CST)
X-RM-TRANSID:2ee36af3d61dd36-9f549
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af3d61b011-cb3c6;
	Wed, 11 Nov 2026 10:42:37 +0800 (CST)
X-RM-TRANSID:2ee56af3d61b011-cb3c6
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: linux-spi@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Li-hao Kuo <lhjeff911@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend
Date: Wed, 11 Nov 2026 10:42:35 +0800
Message-ID: <20261111024235.1542-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261109045314.1211-1-zhaofeng2@cmss.chinamobile.com>
References: <20261109045314.1211-1-zhaofeng2@cmss.chinamobile.com>
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

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

sp7021_spi_controller_resume() enables the controller clock with
clk_prepare_enable(), but the matching suspend callback
sp7021_spi_controller_suspend() only asserts the reset line and never
disables/unprepares the clock.  Every system sleep suspend/resume cycle
therefore leaks one clock prepare/enable reference, leaving the clock
usage count permanently unbalanced.

Add the missing clk_disable_unprepare() to the suspend callback, and
reorder resume to enable the clock before deasserting reset, so the IP
is never live while its clock is stopped; this matches the probe()
ordering (devm_clk_get_enabled() before reset_control_deassert()).

Fixes: f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
v1 -> v2: Assert reset before disabling the clock in suspend, and
enable the clock before deasserting reset in resume, per Mark Brown's
review, so the IP is not left running without a clock (nor live while
the clock is stopped).

Verified against current upstream master; the probe path has been
converted to devm_clk_get_enabled() upstream but the suspend/resume
asymmetry is unchanged.  Not runtime-tested (no SP7021 hardware).

 drivers/spi/spi-sunplus-sp7021.c | 16 ++++++++++++----
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -507,17 +507,27 @@
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
-
-	return reset_control_assert(pspim->rstc);
+	int ret;
+
+	ret = reset_control_assert(pspim->rstc);
+	clk_disable_unprepare(pspim->spi_clk);
+
+	return ret;
 }
 
 static int sp7021_spi_controller_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = clk_prepare_enable(pspim->spi_clk);
+	if (ret)
+		return ret;
 
 	reset_control_deassert(pspim->rstc);
-	return clk_prepare_enable(pspim->spi_clk);
+
+	return 0;
 }
 
 static int sp7021_spi_runtime_suspend(struct device *dev)


