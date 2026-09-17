Received: from mail-qv2-f21.google.com (mail-qv2-f21.google.com [74.125.230.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E3547045
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673940; cv=none; b=eEkJZWS9PpDFbBxutZFP366YTzL3pVoEN39Pe44tj88LOekjtJLBBDiOFfjrFs+fyJSEdohcuP9NnZe6c0KUs4UY4X5T5HiiCSrQ4GyYffIIDNkOLPGu2SPcQdYNsfoqfZpr8hGx2RwDJtC9vecwwWZkdzM6277QTcJzQhXBFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673940; c=relaxed/simple;
	bh=zlI6cPEnBqZ4NXZ39puSLHk9fcYVmQZ79vqcCv31lpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovIkNo1vosDMSFTBBm9e1DRBA2XY8el3WGrnicXlBOHmCLF/ReS9EuqtrVbY01CN/vlVvc8kQRH/imdFWcWSPay8xowOqIKriIfHGCCRYSINR+dB3wZLMLxN9yqML5V0S3oi7zvf24vAdbE4RiyTlSXJIlvUzLwWShkIunB8vPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKfFNCbG; arc=none smtp.client-ip=74.125.230.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKfFNCbG"
Received: by mail-qv2-f21.google.com with SMTP id 6a1803df08f44-90cdfbd148aso355056d6.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673936; x=1790278736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4Q6Ad+YbWNAFT1S/eagIuareTvI4szF4zzV0Tuqr8s=;
        b=sKfFNCbGpTNzeEi4ENv/2ziPTXiJatiCcyrImuWvgsAszaB7HN61JRrrd/XR+SbJNu
         a05eIETWvu2NtdSKYEHHMTFCeOQRv8jn3idx9svnVkW7w/FjUNF/ag5BkbNTIViPaU2+
         H1qZSdzd02z5ElFYYaBiW5LhPk1yDmgvpnN00+9mfdj+rJmsDQgYPGmy5KQr3OuMgBGI
         +xAJL17EF4GoXeC9Svfdt7wC/jdW5IkJidOsvW/zP0vBKIGi3bNB5x/Ac9HABHhOKnjr
         BZtqoHyzqA2E1NPHZm6MK/h7+LmH4M4+jg/nbuRkkS6CuAPTjzenNZApex5rB5aA5aAH
         goig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673936; x=1790278736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4Q6Ad+YbWNAFT1S/eagIuareTvI4szF4zzV0Tuqr8s=;
        b=DGxCKae9966pZ/eTCOa1H5OVNzOxtbCJ+WdN70JkWfsEyMtYpklPV1lMXiiC47CBdt
         FRuqdrhexkDsubQQdhg2t0bBTFEbvvwV4VMGWIq0dWU0J7NnDr7UYcf3QYgm1CsqiTEE
         YUo0PUsHpUwPYk3dGV9zng2YMR481FSyQWO1ltARZOxpeH634HGU1XB2EHHSV47izw19
         obT9dnG/hpZ98sPdvHI6RXLQWCDLSaMVOgBEQFm2PZwBqfV4dIqLG1blIy1kKFZUY6lg
         DFF6lk9+SEdNdAgu21Ef12WHHAtBwCh0cu/CUBPxu/n/oZpOVJaIc/eXKS9+lgkH1w7h
         fAbw==
X-Forwarded-Encrypted: i=1; AKwUvBzfxDwKyNkqyjJPDR2HdO00jemapHbhBDoWWJxkeqOCewEBpyBfB+1X4bt93bkNDUTK8A9gIus=@vger.kernel.org
X-Gm-Message-State: AFuF++lktVbZuV9GDf3ySOtjODFp7Y4mahuG3XIp1z2Sixo2mBDSzagy
	QcyrcMvQqMuW0D8G1XBEX5jmYhE4lqgLbNDzNHY+PmQPF+0mAIv9sAk=
X-Gm-Gg: AYBFou3lSdor8Jjm90vCg3u5ZrvHsTsKleUhyQlYdDHT/hNKUhuSIV3yG38OLpC8AV1
	eLDXQrftpZBsR1aGjPy+jYLU1HFKIerEu9GP/VbFaNUANG6cN4EYT28sNM3U7w0BGKwL31Zq6qd
	ylzVduMDaSnfOKVePAkq+Eu3wULaf9qGMc9PMQoAVSDf4kzKywXmGz9P9vsjOtTHaJiCT4V+QJo
	tRz5EFjDmGDH+URDYU8nJreDwkmVzUs8e3IYazilz3zVHfzvNGuUbJgw2G9OvI0GJNUDsBrBxoG
	+oMvx9XXCzxESH7s7c3l0ewJ1TLkYH7Az2LCG8CVK30qzwClZpx9k/ds/BamW4Ahr5jCepq1doy
	fjqgp0W3QhzLla0U3XpawjRkPm+ZIYFNTeq0DP3tQ6M/wiuc1PbhWvWnjGQGDuoit3nIBReYAtX
	ZBoZxgmY+qoAwYLURJ2N7vrpif2J0hIf6zaUks2vDTos4dczgb7E/b/yYrQnZJmpU5/Ghu8hUqo
	AV4HUC247ETRSTMa3Li4ZleEy/EkLoBGGqSWSK054VKV2JrF6WFoctaUAR0OLHqB7mt/WHYXW0L
	qPiO4EHZPDKiwdkCXn53SjLCgje5HT84cfrd
X-Received: by 2002:a05:6214:d06:b0:912:517b:912 with SMTP id 6a1803df08f44-91254cd0594mr3693816d6.49.1789673936433;
        Thu, 17 Sep 2026 12:38:56 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252ce6d54sm5254416d6.39.2026.09.17.12.38.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 12:38:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diogo Ivo <diogo.ivo@siemens.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: ti: icss-iep: Cancel compare work before releasing device resources
Date: Thu, 17 Sep 2026 15:38:47 -0400
Message-ID: <20260917193847.63849-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compare interrupt can queue work that accesses the IEP state and
registers. The managed IRQ is released when the driver is detached, but
pending or running work is not drained before the IEP resources are freed.

Initialize the work with devm_work_autocancel() after its resources are
ready and before requesting the IRQ. This makes devres release the IRQ,
cancel the work synchronously, and then release the resources used by the
handler and worker. Moving the IRQ request also ensures the handler cannot
run before the platform data and register mapping are initialized.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: f18ad402cd8b ("net: ti: icss-iep: Enable compare events")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Validated with static source review, apply checks and strict checkpatch.
No build or runtime testing was performed.

 drivers/net/ethernet/ti/icssg/icss_iep.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index ec085897edf090e816b05880286a3f43c69225c8..fa45538f1faa6c8b44e7dd9a4ebb7269843b60bb 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -857,18 +858,6 @@ static int icss_iep_probe(struct platform_device *pdev)
 	if (irq == -EPROBE_DEFER)
 		return irq;
 
-	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, icss_iep_cap_cmp_irq,
-				       IRQF_TRIGGER_HIGH, "iep_cap_cmp", iep);
-		if (ret) {
-			dev_info(iep->dev, "cap_cmp irq request failed: %x\n",
-				 ret);
-		} else {
-			iep->cap_cmp_irq = irq;
-			INIT_WORK(&iep->work, icss_iep_cap_cmp_work);
-		}
-	}
-
 	iep_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(iep_clk))
 		return PTR_ERR(iep_clk);
@@ -895,9 +884,24 @@ static int icss_iep_probe(struct platform_device *pdev)
 
 	iep->ptp_info = icss_iep_ptp_info;
 	mutex_init(&iep->ptp_clk_mutex);
-	dev_set_drvdata(dev, iep);
 	icss_iep_disable(iep);
 
+	if (irq > 0) {
+		ret = devm_work_autocancel(dev, &iep->work, icss_iep_cap_cmp_work);
+		if (ret)
+			return ret;
+
+		ret = devm_request_irq(dev, irq, icss_iep_cap_cmp_irq,
+				       IRQF_TRIGGER_HIGH, "iep_cap_cmp", iep);
+		if (ret)
+			dev_info(iep->dev, "cap_cmp irq request failed: %x\n",
+				 ret);
+		else
+			iep->cap_cmp_irq = irq;
+	}
+
+	dev_set_drvdata(dev, iep);
+
 	return 0;
 }
 
-- 
2.47.1
