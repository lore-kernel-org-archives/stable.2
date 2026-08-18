Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632A379971
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787019015; cv=none; b=lR6TxiJEwd10tVl879dGLCKMHQwV6aG/kTGpqlSQlvtgK5RcDDgOwHYDJyshXiF8LNBga4Dc8M2CH/PJqz6DlXIz+R5XMfSJyutI0chpxqT4MFabzr2nDU3MrWAa6n5OzmOZ705Iw4AahZOBf7IOrQOx2N1q/1N5qGdgJYcQeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787019015; c=relaxed/simple;
	bh=cA9WlMYoxFTZK4iF8Acv03xZwGQZkOeymCDFeNB9gRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jazg74+SdaXrED51N0rdDNA4D62DVR+nAwhmUGj0bensPxTNXSwfFPMMx2x8dsLESfLnBqVQL7LJkCADA0DGlnGJgP9BAjr0Kb1VlW+Bxnqj3EnpXcibMGdpZcLsA1OTuF47Bp2iKiQysTZBZm8VAqsnNB6yKMRjHKCNBapU3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=s4nibJhy; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=RzNBmpAo; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="s4nibJhy";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="RzNBmpAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1787019013;
	bh=cA9WlMYoxFTZK4iF8Acv03xZwGQZkOeymCDFeNB9gRI=;
	h=From:Subject:Date:To:Cc:From;
	b=s4nibJhyforM80XUBFegshhkex7nQijmPAj+zyBCpQGTMFDY+nuTDhaE+tYGlV+Ay
	 PypuJVKDd2kGDOlcYfzb77rKkyWiHHp5pmg8Vsm/iAW8IqC+QFglsy5XQXt9Ft25jM
	 ahLDUNjdMgAUX/Uwg9PyGPIUR6b7yISdMiJUgnAKO6vzavVczFOsEFI6sO3kwtzCts
	 QdhWEBWFusv3ONe8b+/CfAYoF1ibvVhhuM6wQuU3E9whUQR2JLnGXWEfkiSxxSw3R1
	 e1vpkkfRVnfLDCsXiJKA+9hx1ReXYHYtqr3oRtzQLD7/JBpPXps88VeqSSq0pVCMzC
	 DKpz0RfRHNq0g==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 663B1329
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:10:13 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=RzNBmpAo;
	dkim-atps=neutral
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 98F493B5
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:10:12 +0900 (JST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a67b16217so6367036b3a.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1787019011; x=1787623811; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kkzuUIkcjhrbl+NLRbOh+awbahBdDgYrrv/qyvkX3fg=;
        b=RzNBmpAoMGqwO5ICMg6jkDWHRgMIAZ0F54ohGDRNKOs3qI56+ehsGVZuOSjulzMlKW
         KzHuDAwHzjkAeG6YLy6/A7jbE8iaoRYWJOxJq3Crt0NVw4ZUN7/KdRw+RbiNpuDMEEaU
         ii5iRghse+Bt5oXB/X7D67/MctTTQMO4EEstNXhmsfOaz1Zi+SJvYKvtFTB0mQMi+9QW
         kRqJ82jv0DfodjjvmDuDekYAwfPKXCthoIecteHDi1tAx4iEW6Br815LfQAqRPoCDunl
         gvQJa31CS1fsr1gDVDDAnH/PkjWcAAHjbB276mq4XFwoE8YRyB9GEcnoFelTbH5z8VTA
         XTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787019011; x=1787623811;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kkzuUIkcjhrbl+NLRbOh+awbahBdDgYrrv/qyvkX3fg=;
        b=fn2qAqnEbvPbVrmhzgzGyJbRxtrkxGuKgceYvfUFZiTOLhVdPa27nidozrefbEaQxA
         suW9NbpqfYEZWYTtniE2j3uHV2N8M0JlcftR0e1t8PcxZYsODwC2sIs2Qx3q6MDjP3OK
         9ymrytgWm0bQVVuycSMF2qMN/fsi2AGLkFdMEG/HB/vpC+pOhEBnlE9GVrXJ1VGGxlCp
         +zyUBHNI5ml6MI2r6sGJviZc27KmUoNY4JQ3Z6J86ve1eviHfi28k/ne8bWM+Q9vN/O5
         zMJ/MUeT3JSQhZeeHOF37AP43lu3HS/0UhFXULYLdYq4s1pphUdpRnL+VvS8A6ZuNCav
         ZInw==
X-Gm-Message-State: AOJu0YwoLhb5E+VosTbr3geil+vy7RCuVnLTkpZs3p+eqRg71BvNezVx
	0twqkuJSwL5GFMJo/2B9OWPE3nqXsAdncLM6OswveSCFFPvuLe3rv6AiZC0wICqoputuLMyDRH/
	bWei87RD4A+0sUl7fWuSwSKLRsxkROW+2PtsPqRceAugNr6KScrbUvBYH/Pc=
X-Gm-Gg: AR+sD115XB+UMLQ7TS+Vpi6/LcgVrqg7A9aDzUFxCNlx7gPEyBOhMNKy0VRg8nrII2D
	zFxc9U3tfL6v9IDWQw4xe438TkCl0bEuW9HpXf3p907mrV9ePVnzpKM/s+bqQDM/4zf5TRtmpT+
	2yABYBh7nZ3BvSaH+DxFzY6ZWcH86qcn03y4p0gfraD6vW5c53HcHIZwfIOYwd4A33sbpV+SAV2
	PvmMj5ie25CqvaBjbOZTDfiX+c1or90BqCJ8d+kFDbfNG3Q7CrIwtQbZ/hjKqJ7D0GPtqnYBYzI
	D62S/u8Sk/PTDrGx44qzXRb8B7nRa+ppm+bia+YcwWFvhpgtzSqOAJnbsYVbw6NxKGM6izuoOqQ
	3DCR/vGI6vc8QlXt+LqO319Uo2xZXImXj+zgxDPzOfL0Z1ESo
X-Received: by 2002:a05:6a00:c94:b0:845:dde9:ab62 with SMTP id d2e1a72fcca58-84fde2e8fb0mr29085196b3a.19.1787019011521;
        Mon, 17 Aug 2026 19:10:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:c94:b0:845:dde9:ab62 with SMTP id d2e1a72fcca58-84fde2e8fb0mr29085143b3a.19.1787019011034;
        Mon, 17 Aug 2026 19:10:11 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-851b404f349sm1175062b3a.24.2026.08.17.19.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:10:10 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 0/2] Backport fixes for UBI
