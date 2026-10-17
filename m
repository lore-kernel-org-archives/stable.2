Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BB39B4A5
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281458; cv=none; b=WfypyEfIDwKbTVWTkNmeT5DBU/Ln8bEmzvYTA1Or4Gzk2NKVMXUYTqcoa1sfq4sy0t6/5CEhHke/m172GqcFb5X1uM110/O+kt5oHSK4nuz3T0vaFZGXKoTSKLubmlrfMQ7/F9Dxx8bkBJ9NKXj+SO9oMtXd/RbqQvjZWq9bxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281458; c=relaxed/simple;
	bh=o2NBSx/FDXqBMksdU/mUlTzX6/bzw8/craKKvdkqRIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DEjX1qCzF2p9YcjU9EocCtBJFPxd/Mvlc4INPiOjKdnKyCsrxeuHirmt6fupD8939IGsi6SaAcuvDfVzniIc+zXW1VS4sNy1RZdGWOmjcbX2AUrOV9RpNGsGox1bnhnEcDg6JipoMGmsXVk43uG7mRzLlQwyQMgmpHqQgtTlyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlxL2WOB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlxL2WOB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so9999215e9.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792281456; x=1792886256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pex06CPzZvFqO9bOYfRUEtlWF/y2fI6jKIVDllT5g/E=;
        b=rlxL2WOBGgULzrCQFYBLIJu6zGUt4XvNu7tqg4nVHKJavNpjogHk/KWGnUX3oDMdqj
         FYbgVMcLwPH+qPkgl0Fs48NALE7r01XFFyZWGgBT5UKMNGdKnltzW1s4GvaJhh8z7IWK
         VFg8Ni1QVWm5B+Zcj3x5IpLy/jDMtXQnKCTFufAYZ8jlDGB9emnLdJYsOgzeO04QKtR5
         mtUp9lq6GJbFdug2Qj+13OQJMOlrtYscNo7xCbIL7pCT/RnSoB2SVBPaqmXDRzqm8Z1O
         KbpF4MV9g8R4ynJNBnZJkz/hz8rbBCkuJFLAZE3D02YuI2hzQQlJ7W80KdDDml10kR2f
         lQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792281456; x=1792886256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pex06CPzZvFqO9bOYfRUEtlWF/y2fI6jKIVDllT5g/E=;
        b=iltIJ4e//vixe+xqwBCTpa2C6kayAQevQg39ulvxqyTVvjR5tA6DrC4KWvtvQga7/v
         w5FvWGBj7LLqAl/4ovGIVnXiGyltqYdWDSqLYfGzrHd2fwx997LIhpKQnYOMoFF7Wg+/
         wm/v9eY99Aka1l2iHzi7i+/Zym3OmIqDca6a6kTV5nA5AeHcQPNoL8UhnZAkaz+oSPnf
         dC6Loyht1GjVN5CxVauUZu+GCWsVEIWIrweoApT4tqjbrg/1SX7SH56wUxiDF3o4gaM0
         htMnue/TZNcTDbNSgzmPKfG1T1axbsh5QJCaq+FJAz8GPmyX780FPuI9uMyzXm/pbreh
         TAQQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3UKE18GiCM0dVKwPVG7mFZtLdjqV/ZiTfzgfCSFqMvN6sH3aSuC4YicygNb30Nx/4AhcfxRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+zZCPv0FTXNH8+rPrtyAAnZWU/CSqSqmGXVsdb2CRZWmhrsFM
	exjZR8UL6KZLeSX5AzUS+5EZy6c1la+s4PV/5CyYjZ4UKRTTYYkfNYCi
