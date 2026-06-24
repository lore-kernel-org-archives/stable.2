Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6017993;
	Wed, 24 Jun 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271499; cv=none; b=LgMI8x4ccP/knuJBWrS+sxh+xv+hte0BqSOjFarCzzK3n8n5v3P0c4oNkXzTLq5s/jtIrWMovM47Z1mgD6t00OviQXaIcqAwi77MHLYd2VK4JZWTRyb/mCxY29aVacAA6Ki4axRKTyxjLVMgfnU2wfEycHRjoqJ8no7/8lHer2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271499; c=relaxed/simple;
	bh=FR4JW+UOX/9dyOBYDpiHx4ATWbvVpFpzYdWJHRYQLKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/X5o0+Abg65JrmTuRXTOXD0iOVqqD/AR9tTglgm5Uf2zOLTw7I5Brp+uqMSGDHe+kFlB0KT7+RJ+fCUR0BxCL7tGAhb9YM0VYG7C6buFbfT1oz2A0Fj0n1Xsyvu4u1oNRMaIvtbLnEF07KhoXgipRSMXxzN1I4e8vXeo/0puMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ezjeEyiP; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ezjeEyiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=w2
	ozsF+t7ZFrNUaRuy5EbJNPlDMu/dL0yhBCogSjuY8=; b=ezjeEyiPpb8KOC9b9C
	7gep2Xdhg3K8Xju104g0lKzckTEKUGQDeZKrQCpLqFOnyLar1gSj1OSuAsUWkjKT
	DhqPi3UuBuLhUESLxQNy9h32A1tyqNN2q6Gm9Ev6NGc8vgnBf7bcNsUWnjpajQPy
	hgXmrcyaG9lKFX61BX0vO+Few=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHzV_rTTtqYc1IEw--.194S2;
	Wed, 24 Jun 2026 11:24:33 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v4 0/2] misc: ibmasm: Fix out-of-bounds MMIO accesses
Date: Wed, 24 Jun 2026 11:24:23 +0800
Message-Id: <20260624032425.384325-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHzV_rTTtqYc1IEw--.194S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyrJF43Aw17Aw1DGw1kAFb_yoW8Ww4kpF
	s8W3yFvrW8Jr4xWa9Iyr12ga4Yk3WxJFW3Wa47ta48Xry5WFyUAryj934Ygr1xGws5tw18
	WFyYqa4xC3ZrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZNV9UUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDABH43Go7TfExZAAA3N

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

This patch series fixes two distinct out-of-bounds (OOB) MMIO access
vectors in the ibmasm driver when exposed to malformed or fuzzed hardware
with an undersized BAR 0.

Patch 1 addresses the static OOB access during the probe phase.
Patch 2 addresses the dynamic OOB accesses via malicious hardware MFAs
during runtime interrupts.

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
 drivers/misc/ibmasm/lowlevel.c | 30 ++++++++++++++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 28 ++++++++++++++++++++++++++--
 drivers/misc/ibmasm/module.c   | 13 +++++++++++++
 4 files changed, 66 insertions(+), 6 deletions(-)

-- 
2.34.1

