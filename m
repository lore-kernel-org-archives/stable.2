Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BABB2571C0;
	Sat, 18 Jul 2026 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784345845; cv=none; b=WVcQ35ZhDDIpImR2MNBgQMSdusgtbRXOGwWmEZXO7RG30M5Ly8yxaKSDyqid9BNfM5ApEkLtJ+QdrUwvcR7McOdMKsmlxoOcjyt9M4sj2Bb4UAtB+++F2nCPkalUfXa+2AkF/HQeNXtJMtEQKH3ir8fU0ohX/CsLQdX8XL/0HKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784345845; c=relaxed/simple;
	bh=veMgSjz45XJCBweqnrS8D38k9ock1SRvQMtYhFyjymw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMsA65COZUrqNEQaG4LlyjJ7TK7H8cUhOemsxUQ00ueTLSWN3fVtmP/lBHXOtjlMIxgiv3pwaiqlZUE5DwUNm6Xnp/ZrH0A6YE0XDKpBYj7cA3p2T9X6NnylWh86u9rrTZ0opLul/MdZFP6sE3Sw5Z924CF4G999fmrvdIJFbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=e5oSA/GM reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="e5oSA/GM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=bfttyS91lf
	M3W2GA9f9+XNI0eVd2gf2xNG931ty+M5g=; b=e5oSA/GMLTEbJl+6xcOJBkSEo5
	/baAUHgy47QR0USMqU6JgXWhgRdlUmwLHp8xw9bVGkKs3mhVC2dEczkf3ahMWvYQ
	n08DLSCvZgcNsWinbsbba9xTDCLlwiaitO7kDx0suKW0AKnWS77uZBeSmxOAUoqG
	Xbzr+cILcy/E3zOT4=
Received: from wmy.localdomain (unknown [115.53.187.56])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkAmitPk9Fpqy40YAQ--.283S2;
	Sat, 18 Jul 2026 11:37:11 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v7 0/2] misc: ibmasm: Fix out-of-bounds MMIO accesses
Date: Sat, 18 Jul 2026 11:37:04 +0800
Message-Id: <20260718033706.95929-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkAmitPk9Fpqy40YAQ--.283S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrJF43Aw17Aw45Aw1UJrb_yoW8Kw48pF
	Z8W34Yvr48ArWIga9Iyr17Xa4YkF1xJay3WFy3t348XFy5JFyUAryjya4YgrWxJws5Jw10
	gFn8Xas7C3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUfnY7UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUSEWpaRvg-qAABsc

This patch series fixes two distinct out-of-bounds (OOB) MMIO access
vectors in the ibmasm driver when exposed to malformed or fuzzed hardware
with an undersized BAR 0.

Patch 1 addresses the static OOB access during the probe phase.
Patch 2 addresses the dynamic OOB accesses via malicious hardware MFAs
during runtime interrupts.

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
 drivers/misc/ibmasm/lowlevel.c | 45 +++++++++++++++++++++++++++++++---
 drivers/misc/ibmasm/lowlevel.h | 23 ++++++++++++++---
 drivers/misc/ibmasm/module.c   | 13 ++++++++++
 4 files changed, 74 insertions(+), 8 deletions(-)

-- 
2.34.1

