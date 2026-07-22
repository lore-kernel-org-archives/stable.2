Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9935B63D
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681475; cv=none; b=CTe7Tv6MjmPlTQK8mQ3nYJY2oz+jmC7m8qPwKh8taNLdcqx1NWh+H5LfzPW2VzcICOIXlmK+UQQ99Ti8+ft0IV+3F/hPqy4DUgCfDnUNsL4CUD3MpptQq+POc6PL+T20S5jmhrxK1lcx0hXJ6JpH5pbAxWEX5Vy7dH3HaDN7+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681475; c=relaxed/simple;
	bh=7Vq5bmY50ByqkvBZQ27v2wsImA3RFJ+/YmrnW/YCWZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1AUqDK1DgEyq7NpPhd6pA2Y9/VUTJCLR6VrLEB+aJQ7yA3YAF3XjKFtxYsuAuvULwwU8iduXbgQblxA5xyxbBZ2942AAueWNbcI+79y801q0tRGalVnxsr+iWfdX2ZHOauI0y53dEP26GJ3WF3mzxz1oyj2Rai/nXorJFcTeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3gysMRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3gysMRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C08D1F000E9;
	Wed, 22 Jul 2026 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681473;
	bh=dTpnVdooM3QR69AX2QXyk/lONLEuNRJau51VnOLRR10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N3gysMRuHv9iY4hMQXPl0mqa81jOTVSwzKnYdZhdEB2NIJgwmnG0cV6a6C5leHd7w
	 GXuF5avVpTvpIuHkhTpjFlFiOWSJj1DW1AS6poO951lruVIa28HrW0l0z2dQLuvHH1
	 ywQuPoU9vJkYZAiKsuR4L0xLahtPtz3Dsckmi7OCFjKC+lb4QGH7wqm4UFkwt69bzv
	 h2qIguhhfI7dDKb/N+ZwkApYigCDUZ1W0p/NCrBL0PAxGWZB11FOczucZzAPtjpfPP
	 kVEGz1CdSx3TJGakmdtKzIEpA6xgfLY/TQyW+2x6RRZoZNa2RbItipe/j+M9IaOYgd
	 v6kHHwKioDKYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] i2c: i801: fix hardware state machine corruption in error path
Date: Tue, 21 Jul 2026 20:51:11 -0400
Message-ID: <20260722005111.605431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071642-divinity-volatile-1a36@gregkh>
References: <2026071642-divinity-volatile-1a36@gregkh>
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
index 24363acfc3f8c2..321fed8117222a 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -930,13 +930,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
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

