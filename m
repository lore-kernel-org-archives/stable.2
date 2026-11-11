Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362360;
	b=T7QgJEc5uQyiHqsMR8tgyGNDdGV/AVtLI1jkyu4ej8BX2RTltBtx03wEtAGX58QIUK89
	 jhduY4fm6UnbGUSbx3og0Xo7Jmq6XT1rrcgHYnIiVB93LVjrQsJBDxvbS8yXs/k2dnRQe
	 OgkA127b8H8WoClA5lEILm6+ID5hS6+KWNUSW88qXhPT8EGHGez5ZSUKuEXTF9DSdmk5X
	 9Nwo/bOFZAKwfyc6rcNsAqr/rmvbUqhYl9Y79I8KCxkrOGGVgz2bx3moA64GvNTDLWGCm
	 kWtBrQtmR/ugMIv95XxtXbyPCPODEf3nvTebnWaZwJPur8Oe4ng9mlGi2kuy6sdWftA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zpzItf2kgzY/FjTt6c/xJDArIXmL8uNaiPpWbKZVyaA=;
	b=MkXLOQjCwQZPsoYiUzwPuf3idsFSRIGui9vkor0v5SLiAQeZYUj6gaspW9xHPtnwiLV7
	 R3aYXl1/TE9Y/QLIkw2nEkxryI0f/KcHqu95IuAOHVQDMsOK/lexnVc087u4H6qTURTx+
	 hzOKvkKDpAt8VFOd8s3R8gpDbCDUe37y44+56fX2zUUBUumSDuwNFE1hce26h2f86cqAO
	 G5Zqd5oziGYCaNVng/o+zhIayIMJA9clWtysLjccY/srG6y16cHrHZGrqyaB0nylskLDJ
	 2riTFjbW+XD4Yo2Rs/2ynlYWH0o2B01n9m8dA/HW9LT/5WnawaPdwR3g1uKON2hp6HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POlDZ7hh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36610606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POlDZ7hh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7831F0093C;
	Wed, 11 Nov 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362360;
	bh=zpzItf2kgzY/FjTt6c/xJDArIXmL8uNaiPpWbKZVyaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=POlDZ7hhbmd9/KQ7L67A1WjittdFjvnOCNbeI7rddMpz5oeG2VfMoH+4WnvfiMNeC
	 kFbaFo5Lwg74BTdyPaNAnsxHNzdVP4iJX5K7dJYi/7CZ6mGUkKz1xMMySL8aGKrPeW
	 veHn5S3eUsv6/M1wEdzKv/GcQbn3rH9jcqXAzJxB8WxynVkzTKlzakeg0ZpZbnDt/e
	 VGgLGYpWi6AovtKva/0J7U30NSE9HnfLuGyGePcLedHKfHY17I3HT145kxUhU4+Xg3
	 vhkyJn0K9/cs5xqBoO/+mVf1khqhDEy7pmkXZr0kHilzuJQeT2UVcoGiheCygwxpZv
	 rC4jmf95qdmeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] nvmem: rockchip-otp: Serialize reads
Date: Tue, 10 Nov 2026 20:59:17 -0500
Message-ID: <20261111015901.481553-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015901.481553-1-sashal@kernel.org>
References: <20261107052051-failed-6.12-9fc6a1592d84@kernel.org>
 <20261111015901.481553-1-sashal@kernel.org>
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
index 00921b9fe9aae..1475ce11a9c74 100644
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
 
@@ -334,6 +342,11 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
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

