Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE76371867
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155663; cv=none; b=Z8Z8UGvyXbMh86GsbjQAhWPYY5dvQ/YPczcn/DLaOolUw1jU4Xui5AagTEiLkOZ3Kh2bV7nshUiBJzZoFe3relQFfACqO8pdVEMaV1eppTn08LQeic4fq7kjQcDDzbml7V2FeKhCGnKjv+WmnYsv6mwzgn1yffuVb7WRmyegQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155663; c=relaxed/simple;
	bh=tnL9O9Z7eVZ+EFi12OyJIwP3KzopoQRB3H0/5ZGueNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dzh1alaTXsHbvfXpDKSMIStpXfUVzH92AQ+pbWLQROdCrIODkqr2v8ZFvVa5usON/icSqoR6NuNoeMkt688YOPXbzRd5nXt+uAOxNyKXUtT44NygX1+IsdOqjMXDpl5GQszy4cBBs3qo5TXqinSjyYYmmCUNGx7z3JX2xhGtgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDncjdFY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDncjdFY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so2074940a91.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155661; x=1785760461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ad864FHAlhdgy4F9Sp08C6CuMiqJx6RHQkPj5GQwqjE=;
        b=SDncjdFYndxVcFvM4eSwH7OQqOIvZnH4dVWQvnlBgY+EFIih2pmUc15WrN9F9salVr
         j76hgjufrGZy8QIz+lKdhIMEYIdvzMGT1Qo/39OH9OJlU2uo7uYCGRTpMEKra119DmNJ
         uSQzZTA/YXLsD4ZuO7Yi2K/CKIbw7gwCv5GBeHzLdXfje4aquWX98TsibJLxAWKI/7bX
         bfnHGZUVws3ZOe/4EkxTtLyOcNA7/Ik3fqDo8U5FEHk2m/Hu2dbEtJWJcCtzHnYGt/Cd
         SzcAkTdLh1sHlBsSyB8P4k+Ka9A5LX6ic7ZHiYPxEPzKEwxw9xrPqBPH09NSU9aknPds
         aRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155661; x=1785760461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ad864FHAlhdgy4F9Sp08C6CuMiqJx6RHQkPj5GQwqjE=;
        b=JvBUJM+dKja39bVq1wEeJ4yvF1ZcZWNqtDSyFS0lpEnxboCvkG2VxHkrBzFpae860C
         U2i7AiR3+HFMYuAc/vjDCSHBWI2bOrtA8mkcgoc6qTBiUduGZee3eW0dO1ClOFChmXsh
         KFAXibYV1HttgqjlCVYtgNOgOJDvzx2/ZS49JDuPB2SoNDifaFcyV1vSh27lUs9V1TxV
         jL63wxSXQa9tNFJBfmKPD4lRmIF+yoJ73usLAmzIRdbF6L5gnxVF16r3ASXBP48hvcTZ
         ru81A28aUBFyRgIAZ7CTKC2HkpXRi1EfYLcUZ27S9fGXYEDX62R0H/BuEZ+xjFD0ZlyQ
         LDlA==
X-Forwarded-Encrypted: i=1; AHgh+RoxdRRtvos9a3mWWRnzjpptV93JdjNOjnKOMvqBFCdqC9XxX365GjZ/Ehvc0C/jz9o486bHRHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS7Ufa1t9NMfHYK4wr4RZjKq1JdT1fvZs6hCZkh6W4MuVuy8E
	5bFsqoiCabZYL+G9DtFN7StQ01DkkCyKhfitehTi8Jc66ir3TPQBmbw=
X-Gm-Gg: AR+sD138g5EZ8rhqIAX7z71sTXFKVd8Pgu7NZco2MnfjfjnhFKPz9jIAZUXRKN1gXNW
	v9tV6lpx4ZeGu1GMkw7+6ByQhWT0TIEQxX5hEUXN2S6MJnq/3l4Ed11rPd8/Nkdd7dLbUnQTqi8
	6bm22dqU6JkwWq6bYddAI9lH83h7joryNrdXMDXKGPBUyDa62Fuj9nc04kuxabSLu7OK6BQRT+n
	KKZtj7S9jLjOh+vC3qeoKTALeXKUiXSAlUPe6dISAK4aurNcDeP9r3hargjdAjmnw7DsikeGa2l
	frqjO/hgrwOL1O9+df1em9kin5iD9E2/0QQO+bs0wLEDNXQhoeCKbhBpPvKyIMI+NCbN8qu2iP7
	moncrUgOJNAQ34TNgMgOT/MpedqtDW39TavimRDXmLnnyJY5sa6WdtXxmTNz03na7+9w4muHGjX
	CaV2I7Ckz87es7hwc8RXTIAljTcs3i2oFFN8OGXvBWjkBe3yiM9i6zd6+vjYBBsJVI+YBETQ1VP
	2chAW8NA/V7ugyYYJaq9A9BxZ0sHy9BBD2L/ivbw/MoOfX3FFX7UME=
X-Received: by 2002:a17:90b:554f:b0:387:d5bd:6231 with SMTP id 98e67ed59e1d1-38f2aacfdadmr5837955a91.20.1785155661178;
        Mon, 27 Jul 2026 05:34:21 -0700 (PDT)
Received: from localhost.localdomain ([121.147.145.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03ad817esm4956993a91.4.2026.07.27.05.34.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 05:34:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	edwin_rong <edwin_rong@realsil.com.cn>,
	Ijae Kim <ae878000@gmail.com>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: storage: realtek_cr: fix use-after-free on disconnect
Date: Mon, 27 Jul 2026 21:34:14 +0900
Message-Id: <20260727123414.44700-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

realtek_cr_destructor() calls timer_delete() before the chip containing
the timer is freed. The timer callback may still be running and can
rearm itself, resulting in a use-after-free.

Use timer_shutdown_sync() to wait for the callback and prevent further
rearming. Do this unconditionally because ss_en may be changed after
the timer is armed.

Move timer_setup() into init_realtek_cr() so the timer is initialized
before any failure path can invoke the destructor.

Found by static analysis.

Fixes: e931830bb877 ("Realtek cr: Add autosuspend function.")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/storage/realtek_cr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index af038b897c6b..c4b28744693b 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -916,7 +916,6 @@ static int realtek_cr_autosuspend_setup(struct us_data *us)
 	us->proto_handler = rts51x_invoke_transport;
 
 	chip->timer_expires = 0;
-	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
 	fw5895_init(us);
 
 	/* enable autosuspend function of the usb device */
@@ -934,10 +933,7 @@ static void realtek_cr_destructor(void *extra)
 		return;
 
 #ifdef CONFIG_REALTEK_AUTOPM
-	if (ss_en) {
-		timer_delete(&chip->rts51x_suspend_timer);
-		chip->timer_expires = 0;
-	}
+	timer_shutdown_sync(&chip->rts51x_suspend_timer);
 #endif
 	kfree(chip->status);
 }
@@ -982,6 +978,9 @@ static int init_realtek_cr(struct us_data *us)
 
 	us->extra = chip;
 	us->extra_destructor = realtek_cr_destructor;
+#ifdef CONFIG_REALTEK_AUTOPM
+	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
+#endif
 	us->max_lun = chip->max_lun = rts51x_get_max_lun(us);
 	chip->us = us;
 
-- 
2.47.1