X-Gm-Gg: AYBFou2NYu0tz0rPLtueUOGhqme9rUQkcu67MyeFTxQQduLotY9YwHitf5AIwrRA6gJ
	xVAOsCv9nmO87BXIH30eC8s/tw4xV9wq/tV8fsdaBYBfuPG66MKro0U5CLB5zZJH2+sDNt6NDsG
	uxJS6xvpq2dGe53UvaAlJRG/yo1B0CzRuf9OUMJryGXcEz+wTFC2f8ahWihYrbhd/mkqDd2D7bZ
	I3Uzq+VyvQTVK4YF0gCc33MeWqv/IXkd7qNrJBFV3RM/F2JV5Mv/Qv1rdxV6q1RrNwUk0U8QZCF
	5APPmNVnsRTc3KviX48fIfhs0usX4IK/6/2zJIVBKUVqrAJbKnXJODpHITJ276auh0Pt1HoHFIu
	BqtiMYWmH40qt7KaBcDW6J64a0Q8tYWFjnmpDRmfxDUUKXxox3nbI7cly4bdliKM/p9f6LaouG2
	MADDUf00f51aIXYlEuNHtr6xc/SeHFYZe8WXZJiPhTdM9+X83K7GMz89PQLrI7rx40pTo8uCHBF
	veNtEa52urCNfU5QdTAGXyImjB5SluTVbap3HAigd9fS9kTY/RzLf2Sz9D+ECH8PmtM
X-Received: by 2002:a05:600c:8219:b0:4a1:85d9:13be with SMTP id 5b1f17b1804b1-4a1d76031bfmr80634935e9.20.1792281455606;
        Sat, 17 Oct 2026 16:57:35 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf05009csm139331075e9.10.2026.10.17.16.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:57:35 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: joern@lazybastard.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev,
	raghunathpalla.0209@gmail.com,
	stable@vger.kernel.org,
	syzbot+c9d8bc9f8ccc03799e1f@syzkaller.appspotmail.com
Subject: [PATCH] mtd: phram: fix name leak when phram_setup() fails
Date: Sun, 18 Oct 2026 00:57:33 +0100
Message-Id: <20261017235733.14667-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_err() is a macro that prints the message and then does "return 1".
phram_setup() still uses it after parse_name() has allocated the device
name, with a "goto error" right after each call. That goto is never
reached, so the kfree(name) under the error label never runs and the
name leaks every time one of these checks fails.

syzbot hit this by writing "p0,0x8000000000000000,0" to
/sys/module/phram/parameters/phram. The zero length fails the
erasesize/len check and the "p0" string is leaked.

Use pr_err() for these five messages so we really jump to the error
label and free the name. This also means the real error code goes back
to the caller instead of 1, which sysfs returned to userspace as if one
byte had been written.

Fixes: 49c64df88057 ("mtd: phram: fix a double free issue in error path")
Cc: stable@vger.kernel.org
Reported-by: syzbot+c9d8bc9f8ccc03799e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9d8bc9f8ccc03799e1f
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
 drivers/mtd/devices/phram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index b42cadcd76b1..7aed57b31967 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -289,34 +289,34 @@ static int phram_setup(const char *val)
 
 	ret = parse_num64(&start, token[1]);
 	if (ret) {
-		parse_err("illegal start address\n");
+		pr_err("illegal start address\n");
 		goto error;
 	}
 
 	ret = parse_num64(&len, token[2]);
 	if (ret) {
-		parse_err("illegal device length\n");
+		pr_err("illegal device length\n");
 		goto error;
 	}
 
 	if (token[3]) {
 		ret = parse_num64(&erasesize, token[3]);
 		if (ret) {
-			parse_err("illegal erasesize\n");
+			pr_err("illegal erasesize\n");
 			goto error;
 		}
 	}
 
 	if (len == 0 || erasesize == 0 || erasesize > len
 	    || erasesize > UINT_MAX) {
-		parse_err("illegal erasesize or len\n");
+		pr_err("illegal erasesize or len\n");
 		ret = -EINVAL;
 		goto error;
 	}
 
 	div_u64_rem(len, (uint32_t)erasesize, &rem);
 	if (rem) {
-		parse_err("len is not multiple of erasesize\n");
+		pr_err("len is not multiple of erasesize\n");
 		ret = -EINVAL;
 		goto error;
 	}
-- 
2.34.1

