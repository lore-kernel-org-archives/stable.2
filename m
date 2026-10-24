Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875435;
	b=KodSX9fFSbmVzWaeR4DezQc33U45iC0um/y2CaAh++egUn4aA3Uo0JyrAAm7U7Bgyyh+
	 5nbULbuGpA8mwtoZr5aAptxRV3rPgny1jcoPT96xeiB6KIS/ZaLmDD1XPoooi4VohnA7A
	 PvgqU7LQ7FsE6QbBjhKQWJ6cgXXap7akNXkDwnSh5LRhsLBIj2pZUmTkg4ZiK6qE1w3R9
	 ENfJf/DeddmLMsSuiZ4nlwEnbw7et5w0q+Kx7BbxbGlso33RProezocePPgCkPi+L/IeJ
	 43woR31cjIg39/SksIkhiWEjHhYHctMg9vwpeAPXGHXUlwju6ZQANtVBBWl61nfb8AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IV1NP8FklaqMSKF4K9LgBOKBFJvutUzvKwE1feKuMJk=;
	b=K8a0q1OF23M4a6ui5bukyVB2JCiLyKuMj1DbOUKG1s3JhKh1AKx14j5W/Fy363ScfVS9
	 ZcLuguDc8hyM3BEZlpCr5t4qtrw2Z/2bxKhca1BiH5k5NDhS7xRUAWoXwGO0al09I6x9n
	 u8bk1DuDdTzK+ReyrxskRiEWOroDwnTcxPq/1JBL9vChPsHj7Fgf7xoLmWqrwmOmp03jL
	 PoXJEP0FD0nIGgNLyK99C+1jcSLTsg9q4pwvTFbX6yRejpgyfN39AnZ6Vj7jvx5lt7qu8
	 9ym9R+B7PpypC2QHANk2+aOkTLvrft0d2cZNx1qxpZ81/3/3kx1IYc8OaJ7vzQfHokA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cujVOZbH;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62C606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF62C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cujVOZbH
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso19608045e9.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875433; x=1793480233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IV1NP8FklaqMSKF4K9LgBOKBFJvutUzvKwE1feKuMJk=;
        b=cujVOZbHlQfToaTJYXhFKOmdi7F7oOBIQEBzgQxzq04TO0nTp0Pq4Fjx7TvqFwJAo+
         rtcIxzzEVRCOJL+qbkO7vsdqGmkWd7a1ZmcgO5X1cP7xTlh9OSE5Llx6uAXIpyDv2s+R
         +4+0G/CJ7Fbmn9B2UnEh8oa5f1g1v6p3DLhEH8SVzMbhC5Gs+fTfKyELTeYwVwZPCjjl
         jPSXetjPqQYQOuPvzQsk0KyuA++u2bNlr5pee1UQHQH1aIXdqId1LFX1pY9P/dg0e3L0
         aBBjA6wFF3NOPnmUx3d8PoHugujtju7/3pL0j6Z4ZiO4xR60k6FdjHfE3etuNPQov2Aj
         ffsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875433; x=1793480233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IV1NP8FklaqMSKF4K9LgBOKBFJvutUzvKwE1feKuMJk=;
        b=XZLSM03DcdU2k55fbLCj5M9U5t9DiSjIWYnHlWJ87uchyy/iOAO0P46mcce3erljMl
         1qen6ntly194QMTBubj/nfYca5tMpe/BWayje/SUEItFvSn0laO4gB/M2g83Fy2MhuUu
         0aSqKrWy0C4i9lg5PCJEIjC90MQcp4GntL0Me14dTa048zcZnRbsiqWDnx9wnT58JV3+
         Zw1OCbDOSa4ztq3W8eVAxBw6WTWp0err9/D4eCJKuLuP+44KWqGbXbzlnWz6jjdX8KZx
         FihDcT2hZUfIXxFMAYWy5DujIQ9k0+PY4OiM8oJleXE16JFVIFhUezCOFuTXQouIyoot
         IMow==
X-Forwarded-Encrypted: i=1; AKwUvByMdVWa3BtVElLNCJgl7xI/4iQF8lODa8/9JtWNjjYKbTdPaj7CdRp1JdSBgx93vGbsnxJDxTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7PmDmnsrY36xda11F/M3unPplAmOCIzn/FEO1qIqBh3/cwFBa
	diAi7m5IAWKx765ThmoKrk7BgnuqgC5h5qovW3+e6MguA1lPE9Y+pNs=
X-Gm-Gg: AYBFou0pukEaB9J31QTMr8GHsaFZmhWznIJ5mjBjq2ZsgzUHgxoiZ7giehOMWTL8Yz9
	U2Ez/5KMGPN209UoTp1yL0a/1RJXUzoyexQDMP5UNhBKWUG16HLoEKFx8PVZW701Dbz9WxVRUPi
	ojkUqItpiuuEtZr4AEJJ3fc7AO8GIkNus+AxctBSzvoF4WthwzG4CGL2d3GDzBgKgE6dNvTROpJ
	oMxgOS2h/UEeAUj472y4hBH2pk42DNh+5wvMRDl6Zu4JnuhoO+/M9PbBtbvys2bgsdZbowtVprZ
	ueCojasKsubuLnBHsWxzhCHfIYCjUGaMIOIMFoxO97ByM3+Odc+8hJJWagQtwl+x6+kGCpK6oBO
	enZayQ7DKCyhO2OvDLwp00AyU4OQ4Nc2pbjOCSMksqQRiMdN8D5xuSovCW9erkIh+zKyNXfNv7X
	DdI3XPJDlzZ/OblzAW0ckPZL/BtI3JrCo9rl5KV9ZbAV1CSVH2qT6MEWjZRe9o9puHhMjJcbhCa
	XN21GqgrLpJCmp7le9w1T9T
X-Received: by 2002:a05:600c:4f89:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4a35ac9d018mr45023005e9.15.1792875432943;
        Sat, 24 Oct 2026 13:57:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35b4a8bc1sm33788405e9.4.2026.10.24.13.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:57:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] media: v4l2-mem2mem: cancel job_work in v4l2_m2m_release
Date: Sat, 24 Oct 2026 20:57:11 +0000
Message-ID: <20261024205711.4041369-1-tristmd@gmail.com>
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

v4l2_m2m_release() frees the m2m_dev struct without cancelling
m2m_dev->job_work.  If a device operation schedules work via
v4l2_m2m_try_schedule() and the driver tears down the m2m context
concurrently, the work fires on freed memory.

Add cancel_work_sync() before the kfree in v4l2_m2m_release().

Fixes: 7f98639def42 ("V4L/DVB: add memory-to-memory device helper framework for videobuf")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index a65cbb124cfe0..311e2e08d066d 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1207,6 +1207,7 @@ EXPORT_SYMBOL_GPL(v4l2_m2m_init);
 
 void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
 {
+	cancel_work_sync(&m2m_dev->job_work);
 	kfree(m2m_dev);
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_release);
-- 
2.47.3

