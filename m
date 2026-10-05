Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8447252F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196163; cv=none; b=aFB3DuHHYM1oF7UlqO4gKY2FBaWgXKospYSUIhyQC4Uh4l4/dfDtUbx53jS4q7eQ1n7DwNbgPNEwpEgUzY0it4aHp9YCUrlkJP+LEsjRJXVTx2ZeR65IlnFXBFtTEjRgc433viEK7d1DVUc7sDPKET76ssa6/FhwdBAPP+SPFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196163; c=relaxed/simple;
	bh=SMPfRdImgmeDIMQ5L2ywK6adl7nIMG9+6zwIL/w4ky0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NTRcwxOR2sH7yef9/grwDKUwUYZYzrIFdWVqB5huAvN0j0p3holSsULDNtw0LZ/om5pbtXePdr5KV4Aps8eto13R7i6GS3Q1ljB1gqqqan73qZj1eYYhkxrJs0FwEK1vnRwfLCRCHw67ZL0tJcq7VpXNBcBRRpwj1xipdVr/rQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFweSx8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFweSx8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211A71F00893;
	Mon,  5 Oct 2026 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791196160;
	bh=u1cwuLU9Ba/1vnZ0BUGDCa7jS44BmM+KN0JM4QxrlAI=;
	h=Subject:To:Cc:From:Date;
	b=ZFweSx8nl9Bf2yQ17boovuodliQrm1obnqc9ajd0WA2cn+O1AqUI2bM+5SeanXDnL
	 mt99UIPn7u6rbzekrfnOdZIcg7J8qsY1UKtuuOS5NoTCsMxY1oLli0TtCGpvN8aZEm
	 poQ/iHi2286tSTc/phh0d9tu9V5GGfcySh6IsTQ4=
Subject: FAILED: patch "[PATCH] i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO" failed to apply to 6.6-stable tree
To: abdurrahman@nexthop.ai,andi.shyti@kernel.org,michal.simek@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:29:08 +0200
Message-ID: <2026100508-underhand-quickly-8a38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e6fe3ea04f0113fe4d47c03d76e03805a4768ca7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100508-underhand-quickly-8a38@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6fe3ea04f0113fe4d47c03d76e03805a4768ca7 Mon Sep 17 00:00:00 2001
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 24 Sep 2026 17:10:36 -0700
Subject: [PATCH] i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO

For the normal path of xiic_smbus_block_read_setup() -- the trailing
bytes all fit in one Rx FIFO fill -- RFD was programmed two below the
byte count, which fires the RX_FULL interrupt while the last byte is
still in flight. xiic_read_rx() then lands in its bytes_rem == 1 branch
and sets NACK on a byte still on the wire, truncating the read.

Without PEC this is harmless: the truncated byte is the dummy one the
caller never looks at. With PEC enabled it is the PEC byte itself, and
i2c_smbus_check_pec() fails the transfer with -EBADMSG.

Raise the threshold by one so RX_FULL fires only once every remaining
byte is already buffered. That routes the drain through
xiic_read_rx()'s bytes_rem == 0 path, which reads everything out and
emits the stop cleanly. The only change for the non-PEC case is that
the controller waits one extra byte-time before servicing the
interrupt.

rfd_set stays inside the 4 bits of XIIC_RFD_REG_OFFSET: this branch is
only reached when rxmsg_len + pec_len <= IIC_RX_FIFO_DEPTH, so the
value is at most IIC_RX_FIFO_DEPTH - 1.

Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: <stable@vger.kernel.org> # v6.3+
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260924-i2c-xiic-v7-2-df7e752332ef@nexthop.ai

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 0777de45bdf4..5cd737c7608f 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -569,11 +569,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
-			 * All trailing bytes fit in the Rx FIFO. The widened
-			 * condition above guarantees rxmsg_len + pec_len >= 2,
-			 * so this cannot underflow.
+			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
+			 * until every one of them is buffered, so the drain
+			 * takes xiic_read_rx()'s bytes_rem == 0 path.
 			 */
-			rfd_set = rxmsg_len + pec_len - 2;
+			rfd_set = rxmsg_len + pec_len - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

