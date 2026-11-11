Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362925;
	b=o9Pi158dkHjAsDv9hE7Wnjj47GtLk/0gY/CM2+tBD9WRwOpq9SK9D2ypfXtCwpoa1isC
	 X95257dFnn48w2yJWOkpvjXdVfJmQdB0AaMFqk4bYlXugOanDqOs8U7jdmfJP9zoVkJ1A
	 LUFc0rhvB4KXjgYGSurYtNCM2DZRzfKlUOkyK20KTO6G7QAKRNuwjZjKATHlkqChKbRSr
	 LWTu15iCYIW0MD3VOy4oZAvisuhyrXH5Kk+So6+tqpF+C3FYW4S1VEXQX0oG+SlsQrmLs
	 c6VkPf62j+Se3qG6wJgsk+ETsAhnfkMTmKgcyCc3Fb85/ICrh6t8soqbHL3vHECOn9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IqRkQAWA6x79NK/foSAYp+LfNrOBVrF5NDpnzdsePVo=;
	b=jJtgb9T1VlaimtH6Bii9WN4JeD88mL35+Oyy5bdq7Dy+/+azsPg8VcmFCJfZBmYkFnsy
	 7Y9+xAR7LpdLXKdiKMSFg3AUi1h7tGz0bF40BY2idKl6Z/4XGvLPcB/NgSMwR1xnNZZmE
	 Kl1MtKTpfbEQDiBtnVBPC0L+ndPjrpjJ8WjpGSHtDFoXKBMuA/KizF2JhGnt+tdjoGdTU
	 u6MHYV+wwn1KHbxO1rBtu19XuDmS5hR5uVcvZMUYWwZj/gjAuoYGtZPsNf0slMH112GJT
	 Wg0bkaoTUkk8lmu++yT0Ear8RMdWpsrb4AE4/70NBdUX1uLs3vEURrNMTEV2JG9fm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Y/RzuCcz";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E3606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 412E3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y/RzuCcz
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37123334649so7710eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362924; x=1794967724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IqRkQAWA6x79NK/foSAYp+LfNrOBVrF5NDpnzdsePVo=;
        b=Y/RzuCcz11gPiJ4voG226bkg8toO3K9UlJWCo6HoE5c4W9tW4fL1ED84UmKoUc8Zu7
         tBfUzu3oObPhDBJOUpY1HzB5owa8Tz9wFdmGoOo9aga8JPTAxoLQoMMNwtizl0iHD/dI
         L2UAyV6V3DV5OtOq1K9ZQRqdMUqphgZu5u850yXGYA4wUDn/ajyvB9ZbveC10Zp2pSve
         /eULW8xTqz3yWc4EQoVlhFXMbQQBVbjQKsvqnesPnHzzf8A5aUWG8keijou05OsplmCf
         2ckmmhCAIuU24zVnf6llkJcprGLCjdw3uPtvgjjQyK37KX9BqUNkNS6a7fJkHxr6iKzX
         A59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362924; x=1794967724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqRkQAWA6x79NK/foSAYp+LfNrOBVrF5NDpnzdsePVo=;
        b=Eb7kxoDpWv8cP9RkPaTHPJjBV4kO0aUoZ48s0FfUCCyfqL2p2OmfrwSbPXAjpfGA+h
         Ca0q2lo3pE+9MvcJhBcVwmm/EQF1ld5+uts+0tu7KezqT2b81vqFOfk+lZPf07HNztXF
         xoGi7mN5RxXsrgeRtFpexR9rIPnVe50lkwOCDx5mk3reaat/pBoKUXunJrHCAnZlyE2p
         pgDrGuvD5v09gdA7/zT0pPMO01rXkOJnlXMHKaeuk3MEmmWFhnsJhQIAoJaxGyPPf5Uh
         /nRg05NXmqcxsJPZYqsEU+uOxKZDK1qVUnz4NA4iOOV0t0JMNL2QQVXvfVkDTiJsIlAc
         PRFg==
X-Forwarded-Encrypted: i=1; AL+hErFZVx6QM/xqo98TS0mhE3keFT58V0nbDW5f8vzJTf5tYxVgaxsg8CB5EZn7l/2LTfCVAGV84q8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rmz2p3TmFsIVXsefRaEEoHfloXa8/80jANhBsCRt+jdxZQ6ZE
	Og6qyYsi9pEwW70cb3j0M6PjXrcu9GRrfjO/PZoct8bVgsK+DMTDUKXX
