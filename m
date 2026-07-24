Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA763B6371;
	Fri, 24 Jul 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929290; cv=none; b=UPYvemOXn7+BlBTRLZiRY7EpPukVWLA29zRvmZuzkZlhaYPt4Bo8memIxM1tFLYANfXiG91qhapH3KMPkr89Wo4a1v5DBM5r/dv8VqxFsgGg+uHiLvNGABduhuFQmkyXR1CYbmN+wNXpzggsS8CHXdvtzzjbtfhjv4ZSrLv5L+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929290; c=relaxed/simple;
	bh=MwClynYi4UNnl6Qv2z6qYYcDGD0umclzy3mfRtl6KE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=amHkpoPdueuf5hSQFLtF8jiwCWklV1mX1q4hgeEcit19Lp1iniqgYn6QYi1BS27VwT5ltnMuMQuj1LlHT01bVln3ZjOaAnR/90Qb0OMrWQeQ/h+bdmyqKgL6iSp4J5v7Gm6t/+hqW6EFY5iJkScWbuyF2464a1L77woW7qtodUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HbkSZXF6; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HbkSZXF6"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8F7AAC0003F1;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8F7AAC0003F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929282;
	bh=MwClynYi4UNnl6Qv2z6qYYcDGD0umclzy3mfRtl6KE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbkSZXF6FeBLqDbu0mITagG9fU09UAuSao2iEKeVgkTycc0QhkXC2sweyCb6I/Khp
	 4Wd0zWkWNTtKYEQra0UTqgsbQw0SY234WytDNj/pEC+EShYu4DkntRbX5BBq4Jvdix
	 lVi6CmVFZE4nw6kxfLM7C7RPodBNw+9HqKY4YOcA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 295C8ACD;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
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
Subject: [PATCH stable 6.12 5/9] um: Set parent-death signal for write_sigio thread/process
Date: Fri, 24 Jul 2026 14:41:15 -0700
Message-Id: <20260724214119.1066665-6-florian.fainelli@broadcom.com>
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

commit c6c4adee65969218b0b7b13f568fd2c6f2333373 upstream

The write_sigio thread is not really a traditional thread. Set
the parent-death signal for it to ensure that it will be killed
if the UML kernel dies unexpectedly without proper cleanup.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20241024142828.2612828-4-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/os-Linux/sigio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9e71794839e8..9aac8def4d63 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -55,6 +55,7 @@ static int write_sigio_thread(void *unused)
 	int i, n, respond_fd;
 	char c;
 
+	os_set_pdeathsig();
 	os_fix_helper_signals();
 	fds = &current_poll;
 	while (1) {
-- 
2.34.1

