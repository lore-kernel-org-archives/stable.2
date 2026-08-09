Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD517386425
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786246099; cv=none; b=QqhkV+7bNYA4XNg7HYUwSbPTPodD+O+9qxwsqNpt6uaauL0wf2Cguss153JpPCvG+wwPvSYa6vvgd2sSvvqYP1ESCiqovwNty8/0k91RGTWoa7UAsSGMY8coAO/ly4vBCygaBCdQHsVItFm1ovG7UiiDtgHZKEXnLWIv59hrqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786246099; c=relaxed/simple;
	bh=EUTWRYIkv/eb/Z386B6IxzwAsVtI3sCcs16queTkXnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeLBKS4/3MiwgzJpWe+ol2FJ46fWw2FbchwWd1a445MX5SEH+ZDt1vVgIdbjIifKqrpVy59Q4j4oL4THR1GZ1Ee2i6NtDP8kqaCVxasOX6hKoS/gICo1h2DhZ6NrBhavbFOigxax78MO+w3o8OPWkajhzOOQl69t0OPovdCjETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbHWXW4c; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbHWXW4c"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1087035a91.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786246097; x=1786850897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=htQ3Nh4NK5zZ2RbZHHLwjMu5TBvqvLaS/zwT9S8pras=;
        b=GbHWXW4cTdlH2njj7u9Tb3WW8C+pb4FRQC8QmMTUxgtuj7gaIXBKrnAKn63gMe0VYU
         0JMnUmXmpJCZiu71/Nj1flwexmGsZ6itwDXVIqcUgAuSM4GGHjc1vkKo5fHQLIGhWzlF
         qLQtE5cBso1qJAbmuUs4M9mF7GhElH1fZVdEHQpZmUrAdVcePXvvLq+LlDM66SpEiViC
         x8PzPWe1Z2Bm0WzgOomLJXoURsgUCJhY9lOiH6TxF/eYwrU1ZyTcCNJbJ8HIGSvGXp4X
         eYzFjtdD2SIsMdFXQxKomzisonq+Zckty/rpwBkmY/0SDEPWU76VnK0rR4L8KskA+yD7
         BT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786246097; x=1786850897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=htQ3Nh4NK5zZ2RbZHHLwjMu5TBvqvLaS/zwT9S8pras=;
        b=IFN0jnT/Jb2GfCAOeh1z5rRGHf0NbEW+YVPFosZYZuEuR9RmlO2D/cZbz24OLO4Wyk
         VutVfv9lTFrXataPd7Ll4AvvPWfPK+mGdLqArXq+DAmoo1MssM7lp5evk1Kkv26irnoC
         WqbFIYtpF4p+boxziRFMN7zo2zNFGlNBJWCqKX6WA6TfY3pzjFw1dX/2YEm1hFVAr16g
         EwNLxKAl2LQauhBepzAK4J/rsZfy2N+mDvFDm2EzS5Gfk1iC/zg3qthMp63B5wik60L9
         m2GvVMOiP/TzpgvcDNNkfCYKQSz81EF5IduuCWIYE0nQJcitmFslQFYZ3c7viWJZVluD
         t07Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr/fzYX2pgMEgDJ3FBDQvSEZ2sihInxFdIb/6feHaai3YxIqw8b4BXE0jQFvyd5qpWned0Askk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnPDQBUXvrN+bMVvTKM38rxcFCoiqYnaMyY3xsdCLhHEZwu/QO
	zAu04A/zSAd0h1qjlq0U9M+O4PiwNMSXX6mHWC+eltlRhfULqrk8+hqD
X-Gm-Gg: AR+sD104TAZce1+lshkUNE52fA4eR4ZgIp7j0CkYCsUfVhqMEur8pqP4KVCH3vONvzA
	w+7PRPa587ZWc+Ioj7XXYLxhO/DVELD0/aFgAPwi7El2PMTqHUunvacSHn3NqtvKCkB69eFQR8w
	BfzyJTzvjHKViuLDc9OfLXOT7jGDyJLVKyvfrUU0X7FM/P9czPejbwra17ClMxX/YLOcmDK1v78
	aiGSWGZY/LATmXRe6i6IFy3YO2PZC0o1aPpy9fVm/3sd8u9/uKss49BQt/UFyv7NsG3QvUVmpbJ
	GE21Mwy5pZpJZwbhyZuGbWalo7TO+OCJSmvEaVbo0lRporugjWXuKmkjftblEs/oymQJFSDTpwn
	jRmmH0cQPXqepbAk47lZKBaLKAinLFf0sX5rIIOwNvmP38gZWHG9bB9Hfjpc2zbG4OhU/x2MqgX
	ul548DL/z+n50LDWoxNu0jrgYEanLSUYpDnm6WrxaAgTMxZesdv3RhOegOBQL8ILzoAQvMUOHeq
	OV6Avotrk4JV7lP5gzyKLuo1nZ5kp1YsduO9wUQqDiOR/2aI/XDvAzJ9B31U+EcMNDaKL3UlA==
X-Received: by 2002:a17:90b:2545:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39261feb6a2mr16196173a91.8.1786246096980;
        Sat, 08 Aug 2026 20:28:16 -0700 (PDT)
Received: from homelab1-WRX80-Creator.localdomain (p790255fa.sitmnt01.ap.so-net.ne.jp. [121.2.85.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3926254ee45sm7587626a91.2.2026.08.08.20.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 20:28:16 -0700 (PDT)
From: Shuhei Takeshita <jyohuku.alterego@gmail.com>
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dean.luick@cornelisnetworks.com,
	Shuhei Takeshita <jyohuku.alterego@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] IB/hfi1: Resolve the credit-return buffer through the send context's node
Date: Sun,  9 Aug 2026 12:27:42 +0900
Message-ID: <20260809032743.2671579-2-jyohuku.alterego@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809032743.2671579-1-jyohuku.alterego@gmail.com>
References: <20260809032743.2671579-1-jyohuku.alterego@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfi1_file_mmap()'s PIO_CRED case derives this context's credit-return
page offset, and the DMA handle for it, from dd->cr_base[uctxt->numa_id].
uctxt->numa_id is the node of whichever CPU the process happened to be
running on, but the entry itself lives in the credit-return allocation of
the send context's own node:

	sc->hw_free = &sc->dd->cr_base[sc->node].va[gc].cr[index];

and user send contexts are allocated with sc_alloc(dd, SC_USER, ...,
dd->node), the HFI-local node.  On a multi-socket host with the process
running off that node the two allocations differ, so the subtraction
produces an offset into an unrelated buffer and the DMA handle belongs to
the wrong allocation.

Use the send context's own node for all three references.  The
continuation lines are reindented at the same time; they mixed spaces and
tabs.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Cc: stable@vger.kernel.org
Signed-off-by: Shuhei Takeshita <jyohuku.alterego@gmail.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 56031becb..e05f3c255 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -382,10 +382,10 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * of enabled contexts > 64 and 128 respectively).
 		 */
 		cr_page_offset = ((u64)uctxt->sc->hw_free -
-			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
-				   PAGE_MASK;
-		memvirt = dd->cr_base[uctxt->numa_id].va + cr_page_offset;
-		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
+				  (u64)dd->cr_base[uctxt->sc->node].va) &
+				 PAGE_MASK;
+		memvirt = dd->cr_base[uctxt->sc->node].va + cr_page_offset;
+		memdma = dd->cr_base[uctxt->sc->node].dma + cr_page_offset;
 		memlen = PAGE_SIZE;
 		flags &= ~VM_MAYWRITE;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
-- 
2.43.0

