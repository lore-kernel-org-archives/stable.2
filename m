Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947869;
	b=iKMs3We9kGJy2n1aA33wfothu2IevqLZhPAmBGjowPFtgghFWH5HwYjjE+Z9yZ0d3IiZ
	 0nArvt/agv5PAbobd9hdIOJk1dtfbupY53ki/NpFsYsKEYgbA/Z6QTzprsl88UvQJTzse
	 e0lc8ykvMWhy7Jidxd+FZ8BUJV6L3aO4TpBdCIffuckxst/eHLBoTrkEeqCJq0e+HtSJW
	 6cCDe7XvhUOFjF7NPZ+I5f6N32xHATMKjzV0ULYbej0EV638HJ8VqnwOuQtek6/Mqv3W8
	 4ccDAtbMCBupgDbMCVFxybEKxTgk72800zjCiWM6VWvsIqyLh5/Tz4R4z8mNYyt5D8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HY6NyKTM8r0x5O+rVjJnGBZO/BpAxBcqOXQFhbzKwHQ=;
	b=2zTDrtoyEoMZvaFh2a3dj4OKPoM87L8MmHzVbJSSBqM08sQxBGxHMYXy0jEnCzYxMKPB
	 wH2b0qfXIXLPbstfu6oFVEwubQGbCrEyBHdcoMtnD5F/u/KDrgyTc+FZBlBP0BSnAHUm9
	 o2sMPxiTzqu8iNkZZYcsltgN89Mj++H9ubVY3avdPlF1FkI9me/H9geWBdDfxKyP1S8Ru
	 dYMpZhulHu3oredipk3zAxFMGVrDOS3UyP54YWfBWJHIFNqs8VZDbj3Yk/XonD0MkVYzr
	 6KR57l6nNCx4nWKTsT92NzH7NqioUP2jowr8pymlaNcp1HpcpIhSfjPg2sKfMqJqJlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWtVX+9y;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B413606D806
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 06:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B413606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OWtVX+9y
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14fc585291cso308298c88.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 22:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793947868; x=1794552668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HY6NyKTM8r0x5O+rVjJnGBZO/BpAxBcqOXQFhbzKwHQ=;
        b=OWtVX+9yJiDrq0rs2SpBd1em1ofisUH7B0auKEjhCJaJR29DjdEYtxDQlX+Dw88AH3
         3scUaZMgYjvdWP6yejXOIoQTt8JFDEsneRU6k+BjRU/wXaYOyANu40T81x914lb0M4Nc
         kfIa1BRPkCDHu3LsYSyKL+1kN9OrruoODUS3W8BbQEXCjrd7RE5Dy7LlKw5LElg8OlLU
         ScnnOIekOhEoMnGJBQP1n6VtNynZ/4Gro8USt/QjLxFhILpJVqWByAJy5ma6NlqIpFgj
         w7TbiXpwxmWNXntPnIEsFqSIcgVSfqHazGSBIyGTO3R7L6GuTCTxsE7wuFbJOVVFcnai
         NfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793947868; x=1794552668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HY6NyKTM8r0x5O+rVjJnGBZO/BpAxBcqOXQFhbzKwHQ=;
        b=S+A8yyClhM+1ZUSmEVa6Wtra7KDD9SujemUseNh1gcRtAUuatZem1OMZccvRGI/y0g
         JSrwzD0+10tz4GwTmJ1mQMuGxjtWQeC0y/ZCufgp1DLEqulvmBPvLLPr1V25AZqTROnQ
         tbo1+LzOPz9T47YzV/wZAJKUvoCLZDt2rqmC19Ot8CZM69KUe4PR4e1tD3LKNy58Y46q
         ZMffhwKJvd0/WGmWuSWQx7b+KDY7yxBDsTqA2LWvv0kxXPFWWxcv8u9A+aFff0FTu1kn
         fmt4vDuw1CmModjItvnmAOQ+SoDIP6xSZD5WWbZWZvzTcTgo4JHP9Z2IHVDGeLyRsfVt
         VcwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVD1nmipUejeuRtg1eNM7jo2Q/OtFHFLxfESJ8TfrOtt1Qienu97GyjsEeV2Kpk/USL6+XsYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z81mCr+Uy01KGIwXd1TD1/sPaMqV2V9EPg4G7a+JF6TWYCBoJqp
	xmvhhpdgp0c9G99cGvkfQUbCrjG9O2g0UBSnOdh43PDDeH0Mpy31yW4M
