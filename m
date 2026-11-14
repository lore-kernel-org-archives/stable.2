Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670558;
	b=3qQA/93QZpuz1Fqrv+OTtlOjIfemUY9Gl6bdmZP+kCTTchj7HvVs2x3P8grcAyJU1fzh
	 bCmuHDLxtxeMplgBxRrih5UHd6soJzyZhhfHxrqwVJCrZjUsMunSd1bXC5iMB9CGP8MWB
	 Q4xi+MagCVlhZWShze7X/2zL5TFsH2pdCgwYbArZO2EskcCj+WRPjUmPRUHNbOSe0muOR
	 AFaySqz+8hSlpHov/xnuV3H9PAWoXhK7hxSGb3LCKaarajDoFe726eDOOSSQSDIQF/oHt
	 DLKrMOidCa/59mxkWa0ud2AnpyZPO1Gu8kDxHe6DE/NK9OLck5afb5aEhnZ7hHvglSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WMlf2lM1RxDiH5Rewe6O8b5zNDEZQcRi4dZR19CYlA4=;
	b=Vn8pOp3NlO0XoiaLUYAcku5Zq3sJhyDgcU9qSJ7nKvCzYjt80LPyxdOcd2oUT3qPih+5
	 7R5E5JFMFvlUtqo3aU0Jt9BCLQsCDxbdfYLuLvQasBOQHJCgU0ufgFu/3fCH/6LqgLORh
	 PytXeySdrzfAe+ns+RDDWz6kHf+RH9DxoMoQh62mvU6jylXIxFcEL+L5q4zq1UULgH+Mk
	 QSGRz4Fw++9MCgQ7VXqv6cjPBFPIizD/sL8yqbQb1JnufRZuIV+z34AwaOyYmkaMIcYiQ
	 Cdym3nrBh0MZamridDO1ajhAyRppOrtfCq8XOJziAyisXxqvfgRODmNwH7m7EiAqD8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H63zn4WF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BD606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H63zn4WF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0331F000C4;
	Sat, 14 Nov 2026 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670557;
	bh=WMlf2lM1RxDiH5Rewe6O8b5zNDEZQcRi4dZR19CYlA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H63zn4WF59Odehhd9cBJXtMMK4eX8u0/qxpDraCn52HkJQTyM9YG1Z7dceJ/Wu9vp
	 bmcXqzfsFSY0DiAXxxIU2YcXzRlvy3lCZHQBcnFg575Wf6UjQJ5thDt4GesHCRv9tn
	 D+l82LxMRcQfX/XkeXfaTP3JEJQ0VAXqGYY24uHPhjWcUjT/+Fe/LBOF5ByuVgNp5S
	 Gi7ztkoRmVzTaA8AAn8ycQEdPr2ajKedWf2q3DUE3nepuy0bFCA5TN3MGdWFmiYMGI
	 8RFFjVtO6q0ALtMqUNu+ZbOQ2ljTH7yGvnVHqOtUcv3TC4/5exxlNMbrpOn3jGuHmw
	 2OPxusYB0qn/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mm: document mmu_notifier_invalidate_range_start_nonblock()
Date: Sat, 14 Nov 2026 10:35:54 -0500
Message-ID: <20261114153537.3690930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202336-failed-5.15-6d65925777ec@kernel.org>
References: <20261109202336-failed-5.15-6d65925777ec@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 7ced098fcfe596feab3cea4f40128b0119c7bf1a ]

Document what mmu_notifier_invalidate_range_start_nonblock() is for.  Also
add a __must_check annotation to signal that callers must bail out if a
notifier vetoes the operation.

Link: https://lkml.kernel.org/r/20230918201832.265108-1-jannh@google.com
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6d65925777ec ("mm/mmu_notifier: finish non-blocking interval invalidation on error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmu_notifier.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 45fc2c81e370c..786f0f8707981 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -461,7 +461,14 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
-static inline int
+/*
+ * This version of mmu_notifier_invalidate_range_start() avoids blocking, but it
+ * can return an error if a notifier can't proceed without blocking, in which
+ * case you're not allowed to modify PTEs in the specified range.
+ *
+ * This is mainly intended for OOM handling.
+ */
+static inline int __must_check
 mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 {
 	int ret = 0;
-- 
2.53.0

