Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A22F7EED
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416757; cv=none; b=J7gC0iVIyxaV/734tj07fibZpvs84cknnu1XUj6KGiFHnrBaUSDkxbme3KZMPP9ICjfMLEVT/7fdnRlw3pDOmd3PZ5AC73U2UHdaD3CiladcFefoGixzX1Y38YrtxSyli8J3VIg+1BW5VJsMC/TipwC3ajtL80dUne/6Xh3Jlqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416757; c=relaxed/simple;
	bh=EDn7lPcyz5No05rPAZ6B63rzdWT+9cO9q/D2vOMYvD0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=rQsI8BIMUR8yNhVNR350L8PArhlJFqR4OUKSocdUsN2h0fl1GKKyw6sleUnjEl5dO+8+x0s7ANSjad7Mt8QBY50R6c+2FN40VJFHtrI2lJNK2oAroIkMa0YjsUZwJEsMjEUCmWiv92BXK6XDBOBe0BOJnLGBxSQtt/IaRbHsBUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYnfTrv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYnfTrv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361261F000E9;
	Sun, 14 Jun 2026 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416755;
	bh=pONxs0l81RoTZu7YKfQ8Rjdl1dfk+RNIgZZEtuxW9dA=;
	h=Subject:To:From:Date;
	b=xYnfTrv7+kTnF0djBx6v8OicEuwitxZtqOf9M5cHlb0a5pElHhK56xAo7EZqMhhre
	 ePuEBv37oOqu3DCmq8TzS5oD+ks5w8prSnVBaxaspgXWMljlzHfS32cKStC0AtCCro
	 te0/0HaQMoqko35+8Zic+s8RF4/n/mAa0p/WyKl0=
Subject: patch "iio: backend: fix uninitialized data in debugfs" added to char-misc-testing
To: error27@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:23 +0200
Message-ID: <2026061423-unloader-hardwood-a0cb@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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


