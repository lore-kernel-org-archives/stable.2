Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840941;
	b=AJ7N4GIJcCsX/SwbiWVe5V2MWteF7vUSA0PSC8KCazOdZI8snX2AyfT8DASZt14DbWkk
	 DnhpGIrz/cMMFvyKsQjgEjwGuQ1gkfckT0fsMau43yunkNSYrS3NhvU77t45YiI7pUSse
	 RYdaD5jd6xGxTNtqC1wB3cXuBMn/gdpKBDizGWAoz85jRkRaCM9TpTcThaGbobFdyzF91
	 0kSD0D7+KnmXR+Hu/zR7tYcQiCwJ0RwfN78He5s4HKpDaWR05w9B9/mQ1ET2rN/+C4a/z
	 DAeiA2KEi4a1dUadcsya2VJt5rASi1eF9Qxk4erc/55Q7eHKAD2bTFjiWZGRQ25b1nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YciI8kRUrInY0KCgu42G/I1oiYsRIqMO4kLjHtEDjOA=;
	b=RI5sBuV9kdZYgapmBXpL2tNBzP49Cr2GlzOP5yxptqOTtCj3ph4G3hbKFaiDdrP9Pj3k
	 SIhJ/60zQVBQ4Fm51pkVbTxQ3Z8G+iWP71FKiZIcXBkh2PiqBSFfacwyh81JdxaJ4AfqL
	 XEMNATTYqdoLXutdATyY7HY/4zuppuasf82tdkSJNgq/ofVJfKLBqY/IK90id7sl7eqDu
	 bHIk7wmKxxRILUxHfjSlNzun/eYGjLD/RtFIkbahDl41DteYlG3nq0mxFW7xNq4eX9Qx5
	 MLjsPK52uYoA6K6nS1t7vsXpIvUfAhcwuqsW8K+y2Z1ysENo8fLQ5AvFI/cvMoxQkqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1X2msCI;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675B606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3675B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1X2msCI
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so6345956b3a.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840940; x=1796445740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YciI8kRUrInY0KCgu42G/I1oiYsRIqMO4kLjHtEDjOA=;
        b=A1X2msCIX4ekoST/dOr/GvrTArKIqLNFbIp+0mmVpt3YJq+SsoykpIYo+MQ4rsFavL
         xTHseXOnzFBfnvcMwbeXauLOQrgTmzguPch1Aunk5VLO7tjsjC8klJ8BcFP2gaCtLXEC
         MVM1aIauNBccrsSIgD7XAT8MmEBXLoXGDnKDqcJxPv0o0ayk25/3NDpPC3vv+Wm6EWJQ
         YN6mG1Seegil542b5Iryt1NP134X41ROhci/81ZlswtLAePAjijlRYKtWzwk8/IBJFwH
         1lBkSV3ams82WrFSfZAcmBS6IkY0Hv56n1/Xf2WJDwyZ/+tcQI8ZGTuxTwR3gEbQY4vz
         L3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840940; x=1796445740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YciI8kRUrInY0KCgu42G/I1oiYsRIqMO4kLjHtEDjOA=;
        b=I3mn3ZWzde1KkxJiLP6aQ91/O4Ypvn6GGOwltwZqA7K2IaSL+OIik0ZgwQ/+0vgckc
         nGVcLajw6DI9yxAuQHUFQZCxZYrXKyP5e4bChNkHSdOmyUNuxyruqJVfybw88bkFStiU
         ltCG3WtCbPl7T13yjGQig+Ys5F3uN3wIpdUsDxrWTMRkr82qY96RHFMFCwVAn2FawMUG
         /Q9GJIDNTh25u3f/LoOcyWgjuxnmIpm3zrznIMRHVOGPq0BibOBtKRqNNbQz8UQuO3gx
         IkkClOc+6uhdXZ2gUOHF7i8a/uzFjWTJ8tKnpHW73WUpjM2iVgu0SapHQ/ZN1tUkEjJe
         sjIw==
