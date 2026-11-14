Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644429;
	b=YVXWI30n8vreZ0xVUcaKdJeKZotocucYTNq1r8NFJQ9LI7xk5bU4HmL1Yocqvamw0ZXk
	 tjs4kFo7Oml5jhhJWTPmjnNgxrEXAB2EU/lQXAW7uWjiSmTAexWnKu4ma7D85ZGav6TqJ
	 MGkxngcXDUMWi2dvZJIf1XPJAw6YcjgYmKSbPcrzsK4uOIPrzH/jbGMyww0Ph+4Hdy15o
	 IWPeMfrRtW2680mWbJK0HP6kx43Xr1yV0NnzalZf7CUhQ5qt2sU082PQpt/ELb2Tnvnuk
	 qPbIOCAB6RFlrwRx1I6bWwg0HhLBjuM/caMmlA2De/bImSvYm5u/9p8/pZaE4ezJYVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SqXDyJrLwFkhi21RssicBQAdX6l60Qls8EPKvWmfnzg=;
	b=TvPOltMe2ivttdZWxjRmlWOCxBtMPkiRlQ1al4ppLMQGwhOPxT3bYjAMM5CY3OZVSsAN
	 8WLh1kCoAHzW4mvesIpPyJC7d+Pq3V2NR3uPB4dW2qrzyn2f7Gu2dcrVnyDEpAXYKnfT7
	 C4x8W457lvcDjb/yWaH7GiAo8fJH5jNZG8G6aKZueGQLNqQihMSA5hdD0a9k5n06SBhpY
	 e9whJzTMoAx11ibch/7pcdlru9kjjtfPQtdFPdFmzlJfIbYNDABVseu907ZFe9tec2xOV
	 lvY1wuA9YnOIcEu4EfeRlkE6F7Kpmn4DprBBdQxfQnWzexS6AVWfpY0Q7twcW4glSxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhsHwDct;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B26606A884
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B26606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhsHwDct
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3af3aea85so11243c88.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644428; x=1795249228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqXDyJrLwFkhi21RssicBQAdX6l60Qls8EPKvWmfnzg=;
        b=OhsHwDctsui8SfgxQeO7fC8WUblvjJqKKTFnTnFN/lOQGbrYHXiyeStOqGpcLAtVIp
         JHrH8E4WSlE9gfn8QkSX4Zjxs96v+RW9duU6XIfVdwtK9wRv3r8bOGdBt4NkfQumncoA
         rwhUaUKbnDCyf0PpcJDJTgLxEutY777peD1wee66IwOYXxeBZphnmr2BZA7kU6kyEwZs
         2wLrxZIEuIEHNiyZG07gNALCAAG7hfHejeF4bc0o0FHEsKYMpA+G5XEZGNKySk7hjjFo
         wMKXAZcHk+6TnjZLPg+sUeiJKMTa6Au+TQ88/ajwDXu0dVP64yyPPqeFSWoSUnJNIu7X
         IkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644428; x=1795249228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqXDyJrLwFkhi21RssicBQAdX6l60Qls8EPKvWmfnzg=;
        b=DiUyg/oRQ7DskWSgUxoyYVYYdQBfDtzbASaJEu1hv+My2c3Ks52zya5nebvOJTH2qG
         dYmicY3SxHy1gBXomirJ+Ac56CqayiaJDKui+hhypZuua7B5xU+fGEMoRE4oGSG/vcQE
         /s7gaU7E9sLb0c9uLsNwi8qQxBucdaafQuks9MdbUlwtwlCQyX7e/Mcpu2w+zJSG4kgc
         1vgW6BhiiUjJEUZn2WwfW1sMoyoVWfbrCPx7laHkdk7+4pqI70YpfpTgMr5/qNZ1V9MI
         QfG3HMGVftOZi24pcu+e+9Wl7GgqkM0yiJWDOLQcpciZ/yZsCiKGIzUD5eTJ8jqES6ot
         Kbig==
X-Forwarded-Encrypted: i=1; AL+hErE9gxzZ+U51It9YDN6ujGkOBB7f3EHvHsVxRGlDL839dJjUPgU8KXKR5dT1fuL/exK7TMdePh8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mF00m8+YHOEkRiQZiV4IlLs0469DWIHFJjPDprJnnxExZdCd0
	7ScNuFKcdKRoSBRY3PBeZ8jWbTRvRiA6/y/01xMG/9i7Yky2+AQRqq8w
X-Gm-Gg: AYBFou1hIFod8p2yVkiXA7/pXO4voLAIdxcJ6jjfbPIq8WK7nlURcnHq+w/SmGJTX18
	WjmbBYQZFVZ/DuLoomtIsgYYR6Bc5CzzJ4E1e0FEH44Q7/lGnGsUeYjrIbeT5NiFiF8rEV5eCfU
	aBbyKKAhUqyc3TDbik2+7S7NDewVSN45KRPreaPKxTZlFV0qThAVnM9G+CskC1xA8UJ04/VBsB6
	x465oezTpZROZJyJMYtxE+UqSwXqHw3DS1dCZnZIzSVD5xfGcoYIlNs0rTYvOPnfiFClPsbjmxS
	rsa/V2GS+5CvpQ3acp9hj+qZBrMdhIla4Zldrk47nkKoxINZ66KWx/ttSD23Nq8cAutVxRw1jb5
	uVtGQdGX5DwRguEjWMrlaj5kEsh6g2lgrW6DUW7PePR0w/4SMptLlKOKPzTD371994m6Lwn4G3k
	qmDs7bN8RmUZtdR42IwuOthfiCH42lcPh3CkJ3pFHPjhbzvins8nK3+Svf010mIoHnVqY3OjC+J
	imbvZKYGCaqbqlJRQ+VX80tXdO6LxcRGKI/EixOfAR0EBlKZNeFr1XsUnhFrMqLqnXsfw18ioow
	clw2p6KWPHVONYq3T0BaChQ6us1VEhzEpN+CmhhiFx3T7ah8TLAelDYAvUsPwFpVcgQr5sLQJeJ
	9SiY=
X-Received: by 2002:a05:701b:290a:b0:127:def:dd72 with SMTP id a92af1059eb24-1b5030f8a7dmr6472366c88.2.1794644428430;
        Sat, 14 Nov 2026 00:20:28 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:20:27 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm/panfrost: Hold a reference to the MMU context of a job
Date: Sat, 14 Nov 2026 17:20:13 +0900
Message-ID: <20261114082016.2454-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114082016.2454-1-arpe1618@gmail.com>
References: <20261114082016.2454-1-arpe1618@gmail.com>
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
panfrost_jm_close() does not wait for the job, and panfrost_postclose()
then drops the file's reference to the context, which frees it unless
BO mappings of other jobs still hold it. The job interrupt handling
that follows calls panfrost_mmu_as_put() on the freed job->mmu, and
panfrost_core_dump() also reads job->mmu if the job times out.

Take a reference to the MMU context when the job is created and drop
it when the job is cleaned up.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6e516faf0431 ("drm/panfrost: Job should reference MMU not file_priv")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
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
-- 
2.43.0

