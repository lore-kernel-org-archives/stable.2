Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647074;
	b=B05SLNzBlDFEOb+Y0FjTGHJjqeG9ELsUElyBcMVBehLiLruksdkvZy8Q8nbWLHPfMiwR
	 xxjqLOIVn9kInczFX4IhGeZNBKj+qPdZ7lKNPw7aNx9c1gVCWmM76PHoluT79fkMPXQoR
	 z4N8eKzlK60rES2EGY6X4m1Ggz9ot1Wxz1D2IFLeWpki44TCiFKbSDygPY4Y+lOXmzQW7
	 5XTPfILKxA4IZ7o3PKAgbXutHwcNhcC/VMZ0rU5xcnZSDRPif8hiFigyC4NI6a1uC5aQc
	 rJ4jpuMBLZjVGocDHt/S8619cSnCrwWN4fdIo5SVL5v/D4BIpEd0yjNDy3My1cd8j5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aVE8zme1iRyvaHJJXQb1UnPAk3BxoHJBltYK6kSmEUE=;
	b=eM+xc9CWlIthzGyp40w/z28fiCVNPJMr/8DOiPiJiQhaGrGrTTkoCDC4jxhRkuURBYv5
	 7BCUNJl3LiBqXaqymfiGx0aZltm8pFEDf8J1WUkjAj+1Z8fm+/B55oQylbetJ+Y9G7Nwo
	 wYZq3pHA+9G4NJgU5Fz3WwQyYETYMlmjtZoDiuhwk9DQA19QYNOZd36GyTW0dw9keGzrh
	 +w7qjMRJFNmIMaF9AD0q+O0Sos6vC1qp1Por8VkBwgUGp9qUrV1wB3k9HRQeYgS7QV71x
	 R2aaYxpqY5AzFWGHCDQ2sIQCFDGC1lVoTIV3JPpgN78PEMKLmgJnXQ3HeaE56AXVLNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3pS5Pyk;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C4606A338
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91C4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3pS5Pyk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so34442575e9.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647072; x=1794251872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVE8zme1iRyvaHJJXQb1UnPAk3BxoHJBltYK6kSmEUE=;
        b=m3pS5PykhHodyqYuJX7hbI7UnTabwyROLm/nHosoRh1WH8eaYcpdCffqwnGJZ5vlr6
         J4m2HnK+qSU46GAGHphS0pQUdIaTe5eS4fHma2m1WlWvOIB15TWZ4hydxRUI/f7DrznN
         ZD3ekvoY6/ZfUGzRvI8oKEcF2VK6+fwODHyj5o4MPrfie8oWYl8BGgz6HWGrbPV0zwxz
         sBblv4fRnzBuKs4k71fXjtr0z+ahRidzy6ORUFT4YXW5Eu/yBwItKZe4BhpG/LqE6L1x
         DdYY3GY731RDK5tnmwm3ZYI9Jxd9jb6cCSH0jaU4WJiQqbg2DBg5iGdCap9sblMd2+Yt
         4ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647072; x=1794251872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVE8zme1iRyvaHJJXQb1UnPAk3BxoHJBltYK6kSmEUE=;
        b=w6Nk+DZupSiPjuQH3/y+JRF0trBzKJa0YHvrCxtULMoR5JcED4GFJ2KWBLp85wBmNq
         eDyPfVGLjCDTSo5AYvp5H1TBlu6xXS/VVVmm5l+x5BBipYj2hZF2mnUQWcV1IOsz0XA0
         nhrPfTx2LMEquNivAhANR1QCT1LcvY98w6GmNd8Xu8rz0Sx+lMwkoysnvHrnU7Nkm2BA
         9YtRJsb5sTFf6duzO7l737SCkX7fL74OWkA+j8cshhsSseqYnPJ9Ban+T0LBLja1lIhB
         38VRFq3aBpzbiQeacrnmj0DX2ryW+u4GpSyPbJgAnSpQAXxkmabKk6ozOa93W0NpI4ph
         u9Tw==
X-Forwarded-Encrypted: i=1; AKwUvBybnKlmA1EXBIy3U1ohB+u0NKbHUDz0hcs7gTdKyDIeB0j0Nyqztc6HwWActEGS6fn0lEKndyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK62HrGGma09HLetJQpmm7sCKVKofBSljNX1whkbx3BQ0hKjhoc
	IftP02icxNTP9As80CVZ6Ee5ljiKf81Rng+WdZAchQIE5Wp2h2oHrtc=
X-Gm-Gg: AYBFou2cbsy0VLflH2zFem3sFa4VGLPPjOkS515Okd0XKimKHFL/5PV27gNY7LSf+/V
	GcN6ns55AhSDi7GuVEF9lIg4SBIkWDgJLo6D3Bq9Ib+EqsaBcmrc/cVA/CQAsfKBRs1d/xNArCH
	ehUR7JVcwAfgQhGuLut1ugp5RKEWKQgexN6XUF9/FAc5blFx8rZWqjS0lKxD54An9Z7kQjbCV6n
	LKwMTM1IOZiWaVtl9HGvK7Kj+WiKn56sfer9pWOwJJNPEwVBgDatslxLk1yvAhra9qdcLpReqhv
	V7mpXr5ZdGfTlNNmS3zx9u0rPntY+Vde0+glwe4slGNth52gGyf/5xyrWtZ0DrWpEy4z/A99U6h
	G2yw54Fw3wAaE6t4qeCvo5hTfBhOd2z0WrvRRFUEq3V+5TZ53hQvI8n6ioNtnB6YA0lYhLbEHH0
	v/GPkvqZ3BQE9CtcztNA9M1dFHlS1E5iQqAgJPvLCoamhxxEHcSjMpJEknQ1wwP1O1NJSk18+HO
	7vN7BxR0CuqkJUl5opgobhrWpwGRAOxpISaf8N9Ppb8QY+2NydLpGq4e0/2xSoSgKlqeBb5x/YH
	EGcdNSLFzgs=
X-Received: by 2002:a05:600c:3b18:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4ac1932b542mr261291925e9.35.1793647072092;
        Mon, 02 Nov 2026 11:17:52 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d4f9sm21801298f8f.2.2026.11.02.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:17:51 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless] wifi: mt76: mt7615: cancel coredump delayed work on device unregister
Date: Mon,  2 Nov 2026 19:17:50 +0000
Message-ID: <20261102191750.2308294-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

mt7615_unregister_device() calls mt76_free_device() which destroys the
workqueue without first cancelling the coredump.work delayed work. If a
firmware coredump is in progress when the driver is unloaded, the pending
timer can fire after the workqueue has been freed.

Add cancel_delayed_work_sync() for coredump.work in
mt7615_unregister_device() before the mt76_free_device() call.

Fixes: d2bf7959d9c0 ("mt76: mt7663: introduce coredump support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index a9178e077fd6d..c06b0301a4e4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -124,5 +124,6 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 	mt7615_dma_cleanup(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
+	cancel_delayed_work_sync(&dev->coredump.work);
 	mt76_free_device(&dev->mt76);
 }
-- 
2.47.3

