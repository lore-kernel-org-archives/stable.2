Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE01F7569;
	Sat, 18 Jul 2026 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784359990; cv=none; b=VxBPunBTQ7SJdjk/HABmoobutvXNNaRbmCtAvAjstBDZ12IO29G/xE0bw+WixfUNmbzJWfeRUpW2wq6xryX9RVWvMKy9I4V9avlycLaE6c/s+Ee9B6ICQBCg4IDaurD9IUo+oYlU40q62HeTLjEbPqHL3lUfLDkwec6Y5dDE1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784359990; c=relaxed/simple;
	bh=RC8zDf3czAtGmT4X5OU+FZTQmTpfuWvwLR4012D0DLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kyhbPHEn3Bbmqfoi9KTilrCbHBZgCkfEV7JQrZSqMDYcd90dXKgzXAhTHKfPY01aZUJt4Vmj7vdknk3qJf0vclxjv7cMgy2VtJbhn1fYVUS5k485zlWegCtULWgk4sapO22snMDEHskoU55WxAemyNH33aKv4JoIdZBIbtJGK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=hwvcY6tx reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="hwvcY6tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=XfxgWTi4cn
	HI2POOGPXVSfrQJku008KOXkKRQTdXccE=; b=hwvcY6txKhzhTjJY5x4CSBIP4w
	xgNGn2XXks8cUouOAiL0p0YfJz7+SJNsZs2nCYX3XV7MNhB+Je1yDyCZvraMEyIy
	8YBXoQ4yaPiS/kbbLouMsQ4dxLGIwWmw/g62u8Gbc+Yei/i9JVcGzr9waRvd/q23
	X57rPLJzjwr9tMwGE=
Received: from wmy.localdomain (unknown [115.53.184.209])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkDWP9knLFtqtKMaAQ--.33853S2;
	Sat, 18 Jul 2026 15:32:58 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v8 0/2] misc: ibmasm: Fix out-of-bounds MMIO accesses
Date: Sat, 18 Jul 2026 15:32:51 +0800
Message-Id: <20260718073253.96741-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkDWP9knLFtqtKMaAQ--.33853S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fAF4xXryxuw45Cr47CFg_yoW5XF1fpF
	Z8Ww4YvrWUJFWSgFZIyr10qa4YkF4xJay3WFy3t34rXFy5JFyUAryjya4Ygr4xJws5t348
	WFn8Xa4xC3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0XdbDUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUSEWpaR2pdmAAAsf

This patch series fixes two distinct out-of-bounds (OOB) MMIO access
vectors in the ibmasm driver when exposed to malformed or fuzzed hardware
with an undersized BAR 0.

Patch 1 addresses the static OOB access during the probe phase.
Patch 2 addresses the dynamic OOB accesses via malicious hardware MFAs
during runtime interrupts.

Changes in v8:
 - Patch 2: Addressed static analysis feedback by removing
   set_mfa_inbound() from the error path. Submitting an out-of-bounds
   MFA instructs the hardware to execute from an invalid physical
   address (Wild DMA). Dropping the MFA safely favors a device stall
   over host memory corruption.

Changes in v7:
 - Patch 2: Addressed a pre-existing logic bug caught by static analysis 
   where the driver passed the total message size instead of the payload 
   size to ibmasm_receive_message(), causing a 12-byte OOB read. Added an 
   underflow safeguard (data_size < sizeof(i2o_header)) and corrected the 
   passed payload size.

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
 drivers/misc/ibmasm/lowlevel.c | 42 ++++++++++++++++++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 23 +++++++++++++++----
 drivers/misc/ibmasm/module.c   | 13 +++++++++++
 4 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.34.1

