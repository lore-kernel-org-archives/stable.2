Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867F3EEAF0
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527629; cv=none; b=diIEtIlHMri6fi9yLIPkyA9p4PJYNz/MSZ6EB282q4BTytdeQ7UHPtQe8fq7b5WTafKkCtfED0KXrjjIZtmOzgE2DP10YeYTfAUuRy2fnYxVgso55igHZxHpwzHolidYrmbBuJvhNMJqUhvmrxFFZDFWrdaJzxDeB/6J7y0IZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527629; c=relaxed/simple;
	bh=ZkakF9oXw2JJ3W+/cLDR4b60U5xSBjf+/trk4pVFs7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCRg2NBi37dz2NaM13gWqTug7Zt5nk6xi04ik/ca6TtO5LNinY8F/Zm55PuSYegLbAqQXZponU5VWNB8TXS8CuUo6yPtRs+d0w3hWB1mjmquGJmesNY6TUbXwGrD8NFezbPxXjhb6h+WaUTlTT8i3/nyrNiB070n/oRVrQvhvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=ZDMKQoH+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="ZDMKQoH+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef82204c6so1715150f8f.3
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1781527626; x=1782132426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crH4Z9hoDTNPeb6V+9xac0v/Umo3o6vZRxmQqiDS3ww=;
        b=ZDMKQoH+A/wLpeTpAZojlYGcySTAyHs3p+JA202m+HJXnKWx7buxKOUYjAnYBH7GnB
         63GqWwLr8I4pw+XUTV+//gQMgEF3mN7i2Wxnm5rwKm+Ko3qZhRp/yVyUBM6CeL8sFM9I
         AcGJHe8YUK7UqP0nqyfStlzFpKP+e64exAK6Mzpt3Aml7lIe3i5+mmk5AYIQSHV16tOP
         gMbg51T91QMaOV31W50iFunecuQ3rSSZ2Ku5loLKq5FwwP2frBUqwBECtBt4sWUc0ZX9
         F0sagElHrhPoHI26RUJk/WLHRmp+fU5oAfFUe2KfRxeMQIma8jHFXG8wlF0822gd4iDz
         IoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527626; x=1782132426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crH4Z9hoDTNPeb6V+9xac0v/Umo3o6vZRxmQqiDS3ww=;
        b=K9vJnSohMmF/2Th1CwlYix3jTqrigqOZJG5Kh03n2zwCh+XmLS5GPS2XwP3kw6bi3G
         k5t2VaOMlPLwWoK4bI6BO9DnWklgdFY8L7SIAZa8xUlkvEuulym+JQSfexcQ6eEqFog9
         HTh2SL20I6DF+QQ/r1OiIByPCXl58yyxa8aKr+9aOQ922ziEDNum9sbMns8eArPEcdIk
         lqHQh0305UEvmnhDJfg2hqA83fCgZD++OMCdJwC7pAw/yUA1rjk9IvzVWRoNn2RZ+NvH
         9UdeDtK5QUyfHQAhWcsdk2wSEeEIUzRcIFqMHegWIEJqs7MPN8jvxeTwa442Yfl5IFK7
         Y2sw==
X-Gm-Message-State: AOJu0YyILBXA4ieXaE9qDRMC+cceUys2o+RWZDKXYdF8tp7gBa5N855b
	qJ/wcfdUYluH48A2a+zcpjB266R4G0EbGSYULxFhWiBl097ywIO6rPFFyKJIcoE/ovTE5wVfqsH
	fdlkt
