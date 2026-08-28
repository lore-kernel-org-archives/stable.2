Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085539AD2A
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908977; cv=none; b=fIRzqgOJyUgOS9h2m8PVCVl46XzMwp/eo0j1WKSt5HLtfQNM6CwGG0S+kM6BjcYL9kA8dIyR+rn/X6wHbKTrj13pSuvqccyGUYrEjO52CnkpJK31blZAHwgdngCQ9JELvIieSyF8O+oaNUFJ1GsywEIjv/eAPUiRfQzKG8URJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908977; c=relaxed/simple;
	bh=ey7QBCaDld1Q/XVKLLwtP0hYutZJghLE6jPBnqkv3CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkHniii6tSAhzMylUh5ohDmVreRczSsSezlhOKoqrcPFW4PxmEz4pmrFwkN+JtK6AXCvT95IM2IzAkmAyBSQKEIp1iecpAbVsIvkDc83JIEFxt3j55rW2XSJN0v5CPUcuQgOyCCWqYjCSt4+8cPih2Sj7cw1Pq7YOtPeF232GIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua; spf=pass smtp.mailfrom=iit.org.ua; dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b=u4IrY0Z6; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b="u4IrY0Z6"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so2109955e9.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iit.org.ua; s=google; t=1787908972; x=1788513772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oMl6tXRVOo96S1AJPzpgtCrziqZeX/47A+u1zT3/48=;
        b=u4IrY0Z6hqWgpA1FMsAbYBIcOgHWh7Nk0FJXvpNEYfcCEWAS2WAV3CVQ24LgDm+Q0F
         hvE+QaUyE+AS+eQhAQ5XCxC3Gme54/cnzvun9C4EcjGTHRMB21pEN6duj+XGcdV8sV71
         DSknZ27sYfUghik0ypBqjqTSMVfFp2V+2vRs4prCSYkMzrM1eT01oLfS9R2fuQvd22IH
         7GB0HSZzyyVTlDBKTsXOAP6t/ndpl97rR4EQceDsS3hCxd/rG85tm4tdx2l9XDwjPVox
         LN2GPJh4hRBz+qtoQSaBUiJT9BeIzg6rS9UVgdjZEgsZYtvROG8a5OxSTgDzHZaZDdvq
         g/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908972; x=1788513772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/oMl6tXRVOo96S1AJPzpgtCrziqZeX/47A+u1zT3/48=;
        b=gwNu0IAHclFMucxHEGY2PNIBX5Kng2+aE00aCw8qn9j41rAR9EKidAkzL48yKoMk+4
         TrM6qBvSsl3neWPrgGm8uo8ShVwJp8FZMbxtHvSxJcJf5+RSBPL4iIH/cb3vDY0TcAHB
         768zwNjNXYMCbzN3MfxfPQNMGo8UvxMxuJcyGjRl1gu1bTSodPEdrNPl75yPHN2KULK3
         oKphRDEqP6qCHhJIY7TTIxmVLYF/jptjAVSEL6vlm4eJ/cxbop9dKjqHHjbxLyXnIUhO
         k1Iv6E6hdeRjLeuIccuUD7kQHQteKd79Vd04ygUhlyZwuTomUkDN8sQB5NLi0RknzQvy
         YFUw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3TQ7uDqOZ4Q6WX+Ox8t70a09gMNfSvPOGzALHCylZAmIQATRVoVxk8dWbe9mLx6HlDIIMtMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mzRiUGururgVI5bjXiAfHr/oDU55RO8brkclQ7zdx5b5RrUkx4
	KXcR1PkkubprYaKrf7VWWgdrjq6amujVvo64x8TdZoqbDkHq5vWMaiVGH6cvRd51ZLg=
X-Gm-Gg: AR+sD11vayB4tnLCOE4e1oeP1A5ysyCcOCS7EGuNOYkWCk8wzH1r9ooKZvgTT0V051O
	AxXQwuh/3mWyKmQRTg0l+GeU99Me8cGoJvQVYiK4kEi34vkP5/uoowsVFl1JSzS8go7mzEkhc1C
	qcn/MQDtyJrSeg1kH91RFCeANWi/4xY0D3Bu9rJeiS9b1cc7YhnK7ggDDFHIoFsgFEKLTidOCOZ
	bJPFOns0GyQB/mTW2O7b5Q9W9ZypDK0Zh63YNK1CnluVtTgmeu8cjw/QW1x+vEClrUW2B8pUG6F
	OVmUxBCIZ+R/qQEeyl3s83CfR0ah6yXIjhnQOQyaPhl6Ka8xA6ssDlxMQ6npOf7wt5YvTCCy2BP
	t64aOEKSBvnmK07huaN2vEZygkHj2GuNTH1Pb7A+0om0ssub8KRUOR88JEJQ6rP1WQUTiFALzfq
	a3bNVhr08zhEEl8gjG4RdBnnQEoWgBOwObJtWAc+2P2zf1sREbECnscQ==
