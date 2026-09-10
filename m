Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C93B7B8C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084487; cv=none; b=R8k0LsAhu/bpYDU4ao4s5FJysnkm/ZWGhFSz1jtvEcGnBfFWjpv5A7I62HOZ7Mjnz0+q3OeiyKVdamUDWTk7x3E+dbtcec32O9LxFOPQ3rrdL1CXVab00Njs31goRPrGP550Xjtx1SEKDJySaczbeuTufpoeqyLKx9Lgkhihpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084487; c=relaxed/simple;
	bh=WueL8tY9e+f4EG9kegBhb/48QAgoQxxqkg2Jsh/Y0p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh1FDlMtcxJp8jbP2dmDYfqqjyn4U8aGGAoFt0YUMNddxWrOmcZyWOY56M/2TImLWNp9PDhkX1r0g29IZxe3UmKD1f/0MLMT8N5LsaMncEaJMwK5ZLNrHHpz4CLKBgpbtVn+mwVGrG0V0Hzmcs89c5JLBN6vHcWq1wlE1LoomiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9d+5DfR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9d+5DfR"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52fa6005224so4481431cf.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084485; x=1789689285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=imdVCDjW8TkcoAnhfj8hrX1xpu4892DD4sMcv+6zDbc=;
        b=G9d+5DfRAhTSaQHdIyzsmK7qa1BdqPLpp+8inNjSBxbl0lSEq3vHk12gyFRKfz29bl
         mGkXUDZAns5wH/S8+DLeP1vstuB74IWZqWiWAbrrTH7MBEfhQjjJmfNk2Hi90QBf2qqm
         NpwcpmhC2UGvs5PexFv6qgj71OSzW//jkHLGrssQSEF5id78ScTTXSpygcYqFGeUllrn
         66Dp2H/T9yqYKbzv/5fvnVf1l2k/RF2jYd1T5LKsOzI+gfqx1qmxL9vg9ScKZymQQAd1
         +x094yeyHv6bxYbBVaDHBuBbfb3kzLDGZRom74NufWWt70FQ51qNSrqhCTQr+WAejJmA
         dj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084485; x=1789689285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=imdVCDjW8TkcoAnhfj8hrX1xpu4892DD4sMcv+6zDbc=;
        b=R7UNsvWq5Oj52aveHynv4HptVHxoKXhDcukLq6C0jCVpIQ1og9vqI5oguOAiv5alZY
         irqHT49xeL4h/9jt4EYyz2AM9qubOtqX2Dd8PUJ6SlQ+4Q5/pwHERITrPcs3rbZ3zMzj
         kOzMOEkQKNslv5VazvSc4kYxN8Iiy2hjBgBl8nZjhMnzi0FarRW8DzR0jngKZ9ED8sVL
         M8Wa8bcezmBvvAsuMSlC1zwXgzpMo3LEM7t1NmWqMo15sbpRR7xl544NQvBvfi4ZJQ/2
         DyZF/CpsHwBde67xKg8nKPX3FvpBTs4sPJoQf9ugjmnYakZhhKbSC5LmCIN/PQ+VfBXY
         bd0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxB9VvMF+vQy9X+KWU+y3ls2BzaXmImpjFoaYirQ72sCQM4T7U9lW8Qpq2wYQobLWhnzB7+IxI=@vger.kernel.org
X-Gm-Message-State: AFuF++k8zvEjo7DaiiflPAfUCdcIJYdnxuQiIUbmESPywAj9UjgD0ira
	0Wd+uNToKsFFekzwD/hID+LtzvTZByImJhU4Wv+tREbpTAxVngkJop4=
X-Gm-Gg: AYBFou05obf4LuyzKseZ8VTEKddqug685+fua0wKBTo3ty5/pV3uZjJSbKy4Q/oyaT5
	aZwTXsNgP1cBDt3Zuiq7arctEAMkiwfgy3QTCXA7Z2VLlGZ8SHpgwss9jCAKvxkS1LAenIBX2fc
	wBPpH1x05xcTS2/FH0y70h1HFdSA6aVom5XcKDrg8CEazq20GYcRIsJsSf7JWLW/uczBOp2JyAI
	bCtmQdnVAnK2h+WlWo3fZX6Llyji9lLPbLkklnUjdmWria4vQ9Qb0TfXpO284zsK6pNn+sIaXSF
	cu3LTUVYh6LvHzbgsYMXdLr4VkuSmxXp0oOuiht8x4s7ZeoMvp7d3FILYTxCHOlWLCunaUzNZ/G
	2LrGHWVuir5ptVT2uq8BnwWBGtyIyqYEow8uYZ+Kqya4Zjv/BXhx1ngBFMQp/9A2uiTOlTizOW0
	m8LgNz4Wvn+vHSMQaJrKnRUVXKqzLaOagDcC/pfdNlNbE1iY3L21IKoKpVrBGpgcKYj76TtISUv
	66aEfpT6JtBGRe71IBmwxSKI+YWiMvHY4MVo9JAcNWkpKECFEzp0gBg95QGItfuRb4gpq1ZfxEq
	OYw9QijLAlnZi2pH94J0/g/uSkOKwkK8rQ==
X-Received: by 2002:a05:622a:2294:b0:530:b2e4:d597 with SMTP id d75a77b69052e-530c87487damr29756721cf.50.1789084479899;
        Thu, 10 Sep 2026 16:54:39 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca48912csm6100771cf.13.2026.09.10.16.54.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:54:39 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Christophe Leroy <chleroy@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 4/4] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Thu, 10 Sep 2026 19:54:30 -0400
Message-ID: <598d90cf55981c38288fab8c32dd52286090f384.1788128904.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788128904.git.mhun512@gmail.com>
References: <cover.1788128904.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that object and its resources without unregistering or freeing the
netdev. The registered device is left with a dangling private pointer.

Unregister the HDLC device before releasing the UCC and DMA resources so
an active interface is stopped first. Free the netdev before releasing
its private object.

This patch depends on the preceding "net: wan: hdlc: close active devices
before protocol detach" fix (patch 3 of this series). Without that fix,
protocol detach clears IFF_UP before unregister can invoke ndo_stop, so
an active interface would not be stopped before its resources are freed.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260803133048.42650-1-mhun512@gmail.com
Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 596f4ef053636..371150efc1a65 100644
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
