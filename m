Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637609;
	b=2Ztvqqa4cil3g0QJfn3PZx0R8FoDLKaj4kUb6SAkwWoHOJ6kCJuRk4qtvSUH/K495/al
	 e5ACl1TlGviw3CjluNPF0wk9AVho4n2UBYT26zZUmK2IvWc62C2mx0AXY/GRr/S3jnQgb
	 HtcyT2sB3V0LlUn3VK9q7Ow8AiI7lcS/fIWDNcvJxHWpDZHY8IxRsstRagcAk0NcBwtXT
	 CTIWbOffZAwY0sx2lI8YfAyEh9enBm2aqV8ij0XZV7bhzq18RbqQnCZKMG1WnwhUboCjo
	 Nblev/w83FMfTCdCFgFyxt4RkSEjcRhymCxjYuJI7btYruE72wE8Rq2AsIJ8gh1xiVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/2KQ4epDEV2h9oQK2IfA2VbZzNQVtXN1l25yFvOTJmg=;
	b=fmQzyvldIvhZ570XHrRVVjjQyk6HMqLHuRbFBanWaVaaMvEF0mYz0fXJsHhIATV24E0e
	 bbNLspymm3c4vAukZsgn28LiPTFoO7QF1gay1beUGV+mGHUpt6bnpeDtN63/EVSxgNkhe
	 a0xA5YRf3a28CQrvA396iIkcHHbHTUgSxoT9jolel569MZQLBppDn0dUpXT9BGQzjanFR
	 1jePHdtMJZvR23H4yYRnNlxLu06SY9fmye2hTQMwBd0oIpaqNTfYDTOEtUpcpZAiPLW8E
	 +4TZisX2Mooy5vaPnPnz6Y05q4rIJwMhF6HnpM5BvtU14hpLBDICGVyg7JdGV3Cen1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQBK2BiX;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EDC606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22EDC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQBK2BiX
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-37605faade6so207477eec.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794637607; x=1795242407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2KQ4epDEV2h9oQK2IfA2VbZzNQVtXN1l25yFvOTJmg=;
        b=lQBK2BiXEUdAfkK6mwG0Xu/B4bQPBO7FS/DVFaxaz+4qFqHJNX3eOTur1M4Cp+6JKW
         I5hIZHXgabOzrNCevgLs6PN7xZW+PwqX5zKlixdKQcYR5+gaUZUa8AWN+rmwwNHzZu7E
         Xn4pV3oZmqnHpRjJGdUENznL5rNNAKNQxzTzPkbyNSAH26OBCIp56YHlEKpj8GRDmjMV
         NuZGAbPPmG9QqUmdB5PgkRpFv30kvgN3oHI6uSi5MseyAKmVX/0NZcOtnmfSpXRWLvDY
         6Mm66zCrGiQJmv7SEgdVJxqbqOLyqSjU6+kLlsoOVVz0HA5f0UKj3mXzLrg2IFutCJBw
         oEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794637607; x=1795242407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/2KQ4epDEV2h9oQK2IfA2VbZzNQVtXN1l25yFvOTJmg=;
        b=k5cyhTMGXWj8F57YOaPKTOW1T0xAIhfr0zCBOIn+qwbn9vxljlfkSixhO6TKR6qVod
         iMEa0EZ6jvkJpCCL7CLO80ZP1hyMj95O8aDrptkCmQavGyp4YalQjc4onxavmzjjtpJ8
         Nr72LxPe2J/ik22iCDB3u5llsWsv1ea7aF95lklVJoECM2WFFu4JQatoPYKkqRn/EDWh
         yfvppewMhvCfyqbZr2eb+6FZXn6kroKgfpfFiBeZ3ck/bps4z/0aFKkzVbP3mJYyNPya
         RElI0UFO7jOyC9F2kvOXebDmLeYImYnxPDyZDHg4sg/ByjUKAKiML7gqJc1Bi6AGkuD7
         Hvuw==
