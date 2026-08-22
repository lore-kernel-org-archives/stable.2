Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E138425A
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787397797; cv=none; b=kXfiQjRIIiXFWQUxu4OChxBFfFtjtIke7K7pv0v+cDfmiQ0eiXzTIXhVVtthye0tCBICLsRtlpa4QIFWoaBamGj1HQO+1zPXOmN/Gg3S52X6B7umntEJ5iR8fdD+6escaNSJ0gadLqNo5IK7O6Tad9IxkMLjmELQGloXfYuQkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787397797; c=relaxed/simple;
	bh=uJc74lO7WjucvgdI8DkhmeL+OgjdvyWd31lZCUuWJs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7A7toNntAOTHcSMMrMQfoeXvQP1h4vaVisup+/b7UExyY+RoxGsKMN6mXcJWoPrDMBNA/ZcN6VR85XZgN1ioTQH+p2pwuduAv60pMe+tQxTXMj65eqwqkYJ+WJuYwbEaf6TGt77uV8yXPLhcrAmY0GDAhmhjcyZZV4wVugAXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSiDAYUF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSiDAYUF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so2487553a91.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 04:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787397795; x=1788002595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkT+mJiPYkVs3Ps4IpYVCOf6FJxHOGfqjEwyUrIBblc=;
        b=HSiDAYUFTgQK8I0Psv0bxIpdZWOzFdy6f+8CYtGJkGjtcSs9cP5ImAajEEYj3HUTgH
         oNwF9l5tSBTqF8G8tchvUh0UHh81b6hCLtRF1KNkLVCF/hQqRI/UCIza/twIfizdNzzo
         VJ5D/gEzjXKBW3XIGFIzYua8Ftsq7oGUezGZmFVPEgy503hLgHDO3ciBJgM8aVa5JzY2
         YG9JCdnpTbQkxUVZ6ySXCj3xCCUod1ax+s65wVHj4Fqm4ax05UNXeIjvhy0N5yBnKS6D
         7nUxmdoQJ6yCI9t8e1xljoO18+lqkoEEI5MqMch6KsLRSIg6QAPmyRbOqj/T9h93we/O
         zfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787397795; x=1788002595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkT+mJiPYkVs3Ps4IpYVCOf6FJxHOGfqjEwyUrIBblc=;
        b=WAPrXaPwIb+Pzg5SOZb2Rd0/ptMNanndBdHpCzNLCcpSetjM0clX6Vj4uzw5JM3yM0
         MX5phVRhFZkR2Wu+WiLnBJuUHNH1J4pzqpzXCke0KXoNgZlNqrO+wHK4sQqvFNBddJZ2
         9hXtHRKDEBV+nl+tza9Hdjsu539eoDhx5Bjvfn2/IoE9hP1Y9kECnQYOqtnKwWwdy0gm
         AMqscsh8QGUGQa30mfgfIXK5BE0z7RG3WRboPPrFJy6czNulxWU7TrwVURBtY+jYI/aJ
         QTZrLzzb2fsVWODyyzw1/JBnIhCTcBHuo8Ip5r79Lg4Lg39YZEuEy50nXqrLCwUw61K4
         rlEg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9qpG97UR5TXk8ONyacA2NMtX31oSdxNkFWHgE/IfVw9820NJxncI24GcmQCuvHGolkMlSQ3A=@vger.kernel.org
X-Gm-Message-State: AFuF++lm+NVlQDS3CI1PhnyVnEwQmGxxh0cf3HFe2HSgmo6spfrua4uR
	cAggku40OAg9qKErSpqIxwzGJrNrIlGEYw8EJGLuqbhFOZ27QSr/7DO7
X-Gm-Gg: AR+sD103ibWTjwBThxdW+FFYg2KL/hTKyVCbPE4b4HcP5aToqxYyeA+tAZVg7MTnN02
	1HpRPZDh2Hr1NN1ZrPUtxvRrQP76cBMnxtU3n7DSsczYvAHQq7zMlcks1Q2IucvBCGT7kZpZqTC
	aScMJ9OedKmRVJkwm93g+KaICL8at5lwZpGVFuhV1F1+XYEP83xqVAVbobmYTEEHAtfdfar6yHc
	CjlZrJWTRqytOOgYt54SP5kSKAsR08cczOC2YFiSzavg1ndWvzTfo2Wsynx7w6xj7BThLVS9prR
	4N7pccyRZyS4GoQBitNiCQgT7FVkynaGk+4YdOsOLsCeQT6W7wgVKo6tfA8iZbuSbzGJU1ew/0B
	nyWZXc3VQOVh0/yyYg689zV05df9jf0uY++oh7k7rk+cOCWIZQfPvcw/pKCDCzKDLML5asEPqcg
	x9qARrS/BGLSvv9wr/Th+tvvsrQIHwnc1V7bRZZAJ3nK4FGunMeoc95evMrn86Y90xIQmcDAokT
	A==
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-395c34fed98mr20373056a91.4.1787397795327;
        Sat, 22 Aug 2026 04:23:15 -0700 (PDT)
Received: from Default ([2409:40f4:101e:d886:7c8f:61d9:4c4d:7b7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm7100379eec.6.2026.08.22.04.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 04:23:14 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: mchehab@kernel.org
Cc: kees@kernel.org,
	hverkuil+cisco@kernel.org,
	ribalda@chromium.org,
	sakari.ailus@linux.intel.com,
	linma@zju.edu.cn,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: dvbdev: fix uaf in dvb_remove_device()
Date: Sat, 22 Aug 2026 16:52:56 +0530
Message-ID: <20260822112256.12346-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dvb_remove_device(), dvb_media_device_free(), device_destroy()
and list_del() all dereference dvbdev regardless of its refcount.
Thus, if refcount for dvbdev is 1, it can be freed and we
operate on freed memory causing a UAF. Fix this by moving
dvb_device_put() at the end of dvb_remove_device() so dvbdev
members can be safely freed and assigned NULL when dvbdev is alive.

Reported-by: syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=37578f730d38898f4b74
Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/media/dvb-core/dvbdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..9aa4b8fd7379 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -598,7 +598,6 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 
 	down_write(&minor_rwsem);
 	dvb_minors[dvbdev->minor] = NULL;
-	dvb_device_put(dvbdev);
 	up_write(&minor_rwsem);
 
 	dvb_media_device_free(dvbdev);
@@ -606,6 +605,8 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
 
 	list_del(&dvbdev->list_head);
+
+	dvb_device_put(dvbdev);
 }
 EXPORT_SYMBOL(dvb_remove_device);
 
-- 
2.55.0

