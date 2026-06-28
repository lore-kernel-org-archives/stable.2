Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7337106D;
	Sun, 28 Jun 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782651277; cv=none; b=XXZP65Eu+Ioxz9uU4EXXJlhL8k62W8I0lisilEU3cPaBex92DPMH9y5EN22ltvPfZnNnrZDgnYhAnDBKUjf1m/adsVSd2iAttQOrUKQXxTxjG0i7nZkUxfyZG9MmVdOjjrzn24XzGhMzgA2/dzv0IeXJm9NNhxUnZAJ59Jpn+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782651277; c=relaxed/simple;
	bh=jjYq3FzpwqS/cc9I5YLN/y+qNA8iRuup+f4ZOBC3thw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E89rYYwR2Qf4j5kZroOc86tZjGOVgZBQ4L34SkiDvhW3G46y2YPA5sfRjWRG079e65Xh0KI8IvOAcwh43Hhq73wLcDxisoBmUUEV7MXZHNnGcneskP34cZhpQXjbHAG8Sp9utP6sc5oKdAtDfzC2QJlmuQs3Kfvb1MkQn4IYtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowABn8QR_GUFqTy_FFQ--.33510S2;
	Sun, 28 Jun 2026 20:54:25 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: krzk@kernel.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: alim.akhtar@samsung.com,
	bmasney@redhat.com,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] clk/samsung: fix parent clock refcount leak in exynos_clkout_probe
Date: Sun, 28 Jun 2026 20:54:22 +0800
Message-Id: <20260628125422.45267-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn8QR_GUFqTy_FFQ--.33510S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GrWxAFy3JrWkGrW3AF15twb_yoW8JrWfpF
	W7KwsIyF45Jr4jyF4Dta1UZF4S9a1Yva4jgry3C3WFqFn8JFy7Aay0ga4qv3WDJ3ykGrWS
	qr12kF48GFyjva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2pAixHs6wAAs9

of_clk_get_by_name() acquires clock references stored in the local
parents[] array. All error paths correctly release these via the clks_put
label, but the success path returns 0 without releasing the parent
references. The references were only needed to obtain clock names for
registration and are permanently leaked after probe completes.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 9484f2cb8332 ("clk: samsung: exynos-clkout: convert to module driver")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/clk/samsung/clk-exynos-clkout.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 5b21025338bd..71724b56de69 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -190,6 +190,10 @@ static int exynos_clkout_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_unreg;
 
+	for (i = 0; i < parent_count; ++i)
+		if (!IS_ERR(parents[i]))
+			clk_put(parents[i]);
+
 	return 0;
 
 err_clk_unreg:
-- 
2.39.5 (Apple Git-154)

