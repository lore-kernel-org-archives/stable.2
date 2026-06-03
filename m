Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3F3CF94E
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489156; cv=none; b=Pp5EhrKyDbvWV5nMg7v8umioSf/0aieZyEFwqNzumIKv5jorTmzxr6R8fzHRs4X/BtHIePkfXr+iDLZ3ff5Eqscln4XvIBMsW6m+5uAyxvAPvpcwK8HZ+7yZqQOkY5GZrNwvhzIyRUa0UAJ4OmOMV0NcQik7M11u5m2wk5N46oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489156; c=relaxed/simple;
	bh=WGZxmN+LhA1/CrDAqVpmyUdBdPA47xdXFTjhbPAJrnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EoyZf4BgIfE/vo09tNnAeZzUsNYJqWybM5Vkimd2d55XHi3AtQWLxh+EejKyFJRioZJPOgnP836YfJ4L3gDdrI0mUA0lSl0pbl+FjY6S5uYwL5kFyDuy8sE4FSiCXKbar7Vo82C9mY0hIo8zAKbgMZ/luF+wLsbziQAxcZ2gJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePxJFM2u; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePxJFM2u"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa68d9d56fso3970249e87.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489151; x=1781093951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51Q12HcwJac0a3/dr9D2JQ4mIHf+pK3eMABlg1vA4ao=;
        b=ePxJFM2uEGbIce0d5Vke8FQ1zpC+vp4eMPwzLTSc8wCw5n8ssvS4HhV1iXbHGoQV20
         +txL4VIEBKwGSC9Db5XtN0d1KfQ568sYYCW4hh8FM5bpg9gZv/DilOoKy9KSEB/4ZJbQ
         eKRqA6X1trXeaP2zlq4YlUL4HeHxJ9KYHrdrq07hHOn/sC9kn+OJW8ams2Sbav69QZzt
         J4El+bqlurDB/SFwfJca5Wi9DsEF15A6TwO1HKZ5vLX1j+wARdbAG4CNybfTHeTN3UWk
         19G5eM4dLp2+b8MMik5gr7BJotWechHALaE2Dpn6lnt7UiEny6RhtEy7e7gOC8TRPv1U
         AgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489151; x=1781093951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51Q12HcwJac0a3/dr9D2JQ4mIHf+pK3eMABlg1vA4ao=;
        b=FhsDm7VENT6iOz+dUYG5DieXmhpyRsxsMUyJTb4k2fhQA/bg/cXejBS8Yffs9huW8b
         tDYgYWAh6NpqvvcffveLzd1JlL8hN91CQx131JNTyIQWjpDm5a2tQ7wFdUcifhqz0Xc/
         4jDM/ycZJrQ8ttEPCva6lQgl7/BdritewicwYmH4G7x0odt8T0FTDAPdKZ1M9cVCjTFo
         lAsWvfRa3xUxD2AAo6I63bzHKxtEB7dX+kN0jmBu5RyJYn7ZFRZMXKh+QgevTDASpsDv
         EM2YpRnsyV979D2IlDQn7l9QEYn+2Ai8HD14PP2cxM5r3YsOb81wmdavnOEcAg8znUDL
         nckg==
X-Gm-Message-State: AOJu0YxIFlzIOSryDqncnzsY6d9jDoj5UBTkVh2V5pKzZQi/1AmhcWRR
	XKuPG28iUcYOVBpZyxR7wyjSQorfN1q3DJLRTlW/OGMw7y/UBsTXWMNtQ9Y3AqutEONV9Q==
X-Gm-Gg: Acq92OE9q8X9hXt+SMbVLH0o05eCwgNz/MbCrA7+4qyFLGQ80eNrIZgt8svnrsISbi+
	hD6Y4w8AzW3xGLu9G8SX7mrNrAyeqqxGtmh6mSWWovRQKlhaUi5tVRFkgjEOReRtFnC87PzksAs
	YJkc4mV+Jxld4vIBA8RvTGFUDlEPklpBhrjWTdd7fHDY0rUj8gblzwEK8hr7qEh7KhQ8w7jcZVT
	rYgiWFm9qvqh/UdYtwghdhWX+BMyrJ1N0f0CU2lyawlboVn1oxoW5/LdU1S4BWxaXuA+GLKa4Uw
	/kXUu1daa4G7HdmvOsJfn6xFWRKcFirAMecorIVozp589KouO+HQ9h4kFR5tN7nmpv+Jc0Xa3/b
	3uMKWRHTY5dl64lcWKvJHnJ1YeTPyVY7WPc3SnXXT6kfk3gLDLaWCb71qRI3YntQ7nmTOE2QT2v
	DqyHvloq3ET3MJEYR+vKTEqQyjzuuY551lhrXZES4i+u6+WSPHLPuH+7waClwYeuhpW1AC
X-Received: by 2002:a05:6512:65c5:20b0:5aa:6586:ce37 with SMTP id 2adb3069b0e04-5aa7c1510eemr847865e87.44.1780489151196;
        Wed, 03 Jun 2026 05:19:11 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed659sm620125e87.12.2026.06.03.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:19:10 -0700 (PDT)
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
Subject: [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Wed,  3 Jun 2026 15:18:45 +0300
Message-ID: <20260603121902.274-1-vlad102nikolaev@gmail.com>
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
[ Vladislav: match upstream cleanup order and add the missing
resp.task.func check. ]
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
v2: Move rxe_cleanup_task(&qp->resp.task) after RC timer cleanup.
Add missing qp->resp.task.func check before cleaning up the responder task.

Backport fix for CVE-2023-54028.
 drivers/infiniband/sw/rxe/rxe_qp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 4c938d841f76..616efae0c09a 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -760,15 +760,20 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 {
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	if (qp->resp.task.func)
+		rxe_cleanup_task(&qp->resp.task);
+	
+	if (qp->req.task.func)
+		rxe_cleanup_task(&qp->req.task);
+
+	if (qp->comp.task.func)
+		rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	if (qp->req.task.func)
-- 
2.39.5

