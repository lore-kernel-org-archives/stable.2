Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491364;
	b=eVQM8hdbuHPfW+z3qrMeoIRrDPMEPKR1guO3TNemVshL/I+ySXehvzrDdUi5nF2te6p8
	 fdR9pIPtFR/WwbANlE0HMwOML+xY6gz9L9F1lAqIIW9Xo32oGaN1kbWXM1dF2P7rmXBYj
	 B5xOVghHB1GU14EIACcDSN1dpQKqc5jZUhOkmhL7ceC00gFdw6aQmyn556lxVJAcxKkdq
	 ay+sMyMsadnHDB6lVUNW5vk3aVXfGpf6FlS2kLAKmkpvW2JznmyhuaUK1MhhI29yOwZa0
	 6KgDomtudK+vV7uj4CjVwpnY+YoS0CYirSmJ0UOIr0WoUbSMSwMdNVlwtboOf2VuqYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tPwzcSn9YCtkUcYX05pvK2PhOcLN5eFatEAbk1VC3Ao=;
	b=46E5f2Lr/yjJwCnNTLeNx/EEQG4Ksee/sCJirpnam2bYqlMZPCQ9koUYKD0JSaxry4KH
	 BAcuSEdHRpUgkKF1RGY5WSWm9EYS+TXIJjo1mQV/EZXfZz2qFX8Wg/WDSpkiLGt4WiWHi
	 pXU0ucCttAv1BD1h6pBTpFSUN5STKK82lmfuErI4NW0nUccC6LISIkxZasJVTa19IjMra
	 zrtKRqT9JylX++61bwXum//jofyI+oSzOxjOloVQ/Vu6s4SMauky/ddf39oDzZ8X1ogEh
	 aSJ3HQo6ndBL9A1uIGTbBDX1ghTIllYC0f/dmD2nGJg22JfeJGmv+MlRSumett2f4/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tds5q10B;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000B606A32D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8000B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tds5q10B
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso2829312a91.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491364; x=1796096164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tPwzcSn9YCtkUcYX05pvK2PhOcLN5eFatEAbk1VC3Ao=;
        b=tds5q10Bethl0FfyiXZva4IzMwY9rSAd99cHIo9BJ0aalRiX9U199zumfts2SrIOcP
         M0ElpB8TXNN+39CQJ/83sq3CBLLGn5Ts47U54hAGmtOqpBauy4iNOuJ0zL6BvMJeOOJG
         mk0BSbVFmNWFvBJjC74WWVmAb0XCaBVDyWMM4pN1EOv/IM1LWFzAVR6v68kxSkdx7RBG
         Q+ud+KfixiNbOgFhe6FJxy2Bgg3mDDp5+wyH9SOaGfi3gBy0Ev3p1ITaOeDDaLJ1tfa7
         uWb6+oNWIWG8qgpagiTR2xyzzgFWy3E1JjyaCGNNqzHjt3erllK/GrYLo9qfXfCJaadi
         F5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491364; x=1796096164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tPwzcSn9YCtkUcYX05pvK2PhOcLN5eFatEAbk1VC3Ao=;
        b=QYWbZn559y1vF4VfvNlTTIcRkAhV2L6olH4EWFGu9mfY8UOSI1OyuwfLUcJM473z/3
         oHlkz2wq0hbKaNxYVBMiH4xs9+h5SxYlnre5tbiDI9DGfdQZprGC1ZI/Wfqm/UHVoOXc
         ai6sbCDzUlX7GY7pGbYoZ+GTNrwB4zroxkV2Wir1F43oKpgi75/heXg6pjpZvgh5m79h
         3FVxh+fE2qcM97rUYmg8sjYXMJ3PTYQ+EjUzXibuY5ehs0FJ8GLxLCm1Td4R/JxEgXkD
         ZBLHlW8pAcAjWGx3JJH9QFv4TyHil8rj3Lmp4HZpc+2VewgiVJHcjPHat30FQSeUSzL7
         cWcQ==
X-Forwarded-Encrypted: i=1; AL+hErE2aKGEjzwM8j6CfBfgq5d/ckCO24NCpCsKUQHco2lPoIZs0PmKDLuE45wXwS/dp41WdZz13Ts=@vger.kernel.org
X-Gm-Message-State: APuU4Z96RNl6KhnqyUp9mOj63+Ym5Ctf2eYa18LhTPNTFd18jS1wEskh
	XSNlLbaRb6KH5E2UohogbqzcTXMvI9Ac0Evmn9cvMoL/IR8WPg+JpLcp
