Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E665396579;
	Fri, 19 Jun 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887081; cv=none; b=BkKYP35YGqJfODC3VDIxnq4i1slYlpqzSTlmrQLSVjwVES8WgTUV5bUJXvjeDBnsr6HxxUo1vl55mzI0d2aiaT50tr3Gzqf3MZ/lBfrJH6iCQjbZt8kgJlxGXFnKgctvsUp+kUSujf7HHgSBU88eQkylEvu2FqQTkm7/Dg9FTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887081; c=relaxed/simple;
	bh=5TE/fAmXRPtPGSlZYKZiW19YWz48RJ5l1BFj7iPZLSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmMOOqHIipPJm9yGBT608lPFGEOVF4DV3Lph0n8p3sThj+N/+A9LmerrAWYS21I6KJCbiEsj3wCFq3IX76ADCdHr+4+acWvVAyas93Jpo9rzo5mteVTPA1iiL4LP9/216krnJH8HN6iTBIV87nJUdtSTUt2IRpEgEbNt2/5heAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=odmKolQf; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="odmKolQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1781887075;
	bh=ZIaJqAqwQPglNeMJRjyw5Ro90LLu19Fa82nqcYlrad0=;
	h=From:To:Cc:Subject:Date:From;
	b=odmKolQf9V+gOFhyNtzo8W7ipkFvg3gyXfqIke+gCK3l0YckWwFHQ59cKK2hcUx7x
	 iRrcRQTUGHch4e+7ccOxSAjgrEyXmPdOiu2bDDArmIXJux9vdggPnh9hvdY8XCsTzK
	 Blye44HvSluq4FU39BBx7D//OUu37w5yuR6a69tc=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ghjv70Z8lz115M;
	Fri, 19 Jun 2026 16:37:55 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4ghjv63xkJz114y;
	Fri, 19 Jun 2026 16:37:54 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] cpu: hotplug: preserve per instance callback errors
Date: Fri, 19 Jun 2026 16:37:17 +0000
Message-ID: <20260619163719.12103-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuhp_invoke_callback() unwinds earlier callbacks for the same
hotplug state when one instance fails. The rollback path currently
reuses ret, so a successful rollback can hide the original error and
make the failed transition look successful.

Keep the rollback result separate from the original error.

Fixes: 724a86881d03 ("smp/hotplug: Callback vs state-machine consistency")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f975bb34915b..0f32086f9ed4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -174,7 +174,7 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	struct cpuhp_step *step = cpuhp_get_step(state);
 	int (*cbm)(unsigned int cpu, struct hlist_node *node);
 	int (*cb)(unsigned int cpu);
-	int ret, cnt;
+	int ret, cnt, rollback_ret;
 
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
@@ -238,12 +238,12 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 			break;
 
 		trace_cpuhp_multi_enter(cpu, st->target, state, cbm, node);
-		ret = cbm(cpu, node);
-		trace_cpuhp_exit(cpu, st->state, state, ret);
+		rollback_ret = cbm(cpu, node);
+		trace_cpuhp_exit(cpu, st->state, state, rollback_ret);
 		/*
 		 * Rollback must not fail,
 		 */
-		WARN_ON_ONCE(ret);
+		WARN_ON_ONCE(rollback_ret);
 	}
 	return ret;
 }
-- 
2.53.0

