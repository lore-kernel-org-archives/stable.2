Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78647042C
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766504; cv=none; b=rQSRmX3W2Wf5qiD5l8AsjPHQBUf2AIDPrLlKw6Djtu54i+emOv1Wl4ppZlASoqPpHt2IKnhF3YllQ94JUroTaTtih1vS/52wP9NVsT+AI6ssmp/62SaJCuTMzkKhA7ijggwInLNzSPMdX2A3kZjAVUl1fw52A8pKcuzIG6Sgg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766504; c=relaxed/simple;
	bh=2UMFA1CfdBdsczLSK9sjfVZ/0wyGD4ZTPzwpEX0r8Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/JjbTs5gPO0ijgHG1fvcHdqepNkbhXDnDYFqH5x63mVqs1mfj9L6by5Q0pKOkrqX69QiSo69zpFPFfvJxXWbfqWzEoQ+ZarFhVK/uYH73UulNUlJIkF3nzIAK7q1jrJpEj8clfa/p7tb5KaEdh7kRch7llKbS5jsmo2dcmaYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkdLWwXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkdLWwXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA261F00A3D;
	Wed, 26 Aug 2026 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766491;
	bh=5CbsEqmDirjdFSbzKTJdU9APnp9lJ0Y2huDNp8OmpM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FkdLWwXOpRoaXyPC4zFcrFOULO47oadPeJkwmbjmABOVVGVJZV7/UmVbrFWBx1SYb
	 QQSuSznOuHWt8z97O56L3y+dWfhktnjI4uQXmBKp97hBNVSKtUg0CS5PivMGF/531E
	 hQAiIkAemf7fuvOl/vpxuGIC+c55PWCUo7E3hKI8LRxhCS5mxuKRhJfruAF9fw6TB8
	 jkaQfopAD+leYxW92dCZOWh/+2YVb8mqgRWOkLB1WCr6wQoz5YDEOnDMrMnjuYzD1/
	 Uvjm3q3K87BGMo1wjX34jSss2yvFe/7KfXxwQP4Y7yZTnYeNh2Z8B1bXQVWcaZGB9C
	 TCTIHw8SR3q1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Enrik Berkhan <Enrik.Berkhan@inka.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/7] HID: ft260: improve i2c large reads performance
Date: Wed, 26 Aug 2026 13:48:03 -0400
Message-ID: <20260826174808.2489782-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174808.2489782-1-sashal@kernel.org>
References: <2026082538-overhaul-surging-7a4a@gregkh>
 <20260826174808.2489782-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Zaidman <michael.zaidman@gmail.com>

[ Upstream commit 54410c14800ad652c77e5c6fc5c17baad6e42cb6 ]

The patch increases the read buffer size to 180 bytes. It reduces
the number of ft260_i2c_read() calls by three, improving the big
reads performance.

$ sudo i2ctransfer -y -f 13 w2@0x51 0x0 0x0 r180

Before:

[  +4.071878] ft260_i2c_write_read: off 0x0 rlen 180 wlen 2
[  +0.000005] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.001097] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000175] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000004] ft260_i2c_read: rep 0xc2 addr 0x51 len 180 rlen 60 flag 0x3
[  +0.008579] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000208] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 120 rlen 60 flag 0x0
[  +0.008794] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000181] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_read: rep 0xc2 addr 0x51 len 60 rlen 60 flag 0x4
[  +0.008817] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000223] ft260_xfer_status: bus_status 0x20, clock 100

After:

[ +11.611642] ft260_i2c_write_read: off 0x0 rlen 180 wlen 2
[  +0.000005] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
[  +0.008001] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 180 rlen 180 flag 0x7
[  +0.008994] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.007987] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.007992] ft260_raw_event: i2c resp: rep 0xde len 60
[  +0.000206] ft260_xfer_status: bus_status 0x20, clock 100

Suggested-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: bf3e39df3a39 ("HID: ft260: fix stack-use-after-return write in I2C read race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 539d311bb9b9d..854876b16880d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -30,12 +30,19 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_REPORT_MAX_LENGTH (64)
 #define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
+
 /*
- * The input report format assigns 62 bytes for the data payload, but ft260
- * returns 60 and 2 in two separate transactions. To minimize transfer time
- * in reading chunks mode, set the maximum read payload length to 60 bytes.
- */
-#define FT260_RD_DATA_MAX (60)
+ * The ft260 input report format defines 62 bytes for the data payload, but
+ * when requested 62 bytes, the controller returns 60 and 2 in separate input
+ * reports. To achieve better performance with the multi-report read data
+ * transfers, we set the maximum read payload length to a multiple of 60.
+ * With a 100 kHz I2C clock, one 240 bytes read takes about 1/27 second,
+ * which is excessive; On the other hand, some higher layer drivers like at24
+ * or optoe limit the i2c reads to 128 bytes. To not block other drivers out
+ * of I2C for potentially troublesome amounts of time, we select the maximum
+ * read payload length to be 180 bytes.
+*/
+#define FT260_RD_DATA_MAX (180)
 #define FT260_WR_DATA_MAX (60)
 
 /*
-- 
2.53.0

