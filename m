Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BD36BCC0
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704311; cv=none; b=JC+EdxjJBcKcvTHOTd9ZWjRc+54FwfoDeFJLRZSS2kJcwauDAXy0Tw4wu5qDKgbOJgJ57hoBXUlLnGlIzBQSv63KvwkWeJIYsXbR/0D8ON5n3YyMFq4Z4befm87G/dwjRowNOCwsl9Pr3GuQ4rBbJeZmSaooffbLufeRx9Oy0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704311; c=relaxed/simple;
	bh=65JrXnG8w3WfFz2sW7/e04u1FduXp2dNUbY8SsZkw48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VO38iYYHSIQM755gipb87MNW4v2mYpmGyeStk6TpPkDLTxP8Gg8h9VegZKRX6gvMUx1Rr8OpzfCsQMtmP1REpyx5JiqJafffibheJmRZvsEqBjnHpbZZWdkICzaB3xPf8hdejsZeOocxpTd0ACeW7d6+yfk1V/uf48XKxqiAMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayr0b8jJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayr0b8jJ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so851519a12.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704310; x=1784309110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=icxOE2DFF2D1zfrc2ISsm6d2uJsR1A14htLOcSkm9H8=;
        b=ayr0b8jJFpJdlNWn1DP+FXAU+ai8JGneluaJEq4IgzMr4Ylfm/mK3KSSyfkwBhjALP
         tVcNGgDKGDeah8DIraZnqwiF/fGGWF4x8cFobzIgdfYiVj2u9+9/nN39q97YnO2JhRb/
         YOE7C+v0XxUGx0sdF3qzqLFqBW5oZyojJuFUJ4newORr3q5h3Tx74QM5yCPrWYDE+Stg
         e0OSddrUlUxhqhFRo0D00l4O3sVe2nvIzVdASEtsTl3OlJGskeyo7izT+8lmFa2q/BkZ
         HW0OcVCLQI2l+zM0cXhC3OMAU2eykgwuRfSUwFKFhJmPYieNglO2RbhqdEkFfg9zD3JF
         MccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704310; x=1784309110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icxOE2DFF2D1zfrc2ISsm6d2uJsR1A14htLOcSkm9H8=;
        b=FcA8X1Fn/ZVXGeJBeUabdbk92prDq6T28/JQchmvOUGomWvbhmmz7OrpC9KxxclSCO
         krpd2x8LoJCyVW1eBxVAf/8GwfMDs07sWufzPyeULeOX/o6oEEyFBWbjtv/2VSoBgQkH
         XqJL0Z85C7hGiNM/zzyl1gieWTMCmvdwjsiHdXFPKxNcGT86kuqVkdHwuZ/LLxRx1loI
         nCR9WmX6Epn+Nrvvd9kaAvZTqTAQHeZisNQqo7BXmdEBCZ0VA2ztqUb/PsispAdUe83/
         YNh+i66fNS+dZNBXH4SwqicU8PcTd06+mNRpbxmXZHbEijsqSThVTGuRrFWJ9SLSjc8U
         5t5w==
X-Forwarded-Encrypted: i=1; AHgh+Rqp5vwQm91Wbnf96m+TYzpPHOVueme8JaBOze4RvUXjfEhDEPy+joQSd3c+i4pV/Zbe/essLkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fU6c92rxZkxC7rVUNTF+qFkhkE8HOgAY98W7eE4GN9TOjQnj
	VxlueyJC0nIjGqtjsjVu/Gk5gCi6xdqKtnyEaOjpj0ysIiq7Z89/Gl1i
X-Gm-Gg: AfdE7cnddiETPt1XuXC1G2tCrBbuxq5y5ZcOoSOcZtpF3cyFhr2kcZW4HkYXfSuI3c6
	1fU5QOammnvGGU+1dRX+KWzGU0Xzzc84bLXpS4teCLfVnMbMIaeVwWwO3lEtYWd/WN4DiY8/Zmz
	HJ2ifI1fQk6Yzi7phrh4+jf4jRCAMobL/W3VyzHagj6/sqjyrFqGbXLtrxGB4Yz2gpDPL+06BY5
	yoI53fXidnydEizHGBTOI6eQIXmn3fX6VOfS/JgaH6IGdJEtCYWDAkmKd+iJt4nvl6b0Ro/FZ7L
	8COKvXrs5BROrE/8ndt5Ynx0x12CuvWXl2Kp4eNuMbjatpZaBwnlxFbPX28rVAA/yeDYVSsjQ1E
	IHBJPawlcZe3IaOZWsB/jv+ocOiA2BC6eZy6p6ZU4SlP80c1lCASnCGotJaNbgyRpX7N44iVdZQ
	DX28j/oarpxjMyqMs1jU8qGh+93cA5DGKAYzNH6Yk/tdcSZ9nbbP6Jyd/4mohZOw==
X-Received: by 2002:a05:6a20:914b:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3c0bcec9fc8mr14760591637.27.1783704309572;
        Fri, 10 Jul 2026 10:25:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:5177:3103:5737:1752:bd47])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm32885135eec.9.2026.07.10.10.25.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 10:25:09 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: validate firmware patch bounds
Date: Fri, 10 Jul 2026 23:10:03 +0545
Message-ID: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtlbt_parse_firmware() copies patch_length - 4 bytes before appending the
firmware version. A malformed firmware patch shorter than the version field
can make this subtraction underflow and turn the copy into an oversized
read and write during Bluetooth setup.

The existing patch_offset + patch_length check can also wrap on 32-bit
architectures. Validate the patch length and range without arithmetic
overflow before allocating or copying the patch.

Fixes: db33c77dddc2 ("Bluetooth: btrtl: Create separate module for Realtek BT driver")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btrtl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 49ecb18fea45..7f54d2d2d13a 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -797,8 +797,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	}
 
 	BT_DBG("length=%x offset=%x index %d", patch_length, patch_offset, i);
-	min_size = patch_offset + patch_length;
-	if (btrtl_dev->fw_len < min_size)
+	if (patch_length < sizeof(epatch_info->fw_version) ||
+	    patch_offset > btrtl_dev->fw_len ||
+	    patch_length > btrtl_dev->fw_len - patch_offset)
 		return -EINVAL;
 
 	/* Copy the firmware into a new buffer and write the version at
-- 
2.51.2

