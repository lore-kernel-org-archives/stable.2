Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A73806CA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609196; cv=none; b=AOHaAHUSFFcTGVITLnNspkgtM4j0SoVbpbtiZbKkBOcJQgVeZzjhVI5xM4odKv14xOAqKw9i2l5Tn5aCZ97IaC68t43gcd7GvYsp10SuffCS392yyoKhB3Ay3Y0oRhdoXy6Te44iUJ5Vd9kPbzHLnLrsBb2K60zQZC9Dvf6wzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609196; c=relaxed/simple;
	bh=Ygol45OH1pAMZTJo3QlBTRO8Os9792LTiZg73tIGH6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcbsuvpgWtp8DzEi3Rsz7a1P8DcsQvDEEBKeZfMEkETCf9PerC2OdXvL+IyJYMPqZdkL14aGsNV0z9r8bsQATRm+aiQosU3HqNZzh7HPCq/2PxDl6ItAeraS1yNY/cl9ZaGjcK118SKcxCcGgrQ76boqD2C+rXdOF6SKLQQF4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyzo6CUi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyzo6CUi"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51bfb91795eso6757921cf.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609192; x=1784213992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZNJe/t21+Ulkw7brHFLFuQznLcd456IxIUa0gACorQ=;
        b=qyzo6CUiXh5WgfzwvcIDdmwCJyT7kj6APr3GmMwR7mJf5tOO7J4+/QXX4xxxOT5Gkj
         Yr4ENQnbfPnvbs2iJuw0VrdnbqZDlKbQEPrkm03U/6thaL5Ey/oWRwyhz/hVyGTp8+gX
         Okilr55D+CO7SyuCNPICsxmowpjadM9OW0VtCS3usexTGt20nRol/UMzo17uKGE/RBUU
         HKwbQUjXIH7pxw3hkKaJ7yLAHiWSFJfAzfTftgoR65LNr7uw6Vhso2d0gcuWBtlXIlQz
         Pk094SWvResgSqSStXQirOgFUQoIkbm0MlaRDOz0L0uXFmvdS0XDqbCAZ35nL7HCTBcr
         9THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609192; x=1784213992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZNJe/t21+Ulkw7brHFLFuQznLcd456IxIUa0gACorQ=;
        b=I7ws+TYdl1mfKMSA3RRJcYJ3YS77LRWHibIH1AzRyE+haKqy3ATUvESPc9npuRKVxT
         wIjAU5ZeeC09ADqxY3Akm0L6tuP508rhtGbh4uqAkYGTSjEs384Jq9kChliVQn6oghYb
         ebLT+3ceysTjw3i5QCio0h52jLgNZy67ri+HmdUcBkDnc3eImJ6hQkdAtQQyi7VOSq2M
         UrahrC4JFwrrIPu3sJ/W23Knw2EXEcPGg3HjZu1Cg5KVNsmc2riW/OC2Xm1fqP7Ya/sN
         RySTRAcIt8Y1+6rsjdxpkeLnyOAUmlq9F5ErSDWw0zvSWjH9RdraTB5tfxqrIQM7Hg0d
         LPPA==
X-Gm-Message-State: AOJu0YzeIsBvRHzlS3yyEysVvfZ6tLTJINBOR9FqTdwZzfKlc1eO4zVT
	hWsPiw2S1B6xhDgohybd5JeBZtXNRfYpgDFnHy/Q3XGFCik60EdekMuzEaanFfnx
