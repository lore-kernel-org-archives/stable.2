Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067679;
	b=zV8XBV+pgJisv05UW3+5gZ1XR34liHe8bqT8ZQPSqXEw/enu31dJipx1naM239yF0Es0
	 sMn6gRr6nz+NTmD5j41kfXWhljMvkiBkJEX4AiEPTbVu4cI0vAd0shuzIqk63v8QZaw3T
	 UZfL43Ep9kJ2SxLPbjH1YWG/MbbfoyJ1GBUEx9VH5o03ITnvelDXmWrQ4R6boZ62l4fn/
	 r1pU5z3pcWdK21OFMjkAO/AyMLzu7vIxhG2Rp8RS7Vu2E0Enpwaa+cDK1G3HQtcBxf3If
	 1GWL4tEZeGKRsVbTParBNZX8G+1HfkvpaAHirQJuI+gXdIYnHiGtJI65y6C4XJj2fxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w9ad/RtjHCJ7QFgHhoqC4kL6cny/ndwNqseOOI9y/+Q=;
	b=eRMsvvNq41sjG8zPb1RmuClTxN5MyW/PKs7eNqighJ6wOy6dBlzkTvGNkdS4WqNAMpg1
	 uofFrNBosepi/MlnJaZvubWjJ9sH9qNaFiep2/oyjIcTl40rSMR7XHaVHPmKd+dc6oSKa
	 AaxZcPzFoR9orsviPgkHoFwgJ8YrQlxhplQcLNM0LFOtKOIc0iFJASaw+iWgIFlUw37Nm
	 s7aHsg+6AQviLILArh/c69boOcDNOGotQGdyj2ZQpcQ89M5ERr8w92qMyIx8v3YEyc43g
	 Krn1TbH7a0bPM+2IPhHsS5ZZ2AA0nir65BJJgT8Ygf/X9T0bgsYVOcl5d/hQygoxNwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPvdF6aA;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF2606D828
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4AF2606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPvdF6aA
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1438d9363fbso320779c88.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067678; x=1794672478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w9ad/RtjHCJ7QFgHhoqC4kL6cny/ndwNqseOOI9y/+Q=;
        b=vPvdF6aAyOOGfXmtGZoL9hYy3XjlZTVFvFMW4LYLACarr2+XYknq2u4wzpWrixOJNS
         yMl+JagsDkAZ0AD7fiCRjB2X0DdfrJKvRvESGFGieQEWCouMREm0LHPbJ7QlWcpdcBNC
         /SZt4iusqNDs2ce1E8c/bc81OYjYYx/SBCc8WgtbKZa5YOp6c6Hj9o97zsB6ivPxDN7Z
         zeu28ZxlZpDHLeYyZKRKLFYHbvs+XOFlloKhX2fUFrLJRhVh1Z/T2930c550RWwmGXOi
         u0csKjzz2bOYTqs1PN8QzS/h0EuwnobtEr+2iPGF7Mn63y3nToz8U8E/aeFj0USlavUo
         7yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067678; x=1794672478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9ad/RtjHCJ7QFgHhoqC4kL6cny/ndwNqseOOI9y/+Q=;
        b=MJeKHv1Z3mR2oxJw0htvjPybhyrTvVeiaJm3W07Siz8fVpXyxTk4hsm9QZGD324L6P
         okzocykIYJBhy+Vudgaw35IFR+Knkr653WyTTJOKQXMRfeZNqb8Nyu8ncKXuCsbwD6qD
         BrpYRkR5l7JAgdDuSFdP9XTcFbPCYMPp2Zmy0mJ93w4t4BVfUuZ4xcYsNgDRToSNY8TJ
         xgO2qGG/E8bhVdCCRA8/0ux3GAA3N/D8Hr77AGhCPEXuJUK784HArKiKMmbwCci03K8o
         e25Fk4A9OD56iZHUcKgIJAkkX+EA3Row9udQBAaeiF2B9cRzpblgTFCrAU9o7S/T0jk5
         U3bg==
