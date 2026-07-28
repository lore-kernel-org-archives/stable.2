Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A03998B4
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258957; cv=none; b=h8TNT8k29IaBb2jDw2UQgwNZUNpF5Njsr3/lCe5CXqosDoMb8Ur/eWBtxPaUVmuUgVtJ7Jw6Rc2W0LjUTPdkk4mBgLXEMLDzyyewRalYdmBWSKMWJjsZWdQVPm23B7Fz0iUorp6snXEg76ai/cTNKX3r10UXNhX7+Z5JRJovMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258957; c=relaxed/simple;
	bh=OKcAVSyqAk8ru1r32n3EaZyWolAJF1msAtab6WuNRtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfdeoGzRyR7tNqH3crPXsiff/vR4HsIvE7Soz9wemW+WelFoiqRG/Z1Qk/mZNU4ocIRBje20Bj8FFY+2uLMTcJMxm55bzNGwu2R1V6MwiMc6MfhUvNsqBqoHhUjHrdcrXFSAiSqamnVW/4Dr//XVjZUOb1DYnKHtkQC3viAH9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZY2fJIp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZY2fJIp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caed617615so1496295ad.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258955; x=1785863755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vqxAh8CqqJc99YaNfeG8WErYj9oZt2HH/TEPC3CmhQ=;
        b=TZY2fJIpWe+ACwobPSWzhycUHmIEdw/uxuwg9oMd6xXS7JCSfG3LmGfqpvnHaaVlHK
         v13aN1/IPe7WksXREtOxfseYldwuvlYTIqicMMCgXL28KgIswYX2qA+7kUgXmPrtLlfh
         txnmWaAj/of0lcwPzaz4r7QIK7hE1ODSHtcLvVfDxDNOD6weGlIm/eY0RJLx43iT965y
         1HpXUel8y5QoC74gPIkClB3/DzuqXaQ2faug9TBKMdjLEzRYWdkSts1GRc1T/9FiBZTH
         KfIWcQ31F3p8+X7mQUhGwFwMHHToahEl9ndmwbhHCoxI0JbXbFc7pBx/c2S3un3aXQSV
         GXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258955; x=1785863755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vqxAh8CqqJc99YaNfeG8WErYj9oZt2HH/TEPC3CmhQ=;
        b=NnUuXSEWv/TL1h3vrr/mKSfkf0m05+i+quJnHAdUdicieUBZtgTPrPBWEMKxgrOYO6
         mA4hHkDI6hEm607o5A7buQtOA5XnkBuFqfeKh8XJshKhZxPDv6ILyCyqpRKl3a+lZguV
         eqDvuF7dlyGK6INrRxJtykyCPTZhfK89+qQ3IeGhAZtssD34UniU/26gDlPqr+Fz3CYs
         4kNOHSmGwuXhjOs5iz+9K9Un5+Q2I++o0t269hlCoa2DOTMzqdwkzLOuUB8SqhLTqhwD
         GsvlTBiN98eMn11/kqV1ST3Q+AJ0CYNv/AXTcwLM6hcWol0FShv0EBFMscn0+2MXO2EF
         Ks2w==
X-Forwarded-Encrypted: i=1; AHgh+RpKktSgCEky8Op5tWe7MXm8mPNE+31zmdCxBaM/8RA1COae3UDdENl/PD6tjFF1KxDc9JUyA+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7UMOMK/MjqUS4TWbezxgS0PxbqpRW7p3vTvYXnrmrbrO1Y3G
	kGEeBF9N25qHoB9NYlUF8Bdm6+6myfmJDYRiYTPi5FIjh5wCh7EJ5cLFfAZ5RSY=
X-Gm-Gg: AR+sD10X1ESj8vipqfqUE6crZ9AJ6L2zeRhPPuGcBDY3iOS1S3XNNSgDb8O9F1+GoSn
	YlbV3LTB5wvAEisCJG4Dmwt3CEuseWgwg8qx+kxHMSVzM5v+wVxuJzrHFA32Hg4DLIghx3CqV9k
	Abra0HJvM29e4kb0UsCIhwKT7HtGHASlZzNA+Efiyc0GGARHZpJM7ULT78D86U408xDIW8xMIap
	FFpQy8JN0kGxEnpWIlm9CKRF9JvLakyXATAraVAB/SZS+dkd+CvmHNJ2tbK+deGFFoFh3Ptdxt1
	hHKwUtUxAstAOxR0cyfqxQ6qRaUc8/Ac0TOURE2Nyi9ARthmxuGqtFtvjX6aPF006aphK5KYO4N
	Ilsmb3IRWm4Z66N6yazK1gn3EUzaAooc0lFa7/qJq0JclarYW7was4hzALSYS0mVPClkygXE7n/
	QrIF1gtxM1K7R9Nhw512LEgrMYmgpEqU3+HcYAxViwncC8PDFomZEGn4Y7TNnR831n4T7WNj1lt
	121ACb435qBgyUQ0gD6p+mKWd9ubSSuVGkPwdum
X-Received: by 2002:a17:902:c40d:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d015c2ab6fmr39514985ad.14.1785258955014;
        Tue, 28 Jul 2026 10:15:55 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a466a9sm3235ad.22.2026.07.28.10.15.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:15:54 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Wed, 29 Jul 2026 02:15:45 +0900
Message-ID: <20260728171545.49247-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that private object without unregistering or freeing the netdev, leaving
a registered device with a dangling private pointer.

Unregister the HDLC device before releasing hardware resources. This
closes an active interface through ndo_stop, which disables NAPI, stops
the UCC, and frees its IRQ. Then free the netdev before releasing its
private object.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb9..4c843c94c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
+
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.47.1
