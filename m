Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB124A078
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417135; cv=none; b=EFJKtDAtl44Dg7h83KicfdjcT4FJfGUDFC0qpe1kOrsvlrf5vtRwpZHJsadEtQaGI1TVd58n3/+Fp8ZE8qamy9Rq1ebVtn++DL2w9ya7/rsH1JfLRuOCw/0M7mfePgQru62TOC3ZaYvsivZ+vJJ4j/2O7Q3jGcvzjqvWGkQERts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417135; c=relaxed/simple;
	bh=QVYmwdsugJ62aVjfHqZFHvpHZrpDrdR8qHgsbzlNYLE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=u+Q2xk+CfaCI3LPfzNj2701CF6TIbHPKsdmVQVqvDv3RHaqhaghVAfoHe52D/5vYLaBLGFQX00DA4vIioaZL6Oe5Khcbfw9aaY/gGvPtSAaHIN8iIXcx2VnhNLVd9j6RTGv5tSX4yp+FD6y1SKT/wVZ5+z4yMjdjdKWIoFWuQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7Xcq8OT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7Xcq8OT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F4E1F000E9;
	Sun, 14 Jun 2026 06:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417134;
	bh=485u3how70igpme8XkfDRHPyVbZt0kMxi9uWUHp+6/E=;
	h=Subject:To:From:Date;
	b=t7Xcq8OTCM9bznsq6Hd28fYn9ns/A0NQnftPRuKX0pj3h0f40T6L1Ls/uCQPNlswL
	 IIE1RI4F5BIy2KFuFH6cREhCkLzEup1kzHhtx17pNpe1HsGtN7d8X2ONFlG0/+7hwW
	 By71ttjEJBnQ+KsgpWDx7hL8BLRrin6HU+bIbYlg=
Subject: patch "iio: core: fix uninitialized data in debugfs" added to char-misc-next
To: error27@gmail.com,Stable@vger.kernel.org,jic23@kernel.org,m32285159@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:39 +0200
Message-ID: <2026061438-submitter-usage-7ade@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: core: fix uninitialized data in debugfs

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From ab92ed206d41fd171ebd37bc46360d9f2140d043 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <error27@gmail.com>
Date: Mon, 25 May 2026 10:16:27 +0300
Subject: iio: core: fix uninitialized data in debugfs

If *ppos is non-zero then simple_write_to_buffer() will not initialize
the start of buf[].  Non zero values for *ppos aren't going to work
anyway.  Test for them at the start of the function and return -EINVAL.

Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer()")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..15b56f8972fc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -418,7 +418,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
-- 
2.54.0


