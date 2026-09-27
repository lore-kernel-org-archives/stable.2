Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672C233945;
	Sun, 27 Sep 2026 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470727; cv=none; b=B0dcDl67WvDxVw63a2lWX23bSqft4y+hQ0qVrc54prgTsC2Q8J2eEvOsp4kINFGkoI7ltp+oXYEyDlQPNkQ8dlYYDXpVO7MkjJtrC5hUY5QwgRHhFj11u0ArpdwdDbTQ96zGeJdJDhvG6wFOUPELeGiu7MLDKbz4CmNWnBdlF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470727; c=relaxed/simple;
	bh=6kluXO2Vt4KW2XcGmmwlWFAFwlOkuCpvZfEBJdZTmIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HootWqn/l1YtRMCNPCAZr09YlqENDdKAmBRQZgylVrrKxY8YRDcp0CPqTftG9HXBtU/rZ+mEtc9DUOqp6mBnRapmolMRiyr0ITfrvNZ8ce9wC4HExXqajfjUFMTjX24iP4MfRYmAHU+mh4mgLdEduRQWiLkZ4cRFDcH9G7ZwgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh5h7TGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh5h7TGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830681F000FF;
	Sun, 27 Sep 2026 00:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470725;
	bh=rS7QkZgBicvQ6HYA3FnBu0JXrjIdd6/m9iYaXkFNVss=;
	h=From:To:Cc:Subject:Date;
	b=Qh5h7TGAAjNksuPDZZILfce4s6XQxnOoQX/C/QERr9a70k9/YqZrqY3XdqTIyzi+s
	 haYBbCcJukeJCLa8KBIIv2kT9mQyDMthkBN3pcDyELCcbMmxeEuOXgAXPjVGml0drX
	 iCuUnEWcFEH7yXsyisbfb4xf4sUynHxE4Fs524t8UlNL4K48UaGmEaRud0ZTFDOLGF
	 9+7UfzbcHT0uXGw2YFnD4uFIYahgSfKB9gMprjTBrRon5C6pkCyeA4LGNYD9UQBUe9
	 8KeE3WfbWSN3wzYV9JJHhOdoLnPUgqasYA0QGcI6NOq1jxFOiVlzb5b4Xm5mMZT1iw
	 dgYKMMItKonIA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH] sparc32: add the CPU to mm_cpumask in switch_mm
Date: Sun, 27 Sep 2026 02:57:43 +0200
Message-ID: <20260927005743.8299-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMP TLB and cache flushes in srmmu.c cross-call only the CPUs in
mm_cpumask(), which only switch_to() updates. exec reaches switch_mm()
through activate_mm(), so the exec'ing CPU is missing from the new mm's
mask until its next context switch.

If a thread created meanwhile unmaps memory on another CPU, only that
CPU's TLB is flushed, and stores through the first CPU's stale
translations land in freed pages, as when a detached thread frees its
own stack. Only sun4m cross-calls its TLB flushes.

Set the bit in switch_mm() as well. Tested on a dual-SuperSPARC
SPARCstation 20.

This has been broken since 2.3.35.

Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    No Fixes: tag: this has been broken since 2.3.35, before the git
    history.

 arch/sparc/mm/srmmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 9a74902ad181..7d423e5fdc94 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -466,6 +466,13 @@ void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 {
 	unsigned long flags;
 
+	/*
+	 * The SMP TLB flushes cross-call only the CPUs in mm_cpumask().
+	 * switch_to() sets this CPU there, but activate_mm() at exec comes
+	 * straight here, and a CPU left out keeps stale user translations.
+	 */
+	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+
 	if (mm->context == NO_CONTEXT) {
 		spin_lock_irqsave(&srmmu_context_spinlock, flags);
 		alloc_context(old_mm, mm);

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.47.3

