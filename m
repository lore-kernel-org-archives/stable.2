Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E91384CF5;
	Fri, 24 Jul 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929678; cv=none; b=j7sTT53oLWaAXxfGiRgYUKfWh4wgFAFSrrkz1auzoZQ3Myu7yu9mjQU1tEdMpz9Fxvi53pRSsMX+nCJcBr76t/BtGZkEBuczCQepp8t8IP9Rih4WetZ0jD+joRQubaw82Ro1Bi7SvQfCEe4XmkZCA+sz8gC5ycu/B+ke/DFbGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929678; c=relaxed/simple;
	bh=wMjqlEZYnVh14Bap38tP88tLAFmuKutSDKQ4369eTWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfgAAFISlerDYH4OV4Troo6Yd+Zi7rO8U6ZZrVaudykSHasxUg0kaLEEXyBU+/tWLo3Wt1eCL4CHjWj0AYSouqEuD0vs8AwOn3r5PuW3pmNxg3m6skjE5zy8sCdYPOit6pbWTnXq84eJUYMSd7cNfrS1dYYOQ7uY6zI+h5uj878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eZlKS5H9; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eZlKS5H9"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9033FC0000FE;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9033FC0000FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929282;
	bh=wMjqlEZYnVh14Bap38tP88tLAFmuKutSDKQ4369eTWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZlKS5H9n0k9CSn7Quj4PBlP2j95+hScWQv203eAYsU9oldUR6byVp29DgK5cFezk
	 /b39+PjoHkoICuemlbQ8VdskYxiGL/elw4rucRNvgIQoDWoPU0W8QsKManTe46DEkA
	 E2MynffKOmid2RHm34nfBWuEgzWzaU/JVkYDXDRM=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 5FDE5ACE;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
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
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 6/9] um: Set parent death signal for userspace process
Date: Fri, 24 Jul 2026 14:41:16 -0700
Message-Id: <20260724214119.1066665-7-florian.fainelli@broadcom.com>
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

From: Benjamin Berg <benjamin.berg@intel.com>

commit 801e00d3a1b78b7f71675fae79946ff4aa3ee070 upstream

Enable PR_SET_PDEATHSIG so that the UML userspace process will be killed
when the kernel exits unexpectedly.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20240919124511.282088-4-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[florian: upstream applies os_set_pdeathsig() in stub_exe.c, a file
introduced in v6.13 that does not exist in 6.12; applied instead to
userspace_tramp() in arch/um/os-Linux/skas/process.c, which is the
equivalent entry-point for the userspace process in 6.12]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/os-Linux/skas/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index b6f656bcffb1..cca016b0b29b 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -214,6 +214,9 @@ static int userspace_tramp(void *stack)
 				     (unsigned long) stub_segv_handler -
 				     (unsigned long) __syscall_stub_start;
 
+	/* Make sure this process dies if the kernel dies */
+	os_set_pdeathsig();
+
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
 	signal(SIGTERM, SIG_DFL);
-- 
2.34.1

