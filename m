Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677277;
	b=sJSMe1y7DihPH56oA4c1dSAa+50wJCS0x/JA1tVSnozCDPwzU1lgN8bOGRV5amqX/0Xs
	 dqG1C0FIhcJPX/QNVm1w8PESb8TE5qroyaPCL48tjwKBrcvFGESNw/S1XD6tSGRD0khOV
	 510IHTO9yCTx2yImi6+dWBC8i+zL53VyweIeMrtby9waGAtB5DAYwCkL9ao1K3h38zHs3
	 3PYoQg96nH2ccRbzCIDNOMRUS+em7xp04rX7qDAWFKl9WP5Gqg0lJDQOMInw3JNRfDOb3
	 PaPGBk07AhxZPf1WA9Z1zSNQwqyMZ8myGbffW01kzTiZlrgnZPQCb9I31cLyvQ0vzHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677277;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=2pYc6UijVi1dVzKNNbe4/SSGyC+4QOdNzqCFDBVOzCQ=;
	b=y1DTpR2Vk/yPKaHXE2JIuVS4Ejm14tccBWKCx1XWiuwSKuYPpYiVY69fOvd2rTAB3hsi
	 TnvwJJ0MrfQUHxils78eKtLq2OlmLIZsVh6WGqn87/UWGOEt30n3S4zfBfiSg6Rhi0jDZ
	 yMBOfBnGgIkfKD9l8U84Z5V1iG8W7haOmLReoPwXiuqZlziCLYv9mQRz+uJxQecn+sZnh
	 ElDrkB6AyeKH5VZQZUypVox12YsaTyijQC+LApK6u4ZvRjE+g6OfQ4BgmSQPef9TRZIOJ
	 9PMSjeC8akt4OuT44OZJuWfQqdWTNCAfjSWN4kha8E5lUU22Egn1OhwE3AokQ2ljBTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=dWLePgFo;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F2606A323;
	Sat, 14 Nov 2026 17:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B40F2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=dWLePgFo
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0W3jw4z4yjS4;
	Sun, 15 Nov 2026 01:27:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677275;
	bh=SQAa9s9qVGymsPeujlLVA0PUZrLDkbbjCB3mFYRW+a0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=dWLePgFoyytFzOJvuO8XQnDCLYrbyhVcVMBIYrO1tijTMZIX/KIIHxlyZG19Mtu/A
	 3Z3c4UptpNfRGoIzomtTYrD6CIQy08mx6iK6RZQqWRVv555GKbld1C/wHxR6cf3wJX
	 PZEyN97hHVHOgg2QdmGhCocv19sOBE19GuN37ZzgZnnOvSco9oZr8yqEn4Cb1zs1Ea
	 u2Z0NLqmx+TXCw/KfEdTUfzDjjiBUz+RC0np9LKFn6hqU/UtJyKsVuRMQbRO5Fsn+9
	 r9w1cmiPlQdFJUedztNvHbgZ6o0P+KxKbkZVOFOXk+8YAwwidgfMe5f0Tbpg7CFAaa
	 Pum8ueiFcqKPw==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AEHRmaU012382;
	Sun, 15 Nov 2026 01:27:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:52 +0800 (CST)
X-Zmail-TransId: 2afc6af89a18f0a-53eb7
X-Mailer: Zmail v1.0
Message-ID: <20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:52 +0800 (CST)
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
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvNV0gbnZtZTogem5zOiByZWplY3QgYW4gb3V0LW9mLXJhbmdlIHpvbmUgYXBwZW5kIHNpemUgbGltaXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AEHRmaU012382
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 15 Nov 2026 01:27:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A1B.001/4jRh0W3jw4z4yjS4

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_set_max_append() computes the zone append limit as

	ctrl->max_zone_append = 1 << (id->zasl + 3);

where zasl is a u8 from the controller's Identify Controller ZNS data
structure.  A value of 29 or more shifts a 32-bit int by 32 or more,
which is undefined behaviour even with the kernel's -fno-strict-overflow;
GCC may turn the result into zero, one, or another arbitrary value.  The
limit then either disables zone append or advertises a size larger than
the controller and the block layer expect.  This is reachable with a
malicious or buggy controller.

Use an unsigned shift, and fall back to max_hw_sectors, as for a zero
ZASL, when the reported value does not fit.  Warn once about the invalid
value so the device can be identified.

Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with a host-managed
zoned null_blk exported through nvmet and connected over the loop
transport, so the host driver and the target run in the same guest.
A TEST-ONLY hook makes the target report ZASL = 29 in its Identify
Controller ZNS data; only the nvme host patch differs between the two
runs.

The out-of-range shift silently collapses the zone append limit to one
sector on the unpatched driver; the fix falls back to max_hw_sectors
and warns once:

  unpatched                            patched
  zone_append_max_bytes 512            zone_append_max_bytes 1044480
  (max_zone_append = 1 sector)         (fallback to max_hw_sectors)
  no warning                           "invalid zone append size limit 29"

 drivers/nvme/host/zns.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index e31ec6f4f94f..c34015e68f81 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -27,10 +27,15 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 		return status;
 	}
 
-	if (id->zasl)
-		ctrl->max_zone_append = 1 << (id->zasl + 3);
-	else
+	if (id->zasl && id->zasl + 3 < 32) {
+		ctrl->max_zone_append = 1U << (id->zasl + 3);
+	} else {
+		if (id->zasl)
+			dev_warn(ctrl->device,
+				 "invalid zone append size limit %u\n",
+				 id->zasl);
 		ctrl->max_zone_append = ctrl->max_hw_sectors;
+	}
 	kfree(id);
 	return 0;
 }
-- 
2.43.0
