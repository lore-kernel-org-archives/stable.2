Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECC24A047
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122489; cv=none; b=jnWXwRrVlzAayU7WOO8xeyl9TGErGLMrXygdZPTjF/1tGrVe/cFOPmzuQdRWCTwddI6VPZt9XNttZj4aV2UtCcGDp7CfFhUkDd+NoDSBCyI9aq4lXYpFD908CsOkeruwTNR+McoE/gDPQ3PK5TNTSWegUzWGXNxn8K2x2fexV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122489; c=relaxed/simple;
	bh=cbGo4TQAahnvid5BzTcvwPcvLNuaLGXSG1MBAuo5OY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGR2HAXDezocJTKaHFL/I2sihn2c/bzZ4ljuI7R4oZXIQQB+qH//Rpz4+H1P8KQsiwfgvuxycFatYCmuqcZIkfWMl3tfWW+KgBCOCdlNgMCwqPUlD7EX1qPz6qa3OdvE+XGNUmg5xMY+75IzgYtLfowenH2aL8uZifShtvOuh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CysKucRj; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CysKucRj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso1416365e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790122484; x=1790727284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k9P3MjJHm5LPq6fNgfWUG9o64JUvZTiy872DYV+9qyA=;
        b=CysKucRjAeHbUCuu1hB8404+eSBj109byUFUwmhFgg4L6sF5S6GeXDOPDlsORn1+8T
         6DrC4GKo+nudfefJU5qot6RNuLEsmccusGn6Z+INVHw8vfjscnZwPyjaJjjlIo0ez1dm
         K/0eSpxxAkzNrrizfR3s4RKnxwKrRSCNZO9Ngcw6XAsLzUTKIv8AYySR7Qbbt6XG+QsC
         xBjh1c9kg6hY2t/MhC92GeIJGIU4exBrx5ff0pDMg4pyIQtI0kE7JZsdBTaiEkO1Now0
         vYP0fPmAR4sxRCwLc3PLgZ+OXMPWdg5ApzPmtIY8LQMqg+tp/1XvIzUp2+GreNnfuba9
         IqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790122484; x=1790727284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9P3MjJHm5LPq6fNgfWUG9o64JUvZTiy872DYV+9qyA=;
        b=NES44stnk4oT1eVGh0p/83sx2p0sY/oCdLL2LpGssMr9X/j5R+GoZ6eNl9MNYJzcF1
         d4hTG0SSamPSBtVNXFREKBgQPBd7yrF6csz6VQ6qgYM2K/jTFbmzGfY9seWERl6cCIq5
         NrNzUPPQdL1pyqOPd+9ZkK4XLIRV/gU1tsYW+xAL6tJ30NM8iM8LsT/WVOjcMg6ElZP9
         VvQrOfPia4l6lzfSgjcz6nRXcrwIOx8BSEunyYt9vgqUf5PgmmEEolAC9aLVbSE5HUyL
         AKbd4Oa3vHyo8PMVFkc1uEGHSNHAG6PSErNyzvz4FJFQWREL5MBJNIcoIpv1L2Zr7ZTd
         6jpQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+AOJHCRRauB5aGddP2xlOB7yyGu1xyFHgaDPOCDXCRirJSBB92Ba4qUlpyOSdENa+CNJnUq8=@vger.kernel.org
X-Gm-Message-State: AFuF++msZf7YXvOD78NwhWEH2rJlcleMHlfyqhfTiyF484cZesdemNgs
	+mOtGInFePW3HseBlQLeaUWsGdxpayONXUmWIHw8JnMiw51252oDZb6zZG2Dw1JOCFo=
X-Gm-Gg: AYBFou05TPaKCKd2Fdqdu6RsvcthFsSiHcMwQUulR7dcM8odfy24OQGAKIznlluNuIr
	aRPlHVezOUfAxuKMbUDAIZpJv1KluDJ/iNtHJrkCpnUrZdxYyjGQCCxAaewxuFOBUDwGdOn4P03
	/01QxUJBBMf7jMW0xs0g4mTJJecOMnj4/ZajMGxUxiBDSgyJFsi0gwrcJBnVLLPWdtIKTVWpn3t
	GFtJD/ZcJPFCqO0dJoPEEwSV4FAtoc2dOmhSviLEeEI27sKueTArGIJ/0SjncZtBV88jgDWe1tl
	kkLtL15LNTaiDFPyA9JAuknZt4/dxn/urNBmypG/Xt/xbGniVtoR8BsmtrUzcg+4qD7AHpnLYDM
	phO27I/PdvGkdgBsm5sUjgceQ1LznD778tTPJzKGNt1ZlPidn5TDPG/PO/AHKdcyOCGF7fkPx42
	syxrfwt7ap8cAPw+fF7/taS50XoXg8k2gz4pS0II6D5N5pB83ZzjBDFaryGHu/NvsiDSk1xonPe
	jev9DdzIMZjgscCtdjSuevl9+rns6JiSbCLsu7ll0d4vRLfnUpqe5H4aLDHBB3/k7xy29/rmJCx
	K54EZyo/xlugLbXHqwzwf5odgnyfTGA5HaKFgM2Rq0ll8N9VXhqrZcdzvjaEZwESX5d1hQtHga2
	qxPw5jGd24UqhoXan/0AG+g==
