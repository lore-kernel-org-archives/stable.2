Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626B3B52E6;
	Fri, 26 Jun 2026 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475942; cv=none; b=jvnv53Pma5qoLJerxaaJhRJddS1v46u0eP631c7sw9PzQBwK+tTd12IB6OMF68z/iaHcIbc+vdcYum7axHSpRMI6d0hO+JnszLWiWZ/Vb48ikeyVmorFOliSk6+qPA5O0a4riCucn59xqE1oKHdjwZgVuuyX9jnMtg4Q0PT8+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475942; c=relaxed/simple;
	bh=BfnQk7iKMOLpA7+Kzvp/fPghSJfqclRFtsLc1FYQ4+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OcxEptHdvdeJhahZo7Dpc60exIlfOWyW+muPHplLNVWEXuZfi2ztWjBXAm+y4lC4A9WreCXI1EDleRRNPMnv5DJ50xLPtI05B0eP/CQeCGlv5xRkWsYRxqVOFLaZOc2hGveenByNS5nPEWQ6PlI9ra9gIfTcVJjCpWgosDklLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowABn8QShbD5q9HhnFQ--.10681S2;
	Fri, 26 Jun 2026 20:12:18 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org,
	tglx@kernel.org
Cc: linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: clocksource: timer-nxp-pit: pit_timer_init: cpuhp_setup_state   failure leaks clockevent device
Date: Fri, 26 Jun 2026 20:12:15 +0800
Message-Id: <20260626121215.34748-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn8QShbD5q9HhnFQ--.10681S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fAry8Gr4xXF18XFyfXrb_yoW8Gw4xpw
	4xZ343Jrn0gr429r4UtF4DXFykCan5CrWakFy5G343Zrn8JryrXF4UtFWUXFyUGrWrA3ZI
	vanYyw4UuFyUCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhvttUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYKA2o+ThJUAAABse

After pit_clockevent_per_cpu_init succeeds (registering a clockevent
  device and requesting an IRQ), if cpuhp_setup_state subsequently fails,
  the error path only unregisters the clocksource but not the clockevent
  device. This leaves the IRQ handler registered and per-CPU data uncleaned
  before kfree(pit), causing both a resource leak and potential
  use-after-free.

Cc: stable@vger.kernel.org
Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-nxp-pit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
index bc5157e2ba57..b77966faa112 100644
--- a/drivers/clocksource/timer-nxp-pit.c
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -329,11 +329,12 @@ static int pit_timer_init(struct device_node *np)
 		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT timer:starting",
 					pit_clockevent_starting_cpu, NULL);
 		if (ret < 0)
-			goto out_pit_clocksource_unregister;
+			goto out_pit_clockevent_unregister;
 	}
 
 	return 0;
-
+out_pit_clockevent_unregister:
+	pit_clockevent_per_cpu_exit(pit, pit_instances - 1);
 out_pit_clocksource_unregister:
 	clocksource_unregister(&pit->cs);
 out_pit_module_disable:
-- 
2.39.5 (Apple Git-154)

