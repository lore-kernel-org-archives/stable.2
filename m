Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605050;
	b=TgWeq1PpSC4uQwUTbS7U0xFI+o8/3oW+CB0l/FasJL96YA6ZVI63V+goFP4/ZhzCIZV5
	 vbQ3a39U5PloS9vcWMrDPXoQ4Sba6HcLhDUIB8RQfdYe7A5ud7xyiCRHpRsSVU8I4VYJ1
	 9fhxZ1BCe2NhAgHSeEoSdrmLG8wEwjAVRAVv/s4NC0p0lOEAwbWHHbRb5bjrcjNzA6TTi
	 vsFjWu3oX/HVlI3Q2rZwoDwtW3+1zDFqv4QgoT4TD+h/fX8NbI1BKUIUQlhKgSsAlkIRZ
	 wy8sx9M6l7q9dvLbWhH1bgRVca2ifl88fnlrY9MkEqWZ4QkJPGwGBGkuyERl2pgN5eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mE9Ag/gCpQwpic9Sbpc9hGK5nNJZ45oi/KyynO+C5Ws=;
	b=feCV/I/5oM3x3B3C7XjcxhqXy3P/icSBFhprn5J8HJe/H5KaBgtlf+aThMD9JAIckyqE
	 H+mEQLT6L0NmKyK0SRA4BChJnC2XcnSC1U0MXCAzh+TKSvvxdOEvPxVs1aEuSuj9wKnP4
	 uj/Q3ND+0vAIFyHh878VW19Ahhh85rf6EgP/eo6fnpj8pnT81KGPiQl9m/VxrJtrOT0K2
	 deVp5VCWi+Hedy7AAFDqO2NgBOKJKku+ayLwlOvArmmW4L+U/Axd3UpAjrOPBrSQ8G2yd
	 Hzul9RKOZzbynXWf1aAbC/lXBGy0cuJ+DJrW+01EaVAQVVyIUItK2EdBbhT0vTjYVoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=AcdzYn+x;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4A606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A4A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=AcdzYn+x
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33fb4680717so2438186eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792605049; x=1793209849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mE9Ag/gCpQwpic9Sbpc9hGK5nNJZ45oi/KyynO+C5Ws=;
        b=AcdzYn+xJgZ24qhdgNzJ+znHcPBAcXz72e9f4fQNiIdR9DHJ88983AMvTE3ngzyFC7
         SDCp43YiGEg2N4XU5y9IxSku8AVhcBQifpG6b+xFWQnuaUlWF9eKV6mIv1RvQan4ZlRi
         A9tHlhTbISYlznruJmqYxa1i5DlWZ1i41oAkZUkiMLDZRtM51ZkD4+XEWQBcQnhAHTow
         3uG185oH+MfhXlZiE12QtsqR6cagzCQoEmcGwZ9t3m3bGudFO8B9vNQh02gnj6beJXsG
         HBNvvitmYn6+WQzRXLedcKF7QS4HnyyjH8bwxj1aB5uT88pEdpQBBl5Ih/61fj7fuIIF
         Trxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605049; x=1793209849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mE9Ag/gCpQwpic9Sbpc9hGK5nNJZ45oi/KyynO+C5Ws=;
        b=BvJAucg6IqDrkZpCYBzDfw8SDzSKJ+URp8hyxuHk/t8aVNfBVWV8PoD4P2tb78UrUJ
         DTJuLpIItn+C1mdlQXoX1TJwsiuCG+A3lucTOJmqT2ywIErz2IpUNXsVQycdWXFX7Vkm
         31qy+nFXOWTtqb+QmBUYTrijrxiZ6PgcHHfI1dk1hgwGdWsr9OUoCe9ohK3Z1J3PAjD9
         ItwltQtS2ck1bM/WzoWx0PaSFrpBEles/yG+8CsmTKAFOb8spBgnKveFj4UyhM/ZMaI1
         NvfWynXiAPmXPk1YuGo6F/Ck/RslDxFB4KTWT1fimWo7nuztaq6s8Q8S8TXa6uEVBvic
         bX2A==
X-Gm-Message-State: AFq9FYJCPDUCJ9bf+59zBtK6x/DwXYhYg+uEMBUqR+hgpZx+sESHPFoo
	9BCo5YkGJoks8xa/zyOW6EjSvCnQBF1h4WhEVIQQh0irr3ujfUZEnf8g1YDPRO/utNjsmCD/ayr
	97EHfr9uNfw==
