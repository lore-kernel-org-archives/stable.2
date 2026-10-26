Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013195;
	b=BDjSBPApZosQIWLW0Qd5qlQz7I27Zb2wPCjdnVPDXQYv+g2S6GViDQNods3jdxbdkNfq
	 /RT3eZKUc1AI9CmIjJM7Z7rqkdrl83rSTyJ96HKAqa9W7lijUEt0GGqxrQzA3wlqMcVHE
	 UK8OROTSV4rjPD6o/Tq1o8mMWpv7RNvpMt2tGoP4Nru7t+ceN5hNVouOXLfMCm8JYQyG6
	 8M9Zc+U8ndT4IEiZ+kDCv2smKI1z2DqsXAOrnPPKQ0Yz0PPSYibVlMSFKajkz15W4/rjU
	 fsPZsX9czxoznDlYbKnnBfI/toBVbFnRRhvTYIwjQxtUXRKS38ymq6Y4jGAB06ulacA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=44FELyA7Kt+MCPXIDXpQzdpRkek5ze01af2IV4Cf03E=;
	b=clMKwkmHOJnRpGhegsvtQExl8zgIdN3C8MTSySS7XNaSzchnfklkEWozEAqkpLyhQZ7s
	 CQeR0SDhRVpzvC/Rr8z1jvIIEzdjIF/0KbobFW26bE6sgAnatKbNi3xwGTu8NWIpEkQRt
	 nVkoe9drjkTwYaieTXwBLipYG7sVCyli+YOJA00DdFYXOQ3Ut2pD8U+9CgnQ8Uj1imYW1
	 ahG23SIUVXhZO4YOUfEtJWD3QWcS2/U5B0hGnfXHhu89R29wiljm37JIsLhgglpB+RpIo
	 7kAjb6xp/EAHuBzTXu1sXXQ0uWTkfF/AX5Gb3J2OzABTuBI4d78ZD/j6vSfGyg7CvVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LZhkHCHv;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B01606A336
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B01606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LZhkHCHv
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2107423b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013194; x=1793617994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=44FELyA7Kt+MCPXIDXpQzdpRkek5ze01af2IV4Cf03E=;
        b=LZhkHCHvsoG0TDM8rkXqEt0JDM3s5J6afDon/fYUgfIwEUn8yS69oKHbD0ldlIdw3e
         xIzEwVnyQwxbSeEJVpqIsRwfOjVj2ldoL1gglmDlrrTtUz/G9qiFigfnhIH2QYaG6oNL
         PSnIp6dO9nTMmwhu2b9yRm5xfS12q2J9zCuLzCJqeUOaXLjmOOl6iE9XeuzQjKvL4275
         6njJwcXOehJHOUvvMOGPpHNZ+aah8uZlwciGDWIzl+e7nSn65CGPLYLj2ZUaNgKG1kvt
         lixrzQwpqJaNdZPxh9Ea/DCrsnLdFcHMcr7iqos6oCnK7wPT5gRH6uscec+S7t1nrLnx
         8Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013194; x=1793617994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44FELyA7Kt+MCPXIDXpQzdpRkek5ze01af2IV4Cf03E=;
        b=SehSoQVbOwbW1ZoE0J22SE2jIPAMR7s9UeKpA4AoomRqz3izKs5NvhpclWlM5BBGr0
         htKnF8qNyo/s8K27+CgRIwSkRpa+wm3t5jP3ri1HIxbMyXtW8SdzMXPN5VAkHHoAGqc7
         Vk9vtbLtfcJiqzm85hs2zwOfq6RnAEQcQDEg+3rqchOSgymtdgLEPyh2drklSO7WRPnl
         pPeRK03GrNi4Dc/YUviCj/GiX9bRVYKdMabJmkaGFJ0T41B9+de0+TpzgjfnANp2+YYX
         LYXLx2tpaLvqbpGRWW36q8Q9BEQA0BbJTFc982wJ/nlRX6YR8xsE4liJwdhn9tIX70DD
         EAuA==
X-Forwarded-Encrypted: i=1; AKwUvByYRtyy54RL1utRaMy5EyjgOsNH5XeRjT0W/JnfLIXF3EdswkTtUMV/plpMlizPzib0HYvELUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSP1/wRv7quE5DfSz+wudMuLpONu06+y/4TYHoAqk8V9nwJyxS
	xyuf7Z2eWz1RKLOupwmRCTuhjvrKdbVBz2FWTFbi0FRSEUL4o/1ZbOlx
X-Gm-Gg: AYBFou1flSZhiGg9DbndDyBZS2F6dgspzgYWIX8eOQ5TU2wyXDWD1Ao17xxvbSU+OOv
	ajmwJjG0nFjQa19b9xgSO/1B6gxGSHiO9JiLlwLYAd7izvDSJP2VstCw+Y/FdKjYJK5ZyKAQx7u
	sT/OmEz3vAUE/WLqfdVoQqN+NCGEQ0gkjSWQD4h3TnAMFkvVjD/hVJzfZ59dafV3pcdFhxALqxM
	KQlT6+zMUzClOPzohu/5FpeQEaA7/3aKZlJ1HtY141gfSo9hCPHdM2J6BazI/aUUyAaTdIK2+JT
	A8QTrYnpH3px9F8GYeiWANiMjk8Z55C7BIc6gBumkkLCV9iacVGEkMMuYOBOcS+WsMbvPBkWk0Z
	1t32giENCYKiP/nHbbbrEiiuszCQ71WWRuFVvl04QoaVud8dmlqVg70geFFhhHznVM2UNO9mHIZ
	utzOi+z5nZkQPJIJCz0ZBSQgNcLzkpyWuZFtLq/oduwexsP8RW1XyrIHiptw2dC/naz1dab+ab+
	eejcHvpeWlchb+oxOH9GDusJMbo8crYJ1Q0aB3n
X-Received: by 2002:a05:6a20:914d:b0:3e0:dc12:8908 with SMTP id adf61e73a8af0-3e7cd50c6c0mr5002050637.81.1793013194179;
        Mon, 26 Oct 2026 04:13:14 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::8534])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c0fdfefsm1128535b3a.50.2026.10.26.04.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:13:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Lee, Chun-Yi" <jlee@suse.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Matthew Garrett <mjg@redhat.com>,
	Marek Vasut <marex@denx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: acer-wmi: fix UAF after accelerometer registration failure
Date: Mon, 26 Oct 2026 19:11:03 +0800
Message-ID: <20261026111103.4158855-1-lgs201920130244@gmail.com>
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

When input_register_device() fails in acer_wmi_accel_setup(), the error
path frees acer_wmi_accel_dev but leaves the global pointer non-NULL.

Since acer_wmi_init() ignores the accelerometer setup failure and
continues initialization, a later driver removal or initialization
failure can call input_unregister_device() on the dangling pointer,
resulting in a use-after-free.

Set acer_wmi_accel_dev to NULL after freeing it so that the cleanup
paths do not attempt to unregister the already-freed input device.

This issue was found by our static analysis tool under development.

Fixes: 1eb3fe1d3b6b ("ACER: Add support for accelerometer sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 61ae622c93d9..26e17aa04abb 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2681,6 +2681,7 @@ static int __init acer_wmi_accel_setup(void)
 
 err_free_dev:
 	input_free_device(acer_wmi_accel_dev);
+	acer_wmi_accel_dev = NULL;
 	return err;
 }
 
-- 
2.43.0

