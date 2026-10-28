Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197167;
	b=wWx5gdJWFHIBrnIoYZpvDmB6PwSTdcuZvirWsmIHTEPaHOJl+S4X5GiMXegcy8QKI+hC
	 ivGdSSthjiFX11ixwU4ZLzAhKztkiTUXU7GMg/U+vrC5YoDwgVBk7uwtDrgho/S+BSuL6
	 egnBFNZ0iAhP43y44/rJUonw4Sqnv4XdvEtJHunagcM29ndFhWYHJeJin2b+oZvRAL2x+
	 pqK3QTAEvNpSf53cvV5AiPx+gI0xaFa0k1K1dJyNjGEiVpWCEl6sFM29ToY0A9oLudVel
	 KGNh2e+S7yauHNb3AX6BVTpJW6+UYwtA4l5C0DLrsxzKnDSHmHZzlNrTWOdt+LlvHcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wfVFawx1WEgioRP93JnhxZQvMdlK3X24yVnDut49gjc=;
	b=DqAgsaSLRtnnDf0tjGUp5IzJf6olXfUThJ7HwCJeLVxO1s8AcCINqhOB7GMHcPmKvgXt
	 /OGCiGsbPb8xRtjLFWCRA6zHRf1XxbC/jZPNus8+UTV3E60NUo+J3Lp8hw1yd9CT0IweF
	 Ddl6koCWdzNjhKJgg4jUQEnFfX1HZHtSuvU7qJ9dBJUMEWExjaZ4OzQy+tFBdAfx8U+N+
	 /m3tjkyQ7yNJCfIN+oTiMc39QxWV4njREbl8Gn8evof2/PB19+f5wyEWoATrmn/e+81kk
	 SmbYJZEM5xnzlbz2R4S6uHEQ96CQIujJxIpjwU7+VC9nawa3PxOfcik1L7ctWjL2XSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P1XA+VnQ;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E660A261A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 700E660A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P1XA+VnQ
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso602301a12.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197167; x=1793801967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wfVFawx1WEgioRP93JnhxZQvMdlK3X24yVnDut49gjc=;
        b=P1XA+VnQPQCdb8cQtqtSQOiFR33H3BylLmzvaDP5xvfAoAO+KLEchzy0HUroGMJ9Yf
         pLiTWLeBzGjv60XR0m8sHhiyZhBhnKcQFAwRP+a/UoOGkFHAzOvzxjmV8ZmVxrqb9BFe
         UomSN2nAOriW2X8FvIegSKAg4hCpzjSG0l4pfmHg2R3tdvA8k8FrSlegrlsGYDI9pISc
         RQiJq9VJ4S3ZH3JDGBI7i1S4x/1BXncfu0OaBN7EykMMbBBB6sbtzUSy+GFPNO0ZcFcj
         O4iK9rkiCOpaj3zAQ87CPSqrVOoHRY2+REuScBVAWsgzbiNKjFw5zUQLw9YM/epf+8WD
         y1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197167; x=1793801967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wfVFawx1WEgioRP93JnhxZQvMdlK3X24yVnDut49gjc=;
        b=mFvc44iROwNEdD8uPXOVk9ZW9do6hrof8UdySJ+9bnEbgpYkbRpdSa7+tlCtszb3eH
         vfThIFJnZuACZojb1Y0GuK+OJfBgZJLe+mUj+GWgicNj1oZ6JQfZEY+0vjak2BaFQiEN
         6+ExR1Y7SxL1+GYcytiQSCEoFzT/h/SVy6gaxJPD0AwNOembYng2mNeErg/GDLjVsUD1
         WHKhOQe3zk2nf1Dbzjl+BzPqB4Q/MnA8WZWtcGy4zR0LPRYmxaZX6GHS+lhYSglvhhYY
         h/LOTYINQPOjKZEFMnJlvwaYDRPzavFfHDd4Jta/XDEri4wEYs7OBLmH9pE/mMIjS7tW
         7QHw==
X-Forwarded-Encrypted: i=1; AKwUvByWJVXyl7FhWM59AKXKf9zSFiaq2ISouvMVxNxmd9csuxPGR2mlK9U4UX4u/DBqMmqQDyxHf7o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2MAiC9fyoAmglawKIbjXFGsOhDb/uniEhUDB9IP9FzjQNEu0V
	/JDJmtgExuajH5CRuLvevOkTxi1e4uwKkjymk2jlW9cBkoJ/1jABwl9L
