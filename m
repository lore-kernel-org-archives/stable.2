Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046853;
	b=s/0ePvhM9pYHXYhqdAaenDWnqZ/BMK+gIjX9urhdloC6cpa8lzqzq1ShKjR4AjwwHgY1
	 bM8RfGJ+BpMUzF9dUNNzJrZROw/f4wSyCJKlI2ZbwqjwwQC7DUjH8ixvnynLnKezKFIdx
	 J95Mq93KTVJv0XSzblFUPv76tRKFwoJ+9FQn2Pulv/U9++MNy36wBZffFcvf+ykwlNGBk
	 PMw71fCl0KAOt4mBkK6GrUfg9cgLU1HyuYEPp+OZ/N2OGQzHD7WW2WLX1KcRSrXuhcnpm
	 UHPRipiVZDEVpEzctIX3eaeRCSvsW2T8deWMACr1W/RU7+LvFhB27HJPDOxtcO0SQOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JfV+KLaZ5+NSWQ6PmMirVeX+xKwf3MSITu65s6C+hh0=;
	b=VUoLgvqZyYr/xXaqmYYlMqzSn200CpdQsWE65zLKCS8G4doIvVV8+oReKwwfzOBHwUbZ
	 DP6yNnvH/mlpZNskUENqXlHTDufkkgNXKMiPAWjPKJhODGeBsKWGTEq1mAO5wuy6giImo
	 +x6KbLP/jw4OwF7dix4dA2zCyPdTfJ3DvCAvkF1dzhAQbYAySaaNtXVGJovGUvCZW1P1M
	 /rXtZCtEw4becFTcbH3lFK0yRyg2uP/tsSuhqz+d9pFd2yGbPRz1T5uC6YO+jHyFv7lbE
	 lJ/uQyZh0BRnSM/7rvhi9dNMxgBEnhEWvQPHDBA7Hc2VYfvpysESF6tXweWRDseIZ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNA8fV9i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB3606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNA8fV9i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8B31F0089F;
	Sat,  7 Nov 2026 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046853;
	bh=JfV+KLaZ5+NSWQ6PmMirVeX+xKwf3MSITu65s6C+hh0=;
	h=From:To:Cc:Subject:Date;
	b=DNA8fV9idh5lrSjx8esLotj8MAIvQWumEpA0TVTWG3wjva7PFjkZO5oZid1AMNB3/
	 Wo8h+FlPyhQAgS66HC6t0jKRInWROdDNl34BR3NQ1G9l3B+Fzl/1A2K207jRGGlS7J
	 11O1Epw6YaeHockhq2scnbTsiSOMUzcL5xmmKNyLtZ70qkwiTmXvD4U6loKzT7C5Qc
	 h/vK408fBqMExhVm59uAvIV17cMCeBtdNiyzIakEUyVsbm2uo/LJChqfcAosq04+Qh
	 2ZbzDMc+epyBN47ZNSYiyC24HuilbL/C8RFC2klNDhXkf+MDFusP/85Btc3U3J8BAN
	 dABoY+pBORGsw==
From: Sasha Levin <sashal@kernel.org>
To: alchark@flipper.net,
	miquel.raynal@bootlin.com,
	srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmem: rockchip-otp: Serialize reads" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:51 -0500
Message-ID: <20261107052051-failed-6.12-9fc6a1592d84@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9fc6a1592d844c0397f115ee8cbd935169b9a71e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052051-failed-6.12-9fc6a1592d84@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9fc6a1592d844c0397f115ee8cbd935169b9a71e Mon Sep 17 00:00:00 2001
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 2 Oct 2026 11:13:26 +0100
Subject: [PATCH] nvmem: rockchip-otp: Serialize reads

The OTP controller is driven through a single set of registers holding a
state machine which has to be stepped through for every word read, yet
nothing keeps two readers out of each other's way. Concurrent reads
interleave, and the outcome is either a reader bailing out:

  rockchip-otp 2a580000.otp: timeout during read setup

or, worse, one of them silently taking delivery of the other's data.

Reading two cells in parallel from userspace on RK3576 reproduces both
within 150 iterations - 53 read errors and 9 corrupted results, the latter
either losing their first word or, in one case, ending in the two bytes
which belong to the other reader's cell - whereas the same reads issued
sequentially never fail. Concurrency is not hypothetical here, as six
thermal sensors source their trim values from the OTP and reach the driver
straight from asynchronous driver probing.

Guard the read path with a mutex. Reads are the only way into the hardware,
as the driver registers no write callback, and they always run in process
context, so a plain mutex spanning the whole clock-enable, read,
clock-disable sequence is enough.

Fixes: 755864feb729 ("nvmem: add Rockchip OTP driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20261002101329.1084348-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/rockchip-otp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 2c0feb036f3fd..f8a8c7cece98d 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/nvmem-provider.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -80,6 +81,8 @@ struct rockchip_otp {
 	void __iomem *base;
 	struct reset_control *rst;
 	const struct rockchip_data *data;
+	/* Serializes access to the OTP controller state machine */
+	struct mutex mutex;
 	struct clk_bulk_data clks[];
 };
 
@@ -272,10 +275,12 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 	if (!otp->data || !otp->data->reg_read)
 		return -EINVAL;
 
+	mutex_lock(&otp->mutex);
+
 	ret = clk_bulk_prepare_enable(otp->data->num_clks, otp->clks);
 	if (ret < 0) {
 		dev_err(otp->dev, "failed to prepare/enable clks\n");
-		return ret;
+		goto unlock;
 	}
 
 	offset += otp->data->read_offset;
@@ -308,6 +313,9 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 err:
 	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
+unlock:
+	mutex_unlock(&otp->mutex);
+
 	return ret;
 }
 
@@ -431,6 +439,11 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
 	otp->data = data;
 	otp->dev = dev;
+
+	ret = devm_mutex_init(dev, &otp->mutex);
+	if (ret)
+		return ret;
+
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return dev_err_probe(dev, PTR_ERR(otp->base),
-- 
2.53.0