Date: Tue, 18 Aug 2026 02:09:33 +0000
Message-Id: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6+g2oC/yWMwQqDMBAFf0XeuRETaJT+SunBZNe6CipZlRbx3
 5u2x2GYOaCchBW34kDiXVTmKYO9FIh9Oz3ZCGWGq5yvGtuYLYgJbRyXOa1qXHel2hNTYEJulsS
 dvH6/O3ZfWle+8fgL3cLAcf3ecJ4flDnwzHoAAAA=
X-Change-ID: 20260818-ubi-backports-2f5d76dedbed
To: stable@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, 
 Liyuan Pang <pangliyuan1@huawei.com>
X-Mailer: b4 0.16-dev-a9e92
X-Developer-Signature: v=1; a=openpgp-sha256; l=879;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=cA9WlMYoxFTZK4iF8Acv03xZwGQZkOeymCDFeNB9gRI=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBqg78AdXyHPIvw96F/8CArO9a8ZxlKEIfjDxv87
 8V3HsusQ4mJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCaoO/AAAKCRDyimB/1oxx
 B4NDD/0SRC5VCr0hPJCtUU8ccD5oT57yYjDX+m7VCGw4GmpEseeDC66N82/iM1yNI8AAL5wFhAm
 03qWXI6wMKxmi6zHyV6rhOZ9kst2ZxwU3mCzEdy/3oDQrKD5j9UAO5OMpW5e3GnY3h32Uh88z62
 8mHmloTWQgY/pt+VQRkRuVLhwBq5kRjKUkEc+XpDjDFrpyg8q5/gbD3hbbp7UzqaoR3DGVsFhEG
 +IJvi6Bqi+hH2uuRe8vTuQ9qdX1nC2XwD/I5N87cekN5jZFIwwjXJNzqHJ3QHGqr2zyKdSuG+VW
 yKcO6ovhkkS4Sa5UmqrfVm1lgFIsffqZsHGEaDtCEb74yjOBDQaqfBWeSYyU8JiEFGTAEbQVz/5
 AHVmYdy4uMD/8+XIV0LP82Dxtgc9MCpt2Sm8763e+kS5Ldz9Tu44FkAzLbheenTR5V4cKnQ/gwo
 Zs9XexEUxrkHHSs5xA+DetRK1R+oQZjTJdtU2w0czlLCQPM5NkJWG/OQ9lgXpkphq/sOAfM7hpm
 b/jFuBYaW4PBCcKEZXSWsk7pxMivIzdPZC/YWTEeOg0TEyE5DfSpfWMrkihR8gMbJeNrvKbRQ2j
 +Swibt82y2bew4cjADQH/9Ynh3cNbFpKTA+CDsUsFPE6tl5By68WVQrVSqVICEJyadzTsJgtmap
 FSH/1NsTVCbFtxQ==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107

While looking at recent UBI patches I found these two commits that I
believe are worth backporting.

We're not using fastmap so I don't care much about the leak there, but
reducing wear is always good to take

Thanks!

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Cheng Ming Lin (1):
      mtd: ubi: skip programming unused bits in ubi headers

Liyuan Pang (1):
      ubi: fastmap: fix ubi->fm memory leak

 drivers/mtd/ubi/attach.c     |  4 +++-
 drivers/mtd/ubi/fastmap-wl.c |  8 +-------
 drivers/mtd/ubi/io.c         | 10 ++++++++++
 drivers/mtd/ubi/ubi.h        | 12 ++++++++++++
 4 files changed, 26 insertions(+), 8 deletions(-)
---
base-commit: 98c5a5b9f23ede08be1dcd8be0a13b32fbe2b462
change-id: 20260818-ubi-backports-2f5d76dedbed

Best regards,
--  
Dominique Martinet <dominique.martinet@atmark-techno.com>


