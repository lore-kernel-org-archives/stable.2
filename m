Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A44385D6C;
	Fri, 24 Jul 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929679; cv=none; b=mQcw2gEJLIvlTCyIsc2YTxhu48FlOlHq57V3OZlhIBOc2wD8LSKn/14ZZdKw6Pf+rUATV2bLeiUqWcdPADx7WegyeXyEhZnvtH6JbUkmv/RmoVDPH5vemI83SdGjHevigINNyPPo28cqADvr2zlnryRQdEG/ppFdyJLc9zYQoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929679; c=relaxed/simple;
	bh=QbIyHuCTZXlWeF4J0dDRY0wdd72yASGiNYrryz+pe/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwYdWIPaznWJhmuZGlzJWgBx2J+/DW05zfq4TVqXhLInK698wCMDMHGpDuoEtOQu1d2eduXpwfvVvqNvwbAwvA1Vdxqq3Y3CaFFeJ+kD9SQZXnukYrgK6AZ4COYJOkRMFp1Cr6rV/f0XFq7/HhJ8TrjeQA6Q4HaSB3up0vZC3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QFbsERre; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QFbsERre"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 217EFC0000FB;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 217EFC0000FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929282;
	bh=QbIyHuCTZXlWeF4J0dDRY0wdd72yASGiNYrryz+pe/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFbsERreLH4vaLK/6Wf3eBAZ59eS1Bk3UPqa3P5uvAKAjNEVkLiR+vON2Ne7fqezt
	 yGcsobjQNsttIoMqAh5d85oXKLtK7EwEzAOw94I2kASE0LXN/FmQ/58jtDzVvhEQuD
	 aCRflgvsZuKuxKAQ8/YjYNThvx9U0PJrGxcDRblQ=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id E7A4AACE;
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
Subject: [PATCH stable 6.12 4/9] um: Set parent-death signal for ubd io thread/process
Date: Fri, 24 Jul 2026 14:41:14 -0700
Message-Id: <20260724214119.1066665-5-florian.fainelli@broadcom.com>
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

commit 9b5e6c0f5a9199c69af81ac5bedc512ee7dc20b3 upstream

The ubd io thread is not really a traditional thread. Set the
parent-death signal for it to ensure that it will be killed if
the UML kernel dies unexpectedly without proper cleanup.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20241024142828.2612828-3-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/ubd_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 2bfb17373244..66c1a8835e36 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1501,6 +1501,7 @@ int io_thread(void *arg)
 {
 	int n, count, written, res;
 
+	os_set_pdeathsig();
 	os_fix_helper_signals();
 
 	while(1){
-- 
2.34.1

