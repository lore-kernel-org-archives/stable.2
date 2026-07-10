Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8E3FD97A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677887; cv=none; b=bICik9l/SIdCmhiA5g+5cQharam+KbLyQKrxiPr7+zQ1H9Ckl1iPyZDDOpFKNj+M6A1MI8d0mW2xzGkdrHTIuNGxUqZImJFbrXYwmh4kzmVVHwk7xAwHu9LFZjH/kF7zYYyV30/sOdHUzo2dMsJd6PpOyw3rLlj1RwkKIUkXFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677887; c=relaxed/simple;
	bh=1/T6l30OSc/13ghkKigE/EraxxH+hq6Pkoy8zdnQBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWcgGWSDl1bcLK9xfeoCaqJtPM/qyjhhOcuEy98AqxR3/VniNe31SrfpQmSOku+ZjfhHBV5zPUhhwsjtjQblWhOUyeQHn0bV3tJGwH6k6+dWBOfq0tjTaQWdRBrA6acpUkQVy6Tm6fEoa3e6k6dAaBMuq8sOemeUU2ryT10KJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=KwDOg6Lq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="KwDOg6Lq"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47df6a5202bso425967f8f.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783677884; x=1784282684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0MN3kTnck8FKiznnDeMfk/kad4KxVs02NYEcU7mySM=;
        b=KwDOg6Lq6D6ZMsa1RWoi4iNK3kqvN2UGxtVHBimdK0ovU1diolJz46vRludQn2xiJE
         wZDRfsznI8fREUL+dMvsWZGAvOe7zVFYfJi9Jj62+OwS7x6po4A/tPjV4vLgR7HmqlNG
         NVT/YUicG0S4Ua6hMoaKLSUPbptI35uyfyROb1mmpeOu3H1zjGVhziU58oi+KU2YyDGt
         UHHoo7yuTJea6BmU7TFJ/XNbBH5F2ysHG5Agw5qni3DgI7yNOWPDHzqTfCT1raO61AIz
         BAiF86x3RFqZXe2bfDk76HiMfONQA7MVxVotJrw8z6pMRNoOMyUp+Q8Tl+qYEWAzSr/x
         gX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677884; x=1784282684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0MN3kTnck8FKiznnDeMfk/kad4KxVs02NYEcU7mySM=;
        b=B8OpP8AkA7UFOn+x83soU7o/Y5Yyh8Tn8YQug4DoACy/R18onByw+tGxPQNQ56YCY2
         i4GlrG/pDpual9pWR40XJTGwiFsI8om9dCsMZmMaCnTxlHOVwI1ktpYMcG/AhOIZKIO8
         os/BpAyNM5KKXNxJn8rcrdO4QEUKb87cLz8epbaeWSyS/N+9YDfxRJcVIilyuyJxmfMq
         uddwOSLMidPV99ukeJNKpRdSm7guhPXWBA8hhDjcCxtG0EdJAnuEUR+B5WVW8vDU5Z4z
         Hcn+SIEL7Y59O+8bIsXjJdtfy98QlpQefqzqkpcMAF7fku67Akn+aT7a9LBO93yTyeGW
         gkfg==
X-Forwarded-Encrypted: i=1; AHgh+RqK9RDtyWkm8oi9meRtna4zS9c1PgBnvahXHgUHImDoPEqAfj/VSdQHvBbtZfa41JlLq9S59sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+nGsR1SA6AWiWvZOZcDtOex9cjLAW/yubsKf0VPtAPA//YMf
	04U48aukDBdF1qD3hAJ40XtanUib+FpfN2EyTHwQNpJtZovjzr6LXkulbIuvn/iVQ44=
