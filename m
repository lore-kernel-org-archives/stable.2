Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DBA4A0901
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049182; cv=none; b=a4BtCKOAtI4f+/MrqoG9WgVTLjAc2O8CD8tJCWVj++zcRSwkPTXUUZnAhlNVIob5kPB3TbieJUd66hqxP1+5OZFD5q/CWtvT0gpdQ12PsdlY0qP5Q8kOtO0vT1+urbwZjNLUBJWVM2y0/YboIQx92Yt4nasE8MmADUpvvPaq/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049182; c=relaxed/simple;
	bh=wHSXhckE1oKGKHXGfILcDE3jzmNO0Awb9OaH7mXmZd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6Wu6FV+MIWyisxJntJZJfgHwzvCTWZiraITTrHysPUxjIcSlGjs4EqYqmTJCsm54rJ5G2BIYevqzM30SK9fiKcSDBO/vnlrS06tDn+Ajq/WYJBI3+UEorYZq3kMd/ki5Djb/w2VLkwVpXTI8MU1fSdOibeaHlp2sUJMNx5ZyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0zYawO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0zYawO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5B81F0089C;
	Thu, 10 Sep 2026 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049181;
	bh=y1nz7A+uDNVDDBhNqRnB75K6YV1wfp+PepFULEBsWcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0zYawO8ssbyAOqaxnWinZw5jtLIZd0s+/2PhT8csUqnCbe0CbGsS7pOluak1+/Nv
	 Lj8D/XvBLDkNfpnD8iM0Enl4zAN/mfUtoWGQ5Sl3nyiEtyQdQP3N49+On87ZEVy8KF
	 CFzf6cCodASUOQUcz+RHHtR6ocuskp8f7xJIYkELvTzn3+pX0xOmoSLWShthgVPUnN
	 zI/Epz/XmDzufJ22zYoM24D+Qbo5A03D4VQvMEs6xhUKjuptiGoTy5D6gk+IfxUtYk
	 1D/WKMJXJkSeQeTRuFFYUH8ILOGXC7EWocKlqUKIoOsF4rAeyUrL6ZXuzMIU3UDOqr
	 MwAN8AyIKTrTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] futex: Rename mark_wake_futex()
Date: Thu, 10 Sep 2026 10:06:15 -0400
Message-ID: <20260910140617.564852-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910140617.564852-1-sashal@kernel.org>
References: <2026090826-jeep-tassel-64cd@gregkh>
 <20260910140617.564852-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 95c336a7d8f0c1c34ee99e0162dc64d283da7618 ]

In order to prepare introducing these symbols into the global
namespace; rename:

  s/mark_wake_futex/futex_wake_mark/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-13-andrealmeid@collabora.com
Stable-dep-of: a3b8d46fe401 ("futex: Prevent rcuwait use-after-free during requeue PI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a404c8226d728..40b9c5f6c0d74 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1532,7 +1532,7 @@ static void __futex_unqueue(struct futex_q *q)
  * must ensure to later call wake_up_q() for the actual
  * wakeups to occur.
  */
-static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
+static void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
 {
 	struct task_struct *p = q->task;
 
@@ -1692,7 +1692,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
 
-			mark_wake_futex(&wake_q, this);
+			futex_wake_mark(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -1808,7 +1808,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 				ret = -EINVAL;
 				goto out_unlock;
 			}
-			mark_wake_futex(&wake_q, this);
+			futex_wake_mark(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -1822,7 +1822,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 					ret = -EINVAL;
 					goto out_unlock;
 				}
-				mark_wake_futex(&wake_q, this);
+				futex_wake_mark(&wake_q, this);
 				if (++op_ret >= nr_wake2)
 					break;
 			}
@@ -2368,7 +2368,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 		/* Plain futexes just wake or requeue and are done */
 		if (!requeue_pi) {
 			if (++task_count <= nr_wake)
-				mark_wake_futex(&wake_q, this);
+				futex_wake_mark(&wake_q, this);
 			else
 				requeue_futex(this, hb1, hb2, &key2);
 			continue;
-- 
2.53.0

