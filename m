Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB33E0256;
	Fri, 10 Jul 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678720; cv=none; b=TTd0wmzjpA0MMj9KydPsL3mzhr1ArFwtvjhJqMhRNKRAbeO+1xjP/bauE9R1Bc0EJbfgj9zjlX1FffjDxXFFdfXyxIjt8pIQEvT+K7Qu9iGh8aEZkt3LLDJJYLofHSk2moqOZQYNNICWJ6h0i5uedDaAou9V7g7CJX/Lpl4fvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678720; c=relaxed/simple;
	bh=ojcOofgON57ikcJNVD31ITK+ru1R28tRSQk5bbjryx8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VdGiJWiDc6Ig7yitokCxo003t5FsUi9BM85dk7nTWXIvMg8UIdd8UvMVR6dXWRlHL2kWqojnEGN9WCGymIk73xu8ulHNDDXyV/DWdSROohOBIKTjJ8oD97h6mr9gjV7WNd/m5NvIct43oC8wF6db2vX5J8SeCFbfOJ15c9FMWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3v0DXjfV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JYZQxVKw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3v0DXjfV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JYZQxVKw"
Date: Fri, 10 Jul 2026 10:18:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783678717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7+K9RQTL02SMVS8+xSqcTfObKfwYFwbIQMR9Y7zoH+I=;
	b=3v0DXjfVmTG1SLQqCYOhheBIG8JeGVLwcO1jjVMhPpnw69RbPPaXBp0vCD/LAA1I8SjzaD
	sfy9XeVaAiJrgqR4McTOJNrjzC15JYQ0N67gipEgTkHAvBQmXcrDwwltbgQvl/EPdgWlVJ
	UnYB+lRpflO/Z1U+HzzsDNnoNHTMzvXesPjgvqV+gHFGzthBXeulucdeI+zUmFg8zBFZMi
	BnfJP0WlGE0UyTlK/J4T1wfKJf6iiVeV/vJSq8ksj2ZCR0DmKBWenSPStU58neqrGWS9k3
	bHvQJzWZ/wkVjM1UQqWHmAyG/CEO3Gfh6I+bokbWpByhdCnmHSkPguI00xQ67Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783678717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7+K9RQTL02SMVS8+xSqcTfObKfwYFwbIQMR9Y7zoH+I=;
	b=JYZQxVKwtRXmEcanDhv7Zj1lZHad/G39bLLcZ5k8c8gs2ROsmAiWBXpPLc7wGfq+cGxVFV
	PVZpGO5p3n8+E0Aw==
From: "tip-bot2 for Lee Jia Jie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/aux: Fix page UAF in map_range()
Cc: Lee Jia Jie <jiajie.lee@starlabs.sg>, Ingo Molnar <mingo@kernel.org>,
 stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178367871542.744054.17203365276522484770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5948aaf64f81f217a25dcc2bf6c0779bca19566c
Gitweb:        https://git.kernel.org/tip/5948aaf64f81f217a25dcc2bf6c0779bca1=
9566c
Author:        Lee Jia Jie <jiajie.lee@starlabs.sg>
AuthorDate:    Thu, 09 Jul 2026 21:56:19 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 10 Jul 2026 12:12:24 +02:00

perf/aux: Fix page UAF in map_range()

map_range() reads rb->aux_pages[], rb->aux_nr_pages and rb->aux_pgoff via
perf_mmap_to_page() while holding only event->mmap_mutex. Those fields are
serialized by rb->aux_mutex, and mmap_mutex is per event.

Thus, two events sharing one rb via PERF_EVENT_IOC_SET_OUTPUT can race
rb_alloc_aux() with map_range(), leading to a page-UAF scenario as follows:

  CPU 0                           CPU 1
  =3D=3D=3D=3D=3D                           =3D=3D=3D=3D=3D
  rb_alloc_aux()                  map_range()
  [1]: allocate rb->aux_pages[0]
  [2]: rb->aux_nr_pages++
                                  [3]: perf_mmap_to_page()
                                         returns rb->aux_pages[0]
                                  [4]: map it as VM_PFNMAP
  [5]: rb->aux_pgoff =3D 1

  munmap the page
  [6]: free rb->aux_pages[0]

Pages mapped as VM_PFNMAP have no refcount protection, so CPU 1 holds a
mapping to a freed physical frame.

Fix this by taking rb->aux_mutex across the page walk in map_range().

Fixes: b709eb872e19 ("perf: map pages in advance")
Signed-off-by: Lee Jia Jie <jiajie.lee@starlabs.sg>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7f3e2c..ba5bd6a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7150,6 +7150,8 @@ static int map_range(struct perf_buffer *rb, struct vm_=
area_struct *vma)
 	int err =3D 0;
 	unsigned long pagenum;
=20
+	guard(mutex)(&rb->aux_mutex);
+
 	/*
 	 * We map this as a VM_PFNMAP VMA.
 	 *
