Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9233DD51C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636759; cv=none; b=bxEhYMyvMjv6kWJj9afSQNp0YWkDfE424tZKoAUoyyiyXg2IS+SMGAUUHGMgQa8HmZaS02MauTfxegq4T+ol6vE1rk5EAQuzugTrIvbzTqAqlQp/93KxIVQZjYBeqo7UIZHvIjLzwm2IhnifhWaWdzy1rESLs5Swzpv3xMZGCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636759; c=relaxed/simple;
	bh=U1q2DgZVIv1pjekVdsy4WkcPcZzHcaC8S2CJ0AUGZvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub9JI32uWhMMAUBMbeYN9gT7iHXgXvsNDs/tnB0K18b1lngEHNYjFjL4bPVnL3iVGzKGW91vaMyey+gWjevtVQtJM4idoaBxHctvmJfAC5xsAuqSvqYq4zzMrccz/EfYEH5kZSYzJfSU44qLL+ewTNgz4Vv8OJC/zKWiZELgPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGDTOKE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGDTOKE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893DE1F00A3A;
	Tue, 16 Jun 2026 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781636758;
	bh=kNUVV42dGovCqlARfdhHKA5hbu+SZiEkX55SybJQUo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mGDTOKE8piB9VlFpKt5ADc2GQU3ahC2Xtq08JtCf2W4HDmis786hgpua58S5jloI6
	 sN+5p6sNQfN1G3NkbXci+0t3WZTlNxuxcBUbq+J0QV2JSYFWVyf6F7lx5OC9j5NrTg
	 ogKh7ku8TdklgJyYkVm/ztwaEz7HiRrfQZ+p6Au39Jk0itTbsS+MEs/6xj+ZrxVPeX
	 LC0nZDlCDo9SLVY9mDLH44e8Cd8fj9m/QEIG8STiri/Xr3xt9jaKVga0tCRNOHwlIu
	 ctoRsEUswCWks6Ns9K/1n79u4P/ySgWISC+ZTNOsoXBzxX1wPy8KA8CBWqZ/fOLKD2
	 XxAJbGj5VIguQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock
Date: Tue, 16 Jun 2026 15:05:55 -0400
Message-ID: <20260616190556.3487341-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061525-groggily-boxlike-3e46@gregkh>
References: <2026061525-groggily-boxlike-3e46@gregkh>
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
index f4a69942780f61..b5464a8608ed4a 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -633,6 +633,12 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
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

