Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539303;
	b=vTYyG0puUdJf0ALVJj17AFwkMIbBSZQ/S4169Iv5JnMK3OpVwUevW7dINclpxoQobnyb
	 6PJ4Q6//IZrJhIAzvcb6Cyn40qbOGTlD7JbJWs2eaWZ3llZ/Y5UfkUxFIT1G+j/7Z+SEU
	 E4TPhoxHwMnbtSwq29Dzfl11VimPt1PEBWy1mb4azlDyNKh1Ah6uyOWrR5hjI95RxclCj
	 4jPaPkuTCp97mjHQvJnU8M1Y94dPfWJPHe19eFOJZS0oYFYyvlRksJweXer257vVSkaVd
	 Y17ZeA9HgW8UowkK+7cl0Jt2nCUZmMdCNWriUcsdUKv9kfLx2FTWF3l0FKFuT1DKN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwFBADymfX8ovpyKegb0e90Tt8M0vYJIxJ9ZTAJlmds=;
	b=pQ6QQVwagZ/MxfAMv4U4XfBACt4TYYgE49MJG1PLK1X868IKh40IwPdOzxIb1whWKbZe
	 XDMDc/S3uuCA/M5HaMbFDUbDSFkhY11Xjt14GOLB1oehyn2vzD8JB5tQhJuoF+2zdmYZl
	 hWXNxNsEuTbEISp9s0OuwVY2OiJY3/LZ9W6r3r7KVop8IBkBB3qPUvXa6TF9/UfAMy4+p
	 0cM/6HW+FEJTiX54J6yDLMJI2j8Xl57ODGEAaWb24AwJhMlBv9IHfKLYxdZcrX4ujmWYy
	 GNAqRt08ZtGO0ptN3dIl+ThGV8T3IjgzbBtP2b4UHSmDZ8v4i23Zytn1/CMxCC2ts3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VLfrzNQE;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB20606A32A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 23:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB20606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VLfrzNQE
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso72682eec.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792539302; x=1793144102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WwFBADymfX8ovpyKegb0e90Tt8M0vYJIxJ9ZTAJlmds=;
        b=VLfrzNQEaXvhHebgyJi9HQ3LJu9UIw5QOEdw3LZu6jSCyU9rj187TQ2fqy44X6vOxY
         AniH4aStjLh309KZbfY0S6pfUzKwxNDvfpH1/EhxGZcR6xFyXtUb5zr+NrcHmd5NYz5X
         z4taRpmbfi0U3a8Oqm8ICnaTX+npSxJwrlM9p2lDOj99MYllJYsZ4YqkHAJ+AkU/TL9i
         C3E4ZsRlCYMZgI8UygxKWyqGqlr5KIFX5F4FHexZvUyimDHEqNkliDc3pyxy09XRjZ6o
         aF0yqiXXb+eXGUmZ38zXjoRsB+nw1e/l5qo4GkqoLtsIAcMP1wFUeWFgWa17A4wsYv3l
         pKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539302; x=1793144102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WwFBADymfX8ovpyKegb0e90Tt8M0vYJIxJ9ZTAJlmds=;
        b=aEg6ySZWMToFiv4XeReMuYqdlz8/c2aCaIDHhvsMHPR8IUKlXtUlueo52+HFKNJS0J
         EccVaPdo1lyWRa1DwHQVM1uPRM0731XX/CCWpYdTtXZmeejun1Kpd8kGEmTPPbh3DMVO
         5AKLSjEgVeorPZkU7q6/s1nuIZW+Dn/rV+EYpwUQdOEQDgRXkxonk/heLPehoiuUf1ND
         bHPWtyiOn+n2cFropXsm/ji6WQncI1RDw/uwbnQUXV4V6LOX7AJkWkcWE44lWD9rTXCw
         MT7VSzFI5PLuIQf5s1J9HdUVPmoAIoqoFdjuZBD4nu2T3WZdHQm1xIokwQZ+/yLaX+Ew
         3LLg==
X-Forwarded-Encrypted: i=1; AKwUvBw02iKdMuPfoV+45ccDbPglrbVY439omCKWlPo5OHCwiNinJjtELaq6MgwYVAMQATIDn2X3gug=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn5OaDh5r8998abDQRbzOZNvqSM6YTnPB8ft7HzOhjUtwVcUDP
	7PUUoZ8BXzFBKrjAzpZItI79bXmppSXci0GaGuZuLijsYkmrOVrCpR7ZWvt5uANh
X-Gm-Gg: AYBFou1wBpDxS+P+eel992TWnOsqin3dmVuDSreRMWkj3FBToS/FCHaqZHp11qvrrT5
	RQ7FJt441p8GlfPg0T9iNQjhaYzygpMsPSOi23QkNo496lIOEPssYC97vmk4rTT1ILcdI5WyerN
	sykCMEjPHirp5mtcI4Xj295qfm5cWuYHsLcjS4CMEfrTw2mqcU2UyfZw8aQ+ZkHnjyV3CM+QUAD
	UQ87KtfA7LarcasWv185th40WKBL0lKAYogF+PN2VJtkb977M4n+e3EqGdRqHmJGvNXNJOiqgWV
	tt5zc3DH61DRJqQp0/YElV8MxL1N1GIZSelw64wtAmZdMjRNMBfBs0/+Fh12BKQeSwvX2KRY/tp
	N96Taj2SCOOMRvv4Axig0XMNqvNed/ZKnEQVCsR5Fc9MAuWegQgyMAvLlBQloViD2xz9FgokIq8
	wOzD/qzUkFVE786SJFJT4eueJdnDxlmW7GqMrdWqv9K3pCDAnjNQOvecnIWrpeEQBT6JgV+1w8o
	awlNcmmqgYcnR2M1k82zFM4kl+vbo/1i7aP
X-Received: by 2002:a05:7300:e60d:b0:359:bd18:aab8 with SMTP id 5a478bee46e88-3674a41868fmr1503977eec.5.1792539301578;
        Tue, 20 Oct 2026 16:35:01 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm1825134eec.13.2026.10.20.16.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:35:01 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org
Cc: tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] time/namespace: Fix overflow when converting absolute deadlines
Date: Tue, 20 Oct 2026 23:34:33 +0000
Message-ID: <20261020233433.20997-1-dennylin0707@gmail.com>
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

do_timens_ktime_to_host() subtracts the namespace offset from an absolute
deadline and clamps the result to [0, KTIME_MAX]. A negative offset can
make a large deadline overflow to a negative value. Since ktime_t is
signed and KTIME_MAX is its maximum value, the subsequent comparison
against KTIME_MAX can never detect this overflow.

For example, with a -1 second boottime offset, an absolute CLOCK_BOOTTIME
timerfd deadline of KTIME_MAX can expire immediately. An absolute
clock_nanosleep() using the same clock and deadline can also return
immediately instead of waiting.

The earlier tim < offset check already handles the lower bound. A
negative subtraction result in the remaining branch therefore indicates
overflow. Detect that result and clamp it to KTIME_MAX.

Fixes: 89dd8eecfe961 ("time: Add do_timens_ktime_to_host() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 kernel/time/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 3aff27bb0a15..635f7e544bcc 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -51,7 +51,7 @@ ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 		tim = 0;
 	} else {
 		tim = ktime_sub(tim, offset);
-		if (unlikely(tim > KTIME_MAX))
+		if (unlikely(tim < 0))
 			tim = KTIME_MAX;
 	}
 
-- 
2.43.0

