Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156C36F8F1;
	Tue, 16 Jun 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622659; cv=none; b=A3hm/VDvvGFyPi2/LnlvPiZJougi4MKXqkFaMiwlqP6I4fHYQpg9s1KuPKhGRHhyCMrz1YOnQ4nTlUDSepzAoU91d6zMgYtnOsoyDQ9j5G2JCKk6jxullSlCsqZxC+YJ7r9CG7wy00+nMp51v2MtgK+ddpG2jvzMXmHeZA4dgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622659; c=relaxed/simple;
	bh=W4cgagOPP0hYiBtcEvp+x2v4nSGrdYTHC+4Ya2AkIAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HAj7uXNJrGE80GoUtjdtuyyVCzFVRKjmqWd+hPBVObj0CUpcBWDNAE82xMliqXMVqA/rN2aF11k7CGw1dyZzDavZaEgoniKGOolVK5OJEcVC0zg/sUjFDddz36LgnhcEOKAl0diYNeA7T/WCJf1Yu+L4kZuR7LeKlOsI5rVGf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhF9ZzFqtHPFEw--.19499S2;
	Tue, 16 Jun 2026 23:10:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: brgl@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
Date: Tue, 16 Jun 2026 15:10:49 +0000
Message-Id: <20260616151049.1705503-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhF9ZzFqtHPFEw--.19499S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy7uFWfJF1fXF1Dtw43Jrb_yoW5CrWfp3
	98uas0yrWDG3yUtF43JF4UXry5Zay2y34fuF92k3sY9w15X34Fyry8X34YqryjvFWkJa4D
	Xw1IgFy8W34q9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZeOJUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4AA2oxWswKcwABsx

pwrseq_debugfs_seq_next() declares 'next' with __free(put_device),
which causes put_device() to be called on the returned pointer when
the variable goes out of scope.  This results in a use-after-free
since the seq_file framework receives a pointer whose reference has
already been dropped.

Simply removing __free(put_device) would fix the UAF but would leak
the reference acquired by bus_find_next_device(), as stop() only
calls up_read(&pwrseq_sem) and never releases the device reference.

Fix this by making the reference counting consistent across all
seq_file callbacks, matching the standard pattern used by PCI and
SCSI:

- start(): use get_device() so it returns a referenced pointer.
- next(): explicitly put_device(curr) to release the previous
  device's reference (no NULL check needed - the seq_file framework
  only calls next() while the previous return was non-NULL).
- stop(): put_device(data) to release the last iterated device's
  reference, with a NULL guard since stop() may be called with NULL
  when start() returned NULL or next() reached end-of-sequence.

Cc: stable@vger.kernel.org
Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v3: Make reference counting consistent across all callbacks instead
    of just removing __free(). Add get_device() in start(),
    put_device(curr) in next(), and put_device(data) in stop().
v2: Drop __free() and no_free_ptr().
---
 drivers/power/sequencing/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 4dff71be11b6..9b512a055b5a 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -989,8 +989,9 @@ static void *pwrseq_debugfs_seq_start(struct seq_file *seq, loff_t *pos)
 	ctx.index = *pos;
 
 	/*
-	 * We're holding the lock for the entire printout so no need to fiddle
-	 * with device reference count.
+	 * Hold the lock for the entire printout to prevent device removal.
+	 * Reference counts are managed by start()/next()/stop() as required
+	 * by the seq_file contract.
 	 */
 	down_read(&pwrseq_sem);
 
@@ -998,7 +999,7 @@ static void *pwrseq_debugfs_seq_start(struct seq_file *seq, loff_t *pos)
 	if (!ctx.index)
 		return NULL;
 
-	return ctx.dev;
+	return get_device(ctx.dev);
 }
 
 static void *pwrseq_debugfs_seq_next(struct seq_file *seq, void *data,
@@ -1008,8 +1009,9 @@ static void *pwrseq_debugfs_seq_next(struct seq_file *seq, void *data,
 
 	++*pos;
 
-	struct device *next __free(put_device) =
-			bus_find_next_device(&pwrseq_bus, curr);
+	struct device *next = bus_find_next_device(&pwrseq_bus, curr);
+
+	put_device(curr);
 	return next;
 }
 
@@ -1058,6 +1060,8 @@ static int pwrseq_debugfs_seq_show(struct seq_file *seq, void *data)
 
 static void pwrseq_debugfs_seq_stop(struct seq_file *seq, void *data)
 {
+	if (data)
+		put_device(data);
 	up_read(&pwrseq_sem);
 }
 
-- 
2.34.1

