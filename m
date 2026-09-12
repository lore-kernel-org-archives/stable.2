Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CE41D652
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202399; cv=none; b=Yl/o8zfWiEW7fnvqMoFat6bRcjhuhROVKVYD+K/zrGcqUds6hoEnLZiwwgukmdAmfM45PzPgyGieYbOFxPfjtdvZdnWH95ZyjKMw3+sa6ByEANl5MexWNHG79GRpGl8KXAVVColipS4x+lG/4jeyuuIOrszw1u75L4yLnxsgNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202399; c=relaxed/simple;
	bh=2DLMTSMHxcwnSNUgrjPtTxElhAxiYSnUsdfnLFpf+E8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQ5gwNw3dFeea6Ji+l1OzV65RgfC/r2GSX2xdVZBnJFPZctPe0exQUOc9kPR3vwGeIv4BHVyNugb0Kuz9C3DjNIn7OgfWdFUOFyobTzXFFQs6IMkCPKWQqBLllNVQ3qOsMk1d0CvHPQsiEDxn/E6t83TmuTiWgoBQzlR6/rBzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlElIbGF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlElIbGF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-86a46577018so2648898b3a.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202397; x=1789807197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CU+0lwIWAY9yJrpwScpeW8QXWre3U4uXlIjmiMGRqr8=;
        b=XlElIbGFWlTro53S1sJdCauSadyUUNL2S1eO3SlgMUf+eLDlHMFTI+KUWgiL0VwFTp
         Vf3oDGamWgOCmhvroB1+B3HA+7OXZbwkHXsOuNUnhOTraMtKz03rDblVEagbg4NWUA8B
         v9H8is6T6xkFrN6BwmlN1Ve4Kgmwd1j7scBWGGgZ4PSydu7iTqac55hp/iGHeIu501ye
         PwTsrT857xdJuS7CpsCGu3nVF+F1NaIHo6ttdPkTXygNts5GZ9KhtAcQFjUHuAlebg/c
         8HaDoGgWrpuizzb8CinUHy6LsyXMSNN7vsMs4Y20+WseSCBk2z0RrOQFg8d2xVFLNpSj
         XdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202397; x=1789807197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CU+0lwIWAY9yJrpwScpeW8QXWre3U4uXlIjmiMGRqr8=;
        b=Z5aDa3CArvX/LR3HOFg1jXknLMDkE+npsAk7z4a9BgafZajOwW8ZA44qX+W1netzK3
         c64covWDGl4E+V2lbWltdsAerWvmQuq4096lKoioo5bfQo4KzBJNK/fHSQz9bGybcwjn
         pXk5EjlAbixQQNWn0IsDkXvj8fV5q0O4zuVVkWzTaFuPjh8kViL8F3huBEwzinUeRtBV
         K1GSe4F0spYa5h2aJS+QcSzg65g0Sxig7ZDq5vyz8UU5FqMl/wsigTh7AGIfPhhq7UzY
         VenDxOe16HhfAjwOEkmTYDHXq4BqXjRq6qwaAPUs6C4fK++P1UNKek8Yn2iWW+plkhNf
         cSfA==
X-Forwarded-Encrypted: i=1; AKwUvBx1V4kEZbrudioW8DsKPzgATUUV6S+37oNIQ1qirHxQsg1250JgoZcuf3ZRt65bWZXgNjFvsjc=@vger.kernel.org
X-Gm-Message-State: AFuF++mh8lHCOjMwEgRyldBILRx7nZOPiq3NURZRe94J8jinB3MhzTn6
	6OIWnzeAsJIyisTi8sEMmIeHetsM5PU1S6klegqI9bKB9pX2txsFC2/G
X-Gm-Gg: AYBFou0JyApZbVavGfD3eF7vY6oyLzMQXBJqyW+3uVpsBisifPz3FOOiStJDm4sqZs0
	qRNHKFzJNg+Cs43mGUDYCCNur+QphtLamFcIlvoMv/DXVcE4jImGJ0j2HHyowLcCkXyd9o4lZXu
	ZzjbZLj8QVfn+JXjb+2Lh/rd6iNgEh9gSnPfUHuG8ze8RIYi2Ia++oNAAKPgK0xAABdKX7B7236
	D98hQWJsMIdGeI+Z9cvwpsVVw6nMm79JIPpAC7XT34nqidVH3zcsSsKTJsvps8MQRpEXHIoKE14
	O7oerOb505kDUV9WAx2fyLuisHf0kl7wCaOqC5crSQf0X7+qt5bd0kGdtw2LvRYScBrQV2yg4Lc
	ZQrannf/D15z0LLET2y6CYhWHhOfLVPWri6Ot8l32v5Ub7Ibpn/RMhd9yAIHbZqTWyKOKouwnRz
	NHSod85W1PnTBZvnYffGZj+tuff8W7VF/eHmiBtETSNcN+mIsdcWWkk8gnlirww60kKinrQ73xG
	9x6vT86F8SV4k7B0V5Hjanw7VI4M+Ol
X-Received: by 2002:a05:6a00:4c0a:b0:857:726d:270c with SMTP id d2e1a72fcca58-86b324ec7c3mr13256910b3a.24.1789202396854;
        Sat, 12 Sep 2026 01:39:56 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a2c1542sm2128108b3a.55.2026.09.12.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:39:56 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suwan Kim <suwan.kim027@gmail.com>,
	co+66c3f58096d0bde8@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usbip: stub: keep URB array state consistent on errors
Date: Sat, 12 Sep 2026 16:39:26 +0800
Message-ID: <20260912083925.587987-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stub_priv_alloc() links a zeroed stub_priv to priv_init before the URB
array is allocated.  The error handler may therefore consume the object
after stub_recv_cmd_submit() reports SDEV_EVENT_ERROR_MALLOC.

Do not publish num_urbs until the array exists.  If a later URB allocation
fails, clear the freed array pointer and count before the event handler can
walk them.  This prevents a NULL dereference on array-allocation failure
and freed-array reads that can lead to invalid URB use or a double free on
later failures.

Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub driver")
Cc: stable@vger.kernel.org # 5.4+
Reported-by: co+66c3f58096d0bde8@bugs.sh
Closes: https://lore.kernel.org/all/J3vQPnNHSkQ6YUiFvu1bk8ai3Q8aZ7a9J1Y7%40bugs.sh/
Assisted-by: Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/usb/usbip/stub_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 1e9ae578810d9..33058fb05b2f4 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -534,10 +534,10 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	}
 
 	/* allocate urb array */
-	priv->num_urbs = num_urbs;
 	priv->urbs = kmalloc_objs(*priv->urbs, num_urbs);
 	if (!priv->urbs)
 		goto err_urbs;
+	priv->num_urbs = num_urbs;
 
 	/* setup a urb */
 	if (support_sg) {
@@ -641,6 +641,8 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 
 err_urb:
 	kfree(priv->urbs);
+	priv->urbs = NULL;
+	priv->num_urbs = 0;
 err_urbs:
 	kfree(buffer);
 	sgl_free(sgl);
-- 
2.55.0

