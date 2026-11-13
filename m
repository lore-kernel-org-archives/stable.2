Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611629;
	b=3+yXFGjf75AyW/gnfzU2HClfOMfaSTeEjfSD3uJxD5JJlyVGsfnCb/pKuW26bEI6x8aQ
	 UG9Ph2DLbc4QTYpGx054SA6gzIzy9xwgttbr10yoppvVQ1WWX1xfNx4roqXbmiiKWrzYx
	 d1Aa1ben1w3zb/t+LdX9YNhC0RGzsvX5Z8zEpBJMyGXPbGOVSaglkHMbMjqcHY+hyC+PG
	 bXY3ZRvfae/DggRVVnyGOc9ZjGHkgtj7RkdeBcYYOcS+47P/fnAcGate2YEuordBvDRha
	 hwVV0TYr9xc/Sul4qP+K8PLGPtfKYWuyW6es1ZgbvZHyTSnRRC3+wrRYMH0fR0/0Zhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EG6s7IXphn6NOHl4nh68/lOvSTp0F1fia3IQ49tN0fQ=;
	b=v8LvJYXXfch7TbSQjP/cUfmXc6Uq/U6PyVJTHRwS4XGS7YAqPFe/JDsp0F/ZfcntkSYM
	 gvSL6uWbCXqUQ1b2Zswnx5XEF2izfq1rSEVrdaNX+iK5oaQ+T/rnPhMT7Sup9uvgY2lsi
	 qB4ZU3fTtPX+GpsDMmiAsReS4jaTy/SSgjoNrmqVDt83Tbl6Wbdav5yKWyXZGB44nHo5J
	 fTfI8Wk48GWc+D7fw27GM68eCCcx/JWBBd4452x42rT/nMt0gHB/zy6IbkMmv5iw1HYMn
	 y1Ac0e2AS9642aJGWWOA40KY9LQSb5qYUyfieXomTWzU71OYgKlK4TiiJhkFwJXFUWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSt4dPSK;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF8606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ACF8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSt4dPSK
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-377f12217c7so1494078eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611628; x=1795216428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EG6s7IXphn6NOHl4nh68/lOvSTp0F1fia3IQ49tN0fQ=;
        b=jSt4dPSKRruz1pY4S3eqCOEYbFc0io6eBEJdLq2NG76YVTJ8IGs2hx1WtYgcA1+Ls4
         Ws2si2Q3MZYlxOemx2wdJplId73D9rjtU0SPNetFUHe1K/VL5jujBckLG5iklZZCIcrg
         +I94mNsDT9FjVD+Zbx0EhPu+P84+IDWj5EJNS49BJ/efznOf9mhE8nsujcCXLD8QLBa/
         fqR/w6yXBnHrLarWXQBqIs8lKxrrI1Ak//xYc/2nXqfr2A7R2hOAw17U5+g0kUJM55G9
         szjj1VJoxlxA8+kBUHgw1/L7oWUZMhXOah19zpQyUPRlKdbSNqjZMRFDY0KAb5G0nRQL
         rnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611628; x=1795216428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EG6s7IXphn6NOHl4nh68/lOvSTp0F1fia3IQ49tN0fQ=;
        b=VWTIonmJ4pVDTgVWMUFGsNGAZJFF2tRfZyXC6XZE15ywAVZ8A0wf6+hUmePoSF5yN8
         VlyNjmey7wdy5lVVD/1WT9YifOJGNTjOLy2XqQG7SLEUa885cWs9XvlHaSZA5t4I8724
         mxGOEojVws5wVEYDfPh38v3pDkjRTn82HfT3bHjeibfFabqpwljAvDJNZIdMnu6iT0A5
         CwyHDXWkuNncPFq5nRLFM1UqLYMV7Dm3dtVQb+XMRrVA7eXqJGUrb3sdDo6f8YbPDBW2
         PlRoFzLZwIeWtcIKtN0cj4iv6u2nGtiyYKn4g5ywznpZZFEXtt4kxQiuXA/TTvoVYElC
         jR4Q==
