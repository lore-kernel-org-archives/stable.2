Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644367;
	b=27HhqBSy8q106Tk2kPptX3Z0aN4i+OMzVtNvem7VNG7lhnrVdr2g3NWNGcQ4CJL/OQKu
	 h/FUdN2ITmsiLcgJ9PVDhzZwjI/XnnUfomASLEDkj7w9Key6t7Hgc3XeRXRlPRwlwkZda
	 zWMDP6KGBhZFBWfOOGu9L38NyL5I4i6roolHBd5Od/WsLszZNJuLisRrltdUAkholLz1V
	 r5E9t5At8Zvs6HKmmCHXp1RfxYx4Ucv9Ku9QsdBU8Y/r5t7aNOHadPGO1bjKAfAAtsN2/
	 +S2cjAC/qPldJIFFG4zqOnoZanr07kX0Wsuw/DlhBFEyW7pMGKPXuHK/3K/O+676dhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=C58R8Pgzd1hKqtVMoaWOgYvgQVTOllRn5nwLnk9mw7k=;
	b=TKV02CS6MhBJgI3Yd7QWbpKMk/pq0zpJOv3/nBesqGVs+AsBNRZy6u6qqe6pr+gXOFGi
	 ePuXmKLeS8gk1WqUZPvMYP707p8D2iINVjXlugxgkYEzuNE8whATAE1G/U8GkXPKUFM39
	 DIzYdpEVXMTtu/88MB1JyGWZkIHAOOYSc90jatgFD5yBfQBxHH7/4usnNbTVgE52Q48pz
	 1ljri1L9MQ5zsuftI6UpuvCctaCSenyX6AfOzB+MlmGJ0JPT0RZMzGlnuYPCxUGZxM34R
	 QKk3RIZyhingAHGB2AGeWVEmFar6y6RUWtILRehK79pAqovLbrhkLp+XG/Z1sdyiCqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXb5T5gB;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC171606A883
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC171606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXb5T5gB
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bb5afa736so186633eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644366; x=1795249166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C58R8Pgzd1hKqtVMoaWOgYvgQVTOllRn5nwLnk9mw7k=;
        b=EXb5T5gB5jjsfWt7HDzjvl+XqaWGVUS/bSslZmlUqzZyaggFpVpgJscso1Oqqn79Ps
         bwz+OV1KpZiN6nFUhZsB9fe0drNScYB3Ct5lR1azIJsovPl/tLFRo7eSJUw0k1D+dPeK
         FnhwIkm0vN6qd4U2BFLu8W0siU4GWLKsix7UIlUYf+J5GXKxhS5XfHXMjB+ETofnBIaX
         0mdxDtqq5peMFIDeMqNKhOBgItgcX9aTXyOhieIkIK1IPWrUY0ySje0h2R+meEJIWWlq
         pmwrtsBLanmQ3S1qFyARuhDlFcvWq9REY5mvfwWBQPt4YOkSqVh1s2dp8MZekKjezYg5
         RjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644366; x=1795249166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C58R8Pgzd1hKqtVMoaWOgYvgQVTOllRn5nwLnk9mw7k=;
        b=P4npeWwZ+bdIQG4Zk84HbrhFJR1IoMXrQnfkr4H3pE2cvuPT4kBjtthBC2uaCVfPe0
         P6CQhbiMk7NB6DfB4floiKfpYKGAejAdIHZYjImEVftp2rfg3z/f30UFh6PYeR54qb0f
         t3zrSuroEWEAnELfmOjz2wBR4rV2RIkw4NPm7AFYajMt82FmLSdwLkqVQPXoHmWOtApy
         p6mXaCSt4UUZoQdIYJ5YN3tZ1s64S4bPcjxZHt+CzgnRwis7QR+v5P/EuE+O/gzFs9Du
         dDsNLbMKDgF3vNlFb1qpNa9N6eh1BHP/vze5AzE0mbNgfY0/0FQwDs+elCA4QWG5upyU
         LL2w==
