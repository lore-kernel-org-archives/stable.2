Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121485;
	b=FMaYo8OJO3bTvsGDg2ZR6n5q1mk7sXuZNXeb6E7cZAope4VKM+GVZx9ut6qZDvnv5mfL
	 F0cujysJIcsTxbfFJ2OHtl5+cEvczerAaNj8MHaSIIrv6JC1NxT9M+XNPfVS9NwHorG40
	 KET5BGqPJ6iIWJgoUP4t4HtY/3n07Xy6K6xvZ5+8DcBdnmOULuxoE2APt6Mf4Yq26dTTs
	 w7nLPdsi0283u+fKuOxEOh/LcWmLIfd3TDWYWhCUYQhiQUlt5Tef3AtxLJmm28lr9R3pH
	 Kba28ZiPJT8W79MR6cNTuqIk29OkGVQxpDXOVXw4oYbisAoKYzJUdZ9qvDk5ZQV3M0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oHWOW8G+UnriW2sSLKOhokujUtbgw6vOEtLbwr2KX6U=;
	b=TKXnvLACegQ5/kVwyuEFbgySW8o5v9qVG5xvnrYi0iTvFR1i303JJyauJef9x6c1yKJR
	 W8pSnphkG8xyKelWIxQG9jxZa+TrOfOpuy8It/ujjGd2Z97lGzH9ZGzZbpv57G5SjVwKL
	 Thth2s6B6PAHkEhIrCx+gWtGFOEbOoFElW65wCZo54wbN5kRoDWW7iCnag5L0+OKHsbaG
	 eIqVtpts78T+vggBJ2nNdLhikgZ5CCefk01GkhQT8AttTlYZ4TjTrIAuZQzCZYiv8/yqv
	 q8CN/iz9i0BNa0JmqHMfittXPnliFdAA2K+fDi1LcSxdiv99zW/ybAyKzNbjIf8rVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Px5mt2wx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CF606A337;
	Thu, 19 Nov 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Px5mt2wx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D351F000C6;
	Thu, 19 Nov 2026 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121484;
	bh=oHWOW8G+UnriW2sSLKOhokujUtbgw6vOEtLbwr2KX6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Px5mt2wxp4xZ7KV/d+wOY1G00esTciZYkTZb8M3Ptis/EWn2XPzbuQ/pz6Pjpkz46
	 WRu6qHDSZSWo44wFi9Y6bZyv1tilP1kvvuhHfqbTWlWPcFwEefFOsJk1D8UXstVVug
	 k5eSbFPGsGbLKlplO0JF67JT5bQv1Qu5IdnFg93me3bvTdyKauw4GS2YdfCazIBN1q
	 P/rx4P07qSs3e0v0LDKxOlHw7i9bnL0XAjvuydunUbDynb81L8OBAkO0QosS0+gxtZ
	 nRYJmucc6Sd+A1pzxowvzsY6LK8AuuaEvW7uf6Ctazdfp9b2HxvTh3s+S2+4IeNacm
	 K2TzZ6vr4jO2w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 09/12] pinctrl: single: Reject invalid register width in pcs_probe()
Date: Thu, 19 Nov 2026 20:49:05 +0000
Message-ID: <20261119205013.2563811-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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

If the "pinctrl-single,register-width" property specifies an unsupported
width (anything other than 8, 16, or 32), pcs_probe() hits the default
branch in the switch statement and continues without initialising
pcs->read or pcs->write, leading to a divide-by-zero in
pcs_allocate_pin_table() or a NULL function pointer dereference when
accessing registers.

Validate pcs->width immediately after reading the property and return
-EINVAL from the default branch in pcs_probe().

Fixes: 8b8b091bf07f ("pinctrl: Add one-register-per-pin type device tree based pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-a0303b6e-d0c6-4292-aeeb-fa8a21861827
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/pinctrl/pinctrl-single.c | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index d72ebb186b89..1779ffbc1181 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1832,6 +1832,23 @@ static int pcs_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	switch (pcs->width) {
+	case 8:
+		pcs->read = pcs_readb;
+		pcs->write = pcs_writeb;
+		break;
+	case 16:
+		pcs->read = pcs_readw;
+		pcs->write = pcs_writew;
+		break;
+	case 32:
+		pcs->read = pcs_readl;
+		pcs->write = pcs_writel;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(np, "pinctrl-single,function-mask",
 				   &pcs->fmask);
 	if (!ret) {
@@ -1881,23 +1898,6 @@ static int pcs_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcs);
 
-	switch (pcs->width) {
-	case 8:
-		pcs->read = pcs_readb;
-		pcs->write = pcs_writeb;
-		break;
-	case 16:
-		pcs->read = pcs_readw;
-		pcs->write = pcs_writew;
-		break;
-	case 32:
-		pcs->read = pcs_readl;
-		pcs->write = pcs_writel;
-		break;
-	default:
-		break;
-	}
-
 	pcs->desc.name = DRIVER_NAME;
 	pcs->desc.pctlops = &pcs_pinctrl_ops;
 	pcs->desc.pmxops = &pcs_pinmux_ops;
-- 
2.56.1.750.gf70dc682cf-goog

