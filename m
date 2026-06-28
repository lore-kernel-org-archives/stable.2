Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD234C9AD;
	Sun, 28 Jun 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652030; cv=none; b=g1bzcY5lTGqG3gO5d1hVgbW1J18O/852nBekV52uCH51kxAhPMyNKgxKc9FtZNSnVVN/VxDwtugSce0GM305/OLzS9K+CNqFykVTxXbcIOYU36+eU0H9g0AO2DyNFZcqM9tQyPKbUc+9o6ibQKc3krh8Rygk1/mzRUh0QXo42fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652030; c=relaxed/simple;
	bh=sc9lgCI+pK6cNqVSqDiV6+18rgg1aohYPLzunG/unAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V4Fjq+/ZG0rXDHpZIZtY0PCrM6/YFRqoJG6Y3Hzd49iQ9sbNotMPsCi6lk1hDWGLlcY1wmh1EIop9O/52IeVJAdHC+GDiYLVYRLrxw6mUFXtw0wNr/bmtAdiWQ/cb3QCaY/YxGomzgYefwhDs69sOIU6AyUGMddZu6QadQyLzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhF2HEFqGaPFFQ--.45905S2;
	Sun, 28 Jun 2026 21:07:02 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org,
	tglx@kernel.org
Cc: linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] clocksource/nxp-pit: fix IRQ leak on cpuhp_setup_state error path
Date: Sun, 28 Jun 2026 21:07:00 +0800
Message-Id: <20260628130700.45680-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhF2HEFqGaPFFQ--.45905S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryDKw4DGw1fKryxuw1rJFb_yoW8AF15p3
	yI9w13Ar45Xr4I9w4qqa1DXF93Gan5KrWakFyrG34avrsxXF1SqFWDtFWjqFy7GrZ5ZanF
	q3ZYyr4ruFyUCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfsqAUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQMA2pAixHx9QAAs4

When cpuhp_setup_state fails after pit_clockevent_per_cpu_init has
successfully called request_irq, the error handling jumps directly to
out_pit_clocksource_unregister without freeing the registered IRQ.

This leaks the IRQ line and, since kfree(pit) follows, leaves a
dangling pointer registered as the interrupt handler's dev_id,
potentially leading to a use-after-free if the IRQ fires afterwards.

Fix it by calling pit_clockevent_per_cpu_exit to properly release the
IRQ before falling through to the existing cleanup chain.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
- Call pit_clockevent_per_cpu_exit inline before goto instead of
  adding a separate error label (out_pit_clockevent_unregister)
---
 drivers/clocksource/timer-nxp-pit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
index bc5157e2ba57..2f70d1d5e21b 100644
--- a/drivers/clocksource/timer-nxp-pit.c
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -328,8 +328,10 @@ static int pit_timer_init(struct device_node *np)
 	if (pit_instances == max_pit_instances) {
 		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT timer:starting",
 					pit_clockevent_starting_cpu, NULL);
-		if (ret < 0)
+		if (ret < 0) {
+			pit_clockevent_per_cpu_exit(pit, pit_instances);
 			goto out_pit_clocksource_unregister;
+		}
 	}
 
 	return 0;
-- 
2.39.5 (Apple Git-154)

