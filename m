Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34E18872A;
	Tue, 16 Jun 2026 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615723; cv=none; b=BDF31qQE3JY2NhqCASNOhSuiVwNWeC8SAcbdYEdLcfv5kEi33qbMjXObJJd/j8rWl97wNFxsFl6yCwA/0rzdGNYhESoRCcQ+nfXgPf/YN2UcFo5VGC5R6AY1fXlNKDv9Tr6PgY4e4eYoEdI0j7Y3cLVxOrxqe2QnFceNs2aZ2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615723; c=relaxed/simple;
	bh=xqq+XIxT7PztbwpeQpj5ADv0uMZ/3NYTda2OTWeHMlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jdZFvZF9kCXGaMAmDUZuJzW3/qOtUm5gkNUV8KfCzt40oCWKXBYgVw/CoPEYEx73z5/yb1Tv4fk8CG7/FJMrv2SfiFEuyOTIHOEt4Zoqd0yKZmRwym52kqgnjqhnhalE09pfE43gb/oNPizlFfVihkvLD2nHQKB7ZhpYNz4N2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAnlullTDFqP1rCEw--.23077S2;
	Tue, 16 Jun 2026 21:15:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: brgl@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
Date: Tue, 16 Jun 2026 13:15:14 +0000
Message-Id: <20260616131514.1677558-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnlullTDFqP1rCEw--.23077S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1rXFW7JFWUWryrGF13XFb_yoW8GrW7p3
	98G3sYyrW5WFWUJFs8JFWxXFyrAa17t34fuan7CwnYvw15Xa4jyry5ArW5XryjvFykZFya
	qw4xK3W8W34j9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwAA2oxFj3ONQAAsC

pwrseq_debugfs_seq_next() declares the 'next' device pointer with
__free(put_device), which causes put_device() to drop the reference
as soon as the variable goes out of scope. Returning 'next' directly
thus gives the caller a pointer whose reference has already been
decremented, resulting in a use-after-free.

Fix this by removing the automatic cleanup and returning the pointer
directly. The reference is now properly released in the stop() callback
of the seq_file operations.

Cc: stable@vger.kernel.org
Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

---
v2: Drop __free() and no_free_ptr().
---
 drivers/power/sequencing/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 4dff71be11b6..e8721368f08a 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -1008,9 +1008,7 @@ static void *pwrseq_debugfs_seq_next(struct seq_file *seq, void *data,
 
 	++*pos;
 
-	struct device *next __free(put_device) =
-			bus_find_next_device(&pwrseq_bus, curr);
-	return next;
+	return bus_find_next_device(&pwrseq_bus, curr);
 }
 
 static void pwrseq_debugfs_seq_show_target(struct seq_file *seq,
-- 
2.34.1

