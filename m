Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923533;
	b=3HJfR21PvvD4kRvJju2Hhn0Gk+54x3vx1ub2dOY5fdmdOnYLdzx/Opbis4b+7iulK3ZG
	 ZDx/XY0cEleMjw+ctlJa4KwrY4/0mgxEQ0YYl4EYDMDyn8jadTWQ3WJov4JiCaAshcWnh
	 eVtknwU2NAnIbbrxeJWgsad+NT6CGqKUGvoY0MobW+LNpEY8ZCczakRf+NgLY/lITwFxz
	 egxsIe0EtjEvrFQr0bi+6+OGdtmpdOFPRQlO5bC5Xq+sXvLFYu3EUIeWV3LwiIWLO2xIB
	 KikH6t/VK2M0Hc9lSjg6NnPSafGHHU1JpKER5+CG17h+hwHV1+yKtQc+KNO7WbDDA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X9eeST+DTiB0/P5zHssKOgXfvR+02Yq9ClIKmFNmHPk=;
	b=jiZHmBjS7XzfNfnamA0B3S56K+5ppO7XDHJY53IA/4CgYxYrh0IM2lUQJZxhEQGOkIPa
	 VZdKBQbHVln3pkm+QySkVHgUWczEGU3eXL1rWc5p/ldE5DmHQnDamkH7/4LturivWqJjU
	 s02ZOgBuERhuDCsW0e6+tvdmFoTxJLRGxua+3s/G6sVdQvnMGu5fPSpZ3/yG0iUkTpw2b
	 f08IFtopOLk5CX1GeZFMdHfxUtLFxNlVyg7eOC6EId376CHI5DukYS6mGeh1MGULBMUJZ
	 iuF7CVXff+8DWW5/YnrWsqYbu6698iMT8aJVeYqjO5NQVUK2JETvT1XBTPaPLs7Gslg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzy9RLke;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0C606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43B0C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzy9RLke
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso1964911a12.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923533; x=1795528333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9eeST+DTiB0/P5zHssKOgXfvR+02Yq9ClIKmFNmHPk=;
        b=vzy9RLkeCJKIEWkEHVhJCVUsJ/6sFeknsgnHsqgvE3UqZvqgGs/OtiRJsZtM83ea/1
         H6sCrwzmyZw7Dpx7VOo2A5lV82HGhIS86JiFmNZpHcFFygEpLLgg/0UpWopedKgqs4dw
         1WanW1oYKDPVyvcZdFipmynShUkjTAwlR4RRE+iZvSN1XVc/cgTXDOrQtJWWvhdhv/8g
         dmqt5txFPziJxsTKekhwhjpZYFm1a/rxCz4c4qpSUkp484a631OqjF5bYaq28b1DLjVx
         hnj88rC8+Xgf+yMoUqnOmxZ8goi790B+C9jcuEpUb2xs88n6kCITZjWgb+NPGp3kGVd0
         szbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923533; x=1795528333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X9eeST+DTiB0/P5zHssKOgXfvR+02Yq9ClIKmFNmHPk=;
        b=G50aLnN6lBJOdThToJ6CA0Ytr3Pe3vn/tPc76juEuw8wu1YwqtuqoQXM4K/gPTQ4wB
         Xst6PV5QC6Cm6TDVGOuEnbrsJnzg0dwvG/P1RXE55sf59hOoV4W8wxULAdmiI8prED9K
         ASJB9YlxggTbBcKZuHND432ApjnLEMt4WhrQbNP8CxL9+oDNvENIEaoAp/zFqL2CHvHX
         jOjnsdOwP1YL0eViJhbPN1jsGF+1bXIhjDgkSWBelHmEj6UU/hSbZCaYOPn2g+kHzBMU
         p/yRFEVinltoYFYelLzr2/MWSxtKs+NtxxRVuFGkEmGpFLCK6pwzuTTONB70kIVgt7W4
         DR8g==
X-Forwarded-Encrypted: i=1; AL+hErGMmBYelDnGLxCPd79XVwK/gA5g1LI5mIr4jruPK4ciEx08Jn33662TsTd1kvTRKAYsmHOfiCk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TTZGL6Z2nWKi5d/3VXuSx300uDWKDm13cogS5pYbbDFTsx9wc
	SPTreiudWInjGaBnWoh3j4sLGUdKyILXn+hrMSBKlE69YIi30AWh30+Q
X-Gm-Gg: AZFdTZckeWpTzy1RRzj7icBdyzfRozT8YL5/1P/0zMDH81KE2YyEwVvXuvbbYWzgQVn
	aPmC5w7qSdJtlNVg7SuFQxriTBrGIzWUZS88Yv9QEosrTwRSDcOFlDKDVQwVQ5tDZLS5KnEa+Pe
	YJQKBx+9FZUyGBjM1jY3XNNKLb9wYzNHQGf1FiT8nvacoRc20lKWxIoSCE9Z5Uy+Bn5fdjtbxby
	AuVnELKhIstt2p7SfKaYjHxgfHgWwhP/34iniIPbR5VAPbzZKSDo66Ab2Th+hrpNBE/2AipBHOo
	mHW9KI3UvELbdBYT3lkGYvS23pgpc7/RlFXlOdsjZrTV/7MMuPzhpLyZxacsViTsfh995noaOTP
	gzeKnxVFdcBfon34PR4rsuDooBR+QMdFy9itZktHNwAAYZIdOlx6n1WIATHB/2efP3+t77dgbtO
	RFDvKfloIMUaA3NHOFASvH6PlU48evleC+iDx6genSrJtkMVtkFCMQME6+nTTVVqJzlHZGinvoI
	guWbRW1C+DyNTKbslnzXmS8GbJ96WPHgjcnBESMAOX4dif5PW1cVlUAvf2ArFwwm9QlxxMd3bjm
	qW/EQ9nrmyaHweFznvaQCwPWiV1mA3Q/OKie7/iGQ37zySG7HzygjtOhz0fbfclrPSEBxz4=
X-Received: by 2002:a17:903:3845:b0:2d8:d4cd:dc8f with SMTP id d9443c01a7336-2ee0da9892dmr141649045ad.18.1794923532596;
        Tue, 17 Nov 2026 05:52:12 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a586c1sm15937035ad.43.2026.11.17.05.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:52:12 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] inotify: copy full qstr length for event names
Date: Tue, 17 Nov 2026 22:51:36 +0900
Message-ID: <20261117135146.3174252-3-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
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

inotify_handle_inode_event() allocates the variable-length event via
kmalloc(), reserving name->len + 1 bytes for event->name, and stores
name->len in event->name_len. strscpy() stops at an embedded NUL in
name->name, leaving the trailing name bytes uninitialized.
copy_event_to_user() copies event->name_len bytes from that buffer to
userspace, leaking uninitialized kernel slab memory. The terminator
and alignment padding are zeroed separately in userspace.

Use memcpy() to copy the full qstr length and write the terminator
separately, as __d_alloc() and d_path() handle length-bearing names.

Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v2:
- Use memcpy() as suggested by Amir Goldstein and terminate at name->len.
- Copy only the valid qstr bytes to avoid a one-byte read past name->name.

 fs/notify/inotify/inotify_fsnotify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 6e3af6452dcc..ecbfc9b4e99c 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -120,8 +120,10 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
-	if (len)
-		strscpy(event->name, name->name, event->name_len + 1);
+	if (len) {
+		memcpy(event->name, name->name, len);
+		event->name[len] = '\0';
+	}
 
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
