Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DB3ACA74;
	Fri, 24 Jul 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929290; cv=none; b=iScdhlqIoiiD2Nusq6UVncySvKZ9aSgFGgjpXwQiTSvvqo6HYiMuYykf28QXufOXkNRoUP2hipDk5LmwT6FiOyoj5LC0IqpXiwRQ94v1YosRstXDda7aSmI4cSwuqx6xcHSSK7ONJrBXNEkSW/K2Mp5m7qsDKp8qB6fzrZ9641E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929290; c=relaxed/simple;
	bh=rP/30eNjoWdGI0nVXvPpYsc/XoqP1bck1OwJZBCRtDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CM/vwx2GFbxn8Eauna7RP+qDQH/jEUtq9BTUn+FaZ4KQp1J6xUgJyEF9HjqEBt9109knSDPOcX0ScJAySRrXEkA5RmGyyOWwyIwwIpkOsgEWlxCOCJuVIJ7W2DjeioDjIbTqPhFOmpHh/Q7pAhtO96gJZnRFfk1BwmUYIQVNOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=tCZhj/ao; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tCZhj/ao"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B50A5C0003E3;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B50A5C0003E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=rP/30eNjoWdGI0nVXvPpYsc/XoqP1bck1OwJZBCRtDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCZhj/aoM02YOJgrXSJuLE5MsTsniRiQLjDAj2lRvUIAJfR33ONYYRCRCgL+5uS3H
	 9bR772mRXHQsgJTXu2JgZMi9GkUihcHfzFhfRwBJP7xaHslKMDYGK7+F83gfJNCLXk
	 vjMadfh8ZYqiFoCAN0PfLwtJDCCOCe6KE7+Oej1w=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 43C9BACE;
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
Subject: [PATCH stable 6.12 1/9] um: Add os_set_pdeathsig helper function
Date: Fri, 24 Jul 2026 14:41:11 -0700
Message-Id: <20260724214119.1066665-2-florian.fainelli@broadcom.com>
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

commit 4e5adbe447db382cc76e05613581f96aef4f91d2 upstream

This helper can be used to set the parent-death signal of the calling
process to SIGKILL to ensure that the process will be killed if the
UML kernel dies unexpectedly without proper cleanup. This helper will
be used in the follow-up patches.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20241024142828.2612828-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/include/shared/os.h | 2 ++
 arch/um/os-Linux/process.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 77a8593f219a..2a0843cc2208 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -219,6 +219,8 @@ extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 
+void os_set_pdeathsig(void);
+
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 2686120ab232..4015d3dc3958 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -12,6 +12,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
+#include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
 #include <init.h>
@@ -234,3 +235,8 @@ void init_new_thread_signals(void)
 	set_handler(SIGIO);
 	signal(SIGWINCH, SIG_IGN);
 }
+
+void os_set_pdeathsig(void)
+{
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+}
-- 
2.34.1

