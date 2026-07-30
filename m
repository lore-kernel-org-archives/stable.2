Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03C469821;
	Thu, 30 Jul 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438222; cv=none; b=dDcNuDkiTU0CJ+siBCxppcGI8WwwX3wwqg8QLZ+i3TJDLBsA9xnhfRifVnS5eO331dvlTWlBSj5WZpcec6wOqY6JYHpnkkaf+KzV5TG6Y7dZj3mEC3D+0E3kluZvXUmjpKKuVGA4suShRl0NQRsJarxKqhOTQUOrkc2RwiCOQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438222; c=relaxed/simple;
	bh=HgBI0p3L78A2gotBtRXW+DqrxGUnWnjoc1ImI8EwE6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNKZn7mD5cGDV5i9XH4eZ36GxQIDS31TNRQNUE8IbIVASueeyN97Iqva+zIqGpJA7NZ4wowUEzJZrdMB1NDEpz+pDlTxyzuyQM+NCNH/YFe0LoxSBSwNs54X2P7hmq07hmNGUc4Qr8nPA5sTz4G3dF5zxJR3you42WqL0f7GeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=nHEFK/Hq; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="nHEFK/Hq"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 309B6C0000D6;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 309B6C0000D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1785438213;
	bh=HgBI0p3L78A2gotBtRXW+DqrxGUnWnjoc1ImI8EwE6I=;
	h=From:To:Cc:Subject:Date:From;
	b=nHEFK/Hqfyuiu+tmUEQ1GQ5PNfZiZ5Imb0eoZcwf4gJgu7OcW+nHKXBgUZjj5liqt
	 77IFOYSYUTL+bd1gV+Km3j9CGju2yzu7OcaELc02e14fxFDkUfOfzDR2MHtu6bB2g4
	 DwiaFdX/d7/IK1h3F+c8CMpjDTiIGZkm9BC0RPTY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id EBFDFADD;
	Thu, 30 Jul 2026 12:03:32 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH stable 6.18 0/2] Kunit backports for older systems
Date: Thu, 30 Jul 2026 12:03:27 -0700
Message-Id: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses an issue we encountered on older Ubuntu
20.04.6 LTS servers whereby running Kunit would not return to a prompt
and it would not be possible to Ctrl-C the running session either.

David Gow (1):
  kunit: tool: Terminate kernel under test on SIGINT

Shuvam Pandey (1):
  kunit: tool: skip stty when stdin is not a tty

 tools/testing/kunit/kunit_kernel.py    | 38 ++++++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 11 deletions(-)

-- 
2.34.1

