Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71DF4E2349;
	Fri,  9 Oct 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554094; cv=none; b=rDU6ViWZeEeRYEdHxsQ0uaNEZ0K9+DPRzyNk9yrrEq/f/cpQsdBZGdliRdRoS9XdG2z1JH4hpNqVwxgI8+ZmHaw58sMDcAbltn3dF9nGWdHzIptpOqR94LuUPMvDM9E55qcCgNv6F9/ZiMFy9fPvyd9jXRUbR5VKfJ/wS3ZCpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554094; c=relaxed/simple;
	bh=AIZjWTMqWsLo2oEv2Y3wI6HHlQqDkrXnavxPC90Bu/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1oFtuU1pMTsaKJdaNVf7Mc5n3sTU2UsZOVdjA08Cp7XmB4aYWJk7j6iGnzA8nXvDUJc2z08Hl+ISczQyhAyI337YTMRtxw+o9r+JfqFHmUtASNRb24oI6s52Eg5mOOPC9PBqZeCjb9spJVT++3OrK6W0y0iaYUZq0NWlC+rnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=t0iRBlwS; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="t0iRBlwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791554091; x=1823090091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YwJYEm1P2DcnJV6ReceagIMl2e4ym+juUHbTkuuWSlI=;
  b=t0iRBlwSfgOoAkuXBdhk4OKgVIF8/66AoYxcphcVKLbxz9+ivxqXY9TM
   PCjewuenbLq9anro030MwvuUnn78I1xYonDs6Xr+eY/CoFA8Hw4/PvGrf
   JUYI4d5RcN6ELnkBSG806qPk1k4oA/KnhDenguaGJT18MIR/Pk33go50L
   0vZv5Eta+UgyarcJ6HdpjNdYxelTSKjIVhoCge/CkEivrQlrZOnDHQ1aZ
   EhVmOyEnDouI8Bcj5oXrRMZvEY0Fra4ZrimwkF7n+O7LYWl1RcVojFNaI
   lOYN/cF5WDn15/Hdd9F958xBoMr5OcP2AQedyUdTbFn+rHFkyfk5tslpz
   Q==;
X-CSE-ConnectionGUID: QwZDK0TJTdKkmwXfu3IqdQ==
X-CSE-MsgGUID: DE0ozWvwSHuSm+7VAu4LYw==
X-IronPort-AV: E=Sophos;i="6.27,148,1787011200"; 
   d="scan'208";a="30871085"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:54:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:29640]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.82:2525] with esmtp (Farcaster)
 id 4ded14a8-b30a-4500-87ac-d246a884f6e5; Fri, 9 Oct 2026 13:54:48 +0000 (UTC)
X-Farcaster-Flow-ID: 4ded14a8-b30a-4500-87ac-d246a884f6e5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 9 Oct 2026 13:54:48 +0000
Received: from dev-dsk-nagornyi-2b-f14a9408.us-west-2.amazon.com
 (10.153.215.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Fri, 9 Oct 2026
 13:54:48 +0000
From: Nikita Nagornyi <nagornyi@amazon.de>
To: <stable@vger.kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y v2 0/4] fs/ntfs3: backport slab-out-of-bounds fix (CVE-2026-90048)
Date: Fri, 9 Oct 2026 13:54:11 +0000
Message-ID: <20261009135415.850568-1-nagornyi@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series backports the fix for a slab-out-of-bounds write in the ntfs3
driver (CVE-2026-90048, an Important / CVSS 7.8 issue) to 6.1.y, together
with its stable dependency chain.

Applied in order:

  a8f659ce14f8 ("fs/ntfs3: Add more checks in mi_enum_attr (part 2)")
      - dependency
  2afd4d267e6d ("fs/ntfs3: Mark inode as bad as soon as error detected in
      mi_enum_attr()")
      - dependency; introduces the struct ntfs_inode *ni parameter threaded
        through mi_enum_attr()/mi_find_attr()/mi_insert_attr()/mi_new_attt_id()
  5f33da04e6ce ("fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list")
      - dependency
  7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in
      ni_create_attr_list()")
      - the fix

Patches 2/4 and 3/4 needed adaptation for 6.1.y and carry a
"[ Backport to 6.1.y: ... ]" note describing the changes.

Built and boot-tested on x86_64 and aarch64. Tested on Amazon EC2 using our
internal test suite, including xfstests, kselftest, LTP; passed with no regressions.

Changes in v2:
- 1/4: add the missing "[ Upstream commit a8f659ce14f8f734894227ba2c5ca78c8451501e ]"
  tag (Sasha)
- 4/4: return -EINVAL directly when lsize == 0, as upstream does; on 6.1.y
  the out: label in ni_create_attr_list() returns 0 because 14f527d44de6
  ("fs/ntfs3: Correct checking while generating attr_list") isn't in 6.1.y,
  so the v1 "err = -EINVAL; goto out" reported success (Sasha). With that,
  4/4 matches upstream and the backport note was dropped.

v1: https://lore.kernel.org/stable/20261001114549.162469-1-nagornyi@amazon.de/

HE WEI（ギカク） (1):
  fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Konstantin Komarov (2):
  fs/ntfs3: Add more checks in mi_enum_attr (part 2)
  fs/ntfs3: Mark inode as bad as soon as error detected in
    mi_enum_attr()

Nirbhay Sharma (1):
  fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list

 fs/ntfs3/attrib.c  | 11 +++---
 fs/ntfs3/frecord.c | 79 ++++++++++++++++++++++++----------------
 fs/ntfs3/ntfs_fs.h | 21 ++++++-----
 fs/ntfs3/record.c  | 91 +++++++++++++++++++++++++++-------------------
 4 files changed, 117 insertions(+), 85 deletions(-)


base-commit: a500ba24937a966eab140b95eac42782a7ce2c85
-- 
2.50.1

