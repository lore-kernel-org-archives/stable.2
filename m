Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CA34A79D;
	Sun, 13 Sep 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789308715; cv=none; b=iCe+RUfiBb3WLquvwtGv767FBsYZAhNBuooVtmXIcwzas/9KjHVL0tXunS6/wtnq4uazgmjMHOmgRXHEdDoCeO0mt2Nmf5g+8TcXpHroJFR3+GhvbC1LJwXR8kOStN1x/+RKAv33mnKjLs0JijcvH9MWz4ONw8MBmpDPs+0+uRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789308715; c=relaxed/simple;
	bh=mJnOZtn5cuGbI2017nzUjEmKRHaxUcFGidgrANxD3uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2JyEKxw/ql5bxHiuA952VaLCBNfwisaffRI6CjpahTtoYpgl69qXdGrBQveotOFfWJVJlgU3o4FNkGwX7xkhqpN99DNY97nrkhj9e5TrjXVDrhHe7RsnHlqftWFabN102ZAao1jz++7OMouDTNOT3R57SlMwCTrpjRcd34FCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Tvfjnhzs; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Tvfjnhzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=MK
	a+Yb5kJ73XpCnhjg1Ux1w8fUhPw2uP6nQz6HAv/h0=; b=TvfjnhzsoECyoYtzLU
	jY7Zy/4G5uhlnOGDG40g8AzYx5rLn7KZnpApQ+IuIfsojhvIWJQNaaH5vjIaeQMX
	kOgucVmVODkTphpSjUB+8G7pT92XQQyuiuk4ZeYxbCS/qkNAx1BWfLe0/LtTsQQK
	yib9td4CJNUtp97NchPIw7ufM=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3d7DirqZq7EjeAQ--.56354S2;
	Sun, 13 Sep 2026 22:10:43 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] sched/core: Propagate pointer hash errors from PR_SCHED_CORE_GET
Date: Sun, 13 Sep 2026 23:10:39 +0900
Message-ID: <20260913141040.2338964-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913141040.2338964-1-sh_def@163.com>
References: <20260913141040.2338964-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d7DirqZq7EjeAQ--.56354S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkJrWkKr1kKFWDGF4xCrg_yoW8ZF18pr
	s8W3yxKrs7Kay8KF18Aw48JFyrGr12kFW3Wr4kJ34fKr4FvryaqryFyryaqF4UKrW0kFW0
	yr129asIvryqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piNJ55UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwgMoh2qmruNQpQAA3a

PR_SCHED_CORE_GET hashes the internal core scheduling cookie before
returning an opaque identifier to userspace.

ptr_to_hashval() returns -EBUSY until the random key used for pointer
hashing has been initialized. However, PR_SCHED_CORE_GET currently
ignores that return value.

Since id is initialized to zero, a failed hash is therefore reported
as a successful GET with cookie 0. Cookie 0 represents the default
core scheduling cookie, so a task which already has a core scheduling
cookie can temporarily appear to have the default cookie during early
boot.

Propagate errors from ptr_to_hashval() instead. In particular, this
allows userspace to retry PR_SCHED_CORE_GET when pointer hashing is
temporarily unavailable.

An early-boot x86_64 QEMU reproducer observed the following before the
fix:

  CREATE ret=0 errno=0 (Success)
  GET ret=0 errno=0 (Success) cookie=0x0000000000000000

With this fix, the same GET correctly returned:

  GET ret=-1 errno=16 (Device or resource busy)

The full cs_prctl_test also failed seven cookie assertions on the
unfixed kernel after PR_SCHED_CORE_CREATE succeeded but subsequent GETs
continued to report cookie 0.

Fixes: 7ac592aa35a6 ("sched: prctl() core-scheduling interface")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
v2:
- No changes.

 kernel/sched/core_sched.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 43e0bde3038e..f119a2973ca8 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -177,8 +177,9 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 		}
 		cookie = sched_core_clone_cookie(task);
 		if (cookie) {
-			/* XXX improve ? */
-			ptr_to_hashval((void *)cookie, &id);
+			err = ptr_to_hashval((void *)cookie, &id);
+			if (err)
+				goto out;
 		}
 		err = put_user(id, (u64 __user *)uaddr);
 		goto out;
-- 
2.55.0

