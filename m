Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F8423A72
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530342; cv=none; b=Mqo40k0lawRn9Jr7GusaLBXlyn+jgY3w+vIQmrK/JmHOy+t5zkGEJ2uS+Ra8rPDLGossFZDMoZA1UkINiC4CZ6nDDO5VH82Dj6Wv2fvEZKbKvz+sj5GoDYPT8pVuR7vJ1MVXOnOpismBfbZhjRn8Tn1N3kwncgLApPIYywSHUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530342; c=relaxed/simple;
	bh=FRf39J+ZRFqPDVKVNzFK5g4b7weyN8hhP0og1oDdi1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gv//t2zZYgZPldsoqogUk7swla5IyJr+LKEdIrAeP4ZQA6o2n+93qzCgiClToMTpzpF2pBc2qtL2ncD4RAQBqviCq5HEfj9jnp/IFuPkj7ep+/n+2mNartlc6h9vxy6EVJYgUR5Wbfc4/7f3aTVZoiA6QsH+c6UI7RJW+geEFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moEQJR/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moEQJR/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9744F1F00AC4;
	Wed, 12 Aug 2026 10:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530341;
	bh=350YxoX6309xxvqNkMn+Dp9wRZv7wzv2L6sQp/zweiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=moEQJR/SfWi2P0AIJF1hhAX6O7IiIZ1HNenpcjGeuu1g18zOnu8S1fHZbYt21ntC/
	 LkCXdW+7htH0ETgi001pRvPKFR4zPsL1uQ73lFb5BsIFvyR+fBkud1/SXROROlgOEp
	 wrtsZFnUskbOxtp1AwyWIWt+EL1J4TB9EYL7L7HJkhZwVqObqlC02qlQIiPjc4CD2w
	 qgA847ySU7gU2FuLnsnkA0mBTVNu7SJIFNO4xUzoIg8Ek5sOYa8pe6WGJhm2AKJJbt
	 8zN+EprL+z9mBT2GIGdw6A3zKHkI7Y4orpFBgbkjblw9Qru9yUYBYb2ktHHz9DpWy/
	 MYWvnjT/fKOdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@bisdn.de>,
	Ray Jui <ray.jui@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] i2c: iproc: reset bus after timeout if START_BUSY is stuck
Date: Wed, 12 Aug 2026 06:25:37 -0400
Message-ID: <20260812102537.1684998-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812102537.1684998-1-sashal@kernel.org>
References: <2026080500-deafening-paramedic-2676@gregkh>
 <20260812102537.1684998-1-sashal@kernel.org>
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
index f74299b897df7..a9cbdd0e2f460 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -789,6 +789,17 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
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