X-Forwarded-Encrypted: i=1; AL+hErECdvSea+ULKF0VkjvG1GnjqSuSI/vGMIXM7YuqNvHW3WppMJAEn4VpC27Qn4V3Pe3/cYJcvTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SxkfqMChUNfAU4iCnjA6SZcUGvIKEzURTDtl68Bzmq1UbHr8Z
	VOt4tl17Rd4HptMcfwh3oTVdaKsJenw+DB0XMS5Sa0mG9iAHuE1OsljF
X-Gm-Gg: AYBFou1cQtaK22UTfMDDDlXpVaZn84/XOQNOvE7xhKCn1IJfIBeYNIZ5WdZX3jThH1d
	cBi3Vm5+yFVqOnviwlybfprtPBS/cBJr6QXcLjcxGrlFtSVPk8NoFV2zDdtXc+WkFCGQXLDIlgZ
	j/bClmUsXisAiQTrdlTT8ogW4Uf9mCYP3I/bfu9liIu7+Q9Hre6JvQAGb9pkNSfI1LeztdqgVpJ
	hiuCrdweewwYwJZEt1go1j/oQ4AgZCLnZXU5A1TQiIF0POtToaGtEifm+Q0sIQLN1V3+Ina0kqU
	qX3gyvqRmqpx0BauOslvKHUHe45OrKGY+NCiZrQX38rkfgUs3nSHJKetDYEsm3kTCjz2aNgEst3
	NBQJpnrY82IflJ65mEBZtLuuhBYlByTvPyaJI7YhhEyIsvnjYWspRmhgEYL5AWsu7Ed4czx++mx
	243swlNNtnA4UNwWpxSd9J2Yl2ASQ946YTCX/pkLJkJ1BgilXuBuzsAuztMZsJ/tWzlvQFZvaKU
	t4AdRl0anxkmmAX6FXm7rRed/yRf9a2Hq+MIxmbNXZ3uuPnYF8wphVyS30E7h1gmLzcSGRtFAeu
	Jbgm9CovNDs4EKE7UB01TqCy0MqMq+g0CMBE5mh9nb838poMzaaeWEryc3Izmpo7yTP9Gx6KGix
	rX0M=
X-Received: by 2002:a05:693c:8204:b0:372:c0ee:875b with SMTP id 5a478bee46e88-3796057b529mr6474936eec.0.1794637607266;
        Fri, 13 Nov 2026 22:26:47 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955ffcbc9sm19762863eec.18.2026.11.13.22.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:26:45 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/panfrost: Hold a reference to the MMU context of a job
Date: Sat, 14 Nov 2026 15:26:36 +0900
Message-ID: <20261114062637.2447-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
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

A job stores the MMU context of its file in job->mmu without taking a
reference to it. Once the file is closed, the context is only kept
alive by the BO mappings that still reference it, and a job may be
submitted with no BOs at all.

When the file is closed while such a job is still running,
panfrost_jm_close() only hard-stops the job without waiting for it, and
panfrost_postclose() then drops the file's reference to the context,
which frees it unless BO mappings of other jobs still hold it. The job
interrupt handling that follows calls panfrost_mmu_as_put() on the
freed job->mmu, and panfrost_core_dump() also reads job->mmu if the job
times out.

Take a reference to the MMU context when the job is created and drop
it when the job is cleaned up.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6e516faf0431 ("drm/panfrost: Job should reference MMU not file_priv")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
1/2 and 2/2 fix separate lifetime problems and do not depend on each
other.

 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 7c348a0bf1ee..afda794e2aeb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -331,7 +331,7 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	job->jc = args->jc;
 	job->requirements = args->requirements;
 	job->flush_id = panfrost_gpu_get_latest_flush_id(pfdev);
-	job->mmu = file_priv->mmu;
+	job->mmu = panfrost_mmu_ctx_get(file_priv->mmu);
 	job->ctx = panfrost_jm_ctx_get(jm_ctx);
 	job->engine_usage = &file_priv->engine_usage;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 4ddf4b722ddf..7022b1b2e020 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -377,6 +377,7 @@ static void panfrost_job_cleanup(struct kref *ref)
 		kvfree(job->bos);
 	}
 
+	panfrost_mmu_ctx_put(job->mmu);
 	panfrost_jm_ctx_put(job->ctx);
 	kfree(job);
 }

base-commit: d48ea86919434695da12d280dccab72b094397e1
-- 
2.43.0