X-Gm-Gg: AYBFou2bLVnbNKR/SBebKDJFyTlPYDMnuqqX/GfmG0T6PSylyZFK4+a0ZxfOgSsTtX1
	gVs9wEz0drav3t5Z48MqxU7/eikR5t45kYKzeky/d0ZdmvMksst+Gm7jO7p69U6fWTUa2gGP7GW
	wvg9AxXC9OFeklxUQVsrf/beStXriNwP5OatDUZsehitrmFnlUJo46ypQ2d5yNv/125kgSH0zGM
	5TNv9UjIPEHiKm2SIFcu4nWWpejdoxfOzx+HN/7OTh2TQd2b9vbN9ywrJsqTGP5DdYTh3fOIAIt
	/jhwMN81bu1gijn3Hl1I5V6z1A5fmqwkOzgT3k+Tx6vKKlia2LbgPIYictzmPyeuPHn1NZh+7Gi
	A+mt7kl9KLWlB0XZ5tWnMNDCdF3kJskU4+ycyQzWSnnJCzK2CArNDJ9cAyCKcTfhN3aAa+/GIFB
	su23Exg+MvZ6h6EOX3xbh8p4880yv47hybK21Mn5u/sioiGIi2+ocTfx6wwF46CRakC7YEpAmBB
	n4kfzRL5P3y/0h0BhkwMXhyTd9WYNCWWwKLYbn/5XMsA2iQ1JT9neJGGfaJ+2WJxewKaO+ToRHR
	XwdlUqe/wHATkpuhNntE+JEsrB9wL5y5M1oMY91lmDaoELrue8aF
X-Received: by 2002:a05:7022:3b83:b0:1b2:4cc7:7db2 with SMTP id a92af1059eb24-1b25d34ed54mr2078977c88.47.1793947868395;
        Thu, 05 Nov 2026 22:51:08 -0800 (PST)
Received: from localhost.localdomain ([117.20.154.48])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4d22cesm3196906c88.16.2026.11.05.22.51.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 22:51:07 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] remoteproc: core: Do not put the device when device_add() fails
Date: Fri,  6 Nov 2026 14:51:00 +0800
Message-ID: <20261106065100.44269-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

In rproc_add(), put_device() is called when device_add() fails.
But st_slim_rproc_alloc(), xlnx_r5_remoteproc and the other 23
drivers (which use devm_rproc_alloc() and so devm_rproc_free()) then
call rproc_free(), which puts the device again. The reference is
dropped twice, and st_slim_rproc_alloc() uses the rproc after it is
freed.

Remove the put_device() in rproc_add() and add a comment saying why.

Fixes: 7dbdb8bd7c02 ("remoteproc: core: Cleanup device in case of failure")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    Changes in v2:
    - Comment in the device_add() failure branch (Mathieu).
    - Shorter changelog.
    - Rebased on rproc-next.
    
    Bug was found by kbound, an internal static analysis prototype.
    The reproduction was assisted by Claude Opus 5.5.
    
    v1: https://lore.kernel.org/linux-remoteproc/20261029130037.5505-1-izaiahsun@gmail.com/

 drivers/remoteproc/remoteproc_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index d5fa9d23bd5c..d0b1f6ee49d3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2312,7 +2312,10 @@ int rproc_add(struct rproc *rproc)
 
 	ret = device_add(dev);
 	if (ret < 0) {
-		put_device(dev);
+		/*
+		 * Do not put_device() here: the caller's rproc_free() does
+		 * it, and the reference would be dropped twice.
+		 */
 		goto rproc_remove_cdev;
 	}
 

base-commit: b16b5a4fdf7d1f4ec15a53622d9b66081325fbf9
-- 
2.53.0

