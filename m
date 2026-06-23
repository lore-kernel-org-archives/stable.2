Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EF63D648C;
	Tue, 23 Jun 2026 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218621; cv=none; b=i1PY17xHtfgzmGyisp5GeV7TbggnVlT67+f2nO7gVaprThSEUQ/PcFAuhCA3zcqTEisnl1P9w6gCDktOzvzpguaOYkNQonVbYhwnHjN0O3DoEqWyuFEcYhiNo+c4VvBL07fx1pzI80k2zahcPbt3kdt4iQyAoIv0auGqPt2RkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218621; c=relaxed/simple;
	bh=BXtXOm5B6qhuPXucVvTrKproBQu/gXNwblc0a5BeRLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hGPrTd93OJ2TunEmSDPahISUII7Wo4H+hLEcJanhsTH27OBGKLbFsU9Bwsvtq6IcOIyQf6w90Nq5+0c74+t9wkWo3d5y2vVzZ8SgPRaVU20JYHU0NosEscBIOcNwZwE9/FfHdGBi21rzMGTFC8vfQ0Ine1K6jqpZIGpuyLqdyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W6OFYhR4; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W6OFYhR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=J/
	radkrB3pDFS0FKS2b3QlD+owbAySbqiZgS312jhuk=; b=W6OFYhR4ukxILTmujE
	K9cU9LnWJ+A3GOnj25hWEF0bvxzq3wzsjS033sXY4kKzj8RL3xIdTZFHGunjq19O
	erwFqjaBqFEDEqLMwzNZTIcUz8X98FTMr6Z5oO6PudZkFbtez3pyAj0xXGqk4lp0
	ld8tyuz8g1cYLYFoPY0pUjqjw=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHCxxZfzpqYyrLDg--.21141S2;
	Tue, 23 Jun 2026 20:43:08 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v3 0/2] misc: ibmasm: Fix out-of-bounds MMIO accesses
Date: Tue, 23 Jun 2026 20:43:02 +0800
Message-Id: <20260623124304.371163-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDHCxxZfzpqYyrLDg--.21141S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFW5AFyxXF4fWw1ktF4fXwb_yoW8Jr15pF
	s8W3yYvrW8ArZ2va9xAr1jgFy5Ca4xJFW3Wry7t348Zry5JFy5Ar1j9w15Xr4xG395tw48
	uFyUta4xu3Wjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2fUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5BwgBGo6f1yBfgAA3Q

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

This patch series fixes two distinct out-of-bounds (OOB) MMIO access
vectors in the ibmasm driver when exposed to malformed or fuzzed hardware
with an undersized BAR 0.

Patch 1 addresses the static OOB access during the probe phase.
Patch 2 addresses the dynamic OOB accesses via malicious hardware MFAs
during runtime interrupts.

Changes in v3:
 - Split the monolithic v2 patch into a 2-patch series to separate the 
   probe-time static checks from the runtime dynamic checks, as requested 
   by Greg KH.

Changes in v2:
 - Added dynamic MFA bounds checking in get_i2o_message().
 - Implemented hardware mailbox deadlock prevention.
 - Fixed potential unsigned integer underflow in bounds check arithmetic.

Mingyu Wang (2):
  misc: ibmasm: Fix static out-of-bounds MMIO access during probe
  misc: ibmasm: Fix dynamic out-of-bounds MMIO access via malicious MFA

 drivers/misc/ibmasm/ibmasm.h   |  1 +
 drivers/misc/ibmasm/lowlevel.c | 19 +++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 27 +++++++++++++++++++++++++--
 drivers/misc/ibmasm/module.c   | 13 +++++++++++++
 4 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.34.1