X-Received: by 2002:a05:600c:8b83:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49fdf14578dmr9080065e9.24.1790122484156;
        Tue, 22 Sep 2026 17:14:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-c000-0ddf-8c68-4a09-6ad6-6324.ipv6.o2.cz. [2a00:1028:c000:ddf:8c68:4a09:6ad6:6324])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde180a39sm34612165e9.1.2026.09.22.17.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 17:14:42 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <v4bel@theori.io>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/6] media: dvb-core: wake up CA users on release
Date: Wed, 23 Sep 2026 02:14:10 +0200
Message-ID: <20260923001410.30297-7-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923001410.30297-1-pepe.schlehofer@gmail.com>
References: <20260923001410.30297-1-pepe.schlehofer@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_ca_en50221_release() sets ca->exit and waits for open users to close
the CA device, but read, write, poll and ioctl can continue and blocked
readers and pollers are not woken.

Return -ENODEV from CA read, write and ioctl operations and EPOLLERR
from poll after ca->exit is set, and wake the corresponding wait queues.
Keep the release wait so the existing lifetime protection remains in
place.

tvheadend keeps the CA device open and waits for it with epoll, so it
needs to observe the disconnect before it can close the device.

Fixes: 280a8ab81733 ("media: dvb-core: Fix use-after-free due to race condition at dvb_ca_en50221")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index 1b91ebb8f667..d478f995d5a9 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1353,6 +1353,9 @@ static int dvb_ca_en50221_io_do_ioctl(struct file *file,
 
 	dprintk("%s\n", __func__);
 
+	if (ca->exit)
+		return -ENODEV;
+
 	if (mutex_lock_interruptible(&ca->ioctl_mutex))
 		return -ERESTARTSYS;
 
@@ -1460,6 +1463,9 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 	dprintk("%s\n", __func__);
 
+	if (ca->exit)
+		return -ENODEV;
+
 	/*
 	 * Incoming packet has a 2 byte header.
 	 * hdr[0] = slot_id, hdr[1] = connection_id
@@ -1618,6 +1624,9 @@ static ssize_t dvb_ca_en50221_io_read(struct file *file, char __user *buf,
 
 	dprintk("%s\n", __func__);
 
+	if (ca->exit)
+		return -ENODEV;
+
 	/*
 	 * Outgoing packet has a 2 byte header.
 	 * hdr[0] = slot_id, hdr[1] = connection_id
@@ -1635,8 +1644,11 @@ static ssize_t dvb_ca_en50221_io_read(struct file *file, char __user *buf,
 		/* wait for some data */
 		status = wait_event_interruptible(ca->wait_queue,
 						  dvb_ca_en50221_io_read_condition
-						  (ca, &result, &slot));
+						  (ca, &result, &slot) ||
+						  ca->exit);
 	}
+	if (ca->exit)
+		return -ENODEV;
 	if ((status < 0) || (result < 0)) {
 		if (result)
 			return result;
@@ -1819,6 +1831,9 @@ static __poll_t dvb_ca_en50221_io_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &ca->wait_queue, wait);
 
+	if (ca->exit)
+		return EPOLLERR;
+
 	if (dvb_ca_en50221_io_read_condition(ca, &result, &slot) == 1)
 		mask |= EPOLLIN;
 
@@ -1965,6 +1980,13 @@ void dvb_ca_en50221_release(struct dvb_ca_en50221 *pubca)
 	ca->exit = 1;
 	mutex_unlock(&ca->remove_mutex);
 
+	/*
+	 * Wake up everyone blocked in read() or poll() on the CA device, so
+	 * that they see the error and close it. The wait below cannot finish
+	 * before the last user has closed the device.
+	 */
+	wake_up_interruptible_all(&ca->wait_queue);
+
 	if (ca->dvbdev->users < 1)
 		wait_event(ca->dvbdev->wait_queue,
 				ca->dvbdev->users == 1);
-- 
2.54.0 (Apple Git-157)

