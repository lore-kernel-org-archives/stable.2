Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594E2BEFEB
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417112; cv=none; b=D9Ma4Ehklt1BKhZKUoLXEor3lZrMBQz5pEGJzGIgMXEYvwIB3BCc297P5MszykesEyJUbIgNAPitz3m6W5xBuZCwAiepayhW1e/zD0Gwc5gV1Ldx+Xok2h4orlJuapUZa6Go8jT7OVl79nIWNzPRf92QRoFRwYiLzXf8pi9XJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417112; c=relaxed/simple;
	bh=KhoXUnFYVsJHrR59Q+vDRwpZMFMYZgBt67hADAonsH0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=newJztg+wuwzfELgnc41d6V+iMtaKNZSOnhRSM4f6+X5/TBOj9hKO5A0w8nhNJ5u9eHsB44R97L9ZFFuHe1OmclCXkQV9jWGZTHV2cYEtC+YGtDddapDL6RvpA5A4ITrh1Q22B9BbQYldg1KKswQxBU2py8wmsTdqbplH5UEMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jhpUckRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jhpUckRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1AA1F000E9;
	Sun, 14 Jun 2026 06:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417110;
	bh=OZMzdCmei0x2gTJ6UguMjFNyv9Gy/aTgrkPUD7LYvQo=;
	h=Subject:To:From:Date;
	b=jhpUckRHv9HIwnXY/28LhbY+MLcguzz6xYEj8iyg/DTQwshsGCItiqgotaD6k70Qm
	 BK8jGLU80JULdPhtZu0BY8nNtw/yJsxkOOjjrvxFgJb701PahR3slh0AZ4PN3YCGLd
	 lsQjSb0FgqqpHIvTmXI2AoEDEGxhfICtvhkXvyDo=
Subject: patch "iio: buffer: hw-consumer: free scan_mask on buffer release" added to char-misc-next
To: ustc.gu@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:36 +0200
Message-ID: <2026061436-coyness-clapping-d17a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: buffer: hw-consumer: free scan_mask on buffer release

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 6325d6e2204327965b849c0a16efb6ac9202e5a8 Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 27 Apr 2026 19:11:39 +0800
Subject: iio: buffer: hw-consumer: free scan_mask on buffer release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
hw-consumer: remove redundant scan_mask flexible array").

Before that change, the scan mask storage was embedded in struct
hw_consumer_buffer, so iio_hw_buf_release() could free the whole
allocation with a single kfree(hw_buf).

That commit moved the scan mask to a separate bitmap_zalloc() allocation
stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.

Free the scan mask in iio_hw_buf_release() before freeing the buffer
wrapper.

Fixes: 9a2e1233d38c ("iio: buffer: hw-consumer: remove redundant scan_mask flexible array")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 700528c9a0a4..10e912bbf0c5 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -40,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buffer)
 {
 	struct hw_consumer_buffer *hw_buf =
 		iio_buffer_to_hw_consumer_buffer(buffer);
+
+	bitmap_free(buffer->scan_mask);
 	kfree(hw_buf);
 }
 
-- 
2.54.0


