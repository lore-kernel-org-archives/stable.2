Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955533FE15
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312444; cv=none; b=bksKXhLhbFZ6wVstQKZ+kg8uqockojUQ/ZuxAINVmViauaZCDJnwSYvOOQi+F/C++b94YL1nFMmabRv53Bhetz1IP2chGbLuo/Qdo1406ivE53N5CNIcBoQNB2t8DIgQ+8P/f8XMuB93X42xQMmNIwOvvI6pAk9GQtVyz93xNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312444; c=relaxed/simple;
	bh=Qm8WGKhjL1rfOfcBgZjBCZcdl8omH4KL+Zz05e0LOSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/og9p8hTqsq8T/uRtONzCGTp0H2l0AdTvxJY+1ieHAHjLqE9qt8bB/lItbPFL7JkQlMAN/bkehzv+o3Cb1vbobFArLkq491B2ianlQyxv+fa4P/5zJv1vXMd1cN/LkOEcq0BDSwFld7C9W3l6fxzZPE4AOdtLgIS+rvSBtzs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqfKU4LQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqfKU4LQ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so445165a12.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788312442; x=1788917242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wt+LQiGu1u46A6j6YSEB/1Vma9hmj220lRwz/yCk9to=;
        b=JqfKU4LQwEya8OxLfaIl+dML4RPesj02NCeJnRwWfo1wj40GSyF9v5JHxLWlQ773Dh
         WMjVyNOuNCqUWPsoM7V9WTzsuATpLoqZjefYM9anxG4xEl9gCi/rfqjz/Jq7ky0/KUoE
         kGJFnuYrNkkQvBQQATFrdH0PCjHxigfXmHo2HZgUYNXWmFlw4HqTzx21W5RWcGqVDSve
         +ddScoWuOPm3P8o6b4bSTmTPdm2c6KDj08dDqsxD3DLlzP/ZtZ3SNzja6yBxnCzB5p5s
         R1JzMWLeAufybEAR0DyAgPeHn/MimMZ0z/x4qnyqpCrT6A7SDTJuoY1xziNq6TAqh4xz
         keow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788312442; x=1788917242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wt+LQiGu1u46A6j6YSEB/1Vma9hmj220lRwz/yCk9to=;
        b=SbIXwI1AkOQTWoTqmrB0bANvREH3xHPIk2GCBdTvmRhtF3wsOMCYnrrN8EHUsrnPaW
         4D5iO1jeL53/miNvVH7/qaZJYBg7LI176xoZWZrwqchkmVPnySOTHQKuUTLp7IVSesmO
         UdkK5gxglfdc/DT+8axHH2Ii8AXQsi8jXe5zCK/HNDG5nK16QAzclrWbvsO7HfrmvPqf
         LOuW2hgY7u//wVwvrfpdwjDJah/r68OoCPpOZPPjrerfK+4FZ3DsaGzDBifwLa/asPRM
         Q0p6wKaflsJgeL+EdRv+fMfRzVCMgba1lxWNLOUXdeTzXzkN1ifBEm0nO6iTbs8y4Gdz
         PjcA==
X-Forwarded-Encrypted: i=1; AKwUvBw9snOSwJGuJb3izGK+fGwWA6ugUfsEMiqeeq3SA4eNRhwbOP4pBfv+mrZ/HcUx/+6hRktgQPU=@vger.kernel.org
X-Gm-Message-State: AFuF++lTpNaNcDxjyIMEslKrDZcv9C/aI19iD/yClP6Ya5NVP8OyFVCM
	kocLeNJXI9sn6LnZOQa/8liAsLeaY3G+Vy2VHmqDJQ+W1qf2QneX17c=
X-Gm-Gg: AYBFou3WeefDlgxZl1axc+W5wZFX1sc9xjFut9V0bZttwBlG96AnZv3a/vS9oMIedHR
	vm3j9/iLR+Hnk1XzvFNoBvUTeorRYBtRPC59NOG1byNQdwHK6+9o+88WUuqEDIC4TlPHE/K4jvC
	Vaert6wsBcL1U4WLMFxLnhAUEvuY+fubKpdMsMAmE4Iz52KjDLDU6ZwN6JFSt5MlxfTS36d+YcE
	49hj4J337edupuysjuR00zNXEzMYdl+kxh7M6Ok/uCepR4iCE5R9JrgeTO4D9G9Jd9x++6cKRjs
	fPsF7XZOE0pYSlA6Eh8G0NG54z2Ot/OtVjvdFnknTKPqyjHEkLOQHRox4ufQeQEi70ZmYeG8Yqa
	EDgf9IH/JPY0DZNmiUAX/xGIanlqmXgBtovuqb9hJzevwHdGRfbTeEnoZF/rlg7VtME1miyoeLd
	QmIx1MDQBpDJjjbqwGPn0BY5ZAil9Ha42Zc9YTQeLODElhgy4h6vCHvpPZMp0ZokGOb/i3JdG7t
	rwQ7VI9JDMp7MZScJQ6G3DXhP84
X-Received: by 2002:a17:90b:288a:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39aee0848bbmr1717405a91.14.1788312442070;
        Tue, 01 Sep 2026 18:27:22 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d7bb9d7sm8719236a91.15.2026.09.01.18.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:27:21 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: RCU-free the scheduler-containing nouveau_sched
Date: Wed,  2 Sep 2026 10:27:16 +0900
Message-ID: <20260902012717.880724-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct nouveau_sched embeds a struct drm_gpu_scheduler (base).
nouveau_sched_destroy() calls nouveau_sched_fini() (which does
drm_sched_fini(&sched->base)) and then frees the object with plain
kfree(sched).

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
scheduler fence keeps a .release callback so it is not ops-detached on
signalling.  A finished fence exported to userspace via drm_syncobj /
sync_file therefore keeps pointing at &sched->base after nouveau_sched_destroy(),
and a later get_timeline_name() -- reachable unprivileged through
SYNC_IOC_FILE_INFO -- dereferences freed memory (KASAN slab-use-after-free
read).

Per the dma-fence lifetime contract the exporter must keep the data backing a
signalled fence alive for an RCU grace period.  Free the scheduler-containing
object with kfree_rcu() instead of kfree().

Fixes: 5f03a507b29e ("drm/nouveau: implement 1:1 scheduler - entity relationship")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 2cbae003d6de..48dbb851df2f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -516,7 +516,7 @@ nouveau_sched_destroy(struct nouveau_sched **psched)
 	struct nouveau_sched *sched = *psched;
 
 	nouveau_sched_fini(sched);
-	kfree(sched);
+	kfree_rcu(sched, rcu);
 
 	*psched = NULL;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 20cd1da8db73..51ce8dcf6285 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -98,6 +98,7 @@ void nouveau_job_free(struct nouveau_job *job);
 
 struct nouveau_sched {
 	struct drm_gpu_scheduler base;
+	struct rcu_head rcu;
 	struct drm_sched_entity entity;
 	struct workqueue_struct *wq;
 	struct mutex mutex;
