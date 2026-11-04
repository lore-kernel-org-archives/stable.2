Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801266;
	b=kQtDv8fJ1XkiImaHyiNlYXYj+IxdpjQDLFoOUbWAjPmh3jJXAUMIIi2bGP189MfE3HRR
	 4qMZA7sn9SigiFLVFJnk5bMw4JheApbH4gDa/5GqCG8xTnX81IYZ+8q7tX90BKLU09Rqu
	 /ukTzXSJ7SEEWEGmIlQPjVpRm4NGECtfymat7BV6Hj0eGlt+x5anyxjj6UNB3WrCP+2+o
	 QFR7jp4NDy50eW56a2bvswtNnQHj5CZlL/lWCbKZzX0UnHrCApnmz2dBH186J1Le3y22k
	 IohfPZ7DIxQqf9hdUtPC+gWd8FNfpacSSDXLrRQvObXYKzDXwwPgW6JldXfg+mjjg5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cq1h4+ONwtAezyaksz2FMWNnWoV6ehnNK390tiSgqPg=;
	b=GZ8f+HLcreRJbDd6+v9VWqLhHd24bzwqTYRmDEnb3onl6UjkrReGSP5jKFtu7M2p1mb0
	 tQHoopild13m11uBjfjyeqllh6wDBmzmsRMSO8Bye+gk33EhxxYUZ8bGAsUpU3Sg6se2d
	 NtIxH5Dogr47n7No6K+lpfEfo8xAtgCr4AcD7WOEDe1dky0YtM5/3mAJkteaWDo2q/+en
	 +/8ZqKEcTnf7AMqXV2nO+5SNGL9MCcaOgO62Y/FA4s/55SxJ97Q6vGEOOEmR4BLay7YR2
	 6zvHX1Icd5DG8cJw2rk5DJhgPuvUYtVn71U1wBOt/pBB5ksmfkumPMza1SkrrOt5O4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQVHLjUU;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB6606A335
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31CB6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQVHLjUU
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b09cc7ed1aso58785a91.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 06:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801265; x=1794406065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cq1h4+ONwtAezyaksz2FMWNnWoV6ehnNK390tiSgqPg=;
        b=aQVHLjUUvc+RTbCC5A3JUXiBiwuj89jDNl7XoUtPmDn0jR3QO+CGYfAWxmx33xC6lT
         SkHRx5GXN/ZiWqr/kOLtlLKWp/STozQ7taoj2mLpipxq8M76pGQgaF8Piq7S7+hl/wfB
         g0aq3MbYxKSXLb0t0Uh1QfVXEgOVMipz9FYfkfc2V6bgPQC3qZgbX7lUk/8IC/5M9Gma
         lW3ILBx9Aju2wfopx5UYuTXERTto9gc7pRptfiMccEGHrj3AxBEZrq7GTe1d3spvpk/m
         vkr9web93IX+gdgc4gxXbEzV7zfmYVYeuDiCjOk0FqIr1V51EVDohrdYbBUsaH6EbCkF
         VShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801265; x=1794406065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cq1h4+ONwtAezyaksz2FMWNnWoV6ehnNK390tiSgqPg=;
        b=rAH2t2RRFKqKsqXrOlMqu2NkuCpu5JeZGnXM8bmib3fV8MwzGyohEFNaG2xtAJWg+9
         hAcRxLK9wZxWgF4iuhrgpUNlCOJ4UtDRDG7LdOM4gaFM7msErKyTHVAGkGKcA97leUeF
         mZDrZMD9hPuIAcdl1eqNyGJJ2F/Kh8pvqig9QnRwbS4/tGLvcdT5zPzn0OCeBs/VfUNz
         /4Vo5etZbmADLfwOrglPGCiOMutkWpCIHV8N+Rx97HS3QbS9ruhmKWSBwEjJRvehSdJp
         cFjnJR8LUUDKTY7KIrHjyyUn4w28IRgtuxWV6HOSMYcLy7W8hy+Qj4UtrUXR87zbXh38
         ZEww==
