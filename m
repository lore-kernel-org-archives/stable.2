Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AC39902D
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311254; cv=none; b=olFMU4P6KmLVoQJ5VxRDAcvXEiPVnsdWGF8Nex36dTAAuTN7bdRgKsnK+S8cZHbuemNrY+YHmVRwC1FTdLESanFE/6wz7wANjvDxjpbbpHiiIcCQc3mmEfIi2Mgk2IqFGLLxRAhpG9SAvnJIj4Vg8Hx2TMpDduJ2AP4dmCMoIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311254; c=relaxed/simple;
	bh=aBqwRcjjrirAEQcYUzGrlCWqcSI+0qm6EGsqltY6yx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yb5nci8loa2L/pEbglAqjQJXbo/dUosBDbRdUF59QWCaxXb1Zc9aH+cWKIHE3Qr/q+GoY/Ac3tvjjP6FCNZDCiKwi1yBaz21obZUkAxMH09ePGad3irIwGZIIewVUAoLHNrtalIERKl7IKpym30uWmZw5Ojo2zZq7GfzJWvrlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMtAkGfh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMtAkGfh"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39666f49929so17538521fa.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780311251; x=1780916051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFXg3u3Hl1xsWJNPPj6ianatRb4V7SHTMso00cbxCeY=;
        b=YMtAkGfhBSUTJtXvRvAmSFQtqkI4LW5g2KiGEicDsLCdw5BQ6QWD9cLLapBuxjPP0+
         xHTECCMQ2d8Tc2cuY3/qGoHJt90mHvpkbsft3Gh5pGNn87zQPD2JgfSaZBXWbcSlukBS
         MLIhWYNy/GaZqbjMJ8Dx8ye5XmoJTABWe1yPdofQhw/7PXKOO3iqxUDoI1K/XVwNe5PW
         kk0jLSQpq5LEfWvYZuCxSa54mM8FZgUERQP96Y94yM3MfcqbOP5NQrF4yaJH8Fc6gMdU
         AvgEXpWj7GCsX1krCIcg4dOf3p33qMqPaHc1g4y4g5JxvfSt+IOtVDwuUrnXviIXn79+
         3HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780311251; x=1780916051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFXg3u3Hl1xsWJNPPj6ianatRb4V7SHTMso00cbxCeY=;
        b=IBpNVmwMPYH4vp1mG7mRZpP0CSFllGikG64y676+DBubTeNeWvUUzEDy01t/UUcDgc
         4eOjLHqeUbLxju+dMSRvvCGDpyxhqGgS+XmMxfQaJ+eH+M5Qg7hvqduShbyez27W1VXF
         0yKfbGdU+Bd1C6bnHz8L/CurR3AcDJv0HrCUMN/Bz7TWKO+FWsIfFHxg+D/Wq3LFEpf/
         sUgdVbkaNVwfyWbU03tTGdNcCxMx5AlfBDwd+DVXwl/5vIyeGPM6J5QSBs77fpvP1TEz
         iwsN+G4cn2tDpZpJAjvCePjwIlIz6t/65xqsjb1uHA+DGPlG9q5pfK7TM/EVMxMJlaNP
         TUrA==
X-Gm-Message-State: AOJu0YybtqIh1+xpbhIF8wusGwteb604OSjyFo7w3SHLeWl48UI3x+tO
	rAbczkfOVVJB9r/ITWYNx7kxwUgAU4nnRCG2F099+T8DenRFr1uCPS72USVRx5HJ9EU=
X-Gm-Gg: Acq92OEKXsw4GWRdtU7/9rvkY9IYaoxSP8PGrriFJcd3JzHzklKNL+zdUx5c5hw5w7v
	dxThxCn2m1s1V+wuuGw6B+o7ZNGyI2/NeUWmilzViSYYDZRbHQ12D+tCNmp4ZDZSCVD/Auf9vwD
	2Snb79X/QXLR0Bi9IhHU8LKrYH8rQuk17iT00CbwktBdt1KxyNB1UWkrdLVDTVCta+nf5MLIbCj
	qHQ3gxjTCqVryIBKaLsAHghPkApHpiP1gIWEBvl1ddBUbhu0mreLigfwJSjlLRHzQpMg+Kd0oAo
	MV1bFQKgCmmt1ExeYt+VQQYm9P/KHKJaH3sndSYLTrtcmSkoJgJ2QUiuS93Htf9MwGkUuU01hQi
	hnpOBMzwvRKpy5UErcxR3fONxOZFLQmZgIUO99p2HMDHV9HiYYj7tOn9HlMZh32rXOkj0ktnE49
	uzTTg2B7/AgV2dOYxpsLfPZBYu2RA31R8430uM2TbkTnfO4ztckTfNZ1DKZHOT7uKtdvZmY+Nqh
	lRvfJU=
X-Received: by 2002:a05:651c:4419:10b0:395:fded:ee35 with SMTP id 38308e7fff4ca-39664e39419mr20850381fa.3.1780311251119;
        Mon, 01 Jun 2026 03:54:11 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3967a2e7abcsm10381351fa.8.2026.06.01.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:54:10 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org,
	syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Mon,  1 Jun 2026 13:52:32 +0300
Message-ID: <20260601105336.3023-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

commit b2b1ddc457458fecd1c6f385baa9fbda5f0c63ad upstream.

In the function rxe_create_qp(), rxe_qp_from_init() is called to
initialize qp, internally things like rxe_init_task are not setup until
rxe_qp_init_req().

If an error occurred before this point then the unwind will call
rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
which will oops when trying to access the uninitialized spinlock.

If rxe_init_task is not executed, rxe_cleanup_task will not be called.

Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://lore.kernel.org/r/20230413101115.1366068-1-yanjun.zhu@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
Backport fix for CVE-2023-54028
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 13b237d93a61..687d4419388f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -785,8 +785,11 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	if (qp->req.task.func)
+		rxe_cleanup_task(&qp->req.task);
+
+	if (qp->comp.task.func)
+		rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	if (qp->req.task.func)
-- 
2.47.3
