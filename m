Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450772;
	b=pWoEW5Edz34MsBjoA4s3Ck0a3EaHjjBS7TvT06ZeAkaU7U8icEPFHfm1Bnofl/IJfUeW
	 e2ZmsMHazs/Y1j8YhibSDPK1xjagfPnYROm4yQF1k4r7EZ1QV1RqT9HJz8E5IEaM3nrLH
	 lbDtXzVn1BNf39SJYx1NcmzO/BCF2VlJx3Or3uKWCrLUrPPdqgrX4udOmFrQr6kD4u4sN
	 0AHf/KCgYytlVNFGilo3q9UEhf509yk/Kxvj+bMFuosth/0udG5hJDUtGC8XscnXQuR0T
	 Bm/nZ3Re7/zsy+wQE+ZZpVUnkGCXRMXXwsdzdpMaInfa+LtDBSZYRuGzqrdO8/KYTVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q1NlEZrDBkcD8Q83Cfn+yNtsJtw5oz9oIXe3UlhpKnQ=;
	b=LSx4UOFhA1baT2z04YYOjp1NaPl94IplLHddHc/vapOKU+zSkJlRwWI6Lu5weDyykrFq
	 VHJudriCe5LW9EBxX7S4SB4hBzBfAclcKwZwmxpHgXh/X25N+8OSnUSFIGsWNCN+EvaDz
	 m3PJUDdzqlx5Whh7r84X+/PH2wZEv/8IH1vRd8rl2CO5xVc2MDQ3CPWim1R1Ap50ZRfTt
	 adJM7gAtgxfKCASvJtab/0m/+khjCrB5/CBnsnD2RpicEYLMAYM3gwEpZIzjRmIsOr+QJ
	 gG6JpU0FyM+KnutyVKX4yWiEH6WWcAoGsmQ4xQrpVkiG0G5c8SL6+vqUTBTFIuDssTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3HE3anr;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8F606A332
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B8F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3HE3anr
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490f38e9688so2446608f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795450770; x=1796055570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1NlEZrDBkcD8Q83Cfn+yNtsJtw5oz9oIXe3UlhpKnQ=;
        b=J3HE3anr17CRfmjbr4pYFXmqMFAxO6vTBN9siso/42jwueDIz3Ror5RHxzCIdQPHLY
         hef7m2ym8srdpC236g19L7Xqj9nSyHpsjhHGA8wHSSMqswuOyJcKT8HIZo5JjFnu9Oax
         w4BoNSYcXS/9qPInL0CA7ZaaDSE3ncQNvXIDxBBxtsqcntekfoW6WA4AOueSf40vfR4S
         +u3R6bYHolLAZA0AFGtxli/oKaVJ0zTXXBuyJMQMO3fSO/JfNpPAZuINSCOffsjOdxAZ
         dc7Zb50h5ngIgUkDBzk9eJBThIrdYHDbLERaa3Sq/usf5xjER5+9OTWBs2Iu4gGOxLwV
         6HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450770; x=1796055570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q1NlEZrDBkcD8Q83Cfn+yNtsJtw5oz9oIXe3UlhpKnQ=;
        b=hg1iIyDemEVtfsweFr0iwYjkz9LZJbN38oNLxjadhKUljZvzEaPMKbqvC1NPh62tB/
         dQaJRnE67bbMYKKvjVb1HpEBKpWJdRP3jnC948/jmF9thtg4g1qlyX3OANIy65NlHIej
         NfzBOl2xxzGZLF0Wm02Jwzm0ESCU0u/GzFGrEqz0oK6e3QRzc3E5dJdvySzHA7rYIejp
         xHEssKKP1krMIsQgSZ9de5gfSJSYxpa3nfDcAQ5Itgl3Y8lmYGPWGNVOtd8hGcmW1UcA
         mzUn68u0aBj8NW/p2+5a3ppNn/9tI5ywTGxjdcKTUttZRV0pNB/ZmaifjdC67bhT2m+F
         4Jeg==
X-Forwarded-Encrypted: i=1; AL+hErGeVqmBGf/Xd6dUql3zccQPRg3BtWdjf9mZF6McL8vjqpUuSH94GjBScaDXUNNKmKPGh669CJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pOoomxiJ1dqlWzYolGMn+2gDmFeumdLSY3DYI3av5fHxVND7P
	SDfPiL02ucylJIh2uLjs9ewNrXliBrRsmFu6n+yvFyoXXdLms/oYGK6S