X-Forwarded-Encrypted: i=1; AKwUvBwa8rvBS3WuAQa3ALiJlhz2+R5w5Gw+t5Bm6mivGfmKHm0pXWoBQP0PC57jC6b0bvzcEGUOXx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wpVXn/IUMnnbIiqusGO/jdh01QrEHfThY3/EK2zJGks5ASLFT
	rimKbkBVWQxI5BmvmYpkUbMapcvFM+yjoQ4y3ilMNHMVqkXTYOenjD0v
X-Gm-Gg: AYBFou3YRsdk4NTx66nWtmbBhxG5OITUWFfhZGK/253Fi1tEAtZD6p4B/TkAwDoxkyw
	48PDTrbgX4qdS7Tm1oSq9aD4Gc/rlw5bwGgFQuztHSIScnK0VrApQGftuAVOICk5ZxUzCPwv2zQ
	1Z8emjOlFNacRQvXzE4rDTNXNNIZuPoPLWJplsnlxzFDPW25rnAccljU0dtvAxkUA/hUwGvkcUt
	2YS8pQp1iFwohwTWD/QV7+B2yxmOeoVQqVqu6dVbZ1PgwUXo53yVWN8uZPT5P90czl/0pekNmEH
	k6cw1XnixjnT9a93K6ApPVEZLHRoYUk2py07c2/ZgXhKQhPjTuY4aCjQBy9+lyeT/QEagf4Xoju
	O102V/VikcFpaQ/9xFUXrKL0NmSSmnrS7H+FITAULA/zZCvwpdo3D08f2y+u3pmPv1YuYVvNiq9
	oZ9ts8CRg567C+RTN0V6VQR2/rf/4MBJXpAdEKHcgaxXPj18tYOjFLmPh2H10zXoAxKRqZsUIjA
	sknU4t+hYYhwitgLGTnmhPfNAiRG3NMmrVhWKKmledcUMUvt33tlbvw14NgygZyFHpxlerncU0g
	Dww1xIHqPmg0PiFdhyg2P55cFFpT5Q/YMo1rkLzY9A==
X-Received: by 2002:a17:90b:3693:b0:3b0:accf:5c65 with SMTP id 98e67ed59e1d1-3b0accf61d8mr241791a91.6.1793801265362;
        Wed, 04 Nov 2026 06:07:45 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b3b7esm7379556eec.28.2026.11.04.06.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:07:44 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2] regulator: disable disable_work for good in regulator_unregister()
Date: Wed,  4 Nov 2026 22:07:22 +0800
Message-Id: <20261104140722.389859-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

regulator_unregister() stops rdev->disable_work with
flush_work(&dw->work), which is a no-op for a delayed_work pending on
the timer wheel: flush_work() only waits for a queued or running work
item.  A disable deferred by a consumer's regulator_disable_deferred()
therefore survives the provider's unbind, and regulator_disable_work()
fires after device_unregister() has freed the rdev, dereferencing it
via container_of().  Use-after-free.

The in-tree users are ASoC DAPM regulator widgets with a 20 ms
power-down delay (sound/soc/soc-dapm.c): the window is the entire
deferral period, not a race between adjacent instructions.

Use disable_delayed_work_sync(): it dequeues a timer-pending instance
and waits for a running callback, and keeps the work disabled so a
concurrent regulator_disable_deferred() cannot re-arm it while the
teardown proceeds.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v2: switch to disable_delayed_work_sync() (Mark Brown): also keeps the
    work disabled so nothing can re-arm it past the teardown.

v1: https://lore.kernel.org/r/20261103174911.1600930-1-lui2012qwq@gmail.com

 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6a4008f387b5..4ba0457c4747 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6300,7 +6300,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 		regulator_put(rdev->supply);
 	}
 
-	flush_work(&rdev->disable_work.work);
+	disable_delayed_work_sync(&rdev->disable_work);
 
 	mutex_lock(&regulator_list_mutex);
 
-- 
2.25.1

