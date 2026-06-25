Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827D3E8345;
	Thu, 25 Jun 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401184; cv=none; b=BaJIO22GCRtzaupbqYGVymvPc0tIce7Y0x9d46RUeYsEZZNBhrTgrgHPDXPdO3o9G7Wz98NKdDgdEUKcQJbSpb1BrY4ektj5wwJ3vJMNXrNI6pGRMof5lF0Q8PLfxnBruyHx2/klYRZGwdt/loUSB2lH+ztEd/DdwPP0riPol+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401184; c=relaxed/simple;
	bh=QLeMwYMqVINwlrjRGdcfmOgkQ0B+h/JckBiAgec05Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnlzD3DAyagVRdo+QcvQBJxYiVOHkXgz9JEYEYxG4AsrZXLtPgVce/6m411ViOsyJn8uYgC4Jr+7IRDU87GUKFJOtC5a1Q2WLnvFCw83KYE97tnAWvS5AKTVW9nq/f8Hi4Wc4Pfl5De9FeXOVgAKQQVKDGeu1pGVZhs3721OUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=YFhd5dPT; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="YFhd5dPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401176;
	bh=e2kzugiSXXnut0MG0Ah87pWfEVTXT2Cv2TcVn0+5PSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFhd5dPTDSDDJrKklU0G5nPkPXm+iR2wnftu3mjt06uv6wxB6N1YCkOea+ceeTr8M
	 tihriFpyrZgqelD1OjbJvS1CHLuAsk2IrKHK9dQ9+U4/Id+bHv25FyT/89ZjV+uB3H
	 LeIxqI+GwlEBceJJLmMpfY9u549OAHIpQlsFzCsE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1h0QX6z10tb;
	Thu, 25 Jun 2026 15:26:16 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1g2dvRz10v9;
	Thu, 25 Jun 2026 15:26:15 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:58 +0000
Message-ID: <20260625152558.7450-5-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625152558.7450-1-include@grrlz.net>
References: <20260625152558.7450-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
other CPUs. Do not ask sys_info() to handle that bit again later in the
panic path.

Use sys_info_with_filter() so panic_print=all_bt does not request more
output after the CPUs are stopped.

Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..eb842823df61 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	sys_info(panic_print);
+	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
 
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
 
-- 
2.53.0

