Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.10.215.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325431;
	b=z2wSCdwgjlIxvqhb7o/bI2pmNg2OIDoOyLH+k7+L7pDliM2WWhhCvsusrkwTpZ1Dmljo
	 8LT74rrANnK7ZRDxr2jHc2jmo/wjXi9aYkwdGW8rC876jMSoQ5KXiEMMPX409Nz8HUGkY
	 F/56p91iJUgHBFsK14FwFAQiXDgfKtxjbV8vQnJ1lDwweB8OOD5NEFhV28Czu4Awh2zdx
	 wgkvJLluwLDtyw5RqUOdExT54IDjS3Ybvl9KcYfRnulm5nv5YklnUrC6Czbe98PQGjube
	 Pg1j9HEuUoXPUINMzFrc/YzG1slRw/uDmNEMlI+X6wKD6ZIa0/lFCl75edByMIB4mLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325431;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=R5a0Oq9BIezczwgOlTkVnVAW8jrIlXPGAQV31TXS52E=;
	b=q/wEx3uPsWCxv+i4CbvU3MMKbgZ7cRFXIeH/IGNgPVSgCIA7A2smGQDuCJtuHOKfqtr0
	 aiEYWGpg5VkjNE5kbxu3zCdgngZs9xRyf4IVG28h58ADqH2ICofZBenoY+VgbKBgdJXZ7
	 oml4P4c56lMDIRdAL2adx5BWqz5lpzcAGihYkJGN29aGuaetRAPcgXqJksABjugMj9CkA
	 BLMwtcxPq4rFRMsEkakFSVfEJCXQwO3f0pyagNuLJ664MB+Aon3exDvF9egfKfgg0XaEv
	 7dwVtb61NqOAuOUGzXrIEe3MU8F8+L01Ikgz/Zolv8jghSrvlbj97et1oTDP9GEIL2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hetzner-cloud.de;
	spf=pass smtp.mailfrom=hetzner-cloud.de;
	arc=none smtp.remote-ip=85.10.215.232
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90264606AB58;
	Tue, 10 Nov 2026 15:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90264606AB58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1xQo0g-000IEt-1x;
	Tue, 10 Nov 2026 16:43:46 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1xQo0g-000CQE-1D;
	Tue, 10 Nov 2026 16:43:46 +0100
From: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	David LaPorte <dalaport@amazon.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] i2c: designware: Only check for spurious STOP without EMPTYFIFO_HOLD_MASTER
Date: Tue, 10 Nov 2026 16:43:29 +0100
Message-ID: <20261110154330.78515-2-sarah.maedel@hetzner-cloud.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110154330.78515-1-sarah.maedel@hetzner-cloud.de>
References: <20261110154330.78515-1-sarah.maedel@hetzner-cloud.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28179/Tue Nov 10 07:26:51 2026)

Commit 560072246088 ("i2c: designware: Support of controller with
IC_EMPTYFIFO_HOLD_MASTER disabled") fails a transfer when STOP_DET is
seen while a read or write is still in progress. This is meant to catch
Tx FIFO underruns on controllers without IC_EMPTYFIFO_HOLD_MASTER_EN,
but the check is applied to all controllers.

Controllers with IC_EMPTYFIFO_HOLD_MASTER_EN hold SCL on an empty Tx
FIFO and can't underrun, but on a multi-master bus they also see
STOP_DET for other masters' transactions. The driver then disables the
adapter while the controller is still busy with the transfer. On
DW_apb_i2c 1.20a (Ampere Altra, IPMI SSIF shared with the BMC) this
leaves the master stuck with IC_ENABLE_STATUS set, and all following
transfers fail with "timeout waiting for bus ready".

Limit the check to controllers without IC_EMPTYFIFO_HOLD_MASTER, as
suggested by David LaPorte.

Fixes: 560072246088 ("i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_MASTER disabled")
Cc: stable@vger.kernel.org # v7.0+
Suggested-by: David LaPorte <dalaport@amazon.com>
Link: https://lore.kernel.org/all/20260505232244.71807-1-dalaport@amazon.com/
Signed-off-by: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
---
 drivers/i2c/busses/i2c-designware-master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 7e1d9a2e7733..d7d99c7b6ef2 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -675,8 +675,11 @@ static void i2c_dw_process_transfer(struct dw_i2c_dev *dev, unsigned int stat)
 	if (stat & DW_IC_INTR_TX_EMPTY)
 		i2c_dw_xfer_msg(dev);
 
-	/* Abort if we detect a STOP in the middle of a read or a write */
-	if ((stat & DW_IC_INTR_STOP_DET) &&
+	/*
+	 * Abort if we detect a STOP in the middle of a read or a write on a
+	 * controller that doesn't hold SCL on an empty Tx FIFO.
+	 */
+	if (!dev->emptyfifo_hold_master && (stat & DW_IC_INTR_STOP_DET) &&
 	    (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS))) {
 		dev_err(dev->dev, "spurious STOP detected\n");
 		dev->rx_outstanding = 0;
-- 
2.47.3

