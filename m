Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009153;
	b=Q+oSBDIQTdwjXj9Mh7lMkuluJ1zzGfy1jvnyozLqxtxRuK2VhmGVgUclEv3etleLQbF9
	 dNwkqcLrYR9fUyn/g4dzWAcK0Z4u8qgnS/5rbWSxljGkQCgcwmYK/PgrZdQX/O+Hfo6YD
	 AhjOu5rraWLI3C4+rUiq1PQIzuVTZTwAEMg/pI2TLV0R9TqbklNtnvdGJ4AFSFDx6/ztw
	 4FEfRTgE42GCaHPRrPMpElfsGucuXrBLT1rJI8Kcys5FkkB+K7A/e/2bNhURTaK2BV0ez
	 njOi7sVtlii8ne18ZZD/idIq8qChuolgL91P6jgYXxEaiUzUCYgY8Ff8LTgtgpRmStQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gm/vkZ/TPKkcuQ8IJYMQfAw8BN32mGEm+OiB1P+AHxg=;
	b=PZGpvf6lB9xTzagSMS/PY3GaOj+zsRfFt/jeraGEMw+NHt4p5tM0I0Wn+4T5jCYqJ8ik
	 cxxnYLcVggE3gFRF+EbFROtUJzdqH0Xb7IpJO82hJZjktCOq8bRvBdDhV/OgRQeunlM5W
	 T6UhydN5qmKcXtqeeiW9E8UWY9ws9ckHKkVEdF5zo44vgeblKVi7qRyaoFon+Me+vDeR/
	 54Uy6ibs/Csy9Cpx9tgRrS+alpKmYBaWZzOa5n6Q4WzsxLws66tdRPrXpPQ6sKFIAE3y1
	 1tFA4kB+vK10Lct/uqE7CDFKxKMjStvq2uzLWxtz+UTFZo03Eh9l5ubB4sn3ufsv0vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oGltNea8;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F47606A324
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F47606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oGltNea8
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ccca948203aso768284a12.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009152; x=1793613952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gm/vkZ/TPKkcuQ8IJYMQfAw8BN32mGEm+OiB1P+AHxg=;
        b=oGltNea8Icpks0AKShXXj02HZ9E927nFFfMwJpBRbJKt458wbXwSFBWWA3+ghZw51E
         vAqvMNSIm+aJR5miw5r+rD46K2/d/dLNahVUsw5BatL/CY6yKy/VK3/v7lvIwdYP6Ncv
         2HT6AupXt9ynFYBu9eLulOEkm+OgX1tOE3r2peQ4oxqubYTuOFjWpxRbcTe44ySoxVsq
         Dwa7R+baX9Qj2Gz4dQnI4dqy/BQ392ZtfmWA5pGM61MCheekfpKiVQ4VG4rdGApp3+xr
         1uJESliw7mMLBpst5JWXhkqgGWWWl6wZVtxYFgUGC5oYVY7oMOEffn8aEX/I8WlA+F7W
         /vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009152; x=1793613952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gm/vkZ/TPKkcuQ8IJYMQfAw8BN32mGEm+OiB1P+AHxg=;
        b=HltIHjyyzy2GsPvFlYO1fYlHVeFBZKjSk7My5brwysoV6zIwMJyXOVMvk3vsx7ZJ+7
         jXc6gTKNIbf+oj94L6Vf/wiGqoCCjSU3ikgNSgaGEhVhT/UMohaBhaH81nL0DzgYXKkm
         bzuOpj6lYISeBq7vWfvIqHFtPg8eOjjjUMKJsug+gSFPs7Z+/CfdER/ea2R/lUF+XGLh
         8fmlW+CP7bvt2Jiz8vMvgKNSi5Qn51qx9jESETmqMNb4BRru41hFokv0HpfdC+PECldJ
         KjxffYY5XrHcjYDhW63PNJfZ992oV407/yp9EjXsRtpDHcBJEY8KVmmJt6u8ovoXiNW7
         SQ8w==
X-Forwarded-Encrypted: i=1; AKwUvBxR9f3Q6AT2/6EZ9x6YuNExr/7xVUqkrLAKrHbc+SSoxlq6OWE+0L+E0aCoB0JtyMfJWJ893Ag=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUdJjS2FW5JaPePdUfXncjiBffSS5zeKVhkoXKsc/ieWMUIrbm
	fOfhQBuXkZPZQeLuVEbD4rnLx5LcwHZx0luINiCRaaRq1VByVjBRl1wO
