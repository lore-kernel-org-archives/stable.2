Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F041F5EE
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930066; cv=none; b=kA5FSnSyHgDtilwfSDgycKuxv4QeAOx8S/8rx04TBzp53scizCmP0h50oztvGfG6iRe8aPu3G1jg+1YJFui4JS69WseddoalPXtnIHPM2I239T/Mncjd2t39SHuieASUsOZw0CPqskZST9Pl1eXZ45Bw/f5dyK6BMkvBu5zM2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930066; c=relaxed/simple;
	bh=3MhKcuhiM7SmYrKl21n+jL/Q6iENlMVMYjkZdaYG+wU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aI7pMWxGgwE/SE90+K78X/NJUcYYrUWIkEBGeHTuyhyTctiOVynqfUGa4yHbGopJZ6iVuA0/o5QgpgQEvdwuSphEXpiFxT6sYsdseKQFc5oLApONvGiqNAubkmGVjZPRx3reXmARN++FSOBCzimTdMQnPfO1lL4weJ73/XtVEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T0dxmRNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T0dxmRNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BC91F000E9;
	Wed,  5 Aug 2026 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930065;
	bh=fIRrhSu5CEx9czZO3UfBh169/JgB+4/ZvulmNN0KRRc=;
	h=Subject:To:Cc:From:Date;
	b=T0dxmRNOYImSrGMdQUc1XFE/4eL0GwYgYuph6W933RyLTEzZbWvt+gJYFUkYRW2NZ
	 rQlRi+UK7NJgQGLZi5v/2g5/tQ2RWptlZtX+aHym6pg2p0/d6QjqfpSGYC9hQJSRSd
	 Gap5mppqKDXuFm+UO+JAwjzOwJJCqHPtAEyV1Pbw=
Subject: FAILED: patch "[PATCH] s390/dasd: Fix undersized format-check buffer" failed to apply to 5.10-stable tree
To: sth@linux.ibm.com,axboe@kernel.dk,hoeppner@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:40:38 +0200
Message-ID: <2026080538-ninetieth-paralyses-af1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7f40b346462f563a0d6e841a77b5163d2a882a04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080538-ninetieth-paralyses-af1d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f40b346462f563a0d6e841a77b5163d2a882a04 Mon Sep 17 00:00:00 2001
From: Stefan Haberland <sth@linux.ibm.com>
Date: Mon, 27 Jul 2026 16:28:40 +0200
Subject: [PATCH] s390/dasd: Fix undersized format-check buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fmt_buffer_size in dasd_eckd_check_device_format() is declared as
int, even though one of the multiplicands, sizeof(struct eckd_count),
is a size_t. The expression

    trkcount * rpt_max * sizeof(struct eckd_count)

is therefore correctly evaluated at 64-bit width, but the result is
silently truncated when it is stored back into the 32-bit
fmt_buffer_size variable. For a sufficiently large track range
(start_unit/stop_unit are caller-controlled) this truncation
yields a buffer size far smaller than the number of tracks actually
requested. kzalloc() then succeeds with an undersized allocation,
while the subsequent channel program build still operates on the
untruncated track count and writes past the end of that buffer.

Compute the buffer size with check_mul_overflow() and keep it in a
size_t, so that a value that no longer fits results in -EINVAL
instead of a silently truncated allocation size.

Fixes: 8fd575200db5 ("s390/dasd: Add new ioctl BIODASDCHECKFMT")
Cc: stable@vger.kernel.org #4.7
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://patch.msgid.link/20260727142840.567286-4-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 74fe73b5738a..d356a9f8f016 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/overflow.h>
 
 #include <asm/css_chars.h>
 #include <asm/machine.h>
@@ -3475,11 +3476,11 @@ static int dasd_eckd_check_device_format(struct dasd_device *base,
 {
 	struct dasd_eckd_private *private = base->private;
 	struct eckd_count *fmt_buffer;
-	struct irb irb;
+	size_t fmt_buffer_size;
+	unsigned int trkcount;
 	int rpt_max, rpt_exp;
-	int fmt_buffer_size;
+	struct irb irb;
 	int trk_per_cyl;
-	int trkcount;
 	int tpm = 0;
 	int rc;
 
@@ -3490,7 +3491,9 @@ static int dasd_eckd_check_device_format(struct dasd_device *base,
 	rpt_exp = recs_per_track(&private->rdc_data, 0, cdata->expect.blksize);
 
 	trkcount = cdata->expect.stop_unit - cdata->expect.start_unit + 1;
-	fmt_buffer_size = trkcount * rpt_max * sizeof(struct eckd_count);
+	if (check_mul_overflow(trkcount, rpt_max, &fmt_buffer_size) ||
+	    check_mul_overflow(fmt_buffer_size, sizeof(struct eckd_count), &fmt_buffer_size))
+		return -EINVAL;
 
 	fmt_buffer = kzalloc(fmt_buffer_size, GFP_KERNEL | GFP_DMA);
 	if (!fmt_buffer)

