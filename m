Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505D38C401
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930266; cv=none; b=aSFJbAhgfpT7+R/HqzQpa4kluYjdS2dZ+nG5X9uegAEAsq9FUt0PmCN9cZbRLAOkyKwZzMSsCHq8DSS2U8Tn2K1JMEQfsh4VWjXPk0KBR1iaSz/cXGLj5EN6dxO2+N6pZ9Pl9ZV1kYSZnMY6y1mC71kTucCo2GtwxgZEmbmL64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930266; c=relaxed/simple;
	bh=6qpLXLQU+Ym+GB5Kuu5oqQdNyOssY8YZ1dTuCLQqTec=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ga/6wbY1VVSYj3O8AaMA5EqUG25ssg7k3dvw/LatglAw+7aukjvjoVXaVD/YWFZ6cMpkUhL7ZCeovMToLIBS7pbNNf5/CE3JM1ns67I1kqnYC/OVkkVnFE5zwh26u+9w8YD4uUYefZINjl1fxD5wHUF8+ZZ6g7rBnlvTAW1X76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fM3lyFR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fM3lyFR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CF81F00A3A;
	Wed,  5 Aug 2026 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930265;
	bh=U+TsOUffTtOy32j3D9oi183nxOoQd762Y5/BMpngakM=;
	h=Subject:To:Cc:From:Date;
	b=fM3lyFR21TLDWvy9cfOUzN9s8j4EaiaJxSJqojEsbICqadJAH1sIuGGq4neebD1Mt
	 ThWEQM5hm4QK4rIt9xF4WtkJ5nIXtuo/0OIqXDsYxT7f0eHtFwu2to1F01XiWj+WDT
	 5mQsQVpDHjRkv3ta2pi2DVDuMaI79z+yQDivdH7g=
Subject: FAILED: patch "[PATCH] i2c: iproc: reset bus after timeout if START_BUSY is stuck" failed to apply to 5.10-stable tree
To: jonas.gorski@bisdn.de,andi.shyti@kernel.org,ray.jui@broadcom.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:44:00 +0200
Message-ID: <2026080500-deafening-paramedic-2676@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 98f2e9e6d6f91a6abb43f166b244b428ba85fa2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080500-deafening-paramedic-2676@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98f2e9e6d6f91a6abb43f166b244b428ba85fa2b Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Fri, 17 Jul 2026 10:55:07 +0200
Subject: [PATCH] i2c: iproc: reset bus after timeout if START_BUSY is stuck

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

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index b5629cffe99b..86ca4c2221c4 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -803,6 +803,17 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
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

