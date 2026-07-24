Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC946327C09;
	Fri, 24 Jul 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929291; cv=none; b=Kr9IZH3KL0XbE5IKWxgm9Xz1FsWZX7OQDdSTqwHl4B4gtY6MpjmV+3Ww88vObJEEH5YOmflzFOtgq+LoA3O03a9Gvz+fjtFtc1cxLHgcQheZuJ6m4lBVR1jYgpIVBqx9WKSrO3DHQxTpr5lvNX6HD6VrKCATU8GUVfUUzEMgD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929291; c=relaxed/simple;
	bh=X6hKdn2YSvvafi2mgHuWo3wbqEvQXzvfO9b69Ah5G9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q73pmu3mZu5PISiLKFAlQhTD5rsyzadsDWeHzc6HoofHz5SeHiRmMjPNs2qr/AZsctF4GrttWch7J76ATRgbFhhqJobtldjDFgagk5JY3ur8a236e73tSjxM02F0KFIbIcbgxvHIPFWrJlJkk9SsvNYMGKFLqAF3ABta6naxc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DxCwqt8v; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DxCwqt8v"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id DE90DC0003EC;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com DE90DC0003EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=X6hKdn2YSvvafi2mgHuWo3wbqEvQXzvfO9b69Ah5G9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxCwqt8vSB7LG+I6lGoGHH4diBONgRG14vAGZqmLx/sDE2y/bzZpJZuJQXPl92jia
	 btTEYJTDmKtEnmEfVE6FW6jI/EaMJA3o9YKu+yUrE2ydL4qO/9eYWzqPKImBoiuq2t
	 +mtQSbMwsHkgxKnp4A+nP9nM/T/cwbRlc5Hbe+Ew=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 7A579AD0;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
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
Subject: [PATCH stable 6.12 2/9] um: Set parent death signal for winch thread/process
Date: Fri, 24 Jul 2026 14:41:12 -0700
Message-Id: <20260724214119.1066665-3-florian.fainelli@broadcom.com>
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

commit fdb2ecd35d327a1fc6bba69b97f85b494e1f4b6b upstream

The winch "thread" is really a separate process. Using prctl to set
PR_SET_PDEATHSIG ensures that this separate thread will be killed if the
UML kernel itself dies unexpectedly and does not perform proper cleanup.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20240919124511.282088-5-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/chan_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index a66e556012c4..1434114b2f34 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -10,6 +10,7 @@
 #include <signal.h>
 #include <termios.h>
 #include <sys/ioctl.h>
+#include <sys/prctl.h>
 #include "chan_user.h"
 #include <os.h>
 #include <um_malloc.h>
@@ -161,6 +162,8 @@ static __noreturn int winch_thread(void *arg)
 	int count;
 	char c = 1;
 
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+
 	pty_fd = data->pty_fd;
 	pipe_fd = data->pipe_fd;
 	count = write(pipe_fd, &c, sizeof(c));
-- 
2.34.1

