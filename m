Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695308;
	b=EOqVQfFJOeJJhJZFB6SVOkQFvszX/XL8pEwrci3K8gn5QPjHwrdpJEUdmx5q9as2rQOz
	 c8zP6TLfV2Ldkxs09ZXbZr0z877KU7PKa39pnX6Pf0761wjmYlDy4Cr8NfMb+4HqWo77q
	 Pl3Q0fdLV0yKlfQXc/uKp3Fz/rX60OL/eulkuUIzt+VffbjuTtWnTIOHmO2BjAi0dEOYE
	 tneLYkD6IwlFyBUbX7xHgZW9ETccYMlqS4F5FdoMPK0vQqIoKMQoE3LDxuqouAl+on7lg
	 FcvirsUCcJcmZy+I0vINHdXRTom3FwuSfCm3jrCvvj5j+WGfIi/xmssVlzTb5stXKMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695308;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5vyfnd47uwZqspbq4knftFHy6Kp+DJLcSlxq3/tWFaA=;
	b=XkXJKshNSq/GsCuFKKnvdItwQJa0pGbhf/kMlZUe8Oay+2eOtV8tr/AMQm6oseIvQ2qv
	 poFE6Yme3+2sazjQAQ2WfWv1DTJNuAB8wH5ZoO8B0D1mMz9iAUbdd5bsWPljbFn/pTlck
	 JK/Dz5ECopn+XNuU6bWp+X2RdmE56dSVMeqwwAXich+p2cKJQLL3MsYrWCoKdTPqthQkU
	 mzrU70mFt0XuJfbzmzIJ781KNyczDqwY7MkuyWG1i4QVe3oOKmk9IsOlB+PH8ccFRyZ8e
	 w9b1zRZTRdhNDsFfc5HnhlUwGTd0PbDQ+2C1aLVP0XbHQVbRtMoZw8ThMCAJ7HX61yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=LHvdR1zo;
	arc=none smtp.remote-ip=115.124.28.74
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210E606A943;
	Tue,  3 Nov 2026 08:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6210E606A943
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=LHvdR1zo
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695297; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5vyfnd47uwZqspbq4knftFHy6Kp+DJLcSlxq3/tWFaA=;
	b=LHvdR1zoVWzugXqXNicymP3YF9nyqevFYL+5USwGAHLM7l5cPLK5rD79ZlQpWQ1pxcPASWMy4zdRnXUk56aybcJmjR5v/yQQ+LE7muk+M6Cd6pgAMs6yjB9T3TTgJLw7owrdBtI637wnQOTe5pChovj0/HcFguslu4Cw2+cmhd4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1426679|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.000769656-0.000153283-0.999077;FP=8582228276987769954|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9E9_1793695297;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9E9_1793695297 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:37 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: lpc32xx-keys - reject matrices bigger than the hardware has
Date: Tue,  3 Nov 2026 16:41:32 +0800
Message-ID: <20261103084135.426629-5-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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

The scanner state array holds the last state of eight matrix
columns, and the interrupt handler walks the matrix size that the
device tree declared:

	u8 lastkeystates[8];
	...
	for (i = 0; i < kscandat->matrix_sz; i++)
		lpc32xx_mod_states(kscandat, i);

The probe path only checks that rows and columns match; the
hardware supports square matrices from 1x1 up to 8x8, but nothing
stops a device tree from declaring more, which makes the state
array index run past the field into the rest of the driver data -
including the keymap pointer the same code dereferences.

Reject matrices larger than the hardware supports.

Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/keyboard/lpc32xx-keys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 285d5c32fe70..1d0b082e7881 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -142,6 +142,11 @@ static int lpc32xx_parse_dt(struct device *dev,
 		return -EINVAL;
 	}
 
+	if (rows > 8) {
+		dev_err(dev, "rows and columns must be at most 8!\n");
+		return -EINVAL;
+	}
+
 	kscandat->matrix_sz = rows;
 	kscandat->row_shift = get_count_order(columns);
 
-- 
2.50.1

