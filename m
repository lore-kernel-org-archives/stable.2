Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283149C4CA
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354492; cv=none; b=NBdfCMlVJK6vLuksxy0xS3mrSGNPNax1ZlE7OkPOm46E0zGDLT/O2wkhtnSVR4YhXYWDT+GePERAmHLlxB9oWI8MkrkNsNuG/vx3nPaDvKibisGY5AlcZ/AwFRPqOerR/gGrO29toAFrrIGWytqeFYeEkT0Cc/9YM06+uU4hVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354492; c=relaxed/simple;
	bh=qiqsPxlbHv2Ud+rite1LTKKz01hObwxA2+aJF+2hat8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVcUJ5d3N7v211/S49DMCfOMlBdG7bjkXuW4h7k2f0JqoSEUM2AVmMGnFjdLRPraZMBULgmkLRPU1uFXyPVc7P3KFm3dtuBbCVUm0uwrBj21c09zSLXhYVh+FNhvOqAsFlIKjoz8bDTe0rvXjwq9JY0wlAarKKJSy8rRD3/oUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=RsEl1eKh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="RsEl1eKh"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482fc3327fdso717533f8f.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788354488; x=1788959288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aijYbYyh0GYERanA0MNAQuC04tkRJrLzY82fVV+zmsc=;
        b=RsEl1eKhQ+HhSOFTNY3ZgX9PNS6aiL/YuSS6mecYlrejhlj2jsOqIGd/2oAnQCAsfH
         wCA9gVnsrWmXcFmXjxYiGbk487MsJrDfSWxAjy+MwZFDucYifNBFLYtLZG9Us6FvC8h9
         Rpd59d3A/lHc66IbtW+KDOSjboXfJsIY2vjtdJQP7pt3SyJ0SBoPdXL/QY5uIh5NHxd/
         SEp0L4YjKArdoGczGOGjgtPgwg0rWUUX47ezTWIMElWuRItwpsgiohNqRrxyoR2XYCpF
         fMRExlXhpByzlGx6x2wG9pgz5qwdSU1b+M9BWvVv8uBSW2/H6pqsDn/tKBSPROwUlbCe
         BYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354488; x=1788959288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aijYbYyh0GYERanA0MNAQuC04tkRJrLzY82fVV+zmsc=;
        b=GyQCYQ8Cmo23FT7Ve6jX/UfaFWGd9jfg6W56Q+T4ozr65eAgx/QF8fcWCjGxeqc+QN
         3GDTugnJx2K2EceNwsbB3Xmyu/9NRaEK5cnWU5KGbE6mEeXpO8WO7ijeOUPUjtUb8eQC
         1IiWmYBihbyyA0WW4eUPdEPylrcILEfChS2gZ6b/mhQZ+CC4gKOXogpMcv5GBlwvO5Mr
         r2/tYdLMGYARClQdJ1vquKweTTWeq3jnM1G8g6PQQJBq4dRpgwfq+wP86YH4GV6dS9wz
         4wwYFz8+5HevbpOMFGvqZoCYKb5LkDMxFTGlDVQGmIkqrBXlXr26IytLvwnEwapxlheW
         ObmQ==
X-Forwarded-Encrypted: i=1; AKwUvBziIdtOQyyhV2/8ChLJzyvoHFqqanmlnAh1OCkpaJt1p0Jh6h/8R/EEkYtF3L6pLyL4vAkspZI=@vger.kernel.org
X-Gm-Message-State: AFuF++kRhDDnA1L848ffbfXZ2FAbkqp8ljvlWzi1WcAmV16In7/U/YHo
	iCY8TAervKRnlVuYCw/lyjXLouEyVhPTrAMoanapCyH7ZeNI87lZIKvW4miHK4wmbcW3IhXNsft
	UiZp2gBc=
X-Gm-Gg: AYBFou1unotJUFby3VIPH55flL1Hi/xR98qqeEeWVkAJoB+yHzEO5udct9LZWO0DD9v
	VFwuqz+dC7W94puol4Kdnia3/K9SZQQfOLzIt4aatxpo2xFitKCRZFgslUolEFrTekr9NNXfRlk
	5xzDEtQn0pfzbIRfbX8qBN1bTc8btL6LybRfmBPRcFWmzwhh7u1YpCqLNTB5/1sgNYMbKxgb631
	tFIbh2dbKbMZInvRckXwc4fRXKf1pAGy0mX0l9pXGnr/SDySEbO98UEPLancHjaLKadvcbT0PHa
	lrOtqM+PwOv8S0NezRIRqjBEF1vw3jhlqdb3Cw3ah+onD1nxJTrqQzYmPwU7Yyz4VhXvaPJAnKt
	Hb6LOGp3jGO1nOcdcmrJqlVGSrMEGZNXCYNWOiJaw3yydD4UwWI4bMVQcn3fSc/KdsKjscHHg+f
	FCFoHhRjqfmyOfKS4H2J2GV14Qjy2c3vO45W+32n253rgMHJrphWAy25Gf2lykVef9ZDdOaNDtJ
	qMOVQhVMOZqLrzK63IaIo5lM7Q8Qc7xwy4Z5nSDjA==
X-Received: by 2002:a05:6000:4913:b0:47f:90df:4ec6 with SMTP id ffacd0b85a97d-48488deed8cmr9806707f8f.6.1788354488335;
        Wed, 02 Sep 2026 06:08:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72b5bsm6385800f8f.4.2026.09.02.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:08:06 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 02 Sep 2026 17:07:52 +0400
Subject: [PATCH v2 1/4] nvmem: rockchip-otp: Serialize reads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-rk3576-otp-cpuid-mac-v2-1-e4b7fe2ab13f@flipper.net>
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
In-Reply-To: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090; i=alchark@flipper.net;
 h=from:subject:message-id; bh=qiqsPxlbHv2Ud+rite1LTKKz01hObwxA2+aJF+2hat8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNkN8s8+inzp11M5ymXJWy4XpYf/i/8cxf1m5/mQXsh
 aRs1jIrdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVE2cxMmzmnWlzfMcxzYX7rp1SnBL6gWnV0bVu6Yzf/5yOzFGoZLFkZFjpfeI
 Uf5NNt0u8iMEtAZGLW++d6WzISLG1divjZuR4xgQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

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
2.54.0