X-Gm-Gg: AYBFou3PJ1pCzXzAF1CGQ+ms+JwwkrTuajQIB9SnuVYl6MCL+0rna4a2Dwv+MADw/I8
	s9mrcl3RoHRsAcitSryJVJFUwBcY0NI6t6ji2PdjoEVOqbPa+qh7pqP8pNB8TcMXMseRQ3w61bF
	/ST0RWChjzDGRNIq/HaJkwnpXmwy14cd3w+WmkPHjHcy3fWJ9BVjShyPLQFKznjPHwZwQICneRR
	ov9w15rpZS1XJNMqr/lmNxeqbR1/jjXbKU0jRZmJBWTHRSkRVJ0tZGP2jw2r7rfxzlp/TQrojRD
	E2wfdWN6oLcz/ae16c+q9ZVpidguOqK2BevJArOLrnPG8Zm26ti3uHd8izAdd6EqbPJnoNuoku4
	/RPIso9GIJmW1uMmr1nRIxogpqcY5IIeMYVIW9CtVzgq56oacYvJIfPOsuyCpiQqKb0DE/WmdpI
	L8DTcnq18Sh60T9Dp7M/ComRdxxuTxaInTqoIYyj8WHBLDLlKhmSurTn84REGqulVXvP1h5nJqJ
	Ky1vp889MC47BHhAX2l0FgPwExPfnsT6LePdyU834hPLhPFI7sq4fWhhFk/7W2y94FSeqs58W06
	Y56tn/MJ7srBIPI49WvYnebJBL8prRZ/75YqSlgJq2K+gweDYFUh
X-Received: by 2002:a05:701b:424e:20b0:143:298f:33b8 with SMTP id a92af1059eb24-190a7756cafmr3521892c88.44.1792605049249;
        Wed, 21 Oct 2026 10:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm8229754c88.17.2026.10.21.10.50.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:50:48 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mkoutny@suse.com,
	ridong.chen@linux.dev,
	tj@kernel.org
Subject: [PATCH 6.6.y] cgroup/cpuset: Make nr_deadline_tasks an atomic_t
Date: Wed, 21 Oct 2026 13:50:45 -0400
Message-ID: <20261021175045.1443-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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

From: Waiman Long <longman@redhat.com>

[ Upstream commit 95220e1f18f6321008f021abc7d6f581f64bcb82 ]

The nr_deadline_tasks variable in the cpuset structure was introduced by
commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
in cpusets"). It is reported by sashiko [1] that nr_deadline_tasks
can currently be modified by inc_dl_tasks_cs() under rq->lock and
by cpuset_attach() under cpuset_mutex. So if both updates happen
simultaneously, the nr_deadline_tasks variable can be corrupted leading
to incorrect operations down the road.

Fix that by changing its type to atomic_t so that nr_deadline_tasks
are always atomically updated. This fix patch is a low hanging fruit.
It can handle some of the races between a concurrent sched_setscheduler()
and cpuset_can_attach()/cpuset_attach() calls, but not all of them like
the other issue raised by sashiko [2]. This will be handled hopefully
in a future follow up patch.

[1] https://sashiko.dev/#/patchset/20260626181923.133658-1-longman%40redhat.com
[2] https://sashiko.dev/#/patchset/20260630033344.352702-1-longman%40redhat.com

Fixes: 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets")
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Assisted-by: LLM
[ Backport to 6.6.y: Apply the declaration change in
  kernel/cgroup/cpuset.c; struct cpuset has not moved to
  cpuset-internal.h. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-93150 to 6.6.y.

The code changes are identical to upstream, with the field declaration
applied in cpuset.c. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/cgroup/cpuset.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bb413045d174469d9f5f8187af2de50d3c4076fd..4dc4b326781a8ffb93f503255eb5a026180adb23 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -175,7 +175,7 @@ struct cpuset {
 	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
 	 * know when to rebuild associated root domain bandwidth information.
 	 */
-	int nr_deadline_tasks;
+	atomic_t nr_deadline_tasks;
 	int nr_migrate_dl_tasks;
 	u64 sum_migrate_dl_bw;
 
@@ -235,14 +235,14 @@ void inc_dl_tasks_cs(struct task_struct *p)
 {
 	struct cpuset *cs = task_cs(p);
 
-	cs->nr_deadline_tasks++;
+	atomic_inc(&cs->nr_deadline_tasks);
 }
 
 void dec_dl_tasks_cs(struct task_struct *p)
 {
 	struct cpuset *cs = task_cs(p);
 
-	cs->nr_deadline_tasks--;
+	atomic_dec(&cs->nr_deadline_tasks);
 }
 
 /* bits in struct cpuset flags field */
@@ -1091,7 +1091,7 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
-	if (cs->nr_deadline_tasks == 0)
+	if (atomic_read(&cs->nr_deadline_tasks) == 0)
 		return;
 
 	css_task_iter_start(&cs->css, 0, &it);
@@ -2757,8 +2757,8 @@ out:
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
 	if (cs->nr_migrate_dl_tasks) {
-		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
+		atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
+		atomic_sub(cs->nr_migrate_dl_tasks, &oldcs->nr_deadline_tasks);
 		reset_migrate_dl_data(cs);
 	}
 
