Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358916;
	b=GIp5vzkbHUYiGPR/k5/D11FjhD5IFyrG3hWKp7wSffe6uLUOU4BNBhoH3eZ2ofw+UMpE
	 Dx2vguSH7C4vxDogWzhjzMxgmWNpwq37FTNm1arOqyfmbPAT4H5BTp/HR8xFwOMO02r9S
	 d4U/R+llh2jaueIJmbngt9g7gfm4k+lsPQS8wwghzveusKYm98cpFFf1ltHFTux1P8za/
	 sJXRSp1i4h62zJsKw6JwPx93wX60C+oNxY/b4uVpX+vRSrVcpwfcuzGAkc/5O94a4KY6/
	 wUwnrBDOCNJ/VHC3R7Qoqij7ltUJiselSEfu/5iGimNRvP0HBsHTbG2AFN640mRAnwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Ju3+Kzur//wZ1L6j9QF+ag4oEga6H+h5IALePIcZepg=;
	b=opXNWRL8QSiLz7VoBe6okWaBE2MXp9MU7MNHTAxvjaDFvUkTDG1/d7emchh/NYkqGYNZ
	 G3LLZpvCFajggh5YtXVKXzfkYNdETIBvMtQEZHdtqily20MYKkyUZMlcGC5imGwsXPGHV
	 OjTym8fH0znI9tgVsf46J6gT9+qckUSYcO7nktFzuq5jbVavPQRaxgy9vkIz/M1rTR3S5
	 8sRmpabvO+gAq14BfisoACWr109FLtPp0C9OhxqGOPlm3GrC8nrIdUSdaUHw1TLvQ48Vu
	 bRNk1WF/ccLleLGHlThDB6+6NRaBb2WqStCHAv5f+u9jiIv8orPSh9+ayobkCnJ1xHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=X1HvDEFS;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934C606A32A;
	Sun, 22 Nov 2026 14:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4934C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=X1HvDEFS
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXX4x2cQpz5BNS0;
	Sun, 22 Nov 2026 22:48:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795358913;
	bh=0qJjM47HXnOSi2reeQMhqCNH+1k6sf1nNxDed1gjJbY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=X1HvDEFSVEGtcUKIIqTWR1KjxOu2lPFakWgIqmmicTZuPAHrDz+8X9v4NsD9a2XJK
	 GoHViKAMr7GWe2oDWmOZjkgaNkdpKI5dwURIcs187Mf0o43SPsKupLE1i3/PNHrB0e
	 4JwavCfNJQoc346MdqojC5NTGp6byuDCk1PeR3xz4YdbWIunOxkpozIf7rTPJzBiCv
	 BsCHOrhuTJeT9u5fEQazEjC9HBoGIn1fqsE0h42KdjehaKUq0YeINnD4KGbgPOG4bw
	 DUPGKmKHjqfTmdmmN4uPoL54OEJkOFkY8TlsWzS0Wjj6ZP/LFdDY8XJZliWfx0kxEr
	 FBVLPy6y95IYQ==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AMEmST3038793;
	Sun, 22 Nov 2026 22:48:28 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:48:31 +0800 (CST)
X-Zmail-TransId: 2afc6b0300bf8b6-4e46c
X-Mailer: Zmail v1.0
Message-ID: <20261122224831886ognkZtXtygomcSayJJdF8@zte.com.cn>
In-Reply-To: <20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn>
References: 20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn
Date: Sun, 22 Nov 2026 22:48:31 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <hch@lst.de>
Cc: <axboe@kernel.dk>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvMl0gbnZtZTogem5zOiByZWplY3QgYW4gb3V0LW9mLXJhbmdlIHpvbmUgYXBwZW5kIHNpemUgbGltaXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AMEmST3038793
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 22 Nov 2026 22:48:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B0300C1.000/4jXX4x2cQpz5BNS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_set_max_append() derives a sector limit by shifting 1 by ZASL + 3.
ZASL is a byte from the Identify Controller ZNS data. Values of 29 or
larger require a shift of at least 32 bits, which is undefined for the
32-bit operand. ZASL = 28 shifts into bit 31, which a signed operand
cannot express either.

Use an unsigned shift for representable values. If the reported limit
exceeds the range of max_zone_append, use max_hw_sectors, the same
limit used when ZASL is zero. The hardware transfer limit is smaller
than any append limit that requires a shift of at least 32 bits.

Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Drop the warning for values the driver cannot represent (Christoph).
- Clarify that such a value can be valid and why the fallback is safe.

v1: https://lore.kernel.org/r/20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn

 drivers/nvme/host/zns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index e31ec6f4f94fbe872d346516b02dd1e6a2223872..a93f3b152faaad34199e0d6276536be0c0ae8767 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -27,8 +27,8 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 		return status;
 	}
 
-	if (id->zasl)
-		ctrl->max_zone_append = 1 << (id->zasl + 3);
+	if (id->zasl && id->zasl + 3 < 32)
+		ctrl->max_zone_append = 1U << (id->zasl + 3);
 	else
 		ctrl->max_zone_append = ctrl->max_hw_sectors;
 	kfree(id);

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.43.0
