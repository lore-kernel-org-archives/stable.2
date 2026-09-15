Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28733A718D;
	Tue, 15 Sep 2026 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451481; cv=none; b=CUz2e/g3Kfkuz0cK6zpXbiWYECe0hq9FUQ1hz9Uope+vHoYaYODINfrCMSsERMUETO9j8HsDb+WQ5kMCfC8r+GIPp7YtfI+PIVN9pH5WRPs4AKaIMrIB35QtYMRwzNYxFEP4rCzVh5pPsY6GZf9ZGweTlwavRjfC8qQJaKaPnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451481; c=relaxed/simple;
	bh=ESxk9Z/7FRaHCqQ8q4uTTzh04t+wN6Jr4ts20xyS1uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P0uwrtehPW0eSXbmVpwjWDiNnN8Ea6RBnCCmfliheZmno905G7AoxIyx3aYws3/lXUURG8HBZanqxJcD5ca+dL8PEFsSl7DFj2LkZn7QIID4ERv2OUiuk8AND5HScHfJnP6R/K03vHPWabsqUqGhjHrF0G21XSACySbf/8lypJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAX7O_Q3KhqNDMKCA--.62423S2;
	Tue, 15 Sep 2026 13:51:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexandre.torgue@foss.st.com
Cc: daniel.lezcano@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	tglx@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/armv7m_systick: Fix clock reference leak
Date: Tue, 15 Sep 2026 05:50:43 +0000
Message-Id: <20260915055043.1729896-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAX7O_Q3KhqNDMKCA--.62423S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1fGF43Gw4Uury5ZFyfCrg_yoWkWrc_Ka
	1v9r97Gr9akrnxKr1qkw15Z390kFnrZry8uFWIv3W3J3y7Zr45uw13urn3ur97Wayftas8
	ArW7Cw4rZw1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1P
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMLA2qowR1hdAAAsG

system_timer_of_register() obtains the timer clock with of_clk_get()
and enables it, but on the success path the local clock reference is
simply dropped without clk_put(), leaking the consumer reference. The
error labels already release the clock.

Release the reference with clk_put() before returning success. The
clock remains prepared and enabled, so the timer keeps running.

Fixes: 4958ebb3d027 ("clocksource/drivers/armv7m_systick: Add ARM System timer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/armv7m_systick.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/armv7m_systick.c b/drivers/clocksource/armv7m_systick.c
index 7e78074480e4..1810f811bb2a 100644
--- a/drivers/clocksource/armv7m_systick.c
+++ b/drivers/clocksource/armv7m_systick.c
@@ -69,6 +69,9 @@ static int __init system_timer_of_register(struct device_node *np)
 
 	pr_info("ARM System timer initialized as clocksource\n");
 
+	if (clk)
+		clk_put(clk);
+
 	return 0;
 
 out_clk_disable:
-- 
2.34.1

