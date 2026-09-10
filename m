Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71C1DF98F;
	Thu, 10 Sep 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031262; cv=none; b=d73L7OH+QWF9CO5N+Yb4qp6K5tOwsPLu+WNTB1OzVviCi45PqfqXa0L0H5I9ECCulD1Wz47J3gnaabb4uaHsCsvFIJKvq0jcj9evnGVLwCpNTx0CZ32vw99kavaqcPtlpw2rljZfd/fVU1c2gElx3h5ssZFrXrtReAvmBXHtD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031262; c=relaxed/simple;
	bh=YiRnrekPvQYYdHLy0uF+ZNizPE/g02wDCKW4u+qGHhE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XfbZfKnRB9fPmPOytuCidQjJz6RLZkzu5uctHC3MbOqDF3R99nVV/NYXk6au3UlyDLMo4/20Y1cDSd6FiaQgHx0VOIf+FMSHm5RSnqL256I86TSHabNe6ism2cn/qq8yKcvTgJf1CO7CQtq2GBMIQmq7PMjzgc7UsGXPDHhBUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EncISJd/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JiyfDZZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EncISJd/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JiyfDZZ"
Date: Thu, 10 Sep 2026 09:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789031257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4v9UiDe2ZuB9+5TpijXLbXwKgbMclhThwuiwlG5exso=;
	b=EncISJd/vqDt+pHgkwBWfYwEad6bieir0N9Gc0TlltpXhPXf0WcsHjBuk23Hm69R8yq6U8
	fl8B5IuxVCdy81pZgZc6nRZnJb3e7Q4Zz/OSh+qHle0mc6dWTE2LxoBNQgK9jjOLc9HEyA
	UGWfwl0XKzPr4BjA0weDnmZ7/GJ86DgdpdJZxr3gxhnicvD2eFtGBfnPThdk0uzIjNqNA9
	TR1pywpgC9ln1NoQXERLOcmkx/nrhedhrQUzWaMDVeTITEhJX7b3oBr7G89ydO0kP2JDTV
	N5NUHwMMG/91HcTU+JkF9cCUHKhNSc+/gfj56mIOgP4y7KZgcZ2ZVJKHeNbitw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789031257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4v9UiDe2ZuB9+5TpijXLbXwKgbMclhThwuiwlG5exso=;
	b=1JiyfDZZBOpZxs0axafnTqj58SldQN9SBTDQN5ccgAqew7FgUpjFcwdTMX9QXUHvMpch1p
	wsTLqqVT4dDYIYAQ==
From: "tip-bot2 for Eric Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reset NUMA fault locality after scan
 period update
Cc: Binwon Song <qlsdnjs236@chungbuk.ac.kr>, Eric Kim <seohyun.kim@outlook.kr>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178903125575.623050.1039816034392719069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e81ee06308379a5f2ededf997bcf17551bce5db7
Gitweb:        https://git.kernel.org/tip/e81ee06308379a5f2ededf997bcf17551bc=
e5db7
Author:        Eric Kim <seohyun.kim@outlook.kr>
AuthorDate:    Tue, 18 Aug 2026 12:48:29 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2026 11:01:30 +02:00

sched/fair: Reset NUMA fault locality after scan period update

When updating the task scan period for NUMA locality checks,
update_task_scan_period() checks whether there were no faults or failed
migration on the last scan window, at which it prolongs the scan period.

However, p->numa_faults_locality, which is used to check for migration
failure and number of faults at the previous scan window is not cleared
after changing the scan period, which unintentionally increases
numa_scan_period up to numa_scan_period_max even when there were no
migration failures or no faults at previous scan.

Fix this by jumping to the out label on early exit at this case to
ensure p->numa_faults_locality is always cleared before returning.

Closes: https://lore.kernel.org/all/20250404095354.311156-1-qlsdnjs236@chungb=
uk.ac.kr/
Reported-by: Binwon Song <qlsdnjs236@chungbuk.ac.kr>
Signed-off-by: Eric Kim <seohyun.kim@outlook.kr>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/Message-ID:
---
 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b8bd308..a42360c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3514,7 +3514,7 @@ static void update_task_scan_period(struct task_struct =
*p,
 		p->mm->numa_next_scan =3D jiffies +
 			msecs_to_jiffies(p->numa_scan_period);
=20
-		return;
+		goto out;
 	}
=20
 	/*
@@ -3558,7 +3558,10 @@ static void update_task_scan_period(struct task_struct=
 *p,
=20
 	p->numa_scan_period =3D clamp(p->numa_scan_period + diff,
 			task_scan_min(p), task_scan_max(p));
-	memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
+
+out:
+	memset(p->numa_faults_locality, 0,
+	       sizeof(p->numa_faults_locality));
 }
=20
 /*
