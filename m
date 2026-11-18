Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986591;
	b=XiFw1FGD/QVgnAhKzVLUEyJsDKQ3CInMKlB6ZuSL1dFfxiNYoBV0NjyIwnGIdtyMjc/P
	 C6QRSq9Y5+NNRfh59ZhG/IBf2KT8SY0Ze421KnjTNW3qAR6hOpuqKhVhBRMGsqLSg5nFd
	 1g+/64FVNO/n0qru981Si//byE9iTx9Lg/RCzJOHnMDUkttf61MVeq6EsL4R6RXxKj5xC
	 CFJHdnOBgivlZpO99+EEjpTuaNyHJwzZBLZh9L+nbuASIy0rZNbyAtCdh9FwKfe3OYtCh
	 8l66e1ucpmKE2BQfPId1oaYXW/o47FxvDoWMHTcjTdCHWjncGqQNYIbeMXXa8O3nT5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b8jhD9NyOgBY8U4+x22CAnEoBAUGT7c8YHeC5TZXIJI=;
	b=DEm+DVnr37hm2zqTuRaiFmwnZevAO5nJGWAUFXd+cQ5k12gcrgIyU+KPEOnLaFettSPT
	 Lqpd+l4LdJqnc3QN9YhaeEsqzV467wZD/fY6n5kYOOFPDHID9ati+l+ZHzZ7Fjry4Rglp
	 AXS3hVyn7aAKDx77XwGPl3SyxMU0nOffFATLSlqd9+drf/FKB/R2yKZqUVSjofn2MLKi6
	 P0/INMZwl/+XZ4Sq6DWAZE2uLRX+ZIuREJNItVP84Uhqg+N4U56TSvYVMeM2QqrW+oQCO
	 kgrujYw7ywCUkamgH98sc9XE/x4Xt2FQiDPvYW75kDLvjZlfMoVes94CH3yvgzJQcRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1frDFoe;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEB606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CDEB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1frDFoe
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1262015a91.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794986590; x=1795591390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8jhD9NyOgBY8U4+x22CAnEoBAUGT7c8YHeC5TZXIJI=;
        b=Z1frDFoem+7o/vGx2nbbSolor5KaZatEeUez6FRBzfmKkNIGkihGO9242gyljdFDrw
         P67bp1EjuAjEpwpwMw7T9kvfvVNpt7vjBOgI3BPtTAIR0Y8e8LFuUjX/COS7qFddQs/C
         vK5twTT7XHWS/D93Fvp9IF7aK8f4Ct3iV26cEJzS/V2VSERAZrxC61e4yDZiZKC3/dMn
         9iklpy1phor7eFJOg9GogU9VlxAVTnVRqA/SARD5y1Ok0c/MKmumhOkcsi8tFv44uEYw
         cm6cdKCA3F0BlaAhc66siWJbWTOOueL+xRIz4YMwbOgvvyeHJiNn0ib1MTjMgprZIeYb
         TyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794986591; x=1795591391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8jhD9NyOgBY8U4+x22CAnEoBAUGT7c8YHeC5TZXIJI=;
        b=CIwOHcDZ2NZA5miqIXfi3+5e4wDSOMCojFsLCmXJOYYe3Zx7u9GuKh7K7FjULfDR0S
         GNTz9CcDgsufDEvf1cMwqK7aKgw9+vexnyjAaxvPPf3XSo6O6WbWMiLpn1jslY5u2e4F
         z2MAmThT4ry7cLrLGx7IHVk2xCiXrHt4QnVqGwgt4bQrY7apgx3Tn70cz8FabXdMi3jh
         YfTsoUU1FobUXVoedmvCIW3CLr6sWE0qy9LY0t4Tso24srbzdEeJWVbzn1oWPUEfDXyn
         nATjp1ys+SUtah8kXWrPlu3hkUSdP/V43WbknLAJ2Nd3iG9kAdoTGkDKGdoT+o+CrAVR
         nOQQ==
