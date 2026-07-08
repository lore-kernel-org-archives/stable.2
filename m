Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0140928F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523134; cv=none; b=icikIYm6Fx2gBKtiWoKBDMnq4NtcYcGyxI/zohC03ftdGJ4raJ5Ol47Je8lD7o3rKAIwopGYJpSA1KuN+rNA4jA6S4yzSlAsSgN1ARVMaAvDnShl3o65Z2yLWKzU1QoZbivNZhYHalT88U+Nop1XmGr6VWJ5YJSQrYs+70EehVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523134; c=relaxed/simple;
	bh=1yVTfUcNgUS1ulpZLy9An3ShkB5C76Jexu6G3Gsalxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXBp5zojNqviZ3RPBsS/T9H0xcdaI7vUywwqP0axQPQxZMWc/nSzFho2HY+dtGr/1x4TZjEsR8l6sOWPmC0xZP7spbpLwp9tcMrrwtq3fBzfAWRmDPdBufkkeM5dWYtyxqiMrHGJVJamMxGFkMsuJrS9ybt/umccIjtoTm8O0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndT9M2GA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndT9M2GA"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f18d92172aso10147916d6.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783523132; x=1784127932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLVhwAX9nNwgl4ODyEb98lq7vMVDHRccpj+VTBcaPiE=;
        b=ndT9M2GAdDvMjNrlwqhX1E1vFOrOuj8cA9mAkJ0LkTfw+Z5Uvrp3GQLD4ORrcJ5E27
         HCiwQqzd66Z5Zgr6fWX0b/YZaG7p97YWepKs0RVwhL5sBFvgJ1CkBIskvr0Lhy/m2J7N
         BRhIB3IdNocAjs6QE+C6/Y/BDJcNkxhwxDYkIUd+EEw1sxURSVMnamlzImNbhjgtbcDQ
         pEHA+F9viCUDUlyCLKf61ax9w9q6bX+eHU5rHubwsxuoTXZIbDf7+az5zG843tPooxZw
         1cHrfrJHll2MxXTEamDzwNVNk5W/aQYVuHGJANMScmN3heWZS5uR1GtpeaJKadUqVOXm
         iLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523132; x=1784127932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLVhwAX9nNwgl4ODyEb98lq7vMVDHRccpj+VTBcaPiE=;
        b=aXIFeLUG0TL/ofLUxWAZOnhDSmMV1S5LJ7+BWpaCM9oWD1yjiFLolbrCDdg32ZXb1l
         0gxcS3jM0dlL0AXO9f3XNHC5Gsbiafh/bFdhS2jgfLQFWEm635CfoJXi58Ti0CmxLKJO
         argW9hWf6FbTt77mSikM1m0QOqcnQWr9Pqs99LX6AQ6hP1vlvjTzx9CatcErqQ8wWZRu
         rs9JTfgU3DOPdqzrS6QryyKI+Qzwdw18BE3LPsismJeIxZNBJ3EJFFCmpQNEolgS/Sdj
         SOUieWa3cqXqqWw4oSoDAPe5r5ApWrveFFJW2HM/jbUgJRVhvnmHwjiKbvhGAvRnYnuz
         zegw==
X-Gm-Message-State: AOJu0YwLeZC4jVRcww6MtyNNTEOLpTK61whvJ7HozNOKI91IhyWV0gYG
	JXLU9Mnx0whIGaaqN6uR/GJTys/CrhJHSgzqGlis2bOUScjuGMU/CUJNFNldU0Ee
X-Gm-Gg: AfdE7clHdOpP9nIk1lWlN16V8cuCsQlVzQNVTkS5pioCQdKreX3N9XyesdUAYCU8Dwz
	qGgaAov6fA6LKIlx/Remhg5SSZ4Cj1ZlWSUfIWSgs7jJFbBcPchgpSRgVuvWfRJlTr0REq0pirM
	zA+77/DC7Hy34lDQTxED9c7LfdaQOfZWbtRZA0v0nlSCb5DgtlxzE3bNYkFByWo7yyBbZkvMEXB
	QVTKYs5EkxEAr2iRh3rUIHIt7afNIGLjFpye1I692o/uGGCMWJGnI4gEU8kSFYx1lJD++xrUbGD
	gXycCEaAA2vZ7APlyLZ3bKE8l0utqVA0s/gsTPnVe+2KYv3504+p9NmlXaaDoA67hiJl1WxSUBb
	MzMsKozeFoyuR5DoUz7E56MzM5Inxl2RUod5rsE5Bo3++kz3WB96YOzNBswxf7qU2oAhaix6J6Y
	eMDLcRltWwePJFxiKQKc0ywTHncrOHHrJ1g5gw9yVEEjqZEkCYluxkL2ctGND42otq3yeo6oZpF
	iLbsHdNceH912Jq2NXbFqfNqu93RvA89Ik/jvYvB78f4LBCgs38whk=
X-Received: by 2002:a05:6214:e87:b0:8ee:e686:1b24 with SMTP id 6a1803df08f44-8fec2a48035mr32916256d6.45.1783523130869;
        Wed, 08 Jul 2026 08:05:30 -0700 (PDT)
Received: from sm-sl16-1.lab-skae.tower-research.com (static-71-183-126-99.nycmny.fios.verizon.net. [71.183.126.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4722ca4c6sm185022976d6.39.2026.07.08.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:05:29 -0700 (PDT)
From: Sid Kumar <sidkumar1@gmail.com>
To: stable@vger.kernel.org
Cc: Keenan Dong <keenanat2000@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sid Kumar <sidkumar1@gmail.com>
Subject: [PATCH 5.15.y] rtmutex: Use waiter::task instead of current in remove_waiter()
Date: Wed,  8 Jul 2026 11:05:27 -0400
Message-ID: <20260708150527.3212183-1-sidkumar1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2026050433-granular-zookeeper-b705@gregkh>
References: <2026050433-granular-zookeeper-b705@gregkh>
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
2.52.0

