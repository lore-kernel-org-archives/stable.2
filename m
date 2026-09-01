Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399A3B14CD
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276837; cv=none; b=P1278dMzP/FEstWV4/D2IbDUTeWRRGOd1YjymA78x2C+NJuGaVTsV9L1SkAQOk2hZCsJN8fJomtgZmvue6qtA7NgknQwXOQVYFoQUrRghtTLl7QlSzL8x8SOtftGd1IZr5iakbRjudHWZfuskn7ptHATsFGKy5kdT90PVCGUGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276837; c=relaxed/simple;
	bh=amm6IB2QVHQmS41llynjCeEO9qHZu2xpesEVqtnd22I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdvbylovmenuZHTXBkNZC86vc1btYRQdVgZqELGQkK/QmXW0yJkXD2vbBIKwfY4OVaIL3Z6lrJZZg7P8j124dV6gC+lv8k50t97blfV+xISlJkmkTNbpr51VccvjpcCxIKWFN6IphS9qLsjDGTPCzUjJleuQtenO3n1WAYasak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=E5ssZtUF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="E5ssZtUF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b8687630fso36077715e9.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788276833; x=1788881633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MR/cQZoK7JPxTk5LPqkidwaMJQfEv51POKdRxNvWHUE=;
        b=E5ssZtUFAfATEqCPXU6WzHWaxK0dzq3YpkacvciZ3wUrP/nbA6oDbYMJBLjWG5lw2N
         bKWFONVvcUopczZaZ6f4L+obPmcKi0oxBGNwOQ24+XwpdOIMyVui/6RSuV3pAJth24Ey
         hdT7wqfWAO2UXkhMl02SGHIdhjq54RJV35TDcaqWX9MlkCnS5NaYOt6UtrG+X8nOreIL
         EE/RlYym07WiOxLKILjATNcnVO700SaOhfov8zsw/hDOHl7T73qm5PjiGMczyxVFvXb9
         vmfb1zpu7zvvHtEnj6I5W4S35aNSph3svxoCwXb9kZfKmzn4nhkV5jVn53efVRUbpSBb
         YsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276833; x=1788881633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MR/cQZoK7JPxTk5LPqkidwaMJQfEv51POKdRxNvWHUE=;
        b=ajq7kiATTkRJaPiJOrklzBEJj0gAvxirKCyywaAPyS7sLuQwhcpoSQpz5/0fzJNEti
         N1Um4H0UMoKz9mnVESJxlqG2qsFXMl4SStLRGOxGelx0kM9tBen08s1lsRe/mVfzzTBk
         osCJRv+z8FkQFClPAzfroME1r4dv5tp06yWQG0D955YnT5XQRzlw8vXZoxCEzhLl4AfM
         3IeJkZWRKdCokfnGPSQaecYe3BPWK3/biTQs8vQCOwR2xQQTT42t2O6IYpaUBHDBiiCq
         T29tnuvxPWsTLrscAF3x7nFnbivT6R44YFOKieZ/yPhvunszIamNgL4+gChEoCYIWD4+
         zp2g==
X-Forwarded-Encrypted: i=1; AHgh+RoKchHyjd2z1thNNhB5//lHQ6YFlkO4er5dcawWmTamCGCOfO97eCB72ZHqK8C0hbjR66gVnnA=@vger.kernel.org
X-Gm-Message-State: AFuF++nuJDH5bzNQgaIq/cIkWtuyJclrt4dYTdBfT1vq5g2uN6w74Dff
	/7fotW2Hhxyq6hWvM6O2H99pfyVrUkPGLLliy1PRPaAvffXOep/9mFoxDOQAH/t8D2A=
X-Gm-Gg: AR+sD12lAuBJmKNDxyRRFOKb45XSMkpPST6kCEh+vvRZF+Jd5bLxlsZUTOgJ7N64pzL
	isRYWE6TAwD4Q3sarf/WVWc07whQx4HGYG6HkPdgtLA3XZOpQO2VYoyyMl0sbAaihLK8V8puxcf
	bLMtmwjvV2d2ePRTryqTmF5hIKZWW5TfNsBR9yHuLbG9iE2dmL1GTT7VkL8GrVy1AIZqw+ui7xY
	tIkyS9yPNHIA/D9yfDKQp7n3iuj3lNzWBxB/qevh2jDxSg/ewVwY/5/PGdFF/0STgkSRjspnJJu
	FsEWKpxnvXQBIUdVKXT1mRM5ZmpRNjB6wYoLLL8eFdcwyBxD4eq5yAmhp6UsIxDj2TYJ+25T/oK
	o/JkfOxGfCKypMMozN8pxtMhUQ6gUaH1IJYpn8sijSRM74bARfaPUbEPWpXw9Vg9/D+7T+kOQVV
	cnVZMq2+Wmxb/i5dmwRHkBaUnYQZrBb7tPHyfXPZ52DuCjxfYklHB1wefo89u9stljk5WopkaK4
	Je1owlLNY8ITLepA+eP2PkqzpDjahxMXb2klH2v/mCDOXqt49Y=
X-Received: by 2002:a05:600c:5391:b0:49c:cedf:f870 with SMTP id 5b1f17b1804b1-49cdc555577mr180831445e9.16.1788276804848;
        Tue, 01 Sep 2026 08:33:24 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm314541845e9.0.2026.09.01.08.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:33:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 01 Sep 2026 19:33:11 +0400
Subject: [PATCH 1/4] nvmem: rockchip-otp: Serialize reads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rk3576-otp-cpuid-mac-v1-1-ea9135270fc2@flipper.net>
References: <20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net>
In-Reply-To: <20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712; i=alchark@flipper.net;
 h=from:subject:message-id; bh=amm6IB2QVHQmS41llynjCeEO9qHZu2xpesEVqtnd22I=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRN+2C3xbXrK4OeZYvDjPdrr1mZbp/St7fnwfTot49W3
 TD5HCSf3jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUx35iZNibP3We43yhXZ16Wn+qpl7LuCJ44ZzTmxzTjRy/HlSF/clg+GfIZX2
 of9I/hUiz98vtfcUeTXiyUHIf56ZrjJturNqyaAEPAA==
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
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/nvmem/rockchip-otp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 2c0feb036f3f..b034b7455016 100644
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
 
@@ -272,6 +275,8 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 	if (!otp->data || !otp->data->reg_read)
 		return -EINVAL;
 
+	guard(mutex)(&otp->mutex);
+
 	ret = clk_bulk_prepare_enable(otp->data->num_clks, otp->clks);
 	if (ret < 0) {
 		dev_err(otp->dev, "failed to prepare/enable clks\n");
@@ -431,6 +436,11 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 
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