X-Gm-Gg: AZFdTZcD6vmHNlarezI1txa95p3igNPrpUXGJWdyivXP4obi9Hjg0A0lXooydth4bWw
	a+j0wQSOuVPddlieaGj7V6+iayobMqiYhFbREpXS6YGq/biIvUS8Qw/xkHkjO4OePhyJxudWYYe
	rejSf1jrt6cyxwLfEgNqaSNI3/QbIhFZeRwW/HkRKbgptb9OUha+7CikpN9Evn6Jn60vvwHSepX
	gBcYg73UnSqd/mLMI+QdN1c7vG/erywcBnPrcWaXc4J6jhBid8Sd2FnPIxmTLLbFuiofa0Ap+4A
	kO7Hb64VoPhUGxwnZumAGSBMaHWAOIHRs8Wspt21Ml0PsikX/6jWdfLoECO52xuSzV8GRvwQeFK
	hcuW0nUS+Gu/N2eHodwUQmQxGgEC2yrmMl4SEgFGf4JXP13vIxzgCT3In01IiWWLah1KV8TuqDf
	0ns+5AnlIGcZ6DN0RqxcZ4xqY1Vfoe/c6WflRndTdAN837qiVtOI04DAjaEjQ9I+kyLHQ44V3B9
	p1Tw0Owlkw/TcyhEzInnt9qX4EZIbo178cN88AL2a3D+ce81Wa5ESpahR5YedKjYKzWPI+VA9m0
	p0LIASTaHis6ACEq8vddYxR38qyeZ1lI8eUqLjQdRx23S4hDtyWeK1C02/cmqcfykVE=
X-Received: by 2002:a17:90b:4a92:b0:3b3:fd13:683a with SMTP id 98e67ed59e1d1-3b41c995b82mr12834105a91.59.1795491363557;
        Mon, 23 Nov 2026 19:36:03 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm23397939a91.16.2026.11.23.19.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 19:36:03 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: tj@kernel.org
Cc: hannes@cmpxchg.org,
	mkoutny@suse.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	kolyshkin@gmail.com,
	chris@chrisdown.name,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm: memcontrol: find the OOM group of a process where its threads are
Date: Tue, 24 Nov 2026 11:35:47 +0800
Message-ID: <20261124033547.2373352-3-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124033547.2373352-1-zhanxusheng1024@gmail.com>
References: <20261124033547.2373352-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

When a cgroup.procs migration leaves an exited leader behind, a
CSS_TASK_ITER_PROCS walk visits the leader at the first live thread of
its process.  A memcg OOM walk of the cgroup the threads were moved to
can then return that leader as the victim.  mem_cgroup_get_oom_group()
takes the memcg from the leader, which is still the old one, so
memory.oom.group of the cgroup the process is in has no effect.  With
memory.oom.group set in dst and a second process in dst, an OOM in dst
killed only the moved process.

Add task_procs_css(), which gives the css of the process a PROCS walk
returned, and use it to look up the memcg.

Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 include/linux/cgroup.h | 18 ++++++++++++++++++
 kernel/cgroup/cgroup.c | 11 +++++++++++
 mm/memcontrol.c        |  2 +-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 5dfa915a630e..cb05808f2172 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -548,6 +548,24 @@ static inline struct cgroup_subsys_state *task_css(struct task_struct *task,
 	return task_css_check(task, subsys_id, false);
 }
 
+struct css_set *task_procs_css_set(struct task_struct *task);
+
+/**
+ * task_procs_css - css of the process a CSS_TASK_ITER_PROCS walk returned
+ * @task: the task returned by the walk
+ * @subsys_id: the subsystem ID of interest
+ *
+ * The walk can return an exiting thread group leader that a cgroup.procs
+ * migration left behind for where the rest of its process is.  Use this
+ * instead of task_css() to find the css of the process.  Must be called
+ * under rcu_read_lock().
+ */
+static inline struct cgroup_subsys_state *task_procs_css(struct task_struct *task,
+							 int subsys_id)
+{
+	return task_procs_css_set(task)->subsys[subsys_id];
+}
+
 /**
  * task_get_css - find and get the css for (task, subsys)
  * @task: the target task
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ab442f94e29d..0be7f96ce074 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5237,6 +5237,17 @@ static bool procs_stand_in(struct task_struct *task)
 	return leader != task && procs_live_thread(leader) == task;
 }
 
+/**
+ * task_procs_css_set - css_set of the process a PROCS walk returned
+ * @task: the task returned by the walk
+ *
+ * See task_procs_css().
+ */
+struct css_set *task_procs_css_set(struct task_struct *task)
+{
+	return task_css_set(procs_live_thread(task));
+}
+
 static void css_task_iter_advance(struct css_task_iter *it)
 {
 	struct task_struct *task;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1271d390b617..5704e4415a16 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2003,7 +2003,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 
 	rcu_read_lock();
 
-	memcg = mem_cgroup_from_task(victim);
+	memcg = mem_cgroup_from_css(task_procs_css(victim, memory_cgrp_id));
 	if (mem_cgroup_is_root(memcg))
 		goto out;
 
-- 
2.43.0

