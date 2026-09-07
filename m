Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C25013CA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794082; cv=none; b=TJHUXWZzovfFiieNUoE70psgMULDtRBQlKj/bxHh5q0V/pr6NwVDQC1OAZEy5qcL70gbKEe10bPNzEFTQ4qV+IxtWVPNJ7hjW4YbVt+6Wh+67CQZQIt4YUxwL8jYP8c5VYrA3xYU7bm9s+qTh4+bqjJ6/wlUxTaZbW/QXXG6XYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794082; c=relaxed/simple;
	bh=mNjpd1tQwWKdzKUEeAZaOMlQ8clRHjCrzGoa5fQ5e0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZ11SiSh0lBlXdhZJU/6kVWIXH3Xkl1Sq/JBix9D6Zah1VTayYc6RCMPW4LwmvPtNEXifBDMLOzQBUrHlAErAEzDkXbPHxkqXqMkgxbh5eN+NRVLYwvrlcz3S9+zxl0ReGWhUoWJqpRTu0UaBYzEwxbzvKIA2mdtYt+3yH0uC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV+b6MbT; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV+b6MbT"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74ab99038afso2468661137.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794079; x=1789398879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W9HwXQlNGS9bLvO1Kv0B3vOGIHhTJMb9BOvcgiHRmOU=;
        b=YV+b6MbTdU9we3rDFifWyokV2UArQSoXeTUTrP/4pcbgkrBxwpkzTLrRsF9e9wIg0h
         T7pffIMDm1TEv2IzMTbzbzlORyx1OURjcLi9S/8gJ30XJ5uXDYBq6XzrU+9l+dVHPEfs
         LxwYnjxrUQ3WwLVu4T/lbYMnCfgST6DNXDLjNaYrLEhJZKET0tmOb1GtLJFHKmTGpPyA
         mO2JZPz29+ToEroXDaA95Y8MDcLoOYWgnIb01HVgG6MZeYVP30XVPnRa2HFzZTkFK5H4
         WheiyG8uhDXcifr2pcbv9blNGtwqVUXAT8nenpbF1V7TJPF27lfcmlZcGCIdAvM8eF6o
         KnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794079; x=1789398879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9HwXQlNGS9bLvO1Kv0B3vOGIHhTJMb9BOvcgiHRmOU=;
        b=TqCfrLotT3n/CSmmd6ExEPTb1tqkc1/y6qGFB7CePS/2G/8FXIVc2NoS2XB90Ez9AW
         Rp/ewl+3n0SImmkOC0MX66Eb9m9nBdf73QJ5q1detc9ryHVYVYxvaIOFDxox9MDYl3/u
         Mv7QCmB4P9y235Bfsz3cVpUEqRK7aAc3pAayUC78kFnK714CYyLl820HgB11XqwISs8+
         TXNr8LHeZ/w7d8R4WW9oHGbpGVgTVRPCfNEVQtaPVnK4BO2JzqT0RuCu+6+BPU9rtwWU
         pe7r5UZ914Ow2kUTWrOB+MmAbJvAn3/cfT7Eihw2WjvBoOVua9xm4AOCv6d2aH708zs7
         7KPQ==
X-Forwarded-Encrypted: i=1; AKwUvByAPcgr0uGPtp30hnrAI/PeCDrA4l65xln0YSc2KRzmuDMWQ9B7u7+y08IR4mHPa4/PfDpD0mY=@vger.kernel.org
X-Gm-Message-State: AFuF++mYtugGDFT4j9EUAqHssIeUy1W66wP/VDjZsN8itBbQgY/6oYUd
	QvQ3HqZ3dIaG58i9+xRZMQlxvo5Uu7kYJfSEe5d8i048OQd5ncONYf3l
X-Gm-Gg: AYBFou1sGis7tkd6LQYZAxE35IgTFJfEtvYZbYC7q2KykwvT9keZGoA6tHkQEIZLLVD
	8OL+rmrFsqOHtDV8qy3G5z3/W08YkNVtJ0xd1etZ8siD7Ohv9BwuiAveeaP4xe/zA79IpZUvyYI
	wqV9TgQGhc/z54rkj3VMxTI7FddgH4pQcd/FIzOUdppzFm/SgWs0UYFsAP3XM8vYnLL7BUajczd
	mfT6HTN2jTy/J8DmcYAILtD/k00Ei66zBproc9SKvLKjiGk7Q4MtQ3VnSL8n8ZTNzLOM693WAab
	JtfnyXqv8iOFB+dQQxpr7vuIpCuQbqSanYaeGQHqnG89ILJhyDXl/OucqF6mHZghCGXkZ3UzTTp
	lF+Cwg+42mhy11ZUqudffvy2Dqq9hDWj+AUWZBvLGR7BKnxjbiFxHV6TCc276sdQfSXhYvJFr5i
	xGHWzwAygt1vKhH0Vs8yXicVQnJlBfHr0OpSX7HYF9MTqLxw4rjnJgKLaIcDotXRM=
X-Received: by 2002:a05:6102:80a9:b0:786:4822:308f with SMTP id ada2fe7eead31-78a4a9aea5fmr9223898137.13.1788794079271;
        Mon, 07 Sep 2026 08:14:39 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-980d774ad5dsm607088241.9.2026.09.07.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:14:38 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] mmc: vub300: fix use-after-free in vub300 teardown
Date: Mon,  7 Sep 2026 12:14:28 -0300
Message-ID: <20260907151428.643841-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not dereference mmc/vub300/udev after the final kref_put, because
it can release them via mmc_free_host()/usb_put_dev().

Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/mmc/host/vub300.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..a1a6aa1aafdb 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -370,13 +370,14 @@ static void vub300_delete(struct kref *kref)
 {				/* kref callback - softirq */
 	struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
 	struct mmc_host *mmc = vub300->mmc;
+	struct usb_device *udev = vub300->udev;
 
 	usb_free_urb(vub300->command_out_urb);
 	vub300->command_out_urb = NULL;
 	usb_free_urb(vub300->command_res_urb);
 	vub300->command_res_urb = NULL;
-	usb_put_dev(vub300->udev);
 	mmc_free_host(mmc);
+	usb_put_dev(udev);
 	/*
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
@@ -1794,8 +1795,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			construct_request_response(vub300, cmd);
 			vub300->resp_len = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(vub300->mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		}
 	}
@@ -1946,8 +1947,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		    satisfy_request_from_offloaded_data(vub300, cmd)) {
 			cmd->error = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		} else {
 			vub300->cmd = cmd;
-- 
2.51.0

