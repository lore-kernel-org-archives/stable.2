Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9E466B00
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766501; cv=none; b=XzYq8ZBEDbVvVZdIlFUNzvOgveijf08escHRgcA1iaZxSeN/EI5XgGTzOWyYIl8xxI/68t73zClMrArhDLqTCqjqvdn6qPqXFlRgqPlmvaaB7JmQRBCryeNJ+lCtBP84S8CnR3iRUKIpLr34w3lWtv+bkmIUodTUHkAr1jE1FS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766501; c=relaxed/simple;
	bh=N4+yKr4auqjEJsxKvIE7c7peGPATWqfKsrNx8qFx/W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV7nvdG5KzvNF4yDM2IoprOmPc8RGkunCSDljNrHrYdmiw1V+qoBZT1DzAfxydyrWMHdsAUJrKxwPgbyqonUrjsKwFoFb9vm+AQh/lsiE/kTrnOsOJgBtupk+rIDdgHT2ECx1LjFSzz7N4bNKnRij1uNcXnYSTXKHYkg+v8rjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axMfGg4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axMfGg4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEA51F000E9;
	Wed, 26 Aug 2026 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766490;
	bh=rE+8iL4lHr+JKkuSZJk2gTEKTXF+d11ZfVdUUKpSS+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=axMfGg4VREp9+XeUYkWkzPpb4YwYYuN1m34+jInLIAl1eHLLmZDIKk7vhD9gTuDuY
	 moQ9yAusv7UH3iPZbPl/ZBk3Ij83j1iGPoY6rnPE7cRdl/PYxlzsLfDHYWQhN4+HAi
	 nvn2V1ujM2A2OM6RWjLjcXXvepncdsNaQIHcFKkI6oGz1N5peX1gzISG1PcByl6/Xo
	 6eey0h63JohBRVOIu95z+lF+0CI8Afce6//I2SVD74yt+1oPlQAu/XYheztwVyvisw
	 UJrBWumhtSg0oc41zcYqX6bK4g4CJROrhR2WZRk2D4ehENrm95KqqtqPCph3Zmdk7J
	 YJ6LTMQaXbCNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Guillaume Champagne <champagne.guillaume.c@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/7] HID: ft260: improve i2c write performance
Date: Wed, 26 Aug 2026 13:48:02 -0400
Message-ID: <20260826174808.2489782-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082538-overhaul-surging-7a4a@gregkh>
References: <2026082538-overhaul-surging-7a4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Zaidman <michael.zaidman@gmail.com>

[ Upstream commit 6fca5e3f5574ca1bd5bade5737848c816f924c6a ]

The patch improves the I2C write performance by 20 - 30 percent by
revising the sleep time in the ft260_hid_output_report_check_status()
in the following ways:

1. Reduce the wait time and start to poll earlier.

Sending a large amount of data at a low I2C clock rate saturates the
internal FT260 buffer and causes hiccups in status readiness, as shown
below in the log fragment. Aligning the status check wait time to the
worst case significantly reduces the write performance.

[Oct22 10:28] ft260_i2c_write: rep 0xd8 addr 0x51 off 0 len 34 d[0] 0x0
[  +0.005296] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.013460] ft260_i2c_write: rep 0xd8 addr 0x51 off 0 len 34 d[0] 0x0
[  +0.003244] ft260_hid_output_report_check_status: wait 1920 usec, len 38
[  +0.000190] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.015324] ft260_i2c_write: rep 0xd8 addr 0x51 off 0 len 34 d[0] 0x0
[  +0.003491] ft260_hid_output_report_check_status: wait 1920 usec, len 38
[  +0.000202] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.016047] ft260_i2c_write: rep 0xd8 addr 0x51 off 0 len 34 d[0] 0x0
[  +0.002768] ft260_hid_output_report_check_status: wait 1920 usec, len 38
[  +0.000150] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.011389] ft260_i2c_write: rep 0xd8 addr 0x51 off 0 len 34 d[0] 0x0
[  +0.003467] ft260_hid_output_report_check_status: wait 1920 usec, len 38
[  +0.000191] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000172] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000131] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000241] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000233] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000190] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000196] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.011314] ft260_i2c_write: rep 0xd8 addr 0x51 off 0 len 34 d[0] 0x0
[  +0.003334] ft260_hid_output_report_check_status: wait 1920 usec, len 38
[  +0.000227] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000204] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000198] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000147] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.011060] ft260_i2c_write: rep 0xd8 addr 0x51 off 0 len 34 d[0] 0x0

  Before:
    $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      40510           80             256           8           32

  After:
    $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      52584           80             256           8           32

2. Do not sleep if the estimated I2C transfer time is below 2 ms since
   the first xfer status query frequently takes around 1.5 ms, and the
   following status queries take about 200us on average. So we usually
   return from the routine after the first 1 - 3 status checks.

[Oct22 11:14] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 d[0] 0x0
[  +0.004270] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.013889] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 d[0] 0x0
[  +0.000856] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000138] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.013352] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 d[0] 0x0
[  +0.001501] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000177] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.014477] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 d[0] 0x0
[  +0.001377] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000233] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000191] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.013197] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 d[0] 0x0

  Before:
    $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      28826           73             256           16          16

  After:
    $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S

      Fill block with increment via i2ctransfer by chunks
      -------------------------------------------------------------------
      data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
      -------------------------------------------------------------------
      45138           73             256           16          16

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: bf3e39df3a39 ("HID: ft260: fix stack-use-after-return write in I2C read race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 79505c64dbfe7..539d311bb9b9d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -355,7 +355,7 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 						u8 *data, int len)
 {
-	int ret, usec, try = 3;
+	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
 
 	ret = ft260_hid_output_report(hdev, data, len);
@@ -366,10 +366,14 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		return ret;
 	}
 
-	/* transfer time = 1 / clock(KHz) * 10 bits * bytes */
-	usec = 10000 / dev->clock * len;
-	usleep_range(usec, usec + 100);
-	ft260_dbg("wait %d usec, len %d\n", usec, len);
+	/* transfer time = 1 / clock(KHz) * 9 bits * bytes */
+	usec = len * 9000 / dev->clock;
+	if (usec > 2000) {
+		usec -= 1500;
+		usleep_range(usec, usec + 100);
+		ft260_dbg("wait %d usec, len %d\n", usec, len);
+	}
+
 	do {
 		ret = ft260_xfer_status(dev);
 		if (ret != -EAGAIN)
-- 
2.53.0

