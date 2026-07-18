Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B251E347DD;
	Sat, 18 Jul 2026 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342021; cv=none; b=EhBHoFWj+ovfDywRUJawbTMfXOWOk4tMEImbAQ1G55378o4ZpoosZY0YfO+QlEnrsaDbr3HmP7gZAwklgKVD9KNsNjf/jrDAKW+aO9DoNVAwyWor68mtiV6eJBmF8n0iihEuzmBNj6t8pAOXtrtBV8yqn4HUHBjq10YHBsUlMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342021; c=relaxed/simple;
	bh=jCcd/nkeRo8M7sVog9qerSNLTdVlxiCwI+JKhpJeKsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FYAoVtMYlEJXJ+xUi3nBHkGvgfQchmYoaatue3Gsi1zMBAyTQ3xEyMk4ni83ypVxJExX4L6EbNcChXhgX3XD7K/ie3xrivz7Wie8wXHWYiX0EayzSsJIUnx2tuVs52STEKOscIwIWxpzJ712fcOWjBmUpHG+z628B1Q/gnxf+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=MxGOW8NQ reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="MxGOW8NQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=nRn8muFYOa
	q62rjwOOpm3VTpvWQuReFqDDZrmSqV270=; b=MxGOW8NQAJTi56TZlI8cddKNoe
	OGs9rDVYA2b3h/jA6xZ9KsANfW782Cqe/ys33XdVgwRY/XBMtMSHRqQ9apQ6POiu
	jyTolcmhp55UzLahlE1+gTAEzRVyV+GFT/ub6VuMlCxHrBqiPxy+EzTZgKAYiiH3
	Y0U+JB3sKa6OvBHGg=
Received: from wmy.localdomain (unknown [115.53.182.64])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkCW+9T25VpqJQQYAQ--.52490S2;
	Sat, 18 Jul 2026 10:33:28 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v6 0/2] misc: ibmasm: Fix out-of-bounds MMIO accesses
Date: Sat, 18 Jul 2026 10:33:22 +0800
Message-Id: <20260718023324.95237-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCW+9T25VpqJQQYAQ--.52490S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrJF43Aw17Ar48KF4UJwb_yoW8ury5pF
	sxW3yYvrW8AFWIga9Iyr12qa4YkF1xJay3WFy7t348XFy5XFyUAryjva45Wrn7J395t348
	WFn0qas7C3ZFyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjdMa7UUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUREWpY9eq+1gACsD

This patch series fixes two distinct out-of-bounds (OOB) MMIO access
vectors in the ibmasm driver when exposed to malformed or fuzzed hardware
with an undersized BAR 0.

Patch 1 addresses the static OOB access during the probe phase.
Patch 2 addresses the dynamic OOB accesses via malicious hardware MFAs
during runtime interrupts.

Changes in v6:
 - Patch 2: Fixed a mathematical error in the dynamic bounds check where 
   the header size was double-counted, which would have incorrectly 
   rejected valid hardware messages.

Changes in v5:
 - Patch 1: Extended static bounds check threshold to 0xAC1FC to correctly 
   cover display_depth() accesses identified by static analysis.
 - Patch 2: Moved get_i2o_message() out of line into lowlevel.c to avoid 
   text bloat, as requested by Greg KH.

Changes in v4:
 - Patch 1: Extended static bounds check to cover remote input device 
   registers (up to 0xAC000) that are unconditionally accessed 
   during probe.
 - Patch 2: Added dynamic payload size to bounds calculation to prevent 
   trailing out-of-bounds memcpy_toio().
 - Patch 2: Restored set_mfa_inbound() in the error path to prevent 
   hardware queue deadlocks, and used safe subtraction for dynamic bounds 
   checking to prevent integer overflow bypasses.

Changes in v3:
 - Split the monolithic v2 patch into a 2-patch series to separate the 
   probe-time static checks from the runtime dynamic checks, as requested 
   by Greg KH.

Changes in v2:
 - Added dynamic MFA bounds checking in get_i2o_message().
 - Implemented hardware mailbox deadlock prevention.
 - Fixed potential unsigned integer underflow in bounds check arithmetic.

Mingyu Wang (2):
  misc: ibmasm: Fix static out-of-bounds MMIO access during probe
  misc: ibmasm: Fix dynamic out-of-bounds MMIO access via malicious MFA

 drivers/misc/ibmasm/ibmasm.h   |  1 +
 drivers/misc/ibmasm/lowlevel.c | 41 ++++++++++++++++++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 23 +++++++++++++++----
 drivers/misc/ibmasm/module.c   | 13 +++++++++++
 4 files changed, 70 insertions(+), 8 deletions(-)

-- 
2.34.1

