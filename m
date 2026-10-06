Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9913033DE
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274748; cv=none; b=I1lH5WUrWZ3kwl5el9aOS+1CQPO7o8jFxTkjvEseeADU4MS+PGABKu9n30bSrcAeOPGYi7gy7nsq5RfZAIEjJ0dIj7kE3Oj3xdlCLSq4GPyClKw0m3J+tmWaZszgekGDeV+l6pAnYgQc74PeDuFcz7JbFu+mL9rUFzPv/sgEZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274748; c=relaxed/simple;
	bh=qhZNAfD7z34kkB/8KUmaUTADLEQDzTgyQRnKEcSpYa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVeI2NF7m4ro1Zr0EmMEViwy0pd3WyQ2tF9gBoaKML+TyLF931O58XYcFVjtmGdafgdM2uKEmjWQ8DOOF8a4FMLzHnAj9//A92FhvwC0BCKwsnik8rfkE81VFVPUNAsKHGdCUOUm3lOIzlm5rkChsWGefCFTzCsvgrGhSSLsqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5/xl51e; arc=none smtp.client-ip=74.125.230.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5/xl51e"
Received: by mail-lr2-f1.google.com with SMTP id 38308e7fff4ca-3a772511049so17676201fa.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791274744; x=1791879544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5xmegwaObSlaaJYAf2hwhY81EYio3LkX0sVedAPdVEI=;
        b=r5/xl51eLU2SAs9UuoSfn54iCb8V3FKtaZo99LV1KyeUELer3P1LRuqwLK7fmPyI3i
         yWUWJ4ebnoazg4f3ByZFtCJP2qLehraH8eHTHNjVxzQ7pYtfpcvuJv/jmoJr5Tz8Lij4
         6IKM8UUL/VBum9VjEBTm+Xct/wMF/+BwpIQ9RQiu4gAqLG0u+w03T8ZaxHcMy7h78Ffm
         Cv/jNzN4mDHeRMoogRlOiqksyW05ejCfb5TTnQ6pvLFYZljM2nvw72HOMbsMkriwf33a
         gK0NEkzA/wFEFwe6VUht0eCfeTJiSkRjcRnyelV1pGB+h++4pwurYBcTMUYev+tUIi9m
         guzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791274744; x=1791879544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xmegwaObSlaaJYAf2hwhY81EYio3LkX0sVedAPdVEI=;
        b=AZYifgLyAeTGxKQeuL8PwGIl/oWDuAdJDj8IlLRLusyh7ADhyiFsqxcput4wInG2sy
         ix30aDiPDlDDV2CTb7jkVxnSOtTf1Y47fnwLDT63257jIwevUglKnG7VgY6kMteDKUEu
         5jY8mcmrwTKh4E5ZP7zboWfksIwI+TlnFYBKHrmj/0hYGc09bkXiWoUcj73JnL+8tQZB
         SiI2QKdhq5zEzRiINKmN7Qg+e3i5zYsGrkYFwMVgKt59LR1ig/lCpLPehQYPcfuw2+u8
         d87jjxgCnruFfeLk0aEIVX+icLPScP1ke8IetlLtCtLl782ohMhf41VsXPUbCxhvQpmS
         HSBQ==
X-Gm-Message-State: AFq9FYJHAxSDkeaVfvRoSrkjlLW703coPNAuAjRxmp9wMLQcOpsDoFbF
	hY4L1sEmtfxgTNlEqadjElf/5qZRYv8561t2JSjV56gkVaxGeUdknqZouQWrRXew
X-Gm-Gg: AYBFou3MHqEwDF6fg26T/4EsHC1Bot6/nXAqCTxMhBZe+v602d9S4tBr4zghTssTf57
	a+iWJ7UbvPXoHs6k9XI2i361ge9Ai7uEUQbtD5bWzfz3PN24SvLuOETDdNzuQbvKZruUDqn7RGw
	p1HEwIe0HPblL1EG71InqbHzj9wWFptGAvPoI8nC0LBvPXFtDWZApQ8YeR92Vh2xAtSc4KTK9Ra
	/UhA+IVetuRy0bUhJIvdUprIqDNNUQo6VMGdnElDpDAVulYXT7XHbb+zvthZK+Oe7GO8XTj+bGo
	SjeIopPyDUKBGh2BKFaHfdroVrzjF9YNvgVGNt6RzUnpnAaUdd+e+oOSOxhP8f+Ecd7N73152r6
	q2zA5k+n1z0Pz5OoHCghRHVer+5kCFdreuVSoS5x58/5w3/m4ojqb3sglcSb7CEpNXyfcy60toY
	O9VngdAI4mlCxSiEKCyBibywEmmRO/RmEr7HjZzdMVjYIZcry0yVd88G+9JiSVMiQb/uvzL3fS0
	IuTTUKxxaCAO3te
X-Received: by 2002:a05:651c:4cb:b0:3a9:9a0c:6a75 with SMTP id 38308e7fff4ca-3a99af74c30mr1654821fa.28.1791274743808;
        Tue, 06 Oct 2026 01:19:03 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e303889sm46849861fa.20.2026.10.06.01.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:19:03 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yixian Liu <liuyixian@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15] RDMA/hns: Fix WQ_MEM_RECLAIM warning
Date: Tue,  6 Oct 2026 11:18:56 +0300
Message-ID: <20261006081857.125617-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengchang Tang <tangchengchang@huawei.com>

commit c0a26bbd3f99b7b03f072e3409aff4e6ec8af6f6 upstream.

When sunrpc is used, if a reset triggered, our wq may lead the
following trace:

workqueue: WQ_MEM_RECLAIM xprtiod:xprt_rdma_connect_worker [rpcrdma]
is flushing !WQ_MEM_RECLAIM hns_roce_irq_workq:flush_work_handle
[hns_roce_hw_v2]
WARNING: CPU: 0 PID: 8250 at kernel/workqueue.c:2644 check_flush_dependency+0xe0/0x144
Call trace:
  check_flush_dependency+0xe0/0x144
  start_flush_work.constprop.0+0x1d0/0x2f0
  __flush_work.isra.0+0x40/0xb0
  flush_work+0x14/0x30
  hns_roce_v2_destroy_qp+0xac/0x1e0 [hns_roce_hw_v2]
  ib_destroy_qp_user+0x9c/0x2b4
  rdma_destroy_qp+0x34/0xb0
  rpcrdma_ep_destroy+0x28/0xcc [rpcrdma]
  rpcrdma_ep_put+0x74/0xb4 [rpcrdma]
  rpcrdma_xprt_disconnect+0x1d8/0x260 [rpcrdma]
  xprt_rdma_connect_worker+0xc0/0x120 [rpcrdma]
  process_one_work+0x1cc/0x4d0
  worker_thread+0x154/0x414
  kthread+0x104/0x144
  ret_from_fork+0x10/0x18

Since QP destruction frees memory, this wq should have the WQ_MEM_RECLAIM.

Fixes: ffd541d45726 ("RDMA/hns: Add the workqueue framework for flush cqe handler")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20260104064057.1582216-2-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-46265

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 43b661f97188..32d8a4eb385b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6209,7 +6209,8 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq", 0);
+	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq",
+						    WQ_MEM_RECLAIM);
 	if (!hr_dev->irq_workq) {
 		dev_err(dev, "failed to create irq workqueue.\n");
 		ret = -ENOMEM;
-- 
2.53.0

