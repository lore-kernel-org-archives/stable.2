Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07921339366
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716247; cv=none; b=Qm/j6r8Y82GaBLYr+SJWZ7XY9xEsHrg7aGTnBoERHVnF4uLTlRVHIH1hO82fWsm6JVezyPDiY3Iqf8phEOdWNkV8bCaSFU9e+fulgSZ33KU8RpX/J0hKQDGsMj7lNrLGtt2YMoXHq+h63JXSfVZ4n/WH2YpLI+uYdeqvY6sHUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716247; c=relaxed/simple;
	bh=AJufertzuDUfBc0vmJlKh8YD3M22Pzd72oYhHRqkAOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7CJ0pItAXaWlvlLAkSGVpSVGUeEbAr+Z5iN+8yC7yXpj/sCqKTRWxnERBwRkJrMk4bz5nYMrB2cwbUQMtlHOWobLLFlkPY2cE69jOWxmjDhcQKDmo2epUVkY7yDAXeOM1oSNgcikZGYoffx1vxzRprIAqDA7v+cKGJAaEqpk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeDY/qtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeDY/qtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB3F1F000E9;
	Wed, 22 Jul 2026 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716244;
	bh=TXjaUhd4CGBthdu/Z/2YGTGybtbUQd0vnoaYU624Aak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeDY/qtIXsocqpaE1q6MxGBYnm5bF4qPoZFWLNxaU6UKkR816M/c/dz/QkCSNk/rn
	 hh4z0CBXhX1Wq5g8kRVgGuleKo4UxKsX0O2EHXMujSM96AXZUtzenUarikVG4BFg8r
	 HWeXLzbogBGt9JAV4aGQP3ygh2/XTcCC9F2MO4OSZb6ThHG7g1XZUjajv+ajKu9ns/
	 cyZEMW8u1pohObZzxImXvmBtNM6M6kLAUSzSUjRxjMiEPUeh2KuG+lGpSVc+uUKcHG
	 3vvqWE6DO1X50I13Ouh/pQRSo2+7c+1XfA1An4h49Fu9V5I3b7u3NWLq/R0/xwYSfP
	 9aUvFdKAfcZnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] i2c: i801: fix hardware state machine corruption in error path
Date: Wed, 22 Jul 2026 06:30:42 -0400
Message-ID: <20260722103042.891373-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071643-unnoticed-jitters-56c2@gregkh>
References: <2026071643-unnoticed-jitters-56c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

[ Upstream commit 10dd1a736d557e310a77117832874729a0175d57 ]

A severe livelock and subsequent Hung Task panic were observed in the
i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
unconditional hardware register cleanup in the error handling path of
i801_access().

When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
controller is actively used by BIOS/ACPI), the kernel does not actually
acquire the hardware ownership. However, the code jumps to the 'out'
label and executes:

    iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));

This forcefully clears the INUSE_STS lock and resets the hardware status
flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
transactions and totally corrupts the SMBus hardware state machine.

Consequently, all subsequent i801_access() calls fail at the pre-check
stage, triggering an endless stream of "SMBus is busy, can't use it!"
error logs. Over a slow serial console, this printk flood monopolizes
the CPU (Console Livelock), starving other processes trying to acquire
the mmap_lock down_read semaphore, ultimately triggering the hung task
watchdog.

Fix this by moving the 'out' label below the hardware register cleanup.
If i801_check_pre() fails, we safely bypass the iowrite8() and only
release the software locks (pm_runtime and mutex), strictly adhering to
the rule of not releasing resources that were never acquired.

Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260512093534.348655-1-w15303746062@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-i801.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 89fdc75cdcfa54..b0429fa3f57349 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -918,13 +918,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 */
 	if (hwpec)
 		outb_p(inb_p(SMBAUXCTL(priv)) & ~SMBAUXCTL_CRC, SMBAUXCTL(priv));
-out:
 	/*
 	 * Unlock the SMBus device for use by BIOS/ACPI,
 	 * and clear status flags if not done already.
 	 */
 	outb_p(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
+out:
 	pm_runtime_mark_last_busy(&priv->pci_dev->dev);
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	mutex_unlock(&priv->acpi_lock);
-- 
2.53.0

