Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B7382284
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844571; cv=none; b=Vp6Lt1bK9X3GagWmwbMjfTl/hUTCaxiCjUFh81t4mOrDh+6jqRJgc9thFG2RozAEL/Wk4px2067DCQYS+60Jb0f0pLyzk2LVtOwZv1mgpbgrQEfjL+UDVd4hLaQEGIsoZn7X1iiJwRhKkpuWN7Kq4Hwl7UaLDVNeW8uAckUlk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844571; c=relaxed/simple;
	bh=f2uFUXzOh9ed2PB9UIZrruaq47ewE/vvHcYpSlqLKnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzKpridZ1NzrXwdiV3r9GK7lZ0UtpwsGN4RjmdgRo8a+NTMInamBVco/YshJoUbNwaX1ZtUbA1XRSX6nPnXW8KRYd7Ls8d9FJ6KuAbU/vDxHngkSIUMvHMgW1kmnrVZFNI/nFLvFWEIOqP8MtPBNgxfw+pz/qzTIJd5I+qo+h+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ6kE6FS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ6kE6FS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so4530840f8f.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844568; x=1786449368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYG4UXLGxO7ttgBOjFjsHN6l7EWjIoeHBMt3IH2Ql0w=;
        b=eQ6kE6FS5C1FLTE3b0HcVxtGNGIQqeYddMidMRyegJk+PAsJ/mlsF+zSeVQXpM/QfP
         p9DGvX/p66Hj/EPbTz3x8YAUNo05bfRGyOaUPit7DCFr91pUAuwXxRIgn8wm6CIv5swS
         t4h5e5tneAkb644hRTzcfUknp4ti7UAZQCy/lSr8RoMKgt2hLLhp4ou1fxwFuTqcW8Z/
         ZMtFeZjVFMA5MjOkAHNcWL7sqXzcL3OsRaYI1KkZEboGJd9gA/aDUTpKnBdGdioccSyb
         Q2GN+5xtUXluWmt9y4K8Ua2UnzbAC0JjwSDIUN1uQRg5wyl1Ci+3twuxzAaQanPuky2U
         u+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844568; x=1786449368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hYG4UXLGxO7ttgBOjFjsHN6l7EWjIoeHBMt3IH2Ql0w=;
        b=C1huE8xa7T5vul2rLtr2kUiwR/OY/KYebTsu+rJtIU0xOjSV5d0zHcubqptf4hdn7M
         84FKqJNWsZIgDfLkHgxxxeRGXiuLZXeY96RyGYgn72SKYSZIuf2BujZ9K0LEog8t2P6G
         yjnxN0eramBOgPFDb2qjYJWNHGpCt8JTE3BBFX4kf/hse0uY+hPQpNGLM7C2tymw0FV3
         D/kfmCnZAQdfCHKttgHpB2WTLwpjGSKDIwZzlJXw8880YZLhvqPh6lIog8liylGmPK1l
         Y9Z3BV/vR+y69b+N+brDK9HP6PyAAS9lxf3LB+gIdxgFE5YK5fIRyAdiibria4BTFjz6
         O4FA==
X-Forwarded-Encrypted: i=1; AHgh+RrLEUVxrqXF2jn5abHlooRu8jFpkG6VjOjLIblsDUC50E+ahfjvUClz9Zo99W8m91rwrdsO41M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WQxBw5idVnPZWI6Fg1g0abJdvoyKb6IQ+kM3599enhG7TSy/
	BZuKb16EQVOjIVxZacXrhAeINz8pc5nQwY+1AbMeVgN0ux2Eaar04WkM
