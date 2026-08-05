Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19E26D4E5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930263; cv=none; b=fHNo3x7CG7PajhnnNsTCUR6WF0Edf0ilElp1ApYqvvKOLy44IbBdIRWT1KzAVd7KPrvg+JJP7YVWaK5R222vRQxQIlr5o+44THXeAcrF0ZR2HkwpSDBZcMWFFD5lR6nT7gNj8SQKsRaT7ZrGejYVU3Mm4fa9cAYhRSkPOQKD4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930263; c=relaxed/simple;
	bh=aTCpEHvzQo5im8A2QVTFzZTMx6XQGHnwqhESeCKGf4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EpP9UShdF0ZdPS/BJTQH8V6S3buTMUVaaP2NSo+jQ4WHx0cm9DyzO3rIx0ZR+0fnpCkMn/wQaKCb+JOUD1ggas+J4E/R1RkDFvAzNHOvIalkLyVJfuRrkxe48s+mExq6ewFoPdQN2RUevvh2ToPA15gIpkaX2NCJOfcsS/q0yok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NYVNqK+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NYVNqK+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18971F000E9;
	Wed,  5 Aug 2026 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930262;
	bh=sPNZAYNZHsIYd59v9RxN4GdL5xPbEIZVNjQVp3VBJfk=;
	h=Subject:To:Cc:From:Date;
	b=NYVNqK+ilsPYNIbRXKTIISimGZBS74y593tE3qFGgJPj+s6wuzzJPBsDtsFYBQLWH
	 ELFrJY8RaD+R44j0kSWThIxADZouDXDk1PDcnpbpp6pC0AJPlTVV6LFrHHw5yXrwQ/
	 ZfoGyLfeH0Si00NL6MwMtxqQS8IzkscBRD8gNyQU=
Subject: FAILED: patch "[PATCH] i2c: iproc: reset bus after timeout if START_BUSY is stuck" failed to apply to 5.15-stable tree
To: jonas.gorski@bisdn.de,andi.shyti@kernel.org,ray.jui@broadcom.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:43:59 +0200
Message-ID: <2026080559-rendition-presoak-a347@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 98f2e9e6d6f91a6abb43f166b244b428ba85fa2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-rendition-presoak-a347@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

