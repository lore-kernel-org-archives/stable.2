Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F42356C6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639577; cv=none; b=arKr42DEPHineoih+Un9wxyu7kgBjMB+N4499rrxDFXdibS8xx1lrzEZADm36LXV2u6U2tNoomN/nN8ZpxbRKSr0gphJ6A8FjH6pTZcbTvprlzb2AAnySc3VGG37ujVW9yNbiYBgd7i1nFzqMC+MZkxMZtb8ZnudkIaqV2gjoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639577; c=relaxed/simple;
	bh=36u5z43Y4yET9L4B45tDjUygTcKerVhoLNRoj8NL2y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw3fRIMlkEOUj5EPFo/3X7SELHUqX/LxCVWnyIuEhqukxDt5CC1HRqJEaY67NdSzilvB/UbWeootFD50FqYkn0HDvpfD1FljoXSt81NmoWUNM1Xq78tVJkF/U2Ghl/M1GP9IueHs9KYQlrPcSgG9DN6yVq/j3ZmptYa728UketI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtNA1SEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtNA1SEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1EE1F000E9;
	Tue, 16 Jun 2026 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639576;
	bh=tRYxbkQCgYsSdLp4X49L/g+w6hxo18wZzxuMrCVMOFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jtNA1SEWhaZJHu1iBanQ3lWqn9JZuJFaZK0DeDyjC3yrbvrX7e52Q3VHpQMtGZzfH
	 ElwaYjPvGvDIPWrLvqUSoQu6csbA6/kXgrV/mfr3l1ddmfqjG+cYFi0Nk0dwlt9Xiw
	 uxjcZDCue+aJIn+FYMCuj8ezdnddgCHSlFF8uRw/+CEvE1qrdm4WpxP4PBCsnn9/ZJ
	 xUzmVHZlsjd1krDRCjULpS2bfpMPvyOH+LUQy4K5OwktR28ctcQ+FMaIksZTt6fUi4
	 5YFBXlanUC4cOXQofm/ElCTC8gOl/92BHqhzz780uLOt4GRiF/xJHG1BSaUCgDC70+
	 wsvvK5/0Y5VxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock
Date: Tue, 16 Jun 2026 15:52:54 -0400
Message-ID: <20260616195254.3526787-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061530-freefall-hardware-b907@gregkh>
References: <2026061530-freefall-hardware-b907@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ji'an Zhou <eilaimemedsnaimel@gmail.com>

[ Upstream commit 74e144274af39935b0f410c0ee4d2b91c3730414 ]

When FUTEX_CMP_REQUEUE_PI requeues a non-top waiter that already owns the
target PI futex, task_blocks_on_rt_mutex() returns -EDEADLK before setting
waiter->task.

The subsequent remove_waiter() in rt_mutex_start_proxy_lock() dereferences
the NULL waiter->task, causing a kernel crash.

Add a self-deadlock check for non-top waiters before calling
rt_mutex_start_proxy_lock(), analogous to the top-waiter check in
futex_lock_pi_atomic().

Fixes: 3bfdc63936dd4773109b7b8c280c0f3b5ae7d349 ("rtmutex: Use waiter::task instead of current in remove_waiter()")
Signed-off-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/requeue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 60b08247b07dd5..8cf1234be584d7 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -629,6 +629,12 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 			continue;
 		}
 
+		/* Self-deadlock: non-top waiter already owns the PI futex. */
+		if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
+			ret = -EDEADLK;
+			break;
+		}
+
 		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 						this->rt_waiter,
 						this->task);
-- 
2.53.0