X-Gm-Gg: AfdE7cm26Osu2fcQTmGRtDyH/Z/a/QgVCxmlf0gyaFdfno7hV6OKQZgx9TMCBd1vFK5
	+DpRLKgNeA+xBuDERD0AtPUKFKKPckZgUjrwgfpzOZuBqNhFoi/67I3slsoexL4QHt3IHdWfhe2
	bfQzBoyV6OQzo9DEXJekZa6HW882Xc1nbXDaxJzDBSK5s4O4owanqJlPYojRShoxByrQiEytGXr
	4RTJBgsLs4lnIG8B8dJsEaxXehFhjrFC2Dv9FsuJ+GdCkcPvVFgF+GMAt0p0HTwuQjGFT2w4gmU
	erHLyb9wHHe+I0HLORBSuly9SFCRKSnTYHMEJR1+TGVBDxTRQKovfHJk67unB71Getk1VImc+fy
	gRQ2THLJZwYugKorNs1Ezg8WNsPnxHL88Yo67GVHJZoUZ9QYV8ILqAOMe948sZL/jMLAgx/YA4d
	+mjHtFCKKW6pQ9BTDf63pQXhgdS6fjB99KrXjhQFl99wmMA+85Rx46LI4Q2okXwsZvZoeXitEhf
	oi1/TLgj3MrP8AE2FwxTaeJNZkzKYsE7NnPS56o0jkB10G2GDgTcB6P4tQpyzShQg==
X-Received: by 2002:a05:622a:44:b0:517:6b9c:58e4 with SMTP id d75a77b69052e-51c8b4d5940mr98315321cf.51.1783609192014;
        Thu, 09 Jul 2026 07:59:52 -0700 (PDT)
Received: from sm-sl16-1.lab-skae.tower-research.com (static-71-183-126-99.nycmny.fios.verizon.net. [71.183.126.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm20374506d6.34.2026.07.09.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:59:51 -0700 (PDT)
From: Sid Kumar <sidkumar1@gmail.com>
To: stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Keenan Dong <keenanat2000@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sid Kumar <sidkumar1@gmail.com>
Subject: [PATCH 5.15.y v2 1/2] rtmutex: Use waiter::task instead of current in remove_waiter()
Date: Thu,  9 Jul 2026 10:59:48 -0400
Message-ID: <20260709145949.3640783-1-sidkumar1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keenan Dong <keenanat2000@gmail.com>

remove_waiter() is used by the slowlock paths, but it is also used for
proxy-lock rollback in rt_mutex_start_proxy_lock() when invoked from
futex_requeue().

In the latter case waiter::task is not current, but remove_waiter()
operates on current for the dequeue operation. That results in several
problems:

  1) the rbtree dequeue happens without waiter::task::pi_lock being held

  2) the waiter task's pi_blocked_on state is not cleared, which leaves a
     dangling pointer primed for UAF around.

  3) rt_mutex_adjust_prio_chain() operates on the wrong top priority waiter
     task

Use waiter::task instead of current in all related operations in
remove_waiter() to cure those problems.

[ tglx: Fixup rt_mutex_adjust_prio_chain(), add a comment and amend the
  	changelog ]

[ sidk: Replace scoped_guard() macro with raw spinlock operations for
	5.15]

Fixes: 8161239a8bcc ("rtmutex: Simplify PI algorithm and make highest prio task get lock")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
(cherry picked from commit 3bfdc63936dd4773109b7b8c280c0f3b5ae7d349)
Signed-off-by: Sid Kumar <sidkumar1@gmail.com>
---

v1: https://lore.kernel.org/stable/20260708150527.3212183-1-sidkumar1@gmail.com/

v1 -> v2:
	add a backport of 40a25d59e85b3c which is a fix
	for this commit.

 kernel/locking/rtmutex.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cf72ef77bfe7..f79c9286c7c0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1500,20 +1500,23 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
  *
  * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
+ *
+ * When invoked from rt_mutex_start_proxy_lock() waiter::task != current !
  */
 static void __sched remove_waiter(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter)
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
+	struct task_struct *waiter_task = waiter->task;
 	struct rt_mutex_base *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
-	raw_spin_lock(&current->pi_lock);
+	raw_spin_lock(&waiter_task->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
-	current->pi_blocked_on = NULL;
-	raw_spin_unlock(&current->pi_lock);
+	waiter_task->pi_blocked_on = NULL;
+	raw_spin_unlock(&waiter_task->pi_lock);
 
 	/*
 	 * Only update priority if the waiter was the highest priority
@@ -1549,7 +1552,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
-				   next_lock, NULL, current);
+				   next_lock, NULL, waiter_task);
 
 	raw_spin_lock_irq(&lock->wait_lock);
 }
-- 
2.39.2