X-Gm-Gg: AYBFou0c78aoAvYaPnvz/jhDYM1OY3nWnxu3ge8p+Hic3zgwrIhMSO7/U1X4tvBAZVx
	eGmlmcfE2e5rBnJzLVG9zUVqY0A4mOSOcJhAttxDClQAHHIW61UsKw9rqzGq9p6TvsONsCcyjWA
	pGuqLnbslx9ui3ZwlhME0RAzwsvt4qiT3fbjaJLeHzAxBlqWPo57BrQc0hb6tRSogyN29It0CQV
	T/Xelrma++bZF7GuIaFSOxq7odzcWzn0WaQUUgbbElDDt/rQhyXJAAuTjuArfRN4/ZAwNcE4mSO
	pEob7trOR+AvhLjLdbSr1rh7ybFOOFmScjU1AQdggo7YT0yADafy0UQSXP1TRPdgh4osK/KdPgE
	tHz6oXiH96M0dN7YSlNQk8vNRSDAEkZ2XgLxeeUj6bjsKWgb10Dl/M46w4u0/vCSaqhIUB1oaSc
	JY44bqc3SQcri+FpROA1c8XT4GUiejayhUf8kog9Kl8zkobT0uAVmL8/mu5TOTl3EFR7KUzJdCy
	lwOufySy3OxgVKHQk9NC0XRgV1xSX8QNYXaFKcMZ+VJ/I4vTnfxWFHjWhnHovXX6lJoog16l6+Y
	8HcgB60S9sh/n3BbIdgWRRdGbV8TqTAQz1x39uCucLY98aOA8fEHrxE=
X-Received: by 2002:a05:693c:20cd:20b0:375:f846:5b3f with SMTP id 5a478bee46e88-3767fe8f34bmr2355849eec.0.1794362924193;
        Tue, 10 Nov 2026 18:08:44 -0800 (PST)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm12644625eec.14.2026.11.10.18.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:08:43 -0800 (PST)
From: Wenwu Hou <hwenwur@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	frederic@kernel.org,
	Wenwu Hou <hwenwur@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/hwlat: Bind the sampler kthread instead of setting its affinity
Date: Wed, 11 Nov 2026 10:07:55 +0800
Message-ID: <20261111020755.1422284-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
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

start_single_kthread() sets the affinity of the kthread it just created
before waking it up, but kthread_affine_node() overrides that mask on the
first wake-up. See commit 60ba9c38b931 ("kthread: Comment on the purpose
and placement of kthread_affine_node() call").

In round-robin mode, move_to_next_cpu() compares save_cpumask against
current->cpus_ptr, sees the replaced mask, and switches the tracer to
MODE_NONE on its very first iteration:

  hwlat_detector: cpumask changed while in round-robin mode,
  switching to mode none

So the tracer no longer migrates across tracing_cpumask. More importantly,
tracing_cpumask is not honoured at all, and with isolcpus=/nohz_full= the
thread cannot run on the isolated CPUs it is meant to sample.

Use kthread_bind_mask() instead. hwlat requires exactly the CPUs in
tracing_cpumask, isolated ones included, so a hard binding is the correct
semantics; the PF_NO_SETAFFINITY it sets is precisely what tells
kthread_affine_node() to leave the thread alone. The in-thread
set_cpus_allowed_ptr() in move_to_next_cpu() keeps working, since
PF_NO_SETAFFINITY only gates the user-facing SCA_CHECK path.

The mask is now computed and validated before kthread_create(), which also
avoids creating a thread when tracing_cpumask has no online CPU in common:
cpumask_first() returned nr_cpu_ids there and cpumask_set_cpu() then wrote
past the end of the mask.

Tested on a 4-vCPU KVM guest, bit 0 of the mask is CPU 0:

  mode        mask    before                    after
  none        0b0101  Cpus_allowed_list: 0-3    0,2
  round-robin 0b1111  mode -> none, no migrate  migrates 1 2 3 0
  round-robin 0b0101  mask 0-3, no migrate      migrates 0 2
  per-cpu     0b0110  2 threads, cpus 1,2      2 threads, cpus 1,2

Fixes: d1a89197589c4 ("kthread: Default affine kthread to its preferred NUMA node")
Cc: stable@vger.kernel.org
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
 kernel/trace/trace_hwlat.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 3fe274b84f1c2..65e184d800ff1 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -423,15 +423,12 @@ static int start_single_kthread(struct trace_array *tr)
 	if (kdata->kthread)
 		goto out_put_cpus;
 
-	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
-	if (IS_ERR(kthread)) {
-		pr_err(BANNER "could not start sampling thread\n");
-		cpus_read_unlock();
-		return -ENOMEM;
-	}
-
 	/* Just pick the first CPU on first iteration */
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
+	if (cpumask_empty(current_mask)) {
+		cpus_read_unlock();
+		return -EINVAL;
+	}
 
 	if (hwlat_data.thread_mode == MODE_ROUND_ROBIN) {
 		next_cpu = cpumask_first(current_mask);
@@ -440,7 +437,14 @@ static int start_single_kthread(struct trace_array *tr)
 
 	}
 
-	set_cpus_allowed_ptr(kthread, current_mask);
+	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		cpus_read_unlock();
+		return -ENOMEM;
+	}
+
+	kthread_bind_mask(kthread, current_mask);
 
 	kdata->kthread = kthread;
 	wake_up_process(kthread);
-- 
2.43.0

