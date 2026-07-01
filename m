Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F27480974
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906345; cv=none; b=PCnzT/kOEzkJJutf7JrU1rB/KW9xkT2TyweaxFZK5PcFKwjoS0Hg/GlKKPL0RAzNPBPvWVuTBA+RKKaLitsazJ3JbtDEm4uoMK1cJRPa4KlDKf1dszw9exbxFiJmtD8eJttMfrj9Y6pGVxxGZBrshR1DMdBHtzjv0IYGNgQ94E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906345; c=relaxed/simple;
	bh=Z4IOO7ZsfxNZwdgMwUFeB0c004Jd0L5cGT8SVFWvo5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yh6wKNYFAl6cfmQotBjxkO7OLx5Ydeun2MnNCA7tZKJQryG8GX3vP8g/V8NWWvyqjOybfOf/caWMtuna36psjYi4MPWH0RXAgVmbwAdCTg5xlboKiuByjFcDPU3fFa5vF0PLMweCDOGY/nIDmLDbuBboMdQQZ3xtYUweYluOBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyL+5NF/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyL+5NF/"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so318988a91.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906344; x=1783511144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkrp/nl+DXAxDEgj38SKWxdi9ULvDXZAIWkhJFmjLHw=;
        b=nyL+5NF/qVBw5mp8Xh9MoxiVyqwTqJ/PXfP7zN+IIIbtwxOMI2e/zh4Dc2psecWaQH
         yV7UOhotKf95nnVIT+k6i2piAQizaudPiAF81XQtQr08rQ/rR/hUzQ3DJa/HpXKeoLFG
         BvDWMwuSrFQgVKDm7ZrxfV37xJUFYyvxWWTKV4Syxd4QnbzN6rB9oJP6WFDSjpuNRarj
         gsDeHmmxCi+evcNZcqxmN82qNPIHyZm65QzzXsff3TtntI7p2chdQiCHhmY9XDc5NxvC
         GlmcpUwMQhck7v1GB1OHEP98PvevffpE5UElYbMnC64i1z/IV7kHWTj9P/56210rtozV
         0UPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906344; x=1783511144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkrp/nl+DXAxDEgj38SKWxdi9ULvDXZAIWkhJFmjLHw=;
        b=ZRFipvNH6SkRUEGbELtFGuKQC/eVSzccJ82D4BiF3Q/XUtiTcKUtccViF2Zl/iEbVK
         mp7oPWNIZ7wuY9ckDbx2/Zh2VixzFaUZy7+dino6u1hvUOSsEyUWr3mqZ0DPT/eeZKA+
         6wPPCYEr6R5ve3AtMwri2QBgdrbE/M8KI+EpowV2ul1HbL0ErWjtxQmU2c2x28W85cTE
         MKVfTRKauLKzePqvqpHkP//OqP02ibjVyqhnr6Nw4hfrMIH+U6QPc3lIXPCdOggbk6Ka
         Fm4U6kp+g2SdEV7u3bMt8b9b0Qa2uuOsRzlWZwpG9gDwVAsn3s/g1lpCvsZmjcSltRcP
         FJUA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+nCkj8G7vSVp5qSxr3CBxJdZrzk50oo1bo5kZtUE3q/hiEM0ojKGs4Sc8AIrZHGkEFPNoyyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2ejJ+gCFwXqAaAkJTKHrX5tNPLjYK/R/QvNasQlOpM6ZJ+2i
	u74VzL5wpS52Mdk3VzFg6+0mdGDRpCw0w5Oz7LnsD1jNKuuOtRQc6/a0
X-Gm-Gg: AfdE7ckMFwa/0ZrNTzIFjPqc4rGodQ1/6lKFP5GPywfTzz5ErhQuzNGRxn3JsfHxrFC
	OXSBYOZei5xDxmTL/uj6bLDyU9CHFivuiD01KdL137vFN9DwA8i3X8e9rJQdjo6Ik0HdEVBMG9y
	E5aI+4QuvURri/6fN/kse8LYcDOH0+ntSoZQDv2tc1NWPHexZScZ3CYE6EQeO9IP5LDTWuHQE+i
	U8RQfFS3QRVO/WNezTZpDJ+zURLwPnaK6worva39x60CxI0j+HJ8GdLnI5nSP+kASd1b6RAEDem
	XzEe+21e0PKKhSqd+qEIyR7u+Z4lIca5w+LcbN/eO2l6PcnUNEzJ+GblVGfDb2jkeo55PwRGkRt
	fX2NDoImoF7pz0rLyghQG2B/bjv5Yy81izu3yQtS555moG64Zk4CUIwSsomYBhxJhsvmjwrk6tz
	Se/JPELH6ux/Jlds4vKZdE5/ckB6d3T5wNVu0Yghz6uymcgdsBpYPc9FINYD220aR6OluDQGsOe
	JkE4Q==
X-Received: by 2002:a17:90b:1dcc:b0:37f:c232:f075 with SMTP id 98e67ed59e1d1-380aa1d454cmr1081753a91.12.1782906343600;
        Wed, 01 Jul 2026 04:45:43 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095e830ddsm1710645a91.13.2026.07.01.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:45:42 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: s2255: bound JPEG frame size before copying into the buffer
Date: Wed,  1 Jul 2026 20:45:36 +0900
Message-ID: <20260701114536.1045484-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s2255_fillbuff() memcpy()s vc->jpg_size bytes of a captured JPEG/MJPEG
frame into the vb2 plane.  vc->jpg_size is taken verbatim from the
S2255_MARKER_FRAME header the device sends (pdword[4] in save_frame())
and, unlike the frame payload length just above it, is never bounded:

	payload = le32_to_cpu(pdword[3]);
	if (payload > vc->req_image_size)	/* payload is checked ... */
		return -EINVAL;
	vc->pkt_size = payload;
	vc->jpg_size = le32_to_cpu(pdword[4]);	/* ... jpg_size is not */

A malicious or malfunctioning device can therefore report a jpg_size
larger than the destination vb2 plane, and the memcpy() writes past it.
jpg_size is a signed int, so a value with the top bit set also turns
into a huge length.

Reject a frame whose jpg_size is negative or exceeds the plane size
before copying it.

Fixes: 38f993ad8b1f ("V4L/DVB (8125): This driver adds support for the Sensoray 2255 devices.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/media/usb/s2255/s2255drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index 0b8182edf8e4..b34061ffe662 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -617,6 +617,12 @@ static void s2255_fillbuff(struct s2255_vc *vc,
 			break;
 		case V4L2_PIX_FMT_JPEG:
 		case V4L2_PIX_FMT_MJPEG:
+			if (jpgsize < 0 ||
+			    jpgsize > vb2_plane_size(&buf->vb.vb2_buf, 0)) {
+				dprintk(dev, 1, "bad JPEG frame size %d\n",
+					jpgsize);
+				break;
+			}
 			vb2_set_plane_payload(&buf->vb.vb2_buf, 0, jpgsize);
 			memcpy(vbuf, tmpbuf, jpgsize);
 			break;
-- 
2.43.0

