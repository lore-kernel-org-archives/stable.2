Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F363E5A38
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541510; cv=none; b=VKq6gNfO6SkdJVFa/A/PMAxW348cm0a/6pW7U0qpBTyJBqWeoSUKoUP3t83aep2yOgbQkqaqmD12KHJNw0z7NLW6BvPo/BOdcL/I7VUiEeqeqjq3O6DTXdPrxHg5de0lnSxTqQRPcNekQTGzBFTgFovOqZsx5JVVsSEBV0eL/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541510; c=relaxed/simple;
	bh=fzdVRBFHxJxY+YTfyuXhR7kIKBfpFjNgij1UV4zMuq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyyAPSsttqVmCgIQ6HHDoxPxtaEKEXRi6lnGAFit4MiE5VMgJsw/coFhsfNSXAtOLMQ2ylnVN8H/YL4dS6aX+P2ulOApk4aN/7KOQ7WWxvvUt0GoHfqOe+XEHCXm875zMfaEQKXk6N5gdLn1115Sq93LJcCDee14cQwsyI6dz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbTu75qQ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbTu75qQ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso363323a91.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789541508; x=1790146308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AN3SOTukBoOl3ckWtu7ycjUkrBPQfO8wZi20AvSxNVY=;
        b=gbTu75qQoC57s1gMoAikpg97jgc7jvcfuXFFSgce5v4J5c1bFqPgVdXiizcXTD2pW5
         CkHtcISpux8FyWjEkWOmaJQ0LyT9OT2xa1tyxTIzrX6Es2pICJ3p8kZqdk5F7j5ZdU4k
         EUizwHQMLbcVqoQ9Pp+8r2sXivgnOEsTAt5vhz/c7tI0L+ch1ov/ETKxVdUfNkk+qtKv
         4zXqO0BjsHqXCtTUZNSStY6ibtdECBEyj6PAtqbVwAFPheM7/HpdiylCDA87kZOsU0XN
         Ci79ZhJtTPYdS9SZtUKI/EN0Jtt0lZJ6IGqa0y/GmxdjI1ItrgQVAttWeaKVDG2JiEOs
         3K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541508; x=1790146308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AN3SOTukBoOl3ckWtu7ycjUkrBPQfO8wZi20AvSxNVY=;
        b=gjhiKOq3fpQf38JWHS2sIQZYlqkKbUXLZBAArl4AbC/7RQ26k3bLMprgclzLIRmdMO
         5BLEcvP0jQGJsSVQugaa/AqALKV9ybXAQdu6MoUYfs6xPIh1uzVCyaGeFrwy5dpHyOJG
         +uMQ40jVDKdHOb2MOoF9BJIfxyMWRhquc3Obuvvbkv2CWdfeIAi3hmOCMM5zjYAMpe2k
         zJ/XjrnAEbxbbUO2QLhJ+9aU6a1wXPr58Gcq9s1zIyDGroyzs/9r2+vWIx0VGRnS1jCV
         VYMtAHiDZ4UUx3dCbUpZUc/KGM5Z+OjkLHbIFwXf5dlkuSqHm/iIpPZNGH5eVZCRkMfk
         BUrA==
X-Forwarded-Encrypted: i=1; AKwUvBxMbeDemUjlf6J04ip9J6nCt+onp+0e1ksQLGHj8FLo5JoL/2kRWtTw5dZNIF0XhqpvphP/5AU=@vger.kernel.org
X-Gm-Message-State: AFuF++kVpp5FuDGRI+9jWdX17ldnPcI2NN672ZtPTwE7RmmdGRctZ37+
	jXXFcpzgC1BEcNsp0P++RlxdrdY5n3gVnAlm6AFNAbbe1l9dNymroM9C
X-Gm-Gg: AYBFou1dccTrbV2PJ7ztYb+EWQM81yLN+IqcjkTutA1qr1ZFfxP/GH4cWWSjo5rjY43
	Zr5b8InmxsC0KvVqggYY4eHxAbr07xq2BH7TdI3cQDemxf0F6IrbbYb2WwBgCUOBLmDROOJLN9C
	D64s6UyZzzv34KZOJhC5lYUNOv72bh/K76LPwDcdIX+XgnG28Kzx5nM9a/KYpCciadlgoLyOJS7
	8VkabIvuhEz4sDDemPWd3jy266R6T1icvReOfoE+/CAFh4lCZendkjKVjqMvxOsWffM0sTH/Hi/
	HEDCdILO9nxlShL32X0fZSAIEly4Mi/djdiIiWBV72PGm1ydW8UEQlkxmA+jkV9fvUv9U8kcXB1
	kk6uOf9Vn7eaXXUD9W9O2EQ7Y9p8h9c8sWIYcAQIOf8U4jai+oJLozToyy5OLlmct+hWmBsCG8P
	jooRbB4z9jxNZUC1SRco9DYXyPvxjZAZf92XLBPSnjdoLwubW0y3CODw==
X-Received: by 2002:a17:90b:4cc8:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39e1e330a2dmr3903318a91.10.1789541508193;
        Tue, 15 Sep 2026 23:51:48 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b9068c6sm2903880a91.1.2026.09.15.23.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:51:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: fsl_ucc_hdlc: release resources on remove
Date: Wed, 16 Sep 2026 14:51:36 +0800
Message-ID: <20260916065136.2926089-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() allocates and registers an HDLC netdev and, when the
TDM interface is enabled, separately allocates struct ucc_tdm. The
probe failure paths release these resources, but the remove path does
not.

As a result, the registered HDLC netdev can outlive its private data
and retain a dangling private pointer. The separately allocated TDM
data is also leaked when a TDM-mode device is removed.

Unregister the HDLC device before releasing the UCC and DMA resources,
free the netdev after the hardware resources have been cleaned up, and
free the TDM data before releasing the private data.

This issue was found by manual code inspection.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93f5..ffc8b989e33a 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1254,6 +1254,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
+	unregister_hdlc_device(priv->ndev);
 
 	uhdlc_memclean(priv);
 
@@ -1266,6 +1267,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
+	kfree(priv->utdm);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.43.0

