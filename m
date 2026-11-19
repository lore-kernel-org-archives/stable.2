Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104119;
	b=iUJrhelEFgVXhuH2/rxOG8gPRq1dzQjxfxuJQZi0r/QgP2WwNTyxRhVnoLVorIfRF0Hd
	 PwSZjwbhmtaG38jc0NmQr9M74WG1djMjnsLo3AN9mK3jZDSQivspyRuU9ZJme99y35nHC
	 mW5x8dBYsFJCsQAaxKs98zZlLgQbKdSc9TSPSJYytoAumfJzjmNNCJQD7H8BUhAqY6/nR
	 uWkqEXJKjIWpl1pN34ewwndWHxuAF7xFRKM/5zxnx9X2Pdmdc5n/XI/84jRybp07XyRdH
	 DAHT47S4Ept/gLy8nb14csyNoD14sVfnoADKbzcgIXYY62I1zxtupScGI9giCJLCHkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=efYuB219fcaN9C26HZvNi4/GEEQYMSSt/HAQ3O/Eb2w=;
	b=Ev4Nc3TkAhT8rqS9QyaGATUzSNPFX2V7oeBdrng/uz4cLljdKSWjY+QgNlwO6EXfuRlz
	 tEche06tjuWDbdFxBYxmfuB2PVxGVpx/ssBL2Yr41+dmg/jkNxLDSswNt67VMOWgO2cam
	 ENxB3jUTAe29P5INMgwmXtINUDyxwPBhJmsTH1G8wjmI9DUPZ8XSKC1nS2vu0t4M4B4YX
	 EZTBQJALYMWe5VwAkBSsh7HYNnJcHQzQ1VTy0h1XmICuw1z9yqU042Gw+IkpoyYIIPYTv
	 78ymNcCJdjV5nkbfHhf3ppF8aJEQALsb7aYyUl4ZIFhYoYXHm4wxGb6gjO5NZgJTLiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bqX+sPLM;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6D60A2618
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A6D60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bqX+sPLM
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4eab91bcaso17664707b3.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104118; x=1795708918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=efYuB219fcaN9C26HZvNi4/GEEQYMSSt/HAQ3O/Eb2w=;
        b=bqX+sPLMc6zRDTNZOyMiZh94eEA9Vcrfu8bai0LW+BMdAaE97eIUXYosPQmW0Q8zIi
         kYgVarK4eNDNZC9orqU9V+kZEmO0Bz4SlFR00hagzKraX6CR3nyTTV45Oyl9oBznaSad
         UeLidQDmBC/CmHGHKwLJi6/g7RpEU5XvzQoKPKr8SspVX55H5qJ+xCnPRfOdSP3++2Cp
         AxOXFJodi+ICFGcHaPYQCD+4anzri5guXZOccffgvyM3uyIMVKM11dtBl8mmUEjkQgTB
         WxyEzLWLLYoQLzjHw2LA3UAJyScJxaLNELNnEheds907V8cppFAQM9eWa3N3z4dGygG0
         ghoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104118; x=1795708918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efYuB219fcaN9C26HZvNi4/GEEQYMSSt/HAQ3O/Eb2w=;
        b=ed5/U44UmQCFSI3HiTSfs+9xJcMABdVq8AGvvJ5vxN97nZymRHDtWtEjDPAC04iv06
         7amgyGOOlf8Wbb0buJbMH5eufO/w9cE1BTaIDQR++Qoqwidw9MD/gxRlb8T+cESzKVG4
         wulAJMBGaDfDEcowTs5Pu2Ojvn8UZNyywLt1Z1MfeoIHzbFYaDc+X5UQWGb1qLUrYA+p
         Il9tz4jsTzfd8Mdck8uXt20VTkYDhdeelgXpF5zid9/D6emyPjrF/NsdA73Iz1tMHntU
         xxxQtNdlF0aVOtg0brfEduFEdsJcD1jAhBACP9l7ldHCRpX0ZWLY4AQZBkeXHhJWLR2Y
         XUBw==
