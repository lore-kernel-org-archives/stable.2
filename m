Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362864;
	b=vJtzPYEJce5DjJxdcmPV5UQcBKGJYovSh3Xv5QR5j8pEQzWfNQn0DoYORLrXBnkIIdcx
	 oeofY7hzh9ISyeuIIFQVCnWjUo4RPQeYnUdr45ovzKarnKeX+WJwGBlAl0O1SVpm6PijD
	 gmqUrvpNQ9P3s4BaaTFc0unjou4/ybBe4zw3arXIyMBylwjgv8ZRzkQz7leBOpjY9gx9a
	 TRA0pPnvDtV4qdCojkpzy0AojgEYEvMr40vzBcf08JDqabGOYDZTZ8gFfH+oavRywSn0B
	 0O3q20RzfCzEeLKyMH4KPO3mgEN1ODEpgNKPNLz0KyC8UgTl+lnx7wHkTOtjeKg0PUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bqxCkV9WJyxvVgd7Hes3hNzceRrlZ+sSCAMGIQL6+OQ=;
	b=sKHhVRVHgJUxqMsAby/9jZpeJPyZCHnmPqORMp16ftQxBhM8jcI/Bke4h4LevPqpkK/I
	 Yb8UxPR5/P4ZLgStlLgnOxv5JRP93/7Hfwt0sSDRnrKpwujSATif3MLeWrVGnwQFSxZO1
	 HYulnjfDIbMx1I4wVVMhHJC3jVZRY8+vwbGEPqK+t66TGJCkmqAKrQuSkVBrmbXEkL7Ve
	 fU9MDLLQ3uyCdISJUWz0Laln402CGWhu+k6NSMiL9OMtr027xrm9ALSPDVP1+bI9EUGSp
	 k9DD2bdSndn7HxG2ARhxKYV9M3gTkytCn9OsfzffJLBmcWjnpaWGBbQfbdQenN+BBBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfvvyFhT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBDA606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfvvyFhT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96D71F0089F;
	Wed, 11 Nov 2026 02:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362864;
	bh=bqxCkV9WJyxvVgd7Hes3hNzceRrlZ+sSCAMGIQL6+OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfvvyFhTVmQfUPVjo2+VoiYvhOAC0rukhDn6pLIh2GQ1Orilupk3M9SlK+bDQpjnF
	 lyo/1GI/LpSo51ySdDLv8ODmk9RYzCoy8/4oaM8AwQO9lYpKFpDiae7PjTM0To1z60
	 080NDRcvV3nw8zwQLhbVB3MOR1pcwjnw1JmtH94eBfc0ojq8Si8fLctwXObqrSLjMq
	 70JoTC7PLSPcEgbcqz2QkBnUakNCZFkPv1S32Gn9MNy3uNeM1zLrTvlbuV+llGxQnm
	 b5zx7jQhnM/i5rwB8Y3dCiSN6QQzvYHo1buuelMMFkZ9OC+5lYUit6lyH6IEUUU1lK
	 qdloBQSUDA1XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] nvmem: rockchip-otp: Serialize reads
Date: Tue, 10 Nov 2026 21:07:41 -0500
Message-ID: <20261111020643.543837-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111020643.543837-1-sashal@kernel.org>
References: <20261107053315-failed-6.6-9fc6a1592d84@kernel.org>
 <20261111020643.543837-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Charkov <alchark@flipper.net>

[ Upstream commit 9fc6a1592d844c0397f115ee8cbd935169b9a71e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/rockchip-otp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index f5b7d3f6986b5..e5a24283ced76 100644
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
@@ -79,6 +80,8 @@ struct rockchip_otp {
 	void __iomem *base;
 	struct reset_control *rst;
 	const struct rockchip_data *data;
+	/* Serializes access to the OTP controller state machine */
+	struct mutex mutex;
 	struct clk_bulk_data clks[];
 };
 
@@ -239,16 +242,21 @@ static int rockchip_otp_read(void *context, unsigned int offset,
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
 
 	ret = otp->data->reg_read(context, offset, val, bytes);
 
 	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
+unlock:
+	mutex_unlock(&otp->mutex);
+
 	return ret;
 }
 
@@ -333,6 +341,11 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
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

