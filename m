Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0838A702;
	Tue, 15 Sep 2026 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455703; cv=none; b=WGAobpZkP1SRSZiDxXBGR39GX4FIwysTwgTGaVV+a1oUKGMWmCL2LXYKPQly6YSxdHOhGyW2AttQ2TwGKvdGCaFQQMCaiL2eoCWLmeYp1wmO6ZvbvQ/aLv0GldvUEFca0SJmy2EPg8wtTIc5/pCo7WohDCaNAhqgnXZQ8gtdOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455703; c=relaxed/simple;
	bh=vF1V0ylTTKs8GE4BBdhZti8reEXrmv6XKYpSFkNibZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9twnqDTxmbc8giqVmj2u5JgEYtIcJgPbI1P5IHgKwr//ApzE3CdoUKdWwMHRcJZw9EW4nB2xoGb4zCO/BjSbdXje0YB3ttwCru4ZfO4He+DewEOCFumhB2dBDWMQ1q/s9Lyc1KplPbBEoZDoxSbymvJg5OoDGeTS+IeR1BzMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABnaTdL7ahq9KLIBw--.59459S2;
	Tue, 15 Sep 2026 15:01:31 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bmasney@redhat.com
Cc: linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clk: versatile: clk-icst: Fix node reference leak in of_syscon_icst_setup()
Date: Tue, 15 Sep 2026 07:01:03 +0000
Message-Id: <20260915070103.1733176-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnaTdL7ahq9KLIBw--.59459S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1xKF1fAFy5Aw43ZryfXrb_yoW8Wr43pr
	ZF9rZ0yr48Kr1Ut3y8trWDuFyFvan7GFWrCa4xKan7ZrZ5JFy5JrWUWa4UuF4UAF95uayr
	tr4qk3yxZr4UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU11rW7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRULA2qowd2jhwAAsu

of_get_parent() takes a reference on the syscon parent node. The
reference is intentionally kept on the success path, but the error paths
return without dropping it, leaking the node reference. Release the
reference before returning on the error paths.

Fixes: d430819d69a5 ("clk: versatile-icst: add device tree support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/versatile/clk-icst.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index 6bd3db54dd22..8c84377f3ec1 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -516,16 +516,19 @@ static void __init of_syscon_icst_setup(struct device_node *np)
 	map = syscon_node_to_regmap(parent);
 	if (IS_ERR(map)) {
 		pr_err("no regmap for syscon ICST clock parent\n");
+		of_node_put(parent);
 		return;
 	}
 
 	if (of_property_read_u32(np, "reg", &icst_desc.vco_offset) &&
 	    of_property_read_u32(np, "vco-offset", &icst_desc.vco_offset)) {
 		pr_err("no VCO register offset for ICST clock\n");
+		of_node_put(parent);
 		return;
 	}
 	if (of_property_read_u32(np, "lock-offset", &icst_desc.lock_offset)) {
 		pr_err("no lock register offset for ICST clock\n");
+		of_node_put(parent);
 		return;
 	}
 
@@ -552,6 +555,7 @@ static void __init of_syscon_icst_setup(struct device_node *np)
 		ctype = ICST_INTEGRATOR_CP_CM_MEM;
 	} else {
 		pr_err("unknown ICST clock %pOF\n", np);
+		of_node_put(parent);
 		return;
 	}
 
-- 
2.34.1