X-Forwarded-Encrypted: i=1; AL+hErFwxJe4r6j+iQ3OywC7v/Svbbq+H3AFM2k+jbGSxM5puNz+NpPaDn7E7531WjMIyXcztg09d2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kBNt15yV0GrzDsVb87U7Bhk/Ho+IrzHq13vrY1Y5FFIcW+Rd4
	6RDQhdrVY2J+fwkMgFWtxwteZDV30LO5cq6p8DDURlTsoJCU5IlEBooVw/t+Tw==
X-Gm-Gg: AZFdTZcOxpcS467HMumBgluszX0K0kVF5v4mWK2f4W0uZSEHVoWyDcO9ee9/ZO1znKm
	UESwegsy2DAnAU/z3BXKQEKXALh0d+OFgw9eS8llNp65c8yFzQjB/9DMjiPqh+zaEds1S1zCaGX
	GSFJyCqm/clmWYpGXr+lQXIaDGbhG0LENWtWy6N0kTcBOT2R6Tiz21M5psrwlUNN9LmkJej00uv
	qD/Vt7czpIoCPZAyL2+0Uztjsr/yX2ORyHwRml+QKoC79JgzxYPLLSjoTT9zYtqmaPOTg/FWra+
	bJEVE2mlWk/QPc23lbCuvOrMe0RZRLoTGn+zntlTQxJ3O8bGK/4BuLHxKEBPnDGKmvoWPHvuP5G
	W0FbXJLv/dNbEleURdWEtSuz/tIsUGQi7W7vkJPSe6/o4MM/aJQwO+AWQoYJsjW3bTbezaZ9Sq1
	0q2GDWfLwHr89HsZLbMBRtlNADAnWDXxGyjdFb2o+HsThEr98Z8ToJrPYg963VYZGwGqlWkV4aa
	3BvlrA3u4hw3NbXgnPOQb3fz5F+WlX78TSiHbZUSGOFUrmUp9KYDa650Iwjrp+89g1JCh8KqHMc
	ssiJz22kz/sA7ge5ZY9KJhVwLPYRddBMuF7nlYs5lDct58bRNkGYKd3OkqsWyBuFISVO4d4AAuf
	V4mox7nK+ukC5j+lj5xYe3F+Qqn1bS/fA+2pCX98C9RePKuziYQQLYfPSfQqrKhEV5rZLxrKKAF
	7C9Q==
X-Received: by 2002:a05:6a00:1382:b0:882:7bed:3b3b with SMTP id d2e1a72fcca58-8c87c481e1cmr24791571b3a.36.1795840940447;
        Fri, 27 Nov 2026 20:42:20 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cc4eb26293sm10113797b3a.16.2026.11.27.20.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:42:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	stable@vger.kernel.org
Subject: [PATCH] misc: sram: do not allow unbinding the device
Date: Fri, 27 Nov 2026 20:42:17 -0800
Message-ID: <20261128044217.723361-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Other drivers allocate from the SRAM pools and map the reserved regions,
with nothing tying their lifetime to the SRAM device. Unbinding it
through sysfs destroys the pools under them: sram_remove() notices and
prints "removed while SRAM allocated", but carries on, and the devm
release of the pool then hits the BUG_ON() in gen_pool_destroy() for
the outstanding allocations.

Seen on an Armada 385 with the CESA crypto engine holding its buffers in
an mmio-sram region:

  # echo f1100000.sa-sram0 > /sys/bus/platform/drivers/sram/unbind
  sram f1100000.sa-sram0: removed while SRAM allocated
  Internal error: Oops - undefined instruction: 0 [#1] SMP ARM

The driver cannot be built as a module, so suppress the bind attributes
and with them the only way to remove it.

Fixes: 4984c6f5e56c ("misc: generic on-chip SRAM allocation driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
An AI coding assistant (Claude Code, Claude Opus 5.5) was used to find
this while reviewing the CESA driver, reproduce it on the board, and
write the patch and its commit message.

 drivers/misc/sram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index c5110c32f661..fed949de60f5 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -450,6 +450,7 @@ static struct platform_driver sram_driver = {
 	.driver = {
 		.name = "sram",
 		.of_match_table = sram_dt_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe = sram_probe,
 	.remove = sram_remove,

base-commit: 917fcbf033154a6c8d83cfa6c88f012b71eb37b2
-- 
2.56.1

