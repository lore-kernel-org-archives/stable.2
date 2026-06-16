Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10823EAB2;
	Tue, 16 Jun 2026 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576568; cv=none; b=VLIB/OUB7/DOR+BfcHqknKCbLG8Zeaz8/il+pL+ElX32CLmTWu2Jkbnt0lYQHr5/+mdWQTrNeCOTR00rzhvKjkU45Lap0liP0QqxhXPcEs12II3p+EGd4ZKzydNX2x7i+tzpeffa/Y7jwRH7RWtP+vLjL/wii0AA6+ZHrxWGF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576568; c=relaxed/simple;
	bh=S3mz17AhE2+LTLaXrzCJePSSSnwKBwPr5tsB0ra3wVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GfGxoEqmuxfRkFum0xWkzX5lwU7AV41PSvBp4yMjo76+dgsAbVoqpjwBPiJPl4pyUUiMpu05cvJb/cXJ0EGyltFSo6FHGfcLYACen9MlyaUsNYgSl8jm413d7lAkxA7HaWv/gYKgZotKzOcn1Nd88xx4ERaVcn21/7+hziQsDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHJt1xszBqCv7gFA--.37987S2;
	Tue, 16 Jun 2026 10:22:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: brgl@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
Date: Tue, 16 Jun 2026 02:22:26 +0000
Message-Id: <20260616022226.1655762-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHJt1xszBqCv7gFA--.37987S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JryfKFyxKw1kXw1fCry8Xwb_yoW8JrWrp3
	98G3sYyrWUWF47tF45tFW7XFy5Aa17J34fua9ruwnYvw15Xa4jyry5ArW5XryjyFy8ZFy3
	tr1Iga48uryj9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUg4S
	rUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYTA2owFOcJPwADsG

pwrseq_debugfs_seq_next() declares the 'next' device pointer with
__free(put_device), which causes put_device() to drop the reference
as soon as the variable goes out of scope. Returning 'next' directly
thus gives the caller a pointer whose reference has already been
decremented, resulting in a use-after-free.

Fix this by returning no_free_ptr(next) so that the automatic
cleanup is suppressed and ownership is properly transferred to
the caller.

Cc: stable@vger.kernel.org
Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/power/sequencing/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 4dff71be11b6..1ec4f393994d 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -1010,7 +1010,7 @@ static void *pwrseq_debugfs_seq_next(struct seq_file *seq, void *data,
 
 	struct device *next __free(put_device) =
 			bus_find_next_device(&pwrseq_bus, curr);
-	return next;
+	return_ptr(next);
 }
 
 static void pwrseq_debugfs_seq_show_target(struct seq_file *seq,
-- 
2.34.1

