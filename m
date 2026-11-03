Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687319;
	b=KFNszpOyfc6CqMEhYYXMiT9SJGbPMwwB8uHBqtK8xfGaj1zacNrnZGb08i+PPlxBmd/x
	 gzTCJdZ7+I7kbf/K8l1Vni92TS3ieL5XJ95XQR/yn32nNQLyqUou8idgcL0/SpsK2taTl
	 MipSYpLPxIhAJ9qXjPqcBYa960H5eIpn4jHOiKb5X6G53qzXM8Ji7H+ODd1N/kD1ve3BP
	 qYJyAan75o81lQw8gYrRBYHO3MYuHRixb3rc/RyX0jAIQR5pn3Zw3jc+kuGXoS7ugTnQj
	 psvonPt5YodpXpkJDhOgi/lSUkM9Ak55brqXr4kQLih5XcJ0tOw8KDsoCks9dqXIhMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687319;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=NGgi7FuzRvoo9lEIu1iCHQcCtHKx/g+aK20hu2ScPxo=;
	b=Z7Ys1rRDc+S2KfMhlTOmPEEY9TsDGdIBnNCzYR/ejUVPt2bvYAoq09TAUjdmZC+QcI/H
	 yeDVrnC7zDdl3KfgDV3LEyhdEMpJBoP/XRwnGd++7NlUCXf/wqpZpiNFHaV06UBexNvBu
	 IqZwWgBIUqX1JnldbsTsoUIxdeej4+ogBeFzeCoqudF/LofV7kSWMmHONDYgZH/vEUjhq
	 Q+lDW/YZtAMcK59Js8BCP0X6IbtX44ysfY6hzjiGWkf9nKU7+EMA+xPdU7g/LwBuRDgC5
	 CyWMO+W8JqoWJPRnGRuLG4p2WqPk2TkSwDeFLbFHD6BaaGaYMpr6jvAr2rSC9s7Q3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F9606A324;
	Tue,  3 Nov 2026 06:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B7F9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHE5QSf+lq0Fs5AA--.43S2;
	Tue, 03 Nov 2026 14:28:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: pxa: Release the core clock reference on failure and exit
Date: Tue,  3 Nov 2026 06:28:43 +0000
Message-Id: <20261103062843.1020546-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAHE5QSf+lq0Fs5AA--.43S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZrW3tw13Kr4rAry8Jr17trb_yoW8JrW5pa
	yrWrWYkryrJF4Dtw4UGa1UCa45X3Z7CrWjgw1UCwnaqFn3AFyFq3WDGFyUXFZ8Xr1kuw42
	yr15Jw1xuayDAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5ku4UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcAA2rpWtl1KwAAsd

pxa_cpu_init() obtains a reference to the core clock with clk_get_sys(),
but neither an unsupported CPU nor a failed cpufreq_register_driver()
releases it. The module exit path also leaves the reference held after
unregistering the cpufreq driver.

Drop the clock reference when initialization fails and after unregistering
the driver on exit.

Fixes: d9278077385f ("cpufreq: pxa: convert to clock API")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index ed1ae061a687..83cd5a5ec7ea 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -305,12 +305,15 @@ static int __init pxa_cpu_init(void)
 
 	if (cpu_is_pxa25x() || cpu_is_pxa27x())
 		ret = cpufreq_register_driver(&pxa_cpufreq_driver);
+	if (ret)
+		clk_put(pxa_cpufreq_data.clk_core);
 	return ret;
 }
 
 static void __exit pxa_cpu_exit(void)
 {
 	cpufreq_unregister_driver(&pxa_cpufreq_driver);
+	clk_put(pxa_cpufreq_data.clk_core);
 }
 
 
-- 
2.34.1

