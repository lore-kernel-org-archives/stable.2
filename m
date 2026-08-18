Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177B47ECFB;
	Tue, 18 Aug 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071100; cv=none; b=kXfvONavsOWZ4ShsAO4ZM26wEV4bHjRsMXhi3R7ZcgqKjHXwo396dT2BtCBecrKrUmZBOO4duJrB8TilMYWZfhQCrd18c89jXpWK4aaU9CvLOgP66FkYMzRGwQeU6QWWwgYvuey+nMjVTHuIWqwI2A8ns3rR6p0KjSJZ65Lw/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071100; c=relaxed/simple;
	bh=NSgiW3uujcwCmGYFSYxV24KtMQZh7zbKbvsSiJ0b8U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niz/vcc5Wvyl0MEWnTHyLe37PFUqSyzOfrTQeEQP3C4wXEKCz5I7CkONopIx0+FzWVBOWCXFUNqZ3OQ2Jsnir2Afan3/Anny41P+OElxQwoZXV3NorOPRvBDlHcWtlDBYVjIB7S3MQIz1XJGAsa54ZRpSUQeJ4fOs/GSkmQkJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Pt9QrtPf; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Pt9QrtPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071091;
	bh=cgyI3IaPBzqKh6lTsN7YU3kb9A0UK9kug2a9FDb5Bvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pt9QrtPfYOKgXgGrN9R5Beps5+GrFxvb8xUaowsxKfT+1XFkM3Jk5cA3dhfyDfLhZ
	 W9I9rWP7i2qR9Ufx8ekltiq2i/07Kn0g5cyEYTy6FcPG0EkuB+vfowrtOQfh/3oq4R
	 RSdhvTofTAX5woA4eqjEMM+6oFbC+sFDnBM2V0cE=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with UTF8SMTP id 4hPb3l2mKMzGpDL;
	Tue, 18 Aug 2026 16:38:11 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hPb3l0pRvzGpDF;
	Tue, 18 Aug 2026 16:38:11 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 4/6] panic: restore variable arguments to nmi_panic()
Date: Tue, 18 Aug 2026 16:38:04 +0000
Message-ID: <20260818163806.17460-5-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818163806.17460-1-include@grrlz.net>
References: <20260818163806.17460-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nmi_panic() used to accept variable arguments until commit
ebc41f20d77f ("panic: change nmi_panic from macro to function")
flattened it to a final message string. vpanic() did not exist back
then, so the function had to format through panic("%s", msg).

Bring the variable arguments back and format with vpanic() directly.
The next patch makes nmi_panic() try the panic_force_cpu= redirect
before claiming panic_cpu, which needs the arguments twice: once to
format the message for the redirected CPU and once for vpanic() when
no redirect happens. Passing a final string would lose that.

Every existing caller passes a plain string literal with no format
specifiers, so nothing changes for them.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 include/linux/panic.h |  3 ++-
 kernel/panic.c        | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f1dd417e54b2..a9128bf3c168 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -13,7 +13,8 @@ __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 __printf(1, 0)
 void vpanic(const char *fmt, va_list args) __noreturn __cold;
-void nmi_panic(struct pt_regs *regs, const char *msg);
+__printf(2, 3)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
 extern void oops_exit(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 6b5728c3c9ce..bc142485faa4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -518,13 +518,20 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  * nmi_panic_self_stop() which can provide architecture dependent code such
  * as saving register state for crash dump.
  */
-void nmi_panic(struct pt_regs *regs, const char *msg)
+__printf(2, 3)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
 {
+	va_list args;
+
+	va_start(args, fmt);
+
 	if (panic_try_start())
-		panic("%s", msg);
+		vpanic(fmt, args);
 
 	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
+
+	va_end(args);
 }
 EXPORT_SYMBOL(nmi_panic);
 
-- 
2.47.3

