Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762584B8DF2;
	Thu,  1 Oct 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843080; cv=none; b=PjyVI95qiXRax7yVcbdhoeLmQAXdHAXzSWHqX/L4sKqOBir2QccGAE87ID0LjPG7kpWXxf0fi9VNiL6Yiaw5g9RQ+WZ16myWn/DGmnRuiW/Z0pI/5hPQS4QuAZ0pGqiEHFULKG9TKzLKRB9Gv/J2F7s2tcNzgAQNSG6tLHzIspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843080; c=relaxed/simple;
	bh=uUxVbAJFD0ONKElLX279ok1VDHKLisqJOgNdYvH1EM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GmHLwclDfaQLatXsaeb6ib8tb2RUQN/ncum8xZkXj2oz+pA2Gkj+vR68aVUNRg+7IfVnEwB3B5i4r+Vf8F1TWorL+sX6l6mtYqPkiCl/ieKCXXBgrKK1XEUdqURYAeR/DJcEhUPtGRQ3EMtHGMLWRYT3cOfXbUWdn14VBhmngzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=AV/+hu+Y; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="AV/+hu+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790843074; x=1822379074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dwZ6+Ny11M89ZBPSWHCcY4nVqs3E53TyZaHaH2FNxjU=;
  b=AV/+hu+YSyvhUrq3r+y9vT8WJR/g9cpvdlPGTW2GWDefG3n3x4OHHsgJ
   J2HKzpfaDWp+krAbe/ksrqlEEh/SyDGrSqGVje7/Yb7QLmRHSQyTb9loj
   aw3B1/ZXovgqpbS77JEELVu1w1Cw+DXTedQNlvxQ9A1hP+vQsc1R4KC55
   GAuAs5ye40rHMzzL/yaiDgG5p1TUe8cpdGqRqSj5O/I6/a+OgYu9+TY4J
   1u2s3pWTSHOSHMk3+vGe3OtgdVH3wHaQHAaF5HJASXe0e4/vN3BsIbnK9
   ZNxcHyp8/eucanUl2bewyv3yOnkYcJj4X/gy6bgQhni5QWO8DLi5KJLQ/
   w==;
X-CSE-ConnectionGUID: Rg9+v9BFRVey2C7lw34VuQ==
X-CSE-MsgGUID: 2lZptLmrSLOH0UT76MqrXw==
X-IronPort-AV: E=Sophos;i="6.27,134,1787011200"; 
   d="scan'208";a="29880503"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 08:24:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:4411]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.131:2525] with esmtp (Farcaster)
 id 585c572d-5cd2-4dd5-95a8-6793cabf42c1; Thu, 1 Oct 2026 08:24:26 +0000 (UTC)
X-Farcaster-Flow-ID: 585c572d-5cd2-4dd5-95a8-6793cabf42c1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 08:24:26 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 08:24:25 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
CC: Jan Kara <jack@suse.cz>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Bjoern Doebel <doebel@amazon.de>,
	<stable@vger.kernel.org>
Subject: [PATCH] selftests/filesystems: Fix idmapped_tmpfile layer dir ownership
Date: Thu, 1 Oct 2026 08:24:11 +0000
Message-ID: <20261001082411.1493072-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The recent idmapped_tmpfile selftest creates a new directory in tmpfs
owned by user ID 0. It then idmaps the mount as caller [0,10000) to disk
[10000,20000). The original uid 0 owner does not exist in the mapped
range. As a result, mapped_caller_creates_and_links fails at the
O_TMPFILE open because inode_permission() rejects MAY_WRITE access:

  idmapped_tmpfile.c:145:mapped_caller_creates_and_links:
  Expected fd (-1) >= 0 (0)

Chown the directory into the mapped range to satisfy the UID
requirement.

Fixes: d943e68edc5cb ("selftests/filesystems: test O_TMPFILE creation on idmapped mounts")
Cc: stable@vger.kernel.org # 7.2+
Assisted-by: kiro:claude-opus-5
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 tools/testing/selftests/filesystems/idmapped_tmpfile.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/filesystems/idmapped_tmpfile.c b/tools/testing/selftests/filesystems/idmapped_tmpfile.c
index bc411ab8281ea..77b96d0943578 100644
--- a/tools/testing/selftests/filesystems/idmapped_tmpfile.c
+++ b/tools/testing/selftests/filesystems/idmapped_tmpfile.c
@@ -91,6 +91,13 @@ FIXTURE_SETUP(idmapped_tmpfile)
 	ASSERT_EQ(mkdir(self->dir, 0777), 0);
 	/* World-writable so an unmapped caller still passes permission(). */
 	ASSERT_EQ(chmod(self->dir, 0777), 0);
+	/*
+	 * The directory itself must be inside the range the mount maps.
+	 * Left owned by 0 it has no mapping in the mount, and
+	 * inode_permission() then fails MAY_WRITE via HAS_UNMAPPED_ID()
+	 * before any of the tmpfile logic is reached, regardless of mode.
+	 */
+	ASSERT_EQ(chown(self->dir, MAP_HOST, MAP_HOST), 0);
 }
 
 FIXTURE_TEARDOWN(idmapped_tmpfile)
-- 
2.50.1

