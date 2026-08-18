Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC447AF69;
	Tue, 18 Aug 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071096; cv=none; b=OitNClmMxKGq+Nf3bbf2Q79cPXq9nridJCg1Z5pz1qGHdyk5yTUP73atdVZY5qIsH++nuIus0yN1Bsri3OeXNo2QMFVKWyB8e5tk2cRFp1lpb1BXNLEv7dSMEhbiTcuTCoxeKIksU/smFsrNdep/Mwu5uWhOc3Jytp56Ex5dSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071096; c=relaxed/simple;
	bh=NiGA6AXye8cZ/IcxBjpZ+kHZGi8lvXQ6kFgbZD0Lok8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8A0dwn9rgF17xTOfWDdjOf2f4AK3fKauN2b/+40xzbvPVA5F9AIOuj+ddHGITDwpXlZPXMAukR70pfToAgtV/2htiGnxhxSok8X1PvNMvgeb1xn9LkGnuNIpmjTGbYdhlUnTDoNdbkG+MaOlpAhRYPM4relYrfZ5Vu1plOo7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Umr8blve; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Umr8blve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787071090;
	bh=zk9npSmxa7h2iYAfiMla7unhtV1PsNEB/GA3nn0UEss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Umr8blveLBUGt/5l1/+WgNuWo7DMBmgBGQ7ShSbpiO33Qa3UNSme3YDCqN0jRPoRl
	 0wxVyVPt5w7ldM89/Znf470VZFXC2kp5fYyGV2tqyl6cJTDa8E5zNVjrre0tDGhELI
	 hh33m/gP/f/UQD6bfwxpF8WuoLtEyMOgMwGUSdWs=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with UTF8SMTP id 4hPb3k5wW9z6vLM;
	Tue, 18 Aug 2026 16:38:10 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPb3k3bHqz4y6W;
	Tue, 18 Aug 2026 16:38:10 +0000 (UTC)
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
Subject: [PATCH v6 3/6] panic: fix va_list reuse in panic_try_force_cpu()
Date: Tue, 18 Aug 2026 16:38:03 +0000
Message-ID: <20260818163806.17460-4-include@grrlz.net>
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

vsnprintf() consumes the caller's va_list. When the redirect fails,
vpanic() reuses it for the panic message, which is undefined
behavior. Use va_copy().

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Cc: stable@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/panic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index e1b443150ba0..6b5728c3c9ce 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -417,7 +417,12 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 	 * fall back to static message for early boot panics or allocation failure.
 	 */
 	if (panic_force_buf) {
-		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, args);
+		va_list ap;
+
+		/* Do not consume args, the caller reuses it if we fail */
+		va_copy(ap, args);
+		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
+		va_end(ap);
 		msg = panic_force_buf;
 	} else {
 		msg = "Redirected panic (buffer unavailable)";
-- 
2.47.3