X-Gm-Gg: AYBFou3thfZw957mwciiO/sUdRe4F7XemcFpKBzqzURn3IDuvVx/blDLMMu67YhZENN
	nz2byNNPM8oOTR+eTYB4JuLH8b8p+s8xjpmcMcbwmWNvyAsCrMJjY3OLjufmwHGOtzx0ujXN8PX
	4GvYWS0EURb93t9KlW5yV9nhKZYmXozPWX1uMgU2qfT3is8Epnm0rRnWcHd3gcYO+QA/haqrsE5
	G77HX4yl/P8o9qXA42yTYSRPEa4EUVFq/CaxRLf1Y4k55fZqS7NOZeJUAFNYjQdANXpf4jaEvmE
	s/STH6eVKkrVlRSzC2oWpjauLo0/G/rCPG0rXQg4R10NKC55NBTa39rlETxvEVp9hW4dP/2L8xg
	spM/JfDZGmhohbsF585m5iQhpPCyF/1aUCYCRtTYvwUpwnp5g+IQXGhypvz3ol/YtHZ8/hEun8o
	aXaJCq+VJNffIpuZEU/Xg+f1uLBOfR0LsVH+YdwrWtjc60Ixy2yMha4KU1KFESkoSslfK5oBYGr
	kobPyi41nYmyAIALJP9eInxOtYh9DU5X7UFRr+hyTOLd/CCfPIWLWASpnMns5CgyFSn6oXYGjNU
	cKuH1/yjz5/uNYYqc17MKT3TkAUzNPV8FwkbkuJiuXLQpt6ewFrPDVdaGu+06dh+PTMq3aD4g2N
	pVuKieRqTaPM17o/EQhCapa+MAWhg
X-Received: by 2002:a17:90b:224b:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3adeafd6bc7mr4882037a91.53.1793009152103;
        Mon, 26 Oct 2026 03:05:52 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb83b35esm4837686a91.0.2026.10.26.03.05.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 03:05:51 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked
Date: Mon, 26 Oct 2026 20:05:35 +1000
Message-ID: <20261026100535.68114-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

extts_fifo_show() walks ptp->tsevqs with list_count_nodes() and then
list_first_entry() without holding ptp->tsevqs_lock, the spinlock that
"protects tsevqs from concurrent access". Every other accessor of the
list honours it: ptp_open() (list_add_tail), ptp_release() (list_del
followed by kfree of the per-fd queue), ptp_clock_release() and
ptp_clock_event() all take tsevqs_lock. extts_fifo_show() is the only
one that does not.

A per-fd timestamp queue is appended to tsevqs on open("/dev/ptpN") and
removed and freed on close(), both under tsevqs_lock:

	scoped_guard(spinlock_irq, &ptp->tsevqs_lock)
		list_del(&queue->qlist);
	bitmap_free(queue->mask);
	kfree(queue);

So a read of /sys/class/ptp/ptpN/fifo running concurrently with a
close() of a /dev/ptpN fd can have list_count_nodes() walk into the
queue that close() is removing and freeing, dereferencing freed memory
(use-after-free) or a poisoned list pointer.

Take tsevqs_lock around the list walk. The fifo only ever draws from the
first queue, which is the registration-time queue created in
ptp_clock_register() and freed only in ptp_clock_release(); that cannot
run while the sysfs attribute is being read, so the dequeue from
queue->buf under queue->lock may stay outside tsevqs_lock and the lock
order is unchanged.

Fixes: d26ab5a35ad9 ("ptp: Replace timestamp event queue with linked list")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/ptp/ptp_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index dc398c6..7d09256 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -80,13 +80,17 @@ static ssize_t extts_fifo_show(struct device *dev,
 	size_t qcnt;
 	int cnt = 0;
 
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 	cnt = list_count_nodes(&ptp->tsevqs);
-	if (cnt <= 0)
+	if (cnt <= 0) {
+		spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 		goto out;
+	}
 
 	/* The sysfs fifo will always draw from the fist queue */
 	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
 				 qlist);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 
 	memset(&event, 0, sizeof(event));
 	spin_lock_irqsave(&queue->lock, flags);
-- 
2.43.0

