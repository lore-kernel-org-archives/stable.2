Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388C2F7EE3;
	Tue, 23 Jun 2026 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228914; cv=none; b=JUy+A5Sb9s32DGf1iEA7H6bLNlt+m0X5KnKjxWC9XqjKYs+wwyV3n2DRe0eoLPdfvdB8uJqYhDuxBg6Q4GNL/uurmO8FUebIaZGQbJQ5EGSov1XbrDQmdydCT7v0YqtJAvOSmBkRVLJaHLqrl2T398978mQXEV2q+LrpAaESqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228914; c=relaxed/simple;
	bh=1Gp/NOYgjpPwmJILJJFsZmVhfxObqfsGcV7GsCvTAWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udMUDvIIcOtOVpbAsPFsO64uL1snaf8GoDO0pXj/dSc1bk8Zn7++qhrefc1PbtyFIIUR+t3+Kw5QDWAmzOfuFeIMSfhWu4m8s839eQEP8D2zqQKwrRIHEVreGyKl17GlCo3QFqzgbeH7yGipmsvMZ00R6xzlrzGkuscquNDeVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=YWQ63Pqr; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="YWQ63Pqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228911;
	bh=yJvoIA1fO2feDg/kwex0Po7ylI4GiWcadD1slikx9OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWQ63PqrZA6fHb8qsiiZDoFe8MfB9mrdyJNeNo70YVy2vjDtftfvhU4iMf/0NMZTl
	 Rr6cmR0Pic59edq6R/aHn1RQm+BOmvPs1Yy4a6UpumqBRscME5k1uJj10kJW1t8FDF
	 4E9tmGrDQ8GfP2ptybXd6OHZwo30tkIyAsf+LS+s=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jv4hBZz10yw;
	Tue, 23 Jun 2026 15:35:11 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Jt3GQrz10xZ;
	Tue, 23 Jun 2026 15:35:10 +0000 (UTC)
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
Subject: [PATCH v2 4/4] panic: avoid duplicate all CPU backtraces from sys_info
Date: Tue, 23 Jun 2026 15:35:01 +0000
Message-ID: <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
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

Use sys_info_without_all_bt() so panic_print=all_bt does not request more
output after the CPUs are stopped.

Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show sys info")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- New patch using the same helper for panic.

 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d030f88ad4ef..2cf229c7c0cf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -683,7 +683,7 @@ void vpanic(const char *fmt, va_list args)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	sys_info(panic_print);
+	sys_info_without_all_bt(panic_print);
 
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
 
-- 
2.53.0
