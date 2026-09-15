Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E96440643;
	Tue, 15 Sep 2026 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451322; cv=none; b=VOkqkHfwfjusN6pWXDfOuXauDLALrZt4AbpsdUfnTOgPHnL33aEGfxiQ5KPDaMDJ8XmzSv3x3hn6QOWhHpgY0kBpsaPLnoiwJty/aI2Fa+c6RAKUz5YFUvSznxFk7pQc2G0hSP/5p5hp2tGMc7awZSD/DKe69HMPkE5F889NFbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451322; c=relaxed/simple;
	bh=LqKs0E+W+LDdReQ983V0fIzIIuGbvF2+nbEBAL6rBhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eV3tRDxLBPDJpi3jEAcKzKpd/SX50gvFnompKElvR2iTq/oy+d50LmXL5iMSHHRzHF6NufUsnXj275oaVQTSCyg4pO9eZKLQZd4MsiZH+d1hcS+9xJKJcqClvTLqaYUjc0zVNsu4QOUk8THp1NhKdHNtslGUo/qu7EPZWmfezc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnu+8x3Khq2iAKCA--.40502S2;
	Tue, 15 Sep 2026 13:48:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org
Cc: lee@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patrice.chotard@foss.st.com,
	tglx@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/st_lpc: Fix clock reference leaks
Date: Tue, 15 Sep 2026 05:48:04 +0000
Message-Id: <20260915054804.1729741-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnu+8x3Khq2iAKCA--.40502S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4rKrW3uw45tw18CFWkCrg_yoW8JF4kpr
	1kKw4rAr1Uu3yIgrs0qrWvyr9Y9ayqkFy3G3y3K3ZrZr45GFW5uayfXayIvF4DArWxCw47
	t3W5AFZ5ZF1DuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmeH
	gUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAILA2qowzNWfwABsc

st_clksrc_setup_clk() obtains the LPC clock with of_clk_get() but
leaks the consumer reference on two error paths: the
clk_prepare_enable() failure path returns without any release, and the
clk_get_rate() == 0 path only does clk_disable_unprepare() without
clk_put().

Add the missing clk_put() calls, mirroring the release already done in
st_clksrc_of_register() error handling.

Fixes: 70bef01c0f1c ("clocksource: sti: Provide support for the ST LPC Clocksource IP")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/clksrc_st_lpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index 419a886876e4..574b966eeb34 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -74,12 +74,14 @@ static int __init st_clksrc_setup_clk(struct device_node *np)
 
 	if (clk_prepare_enable(clk)) {
 		pr_err("clksrc-st-lpc: Failed to enable LPC clock\n");
+		clk_put(clk);
 		return -EINVAL;
 	}
 
 	if (!clk_get_rate(clk)) {
 		pr_err("clksrc-st-lpc: Failed to get LPC clock rate\n");
 		clk_disable_unprepare(clk);
+		clk_put(clk);
 		return -EINVAL;
 	}
 
-- 
2.34.1

