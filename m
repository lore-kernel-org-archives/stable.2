Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC8247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416766; cv=none; b=EBZ+WvueaEmrWTw8FBcw/pftzuLEo1tM9+FCzDmYJpZ1wYn4ikMuA9Rz9uXSvkOZ9/lLrtZuM8ljyYq+/N7h8IOKiR//x5h48czYl2uwEByaBgBV7JbRUfsoUUVg4EmBpnjHkF4FAsWXPT6sweyru38mQxpxLhaZp8oFLDz8Sr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416766; c=relaxed/simple;
	bh=zdNdT722tXhAhvIXGchYWzRfK3+XBQp8bgv5ajFl8jc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=SKLqPcyTaGb3VtNp9pQWsh9mXCLILRwfWXLYR9nFubN0wQ0+imJ4JUyygqjvcHVmGghaQaSD37Cm9P/Y0bqOpl+yzAfENIOk6O55jTpkaF5MgZLpmJPH3zSOy9JeecXtZtjLH0D3szBpJdSbYgGkDTVGO2mXCCnDRhSFM19Q97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBiEQn+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBiEQn+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE2E1F000E9;
	Sun, 14 Jun 2026 05:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416765;
	bh=gB/DH/FLl0YknYRNHcgZdpuQt/aJjnEFyIY9PdBrGvA=;
	h=Subject:To:From:Date;
	b=mBiEQn+JzBp1ZOGQHhKVVEw/eubdrnsisRX/2Z2NmlYdD7QbFmiledPrA4IQIRUXp
	 Adn6Rru1jBGkq4OoJah4bkNty0lKGOD2IApk5Y2xMBYqMN07rQN+19pgmVCRSEnsl4
	 bgmmZNb7Ua7paDmWuiqhUYW6hVYRWg7/DcOX3leY=
Subject: patch "iio: core: fix uninitialized data in debugfs" added to char-misc-testing
To: error27@gmail.com,Stable@vger.kernel.org,jic23@kernel.org,m32285159@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:24 +0200
Message-ID: <2026061424-upcountry-thirty-c0ab@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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


