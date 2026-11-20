Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164071;
	b=R9CBSNSg4YcPT/oaEZcU86c/6Ebbzw61WaNy/Ngi1l1qFXra9jfFGiC7U4e1FfZVEo1G
	 yflD06qQcjxwPa7NGUIHKI9iU3csalSbRxjeaP3BTTpiT03cK6o9+SmGjHBG+wWf+qDQM
	 IKxcDtZ9v9Rdt5+HtKIrYanAEK8oonSAtf3rMEr1ezcXcNFrRqvF5bennwwIu+dvuf7/V
	 k6G75N31T0zBZbsE89+EBgwbd20WaDUWecNS7rxjQFY6wgkBKD5fTz6W0UrKzdQNW+A83
	 bMZ50K24roUvv9D4K+PYL2tCp0ue0rp0GDxw/lH8D4PHWR4SAPBS7REnaD8BioQYFnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+q+bk6wBeU6DAMOAVWLCyHDeeW4f0hRfi2USDPpSdvY=;
	b=n3jubueDKjsDVRQcKk0ZeuYK83gfoHISJBSbbPqgUJIhNkLEc17GjViHwRs+CksIRngb
	 difDio2ZVvy55CDHfDhFXGtH5VGqy3eVIwUMvxbHt28Y3LFYTt9F4lIjPx1wnxE6BDY9C
	 s0xuILOBt4CJES1KlaGbXc19sNxxSplLGJIFM6ULebGbBc4G5Q5iYFjQnxGFhYKC5INd5
	 xcCOKhUC5WcMVe89wzbKfRkXE+TBGL0/tow5YjuPPrmorbpvV/m2VznvbaNXcM+LqdrjW
	 ypA0+X6fQ2+ijpnROXKiqxtd0kXEKDogt8e1/i9etGeR21TZ4UU/rRwD5dFZ3zHExWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFxXblBq;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF2F60A5BD7
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF2F60A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFxXblBq
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38431138772so774369eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164070; x=1795768870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+q+bk6wBeU6DAMOAVWLCyHDeeW4f0hRfi2USDPpSdvY=;
        b=BFxXblBq1otoODFiqEI2i/efkRllhYlVxPiXINOyzCa87lxGRzRvo4ysEgErBhelYs
         8k8DFKpTnbFiViNMEIcQiEl7ek4JT8smZcZwR/XoEUg0HXOQuXzyfIWYXJ3Dm6erP4ar
         JYZ1oZQQ5uDIg+6LlfR2OHha4IK4Ub9DWeLmUuLsYQwOOWF0dl/zF0hoiJTr48raameH
         ZaUn6fd0Dp2ppnh6GWoz7swz1kHULWeoKiqN5seP7dAB+Nd9/y/JMeQOQeHBW2+7pXCb
         HGJJr8XQjTy4uB1JCHT5Q0FaRY+004ORNMLRjWvcxTQ/li7WDeuwUZeG26j1d6Qo8OJy
         Jowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164070; x=1795768870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+q+bk6wBeU6DAMOAVWLCyHDeeW4f0hRfi2USDPpSdvY=;
        b=pZhQpDxWGDQdZ4R7Bxd3b0pRdK+Ek1PYKGekD9K14ZX3bYpvQl7dtnCeWYlTuYpud/
         rUqMmu9k927SCD9jkoQxDM5sh+3kBislxRr+DdCpWgC9BjzIfKKKBZoMwoWeNn1RthHV
         LC3cDeXdKjxD6mXQDNnIgDrv+1igl8tKsDeKfIRy1JY60Eml3wNvnsM6Eaz91BxaaNZC
         GFViltDGuqVV9kNo+P9RWuT1IQjAeZ24jmcDDDNcEFgj/zRfeROtOFv9LrRzzsrmrkTr
         yVoe5mHe9VW6Ir6hQLy9oAvVlauwWKMpn7lcQcd/6vd8T2UI2FeXeU6wRVkGXoD+zTRw
         yFrw==
X-Forwarded-Encrypted: i=1; AL+hErFv0XhvZ6gQ1vq+Mm4barCzxoZtBMO7Sfhkbk5ZfWYgF+jBMWJL8UO0Q0rMl/KZqxGRQrftBQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m9pqM8L4HVB3d3gKM0T6fO3QxAfs/pGGaVd0lLWAaTYq+3Wsr
	TUOkruXhFHVlhHV+Az0gVVuL+llFbnwuBi44DSJ5a1ukll0y+z1atI+W
X-Gm-Gg: AZFdTZd+I/YhkSaiXQA5TOLBM8JSAVZ+TMXw9OGKvSpjtGW3peMsGlfLZB+ViLXbfDZ
	Yfmnz6Fa04BEPgeV5tJ2G0NzgVQAeFhjpXgY6WzfwuqY/7oi8lD/zLaHSWUdjPYR6KsOEjO6u43
	AP9QOUHyXKv3mIRki4JO3a/L6MlNrotMsT7bLEl4QUCZwSk3xTtzpHpoz0L+BuKH+28xtdgqFqt
	25bIlxTtx88li6JL/eNBDudic2YrmFmDNvZ6iNIoxvu+3OMko3GJZY/8RJoelb4NeNH9w9L5Bhw
	lyR0WTVp1A77GlgfsU9bjZVRE9SXAmlRgzNbvthls7jvfKFsCUXFIjDdLlLGRtFWqyv0ACrP5vy
	w/t91sGKRDcgFNycYtFFULqGiffbnV7oD2m+oYaTQ5KbB699zmzUkNBSh4q5pfEkgZEb40ciG/2
	WQerNGIyCNoDjewl7N8wdg+yMdOCGpLkYp3oaxydjqr2LXGuytxWzl3B1pE1XPf3uJ43eJlcga4
	TXfnzuBsXcvyQs2zF7dN5O65PYDhLkeRKGdmt2O2sMiDNd1CZUUl+E+lKHIs7u1ErXeGltnrRCy
	DgJmezonXc5c8awcuM1TMM/DcfIX69KvrjtJWUIeIlBt1KMMkTFtprSZhqurWD6rgwerjF5ZZjp
	zlHgb9nUO82IACyPuWg==
X-Received: by 2002:a05:7301:fc02:b0:384:c043:c5c with SMTP id 5a478bee46e88-3856c6b3470mr1883528eec.3.1795164069863;
        Fri, 20 Nov 2026 00:41:09 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:08 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:56 -0800
Subject: [PATCH v3 08/14] HID: logitech-hidpp: do not retry timeouts and
 transport errors in hidpp_send_message_sync()
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
Message-Id: <20261120-hid-logitech-hidpp-v3-8-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

When a transport failure or timeout occurs, the synchronous send helper
clears the response buffer, setting its report ID to zero. Because the
retry loop only inspects valid HID++ short, long, and very long report
IDs to decide whether to return, a cleared buffer misses both checks and
falls through to the busy-retry path. Every transport error and timeout
is therefore misidentified as a busy error and retried three times while
holding the send mutex.

Return immediately when the low-level helper reports success or a
negative error code, and only retry when the device responds with an
explicit busy protocol error.

Fixes: aba7963544d4 ("HID: logitech-hidpp: Do not assume FAP in hidpp_send_message_sync()")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0264e4541edf..c486488efe99 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -364,6 +364,9 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 
 	do {
 		ret = __do_hidpp_send_message_sync(hidpp, message, response);
+		if (ret <= 0)
+			break;
+
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
 		    ret != HIDPP_ERROR_BUSY)
 			break;

-- 
2.56.1.750.gf70dc682cf-goog