X-Forwarded-Encrypted: i=1; AL+hErECWnrOR1bWcA9DiysHbXLnRAatouyRtbP+ncBny7vpo4PZm28LwV72/oBu9z+TBkPYBkbpiWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JKTQW2qW0eK3DbD5GAlPFnTy/MPL8KQqI/8bhHMcLtaciNSe6
	wMN0aFYUfDk04nbg0M5QnOce5uTmkCJ2ymSdZD8vkmY5uHePcZHUCIw1
X-Gm-Gg: AZFdTZc7dp2fNW0Lkjp939MNkTK00d1gyeo5kALvjR3rOqSymJmBFRbuLpvn6+kf/sN
	6SUamgJE5unpDQUiIaTNavh6ctr5D1DXnENwXnXBJVvH/sTIl4d8PsaxyrH2uM4PuLh3qiKtia/
	jTvjuRvjcdyQ5IZ1ZjQk6gantAbADy79Uwx+6muA0wFNONWgP63RAvF6u9afHT6vXxhA67zV44I
	eYMEB7vHgCmhZ6IiFlpdOFU00X3GpCGxCFxUWnUWA5ZvrF4iWGEsbCizOwejuv3p3+l/y8uNzjA
	Djdf1RPMk8ue84x+VXCEcudIiT6bF8cyfJiO3P2TuY6CsgZ1n2+O11XIOzWFx/EnHgPfJ6yroNU
	c3Fyx2ZRFI/ZV1CCfBsp/pGnylZyz3fUhrmq9B2EqshYHCeqh+fmqS7Am94eKTgc5SpI3pjvk7M
	u2fchvxw7LACJm2bYqVXYNK2ZglEmIZ+IOB0Dd7kluzxPiu5QcNdAL7+u3CBTbQd6Il06QhaCOs
	G4iymRoC+8Ur0I/5JJdDhOx/3APqDD4mzpF6QozmmWJLItjuVnnpsIanRei9h1aPFvL7n7M34G9
	8xURszVjTblhYkK8l37XuYpDDtuRPn0nGf1Jf6GSUeCVepvtoDuULsbhDs1LD5LgtmonSvF8njv
	XDOVfqvY4oo+r3L6A5/muEQsZsB5lTRD/dtdxSKsUTqkgV8UbRSDeACFP2jfn6UiRQ8Yh5bkw70
	bmUGGiCRulVxxPyqLj8c4Y87L9T2ojGCecZXpB1Jp/JUinw2JA7xg=
X-Received: by 2002:a05:690c:3745:b0:8a8:6a39:37e0 with SMTP id 00721157ae682-8b5204ba970mr652727b3.42.1795104117742;
        Thu, 19 Nov 2026 08:01:57 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:01:03 -0700
Subject: [PATCH v8 8/9] dmaengine: dw-axi-dmac: require an IRQ before
 registering the controller
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-8-f8e7fe60594c@gmail.com>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

If the interrupt controller is not ready, the DMA driver can bind
without an IRQ handler. Clients can then submit transfers but never
receive completion callbacks. platform_irq_count() returns -EPROBE_DEFER
in this case, which skips the IRQ request loop just like a zero count.

Propagate the error so the driver core retries probe when the IRQ
provider is ready. Return -ENXIO if there are no IRQs.

Fixes: e32634f466a9 ("dma: dw-axi-dmac: support per channel interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 2eeb902eaad3..531705f8f89b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1518,6 +1518,10 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 	int irq_count = platform_irq_count(pdev);
 	int ret;
 
+	if (irq_count <= 0)
+		return dev_err_probe(chip->dev, irq_count ?: -ENXIO,
+				     "failed to get controller IRQs\n");
+
 	for (int i = 0; i < irq_count; i++) {
 		chip->irq[i] = platform_get_irq(pdev, i);
 		if (chip->irq[i] < 0)

-- 
2.53.0

