Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003979;
	b=dOFBB580yI+Yx6dUAg2D1eOYlVoAmWviX8TjdxHo0H53/LazPv5T+FkSRZxGYOBXQsWh
	 f01rCBH7Vp9CDrrqB93TVun6vQMkw57ufoDq8xYVxwTowhBt6xTuWzgvigkJyAuEKjPPu
	 0XvXeDJmYStNWNTF4CWHRixaPpmAh5IciKmCCnasothWlwuuCli254lrJnObUTiABSdNu
	 034Lm5+xEbLmC39o/ku0unVeY1nTUGEOrRp2gWf6gcbFQ4flSvdo97+P3D7DH9uZ8+UCq
	 gc3C4c4ElDUwOgcqqR23nfnIxmbMQnakUYovtQ7sqxkMUuwkKozc7XEjxu3GPWI2t+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VToF9amWTCrNW1AvfVMc3RB1WXmBdknEErgNhEgj6zw=;
	b=NW7kmJKXyZOS40rJfcUQ63GOUKyN7rg49dYZZlU8NPdYWHjYtAyyDjdcg/2A18103XYT
	 ptiAK5gvIGMYFm0LVA/z7ffaM5EOn64Ofh5GqE8nr4qXJT6BRQXl6P06R+IWNd9Fkb1Jl
	 8BHv0UcwQR3wMlHMs8z6gbsJtOTQve9fNqVOsOxvMUJrPdEu3kSnSwr/09gNSG3qJW1fQ
	 m5rlg46JsNBlt+HL5XURVFP1V3CtiUM+KNLI6aXJNQTt6D3X0HYxkroKAEr6nV8sPrnoA
	 WoL0xKG1hzMNQKhBrdGb4SnM5zwvYG/7HZW53LniABXxdALE8PT/fwYhiLLVqVmsdxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5XNLxSp;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A3606A33F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 945A3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5XNLxSp
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b37951a397so676599a91.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003978; x=1795608778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VToF9amWTCrNW1AvfVMc3RB1WXmBdknEErgNhEgj6zw=;
        b=F5XNLxSpHySTF+ld3i9RFIcPWLa1BLVpQca8ENIgXFtCD+DgnIKR1q7WV1SqX5rkcE
         yZB+VicZ7r8xKwIsaNkjfDeY3vyPoGRMZ63139IofXj8hJw3VPd7HVHN2JVkmJgTrW5G
         i68SXrVRISqis0XYmUHaOxfy7OhXl8TyOJa+K+oIffqJVoz3qSLJr5zTB+9wRkVshVgK
         mtM26jqrhVR1gtFP3W8qdFQq27JnHS8vXF7I+gnLz4XUHgJaAOTTGGetS+I2c4te5j6M
         QtAkOc1qaDXpvLZrMOqyjPVoEiJbqq43h8Hi0/g+oOT7jZhf/SvEWmY3XTq3cc+H3eP7
         X+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003978; x=1795608778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VToF9amWTCrNW1AvfVMc3RB1WXmBdknEErgNhEgj6zw=;
        b=MSfsmvcZs2eEJB6KQrvPimd+0qyeR3XKr3ZjCtOxqDEwgGozXXV/SN/Trr3Vf4DKZU
         mJtipSMpzecrn3kf1+TI2Wfw+eqpNB3XDnXQ6NUkWUgnjq/pIMiDnpHWAE8y9UDs88qw
         PzYJ6cnRMUR5eFAAUyrYY3pidyGEqwGuwETKDCZgIi3rqWMfp6xPTIya/Y8xgFWCDImw
         25FlGIApToaJHSgmCBn//8FPVqaIhEERZ6bg4XfZFKniVq+6O/FFzb+qTJWdTkScw1BQ
         bHPO4qB3P0mHpHKZyOKmijjedAYrdikm1im5J5EcS3N/0Ey7XjclV+5Mnbxi7Gl6KU4Z
         fAbA==
