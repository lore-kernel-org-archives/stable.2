Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756574;
	b=tOLDbnJjV/kKm3OqyEhnI8uZ3r54JpLEjqnKgjSzKIBqcRcfU5zkMP9xXzF7Hr8zREn2
	 ziAAoMBk4iG9lUUyuemf2GSGvykrZh3PqccPRXSwnU2YB/7qyVw4v2vnVlEKVVEHsPjdQ
	 HEKv2U/KUrRqrn9ixVEvs3n5f5c6garFQTzGJnOl7lEDV7m1Q0Vfv4FTuVh8YSK8dN4mO
	 sHuIDBhm4hOzGkbXHu41gMnwQIznjR3DM51XzEzqKoZNEO1qncZJ9EEgYeVonNJEJpLSq
	 2COcDiqdI6o8XlPt/WBu601OyW9S8mSa8d0x0INjEZguKWgjCUesGkPmrdxZ5G/o23g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=04qjylQiRjUxab0wFGioKpg+XzQ+3wNYfPCFHSRebIg=;
	b=DZ43uMA/MY3caEvm7aPiXWXTCv3eVkDKe5Gq+12+BvR93q3weRleQwOvllDsoL3xxgib
	 2BCk8NMEwuJscS+NWw+EvM++6jbQEv0SCom1ALjMStpUzYcBIKY32RSPWPlk8rp9R6py3
	 9/mOfAOeXMSdz0n8dcY4DVUr8A/VAahQhB87x5cv33attvJWlJgI0Bwx/LNnNWRyc8Git
	 Smesfzojwj/W0HCN+IZTsFtBy9yiIEZRsTiicgBfEc8WIMVBUtnppnZpHP+wtrn7ldlrY
	 7Xlwbrse6XbE6p3ZFUG3JO2YtYgzD1c3gMqwvQa0nDhkVFGy9bsqhRudYHg9ZslIBuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnZ5cWJ+;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3115606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3115606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnZ5cWJ+
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so8047485e9.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793756572; x=1794361372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=04qjylQiRjUxab0wFGioKpg+XzQ+3wNYfPCFHSRebIg=;
        b=ZnZ5cWJ+ytnymUUDiWLTVDB8LUTx11Pe67lDgEa6UTMikuPe68RtvMTSngvvG/kQTZ
         zDW+WxILFmp5F9KDBr8bZ75Du8TzTPUcpFIzuzO1RlOJ4dCf1JMNDKjZXKeuCni92DH8
         LV2A8/2ZiAOjNVuhXVEhHVa75+tQ4F/OWopgV+krqItDpK5BawAZn5fHh8JXk7wgQZGC
         eUqFXjsoN77aU5Y6b6d/3e68Dyj3/lYlCdkhISVvTHfvZz5OaaEkExil5VEyLaShdqGu
         GC+wwPZbki+kaZLg3qz1MoSCl8tEssvKKP92k7ba8KFQhfKls9TS1+HIul+I1aSQ7plR
         YOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793756572; x=1794361372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04qjylQiRjUxab0wFGioKpg+XzQ+3wNYfPCFHSRebIg=;
        b=mXxwBPhVRPo4NbUZljbacJfonA7JCxpMAhGqmQtPc16r0qNJZe01hJ3MLy+eHXGZk5
         3lLWooskxyscMHI/snpzNlYi7aiUyJUUDtPt2oscqERDzWT61mZOqZncE/neYY0Zgesx
         T8YNCwS0U2sWTfVU0tB/TTPa66xvEdZ7CHVWOTbAr8b3XEU2JmA0vuM9wqtST25CrK0B
         gdVU4aFk+dsc/qxKekdlhfwlBJLD6mg5PB0Da6nH2oX44KBcV+hZz68/T9Qo2V2y4VT1
         S27Js6mk/5/LB1Kh+VlHftw5uKL82+sHbG+jewG+zOHfyBed0XAV2xDmJqTR9AvUIM8d
         ODRg==
X-Forwarded-Encrypted: i=1; AKwUvBzVkGt+1MSKwVgqkg5jVvfgXutIMpdFrgAm2Xj46jgAtIHrcVXbl+nWedgrg7SENs+J/Kd3138=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qj8J4UuMXnG9NN3RHYSWyXDhPLUNLSqrdPZ6F4o07L5lXFjBy
	socyMZ7bo0Op667lx3Y3X5nzumKhSfkdvKJy1KJF/R6pEBzoBO9tbSA=
X-Gm-Gg: AYBFou3ggx3HXzqCNU+Bdcy8sQnY2ndXeMbx6fw34jbBkCUSi3DVSNjDfIoRp1VlDm+
	WkXoE7hXcje1VjGSmQ1yRMM5KT6D+dfoJl/ttEpMlSCvlLdyhsN8d4dcqQhvXmX/GcVVLPzW5ik
	sxet06PU8IxkVq96NxKOqA5wCAyhDz1NmCCVTMnjmbxuvO+TOFqECdFApPloJX4n6ZB4NWRpz2X
	KruVrf7uQQXZxz3N0PwSxThnbEGeh1cLlyB7EisGIHviw35qTE/0KVwc85WimquD6q8DVMc8VLe
	7zvH3U9UQuRBofe0jPkkspHUUGTR97MWeiocpqKcWzL936G0UtcfUI+mtVZ7f6kWbrAYQ7OiC52
	h9aiHqVdxuFBMVnK9lMr7Z6CIn8/XpVSPmMAEalegP9I0g4H7JP/cY+gnsrQCzfoWmsEYhxR3/u
	Ac8RxWEZaTCBz30GFNqMAb0LzZBgZ/NyJfb67zmTZ8TOlXg2fZ067Y4u2y42AXOo3JU6glzRQmf
	dCjX9of0SoWzTLAq7kAvZra5LOYC0r7s7zGEV/EovjoMPbuG8JyNFxHWBWXzUYw5VdOmvYjEplD
	cGM1kYuInu0=
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4ac169d7e39mr333856735e9.5.1793756572002;
        Tue, 03 Nov 2026 17:42:52 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feeb5196esm885532f8f.58.2026.11.03.17.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:42:50 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 media] media: v4l2-mem2mem: cancel job_work in v4l2_m2m_release
Date: Wed,  4 Nov 2026 01:42:48 +0000
Message-ID: <20261104014248.3761373-1-tristan@talencesecurity.com>
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

v4l2_m2m_release() frees the m2m_dev struct without cancelling
m2m_dev->job_work.  When a job finishes, v4l2_m2m_schedule_next_job()
calls schedule_work() to queue the next run.  If the driver tears down
concurrently, v4l2_m2m_ctx_release() invokes v4l2_m2m_cancel_job() which
handles per-context state (TRANS_RUNNING, TRANS_QUEUED) but does not
drain the device-level job_work.  A pending work item can then fire after
kfree and access freed memory.

Add cancel_work_sync() before the kfree in v4l2_m2m_release() to ensure
the work item is drained.

Fixes: 7f98639def42 ("V4L/DVB: add memory-to-memory device helper framework for videobuf")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Expanded commit message to clarify that cancel_work_sync() complements
  the per-context v4l2_m2m_cancel_job(), which handles TRANS_RUNNING and
  TRANS_QUEUED flags but does not drain the device-level work item
  (Nicolas Dufresne)

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

