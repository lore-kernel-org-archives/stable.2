Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749743C1D53;
	Sun, 13 Sep 2026 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281359; cv=none; b=QqCGdo1aphsM487pVL1aZpuJnzGTQ/hLe8R4JTn8MR++4wHygwR/aZseCDBMLcEUydHpY9A8fw0yW6/3u22bgO1lsSMj3q9OgRL001BhcJAvszFTSUMXq2ufq+ky9XUTM4WTVnE4dTltEFEIc6vJLNuz03wvxORWxgJPDwspMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281359; c=relaxed/simple;
	bh=K7fPKCJ+Xx+ataxj1VxJwzwRhB9AfyKsvQNjgHLN2qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjazpo8A4Wy85hfedfuRmW6W8mu95LBbykYxZeWMUafsDCxw7fTZ1C0JyiismIxZ7qD7mTP073AfQOOEcdPlUnw0rYY+YwGCi+C7+hpcu9AA1FcGdXSl2/ZeRMo3nDvseY9XOEYu939lZiySdqyUiwmB4YWfhde/tSqTf9sco0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QIVUTa90; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QIVUTa90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7C
	flEv2FrrwTLg4pOvkoWVb1FkOEdZ9mWjEaIhtJj4c=; b=QIVUTa90da21RC7Tgi
	qL+Jr19Jzcpqgne87ZMrzTmHLokEaZdKnx4FlezKWgQQbWB7/BT4YQYG+Ie/IaZp
	mXJsxFt4vQXKf/8OcvroTYP4+S+A7KB+Np6aoXbnCaaiDAVnlTHg4I0uOgzb5vfm
	WSddPwbEhbuo6hQP40CQTvwTY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnd4cARKZqCcuWAQ--.26522S2;
	Sun, 13 Sep 2026 14:34:41 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	shuah@kernel.org,
	chris.hyser@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sh_def@163.com,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] sched/core: Propagate pointer hash errors from PR_SCHED_CORE_GET
Date: Sun, 13 Sep 2026 15:34:38 +0900
Message-ID: <20260913063439.1513107-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913063439.1513107-1-sh_def@163.com>
References: <20260913063439.1513107-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnd4cARKZqCcuWAQ--.26522S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkJrWkKr1kKFWDGF4xCrg_yoW8Zryfpr
	sxW3yxKrs7Kay8KF18Aw48AFyrWr12kFW3Wr4kJrySkr4Fv34aqryFkryaqF4UKrW0kFW0
	kr129asIv34qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRrR6wUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QFVtGqmRAFu4AAA3O

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

