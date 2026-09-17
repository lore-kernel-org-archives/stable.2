Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121053D0B0;
	Thu, 17 Sep 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653382; cv=none; b=HnazbbbCI8ldMBhG9lrUz4BmuVB7xPLlrIJz0LEqKsXJA4VVMTYrjJkSUNZMWD1xfOBQtf+dKuUUeLMslsWZqrYW+vrX0HEPosByKD35mj+C4kKLHrwkN0puZJkxZDrpfOeJa6gNRyr/Sm+YCKs6ZlyY4p1gWt2X5VWxYlO0C0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653382; c=relaxed/simple;
	bh=077i/Q1INZ15yogyP3Tqe/H/1eH6uwCHt37vpOaMT70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IqSgvJEgnopN+es2tRj7DeiL7dXMIDB8yNzh5lH3juwBjTvmb73F/6zCYpUPx/vfXwjNQqrAKfKSJma0PzyPo6nJisahsBvWJwgs6HA6ly5Uc7I+pjEtSJwvLxlwmzwBWn9xI3oOPuCwVcmrD2s0mwgSjB6W2uJk8Eb2V38C4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADH+EJ38atqg+aBCA--.45091S2;
	Thu, 17 Sep 2026 21:56:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hansg@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	luzmaximilian@gmail.com,
	platform-driver-x86@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: Fix use-after-free in ssh_ptl_shutdown()
Date: Thu, 17 Sep 2026 13:56:07 +0000
Message-Id: <20260917135607.2154130-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADH+EJ38atqg+aBCA--.45091S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyxWF15XF13JFWrCw47twb_yoW8Zr1Dpr
	Wjk3ySkr4kJrsrtw48Ka1Uur4UZa9Yy3yjkrWFkwn8ZrnxXrnIqa4I9r1ruFZ0kFZrX3ya
	kr48Kr15C3W0vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UNTmhUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qrrRnMEQAAsk

ssh_packet_put() is called on the loop variable of both
list_for_each_entry() loops in ssh_ptl_shutdown(), freeing the packet
before the iterator advances past it. Use list_for_each_entry_safe()
and move pending packets to complete_p, as their links use
pending_node, so that each loop walks a single list.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/surface/aggregator/ssh_packet_layer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 3dd22856570f..871780828419 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1983,13 +1983,13 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
 		smp_mb__before_atomic();
 		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
 
-		list_move_tail(&p->pending_node, &complete_q);
+		list_move_tail(&p->pending_node, &complete_p);
 	}
 	atomic_set(&ptl->pending.count, 0);
 	spin_unlock(&ptl->pending.lock);
 
 	/* Complete and drop packets on complete_q. */
-	list_for_each_entry(p, &complete_q, queue_node) {
+	list_for_each_entry_safe(p, n, &complete_q, queue_node) {
 		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
 			__ssh_ptl_complete(p, -ESHUTDOWN);
 
@@ -1997,7 +1997,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
 	}
 
 	/* Complete and drop packets on complete_p. */
-	list_for_each_entry(p, &complete_p, pending_node) {
+	list_for_each_entry_safe(p, n, &complete_p, pending_node) {
 		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
 			__ssh_ptl_complete(p, -ESHUTDOWN);
 
-- 
2.34.1