X-Forwarded-Encrypted: i=1; AL+hErEY4HgqGwF9IM2lxwiRDARDMttvzR8U4jogCmFMo7pLh0d1gpSAapQwzcntTRKGtZtTQzmLIuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iI7NGvAxO4szXliebAcncco3RYB3yFYZPCa3dg4AgRfiUHls4
	3gTHpcwwlUs/Lbh/yaXtoNSBVmpKJdhUUxa7fLzzytTFLo6+hVKsddlv
X-Gm-Gg: AZFdTZdyDUWUaSaNTXgaLmOZjWinVu1SeD4zQVxjII/3pE3ib68dYKwTC6pz+IbVV7o
	x4/8071G2eVgeTars1PDPNX7SYMHHcq0O0cEjryIFWzpk3i4GtINRyNWZwte005HjVs6WRiWwcP
	kNEhziyBW3C5J/CVBOH2vdhO+/WXPDvROkqEpChH/cMADw4E/XkHLlmK2F4bReusYruM6UzOwrA
	O5UdZ6BGUhAc5zlxKf10bhuL2iywBh7QMCnFgcFwZqw8rn9ijSi+yLRoK3n1Gyh11x/bf+WdHxa
	/r1WM6PqPJH9rMVKx13DF9jxUMVofcFisYn4cLAEdzfY42eirOib1soLGFFbABTQYTGen3c6Aij
	aaQuXfj/34AMYCYAresSVJG+CL5D/tZbBfNLWrEjbxQSeT0WZeyFyGubmq6ENMa04MrDK0qlAG8
	2mBTfqDE4L98xkff8lf4lHpLwKy6CamG+vmaFf5OdIgXP7sbdMxrMr1cuEC7rV+gk5e6cwj/Rrt
	svpfadSIDNunENyOgdNT1bNnKsdMXryjtDwdX6nGibsQBmUFCqOpIsNO1WaJFCfbDOCee68Rpxr
	pKCXgGk7QieVNz9lzgx4TU5q13bk8uDETMx7nqqe80U9lfK6os23Sw==
X-Received: by 2002:a17:90b:558e:b0:3b3:b453:2453 with SMTP id 98e67ed59e1d1-3b3d07c842cmr2806712a91.37.1795003978466;
        Wed, 18 Nov 2026 04:12:58 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1c03e04sm4095609a91.15.2026.11.18.04.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:12:58 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: cyapa - check the panel scan response against its length
Date: Wed, 18 Nov 2026 20:12:14 +0800
Message-Id: <20261118121214.3571621-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

cyapa_gen5_read_panel_scan_raw_data() takes the element count and the
element size from the trackpad's response. It walks read_elements *
data_size bytes of resp_data[] without checking that length against
resp_len. A large count reads past the 256-byte buffer on the stack,
and an element size of 0 divides by zero.

Return -EINVAL when the elements do not fit in the received bytes or
the element size is 0.

Found with a CodeQL-based static analysis tool that we are developing.
Both reproduce in a userspace harness under ASan and UBSan, which
report neither with this patch. Not tested on hardware, only
compile-tested with W=1.

Fixes: 6499d390a166 ("Input: cyapa - add gen5 trackpad read baseline support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

I have no PIP data sheet. I assumed that the element count of a
response covers only the elements in that response.

 drivers/input/mouse/cyapa_gen5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 59f6e97d54827de..c346f16961cc97a 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -2265,6 +2265,11 @@ static int cyapa_gen5_read_panel_scan_raw_data(struct cyapa *cyapa,
 			break;
 
 		data_size = (resp_data[9] & GEN5_PWC_DATA_ELEMENT_SIZE_MASK);
+		if (!data_size ||
+		    read_elements * data_size >
+		    resp_len - GEN5_RESP_DATA_STRUCTURE_OFFSET)
+			return -EINVAL;
+
 		offset += read_elements;
 		if (read_elements) {
 			for (i = GEN5_RESP_DATA_STRUCTURE_OFFSET;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