X-Gm-Gg: AfdE7clAcG/Uc/AazF7/NRHWi0fEB7J2951TshRoNRhriofkWdBvjkSetLNRo1psJvb
	RFqkojKaWWtB3xA6JKK5LreyPStC7/wzEnfTXALZOFmx7EhdyvrQ/Io/GwGCngQnPwfJOvfxELR
	w3ZGL+v4UVkQux5G7RiCBfYWMHSBMUcFm9uHGM+zxr0A/Xng0ciwodlZP2InWE643v5RpKXktAC
	kNMYleMNy1Omplugt7RJ0KoN71zNq3NEitticxZvPkHfOMLPKxxMRDZ3+3j+dMERgGPm4+eJHUj
	JDNOmnymPgSBKz+MlagYNc+alHwJyzILtyl/MjxOo6x91TFPsIbJyd+7KBkaVSpw5qhEYQ/wnRP
	9ZSYdPf5KysP6Le2VeQVh4pLLDyyGqN2fcYgWw+B0fqT0kb9txGecVbFxchVcel2dXVp6p12dWu
	n/d3H83WesGOkdQmY=
X-Received: by 2002:a05:6000:402a:b0:46e:98a7:232b with SMTP id ffacd0b85a97d-47df07a8676mr12628273f8f.10.1783677884305;
        Fri, 10 Jul 2026 03:04:44 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26a0::3d9:1e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm61261033f8f.21.2026.07.10.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:04:43 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] sched_ext: Fix deadlock with PSI trigger creation
Date: Fri, 10 Jul 2026 11:04:41 +0100
Message-ID: <20260710100441.2653477-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

scx_root_enable_workfn() currently takes scx_fork_rwsem for writing
before acquiring cgroup_mutex. Since commit a5b98009f16d ("sched/psi:
fix race between file release and pressure write"), pressure_write()
holds cgroup_mutex across psi_trigger_create(), which may call
kthread_create() for the psimon kthread. kthreadd's fork then enters
scx_pre_fork() and waits for the read side of scx_fork_rwsem.

This results in a deadlock. The enable worker holds scx_fork_rwsem and
waits for cgroup_mutex, while the PSI writer holds cgroup_mutex and
waits for psimon creation to complete. Any concurrent fork blocks on
scx_pre_fork() behind the enable worker.

The hung-task detector captured all three sides of the deadlock:

  scx_enable_help:
    __mutex_lock
    scx_enable_workfn
    kthread_worker_fn

  systemd:
    wait_for_completion_killable
    __kthread_create_on_node
    kthread_create_on_node
    psi_trigger_create
    pressure_write
    kernfs_fop_write_iter

  python3:
    percpu_rwsem_wait
    __percpu_down_read
    scx_pre_fork
    sched_fork
    copy_process
    kernel_clone

It also identified systemd as the likely owner of the mutex on which
scx_enable_help was blocked.

We reproduced this on a 128-CPU AMD EPYC 7713 by enabling scx_lavd
concurrently with writes to cgroup PSI trigger files. Unrelated tasks
piled up in scx_pre_fork() and process creation on the box stopped.

Fix the inversion by acquiring cgroup_mutex before scx_fork_rwsem in
scx_root_enable_workfn() and releasing them in reverse order, while
preserving the existing exclusion around cgroup and task initialisation.

Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/sched/ext/ext.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f64..ba89eafe7964 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7193,7 +7193,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
+	 * cgroup_mutex must nest outside scx_fork_rwsem because cgroup file
+	 * operations may create kthreads while holding cgroup_mutex.
 	 */
+	scx_cgroup_lock();
 	percpu_down_write(&scx_fork_rwsem);
 
 	WARN_ON_ONCE(scx_init_task_enabled);
@@ -7216,7 +7219,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 * while tasks are being initialized so that scx_cgroup_can_attach()
 	 * never sees uninitialized tasks.
 	 */
-	scx_cgroup_lock();
 	set_cgroup_sched(sch_cgroup(sch), sch);
 	ret = scx_cgroup_init(sch);
 	if (ret)
@@ -7283,8 +7285,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
-	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_cgroup_unlock();
 
 	/*
 	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
@@ -7369,8 +7371,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	return;
 
 err_disable_unlock_all:
-	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_cgroup_unlock();
 	/* we'll soon enter disable path, keep bypass on */
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
-- 
2.43.0

