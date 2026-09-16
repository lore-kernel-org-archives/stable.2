Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01F4D9553
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580110; cv=none; b=AmciunAn0yF90GduIiVpzpjs1egn2dFCKd3zGm3z/f3/MV8eNTqxEFYLT5aAdBttmjlo9SLBEEMg8ZQ8Qra/OyHCjxvrfow5M+3CFz3dqYfZ96BIsQGDe7NgoKTF+LDMW80po25W6ZYXpZww458sUXkyVgOn54XRc0JCQYHG50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580110; c=relaxed/simple;
	bh=pbWiPxiQInKuj5bTFtORq9m72QKi4BBFkW3huAQwTGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNd6LpPWv2S3FerkvwHzrZlquoX0MwridjUrA9H7OzHl3xMPM6VCY5BM4pPnjxSM5lBmGpLHKNw8GOPUbhK2kXJTVTn5kRslKbg0pnqo+9/EIBsOExSkScTixSRW7YOOt7UUHaDAcJMkeGD7aNNLutbbM/NyAVifv88P3FlC1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+jigOvX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+jigOvX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso11106565e9.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580077; x=1790184877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TP9Q4QkeKPg/kRB9zan/QUnpnRo0dK+31LaOT3R+N7Y=;
        b=X+jigOvXb844rOIp9scXQCgpo2sYfoGdYGKyoBITcAaSxkqNBmIhgbKckmNFeldTRf
         uH8IvjsqxgxJ4kHelFL9HDOqZT7xFGpLlEFLnJodlCTd6Yy33Wa5OD+DqyV59VxD+FzA
         0HtyRpkNHrQdvKE4y17u7K9iMIH6ChwWpYaYkPG0wiiHQCHiMiFyBO86RdoxDWNFoM2L
         MIPLH3JeJrFqU9fR6pVBUbbluYHIPq2rMBzveycCCxjryRQHUyf9e+G1ZLuYilzceDF2
         WwAwVfDDFlfeC0s2su0eehePEi/XzLYhZwpM1u1iG3n8UBzD5Nv4n/beVTwtGM/vByj3
         osnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580077; x=1790184877;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TP9Q4QkeKPg/kRB9zan/QUnpnRo0dK+31LaOT3R+N7Y=;
        b=Gf/CgtRN8AI+xv7+qkxcrEKhL5lduZoNJrsyc1vyTu31LorLOzH4PTdJxeM/f+HQmN
         Yp7/ulm++7dQ/axrfLef9+BHTL0befj6GCV0jMFSl6hgAsk3gN1VKDHBBW6pZr7gDPmc
         S0MzKNFfZIcx3RS9Zp61IWFgA1RzGLuJayCO3v+Pd6Ca5qhzhF07LbmYb1eYFurfYc+E
         KXjaZY4kJypzMcNDjHh13n2f2d0CZe62l4NuU+E7eOgllLgOIACQ57dLsJDodE+oH9xa
         ax7omUXs5xNVBlk7wrvOQsAHo+tcEbBkEI9VQVuX+UitacYLuMT9gfqeJSBMB7Zb/fF2
         tyfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwD9oAx42/PWUgiXkhrF1YJ8fRAL9r8dPIkQLqeCI4lK+64hrSF0q06Q6sD5zcKhEk2i+kUxxU=@vger.kernel.org
X-Gm-Message-State: AFuF++nsMw5hgretWMZCZg11CXrJhjLZFv2NftRhe9fy4OyKEicTRFBo
	3zS7594OAYxGKHJKQSb++cGLABlDkZ8sgs5k6TRCRfEGdd8NQE1TnCs=
X-Gm-Gg: AYBFou3oTzlqbbBKBUmEtRrrPnGEZSxIT4xv6bLUqOH6LMvm73//NjKo9t9UhDv8av0
	yEJ8hdhB5OKIssiYq5Cbbo4NwibVl+38elfe3lGRUrf86SpCCsvpYJw1f8Ccf7brfWvFzR0QbF7
	D+IBNiYxtwEajGkXlG46QQlZZbpzu/e/IzZzmDgy46WLe8H06dcZQ+tglepnGL2WCIr2dzkTvPV
	O9vhp1Q9D4LMRnCc/+O+OcnuwBa2rmGWe8CO2gjt3q0tGwkvgW2oF7aUxVf4clUa6we491JaxG+
	+4yLMaM7SVQlUvfgFsrvzfJNRyMIhrwV4xz9cgQcLPV2z747ZvxgY5p/wgY90IXPnJpfEhZPo9U
	BMUsbSGaY2LaHb67aN9pBVL1EL+HGUvwBQnpV4yjQJ9kzOh/PDd/a8wfIadEL1Pi7bsMtSCWFTc
	ftRwu9nfgntOPuCG6zJ+IWig5PmsfX9sf90lRAr6OVUqP4Uq7y0oD5LZmBMxH8ASmQLjDwJaS1x
	jzEyItYMC5mZXPjtJLmDxusK34RmfImaFCrPPMKj7ZVgDPnjoCzdNs7HDiTWWa9ELcRY6JI9LBc
	sGV0LBJhFP/8A7k=
X-Received: by 2002:a05:600c:3e0a:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49eac46392fmr43178425e9.3.1789580077291;
        Wed, 16 Sep 2026 10:34:37 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:f23c:f0c3:c09d:d6d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm8987544f8f.20.2026.09.16.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:34:36 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"John W . Linville" <linville@tuxdriver.com>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH ath-next v4 3/8] wifi: ath9k_htc: refuse a command that fills whole USB packets
Date: Wed, 16 Sep 2026 20:34:24 +0300
Message-ID: <20260916173429.403889-4-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The firmware ends a command on the interrupt OUT endpoint only on a
short packet, so a command whose length is a multiple of the packet
size is never delivered and the device stops answering WMI. The
previous patch removes the one such command; nothing prevents the next.

Refuse such a command in hif_usb_send_regout(), where the packet size
is known, with a warning.

Assisted-by: LLM
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index d3491ff08e6e..4b57cc2f3d6c 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -99,10 +99,17 @@ static void hif_usb_regout_cb(struct urb *urb)
 static int hif_usb_send_regout(struct hif_device_usb *hif_dev,
 			       struct sk_buff *skb)
 {
+	u16 maxpacket = usb_maxpacket(hif_dev->udev,
+				      usb_sndintpipe(hif_dev->udev,
+						     USB_REG_OUT_PIPE));
 	struct urb *urb;
 	struct cmd_buf *cmd;
 	int ret = 0;
 
+	if (WARN_ONCE(maxpacket && skb->len % maxpacket == 0,
+		      "%u-byte command fills whole USB packets\n", skb->len))
+		return -EMSGSIZE;
+
 	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (urb == NULL)
 		return -ENOMEM;
-- 
2.55.0

