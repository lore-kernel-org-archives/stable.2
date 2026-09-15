Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFF36728B;
	Tue, 15 Sep 2026 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446439; cv=none; b=lzPPGzoc1pCwy0ktRYqzPgKqPAR8SasVFiIi5+rV5i3NEYkb+nErsrWVB4nrD/oXRWzr1pybMwCceAcNpLk6L45CpDcSX8iFPT6EQvd99CLS0j6/flkzaIHisJ3sEGNP3aGxi0TEFp/n8axs2XW64JDeRtnf5cLp1c0tmDhseXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446439; c=relaxed/simple;
	bh=1cGlGsui+FK1n1e021N5yj+H8XNT8jo/XA/DoEycxFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ih1oSBqdEBvBaAg05Sr2eHlAmZCAUzQOZm8koVtMN6Hbzmhr4ZEHSwiN4nGIwodU5VAj/wQ/gvXUANCnwYB5O1hkqi6nqy0UM0vnDYhKPs8FxHh70MMgGdYYHTbwbHH+vZQ91HFKxbKgxTI8XnWEEiMtUl3n4oudfYRgkmcsoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnvPAfyahqm5cICA--.51484S2;
	Tue, 15 Sep 2026 12:27:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Yuantian.Tang@nxp.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	scottwood@nxp.com,
	viresh.kumar@linaro.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] cpufreq: qoriq: Fix clock reference leak in qoriq_cpufreq_cpu_init() error paths
Date: Tue, 15 Sep 2026 04:26:42 +0000
Message-Id: <20260915042642.1725537-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnvPAfyahqm5cICA--.51484S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xCFW8tF4DCFy3Jr1UZFb_yoW8WrW5pF
	W5WrZ0yrWrZa1qkw1DGF4UW3ZYva1vyFWUGry8Jwnavwn3Ja45Zan8GFyUuFWrCFZ5Jan2
	yr1Dtayxtrs5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUwT5lUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMLA2qowpAaBgAAsA

qoriq_cpufreq_cpu_init() obtains a consumer clock with of_clk_get() and
stores it in policy->clk.  If the allocation of data->pclk or of the
frequency table fails afterwards, the error paths jump to err_nomem2 or
err_pclk, which only free the allocated memory and drop the CPU node
reference; the reference obtained by of_clk_get() is never released,
leaking a clock reference on each failed init.

Add an err_clk label that releases policy->clk with clk_put() before
falling through to err_nomem2.  The path on which of_clk_get() itself
fails keeps jumping straight to err_nomem2, as policy->clk is only an
error pointer there and must not be put.

Fixes: b1e9a64972bf ("cpufreq: qoriq: Don't look at clock implementation details")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/cpufreq/qoriq-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 42edb41ad459..13d3333e68d8 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -183,7 +183,7 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	data->pclk = kzalloc_objs(struct clk *, count);
 	if (!data->pclk)
-		goto err_nomem2;
+		goto err_clk;
 
 	table = kzalloc_objs(*table, count + 1);
 	if (!table)
@@ -217,6 +217,8 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 err_pclk:
 	kfree(data->pclk);
+err_clk:
+	clk_put(policy->clk);
 err_nomem2:
 	kfree(data);
 err_np:
-- 
2.34.1

