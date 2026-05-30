Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5E2D9EDB
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156776; cv=none; b=gJygwarRYU9enoowdd2v/wH0UfYwVOQRDQeu7HCvYgBPw9ArqzTxfxYhtAjeH0JoDyKlTPTxgFnyHBLZSyvy12zCo4O7/+Kv9MQGJpTlVwGrtsk/+jZEkpBmmsrNPj+UnVV7X+lR8PoB2m3ASnJic9sRvgLBSZsCWwP8mo/7STc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156776; c=relaxed/simple;
	bh=ZqY9+9AxGyC/ye74Rz/F2gbLiidC9axpzQweMBEGG3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+9/fsICdQVmo7/j/K93hma7jvj8MX4tDpelQV4LRFiMPNI5PC5aDQyZNaqE6GFMiBVOaTw7zSLFpFaJHQuvAw61uRDxWZjV8JEjIqeSuCyMwGvKQMpbu8fD5xBr3v73gLyGxMvt4TJepO9xI2XynzkIm/K+9dnSne+DcbRb5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiP1tY4G; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiP1tY4G"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36ab8816a35so4017480a91.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780156775; x=1780761575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TAgj73NhO/Qgky2vRa5up3EF0NXAk1X9eWrQb+RpU04=;
        b=PiP1tY4GvLzoRJZ1KFDryraLfItH68wPY+t+8KHirnD1pzY4/wkAo5pNcDm+EAR3pf
         bV0FAB2t+M5PdgsQBqPrONsKojvGzQ7CjZFIIN2GdWQlJqYCO5uJrq4uqZiEi2kwG5RM
         TznFMMmNAoY2O0JroCra19t8VHDI+LX9H8fS4OdvN8JBbfU0Ewo08eF0elSyeNL3o4ih
         XhITUGz1h4GOsaBgTEYJRdTBabgYZhQXgYVr3cdNof6A1G0syEsv4rKBadgIFGbsSVTz
         IBjJdBOcy6ItKfdxuLQ/lXa7/GNu/O9R1d1AoAhp9pUJYV0YAeqGAXNO6f3HACgPP/NS
         XhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780156775; x=1780761575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAgj73NhO/Qgky2vRa5up3EF0NXAk1X9eWrQb+RpU04=;
        b=bEQVKPPNV6jt95/MlJhK+HijpHeKnt5yUlH2efBIx71Xi/yf/l/hkDMtQSJ+oplp1t
         8x88DUckgYRab3bgc3k12lFkeZqyIhgmoiNKlnxNx1Za+8HInWeK3DFs6gsmNCYsddEt
         hma7FrVGIUTUQdI2SNb5pwMBAubuKP5KyByQlccck1eQvjvuVDopwltc2nakv8NH6VtY
         vVu5eJMgXh4o19kRj6V7OdN3kxV9yYdK9320T7ywgUDsRdOFrhCE5I1qkHhCsnatMf3T
         4wKDYoCNbBppHTCKkpL55i5gNUrafJZQh/GfaFZ6GiqqkS8oKYlO79bB9cm5tQ0ESoN3
         fIrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7S/992pbT0wK4QgiB26WXzCErN6FeLgmxrvETT85nMBFRKuQ+eQwT8CMRedn6SlfAkhYNHKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GpFIv3U4JZQyyYa4gbyHGkqjb0VRYA9nRWSe+zAoDAkxMIwE
	9glOQ4g7mXLycW9+RX9wOfMgBZERwNrcR3CJ7wjJPG8ODShyjLnm3de9
X-Gm-Gg: Acq92OGxBzCUdQZTwWyBuyONJxLH5F7kYnFQBd7WAzxUy9p6rEADv4a85fARFtZNBxs
	raF9xmIb1587Few+It/CEuSWmB1Y1OCxe0XfLdR8hrn2GjRUhKGSxtEeDLFcCWnoO97/kP9WmMo
	SDlgOUgRAjfMGNsZwRkLYqKc3iEl1iQZMUhxksNmlxLeQosYQCmU2vPRMc4qq5Lr8rg3PuvFH09
	0m9Z54Y53tJ5y3r4wSeBNqABkoEQRrQRY/YUtqVd0Gxn6OB72tfuigySs2R8Z3P9LdoUPXR6okD
	grpDnpLrEG7ngER+jx3aF9/Bsoekpa6gYUGCglywHjmFxqHeRqFa6Hbuhcce6CttNJk0uJgMHEi
	TP2Z2+MAAv/S+cJ5MW/7GWu7qQ1zEnXkPXvGjmPgu3tFjCLQKAQxTdNk8+Gd86NKjirw+BDrtHL
	8XX9skZ6MaiWTovqtLcVMahqchArh4WnPzxr+MAY06usXi8A4HwCnAYgnSN2E=
X-Received: by 2002:a17:90b:1d4d:b0:369:f48a:f21f with SMTP id 98e67ed59e1d1-36c4ff3559amr4144848a91.6.1780156774849;
        Sat, 30 May 2026 08:59:34 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0befe7asm5776983a91.11.2026.05.30.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 08:59:34 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
Date: Sun, 31 May 2026 00:59:30 +0900
Message-ID: <20260530155930.128183-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

wacom_wac_queue_flush() is called via the .raw_event callback
(wacom_raw_event → wacom_wac_pen_serial_enforce → wacom_wac_queue_flush).
For USB HID devices, this callback is invoked from hid_irq_in(), which
is a URB completion handler running in atomic context. Using GFP_KERNEL
in this path can sleep, leading to a "scheduling while atomic" bug.

Use GFP_ATOMIC instead. The existing code already handles allocation
failure by skipping the fifo entry and continuing.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b35..2e237bdd2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 		unsigned int count;
 		int err;
 
-		buf = kzalloc(size, GFP_KERNEL);
+		buf = kzalloc(size, GFP_ATOMIC);
 		if (!buf) {
 			kfifo_skip(fifo);
 			continue;
-- 
2.53.0

