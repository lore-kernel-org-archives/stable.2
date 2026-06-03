Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5712C375A
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493258; cv=none; b=s9+vcrE0Kzd9IsQQFQzlBeGWZ6JXCh76yty1hKGzFfzPa5R3Xmz8UsK8XwbYvOh/Eje2KGC6EjUaUbcEA13lFtQ/lLsNIP/czgr6OC+MjFx7yscEG02ixZKz7myuaJojpfph5WkFS7LpWod1pHxl8sFa69e6s2NgApHQLHJsYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493258; c=relaxed/simple;
	bh=ZKmIfYiJUMLvnY0Ua9XlJaLUeAaZxb1MUfLcnPeVDeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNoOEY+WxUeaUmO6raD5E4J3+DQQFhPPALPWBMNzDKOXhQ8qhAG1CkBAgwcSlIDHXUTwdJz3StwXwdhSaeuzkxCbViXT/f7NiQXW98NsiPCeu4kyxlR3V1Kv7SqcIwgyzddZ3fULQWPX2f3P6CAw1zJhhgU1+cBVK3iIY8eCJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZknzVmwJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZknzVmwJ"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso641679e87.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780493254; x=1781098054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2h2vROgMXzHw1sF/4pXkeNWKYSy/sCswN0t0aO0Lclk=;
        b=ZknzVmwJv+xZP/AQeZ6RpppJQ7ghZ24HNJEfOZDOFXyz8HHGAXdeOkIHz3u8LFzLYL
         yxQrbnCJ4EZDPIO1MpejEWMDzNYOYM6R64tQQvM8u/flpi9RHiE23I4MuKf45OeHsXRz
         JHNA2clWC/w/TTbwdsxLhRTwdVePSpr8Ex3E8u4MkpO7rX+EuJ5rT9R5coH4AFmDicfN
         pcBrANNEF94TAEevep+oa2GbYaMQDZNZIAnm1Swh7cNVOi/SsOuZ0pJ40rKCi4/lMH8X
         EuYQ7//n/3TkylgeZ73ACSniNVkQxstZXgovVra7FFDT+7IUVjAQtUNKFBV7zPOHTLBn
         dBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493254; x=1781098054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h2vROgMXzHw1sF/4pXkeNWKYSy/sCswN0t0aO0Lclk=;
        b=SUcPkPhILAYA1BbLg0Qfz+6Qmir+Ss93aimqaOV9WipUuvDSYS/RmNI8WJhPwNTOax
         gC7//AzBGBz9ob3xbcfqU3Sq+/HBAEByOOuIH1GUL7TLeN/S6sIMYh70CUskuWf8HYd8
         VQBQhx67A1VtRmkkihsl4UAfoyIuWlMf2uKT4p2Uo6gUQ6oO6jDIIhdnM86CWO9/+D8q
         L+FgE0XgBK1gbzGILe07ML7wGEGGyWlqASvByod1R9QnL2ZkBu4eo9BRlPgmVH+JsxAL
         HEcRYHrf1hcF9Hi+mF9ZsMARPBzFRkfNHWu3pJERmCrnmh3z2qKiYgD3d3QQHFFNob23
         8Apg==
X-Gm-Message-State: AOJu0Ywdt8U0+Rgs44e9J6bzP3JjLGjUjGwW1UG8F6inPssfgYkbOHUT
	M+JKd7EFFEc1GEwkmX/Pia7vzYItApISj24BIVyf/NdAGj579Z/pE+uMi7MvJK+Nn08UWg==
X-Gm-Gg: Acq92OF+aqdARHul6vdaXPgfKcAdLvlI/KVZYz/2/nHb0wUc1k/SoY7Dc4WSbdDEcw1
	vDtd8XJ7eysuK3pwBlsM5JH2qZDf7iRUYSlE3Lpr37JgvlPoVKwMrcy/ekk4nxpGPTiIOCcG32p
	ZKS1hrOKcr9GSBT8GilBsNxM+VwI8n0EGItn2g1a6OVU+id4N2//hVC3Hwu/E7PGUgG46/eZ2IG
	uOc68EbsnU8CFbVpii+QwS4UTlzlhyHEl10P1N6Bv1MK8A/qIvHHUen52HtMC6yWQSOt5CUSzR2
	2b+P4hzrqPEIeRKPB3f5JQ/6AL3HOnfaUiM/MlJfgbSBDNPM+9FKno2WmJfZlzHn98WaiHq3Qnl
	rKZ1KFl3QH9JVb4/oN7P0jwi2pLEKUACM4vJfHCIqV42DCnTK7nbdmZgKoB3wa39qPq/tPZwasO
	etUoufSf3Dq8gajApZZMaRZBgbiG4Z9Ei+bxJ3hyNPwu+uOmeN1H9gJslluWqFsQhIZCxR
X-Received: by 2002:ac2:4bc4:0:b0:5a3:ff48:f7d6 with SMTP id 2adb3069b0e04-5aa7c7921f2mr967973e87.13.1780493253776;
        Wed, 03 Jun 2026 06:27:33 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed90csm653167e87.7.2026.06.03.06.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:27:33 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjunz@nvidia.com>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] RDMA/rxe: Complete the rxe_cleanup_task backport
Date: Wed,  3 Jun 2026 16:27:15 +0300
Message-ID: <20260603132729.423-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

The issue was introduced with backporting upstream commit b2b1ddc45745
("RDMA/rxe: Fix the error "trying to register non-static key in
rxe_cleanup_task"") to the 6.1 stable tree as commit 3236221bb8e4
("RDMA/rxe: Fix the error "trying to register non-static key in
rxe_cleanup_task"").

The 6.1 backport guarded qp->req.task and qp->comp.task before calling
rxe_cleanup_task(), but left qp->resp.task unguarded. It also kept the
responder task cleanup before deleting the RC timers, while upstream had
already moved it after the timer shutdown by commit 960ebe97e523
("RDMA/rxe: Remove __rxe_do_task()").

In the 6.1 tree, rxe_qp_from_init() calls rxe_qp_init_req() before
rxe_qp_init_resp(). Therefore, if rxe_qp_init_req() fails, cleanup can
run before qp->resp.task has been initialized by rxe_init_task(), and the
unconditional rxe_cleanup_task(&qp->resp.task) can still hit the same
uninitialized task lock problem that upstream commit b2b1ddc45745 fixed.

Move responder task cleanup after deleting the RC timers, matching the
upstream cleanup order, and guard it with qp->resp.task.func like the
requester and completer tasks.

Fixes: 3236221bb8e4 ("RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"")
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 709c63e9773c..171c0f4dcbec 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -781,13 +781,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
+	if (qp->resp.task.func)
+		rxe_cleanup_task(&qp->resp.task);
+
 	if (qp->req.task.func)
 		rxe_cleanup_task(&qp->req.task);
 
-- 
2.39.5

