Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC93C4B93
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528776; cv=none; b=BktOPVyfEX/HCwLD1BuChCnppaY3+h2vh85gC5jHJdUfurFENWDLbKddlkrM8wnFPIX0gdW2OGxoF3mE/jehDMfmSOfEeby6ZDsedpLMh4tD1kz1REeSXvTfPNMRtc9jkP280wEpP736Pk7zaf46a1rOMZP3i/sUGP6OdJH/2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528776; c=relaxed/simple;
	bh=Q/ILtihT10uoaq462B+W4OJyomLNDNuPYSE7McPb9wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HixNDUdQUbOvDrlOXoPi4wikDMGbgxG8exjqm8fAOwMlNExsAKtAgg5dh/Dbpsdz6YHgezaEzse+oNlDkoxNH0+27G5LuinumEXc7gVV6l49W/itfxsfmLgWragTmy+fE8a70KFM477eQf9miu1m/WOHIjZYgiZ3yAZVFbJUzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecA3Xtu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecA3Xtu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530931F00A3E;
	Wed, 12 Aug 2026 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528774;
	bh=qceXEzHJsCmj8Y02g/VruWx5xqPZ7issqBAWl39tM+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ecA3Xtu3A14mkR6jOezH9raO+NLL/XyNaJG3tecoyz31y+J56z+tNh7RUKs1M6+1U
	 gouk8KhOBNsO2g2fnMRrB6K7jsyMhs9zQs1/9EuEsP+99Jec5AujwzTUPLjs1ZrzKb
	 psodSYvN/eGtVHqE17yU/jLcgPCodeTAfNc6d7NuIEq1oxIy+JMH5Oo9yLf5us8DWy
	 KLmbM8jZFrAmQzuC8yg/3ZLFOL1FJY1XXjkLqrgdSaFblFkwcIrNYguyjZgOc4nVfb
	 /REXFBGHPWvFWU4H3m0oPmKRLm0DIOi9OFwNfeMsFlhjb+nFxlmhBYrAM6UcenRLMS
	 MkKbl3yxMDhfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@bisdn.de>,
	Ray Jui <ray.jui@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] i2c: iproc: reset bus after timeout if START_BUSY is stuck
Date: Wed, 12 Aug 2026 05:59:31 -0400
Message-ID: <20260812095932.1597082-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812095932.1597082-1-sashal@kernel.org>
References: <2026080559-bonehead-marsupial-c9b2@gregkh>
 <20260812095932.1597082-1-sashal@kernel.org>
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
index 56203eadb319a..36dae5fe28260 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -811,6 +811,17 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
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

