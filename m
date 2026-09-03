Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F237F739
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443668; cv=none; b=L65WdxVYDZuarjEEzZWI9EJXv4vUqqBd8EAHkJcveugGwpK3IoLnCyrtlRbhseFe8IHscrdrUB2XYF4g7PcWa8xCOdfpmT/N+S+RvapTUBobbikfDWPMAoxdk0Pl42Vfu28NTWUBsZeclyLI3Oo8etQU5mWz4KmHCsnvvHklkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443668; c=relaxed/simple;
	bh=83+kC3DR1A9lYe1uT2vCEU1MfHy4704BF+0hidrVyEo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S0dfyou1e6M5+y9Ycjl4KGrWRfLwMNw3sn/FNWVPzP/gLDT23evB6KxM7YPfLetC3smRUllGfJeh5fzv4Xi1PemHEuT5DnSxjaDKwIVbta9NslI8GPE9yf9T9po37yxnRVs1IGaPR17N+9p6yXEj+OGfQ2cXvrRrBHbr6KVTC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yEehj0hE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yEehj0hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9021F00A3A;
	Thu,  3 Sep 2026 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443656;
	bh=jmSpAinGx1c3ppzz+q+yBjB8T6LpEbTPhCh9o5WovMk=;
	h=Subject:To:Cc:From:Date;
	b=yEehj0hE/+Mr2CH07fjQjbZGxeBF5dRwUU7RDze8FaePnMwEcscS+a/9CvjtptoFn
	 5yI3zeOWVImykwz8yJpcnxEr78Co7+6l7y6l0fIMOlaKWaO48dNUkoF3WEvqy2NjYf
	 xCNqo7hn174FisAJQPpMANkM6cAh8KkxUc97d2k4=
Subject: FAILED: patch "[PATCH] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes" failed to apply to 6.6-stable tree
To: yijiangshan@kylinos.cn,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:36:57 +0200
Message-ID: <2026090356-ramble-footing-c350@gregkh>
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
git cherry-pick -x db2333f88729c8aae062cb171ed058725ff5c901
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090356-ramble-footing-c350@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db2333f88729c8aae062cb171ed058725ff5c901 Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Tue, 28 Jul 2026 21:14:41 +0800
Subject: [PATCH] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes

mcp_i2c_smbus_read() stores the caller-supplied buffer pointer in
mcp->rxbuf for the duration of a transfer but never clears it when the
transfer finishes or times out. Once the caller frees or reuses the
buffer, mcp->rxbuf becomes a dangling pointer. A delayed or spurious
MCP2221_I2C_GET_DATA report can then drive mcp2221_raw_event() to
memcpy device data into the freed memory, causing a write
use-after-free.

Route all return paths through a single exit point that clears
mcp->rxbuf and mcp->rxbuf_size, so that the existing !mcp->rxbuf guard
in the raw_event handler can reject any report arriving after the
transfer has ended.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 5c7fc56c7c67..9e03d1f733ff 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -343,7 +343,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
 	if (ret)
-		return ret;
+		goto out;
 
 	mcp->rxbuf_idx = 0;
 
@@ -365,7 +365,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 			} else {
 				usleep_range(980, 1000);
 				mcp_cancel_last_cmd(mcp);
-				return ret;
+				goto out;
 			}
 		} else {
 			retries = 0;
@@ -375,6 +375,10 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 	usleep_range(980, 1000);
 	ret = mcp_chk_last_cmd_status_free_bus(mcp);
 
+out:
+	mcp->rxbuf = NULL;
+	mcp->rxbuf_size = 0;
+
 	return ret;
 }
 