X-Gm-Gg: AYBFou3d5Cd4XrxpxbCsTGtRGUl8q4Mv6PAsMyUMHqT7TOQFBDdqwqIQKEL5AUkq6iK
	YJkJC9El4kofNY6Ghi7T5j04B8FOAOH+3V4dfxTWLpU8kiQain+ZNsjEWqFVJX5arnOE3XS4NXE
	+pxsVCD0u1XRI9zxu3Pnf2wSNqOE9KHhmiTIgnxz75QtJ5e13McxqLYKYkw3CT2RF0tTc3g3MG1
	J1svCXg+UgWgtQ1pSTzKNEuqc/GgKcvvVgMtOac7oXk0FOQAPghr916ZgeMZUnD+JT8Uvh55vvm
	V0fznVk7hcJyuP6VAmCQ3V+DGLFZXYZm2yfy9vF08x0uKXhCyasq7/s3NuPeFQcD5DTNd0duGCW
	7XImTh0wtGVa9M6DNglzXByPqtfI0HFTF/mh3bv1XN4Q4RvXqQlfYNl5FuK/uu+BBiHleUtKAlP
	V8q2CP/Jp+aVXO3m23K+3LN5Is3OQ2YahFSCut9IQpoCN7BXPKqz5X9GgPgYTKwuX/75xSEqHea
	ypPXYLBna775kww4tsglEtByrGjKEIfejHi7EfiWUzurg5kZlu0rpjTfhja+CLdJH4z87EP7//5
	wFoqUvy/jTzEMj3QF0Ql0KdmK1MLgj8qZjQZQygWKd1P58ftk6Zt9pt3r+dutHRwDWtI
X-Received: by 2002:a05:6a21:8217:b0:3e2:7030:9080 with SMTP id adf61e73a8af0-3e9023aaec6mr2697680637.47.1793197166415;
        Wed, 28 Oct 2026 07:19:26 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6cf9489sm1300647b3a.39.2026.10.28.07.19.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:19:26 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: neo_jou <neo_jou@realtek.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Hans Ulli Kroll <linux@ulli-kroll.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw88: usb: stop RX work before unregistering hardware
Date: Wed, 28 Oct 2026 22:19:04 +0800
Message-ID: <20261028141904.8707-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Disconnecting an rtw88 USB device while RX traffic is active can leave
the RX worker running after mac80211 hardware is unregistered. A firmware
event can then queue C2H work onto a destroyed workqueue.

rtw_usb_disconnect() kills active RX URBs and unregisters the hardware
without disabling rx_urb_work or canceling rx_work. The resubmission work
can restart a killed URB, while an in-flight RX worker can keep processing
packets during teardown.

Disable rx_urb_work before killing the active RX URBs, then cancel
rx_work synchronously before unregistering the hardware.

LLM assistance was used to find the bug and review.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Fixes: 3e3aa566dd18 ("wifi: rtw88: usb: Preallocate and reuse the RX skbs")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.13
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed on the rtw
tree. Not reproduced; rtw88 USB hardware was unavailable.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.
Kernels before 6.14 have no rx_urb_work, and 6.6 also lacks
disable_work_sync(). There, killing the URBs already stops resubmission,
so the backport only needs cancel_work_sync(&rtwusb->rx_work) after
rtw_usb_cancel_rx_bufs().

 drivers/net/wireless/realtek/rtw88/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 64e1c3420e0a..1d2759eb96bf 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1370,7 +1370,10 @@ void rtw_usb_disconnect(struct usb_interface *intf)
 	rtwdev = hw->priv;
 	rtwusb = rtw_get_usb_priv(rtwdev);
 
+	/* Stop deferred resubmission before killing the active RX URBs. */
+	disable_work_sync(&rtwusb->rx_urb_work);
 	rtw_usb_cancel_rx_bufs(rtwusb);
+	cancel_work_sync(&rtwusb->rx_work);
 
 	rtw_unregister_hw(rtwdev, hw);
 	rtw_usb_deinit_tx(rtwdev);

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.56.0

