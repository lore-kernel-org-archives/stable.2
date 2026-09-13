Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11523126BE1
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789273599; cv=none; b=G8DM+QDZV7JonHKKRLic9WU5J6H/whEzgmKF6YotB6arAhyUPyaFob015TWyYQKCAs8zwLjlcC5Eyc2yVIAVEnW1zYCbDv7aKppypRLupRgtH0VKBjjDZF9spa97hy2OHe2SigMyZiNHuXiMQT/ISDBJcRk+C4p/X9bxDsnO3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789273599; c=relaxed/simple;
	bh=l0EqM8munegQGAWYoLgSWbJr+elV0QzsYM8QaNsLACM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVbsNhpiCwJ784zqDZJTO0bgeYrDvEe7qhOsAtO/1lL9EwWdpxQPQ1jC48zX1RxBTvNeeVLGhIfEOvX4d5lXAPwLkcMk86ehxk8yAEwGuDl1Lg6R3I1YQ7YIyCLQyO/1uJD89P0BjE0nFVCvwdaxAqq2e2B6cfL5uF+7gYj+dF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2dGO1kO; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2dGO1kO"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e2f50d01so12403161cf.0
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789273596; x=1789878396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWc5ORGBMLSs59eoqsaA5DPnuqtjSJQmTTKP2X4y/Io=;
        b=R2dGO1kO0USDCB1Ru/oyWQGtAjnYQ0bUMxS6fCh6cpcgYiBn2lN6RdnvmZW8fz10Uq
         Dp77ehPJirvBD+d5ZDsKphaTsIakBtoh4CCub+02aOmZ1yjZOUW+9NVs8z2cIV5gYRAc
         M0BxEBpUwt9HwR0Tq324JBLph06iWhLEHexFGzjmnFYR1X8fPc3ybTc6rgWltgF19g9X
         UYXFdb982yhQ1uacPnnWtBng5zmO+0WZBtrkcSJIqZXVr+GEfDlWZSGVseHTIQJBcx4C
         05DXUwHSN0qUYWQN4m1g7jz/ozO7YUaOSohQHoMnDIV7kkAetTi4AWMl8q7H2W4wA2QZ
         lUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789273596; x=1789878396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWc5ORGBMLSs59eoqsaA5DPnuqtjSJQmTTKP2X4y/Io=;
        b=ZMylUKaBFjbng2Ox9Pqq95rHYpyakoxlTcS1xqR4ilQqZ3IiUOmfpl8YKGnxa7dOzH
         GoEsRGjjsrih0eeZwpb0mGXvubImdF/B1zdMpMNLwuzZ6lDX9sjmWBe19uYKtNgvi/nW
         F0EA1R0rKAWxCvu6ct1tOAGCyUAQBS5nGQYjDFinWsk8QbfE+lrWveesYyzRi1h9Fngk
         aDdzgzA0+9ahDJ4I3tM926xmOBiUUt1401JVyf/A8C2DbF2kdK6fJZA0KqmAJTSuy8cM
         /yO4oS4pBDWvu+yli1gV20+IKQpTHNMofONxil9c5yHJOG4AbBJk/kSxa9jzog7aMofn
         uHqg==
X-Forwarded-Encrypted: i=1; AKwUvBxEuEtP/d+XNJRIfiVQXM2vzIDepBOon+U7CciGzRyHBzneLCHIuq95YffmNjzdZUcZCltMxSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lcZcBNTXIgNgDhpnhszhX/8M9kZA1cPRLGWpEzecrvroQxW6HI
	Eip53d9mPZHS9rTn7iFM2nM9j/Ec1s7nKoNbvFIMV+hlCZOW7sbQ7e8=
X-Gm-Gg: AYBFou3lkl05TPSuwjCKHq/Ua/KV9OTJuU+K3T4iwoFWZBg3xDMjVCA5p36XKN3Pp4L
	l9S1HvJY/kHhK/YX1iZrpQvFupS8AWDh7mPdu23ZrgsxfSb4MgTrpan5Y7xu2ZXDviua73HdGwK
	V2r+8kgihamZ0uwVuDgvY3UmIW6TwJTdw9zbGELGk9oE4DodU6qduyMI4DSci65OHzq0pUXyP2R
	vc6Vm5pBWQ+wMGdlKWUOUkIwTk5vMCq17avAHVSZVEcZOWehGSlTHBKEI8sE+cJHiGmxNRFzU7c
	5zCpKxdQGN/7jeFXc2EQE+lG5AKEPbXw3xYPN8Km7SbYMC9u4u0wKCHDxN4pv0uzDY06EOQJDEp
	feKDySLkJenO/AFBIvxoGqm8NhmwQ87hmjrRclWw5B2qWoij1n7le5wj0NMhTaY1m7ZJAtF2Yty
	TEqtS4cdLzv41/hnrVSMj4YQUzZx7jGI8KTmesQh0p6RRS8GOTzuwqm8ayCPpWiBf4r4YQGobeH
	2HNt2zewfMHRRr6LQU72lu5WGMzBSujbE/IST6d8559Tw1lq88dAcUvHhybVFB+pzpk4k3/NgAS
	yRxusc0LbHP4tIuKthWg2Ks3q2Ud
X-Received: by 2002:a05:622a:295:b0:530:e01d:6003 with SMTP id d75a77b69052e-530e81ecc85mr78423631cf.49.1789273595966;
        Sat, 12 Sep 2026 21:26:35 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f2033e7sm62784096d6.4.2026.09.12.21.26.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 21:26:34 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Mark Greer <mgreer@animalcreek.com>,
	David Heidelberg <david@ixit.cz>
Cc: Paul Geurts <paul.geurts@prodrive-technologies.com>,
	linux-wireless@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] nfc: trf7970a: power down on startup RX gain failure
Date: Sun, 13 Sep 2026 00:26:25 -0400
Message-ID: <20260913042625.31296-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trf7970a_startup() powers up the device before applying the optional RX
gain reduction. If the register read or write fails, it returns without
undoing that power-up. Probe's unwind only drops the separate regulator
references acquired by probe, leaving the additional VIN enable from
startup unbalanced. The system resume caller also has no power-down on
this error.

Call trf7970a_power_down() before returning the RX gain error to deassert
the enable GPIOs, release the startup VIN reference and restore the
powered-off state. Runtime PM has not been enabled yet, so the full
shutdown helper is not appropriate here. Preserve the original SPI error.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5d69351820ea ("NFC: trf7970a: Create device-tree parameter for RX gain reduction")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/nfc/trf7970a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 60883001f..ddfc58c29 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1997,8 +1997,10 @@ static int trf7970a_startup(struct trf7970a *trf)
 		return ret;
 
 	ret = trf7970a_update_rx_gain_reduction(trf);
-	if (ret)
+	if (ret) {
+		trf7970a_power_down(trf);
 		return ret;
+	}
 
 	pm_runtime_set_active(trf->dev);
 	pm_runtime_enable(trf->dev);
