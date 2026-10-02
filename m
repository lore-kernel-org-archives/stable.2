Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09F481A82;
	Fri,  2 Oct 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936023; cv=none; b=XHRRVI16Ox3zHaRhTc2CDEm9MkAIMLsFEgqarercUnCXEZ/fR4VhK6Jp4+dmtyPu6gCNSOGz5+Ba6yP/ZhVTTXUHe3DKCE/uiZlGDJnh3W0FvzCKUMbEetIkJ9uGzH4DMAQU7KeV7tLwHfKM9yrvr9gNvRssDnC/hYcBw9Tnsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936023; c=relaxed/simple;
	bh=hmYWsK57NfBoyHZLdcrGegzBAKx916qJzJBdz2w3p2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz3PqJENKzk5tCFJP1QqvauhT7a6cub1R0TYFY3PsCVzE3gwK696TlMma9eRO9FdBHXi5t8ldhB/cXNal+es6gwdjTmxa1AmQO9Xhjj70dM6APYTyZXXwwMHikmeG5f2QLs4MeHFMNlFSEboBRHFtl9uc6g8ht2HYBXxMxKMe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkCrQ/RM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkCrQ/RM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66D51F0089A;
	Fri,  2 Oct 2026 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936022;
	bh=Txo2Fn8QnKjSdSRZHBpMWh0pPCWQj+eCSqwzLZ4boxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkCrQ/RMwORB9Gp8lAgCeGDqvC+jN/dp/indqsS7IeaZTTDGC/LxoyW01VxgrAVtb
	 VkPpjoyc098EyvOek6lRsXYnW25XvXSibwzsiFSAThpSpEVBFdNO1BdcnN75/AlMc0
	 IFn7qpQrOPKXcUeAkGpHMpXfq7eja2TaNQxR6INFh0TTKsxFBVwd6Aze4ZF3ZPxSFH
	 CmSvyf19dGx9Q+xNInDRi04MkPZ3D6WLnTfrsr9kOCrDswgHK0ACiw7ziUJmF5lFEy
	 CU0PQhC6DSBkmot4LQgKrWqoH43qDFuAS+G7QmOn6LkzIU+MR1MzRFhuKc5WUEW6m/
	 eHO2BJkUN8meA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Alexey Charkov <alchark@flipper.net>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/4] nvmem: rockchip-otp: Serialize reads
Date: Fri,  2 Oct 2026 11:13:26 +0100
Message-ID: <20261002101329.1084348-2-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002101329.1084348-1-srini@kernel.org>
References: <20261002101329.1084348-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Charkov <alchark@flipper.net>

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
---
 drivers/nvmem/rockchip-otp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 2c0feb036f3f..f8a8c7cece98 100644
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