X-Gm-Gg: AR+sD13/bXZGPstr0ojaDbCQRxCGjbQsRIdTmFUeQ1yTGLqtGh+UPcEdj4uM+E/nkTS
	T68n/3IwEGgW4QYC9qlw9413AWY1HlKUv6KcivwfPozjT2emiqkngo7DptJxXfC1dw3RUZTmpQw
	WIUd6swK8Jzy0cQVVaZwddvzfTD9nSIhdLm7Cs+hF9v7ReQt2FzIEKcv/xSeSth1z1K7w35cEnu
	Qp+wJD2YidCSTzb3U8SYB1IRJxFUP71/0vlLwxoXiieHOgdnSrVj+i/lgZIFoPJvoeh9JYjLk+E
	d1OSQ6Ctvcji2OnmIzlmIwe/8gARqzzycy9Uk1G9nu06iig4j8uwXBwnZu2p/mebUQTc5/Zc3Ye
	WfwH+ZcZWB/rC+cZ7WIyWekw2uyzuAS1H0pcz/DFe27E076crhTT06zfctyFhOhOj3aaCBlkwS+
	JgwLX60QYA1l5OK7KPhLv/kv36vmdyXAiSntAlqxLcP7J9xxx9SOOGgBqVvB0CUbljw8XnH/Z0Q
	4b2VDwEqTeZVDjuRWR4xJpN10eYoqX6Xx8XK1Y=
X-Received: by 2002:a05:6000:491d:b0:47f:93fc:2d27 with SMTP id ffacd0b85a97d-47fd72f08f6mr36644389f8f.30.1785844567776;
        Tue, 04 Aug 2026 04:56:07 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs192228.centertel.pl. [46.134.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1abfsm42083414f8f.37.2026.08.04.04.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:56:07 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Jie Luo <jie.luo@oss.qualcomm.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Brian Masney <bmasney@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Tue,  4 Aug 2026 13:53:59 +0200
Message-ID: <20260804115359.16633-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730191353.557494-1-kuncy7@gmail.com>
References: <20260730191353.557494-1-kuncy7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe function takes a runtime PM reference to enable the GCC AHB &
SYS clocks of the CMN PLL block, registers the clocks, and then drops
the reference, letting pm_clk gate both clocks a few milliseconds after
probe has returned. The clock ops access the CMN PLL registers without
a runtime PM reference of their own, and on IPQ5018 gating the CMN
block bus clocks makes the SoC hang on a subsequent bus access: boards
died silently within milliseconds of the CMN PLL probe, up to a 100%
reproducible boot loop, depending on binary layout (micro-timing).

Take a devres-managed runtime PM reference in probe, so the bus clocks
stay enabled for as long as the driver is bound and the reference is
released again on unbind.

Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
Changes in v2:
- Use devm_pm_runtime_get_noresume() instead of simply skipping the
  pm_runtime_put() on the probe success path. The v1 arrangement left
  the usage count elevated with nothing to balance it on unbind; the
  devres action releases it. Spotted by the Sashiko automated review
  (thanks to Mieczyslaw Nalewaj for pointing it out). Note that
  pm_runtime_reinit() on unbind does set the status back to suspended,
  so the leak did not have the re-bind consequences the report
  suggested - but it was a leak nonetheless, and the devres form is
  the idiomatic way to express "keep this device resumed while bound".
- The diff is now purely additive; the existing error handling in
  probe is left untouched.

Note for stable: devm_pm_runtime_get_noresume() was added in v6.16 by
commit 73db799bf5ef ("PM: runtime: Add new devm functions"), while this
driver dates back to v6.14. On 6.14.y/6.15.y (both EOL) the equivalent
is to move the pm_runtime_put() out of probe and add one to
ipq_cmn_pll_clk_remove() instead.

v1: https://lore.kernel.org/linux-clk/20260730191353.557494-1-kuncy7@gmail.com/

 drivers/clk/qcom/ipq-cmn-pll.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/clk/qcom/ipq-cmn-pll.c
+++ b/drivers/clk/qcom/ipq-cmn-pll.c
@@ -437,6 +437,17 @@ static int ipq_cmn_pll_clk_probe(struct
 	if (ret)
 		return ret;

+	/*
+	 * The clock ops access the CMN PLL registers without taking a
+	 * runtime PM reference of their own, and on IPQ5018 gating the CMN
+	 * block AHB & SYS clocks after probe hangs the SoC on a subsequent
+	 * bus access. Hold a reference for as long as the driver is bound
+	 * so that the bus clocks stay enabled.
+	 */
+	ret = devm_pm_runtime_get_noresume(dev);
+	if (ret)
+		return ret;
+
 	/* Register CMN PLL clock and fixed rate output clocks. */
 	ret = ipq_cmn_pll_register_clks(pdev);
 	pm_runtime_put(dev);
