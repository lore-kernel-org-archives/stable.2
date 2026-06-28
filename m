Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD0242D88
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782638943; cv=none; b=ACRV1JxLxPkopiEOoxlrxUrNTWA4jtWP7Kb0Zi09o5uxC2opKVCuMj3WBr9zpZIPsc6g3mVj9RuzJJmcbYEgzPV1Ru5iJdGKg81zDt9hCumIrTc82vxrthyqORXXf8vjLOPna1TdoCaVMdwyp+cuJyJocjzwwjzlC8FMd5+pxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782638943; c=relaxed/simple;
	bh=g3TEEhSCxa22KRzyGSBbXztaApgxMd71thbKhrfdhH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4QTeT/XLjVyaeoE6NCpFflGWvoPqDzFdhLA1fHU+FWGrXHvte64pzLjrVpHj5d/ZzRL87km7FUKJM9bgxvvPc1WTExmNpN7cPsPb8RQMMlBE+wBu7PCpVxy+sKRt2izZcGLUNoAJ7ignZCow3qp3BQRatKg1xGUZpmDRt/jC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IigX29/Y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IigX29/Y"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80b0cd40dafso21888287b3.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782638940; x=1783243740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBRPtbJqkKNZ5K9wV4Mq8UH+00E10dqVKsU9yLUE8eI=;
        b=IigX29/YhnMkZOB9DNFpOEP0mWnZySasxJ1I3piH05xD0NsO5NC/+45L32c8AFjunH
         jnHWLM196wfYxIsgIFb8UhHd3i8+VQtCPWaC1YKyNzY/hWFv7LovwbeFYaysUeymVgw+
         k48geaKAcF36YyRQANprM9Y7VNzehIi44b9eg0S41agWfp//yHUGZoiJGPo50H/OCvdT
         V9FBLRBE1isbJ4/XaNoL4qdhATBNB2K7bJvdaY9P3ATKj6b7UwVfdECDeB8eGiYVKvNn
         Vtg3zZzM7FHjEMntBzBVjJ3wrmQJDfwlZ9gLU9ISbpAEIQsjxwqobXvLcjcxYBsWEist
         ZCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782638940; x=1783243740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBRPtbJqkKNZ5K9wV4Mq8UH+00E10dqVKsU9yLUE8eI=;
        b=nsmXIa1s2y4k8NjWHneUWSWYM9K75gvYewNT1hOGO2oIi31N23otz6P4Nw24jQfCwH
         6179qw8qF44n127zWidAxOLZi+e3Ojj1uFl6ybgX2E5u5WFTI1vg3vY3suoYWTzmC2na
         HY5z18sTB/0aqnoUJ5sAT6uAw6YlJrscxhb4EJfUWDamjcF067vO1ra9HEv7oRuPRBpo
         LTN8mQBdCDRikiPPbyxUEaAm52bADRFgPv1Ssbgvbx5YSu5fQAc4saf17BQleap+LOog
         5VePtX9qdB1KTAgmj+s5w0FeTEX0N0/V6SVS3eOZfIFVMmgcZNj8lBylYJAzBJSCll4g
         AeXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rob0OpsQ1OXsdHmAWx2i+YZ2J0/D72+U+Z72wg7CwZhrbtx4kkU8tu3huuKiB66E0n6ymu3lnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaP0DRd3Z76gJMIHDcAilUBAj1g1qLHoKEdMtZmuQB03f5rtII
	EVUv8dtGmlx+Fs4vI79fxOyzlgOiM4N+dSe/ImuzW2raXWYyN0/6F2q0
X-Gm-Gg: AfdE7cmxmz2nn9vhbf6Zd1EDpxQqa+F2i2Rk55p5cNjzzdk2PHVylSEeVV6TMnZS9Qi
	3Zzmy+LwvUYiGV5K/Uq9kYovh+wpBm6FjWPF5rqYUtC5mDEcpuUsVNQHWnnOVthfW6fzOja5D5A
	wBBKhcllTvAFTaom8Lacj+A19JieHySVnwJ7GAvMTebyrzibeLh/iYrbXWYZa0GOsHN1ogEPlD5
	NVEC+qtr6N3YvhPHzVa5ToncjU9xoZpbGTWbgCMb44DexYaS8dC6oUlMYFtflkQhIrAWxRM5ySX
	8OKdJuFvzzhT7w8jz8N5xeAJgehCEYJRpLgG2Eu9ecuJ5K1WPjS/f4O7YQNXGZg9jl69KYvOvpu
	SZL9fhpXj5VX72lljtO+qHECHuttfOxaZbeh/C4JWaSXigH3sSJP8p/nYABo2IPWFdvo8gLTKOq
	ciV/DDldZKvpXBlnumbsAZQPp/dQ==
X-Received: by 2002:a05:690e:e89:b0:664:9ffb:e4c with SMTP id 956f58d0204a3-6649ffb1e1amr7317427d50.15.1782638940444;
        Sun, 28 Jun 2026 02:29:00 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-664b8d0842asm1882897d50.19.2026.06.28.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:28:59 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] wifi: carl9170: reject mismatched command response lengths
Date: Sun, 28 Jun 2026 11:28:14 +0200
Message-ID: <20260628092814.40583-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware response length is controlled by the USB device. Although
carl9170_cmd_callback() detects when it differs from the output buffer
length, the function falls through and copies the entire response into
that buffer. Callers commonly provide stack objects, so a malformed
response can overwrite the kernel stack.

Return after scheduling device recovery. This also preserves the stated
behavior of leaving the command incomplete so that its waiter times out
and clears the pending output buffer.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/wireless/ath/carl9170/rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 6833430130f4..ea3f435fb64c 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -145,6 +145,7 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 		 * and we get a stack trace from there.
 		 */
 		carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
+		return;
 	}
 
 	spin_lock(&ar->cmd_lock);
-- 
2.54.0

