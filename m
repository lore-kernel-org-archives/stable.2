Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B525228D
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438841; cv=none; b=nuBzCe0FPqsh+GVzPxKXj8DArKFUU82A6bNbz184rah+f+hs2Ao8OKb9mYQycrc7Oj4+pjC/7dJZfuY5C9vgjP5ra+a85uDswm1i1iAV4KO3RsLbbQEe0RXyQSUSI4w4UDxT1C2BTdHpMP7+x7oHJG7hYvgd7JrZalIbiWUNapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438841; c=relaxed/simple;
	bh=Topwf+V3jfuUiuzqOBdaGECWQDvVXswPedPSAJACfQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKTDdOeEbrKnRoqJhHvuSpm0pMWmQelrM+s9aN6iNTs0hwp4H3jKVBOQ8ajUKlekwbcvnMIRwjZTfQshD+iWLErHSE1YkwomjjcTN+8cWVzrNPUGFjsNfMNP/+qliCVVg36oo8GFRh5GAxS4dnnHgadw7sjKU0D2t/c98RTxhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr2ny54t; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr2ny54t"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so597515e9.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785438837; x=1786043637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RD3lmsuBeFnVrxhklpYzLfUZAUon1UxgAvihRoA5NDM=;
        b=mr2ny54tuo212MTH/DQS6J6QiCZLVFtAdpF2X6zZ2VBd91l0ooyVJiFXoOY4ptYY8H
         wvdGye81wyLx1Iuxa5q98YbSSo4I1tThXaER564wh9ZSNOZUijD57OqP+cRHVkxB0alq
         Xts18V0K6C8B+3OtGYvNkQpEzyOnpRaiuofhAf19MllXKSyQkJi1Bt/b5auSULJ4xMzF
         ACRqORVPhprh1HvL2Rc3Sk1OLI+RjfaY2XL/GiDXWrFte3xNKo/FKKvkw3Z0W0Du7Tei
         iFyzYHjE4FtiOVeumdnxNxB16921UK8RlYselZZBnSnydBX3IVFD4ECNJ6Kfu+vm0rzh
         Ukig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438837; x=1786043637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RD3lmsuBeFnVrxhklpYzLfUZAUon1UxgAvihRoA5NDM=;
        b=cWVFydK4C9xZJLmvdVsqFLuLtfw+GYRVs7W3pjet5LaUHoqQI0QrB92kp05HulZg2C
         lmGXHpxHM/qoajnm2d2d85AQhe444FdxR2aVbNdW/pEnQ7lS/dS7eM9h12ekp6uHt6Cm
         uMIbt3Fa9lsgSOVFyNpxmdnVmFGi/8PW+6TtFtjUFxBYhQJxcGvx93YOmQw2HwOvMdrZ
         LqOZXUKlCWJYS/LQ98SK1NkW/ogYy9iyfyE83BV1oWsZ3sDcDC6gXQhacc68NnrSJdHh
         mKAgT68xDG3k7HX+2zaWOEhWW/Xg+3KLLhQwb9fQoGp5APx/pM/eUX6CY8ZcDl3vd92B
         0FZA==
X-Forwarded-Encrypted: i=1; AHgh+RqAtj7Odhjh0iN7d8+lHtONf/bE0vTKrH8BrLrzAOdWSKe30yD+uWK4aT1bCy/4OAN3DvE/FHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPai5Cr7QLznfVXXLxY1LE5U7WsAxSu/vIyEGyYSKMOLiGP/DB
	JvuuFGrv7ZnLH4cImm3T3B+CfWy/EFQIG3ejQDtfDc5SpK72hktO4DU6bFhAJJIY
