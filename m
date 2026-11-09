Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199123;
	b=lVora1UQtDW7T7WH+jiS1XMYJfxwMevyVedKJlueCnfLaH6nFHv6VRjmUuNnlXcwOQIR
	 i8wgMzJEjEPjTptlYaEVKwcRH6WYa1Du9KtNkks6N9JCGT2J1w9/wFKJ40hM0cPIa8JRZ
	 QWO/gzddWhoamCE0xfsMWZGfY+izcBlSUPqySDThRlPumCmefrzxxtyMZSNM5F4ooJ/4o
	 39mujY3+N7CGIErb2HLxRu1KfnxzGYz0inVjCraYfHujc2jSK3NUtWdDC9zazWe7aKHBz
	 nfCWGhwRdWRaVI7BKLpwTbF40kCfdRjULBXEFE1Mr1Eu/d3ZaNTb/uhANsmYe+oVQEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199123;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VnyGCZlBiCMpGECUC/uuk3qO0l8oc5IWtcXelbxc1Pc=;
	b=OqrfXKeD9WnAHYkHXOuCKmcnbA9/2/DmALTgU3ZnuC/rp0ShmgRPcr00QbRcuShOdydH
	 ZebNwtDa0nnba4I14FR2AitowCjTCvAhzfqxRNFhMulwSwcddsKvYHwbRpt18OfTMI9jM
	 dPezH0ec9HMZdZ6jOVul7gJBVRMm7ioMrkuxdpGlhwOmZkFj79vu2QGY+RodYQuuoBkNR
	 ABAXDBAWPmzSNaBIdzoGtOYzZh6gxGpkoif3PtMCVpLWhdxWuld+Fq/IAf7aQVc4H3OCn
	 9QYBK+B/HkphbKFHDnhW4h0yvo9xtKwHWueLus8qwgphCc2VDbNPmW67fXcbuT4d86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=efWucSc2;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60764606A31C;
	Mon,  9 Nov 2026 04:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60764606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=efWucSc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=efWucSc2+npSO4CmuFLi+0YWXEMlBYi0ARIJnAB6y8iO2Wh0xg6fUSdSLf3ffrRTvinoUXjl92yq3
	 RikUbekUhjLw/4eWrEI21u/MRAgELsbqxM57RDd1FvJB7irUbak5pmXXITGl2/i1VpsDTVpcGMAXaX
	 vCBdKJOvQyYgRq4M=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af14e4e118-c193a;
	Mon, 09 Nov 2026 12:38:39 +0800 (CST)
X-RM-TRANSID:2ee76af14e4e118-c193a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af14e4cd7b-8170b;
	Mon, 09 Nov 2026 12:38:39 +0800 (CST)
X-RM-TRANSID:2ee76af14e4cd7b-8170b
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: bcm_iproc_tsc: fix clock prepare leak in close
Date: Mon,  9 Nov 2026 12:38:35 +0800
Message-ID: <20261109043837.586-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

iproc_ts_start() (the input open callback) enables the controller
clock with clk_prepare_enable(), but iproc_ts_stop() (the close
callback) only calls clk_disable().  Every open/close cycle of the
input device therefore leaks one clock prepare reference, and the
clock can never be unprepared again.

Pair the enable with clk_disable_unprepare().

Fixes: d5ae685f1530 ("Input: add Broadcom iProc touchscreen driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current upstream master, which still has the
unpaired clk_disable() in iproc_ts_stop().  Not runtime-tested
(no iProc hardware).

 drivers/input/touchscreen/bcm_iproc_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
index 9c84235327..07176f8631 100644
--- a/drivers/input/touchscreen/bcm_iproc_tsc.c
+++ b/drivers/input/touchscreen/bcm_iproc_tsc.c
@@ -330,7 +330,7 @@ static void iproc_ts_stop(struct input_dev *dev)
 	val = TS_CONTROLLER_PWR_TS;
 	regmap_update_bits(priv->regmap, REGCTL2, val, val);
 
-	clk_disable(priv->tsc_clk);
+	clk_disable_unprepare(priv->tsc_clk);
 }
 
 static int iproc_get_tsc_config(struct device *dev, struct iproc_ts_priv *priv)
-- 
2.39.2