X-Gm-Gg: AZFdTZemoTe64kC308scGUi5W+ZfrH5Zzwd1f4oQHnOa0d3GeLB/6tMyBQhG/qqIiRd
	UgJdeZEc7pWGmiI037eR+XXfYWFbMM+7j/Uhvcq0bFn7XBHgUbYA0qoAyn0j3JyIQMI9pjZXbgl
	FE0wTv2W3lHZaen9bXbPmIYG5K6owscNGC3c3MMv3MEzhEy4N0TI3KB8AncjDIeVx4X9d4ylZCW
	VCu9FJZCy7Kzq0xKKaLsnnwI/1GYmZp31JZkk0CFLbexYxGhIjAQTgpd/fbjX53kJ9c0OCwt8tJ
	Zm+j2EYtQmkkQRtTIuOGmEEKQMtd/pVx2THnhXFTDn2PsIocqNDfVj9Kuhybuy6RgcQMwHp1BoO
	zhtwIO3mFp3srZnhk5d5WAKIEDUAODbtA6cB9AG254cTrieDUzoxve9qiE71MIWI1AZ1kVHhIeT
	CBDQbSMDqeeygk/u4T9WbmTlw7VvmXtADqxQzzCpLD/+a3cofPBaPL/uUf4ZXRjtjEkmdw7E8pZ
	NgUwDkFfzHOOi6L/uSm+ilMtjoW8dLc9ntCedpjGYSu1O1V7Ajr/loldNr7PI3EE+FgTmwMvj+a
	lff/1KHJrwvMxxwaQ2utI++MOgrpD1V5sdevxhutgaa1Kb6uP1TUKd8ztbCr5wMVzv7m26FdRBf
	qdlhis+Bpupz1p8wkFT40aFfuAJ7PkWG1jlswSjOEr1N6PxryHKRXlCHnvlWN7m1vzPPRNHgPMx
	uK
X-Received: by 2002:a05:6000:2282:b0:48e:7833:2e7b with SMTP id ffacd0b85a97d-4aa4e01e1a6mr30798989f8f.1.1795450769822;
        Mon, 23 Nov 2026 08:19:29 -0800 (PST)
Received: from 2a02-842a-e30d-2a01-e309-fec9-0c54-1c6e.rev.sfr.net (2a02-842a-e30d-2a01-e309-fec9-0c54-1c6e.rev.sfr.net. [2a02:842a:e30d:2a01:e309:fec9:c54:1c6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab5ffcad11sm22323000f8f.0.2026.11.23.08.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:19:29 -0800 (PST)
From: Valentin Allemand <valentin.allmnd@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jimmy Su <jimmy.su@intel.com>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Valentin Allemand <valentin.allmnd@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov08x40: Fix burst fill writing past the end of the range
Date: Mon, 23 Nov 2026 17:19:10 +0100
Message-ID: <20261123161910.31956-1-valentin.allmnd@gmail.com>
X-Mailer: git-send-email 2.56.1
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

ov08x40_burst_fill_regs() sets the length of each write to the
adapter's max_write_len - 2 without clamping it to the number of
registers left to fill. Whenever the requested range is not a multiple
of that length, the last write runs past last_reg.

The burst fill is used for the two cross-talk tables (0x5a80-0x5b9f,
288 registers, and 0x5bc0-0x5f1f, 864 registers) after the mode
register list has been written. With i2c-usbio (max_write_len 4096)
each table is filled by a single 4094-byte write, which overwrites
thousands of registers past the end of the table with the fill value,
including registers set earlier by the mode list. This shows up as a
fine 4x4 pixel grid and blocky patches in the image. With an adapter
limited to 52 bytes, the last write of each table still overruns by
12 and 36 registers respectively.

Clamp each write to the number of registers left to fill, and loop
until all of them have been written.

Fixes: d0fef6de4f1b ("media: ov08x40: Fix burst write sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Valentin Allemand <valentin.allmnd@gmail.com>
---
 drivers/media/i2c/ov08x40.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index df2c63d64e62..4ddb202d5c32 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1461,22 +1461,24 @@ static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
 				   u16 last_reg,  u8 val)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
-	size_t num_regs, num_write_regs;
+	size_t num_regs, max_write_regs, num_write_regs;
 	int ret;
 
 	num_regs = last_reg - first_reg + 1;
-	num_write_regs = num_regs;
+	max_write_regs = num_regs;
 
 	if (client->adapter->quirks && client->adapter->quirks->max_write_len)
-		num_write_regs = client->adapter->quirks->max_write_len - 2;
+		max_write_regs = client->adapter->quirks->max_write_len - 2;
 
-	while (first_reg < last_reg) {
+	while (num_regs) {
+		num_write_regs = min(num_regs, max_write_regs);
 		ret = __ov08x40_burst_fill_regs(client, first_reg, last_reg,
 						num_write_regs, val);
 		if (ret)
 			return ret;
 
 		first_reg += num_write_regs;
+		num_regs -= num_write_regs;
 	}
 
 	return 0;

base-commit: b7ac871daee981f1963f632586ff9b9d898ce5dd
-- 
2.56.1

