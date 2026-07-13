Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD92416D0E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947957; cv=none; b=DBGDz6f+iog7v2ETDy0haOQqpN/iLC9awzHRDHDvcM6h8t5+I05NP7ZUv7cCIjON+j2lRoAwzijHSsC+3cilcFppWYIJolhDoe97UxXqCPY2kUM65GPYW3UMsQUA7PCQ11YPqCUNp3tRgn3o/UnZ8OKR8UqMEKrELKlB8ZTwCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947957; c=relaxed/simple;
	bh=0qC7ujzOLaFd2s8Fn3l9j7PEA6FfGcqP1hFRcFudcsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eawd7pq9zLLIBwilEUUuNZZjlUSEI1seMzQX45cmgYfeiPKQzaIF5krkLWrisIM2cmr4WZ5z3706+9LfzSZ0DNOIA0mBK5DjRoWxSrMm5AgvzQ1u9Iew/hlcu9ox4U4ncbExUfd1VkyOAJC7/qIgLhgCbJDaAKKHq2flApHZvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Kp4a/QEE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Kp4a/QEE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1697015f8f.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1783947955; x=1784552755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUK3J4PNfu7w2oijinZPF7ASv5k/jbRTm1vrjO45FNA=;
        b=Kp4a/QEE/0Vj1m4cGNCoU7kx4M9m/EvIFXfxe5irchXAjfiYGkRORwGdyCY7x6ejqT
         NXod4il9KcFFI5qr7mChDIgFlkmStRo0kyDCJD4ocJeYDeEmIO4pOaeIXfHmHP/4rkE7
         T5b/fzlefqcQdMbjyap5IaIlD1oCRdDPZnVbKtEKbPpgMm16E0qdyjLpZ5smAn61dnJP
         fUI8/fryW6JdRSOOUam0VifbFOi8XjbqprWS+eFX2Lp3PDtvES0T4POP9S0JIyD+KdEG
         VDYQeEhuG0BRRZjINC6N+Ga+IodixpN+geDhIwaP5BsQx4MIcWRPyyUXI2Of+NXQYHnu
         Um3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947955; x=1784552755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sUK3J4PNfu7w2oijinZPF7ASv5k/jbRTm1vrjO45FNA=;
        b=Bmf5fYLj7vcM5KWw534oSuRBJMpFXGU8BeSti1/8i3tRMncYQ714Dou1KCEDWZx0rV
         c7j3Oo6QVRlX3RaHn6ZJ11jReIh2v1rOqKslAFO+daxrXxIJfXLoF/ob+NGpv1U5ZWaS
         1YXDXm9BWWWuKOLgPQxhuIKLCqBPUPHaq5SmTJvF7+ocRjtQoaDw/bXXz9Jcky5pfMFW
         oQC7PT95xZG/mmi+Zjm6g6uKWA8bf/tTkqa2yyajc3GBuFrX1UQapfJKoEjCWcKOtask
         tXOcz6xMehCxLGPKJpcIEXzS63evlJhKAnrKo+dCruhPueSJyC51fT2GRNPUkRjU8xkh
         khIw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4RqtqDbjUdDlWSQ4KCMQRv6vWy/iWbfXRplmAAPSnxe8lAUOFRbXOtihhKFxxtJuZ1dptvhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOXXPEc4Fja1phTvMmUkrPJYuJnSvn24d0m+uE4/x0m86EXcT
	cLlgUoHyPpt/zfQxwu46spTxEoy1kJxW7Hb3A9mR1FGgIXKT11Z4zG0hugZAzhCwsMI=
X-Gm-Gg: AfdE7clI9COHRDZznpjyhz/gscR1DmCiXqXiH8wVA/1+h4kDXwnlJ6Bt8cgYFD8gRBL
	plEqBbneaQwp+FR4BmVr7kDDR9Y8OldRBdCPuOswCVLaMUWPzKZaZJZuBRYQW/ELMp7a3Fny+br
	uN6pK/A+RIZPxEx75dG8JxRzRrUM8qiHLoC7Hkv9x+UlpQY1S/dBYkhrTBYrMR+7mkuEnEwoPGg
	6UAfMm8XOUyPVn2A1k6iulTTPX7x3pm8Iapm/6+C/uWV4bVdnPtIeFB66omGLOknssTUctgzCb5
	AqtS6E97QVjc/MerEVyeIvp/5o1DNvj4O8VqrQi42eIp0R1VYgAddVZwUIkrtSeLpSX87qj4/G3
	VdHaJG3QfgFO/f2+a2PPWjKfGeApeEL+LE8Jcjv7Pl/b3C+u4LUhR1NzxC7BCoh3KNWi0+mGLao
	DtuAVRGDOj8kgRELgbqY/e7K6K4MVA1qWLlZYxSeTZhkgltoosaYFn6o/lwtnuQ/ViSgTxIFU=
X-Received: by 2002:a05:6000:420a:b0:47f:285c:9769 with SMTP id ffacd0b85a97d-47f2dc8d86bmr11100953f8f.10.1783947954635;
        Mon, 13 Jul 2026 06:05:54 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6402:500:e91e:fe5e:857b:d0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm25321609f8f.3.2026.07.13.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:05:54 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 03/17] i3c: renesas: Follow the reset deassert order used in probe
Date: Mon, 13 Jul 2026 16:05:31 +0300
Message-ID: <20260713130545.568657-4-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use the same reset deassert order in the resume and probe paths to avoid
potential failures due to ordering differences.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index cd9928649c7f..ccf55afcdedc 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1455,17 +1455,17 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 	struct renesas_i3c *i3c = dev_get_drvdata(dev);
 	int i, ret;
 
-	ret = reset_control_deassert(i3c->presetn);
+	ret = reset_control_deassert(i3c->tresetn);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(i3c->tresetn);
+	ret = reset_control_deassert(i3c->presetn);
 	if (ret)
-		goto err_presetn;
+		goto err_tresetn;
 
 	ret = clk_bulk_enable(i3c->num_clks, i3c->clks);
 	if (ret)
-		goto err_tresetn;
+		goto err_presetn;
 
 	/* Re-store I3C registers value. */
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
@@ -1486,10 +1486,10 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 
 	return 0;
 
-err_tresetn:
-	reset_control_assert(i3c->tresetn);
 err_presetn:
 	reset_control_assert(i3c->presetn);
+err_tresetn:
+	reset_control_assert(i3c->tresetn);
 	return ret;
 }
 
-- 
2.43.0

