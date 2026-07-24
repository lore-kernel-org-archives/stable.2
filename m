Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D73C1400;
	Fri, 24 Jul 2026 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929291; cv=none; b=WwLcwKkWFDPM3pOw6j2Gfj9C1jzpM2OKIIKnaIWssaANzu0o/46bFWzVd2p4idzkaZIpOvm+s1FMKCMaVH0q5Je9PmvJd3nloFjpA7AGip7Io3rFASckgZNaEmtJSVDfi5oQcW7iuAmxldRBmoRiuryaw+Q5oYst/tkwyeZqjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929291; c=relaxed/simple;
	bh=a0Cfg7X+g3S2j3WgmrnppIxwpz2k3rDILWehus98x28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujlQKVu6xvQ8BBGDtHBb8KWUmgfu5cTjk+IvyfQZYH+cQGhbhTtsdOfdbfRMgXE/rk3IGNAUt/B8ks2C2QpIJHEpeRy51KHCe3rEIJaCbK+3yZ7tZ7re+qgHdtxEpr95hYIy0Sq+wDvbu8ANJ/HvsAo3PBzNir/djvJDimPD6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RF0dO4fx; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RF0dO4fx"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8403DC0000FC;
	Fri, 24 Jul 2026 14:41:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8403DC0000FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929283;
	bh=a0Cfg7X+g3S2j3WgmrnppIxwpz2k3rDILWehus98x28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RF0dO4fxr+fXUcerTBF4BDXI8aar+8stV5nFdcqIKg5cJqwA3wvps+YdMx+XQv74x
	 Z1JTdJw2EXCfq7Sp20J8hQlWwLzttFUpiPsFcp+BfGhXnD007X+1FiCI4SazOx6an/
	 tcaFJRy70sO2JuWSkcM0aU1kPKWdSg7c2EiILzTs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 14C66ACE;
	Fri, 24 Jul 2026 14:41:23 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 9/9] um: Preserve errno within signal handler
Date: Fri, 24 Jul 2026 14:41:19 -0700
Message-Id: <20260724214119.1066665-10-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

commit f68b2d5a907b53eed99cf2efcaaae116df73c298 upstream

We rely on errno to determine whether a syscall has failed, so we
need to ensure that accessing errno is async-signal-safe. Currently,
we preserve the errno in sig_handler_common(), but it doesn't cover
every possible case. Let's do it in hard_handler() instead, which
is the signal handler we actually register.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20260106001228.1531146-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[florian: hard_handler() in 6.12 retains the to_irq_stack/from_irq_stack
loop from before the upstream SMP refactoring; errno save/restore is wrapped
around that loop rather than replacing sig_handler_common's existing save/restore]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/os-Linux/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b11ed66c8bb0..94abc9e3ec7e 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -190,6 +190,7 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
+	int save_errno = errno;
 	unsigned long pending = 1UL << sig;
 
 	do {
@@ -227,6 +228,8 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 		if (!nested)
 			pending = from_irq_stack(nested);
 	} while (pending);
+
+	errno = save_errno;
 }
 
 void set_handler(int sig)
-- 
2.34.1

