Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5752E413;
	Sat, 15 Aug 2026 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786820599; cv=none; b=eIpNbYt7aLeE2XTqmbhFcN1goVASjX6z4m0JV6WDEXZMW12cRYjcXXRfWEoW1UWvWfIRN2qf+h7js18QWgx96WObJcuujfFFo537GCQscj0PrVtFhmt77JTh0G45b01WiqXHF59WteXSQ/29KqyMhel0IsDwSATAuTJAmsmA8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786820599; c=relaxed/simple;
	bh=hSZMvDhf2JDjYglgkmLPKAOmNSHRBRi5/MH4P4nxlWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkC4LSh3Gmjl+ScL8zR2Drxp5+pHSQWhDH29XFqEkn7SJbr55swJAC1eVFGVYZSHGMvFnSB9u6pyVv4fdqGVTjrjAs38KCBaKDacA/r/r9iYZo463xUGDlfNi9IhtJ64W3P3RAFZCYPuCfA8DHmrUCEFpURAUohOw432IXjXgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kfn9fae1; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kfn9fae1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ij
	OLI4exvrM4btx0V+CGxecfRyauxUM6PXqGpt82jSs=; b=kfn9fae1Jef4X/prg6
	MCyyrUIjTLb8eCgwSLAyg46p9+cJSpcdFoQJ2aE7FpJhZ6ZFjVMFV7fO6ysQHdMh
	sZVQPaybhSZ9WHq3jQO/BcW2RU1Qaxlty7wYRR7jncB2ecrDfO5xPKLpFEbGam2c
	SMuvsQ47MtBKsMKC9A+TRDyew=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCX9BnRt4BqU5qVPA--.26600S2;
	Sun, 16 Aug 2026 03:02:41 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix crash passing ERR_PTR to kthread_stop()
Date: Sun, 16 Aug 2026 03:01:54 +0800
Message-ID: <20260815190151.568893-4-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX9BnRt4BqU5qVPA--.26600S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4kGr1rGF4kWFW8uw48WFg_yoW8JFWUpa
	yFkr13Kr4UAan29a4kW3Wvkr18Ja48Xa4UCr95Gw1fAw1Ygw45XFWjgFyj9w1Fkr48W34a
	vws0vrZFg3yDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQ4S7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRLcPGqAt9LHKQAA3S

event_test_stuff() calls kthread_run() and unconditionally passes the
returned task_struct pointer to kthread_stop(). kthread_run() returns an
error pointer such as ERR_PTR(-ENOMEM) when kthread creation fails, for
example under memory pressure during the boot-time event self-test.
kthread_stop() then dereferences the invalid pointer, crashing the
kernel.

Check IS_ERR() on the result of kthread_run() before passing it to
kthread_stop(), matching the ring-buffer self-test fix in commit
91542863abad ("ring-buffer: Fix crash passing ERR_PTR to kthread_stop()").

Fixes: e6187007d6c3 ("tracing/events: add startup tests for events")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3650d84d4f16..d21564733b4a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4901,6 +4901,8 @@ static __init void event_test_stuff(void)
 	struct task_struct *test_thread;
 
 	test_thread = kthread_run(event_test_thread, NULL, "test-events");
+	if (IS_ERR(test_thread))
+		return;
 	msleep(1);
 	kthread_stop(test_thread);
 }
-- 
2.54.0

