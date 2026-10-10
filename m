Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098A39A4B3
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601364; cv=none; b=k2AaGzcNpJBcWRp/RkIwGZclNBMQMOlRzuQzGCA+gFgUKK+bd+BgU2j8BIchjZzgpno2hIUYPs1omI5QOd1fuYbl4RRRmpsMGwAKdhQ7ueKlL1107yVLGq9wyJR5yPwh2m1Fy1diWmdXkoPOOnln6tnd7+YzWBaPubu1hnB+uC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601364; c=relaxed/simple;
	bh=Q7jW3EZgSwOtIAquZK+b6aU5SZAJC0EAk10qrVLJUXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNzYGvJuPR6Z8D1INULaK1uUDrcQwiFPTpqCCERo8lw+UiAY+FUrCw20muizwVlHAWoTeiidJZfD6Aa7gez1HEjTlAjy1ZNxtV5oxZmqekm6nkMBnEHBaHu+6lbJqjTAJG8NCZsF0dzVoBuTWG1Zn9zf6ILGFktufJRWMTRCqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GscS1J0v; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GscS1J0v"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-826f42e479dso247202a34.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791601361; x=1792206161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CYILw19ZFp1ITRTCjnSJ7SyTvlCLRVtxvPc/6sA5wsc=;
        b=GscS1J0vKF2xYqSa/Zei6578hb7CB8npM99Byeu1nuWt0J8HYGFB/iXwmCFEXjXAk6
         abk6L4ZhsbIo0m+L/0QvWEe23qlqL7f4c240Dt32oVwvOmCKxP/yaPbVCnIuKxBiPdpD
         lq1lbE+jiqr5ej9OUka/eHeqROFjvDmXLrzA1jDCJZ3bVCyYUIlV0LBcEobr1YIblN8A
         QzHWXERhO/WmxxDpZ/xsY7T++yrurZvZNS3F+2tujlzI08yAeSZPXKGqpIo3GLy0FTrc
         hRbmqb32a1VqcKWXxafOkzuxl/1D6u8v59IcUScVr4xwO63Z9d2/AUXSXQ26rfXJme9B
         81jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791601361; x=1792206161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CYILw19ZFp1ITRTCjnSJ7SyTvlCLRVtxvPc/6sA5wsc=;
        b=BFukJP7WcDICQIOW5ncuPSVh77U5XTWbM6Qr5pIgOKBMICeA924YHjzST9u7d00v87
         KOzZyDAga+TPIpIsNp9NWGMAzNqO0MZ1oKtlnOHcWMKmYwrY+eUHnvTeREVqdhmQYNt/
         fApJ9uAA1BI4kxs0nZ/EWHnZgY2KLaQXU45RRMi9e1YkVY39w8vWdGF924Rwl1NENYt6
         1KchS4P66RLPL/qiIKyTmmW+3hwmYVzYKwWwyhmCfOe3EUX8GBokC4CVdyOOsIxRdqi+
         +ziZeAwWBRmw1zxaH/TJAWjUir7drOaWYN6heGDOiOLA2gJa0BueIl7ylW76GYSCTLpX
         G3hw==
X-Forwarded-Encrypted: i=1; AKwUvBwu5zDvBV+VoyZ5gdJkK9witDsbJXGcyp9q93i7+2v50tDvuy4sxfZkRSf0TLXDeIKNhEPyZF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxIhIvEFjvYVFgBhoIhhcpKuS+KDP79zxdnadgKH2R8XPjHUTF
	Dg6+84TrtFM80qS8VYp+x+CZG0HrR6X6kmnk+w359Uvc2sgeYh5Pb7QH
