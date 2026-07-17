Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D73E0222;
	Fri, 17 Jul 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276789; cv=none; b=RqrAaVbCvcPe85iDjACpdKRqbEfPYw+Tdw9Di8hj8e8ChhaO4jnD+2XU5mj1+QgYaNHnGYoRJIFIxfgNiZ7+7DGJP3oORmtgdauhyd3mA5HZIXGQVk+nuFAOXZKcq0/YV9fP29jwdHvp7c2czghB2H35+pmK7zwFJrElMxl7IG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276789; c=relaxed/simple;
	bh=JrX3G6gCgBD6tWah/ZvNkTG2+7hQEj9NEK9hik330Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ueGqJc4FZX7p52WxuYphUIUIyvgUNGC0/EA6X35Zmbqc6KN1RSCgH8AJWrm79nbVFHMrv+G0rRxbFcmWYf4zYtWBsmAvbOIZlYCycB1WvUhXjYm85U/b6fVVP8iWIUcgo3tXRckKbQoRSXba8oF0KgkbqGV+X4IwMkQAbC2TDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=i/r4q+oc reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="i/r4q+oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=NdVdA34gWd
	FbTsZVFbVWkDikNT1Mh0btJhkR+78Rhrw=; b=i/r4q+ocEf32q9h+jPL/GedT+K
	NQnY0Emwyt5ySyK7GwhNQ9m0efJ4FC3hqcx649ql0dqrum8+jmICI1We4QKbB7VD
	5TgpumtOGqjkXkM3/L/7lqxM0KWxD1a7YxPvgU/2Fmgu21Y0G4OKA8gtWGvfdh+f
	QbQPNqxSX8/dR+UxM=
Received: from wmy.localdomain (unknown [115.53.180.253])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkCGzTIc51lqocQOAQ--.7216S2;
	Fri, 17 Jul 2026 16:26:07 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Johan Hovold <johan@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] module: fix UAF and GPF in idempotent_init_module via heap allocation
Date: Fri, 17 Jul 2026 16:26:01 +0800
Message-Id: <20260717082601.81704-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCGzTIc51lqocQOAQ--.7216S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWfWF43uw4fZw4xuF48Zwb_yoW5AF13pF
	s3Way3KFsaywsxWa18Jr1vg34agrW8CF4jva4fKw1fCr15Xr9FkF1ftw1S9FyUXrZ5CrZr
	KF45tr1UWFWUXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUf9NsU
	UUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUREWpY9Xh9sQAAs0

During concurrent module loading (e.g., triggered by syzkaller), the
idempotent module loading mechanism uses a local stack variable
(`struct idempotent idem`) to track the state of waiters.

If a task executing idempotent_init_module() is abruptly terminated
(e.g., killed by a fatal signal or otherwise completely exits before
reaching the list cleanup paths) after adding its node to the global
`idem_hash` list, its kernel stack is prematurely freed and reclaimed.

However, the stack-allocated node remains linked in the list. Subsequent
module loading attempts that traverse the list will dereference this
stale stack pointer, leading to KASAN slab-out-of-bounds reads and
General Protection Faults (GPF):

  BUG: KASAN: slab-out-of-bounds in idempotent_init_module+0x54a/0x620
  Read of size 8 at addr ffff888106367df8 by task modprobe/433
  ...
  The buggy address belongs to the object at ffff8881063676c0
   which belongs to the cache shmem_inode_cache of size 1392
  ...
  Oops: general protection fault, probably for non-canonical address

Fix this by dynamically allocating `struct idempotent` on the heap
via `kmalloc_obj()`. This decouples the list node's lifespan from the
process stack, ensuring that even if the task is abruptly terminated,
the global list safely points to valid heap memory until properly
unlinked, preventing memory corruption.

Fixes: 9b9879fc0327 ("modules: catch concurrent module loads, treat them as idempotent")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 kernel/module/main.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..39f05ac4b1a1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3779,21 +3779,29 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 
 static int idempotent_init_module(struct file *f, const char __user * uargs, int flags)
 {
-	struct idempotent idem;
+	struct idempotent *idem;
+	int ret;
 
 	if (!(f->f_mode & FMODE_READ))
 		return -EBADF;
 
+	idem = kmalloc_obj(*idem, GFP_KERNEL);
+	if (!idem)
+		return -ENOMEM;
+
 	/* Are we the winners of the race and get to do this? */
-	if (!idempotent(&idem, file_inode(f))) {
-		int ret = init_module_from_file(f, uargs, flags);
-		return idempotent_complete(&idem, ret);
+	if (!idempotent(idem, file_inode(f))) {
+		ret = init_module_from_file(f, uargs, flags);
+		ret = idempotent_complete(idem, ret);
+	} else {
+		/*
+		 * Somebody else won the race and is loading the module.
+		 */
+		ret = idempotent_wait_for_completion(idem);
 	}
 
-	/*
-	 * Somebody else won the race and is loading the module.
-	 */
-	return idempotent_wait_for_completion(&idem);
+	kfree(idem);
+	return ret;
 }
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
-- 
2.34.1

