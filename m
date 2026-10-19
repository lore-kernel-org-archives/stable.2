Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442102;
	b=XT49GsOM8Cw+q2MuKVKddFpk7D95Db8nrtFyfpqQxpee1jwbJ1gNQ1ybjYSDHB10Nqic
	 B4ai9/6ONivpa5gya2arEOCzJM9Ux6lnyxqeGG6OnGDBNSsV9S5bLosnxXjnFAdLk6u4i
	 sZJQ1Wq6ueW34LX4l9sL4IE5xUAQ92yBdjC+lO9jGvHimI9GZS/2zR5ifQtkGfWydml0S
	 LV9nQbzShqJ6TZHBLYejJ4LPdA9qDNcL8d4nO8JkZDoFHEo5G64rUSFXXQ9oiC+/ftdW7
	 8qv4UdDT8/w/b6vgwba2WawF/rQw3JITIlRpZFVkR2l9kWGeQ9V+3e6rBSz2Bymfnfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QiKFKvXps967wwyLmEJ59eoTg+fbLeK6RWK4w7bM5/w=;
	b=wkZGs6SIdznKjB/JGqHUvszTVJVh/jXD+OUQjluI/IQ+fCeDJ95ofziVX/dasp8u3jgj
	 FL3pqjJgzdVGrGXHoIT0QUwlNQ0GxSeJh0D61/KIV4xlqJDcqnGic+KDKlOMTYp8wZ4kK
	 YwWG8gCxEeThjgJ19x40HIkg0ZenIeqsQmrHFLAjie8dmLRvLh4oaVsFege1ZazYG5EKs
	 1FX+FfID9hZTiBkQ2VuZauD1x4sYqdSHGdjTvrhwOjt6xQECQMot3fz82HazRzaj41gmf
	 C8GDyXjGeBLPLbXmq8tD1tkN7QqQX4i26j3YP6s+QMV4Q/FZdj8AqRvHxKo09I1cFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZk3+FV5;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954D606A331
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C954D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZk3+FV5
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so19193165e9.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442100; x=1793046900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiKFKvXps967wwyLmEJ59eoTg+fbLeK6RWK4w7bM5/w=;
        b=BZk3+FV5sP7TvpXJf9JI4+NIrngTAnbwPLj5823EEz1Z0X5cG+mkg9zSiurXIUT7oG
         jTRhyO7gBRMCKOJZvPC37cDLRbenfqi/xkzVh5VU6UqfsX6qSrHtAhN1J5qJisRGQB8R
         ai2jRPg61ASl7Ys8//+9Ry1aGySqhbXR9hH1X2UdV+2jheAhovhf0sYxgK8lmS3kj3F5
         4mEMFCBGQfbqD5inyct3EVbTiznmcU8UbYSPjol/pmTNiRURmX/zEZuAa8L+0Kp5WmLv
         E2GbDFsdFbmlCx+95Pboyf/+atdik0lAnXIpYs0Y+a1W4TMOhrKe1eV4bR390Zpz+gx0
         PfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442100; x=1793046900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiKFKvXps967wwyLmEJ59eoTg+fbLeK6RWK4w7bM5/w=;
        b=yMfXkSkT11/EdpHWRY6gqqiDvE/q4ODZXZ9GVCT7+5ZtFCWgnNrl+PEV1ff3jOGhgq
         LcLlaStP4hwaLlKBuzmEOxKHocZwkWqYk39WUhr9HckIl7vW7QQ1WrHOHLCWSGo4zr7u
         cDtbfp01jyVU86v/IZuhl4Znxz+PJRGdizS6wJYxKPbUdavB8nddvpW61IHBGvvctd9z
         dgLSdowHOvvFUKWc9fzkTZys57/d2cFXwK83fWb9UwwcMXwj0PWwmcF4845bgITYnGpu
         LucGw5IcyJhEwf9cvWcgS/6G8ihtPhUzezJV29GtpWKa7St5txltf+SyCgvlu0ES96YB
         CQDw==
X-Forwarded-Encrypted: i=1; AKwUvBxgr/DmQrZPFWBBsmjs2h5pdgkcGl6m9HV4CqLsi34E7y7yit/QATZ7jAhx82tSnCOds+ZMBZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAUcaSkagWaGLDJArC/SoY4eVf8Gr0UHMCDcH5i8vLDRG04HDq
	IgrJgDHdBInO736hHNm1tt/0YQEplg/f+QZk8hgp7fipTpXFhGw0LEXgbVvn
X-Gm-Gg: AYBFou0ty5HA0tEbNweXion6Ub6D6EVHGoK89zqCyNvv9ZopVynEkzLIOQ0u9lfPkES
	+0R3+NJLs0bkbcjS6H3dL/rzTqygAwUHos8/T3Ha8FKBrfeJl8U0anJlTuSfY2SMTrcBs2WfPzz
	+lKyci0XD7JlfZiUji0NFO+LxJTb88vS7ZxpQmxdx6Dl7ioeIiWpHFwt2Er11DficF7Oup4PXu0
	rSbnGiGYSC7Pq/bwbicPBXep08+2ahrWiE9mxD3H/H+7ee9u+Vv8XTrMcWcWGUAfx3OpUVrHfSX
	SlTPR3ZuNV1aCpgblDU9nkJpsJZ9ZijZoVNYDhXKwYnM470mo01e4tZK31xG3g2ynY36SRIZj2m
	EOpvYifuNWCE2Lrg7kotTz1qHsrcW+AT7TOuEX1isGWrZEJJ67/nm4lRFpc7Nd1FURKzDMOkmq8
	KWjElArBkipI4DwH8KShrFJRtYZMGTW7Z+BF7xZgM=
X-Received: by 2002:a05:600c:6217:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4a1dda8eca9mr131113225e9.27.1792442099905;
        Mon, 19 Oct 2026 13:34:59 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d43242sm15802805e9.9.2026.10.19.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:34:59 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Cc: Stefan Bader <shbader@de.ibm.com>,
	linux-s390@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] s390/tape: cancel delayed work before freeing device
Date: Mon, 19 Oct 2026 20:34:57 +0000
Message-ID: <20261019203458.1365046-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

tape_put_device() frees the tape_device on the final reference drop
without cancelling the pending delayed work tape_dnr. If
tape_delayed_next_request() is still scheduled or running when the
struct is freed, the work function accesses freed memory via
container_of().

Add cancel_delayed_work_sync() before kfree() to ensure the work is
fully completed before the struct is freed.

Fixes: 4111796d89b8c ("[PATCH] s390: channel tape fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/s390/char/tape_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index bd8e3deb11993..e3aacfab2cc7a 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -532,6 +532,7 @@ tape_put_device(struct tape_device *device)
 	DBF_EVENT(4, "tape_put_device(%p) -> %i\n", device, count);
 	BUG_ON(count < 0);
 	if (count == 0) {
+		cancel_delayed_work_sync(&device->tape_dnr);
 		kfree(device->modeset_byte);
 		kfree(device);
 	}
-- 
2.47.3

