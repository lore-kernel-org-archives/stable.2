Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A64B148F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443671; cv=none; b=fntDZjJMSle/Sgmb2ZfB6cbvTcphnSaQm57EswaekMBbP7JnLPL6bwMZSXlhsRCphu3tjxhFCzI1M2gIy6mzkr6HmiKJ09AwD2ZJa+imMqHzFkagEFIV5+CkCI0qWKDOYorOB6Z0H1RiK6cd6LAO2gSiUieopCqoqoiNGgTRSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443671; c=relaxed/simple;
	bh=bZCDTeNKJZ8Vkj0Mqe5aDEmiWAjHf9J78MBOcVsOEbY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j+LlgV7exVue8gvLep63Ec+fVZGnmP95aG7gWsBEbHQMV4jfDgBgKLZh/BC4KaRx5d9TEUMHOJ0AEknDyrB/sDUdHyLQFXvwg2t66kgOYkE874vU5tcM/lvve61Ymtak1P/DvP52vTPXWZ2y2NUfsMwiVyGoVm2rLXG2Y344cXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZNkrd6Z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZNkrd6Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D901F000E9;
	Thu,  3 Sep 2026 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443659;
	bh=JSPobfohGpqXpT3G71j2C9exDkA84QzROZiueWvK3Ho=;
	h=Subject:To:Cc:From:Date;
	b=ZNkrd6Z9xN+sb868iXf/NKPLgpFW4rYJSY0zQ9YFSYmffJKwQz7grJzMax2eF7A5L
	 B7uxZjjd5hyx8NnR1qN//H4OlZAEW9ucsqu/O9io47ArSlGaQbL9qOl+neKDSuf80N
	 15f7rT/ptHYa4FETz2PSN2Y6TZlTNIh5pJ9orcEc=
Subject: FAILED: patch "[PATCH] HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes" failed to apply to 5.10-stable tree
To: yijiangshan@kylinos.cn,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:36:58 +0200
Message-ID: <2026090358-twisting-kangaroo-3039@gregkh>
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
git cherry-pick -x db2333f88729c8aae062cb171ed058725ff5c901
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090358-twisting-kangaroo-3039@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

