Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1E45041A;
	Thu,  1 Oct 2026 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855202; cv=none; b=l+5il2I/LB927wUqGIRwlBIuQD0FKO2WHhypEEZkT62653mvMnMOiJejd4zD0dvPixG2HjtaDGo8bfKvqOk/O/01t0WJmiJYhG2wdbZ9bE3Ga4eFDBN9HxJtJwnTNOIo1sW9/AspPLMeOmo1AdRxXNmv/qjhM/q1+x6/g9kxom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855202; c=relaxed/simple;
	bh=22mN/Zqb8A3WZth5RnngnxilDkAVgwgza0/+NBs3OhE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hw/yT12KtVlGGBaoGUrcq2Pke1GhUYvSbZqHSqBdiLA7AifWgQUeyOKjP1zEgGx7K1aHmn83K3WrA++9my5KzVu/1ZOMANAEavz8TW7gkm6BAPsuQSBOsXfHDIvHJUEGdY//byP13zA9OXyqjesYJFfT8XaxNI+CdkodvHXCMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=pvzzaByO; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="pvzzaByO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790855189; x=1822391189;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cJ+4x9N5O37S/cvApiktNuhQViEjgHjtRgvMmynWYqY=;
  b=pvzzaByO0LEG6ra+7ZsvaWCp7boXHZLyYl2jfMzfJW8mBMl5LTCLNIZH
   VIOXaaca9V26J1WHgQmZTkrn6w3+ro3oHOlXa36XQTWU/OkzBrGO9qFEi
   ugtGOns1UmCD8NUSJ+Jx+EgtxHfW59UT37Ic5hONSUH4/P/KzAu3YP0P4
   Sf8Q2klpA4rsszhvGJ1hx2DPEbQFxb6U4aI+a0AxpK8/7Xj/qo4kN+atm
   Mmw7wOg0Ud5O2hu7kHPrDPsbySpKdCQ9WONZn3hC867e3VkP+AlDpYzrU
   dwssAjZZtBTffmsAkrjjWbGdw9YtjLZOTwTgsGG5cY55LUTAQJxlI+0Do
   A==;
X-CSE-ConnectionGUID: XpgKx7vcQjeaxpS3P9De1A==
X-CSE-MsgGUID: 1wgvd0sFRs6e4O5r+4A8EQ==
X-IronPort-AV: E=Sophos;i="6.27,134,1787011200"; 
   d="scan'208";a="30159232"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:46:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:3490]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id 7509f975-4b3f-4900-bdec-e7b1082dd49d; Thu, 1 Oct 2026 11:46:05 +0000 (UTC)
X-Farcaster-Flow-ID: 7509f975-4b3f-4900-bdec-e7b1082dd49d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 11:46:04 +0000
Received: from dev-dsk-nagornyi-2b-f14a9408.us-west-2.amazon.com
 (10.153.215.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Thu, 1 Oct 2026
 11:46:04 +0000
From: Nikita Nagornyi <nagornyi@amazon.de>
To: <stable@vger.kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y 0/4] fs/ntfs3: backport slab-out-of-bounds fix (CVE-2026-90048)
Date: Thu, 1 Oct 2026 11:45:45 +0000
Message-ID: <20261001114549.162469-1-nagornyi@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series backports the fix for a slab-out-of-bounds write in the ntfs3
driver (CVE-2026-90048, an Important / CVSS 7.8 issue) to 6.1.y, together
with its stable dependency chain.

Four commits do not cherry-pick cleanly onto 6.1.y, so each carries a comment,
where adapted. Applied in order:

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

Built and boot-tested on x86_64 and aarch64. Tested on Amazon EC2 using our
internal test suite, including xfstests, kselftest, LTP; passed with no regressions.

HE WEI（ギカク） (1):
  fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Konstantin Komarov (2):
  fs/ntfs3: Add more checks in mi_enum_attr (part 2)
  fs/ntfs3: Mark inode as bad as soon as error detected in
    mi_enum_attr()

Nirbhay Sharma (1):
  fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list

 fs/ntfs3/attrib.c  | 11 +++---
 fs/ntfs3/frecord.c | 81 +++++++++++++++++++++++++----------------
 fs/ntfs3/ntfs_fs.h | 23 ++++++------
 fs/ntfs3/record.c  | 91 +++++++++++++++++++++++++++-------------------
 4 files changed, 120 insertions(+), 86 deletions(-)


base-commit: 1a8763b93150b2c8f3992c27a5ce7857fee4ab0f
--
2.50.1

