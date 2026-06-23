Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454552C3268;
	Tue, 23 Jun 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228910; cv=none; b=BB/BJ3V7fk3oTHrnxlwdDHGdQIsSS5QpT+/fXpZyTeD4dO6ckTF/mcOwy8HA1fe1IBkeGy6mzNkQUzN8zsw5u08op+GIgGQzQo0vhvUDb91Dd25p6Cv2jDWluow3uWhl7pDlr/q9qZZ5RVwgtpyYN7aKkZKMOUmPCYAzJ43UK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228910; c=relaxed/simple;
	bh=mLTuFzzMVDKELXF1rAT/Mbx9fVbGLqpC5NH2pZ1ytkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5Zvh8rAq033nEJPngUDB4o3SJkucFkrOl9Y9SBM9fYtVMfXeL8tSDU88Ik2zet5rVDhLMYfBbtD6gABe9KWaW8zbY34KqMkEMrROLPv3SRPm4Px+QAZb/Md37EK/IaG7/nM6o8X3MMy7EosynZEXaChq+IhMjG7pPfTsHJu29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=DzVafJmD; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="DzVafJmD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228907;
	bh=Gx2pxVFTVh6CiezPzsu7vQ1YDNEI7j7XBUAxmNRT16M=;
	h=From:To:Cc:Subject:Date:From;
	b=DzVafJmDrIL2Ee0agTEXJ/yol2TdqjBOjmeM80UFaT3xcqRDsatfgEpNhiACGNcsu
	 mdwRzS/igrFv4kKvVQSECmZ+HdckiXhaEuokSSf1/xYiuC4ig8AdC6/YRCN/VqknAO
	 Fl1zQpg2i215l2vwuD2p+Ak8oJd9e1n9ttff1Wkk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jq3zc3z10x8;
	Tue, 23 Jun 2026 15:35:07 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Jp2CN3z10xZ;
	Tue, 23 Jun 2026 15:35:06 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 1/4] sys_info: add helper for callers that handle all_bt
Date: Tue, 23 Jun 2026 15:34:58 +0000
Message-ID: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
Add a helper that strips that bit without turning an all_bt only mask into
a kernel_sys_info fallback.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- New patch for the shared helper suggested by Petr.

 include/linux/sys_info.h |  1 +
 lib/sys_info.c           | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..87a841ec7b6a 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,7 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+void sys_info_without_all_bt(unsigned long si_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..6afd4c697633 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -164,3 +164,18 @@ void sys_info(unsigned long si_mask)
 {
 	__sys_info(si_mask ? : kernel_si_mask);
 }
+
+void sys_info_without_all_bt(unsigned long si_mask)
+{
+	unsigned long dump_mask = si_mask & ~SYS_INFO_ALL_BT;
+
+	/*
+	 * Do not call sys_info() when the caller context required only
+	 * backtraces from all CPUs. Otherwise sys_info() would fall back
+	 * to the generic kernel_si_mask.
+	 */
+	if (si_mask && !dump_mask)
+		return;
+
+	sys_info(dump_mask);
+}
-- 
2.53.0
