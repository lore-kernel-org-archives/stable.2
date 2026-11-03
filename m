Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687764;
	b=sbsH35MAD80PqwbBV0h+E/6P2RrSiWMJvlADyILtHTeJUrwbWgEHS+53J76uLxNrRa9v
	 cZe5uXLjsBS31W2iswo9oKFAaYW2X+RUqFmXtIci6KEmqtbURJLYOWxUZEr7gGHP/B+/N
	 tGMHoC8O7QtgLL3zsMOIX3RyibryN+uqAEnuINXUQv4ymHCqUdUJHGOcMbGIeVYuSZnOd
	 e3GKQEnJwaBUSkx84ZNM3EZgG7cGa1yKZDf9Mn3J0ql715PfCGvPPWdHrwc9W6ztjO2jN
	 7c09MxA3lAOkmdKzoP+G4+G/8+zZHeWxAagO9bLPVd6OEETfsU9UZLZMCzcuJzUoXuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687764;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=0bnxT/GaODOLw9buJdXMz007PkKtmbGsQ3QJymSQxXg=;
	b=Fz4ennLExkHX5fWp7rYaBj5BdXInkLjRB14FTLl+cQKp4/AFqznCPRAoMlwTAE3sHmO8
	 uFGjbvvR3EGpeRaiwv7rDEwSO+GJBYmvjiThXESSBYxZ7PGXltx/0rt9N8G74AAgA0veW
	 sleiwf9+Prt9doMJvfU/Sde6WUlDyDKRhHjD8mVYqj1prtRqGXu4GJHzA/sMESUzvrwHr
	 81iLNoap4j5fMywBkivqJgKadC980viEJhGUI+IADeFTWeYA7wkPhu3nzNh/OT39Fwbfv
	 7JgxxDQmztDCRB4qnc4npBLVfiFrvxU/YC5otHvjcOTD2p1TtlcVYKE2+cNPCZPh4iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA803606A324;
	Tue,  3 Nov 2026 06:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA803606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3xZbQgOlqnWs5AA--.93S2;
	Tue, 03 Nov 2026 14:36:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: mediatek: Release DVFS resources when removing the driver
Date: Tue,  3 Nov 2026 06:36:09 +0000
Message-Id: <20261103063609.1028187-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAC3xZbQgOlqnWs5AA--.93S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWxtFy5AF17Xr43CF15urg_yoW8AF13pF
	s8XrWYkrWrJFsrKa1xCw4UCasYy3Z7u3yYgr13Gw1Fqw13JF15Xa4UWayUArZ0krWkGr4q
	yr1jga47uFWkAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiL05
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIAA2rpWtl8QwAAs5

mtk_cpufreq_probe() registers the cpufreq driver and retains clocks,
regulators, OPP tables and OPP notifiers in dvfs_info_list. There is no
platform remove callback to undo this on device unbind or module unload.
The devm-allocated DVFS information is freed while the list and cpufreq
driver still refer to it, in addition to leaking the retained resources.

Unregister the cpufreq driver before releasing the DVFS resources and
removing their entries from the list, as in the probe failure path.

Fixes: 89b56047f6f9 ("cpufreq: mt8173: Move resources allocation into ->probe()")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/cpufreq/mediatek-cpufreq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index f9b1eca176eb..5776310d96c0 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -677,11 +677,24 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void mtk_cpufreq_remove(struct platform_device *pdev)
+{
+	struct mtk_cpu_dvfs_info *info, *tmp;
+
+	cpufreq_unregister_driver(&mtk_cpufreq_driver);
+
+	list_for_each_entry_safe(info, tmp, &dvfs_info_list, list_head) {
+		mtk_cpu_dvfs_info_release(info);
+		list_del(&info->list_head);
+	}
+}
+
 static struct platform_driver mtk_cpufreq_platdrv = {
 	.driver = {
 		.name	= "mtk-cpufreq",
 	},
 	.probe		= mtk_cpufreq_probe,
+	.remove		= mtk_cpufreq_remove,
 };
 
 static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
-- 
2.34.1