X-Forwarded-Encrypted: i=1; AL+hErE9mRa2GCrcvC2Cl8k+7moU/HWruGWJs8MZJK0pBjZ4Of+rlWF7VLxwktsVHnuFKB+2OPs9z5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ERBVF+uPhxeLRQlQcBLJy/ObZDYgBfzxA8gYFi/rLqVOLtg+V
	BXeftFMzXYYqc3EfjY3SURI5JuIZl8g4AxL4VfmZuw4Y2Bae2fy8lqIm
X-Gm-Gg: AZFdTZftK9He1HmlXnlmqYPt0okukKWIy+iWKxRt8N2bALwFFbrSZOWUQhEMPUNVMBD
	l5EVP4PTNuhU4yGVNf/8HD3+Yc8vycC5DQcygwvl8FoyRJLcDy4Vsvao4IMYAS1p1DEhShhV2LR
	XLqb99D2qV5prDy7Q4FpavH82qJHK639cgUfypmkM2PST9db6Lt+M2il8EXKxjoNBlH3/HJX9fW
	nQODFYF0meBgdSkQ5H6BCEaDp2iJx+d4dMMb8tg8BLD6m1Vq7YBu2N3JZV9MpB+i7AgpW9vxb+S
	SXSG/B3fhV6Zcf1o8EKuDiUU9Ha/ADsZGl/yYHZPqbdf+ulVQAD/3ZPGh7sQpSD3bvsObAa0jH2
	W3ihdEjSB8ATTdKUni0nMwlJFMcbcSFecUjAHiJaomVOPLMgcIPZM9h/a5rH46PSVoeyrrKtMsB
	3mrwn19vY76givic11thrkEOtQLEPL1WHZMeYoKvKDJzFbHlQPFvPVzP0TrHMMP4VyRDzTwKN9c
	+xpHnpW/aeN9l2tTq5rTmu9tpnag07/1SEz09ugTOX8kbhu400Fa4zTnZYp5aqgJQ40f2otV1E8
	tvcUVUBD4rQEPPFIlKLRnsQswq3XARZHGYYvg6QurVysAaYEmlLD7Hq5wG3C+aDujIM7GA==
X-Received: by 2002:a17:90b:3147:b0:3ac:7406:b49 with SMTP id 98e67ed59e1d1-3b3d07bef84mr1108974a91.15.1794986588823;
        Tue, 17 Nov 2026 23:23:08 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d56c9c2csm1031783a91.3.2026.11.17.23.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:23:08 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Prasanth Ksr <prasanth.ksr@dell.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] platform/x86: dell-wmi-sysman: fix heap OOB when scanning for a newline
Date: Wed, 18 Nov 2026 16:22:53 +0900
Message-ID: <20261118072253.896390-1-hj351016@gmail.com>
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

The current_value and new_password store handlers copy the input with
kstrdup(), which stops at the first NUL, and then search the copy for a
newline with memchr() over the full write size. If the written data
contains an embedded NUL, memchr() reads past the end of the copy, and
a newline found there is overwritten with a NUL byte.

The copy is NUL-terminated, so use strchr() instead.

This is the same issue that was fixed in hp-bioscfg by commit
ea146aaac690 ("platform/x86: hp-bioscfg: fix heap OOB in
hp_enforce_single_line_input()").

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h    | 2 +-
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
index eb48ced55823..808ff9e70add 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
@@ -144,7 +144,7 @@ static ssize_t curr_val##_store(struct kobject *kobj,				\
 	buf_cp = kstrdup(buf, GFP_KERNEL);					\
 	if (!buf_cp)								\
 		return -ENOMEM;							\
-	p = memchr(buf_cp, '\n', count);					\
+	p = strchr(buf_cp, '\n');						\
 										\
 	if (p != NULL)								\
 		*p = '\0';							\
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
index be939b731063..9677811436bc 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -79,7 +79,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 	buf_cp = kstrdup(buf, GFP_KERNEL);
 	if (!buf_cp)
 		return -ENOMEM;
-	p = memchr(buf_cp, '\n', count);
+	p = strchr(buf_cp, '\n');
 
 	if (p != NULL)
 		*p = '\0';
-- 
2.43.0

