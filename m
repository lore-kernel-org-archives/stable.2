Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13F2877DE
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417102; cv=none; b=CWIa5oC8LoLiXlBZimSDiuU3DODW3DyUyUbwC1u/htDwdJDMsq+1eYR7KPN24Mq/ETWK6JXYqRQY56jSog8yHMSowOFQcUUlfAE+vybxkO1e/r0uixtjXl/wVXgkcH0K9ixNqJsztEeWka9n6Xz1CNQyK6N8f9HKr2NoV81ogp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417102; c=relaxed/simple;
	bh=I4dl6GE7mXAejfA/LZ7RtXKq9Qog+IuXav/DwNUfqXU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=HCSyCud0/hMXtBW1CG75vgKLe8b2+GKnlHOKHwXGWPvdqssnxvQae4BLEQxEdw1CjCbY5OIcTmuQ3WsaHeTrwqLM0jAnGNX6/OOUgvtcbh34mwTlkcqMbwT9VNTpYgncGSs0TOQnzthhtTeYlA4TGfgfiXMBc31VrevRl04KHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=twNh3K1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="twNh3K1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E361F000E9;
	Sun, 14 Jun 2026 06:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417101;
	bh=hpqMshzNyFCtZPHKxkABfnlGtGFkpjnH27DzEx7L2ds=;
	h=Subject:To:From:Date;
	b=twNh3K1KUciIe3oU0tDDECCn7gt6VecCARQOAMmdQGTp/BkbIO5EqSe0ycCRjfhgC
	 WXzx0NaxG3MGUz4yCRYVVi+xfDjHqC8Hxd5hcBj7yiiZhF8Sm8mbAUpQnlMVU6OA+m
	 xEBqRzs17sUGeZ4JEAapz87QOSLxd6WMGyhxwN2g=
Subject: patch "iio: resolver: ad2s1210: notify trigger and clear state on fault read" added to char-misc-next
To: sozdayvek@gmail.com,Stable@vger.kernel.org,dlechner@baylibre.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:34 +0200
Message-ID: <2026061433-creation-parish-67bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: resolver: ad2s1210: notify trigger and clear state on fault read

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 70247658d0e783c93b48fcbc3b81d99e992ff478 Mon Sep 17 00:00:00 2001
From: Stepan Ionichev <sozdayvek@gmail.com>
Date: Fri, 15 May 2026 18:31:38 +0500
Subject: iio: resolver: ad2s1210: notify trigger and clear state on fault read
 error

ad2s1210_trigger_handler() walks several scan-mask branches and uses
"goto error_ret" to land on the iio_trigger_notify_done() teardown at
the bottom of the function for every I/O error -- except the
MOD_CONFIG fault-register read, which uses a bare "return ret":

	if (st->fixed_mode == MOD_CONFIG) {
		unsigned int reg_val;

		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
		if (ret < 0)
			return ret;
		...
	}

Two problems on that path:

  - the handler returns a negative errno where the prototype expects
    an irqreturn_t (IRQ_HANDLED / IRQ_NONE), so the caller in the
    IIO core sees a value outside the enum;
  - iio_trigger_notify_done() is skipped, leaving the trigger
    busy-flag set. A single transient SPI/regmap error on the fault
    read then wedges the trigger so subsequent samples are dropped
    until the consumer is detached.

Convert the error path to "goto error_ret" so the failure path goes
through the same notify_done() teardown as every other error in the
handler.

Fixes: f9b9ff95be8c ("iio: resolver: ad2s1210: add support for adi,fixed-mode")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 774728c804c0..1be19fe8aa3f 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1334,7 +1334,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 
 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
 		if (ret < 0)
-			return ret;
+			goto error_ret;
 
 		st->sample.fault = reg_val;
 	}
-- 
2.54.0


