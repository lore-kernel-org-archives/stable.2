Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F00537AA64;
	Fri, 17 Jul 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301011; cv=none; b=JszieUvZjjQEpQnJDTVmEXwmy6bNrOOevCum9+TX83WxsYaMDH5GnxTTIdQRdE96+845bRAjle4afLLyF6SIfs6JkhYERpADqC/64qHGj2MFsS162YtdayrYAKVXMkuu6ZXFpNdDBdlkxMMDmmLDIe7fs5mj/KY/ZXoH2T4R7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301011; c=relaxed/simple;
	bh=oVyk1mCb3WeJTyZQetd/g/VcL7RRJRL9Ra0heLIbA9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OD+B/2mvOOqTXDNDXLaO4j//KYCmAugIB5YaNQ4D6aDeGAWh+vgZkF2RK56KSmTD+3aIWf2gM6/Te7xVlubmqIHkp7Rk4squqXxAI/xViGIDRMV6sq6feDolns2CSaigV+pkClv/pilFvMlHqetunWxjNeaWhqSaUi9hDfZNqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=6A4EQyrV reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="6A4EQyrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=zYMX3Bgl3M
	wBiu3oHp/4ZnhfMYx1Xs0I6Wu9VQ6kAi8=; b=6A4EQyrVcyApl+xVClXcrX6Bln
	OwA1MyZ8NJVTukQ6bJJnhfCN/mszD5coQuF+oHSGLHHc/k9sKyYK80lXlzX52a4m
	czJjPxEqH4RTbxuMGql9wn7USitnKuYiBsav6tEDgFekX+HC9K013ap6LhLzuzKE
	OGGkvR/09uji6y09Y=
Received: from wmy.localdomain (unknown [115.53.182.236])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkCG7NXBRVpqIGESAQ--.57240S2;
	Fri, 17 Jul 2026 23:09:56 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v5 0/2] misc: ibmasm: Fix out-of-bounds MMIO accesses
Date: Fri, 17 Jul 2026 23:09:49 +0800
Message-Id: <20260717150951.85927-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCG7NXBRVpqIGESAQ--.57240S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrJF43Aw17Ar1kZr4xWFg_yoW8CFyxpF
	sxW3yYvrW8AFWxWa9Iyr12qFyYkF1xJFW3WFy7t348ZFy5XFyUAr1Yya4Ygr1xJ395tw18
	WF90qas7C3ZFyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUfnY7UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUREWpY9eq+jwAAsY

This patch series fixes two distinct out-of-bounds (OOB) MMIO access
vectors in the ibmasm driver when exposed to malformed or fuzzed hardware
with an undersized BAR 0.

Patch 1 addresses the static OOB access during the probe phase.
Patch 2 addresses the dynamic OOB accesses via malicious hardware MFAs
during runtime interrupts.

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
 drivers/misc/ibmasm/lowlevel.c | 42 ++++++++++++++++++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 23 +++++++++++++++----
 drivers/misc/ibmasm/module.c   | 13 +++++++++++
 4 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.34.1