X-Gm-Gg: AYBFou1dRyWMDpFNAo8s+ofMfjAS2+I9N3yaNgKLTXsj0LsaGhk0wmg7p+AhzaZkgx7
	tMWqyiKzhIvIK0Md9f9hNBHw05uqg4omuHCyyQYd0zioRqu3Ce/peMo9KYoQt3Pa6dr9OBrilKt
	Ds7ygHTX4sz9mthWauJjs319vWFStW/f6yiZGuFzVMySMU0QfBZoNP2SfnaROc1nuSsA6R/OoBv
	l9AVnoGWwxddAYVCR1ILXimbbSPP4CrmwbDgbOprOcX+3kMNiG8n1SZSnwUd/3Ul4lHerlm+2Fm
	RJdww2vM6xp0HiwIODbzakzSLNhFlT35+QDcj7I5WK4ucXNhjgD1+Jl/OxNsKbMA1im59D0V6gQ
	Axapf6DEHNv+X7mPNTVFga9JYhx34BBpVw7/BEBBwEg3SJlEMyVYRI+ouw5umjhiwhS5Gkg7slI
	A/sg9urtYAzR+q5X0v+c4k4ZXdSKWdQWgIqsVYZRdVa45hmteF6LmXCRZ7bGywJHaIt5rjXfu8B
	tsjObhmgo+YY0Zg1/4G53HhWKK60p3LWZmpQcI=
X-Received: by 2002:a05:6820:f011:b0:6d9:7de7:e48c with SMTP id 006d021491bc7-6ef0f1b6214mr2982823eaf.51.1791601361586;
        Fri, 09 Oct 2026 20:02:41 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076d72sm3562310a34.12.2026.10.09.20.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:02:40 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] amdkfd: fix doorbell allocation race creating duplicate allocations
Date: Sat, 10 Oct 2026 11:02:30 +0800
Message-ID: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
References: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check-and-allocate sequence on pdd->qpd.proc_doorbells is
lockless at every call site of kfd_alloc_process_doorbells():
kfd_get_process_doorbells() (mmap of /dev/kfd),
kfd_ioctl_create_queue() and the CRIU restore path each test the
pointer under different locking (or none), so two racing threads can
both observe NULL and each allocate a doorbell BO and bitmap,
orphaning one allocation and handing the two mappings different
backing pages.

Move the serialization into kfd_alloc_process_doorbells() itself,
using a new per-process-device mutex so all three call sites are
covered regardless of their own locking.  The device-global
kfd->doorbell_mutex is not suitable here: it is acquired under
dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
the sleeping allocations above would create a lock-ordering
inversion with dqm->lock via TTM eviction, and it would also
serialize doorbell setup of unrelated processes behind a
device-wide lock for per-process state.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 2105a15a2046 ("drm/amdgpu: use doorbell mgr for kfd process doorbells")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v2: Use a per-process-device mutex instead of kfd->doorbell_mutex
    (avoids the dqm->lock ordering inversion and the device-wide
    serialization) and correct the Fixes tag.  Pointed out by Felix
    Kuehling.

 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index fdcf7f2d1b5b4..55acadc986bee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 	int r;
 	struct qcm_process_device *qpd = &pdd->qpd;
 
+	mutex_lock(&pdd->doorbell_mutex);
+
+	/* Another thread may have won the check-and-allocate race */
+	if (qpd->proc_doorbells) {
+		mutex_unlock(&pdd->doorbell_mutex);
+		return 0;
+	}
+
 	/* Allocate bitmap for dynamic doorbell allocation */
 	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
 					     GFP_KERNEL);
 	if (!qpd->doorbell_bitmap) {
 		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto unlock;
 	}
 
 	r = init_doorbell_bitmap(&pdd->qpd, kfd);
@@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 		DRM_ERROR("Failed to allocate process doorbells\n");
 		goto err;
 	}
+
+	mutex_unlock(&pdd->doorbell_mutex);
 	return 0;
 
 err:
 	bitmap_free(qpd->doorbell_bitmap);
 	qpd->doorbell_bitmap = NULL;
+unlock:
+	mutex_unlock(&pdd->doorbell_mutex);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb9..96e59133fee02 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -779,6 +779,9 @@ struct kfd_process_device {
 	/* per-process-per device QCM data structure */
 	struct qcm_process_device qpd;
 
+	/* Serializes process doorbell allocation for this device */
+	struct mutex doorbell_mutex;
+
 	/*Apertures*/
 	uint64_t lds_base;
 	uint64_t lds_limit;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da959..4efe4dae79c13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1788,6 +1788,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->dev = dev;
 	INIT_LIST_HEAD(&pdd->qpd.queues_list);
 	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
+	mutex_init(&pdd->doorbell_mutex);
 	pdd->qpd.dqm = dev->dqm;
 	pdd->qpd.pqm = &p->pqm;
 	pdd->qpd.evicted = 0;
-- 
2.43.7
