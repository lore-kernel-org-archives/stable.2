Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C63BFE41
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904354; cv=none; b=M7DQgU/lpylq5KIHZpGEntY7T08KoSR6YXXgkCYBgbglTWP3uGLb81DiY0E5RwRoDlRvv3rv329UfTs2YBTHMTBspS72EBpSP4FcPvvt+m2L914I8HcKC32z3JH/x303t4BEdkX2+xXi3PK5sftLuzpOEMBaJg7iPS5wXwmiWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904354; c=relaxed/simple;
	bh=aeXVj6xt4QLaE5ZubVLapizM3pMzsZveZsZvA4exgZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LrSbbTgCeiN6XjkP4K4s9GiGw47W6YrgovPmqje1JNOx7AXMFPapmDPm5eIm+KK/ts7wbo0rru6cnNnp15m3XT21w0IWwZYW86w6J8tG5dcZaU3LwMHhI77W3oJ2y0rTrTxTot+ba3fmBECE6mQ/De9qHazNpfTYkLPldmUR6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Ob0bBk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Ob0bBk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9f10fa7a3so4336855ad.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782904353; x=1783509153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWJtxV4Ta72iy42vKEzWLu7hcuhePMIVVuTHVh0+3Bw=;
        b=R4Ob0bBk3lEKb4xAyIkFLcf5k31lef9NAc2PGKv1DNcrGEITFCYCwWHkLNti3tpgEZ
         zZVvnk3UdaGD7XEaWdVGGIQBPmgXCnUasW71a452uO7F+NEGmA+M/g8UPZvOOs6wzFVN
         TejK6oZnF/Yf4r1/7T7XvxqYUA+VFMNr4CgKzS4sCm6gJDWKsT3jbgHjASr2j9lVmeZg
         V6KS6cpI6zwDSCkP58GgCk3DiQHe0xaD2yw/ZuSPU2kIZn3cSC5DTTJWm+4w94gslM4S
         Q/0CS84f5cin9tJEY1U2R42YHRAsk/UsDmhaJ/OIuD/jwgn4NILEFJkWFIj1EgM/82rG
         5+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782904353; x=1783509153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWJtxV4Ta72iy42vKEzWLu7hcuhePMIVVuTHVh0+3Bw=;
        b=o9v7eQLp2XmjVhw46EwMlIkfISbgts6QTUeeieERhFYy52pvdYLYfojpjbYKt3zuxf
         KRCNlpxujCuDsqRHev/MYhY8L6+QWNhDMOSvEC/hKurImmD0nf0jIY2HVZ6BJk9PRma+
         9s7B4HiPz5p03A01RG1yYwvsXWXANt9YUCu/6LRLKeAha0X7GIpkP6Vc58mXeIIOYTpW
         8povlssZC6unpVhzkLp7YJ2ERkuRn6HLgWMQFjMtNmHy43Hcu7Im8dnNWwKC+A2pjjML
         XrIDlXkOQdiY9Qj+qNRYV0xXqqq9z4TjlM0Abdbk/5Wbu0/aif7iA/kbNulVGc8PBKA0
         TnvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+76g+uXKIxMf5igpHpcikZQVW97Kkbsw+BAfMsE1TqVcYP+z8+7DXjQXs5onspSYQj1FRTuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jgW9dqbA0G/ghqzwni/8uqLyiIEmnxNa3BVs9f9d7ku2B4B3
	Pj9IQ8ePWoYqAmC9nW7mM9jBF+KKliecLThZK6rpPZwdheEJm2uOp6U=
X-Gm-Gg: AfdE7cmte5hruUuM7kb85pMQzJ5GwssQrRgy3L7T7DBcqKrhSrqmB5z/+HJqGbpfwMv
	Kdms8Up3G7hyoPp0d0jmplnGIqn7IbNsMW8riLFz3I3gKFXT2ZNa+nc3ZVLD80MjVkhifxsMWTc
	fnTm5kiZJe8M8JtOB6SWymymSAS6Fz2hpvZEQjzuoN5hMiDadKHM3IjHAHSw24JJUtM7GBUG6N9
	qkJ1a1/hZgzLK2uxpZa7BOVhDJ08ZzCFM6SqKFq/6kIV7dLzEIwewyLmFOEmndImREIOnIAxxIp
	XNhs3SfRG0JfEacgjFIyV+hikATkdynEulA277C8vzPYHekqpk7LDwMT4LCzIecNOqBzyh3/sjP
	2nw0D03sowYU2i605LxeiX6oceUfukkS99Vzu6QSo4Fleg5YXupwfnW2OATpppangHjLp4N6RUT
	vLcwh5v7lxxm/7rnDr7h7vg4YaBcTzuP8Kz5MuT5kRBdtgg7SP7CBkYn0XQrRGDpXAWhHlaBn27
	ScaQKZ06TnX58xC+NOz5P+jQ+nozEUOOC7e1MoofXt0tJgJyA==
X-Received: by 2002:a17:902:d4cd:b0:2c9:bd64:8c81 with SMTP id d9443c01a7336-2ca7e6d9f27mr12395735ad.18.1782904352730;
        Wed, 01 Jul 2026 04:12:32 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a71053sm30977565ad.8.2026.07.01.04.12.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:12:31 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] fbdev: uvesafb: unregister connector callback on init failure
Date: Wed,  1 Jul 2026 20:12:24 +0900
Message-Id: <20260701111224.48646-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uvesafb_init() registers the v86d connector callback before registering
the platform driver. If platform_driver_register() fails, the function
returns the error directly and leaves the connector callback registered.

The later platform-device failure path already unregisters the callback.
Add the same cleanup before the final return when platform-driver
registration fails.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 9d82326c744f..ccc9dbc25813 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1907,6 +1907,8 @@ static int uvesafb_init(void)
 			err = 0;
 		}
 	}
+	if (err)
+		cn_del_callback(&uvesafb_cn_id);
 	return err;
 }
 
-- 
2.47.1
