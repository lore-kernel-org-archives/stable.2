Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81638D687;
	Fri, 24 Jul 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929678; cv=none; b=KxOCey92k/UibBTv8Htno+EYQp9RFIQTwfksNC5/BxK7+m+dPIBHELA5U2Q0qtUxSgWJ9dayoY46BTXW/A8ezryGfB9NzXo5klsCNw1d5H8Ov0bIP86FyL6ZvBcYHkpYVTDXymx4bUxP3ZJzc4KYv1dkMkqFmsYeUqJlhOcS53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929678; c=relaxed/simple;
	bh=WeY6EXWLASPU5s4Pi3iS3gMMXxDyW++YTi7U1oRTEl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pU/JupUXGlx4eWOt/oBmzkx3TktP+jG6fe9hl/h2e4ZRYMHErMHMim5QRlT2c1dS+AZgQ6rVz9jNRXHeuHFcXAbZGZUcJhbST/gxm+u3f9Q87qeUPO2wJ0MzRcPIXkkRHdPWqgoM22nIR/BuJCAJMNbLEhmAZIBXR/7i83xsaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BaWmbRWz; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BaWmbRWz"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 41717C0000FA;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 41717C0000FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=WeY6EXWLASPU5s4Pi3iS3gMMXxDyW++YTi7U1oRTEl4=;
	h=From:To:Cc:Subject:Date:From;
	b=BaWmbRWz2li0YD34PDN3e0Mj+sEwGhWboDX3sY/fqc0Kwd1jp8fibwt3kqmyRjbXj
	 7vzE2m61rE+cy+C4NfMEz3BN8ebpb8tNMGxlnN5zB+jvheM3uZLH/bAp/1uMLT9x+n
	 xgEhEpsGAaqwiS84y1iYFd4RfgEdkbLqEfhhsPvw=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 0ED55ACD;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
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
Subject: [PATCH stable 6.12 0/9] Kunit backports for older systems
Date: Fri, 24 Jul 2026 14:41:10 -0700
Message-Id: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
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

Benjamin Berg (2):
  um: Set parent death signal for winch thread/process
  um: Set parent death signal for userspace process

David Gow (1):
  kunit: tool: Terminate kernel under test on SIGINT

Shuvam Pandey (1):
  kunit: tool: skip stty when stdin is not a tty

Tiwei Bie (5):
  um: Add os_set_pdeathsig helper function
  um: Use os_set_pdeathsig helper in winch thread/process
  um: Set parent-death signal for ubd io thread/process
  um: Set parent-death signal for write_sigio thread/process
  um: Preserve errno within signal handler

 arch/um/drivers/chan_user.c            |  2 ++
 arch/um/drivers/ubd_kern.c             |  1 +
 arch/um/include/shared/os.h            |  2 ++
 arch/um/os-Linux/process.c             |  6 ++++
 arch/um/os-Linux/sigio.c               |  1 +
 arch/um/os-Linux/signal.c              |  3 ++
 arch/um/os-Linux/skas/process.c        |  3 ++
 tools/testing/kunit/kunit_kernel.py    | 39 +++++++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
 9 files changed, 88 insertions(+), 11 deletions(-)

-- 
2.34.1

