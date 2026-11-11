Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362016;
	b=2u9ak6dZLfNKiiWQNIzU94jY4my8cgWTrjLYRrwssRtr88wkOn3GdamHaL4XfNWgDDAC
	 DU16WB6MZnk9XQXlUbigRfwClvlUg4/R02RKs+j6FLXBFbeC/DvHXBp3B3UGL/pnOimZi
	 H/yvaA1bN7s+hjanuZP3vsX49rGwJt+cN4A8etZAA5hl3rYD03jW97SZWETeDp1lxFQCh
	 tOdLIevCRl703HAjExMkOnKk5oxrSzRfVy0PJHE7trSKAqQsc5rPA8OXb83KBwWWGHzje
	 Ai6cCOvs1iBFQjlerYGeKSklMmSJZAZEyDoYo2YvkLlz5jjZDjfpWowcrOFxDHiQISA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zpzItf2kgzY/FjTt6c/xJDArIXmL8uNaiPpWbKZVyaA=;
	b=Lw3NlVoneJKxoEVv9IL6VgqgJ6KfTF2vTFLoXwl5D1zVNc/NnfHl+ejma3XLqXdCz2F2
	 wbXIn7jLbx5okx7SdJvADFdhyylVGlk+KGBmgNaIULQL843P711z5GZWOrjagtlrJRYsL
	 76+08hC1WrWVG6PFA3Yi8EGwcItHg5qA1DTxjXol48FdSeWGhOC4FNNRzBzmMAMPJRqZ/
	 TqkouOK4wxX6gKgPX/Ie1nsqf30UeXtr12l4p36EjBv9kllvfYm/hXXkSSGj/eERVCQMA
	 GuMRgk4kdOT0JvEBA68XgdojxMrZjUW30g05sFK7s1TyX18csJMWp5uKr2voypBVcRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bM8gSkyF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F35606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bM8gSkyF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D5A1F0093D;
	Wed, 11 Nov 2026 01:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362016;
	bh=zpzItf2kgzY/FjTt6c/xJDArIXmL8uNaiPpWbKZVyaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bM8gSkyF5GCiiQqsiJaDXhdaYUB6Bki9rPTcyZYR4w4sSNETlCCa7ijtTBDF/4XET
	 nRG5X80SIr9ZDWZJN7W5+KZa9BjLiFxGAcQJXfspzyda0KW1rqQRqOjcjWncqMmeVP
	 rMhmqUFJS5FqNqNqk1p5+i5wmB6qEQppc4AZtXE4Ni5rjJgBILtuqwu5IoVIH/vAFB
	 UJGzZc0xBvFfI3vuSi/MXlapQGQOrymV/v1xHuj+s7eZetVVAf9mFINBHAerKPL/RX
	 OWS67A+HNs/c5Bwc2QAHT205v7qxvFGnIjn8d+KWJsFeQv22Wjql7O8zxI6nnskDCE
	 AfZPUZlFMQzeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] nvmem: rockchip-otp: Serialize reads
Date: Tue, 10 Nov 2026 20:53:34 -0500
Message-ID: <20261111015225.442438-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015225.442438-1-sashal@kernel.org>
References: <20261107050959-failed-6.18-9fc6a1592d84@kernel.org>
 <20261111015225.442438-1-sashal@kernel.org>
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

