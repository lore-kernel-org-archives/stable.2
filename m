Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE3248F64;
	Mon, 17 Aug 2026 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968458; cv=none; b=ryDwkogkO/PlBrTljwmSWFIV+TVZoO0rRNneVM2hW1b56ESDsSBOfi2Znz9HrEWkbtA0dc44BvNQml1iwxIrz/f0qF79fJ0lSOpuclGI24joTjzjkd9qgu8/YCZIC5y5NpjpPE4iOrUk+oG1KEdfvyIMSOKifNYyBAowtEbcbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968458; c=relaxed/simple;
	bh=b3/cuiGaJ2CXMTSctVZ96ZEy//G1nKhQiqF1rdPk//I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6xkS2Xy2VWLTanABrjhfQPLovDxq143WWdUJQyq9MsAmAvKmKUumV3Fn0C3kQ19XAyrz4tBZ6Uiwn/iNgh9Ar6Uc0hsBmKlCDd7o41l+QqNqD+ctHrLwN5rIr21HSiPFghcXAC0q2xKchIuaHfFIeNeHBITAQWPFbOh60J52zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LaP5Fmay; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LaP5Fmay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZW
	8PjdOEfVzLQrehGNbuwtUBqbcnqy3HE9qsNFjcoLQ=; b=LaP5Fmaygijq05exIC
	0ZVOpBoyBXkTYV8TEnq0fanSnE3wfZh/CyCZt/kHE27g56PoaI3t9IOfEwSHZA+b
	TahV5k5EW2ddwCZ91V/LIv+DtS4kZ0dU49cpwlZF6E32CJDIfCk4iEYl9nz416Zp
	fJTFhZvX/JFq23ZwngzKecDLk=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXH+5o+YJqUzs_Pw--.29641S2;
	Mon, 17 Aug 2026 20:07:05 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH v2] tracing: Fix crash passing ERR_PTR to kthread_stop()
Date: Mon, 17 Aug 2026 20:06:44 +0800
Message-ID: <20260817120642.668375-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH+5o+YJqUzs_Pw--.29641S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4kGr1rtw1kCw45Gw1kAFb_yoW8Wryxpa
	yFkr13Kr4jyan29a9rW3WkCw1Uta48Za4UGr95Gw1fAw1Ygw45XrWjgFyj9rnYkrWkW34a
	v3Z0yrZ2k3ykXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsID5UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QzUNGqC+WzpHwAA3O

event_test_stuff() calls kthread_run() and unconditionally passes the
returned task_struct pointer to kthread_stop(). kthread_run() returns an
error pointer such as ERR_PTR(-ENOMEM) when kthread creation fails, for
example under memory pressure during the boot-time event self-test.
kthread_stop() then dereferences the invalid pointer, crashing the kernel.

Check the result of kthread_run() before passing it to kthread_stop(). Use
WARN_ON() so that a failure to create the self-test thread does not go
unnoticed, matching the ring-buffer self-test fix in commit
91542863abad ("ring-buffer: Fix crash passing ERR_PTR to kthread_stop()").

Fixes: e6187007d6c3 ("tracing/events: add startup tests for events")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---

Changes in v2:
- Use WARN_ON(IS_ERR(test_thread)) so thread creation failures are not
  silently ignored, as suggested by Steven Rostedt.

v1: https://lore.kernel.org/r/20260815190151.568893-4-sh_def@163.com/

 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3650d84d4f16..28167b229419 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4901,6 +4901,8 @@ static __init void event_test_stuff(void)
 	struct task_struct *test_thread;
 
 	test_thread = kthread_run(event_test_thread, NULL, "test-events");
+	if (WARN_ON(IS_ERR(test_thread)))
+		return;
 	msleep(1);
 	kthread_stop(test_thread);
 }
-- 
2.54.0

