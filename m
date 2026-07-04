Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B282388873
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783152988; cv=none; b=HFn4KGR1yuXQX88mkI0x40vzoBUdWQAc2wx79zPEnC+yhpD/crqMP89RUnDEu5MqZHQVafK280ZotITP/rUPrOZfS+9EclWeN3avwYlzWQ6FLnkPD1Sdtw1LPWP01fTiQRqAZS8NiMaTE5q9rSNEoc7TRapR/HbQZfMhvEr4UNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783152988; c=relaxed/simple;
	bh=ICYE2DkCV1p/9tLiNI3rxxRdRQI4UCN+8Zh+UvVQYCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDlOnZ+253gz2hdcdcTHzouFBsfZuPWanWvu3mZj9Hip3iHfDtae2XWDfAGGLxf71k6qmmPNPuZHCM2AsQ39alH+vwgOmAp+oJmMPoR1B335JVacBb51jC0+E9oQuO9lAA4VYW6cBHLXG2cptqJP7YbH4t0B0DFMmlKmbFSFkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUkT61TC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUkT61TC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382a3fe0d28so586105a91.0
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783152979; x=1783757779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TH3+2uge2X7v89K7Klwz73DAfKLAbdik2q1vKZDeHZI=;
        b=PUkT61TCOQ5SSgJOz8pkgCYMaNaQyDptKuIgNo3P5feZ0QGSc6fZg9EyusE5kQvj1f
         4SQFm7h+DiPwsDVG2Y4jj2ZUKBbK2vw9mwj9KuTb4jQjahlJ3SxZuIJMEwlV+aWFZkN7
         ltmK1KlPVxeouze3AiV9vJTZWut6pefkABQU11ENoxUh0wm3jApn3Kt9a3MQNnB6uAqc
         u8SVuE/avhs1SZFMQhDlVJlu1i/o5dWAw1d3uKNs3Hy6t8Ln0BNLvS4WsjSl4TkToewt
         A4I7f+5H02t9apI9fMretCCnVaY6YEEyS+HHrJkSddc/0F9/e8xSUaNOhsbqYDp6cj/n
         GoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783152979; x=1783757779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH3+2uge2X7v89K7Klwz73DAfKLAbdik2q1vKZDeHZI=;
        b=ni6GsGvUEZcBaMLeGLTcFBv+Kxck46VVQ3NDBXw1dOE8Uf2FD2hGkmpXTFsRCtfXmE
         RsgZ/+ZTE4nTi7civvoDOnD9z5Se8gTEm0VgnJsu/2I4g6ZNeKE8gy6BELlQdbbbX+jB
         TVYsiyhYFRthjk849UeOWRkeayg49vAH7Z1a8xzB3Q/J8oC0kThRbOpdK6dl8IfjDy6I
         GsnG+D3BOkvuLiBsyxUMyH9770sqjQTxUGRVD3WiUMS5PAYRaWGnknKvNQmGjCBA3FO0
         fgz7oNkb4QObPP0qzhqD6XdhTYqlITSEmt3rLukRTrau4oLxpskHCjMQwfh6hJMOkcvY
         GrnA==
X-Forwarded-Encrypted: i=1; AHgh+RoP4Ct9wvOkz2gO5fXLexyS1czxMgDchNjvhSF/KdWIPGHBr1/jbsVGHZDpH1iv69aOlQPvOhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rCdtEVLZvBOhGIyLhBYCr8XfDmy+48+yonbkc2K9vA2KteMj
	aaXs5oeU7T3yRzI8vpf3Mmz7T0TKHMoCc+phh4BvQuu2/B6OiR5OWIfI
X-Gm-Gg: AfdE7cl9AbXh5oA5zAF8+1GHTlUie+hd7d1VgA1mRS2zr+/clVQm294/cG2DDsmetRs
	BcM57uweQOl7Jcr8+ScaNw7pbMS4ZOJCf/HZue5LPyyuAbXLPbl7308vguE5ZmvCTndBmlGuRzF
	LyjVap3OXgFjwGmvb1R7OsnsJGsrbaK2561X46zMJiUikbC/qqxxCVw1bblmQWH3EwZuIKa6+xU
	VZcyKJnt9MIR2RiYXhlu+uMHUHN0yYB1ZVjwtJSMLNgAUTKgPYVt8cpiYGcVvw4ZH0KMYbeag/d
	Bob6+bhhw+eeiaY2urWpxAdaBuc4DNRx23zGsn7IV0luIRvSm1Lxos8TxHWTWxJq641uKytLo/h
	18V0iSD1oe0SBtLUiwdvRj/quSdnIgAjY+WJdv9q6EIk7ZydlGrIDx/cbn80y+cuYPS0r+j0G+j
	3iCoXM7XnmRGRdltdvDcoZ8L9IvItHkalw2Q==
X-Received: by 2002:a17:90b:5890:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-3829f4f0600mr2732468a91.26.1783152978511;
        Sat, 04 Jul 2026 01:16:18 -0700 (PDT)
Received: from Alvin.tail8ccd9a.ts.net ([101.12.233.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ca8046sm2112322a91.13.2026.07.04.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 01:16:18 -0700 (PDT)
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hao-Qun Huang <alvinhuang0603@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: greybus: hid: fix SET_REPORT return value
Date: Sat,  4 Jul 2026 16:16:13 +0800
Message-ID: <20260704081613.434445-1-alvinhuang0603@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__gb_hid_output_raw_report() stores the result of gb_hid_set_report()
in ret and even adjusts it to account for the report ID byte, but then
always returns 0.

This hides Greybus transport errors from HID_REQ_SET_REPORT callers,
and makes hidraw report zero bytes written to user space on success,
although hid_hw_raw_request() is expected to return the number of
bytes transferred or a negative errno. The sibling GET_REPORT path,
__gb_hid_get_raw_report(), already follows this convention.

Return ret like the other HID transport drivers do.

Fixes: 96eab779e198 ("greybus: hid: add HID class driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
---
diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index f1f9f6fbc00e..1d7186eecd23 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -256,7 +256,7 @@ static int __gb_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 	if (report_id && ret >= 0)
 		ret++; /* add report_id to the number of transferred bytes */
 
-	return 0;
+	return ret;
 }
 
 static int gb_hid_raw_request(struct hid_device *hid, unsigned char reportnum,