X-Gm-Gg: Acq92OFh5QL9y3BXXdQ0EEjCbTT0HGpY6gYzTS6xUmlzaAv/iGIoI2sRcB9MiUfVbJh
	q5TgzZbCOBTHN/tmIzO8QCZ65ZF8InAtoMTBnDTPksioR6sYDIoIkwVr2EB0fKhMKjz9HMIzOsB
	bq+0qDzdznoI2I4ODSd2k0PC6SNuvx/EyBCPkBXKufJdK99iSv3X1rwOsiR5ZVuluxF66l5a66w
	zqEIS+0BlL35S/2vV4KaC8EeALBkIDV/SvzFT5dIqm2GQN9XnhtKasmXljkZhgVhyfJhkEN+Xpa
	9ZUcY2MJbNDQG7CdnlHLfY/hzRavITlW4snawKtUwMDzOAX45n6Cn529TuGMwW/gB3CYWrhVJgg
	B00wRMt3TjjvCZtZDE+0jzc6uYlJMRSJSXyXXuY2ztSMyNhKMLBeyOTMfY32HQbHqosJQOhXmcj
	CKmWzt+PUxOzkSDZZwaluOs8CTTg==
X-Received: by 2002:a5d:4ec5:0:b0:43d:7b90:fa23 with SMTP id ffacd0b85a97d-4606dba20d5mr14528473f8f.29.1781527625806;
        Mon, 15 Jun 2026 05:47:05 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:1cdc::2e0:a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3fcfsm30333861f8f.26.2026.06.15.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:47:05 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH 6.18.y] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()
Date: Mon, 15 Jun 2026 13:47:03 +0100
Message-ID: <20260615124703.2238517-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026061553-elderly-speech-3446@gregkh>
References: <2026061553-elderly-speech-3446@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

commit 02e545c4297a26dbbc41df81b831e7f605bcd306 upstream.

A WARN fires when systemd's user manager writes "+cpu +memory +pids" to
its own subtree_control while a sched_ext scheduler is loaded:

  WARNING: at kernel/sched/ext.c:3227 scx_cgroup_move_task+0xa8/0xb0
   scx_cgroup_move_task+0xa8/0xb0
   sched_move_task+0x134/0x290
   cpu_cgroup_attach+0x39/0x70
   cgroup_migrate_execute+0x37d/0x450
   cgroup_update_dfl_csses+0x1e3/0x270
   cgroup_subtree_control_write+0x3e7/0x440

scx_cgroup_can_attach() arms cgrp_moving_from only when a task's cpu
cgroup changes. It can still be NULL when scx_cgroup_move_task() runs,
through this sequence:

  Step                               Result
  ---------------------------------  ----------------------------------
  1. cpu enabled on cgroup G         cpu css = A
  2. cpu toggled off then on for G   A killed, B created (same cgroup)
  3. an exiting task keeps A alive   migration skips it, A now stale
  4. +memory migrates G              stale A vs current B pulls cpu in
  5. cpu attach runs for all tasks   hits a live, cpu-unchanged task
  6. scx_cgroup_move_task() on it    cgrp_moving_from NULL -> WARN

The mismatch is that scx_cgroup_can_attach() keys on cgroup identity
while migration drives the move on css identity, so a NULL cgrp_moving_from
here is a legitimate css-only migration, not a missing prep.

The call is already gated on cgrp_moving_from, so just drop the warning.
ops.cgroup_prep_move() and ops.cgroup_move() stay paired.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/all/20260601124156.2205704-1-mfleming@cloudflare.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ mfleming: keep the 6.18.y SCX_KF_REST argument in the
  SCX_CALL_OP_TASK() call. ]
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/sched/ext.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7b750bf42698..d8280f874433 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3221,11 +3221,13 @@ void scx_cgroup_move_task(struct task_struct *p)
 		return;
 
 	/*
-	 * @p must have ops.cgroup_prep_move() called on it and thus
-	 * cgrp_moving_from set.
+	 * scx_cgroup_can_attach() sets cgrp_moving_from only when the task's
+	 * cgroup changes. Migration keys off css rather than cgroup identity,
+	 * so it can hand an unchanged-cgroup task here with cgrp_moving_from
+	 * NULL. Nothing to report to the BPF scheduler then, so skip it and
+	 * keep prep_move and move paired.
 	 */
-	if (SCX_HAS_OP(sch, cgroup_move) &&
-	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
+	if (SCX_HAS_OP(sch, cgroup_move) && p->scx.cgrp_moving_from)
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));
-- 
2.43.0