X-Received: by 2002:a05:600c:45d4:b0:499:7219:122f with SMTP id 5b1f17b1804b1-49b91c1ebd7mr67005445e9.4.1787908972528;
        Fri, 28 Aug 2026 02:22:52 -0700 (PDT)
Received: from archbtw ([212.1.106.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b497fa9c5sm111484255e9.4.2026.08.28.02.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:22:52 -0700 (PDT)
From: Stepan Svatenko <ssvatenko@iit.org.ua>
To: Raju.Rangoju@amd.com,
	PrashanthKumar.K.R@amd.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Svatenko <ssvatenko@iit.org.ua>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] amd-xgbe: fix an_irq leak causing permanent -EBUSY on PHY (re)start
Date: Fri, 28 Aug 2026 12:20:23 +0300
Message-ID: <20260828092023.105405-3-ssvatenko@iit.org.ua>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828092023.105405-1-ssvatenko@iit.org.ua>
References: <20260828092023.105405-1-ssvatenko@iit.org.ua>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgbe_phy_start() requests the separate AN/PCS interrupt (an_irq) and,
on any failure past that point, is expected to free it again via the
err_irq/err_stop labels before returning an error. The last error path
skips that cleanup:

  pdata->phy_started = 1;
  xgbe_an_init(pdata);
  xgbe_an_enable_interrupts(pdata);
  return xgbe_phy_config_aneg(pdata);   <- returns directly on error

xgbe_phy_config_aneg() (via __xgbe_phy_config_aneg()) can genuinely
fail, e.g. when phy_impl.an_config() fails against a non-functional
SFP module. When it does, xgbe_phy_start() returns that error without
going through err_irq/err_stop, so:

 - an_irq is never freed with devm_free_irq(), and
 - pdata->phy_started is left set to 1, even though the caller
   (xgbe_start()) now treats this as a failed start and does not call
   phy_if->phy_stop() itself on that path.

Any later retry of xgbe_phy_start() (interface bring-up retried by
userspace, or the driver's own recovery logic) then calls
devm_request_irq() for the same still-registered an_irq and gets
-EBUSY every time, with no way to recover short of a reboot/power
cycle:

  genirq: Flags mismatch irq 63. 00200000 (enp8s0f3-pcs) vs. 00200000 (enp8s0f3-pcs)
  amd-xgbe 0000:08:00.3: error -EBUSY: request_irq(63) xgbe_an_isr [amd_xgbe] 0x0 enp8s0f3-pcs
  amd-xgbe 0000:08:00.3 enp8s0f3: phy irq request failed

Reproduced on a SolidRun Bedrock V3000 (AMD Ryzen Embedded V3C48) by
inserting a non-functional SFP module, then bringing the interface up.

Fix this by routing the xgbe_phy_config_aneg() failure through
xgbe_phy_stop(), which already contains the correct, symmetric
teardown (disables AN, frees an_irq if separate, cancels the bh work,
stops the PHY implementation) and is safe to call here because it is
gated on pdata->phy_started.

Fixes: 7c12aa08779c ("amd-xgbe: Move the PHY support into amd-xgbe")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Svatenko <ssvatenko@iit.org.ua>
Assisted-by: Claude Code:claude-sonnet-5 [Bash] [Read] [Edit]
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 12770af031eb..638c24b9c83c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1445,7 +1445,19 @@ static int xgbe_phy_start(struct xgbe_prv_data *pdata)
 	xgbe_an_init(pdata);
 	xgbe_an_enable_interrupts(pdata);
 
-	return xgbe_phy_config_aneg(pdata);
+	ret = xgbe_phy_config_aneg(pdata);
+	if (ret) {
+		/* Tear down what was just brought up above (including
+		 * freeing the an_irq) instead of returning with phy_started
+		 * left set and an_irq still registered - otherwise a retry
+		 * calls devm_request_irq() on an already-owned an_irq and
+		 * gets stuck in a permanent -EBUSY loop.
+		 */
+		xgbe_phy_stop(pdata);
+		return ret;
+	}
+
+	return 0;
 
 err_irq:
 	if (pdata->dev_irq != pdata->an_irq)
-- 
2.55.0

