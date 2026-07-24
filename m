Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260235E930;
	Fri, 24 Jul 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929786; cv=none; b=N2HjxaW4MnlXLv7D5v3EEDpVO02R+h9oNVVqtkaYNCHQLcEPFpaeTJdX0Q99VX+032809oGRZufICSBarD7oYFbJpyL8cQeBQZoMwF1dg43Q/QxI5UZ3jRVI2t1gMfjc9onm50XFh1VsdIUoYMBjJUtT6HG+ca0yKYQE7GinsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929786; c=relaxed/simple;
	bh=QHfTE5bRcdLZyxMFDgb7aIpXRPUd7y2ghLn7Xo3L0Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pUvb8CC1WYTo4E8Ad5dKrhOS+zWFYmB9d1+lJbqoQrPMOmZFdDLbQRvL02Uy2JiBt1Fp+zVO8fx1I6VAjklUgJpy/VDrwVX8nAHdL1rKvNd9uCkBXfNnKYa+9/FqcZKiJGaMorS9DsAJtuBVPWVTdaEJxiaAwOhoYoJPeMu1TCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=sZetw17M; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="sZetw17M"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E1CE6C0000E0;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E1CE6C0000E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=QHfTE5bRcdLZyxMFDgb7aIpXRPUd7y2ghLn7Xo3L0Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZetw17MNfDTmcMCyWhrDsMrGlDm+5hpAZVnHCWCdi1hjm8ADC5sWofvUbnfzcbqN
	 9EANnpQoIB1kVXwciOa0qq+1SYrCtaczU5rAeWonKGeP4uud9DCpGt5AQH9/2qDWPD
	 VijDBnUb7x77DO1OMJMiuO7WgvBRQEuu80BM48c8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id B1E98ACD;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
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
Subject: [PATCH stable 6.12 3/9] um: Use os_set_pdeathsig helper in winch thread/process
Date: Fri, 24 Jul 2026 14:41:13 -0700
Message-Id: <20260724214119.1066665-4-florian.fainelli@broadcom.com>
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

commit 42b8b00c8ab1ac18fccde3f29ee589626a561ea7 upstream

Since we have a helper now, let's switch to using it. It will make
the code slightly more consistent.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20241024142828.2612828-5-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/chan_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 1434114b2f34..35f9beeb19b3 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -10,7 +10,6 @@
 #include <signal.h>
 #include <termios.h>
 #include <sys/ioctl.h>
-#include <sys/prctl.h>
 #include "chan_user.h"
 #include <os.h>
 #include <um_malloc.h>
@@ -162,7 +161,7 @@ static __noreturn int winch_thread(void *arg)
 	int count;
 	char c = 1;
 
-	prctl(PR_SET_PDEATHSIG, SIGKILL);
+	os_set_pdeathsig();
 
 	pty_fd = data->pty_fd;
 	pipe_fd = data->pipe_fd;
-- 
2.34.1