X-Forwarded-Encrypted: i=1; AKwUvBx6shATQQ2sh0TZ6vLHLdvz8N6Bz0hAgQSExkv7SOBYfnQhrPSw0FMeJjtM5+RJLTQDdM/QA/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jsKvKJK1dMaswVz9pPzsz9zH3GaDxAa8Wwq2AGt4FZ/5Iq5Gu
	uQLdtfFYMwKzd2m+XvT5LKF41q5K+4UxtZr+DKMJxY5LTlaLXqNZ2rtV
X-Gm-Gg: AYBFou3Sfr4EajqvzSrA8q4uNo3E68FJEGtMtrwDA7MgMlcAtj5gVUTqpF9QXI5wYdW
	D/PG8oofHbla0dZP4HcQNxgO4GQfq6cqDAf62bfZOnt1xVyEExHmZDvNlXFsfH9fE/xW1hYqXzc
	WQT+rqFpQCJOjmtHPFjSwT7zG77pZzEkD9yGiJDqj0ZhUKdszCyl/y1AxyJIomz5cj/y29/78fM
	5Jd9Q7EiiwEteN8tCni3nVkHTT3iKL5nMhNAr92LLnYbPk6HW5Pg818iyruARTv7fKRNxyjOQ2c
	2n0buycC5w0b9QFmLCWa5vhwrawIBFjfjv550Bqyf/jym1V8cWtbuKftSuU/VjT1dRg+AxB+WpS
	eWJMSuund25XT6MNrCHsiQuG9MSbszvzJsaQZLklfhhQj2KGKnwcTPPGLvE9kNezy2a/scl/Y8C
	m2j7fGKtRv+XoIkRoJ1rq7WOJlB9/oLdExJi+hJEcX7ENkG33D1CqmygCnDmmkgL2VEAEZFHoHu
	ph7vU3doj8jOUQwZoRK8oYFwpXoJTNazVxTnP5bqVRa2cYgy0RDNBzCN+TzEVHP8mvddIrsIU7g
	nR9b8MHGSaMof7vs3fzlkKpAlOmwlLszdiUvtBK4HBtuJ1nnp6BF
X-Received: by 2002:a05:701b:4591:10b0:1b2:46ee:4cba with SMTP id a92af1059eb24-1b269b2154dmr3020374c88.18.1794067677587;
        Sat, 07 Nov 2026 08:07:57 -0800 (PST)
Received: from LAPTOP-LJ15R92N.localdomain ([49.43.7.28])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4fd2d6sm15683821c88.23.2026.11.07.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:07:57 -0800 (PST)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH] rtc: as3722: check return value of platform_get_irq()
Date: Sat,  7 Nov 2026 16:08:39 +0000
Message-ID: <20261107160839.422-1-akshatrawat095@gmail.com>
X-Mailer: git-send-email 2.53.0
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

In as3722_rtc_probe(), the return value of platform_get_irq() is
assigned to as3722_rtc->alarm_irq without error checking.

If platform_get_irq() fails (such as returning -EPROBE_DEFER when the
parent interrupt controller is not yet ready), the driver logs an
invalid IRQ number in dev_info() and calls devm_request_threaded_irq()
with a negative value. This causes devm_request_threaded_irq() to fail
with -EINVAL and abort probe permanently, breaking deferred probing.

Check the return value of platform_get_irq() and return immediately on
failure to properly propagate errors.

Fixes: b45062619840 ("drivers/rtc/rtc-as3722: add RTC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
 drivers/rtc/rtc-as3722.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-as3722.c b/drivers/rtc/rtc-as3722.c
index 9682d6457b7f..dfa3628ad95b 100644
--- a/drivers/rtc/rtc-as3722.c
+++ b/drivers/rtc/rtc-as3722.c
@@ -198,6 +198,9 @@ static int as3722_rtc_probe(struct platform_device *pdev)
 	}
 
 	as3722_rtc->alarm_irq = platform_get_irq(pdev, 0);
+	if (as3722_rtc->alarm_irq < 0)
+		return as3722_rtc->alarm_irq;
+
 	dev_info(&pdev->dev, "RTC interrupt %d\n", as3722_rtc->alarm_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, as3722_rtc->alarm_irq, NULL,
-- 
2.56.0.windows.4

