Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A524A078
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417125; cv=none; b=IdK1GVLEWHECYAYvHDzXv0XyncSMF/t3L075TMqCLooI4YxqTGxwBGzfcqWi/SQVAhquuaorMC+hpyHyDFLpYF1JNrEVaIFsycnoLptHQBbdCV5P+askwQZ8qhR+Jo6bw+dQ9xT8IS8LCxpvfGg7DzFbsg6qNoChpOgZaprUB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417125; c=relaxed/simple;
	bh=00Z37e9//bTa/nsa9vjJIuAcas3MswZVGinqWp4cdAs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Vpgsa1pPDL91Xsv+2fhs67IyPtgZHAc4SR3Q1CQCMOYGNpS+N5CedD7lS/zDSNH82cV70XvA0J+oWAAHoZXo/lwNjunSH89TIyliv9wuhu0X4ZE5ka7IfzDLrpZP6kav/AYpC7dSsNsI10N+7U0KZuW6nt7GSJIYGxV/9KLgBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uP4jbel6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uP4jbel6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8595E1F000E9;
	Sun, 14 Jun 2026 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417124;
	bh=96U990QXN1C7BhBkHCddDqPJbdI2eEmgZ1wvax3eGeQ=;
	h=Subject:To:From:Date;
	b=uP4jbel6X5dhUMzbxkgkvujZtx9U3Hf/EgBvu0oUB7ilU0HsnD8BysQwXEJGV83q0
	 1mOrosclF0gW9Y5yAz67y0atgW6hx9UmFRNRSOkR9q3LSmSbpa897jIqkpb3N/uQVk
	 dCcJipdqzoyJG6+hKqlnSGpVvPTyBAgV31qXjWT0=
Subject: patch "iio: backend: fix uninitialized data in debugfs" added to char-misc-next
To: error27@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:38 +0200
Message-ID: <2026061438-overbid-tipper-160e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: backend: fix uninitialized data in debugfs

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From a6e8b14a4897d0b6df9744f33d0a30e6b92368eb Mon Sep 17 00:00:00 2001
From: Dan Carpenter <error27@gmail.com>
Date: Mon, 25 May 2026 10:16:11 +0300
Subject: iio: backend: fix uninitialized data in debugfs

If the *ppos value is non-zero then simple_write_to_buffer() will not
initialize the start of the buf[] buffer.  Non-zero ppos values aren't
going to work at all.  Check for that at the start of the function and
return -ENOSPC.

Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 10e689f49441..cd697fbeae47 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -156,7 +156,7 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -ENOSPC;
 
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
-- 
2.54.0


