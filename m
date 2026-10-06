Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com [74.125.230.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2003AB28F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274731; cv=none; b=kjBaE7H2qTe/SjiBf8yQcKvJCMyoYYpZIx3G+qxyD5nQQRr8+9QaDnPxGI6Yj/nSFKJSoUjg0yWvYk4bfm1v0vqrnaMumxF4YzEruTRixNp3GMWRvrTR6/OAv7Op0fgUojfXQBFBNLMiiKJyVXoGrGrKM2tVbQYUBQMQUFKvqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274731; c=relaxed/simple;
	bh=8CFmkxKpRFqhw9jrde40c9rb1WJEJtIVozzjHWTho9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tB/3L2Bj0afVybTdW7BrGGN/mLLQv8Fj8J/P6sKNCQa9OHClFncPleKEmSSMi6SQ/LPbGnjzJ/JpJvJcVA+HCjG14DptG3bIq+gV/OeTgf+pBkwabYLS0pu64UAsHcV92j6MOAWM4lPoSWxpSMw9EirV7tdXMcKIgOnsuwYV6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDfAU/1U; arc=none smtp.client-ip=74.125.230.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDfAU/1U"
Received: by mail-lr2-f11.google.com with SMTP id 38308e7fff4ca-3a782b861ccso18783121fa.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791274727; x=1791879527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gZjlHRYt36AYHmrS72ppy1MygmeYzlOolTpnm0Towo=;
        b=mDfAU/1Ub2o2giIRLyH8vL2PvuQjauNAqwJIJW/gk2FCMuhyBp+/HxeqPmEcEnCI8Z
         Abp/+cv0Dx+PYMyG7gu2hywW47VHM7NqQayeYvXb8gpcmkjmIlFqLcCm952b8CVB7JI4
         wuZlz1cO62618FfTeosnAYsmJKHg3B3JPXmfiJ3IIrITnv8pQA2lppgoTbMFlPjgoZDq
         YAaqGlI5OdWBwK9dkB8q/WphBMtLZRNWldmy4sj1bA4an2XKVJ+hJyhiuIEVWNKri5gc
         Ie+wS10oB0KOT+rXz+uqTMR0hGkJ835rCt2R6jcPH6hv9PYkf5WTGsf9qbde3MpIjtP9
         VlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791274727; x=1791879527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gZjlHRYt36AYHmrS72ppy1MygmeYzlOolTpnm0Towo=;
        b=uYE2TMjrMh4L4HtbxhyLA8QcwzjmnXkqivqlhtc0PpkV0zD3NfHjAt8m9a8zrPX1m/
         44oR1hInOBVTADkrakkv5pfd1X0QjBelR5Y168JHtBcljGzfN+QDb2eiGGgQE1iQOr9E
         /Axo0t81XPjdZuABwxJpWk48VklHmr4/+P5fyYj/NnxD/y82b96AlCT/hOBBGjENfyRS
         s/8ADMi4XimvpF9+FlAsdfJQ3Gt3Kk7oPrxglOlo/6FTT6VxIb+iav9YRLYiw292UNEh
         C0FEW1OM4kdgB4Hjk3WGR1430CTcW1y9EyCkyYuJdy1taXFgslphTG9VuvEv4SFiBFvG
         lXdg==
X-Gm-Message-State: AFq9FYKxQg1QLhpyz9cR4QZX14CNsaS5ZZ6/WYHatDCA0XeKUM976wh2
	U2Q62OJUr9xWMbKQ1kO0psndUwzDPiQHHlc49Jg8XItIYxyaow50rwFwT6ndfaDj
X-Gm-Gg: AYBFou1r5YtjtCeSHdqUNc+qxeCG4EhnogsVPgL8Ul+3h9R6QF5z88U2rpKictEj6P5
	BnyuRHrCeT4I3nfyESQM8ElewoEVCXzGE8LSlRmW1kkxBRvDqG84pH2NPZyZBNHNBgMRErY0jep
	od9+4BGVbODWot9d7viOPmNA5HfbJvtiHzAw2PVEElIkSusslbwpShNitoLLazdtyxonu8dgwHM
	P6YoSl7iEUV3a/NAoA5ynTaOIumTd4I2H0Re0pJp9y37sRKYnyOeLkW/eg0K4nYF/gGgm4/Pajw
	tHoaWkgm0oXg+kZAy8ZP0ltYG5sqgfihg90iE0WVzniyAoHXxAzqC3pudrbcAZamkkoLyZLcsRA
	D6Xg9euj7Qx5D03i+53kBoYuN/GL0wESEp6oigH7zf/NlpCkfEnYjVXvEK+DQ1j/lY88ltJaGHw
	B7DQNoKez8U5AVMehT4PDhnDk5jO3AtWJFAUiA0DHPo2tZSDaJHZULMpkhuA3ZnTsQtyYaD5TIr
	BeGZtfM0ArSx7fh
X-Received: by 2002:a05:6512:3baa:b0:5b6:4ae:8c02 with SMTP id 2adb3069b0e04-5bccc6f92efmr311171e87.29.1791274726992;
        Tue, 06 Oct 2026 01:18:46 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c71911bsm3903389e87.11.2026.10.06.01.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:18:46 -0700 (PDT)
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
Subject: [PATCH 5.10] RDMA/hns: Fix WQ_MEM_RECLAIM warning
Date: Tue,  6 Oct 2026 11:18:39 +0300
Message-ID: <20261006081840.125567-1-roman.demidov.nn@gmail.com>
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
index bb744ba155e2..56c7af1c3b24 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6087,7 +6087,8 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 		goto err_request_irq_fail;
 	}
 
-	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq", 0);
+	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq",
+						    WQ_MEM_RECLAIM);
 	if (!hr_dev->irq_workq) {
 		dev_err(dev, "Create irq workqueue failed!\n");
 		ret = -ENOMEM;
-- 
2.53.0

