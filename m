Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E12F8E91
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529623; cv=none; b=hWADV0GY6S0CPMS2kw+HPEyNirLhif+qohFHZzFlZYZ1z4kvuc6uCyJoXe2UmAq4Kwc2o1++Ro85qCn/muHhkFPgQ4oJ5rRdFmdhdHgA/u+FxR9yekNgQnxGKCoaxdcfUPi+jM1v17QatW1Prjb9aYXP2sjRCA6bw3LdhHQeTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529623; c=relaxed/simple;
	bh=+L0R6kONx6ZmeEEAQcEMriILAGplIcUx3cgglaOYWAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj3YoR5QBCVYlQiWNjfR8qTzIChyFYW1e2fd8fumrZHoiqTpMP6LM1tFNl7gzbjF9AbsZvKFWu8AZR5Q4ACZHu/AdhJnYzJFvoVxWtM4Ueht5uYYLU8qXtMerviRhW5RtgQTMDphN5l7y8OMNKnzx4sjCHjDKKE3ZIuofDTrK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsV2GXw4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsV2GXw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F691F00A3A;
	Wed, 12 Aug 2026 10:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786529622;
	bh=EGWt/XZovKDcWn0xvx+IL2p8JpuJ8BMkQzrcrjtoUAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gsV2GXw4YvYmBycE0077m/h/GkkMCnbvXsIa8nf+omj8KBowK/R9c+JmQPvo0Bd3Z
	 yHprXmWNEMhY+Dy7ffgkoPeidA432K7bhZBIJ3Fk+uNwwduRXQNk7HTK9dIhYTZBf8
	 1YIjF9oYcOVmeMSXKpuI5BFRkL3FjA6zfDHYm9+666vsv2Y1rymbGPqSSWq/mQkWQe
	 l9YBFRRtdVKiOhb1ZWJIP4OyufYAxxpJ0jlyzONE6XHiao4oUd7B2Tm8jA536ljWDn
	 GC6+AAsFNHzX9aFCiMQJpuiq+N2MiFglmgNIDneqysUqwylMSQ2y1o8bS+WGB4SjpT
	 Oa263sTa180tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@bisdn.de>,
	Ray Jui <ray.jui@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] i2c: iproc: reset bus after timeout if START_BUSY is stuck
Date: Wed, 12 Aug 2026 06:13:39 -0400
Message-ID: <20260812101339.1638345-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812101339.1638345-1-sashal@kernel.org>
References: <2026080559-rendition-presoak-a347@gregkh>
 <20260812101339.1638345-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Gorski <jonas.gorski@bisdn.de>

[ Upstream commit 98f2e9e6d6f91a6abb43f166b244b428ba85fa2b ]

If a transaction times out, the START_BUSY signal can stay up, and
subsequent transactaction attempts will fail as the bus is still
considered busy.

I can easily trigger this by attempting to read from an address with no
device, e.g. when running i2cdetect. After the first read times out, all
subsequent read attempts return busy.

To get to a working state again, the controller needs to be reset to
clear the START_BUSY signal. So check for START_BUSY still asserted on a
timeout, and do reset in case it is,

This is also done by the original non-upstream iproc-smbus driver
implementation [1].

Works around situations like:

    bcm-iproc-2c 1803b000.i2c: transaction timed out
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    ...

where the bus never recovers after a timeout.

[1] https://github.com/opencomputeproject/onie/blob/master/patches/kernel/3.2.69/driver-iproc-smbus.patch

Fixes: e6e5dd3566e0 ("i2c: iproc: Add Broadcom iProc I2C Driver")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: <stable@vger.kernel.org> # v4.0+
Acked-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260717085507.34209-1-jonas.gorski@bisdn.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 33a57f362282a..fc5b29cd918e9 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -821,6 +821,17 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (!time_left && !iproc_i2c->xfer_is_done) {
+		/*
+		 * The controller may fail to clear START_BUSY after a timeout,
+		 * reset the controller to recover in that case.
+		 */
+		if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
+		       BIT(M_CMD_START_BUSY_SHIFT))) {
+			bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+			bcm_iproc_i2c_init(iproc_i2c);
+			bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+		}
+
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
-- 
2.53.0