X-Forwarded-Encrypted: i=1; AL+hErFM7nV43x9tSL7kJ1cUNieoW7IANza+bQZkTVucrooj1vMqzkhBO7nnf+EzZJWxAY1VXzR/s9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cWefS6etbzK3wEutE1/CWYboaO++FaNbOlwSHM/OWI1oLax2X
	SrQtkhevJGvelndZan0shOvSJpyo79A6073157kydExQylEH20p9NMDt
X-Gm-Gg: AYBFou1JSVvr0VH3oQjcmI7qEJY2sINXON2FbTy/N9lQqadiVXEDAGJ3VooeIs5JHqo
	wDrmzJ+nMlquA71ZpYKzuzazM/zTd5alrzmiLr11Gngi50p6m5iQFrPrtxtKhxd/bcNmRAoeTVf
	ZQwuEzrmPOjVxDA1yQXvW+GtVrHBkdStBi2uwcRCQtb6EmFEmzqnDUevdPhjzxW0+Q1wRC+yaaP
	XcjWVfFOEXi9hQrTV0a/YyrMwRt/9bupNH8lNKNqfdGxyoVjg557Z/EGDuVI+xn8m2hYjOASx55
	CvTMF7K4TEyAQk4eno1fzgH6eksHKnJf97Zhrr2MonZn83SYExdtQW7uNcH2qXFIbq0At1K9C72
	mHQLRtalzntcafToY1SM7M4UJSbW5HN6QcgF+Q2u5UWtLftFpYtn7V9rggGZA+Wa2tLULJqqzcj
	XrAJkCCDwps2lk3Ke/N+M2iG+fQBe9pk8rKiwPjgGC7Ql/RS+RYUki219nkSEj4guTc2wSlJ2lS
	/tbccdPBdss7LFHxbPPCX4Gdy6ZGAFmASDJH2G9qyYuSirEGg6c8sCd4KuSfAXiWKIpYiDU8lET
	5qyvaxooXvMX717+De2a5iT412JmLb7UqRC9YRailr4ucsTAXsCVnXSRkJEsPn20oRP5YMruqjh
	NcYlLre9PlSanhdlmo1onGNNg
X-Received: by 2002:a05:693c:881a:20b0:36e:66d8:1424 with SMTP id 5a478bee46e88-3796047ff23mr7029007eec.0.1794644366120;
        Sat, 14 Nov 2026 00:19:26 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm14008333eec.3.2026.11.14.00.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:19:25 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Antonino Maniscalco <antomani103@gmail.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] drm/msm: Put the VM_BIND queue last in msm_vma_job_free()
Date: Sat, 14 Nov 2026 17:19:02 +0900
Message-ID: <20261114081902.1669-4-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114081902.1669-1-arpe1618@gmail.com>
References: <20261114081902.1669-1-arpe1618@gmail.com>
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

msm_vma_job_free() puts the job's submitqueue and then wakes up
vm->prealloc_throttle.wait. The job does not hold a reference to the
VM of its own: the VM is kept alive by the context, which the queue
holds a reference to. When the job holds the last reference to the
queue, as it can once the file has been closed, for example when a
cancelled job is freed, the put can drop the last reference to the VM,
and the wakeup then uses a VM that msm_gem_vm_free() has released.

Since commit 01c8d1f385f7 ("drm/msm: RCU-free the scheduler-containing
ring and VM objects"), msm_gem_vm_free() frees the VM with kfree_rcu(),
but msm_vma_job_free() is not in an RCU read-side critical section, so
a grace period can still end before the wakeup, e.g. if the task is
preempted in between. Before that commit, the VM was freed right away.

Put the queue only after the last use of the VM.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: b74fae5492d1 ("drm/msm: Add VM_BIND throttling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index b1fa1d749c2f..1bffade78623 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -816,11 +816,16 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
 	wake_up(&vm->prealloc_throttle.wait);
 
+	/*
+	 * The queue may hold the last reference to the context, and so to the
+	 * VM, so put it only once we are done with the VM.
+	 */
+	msm_submitqueue_put(job->queue);
+
 	kfree(job);
 }
 
-- 
2.43.0

