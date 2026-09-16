Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F032447805;
	Wed, 16 Sep 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543421; cv=none; b=LSD7BDe7jEjT5pKh8U6TgZiXcRfOjVZWbdMwtE+jIh4OoBrfmc9Dn5YsRth76UkyUNova4lSmt5bhz+K3WAZ2pY2gaWs/8W/RI8ehdBY/9ikjvX3t5D4f82LEgLVYPk4wwB7GiUVMHlq1+mdlLTxnAj01DueWaq3/NsHuIYX8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543421; c=relaxed/simple;
	bh=CYU1jUqcD8f8ydXOmi/N32Vz1fMulUC8n8CJvnF356Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BH6z516nv2+bcIZmbS+N4xU+JNowVVjNSQsunpPtlk2sE3hmSuFLEq8zghh+V4ATtwPKk4ka+BDBkCO2VM+YKgmkux48E97RFXd5PK7KYS+JPVhptdg9kzJrlD+2ufYIql8TgrrMPltXR1NHpeaR+MEP1H1QCvbL1VCeUIXEFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wD7jQ6pqYhTfBw--.23878S2;
	Wed, 16 Sep 2026 15:23:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: david@lechnology.com
Cc: jm@ti.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wbg@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] counter: ti-eqep: Fix runtime PM imbalance in ti_eqep_probe()
Date: Wed, 16 Sep 2026 07:22:47 +0000
Message-Id: <20260916072247.1967830-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wD7jQ6pqYhTfBw--.23878S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF1fAw1DXrWDXF18Zr1fZwb_yoW8Jr45pF
	4vvF98tFyxXrWIkasrAw1kZF9Y9rW2yay8G34kWa48Zw15Ja4Yk3WUJFyaqF10vrZ5uw15
	tw1DWFy7AF4Yyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUrF
	ApUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQMA2qqQJUOSgAAsd

In ti_eqep_probe(), runtime PM is enabled and acquired via
pm_runtime_get_sync(dev). However, if devm_clk_get_enabled() fails,
the function returns directly without calling pm_runtime_put_sync()
and pm_runtime_disable(), leaving the runtime PM usage count and
enable state unbalanced.

Add the missing pm_runtime_put_sync() and pm_runtime_disable() calls
on the clock error path.

Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/counter/ti-eqep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d21c157e531a..84fbf500b0f8 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -548,8 +548,11 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+	}
 
 	err = counter_add(counter);
 	if (err < 0) {
-- 
2.34.1