X-Gm-Gg: AR+sD11pRO0X0hcGtV+CNoKQfbAwUVJGQsagaaZDrNKM8Kve1ptc1BS7P3rw/VmYr1g
	CsAB8yfutgf51yhGD6snbKJ1f5/LIRxGhNeph4Wdzf7cU6YHcj3YskB9IoN2l8FUqKbQ996rBI0
	E12tEF8Zfcxif2oFfYVk6SYu/cKruTgdE8a3zsTBkkZhCN6XcQVmmw9LUmwMGanXq5hpXpALdTN
	29SGAFpJ+IqyeKsUqGgj0AUu9iMhRasGzUMPlNHdWCBDhlQdao2hCn2ForcMLPbmrAX/UiKlPdU
	gfTZ/qX6w+8UxdoZSqLGcRKWmhpmf4RFkYWwXJDomOG3f0TCVD14cQgB1wtaxge1qSbL2A+9yOe
	rCa6CxY4mZVtPYR3b4QD5p4cCGjtzXZTi5p3KM8ir3yfANNHJGJgMsLYGyJ5KnJ2a5mf+2dnhs5
	1ECYxXN1X+yQ/xf7l+77PQJhD4PXKIoEauv+BCZ+s2rhAHFYppvKZjcbljUfvTNJLPD82AUCj7D
	Z3CgCFJYu28xk/f+bRW+rI2E7K44FkLOsLAAhRdCVVNj4SWCoI=
X-Received: by 2002:a05:600c:41c1:b0:495:5b02:23b0 with SMTP id 5b1f17b1804b1-49800eabb56mr33840125e9.26.1785438836682;
        Thu, 30 Jul 2026 12:13:56 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs192625.centertel.pl. [46.134.91.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011e5febsm76121635e9.3.2026.07.30.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:13:56 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Luo Jie <jie.luo@oss.qualcomm.com>,
	Brian Masney <bmasney@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Thu, 30 Jul 2026 21:13:53 +0200
Message-ID: <20260730191353.557494-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe function takes a runtime PM reference to enable the GCC AHB &
SYS clocks of the CMN PLL block, registers the clocks, and then drops
the reference. Once the autosuspend kicks in, pm_clk gates both clocks
a few milliseconds after probe has returned.

That is wrong on two counts:

  - The clock ops access the CMN PLL registers without taking a runtime
    PM reference of their own, so any later clk_set_rate() or rate
    recalculation touches the register file with its bus clock gated.

  - On IPQ5018 the consequences are not contained to this device:
    gating the CMN block bus clocks makes the SoC hang on a subsequent
    bus access. Measured on a TP-Link Archer AX55 v1 (IPQ5018), the
    machine dies silently within a few milliseconds of the CMN PLL
    probe returning - mid-character on the UART - and the victim is
    whichever device happens to probe next. Whether a given boot
    survives the window is a micro-timing lottery: different binary
    layouts of the same kernel ranged from occasional failures to a
    100% reproducible boot loop.

Keep the runtime PM usage count elevated on the probe success path, so
the bus clocks stay enabled. With this one change the same board went
from boot-looping to surviving every boot attempt (verified across
three previously-failing kernel binaries, plus repeated soft and hard
resets on the final one).

Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
One more observation from the same debugging session, for the people
who know this silicon: on IPQ5018 the CMN_PLL_LOCKED bit (offset 0x64,
bit 8) never asserts. Every clk_cmn_pll_set_rate() call runs its
regmap_read_poll_timeout() to the full 100 ms timeout - including under
the bootloader-programmed configuration the hardware demonstrably runs
fine with - and nobody notices, because clk_change_rate() ignores the
.set_rate return value, so the -ETIMEDOUT is swallowed silently. Is the
lock status readable at a different offset on this SoC, or is the bit
simply not functional there? Happy to send a follow-up (surfacing the
error, or skipping the poll where it cannot work) once someone can say
what the intended behavior is.

 drivers/clk/qcom/ipq-cmn-pll.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/clk/qcom/ipq-cmn-pll.c
+++ b/drivers/clk/qcom/ipq-cmn-pll.c
@@ -454,11 +454,19 @@
 
 	/* Register CMN PLL clock and fixed rate output clocks. */
 	ret = ipq_cmn_pll_register_clks(pdev);
-	pm_runtime_put(dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put(dev);
 		return dev_err_probe(dev, ret,
 				     "Failed to register CMN PLL clocks\n");
+	}
 
+	/*
+	 * Keep the runtime PM usage count elevated on the success path, so
+	 * the CMN block AHB & SYS clocks stay enabled: the clock ops access
+	 * the CMN PLL registers without taking a runtime PM reference, and
+	 * on IPQ5018 gating these clocks after probe hangs the SoC on a
+	 * subsequent bus access.
+	 */
 	return 0;
 }
 