X-Forwarded-Encrypted: i=1; AL+hErGaCNatk/X/AFllsdNusys9zOo8nS2P6MKs9l8CIM7hip8xYY1SvMn5G//oGfabqrogV7c8aXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Yk2DAge74eCPcKv6jNzF7le94ICg/r2BbkgnpWtppyLB/91pV
	YCttimIMdEEPX3lW2b4etRoDJMnT68Ivqa1xo93E/2mzBZKG+4afRqIgdJAMNrqKI38dBQ==
X-Gm-Gg: AYBFou3FDz4XX99Aozqv8UUBESa6xmXxk6boqDzcnTFV61jukniXHfd/2qiNdX4Ue71
	vs+LSxQ0iDYiIiWabKEwzgrP4PwyLiMg7ZuPU2dKA8tSwQrENMxuduJRND4krzWHBKISstxuE/j
	HRJOSI/nssYS1+MTI4EyzYVC/ofQPACfiNJP0PM9cP4QFZOEuYs2SYP5AfqRhh8uRRfz8qwWa/J
	psyc/zZ1AX5I9P+wipUIcXWkljHZMpjiUPWv2vwcXi0uUqyFnmBcOMi1XeEo/lY9ZbFWCG1oLea
	VCmEqTEmTad+HTh6QTKS7l38ESSyNffUxVDdKPz+dSkRqsAML4jPXxe3fmsELbdBCAPpOXR20Mi
	lbpqTSnr8Dg9+8wFo4BHaD0aaurwoxN3ZL0XLyVqHet+YAhWhIbnIzVpcFCk1x3WXZbBxsGyA1d
	zQVRVE/qfqq3gB2bGlgT7CrK+JnBP89bI4N78Uflxuky9SD+LfJBHyoysKotjtfdeMX2KXEpBbH
	ceTfYoYoo55KM9MPBNbz1mqQZEZvkGgQ6YpzziUpEBZoQxowlbXNB5bB8UXdTSBS71nhxnYlOL6
	suBXK1/tO2VXBVI6Ffs96cu8158gScRud8bpdeT4aFM9GJBtw7svruMAubY/8Q3fMXlE+pWHx0W
	br1FZOhWy2IzwwB8VT5HwcpSKxphaoYAR5gQOP4AGABrE/9ulYdSUuiq97w0=
X-Received: by 2002:a05:7300:d718:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-37966b52740mr4985969eec.20.1794611627449;
        Fri, 13 Nov 2026 15:13:47 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm9922842eec.10.2026.11.13.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:13:47 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Shubhi Garg <shgarg@nvidia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rtc: nvidia-vrs10: Disable IRQ wake when resume fails
Date: Fri, 13 Nov 2026 23:13:27 +0000
Message-ID: <20261113231327.22109-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

nvvrs_rtc_suspend() enables IRQ wake, but nvvrs_rtc_resume() returns
early if the I2C access to clear FORCE_ACT fails. This leaves a wake
reference held across later suspend and resume cycles.

Disable IRQ wake on the error path before returning the I2C error.

Fixes: 9d6d6b06933c ("rtc: nvvrs: add NVIDIA VRS RTC device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/rtc/rtc-nvidia-vrs10.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-nvidia-vrs10.c b/drivers/rtc/rtc-nvidia-vrs10.c
index caac63f4e0fc..a5e73baf03a5 100644
--- a/drivers/rtc/rtc-nvidia-vrs10.c
+++ b/drivers/rtc/rtc-nvidia-vrs10.c
@@ -505,6 +505,7 @@ static int nvvrs_rtc_resume(struct device *dev)
 		if (ret < 0) {
 			dev_err(info->dev, "Failed to clear FORCE_ACT bit (%d)\n",
 				ret);
+			disable_irq_wake(info->irq);
 			return ret;
 		}
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
