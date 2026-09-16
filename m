Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6884E2F35;
	Wed, 16 Sep 2026 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600538; cv=none; b=kNa4H6+YfXaqwETqVd0y3UV7nElDvlpduqCAImtLJyEU/3NKvpdsuJmdC4jR+gjXnIWdQrsnKQAOS0lS6zDW84OCN1bCQNln0+iaKuJGH40SIDLpttb9JbslVxwkyjMcQHwkJZ4oDewMuZzeB7dRJGlSrv6bEymjGnu10aXLyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600538; c=relaxed/simple;
	bh=ca6lbr7wC1+lUpAgeUoXIoCrLo2Z7L/ATuhGgXdAd88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DGt88/xoSaYvu+z1+YBK1p8waPy+fo8iPnM+eKuoL28S9S3CJvy6Pj5lgcfDDxng6+ZDb+bhQBjmWDhjVJfjo3E6QTm8PUD8dS8JA2gkNt2JYuyS6r2/VlLJs3Ao7YyAaE+vhi9+26cmO1JLXUHUOemRCMy4YWy0LCh7GQ9+FKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZfGkcAXM; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZfGkcAXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789600535; x=1821136535;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LTzfF0ba3sVoZXZpxsz+WNjWVEl6ayiNWdWiX2wMLEQ=;
  b=ZfGkcAXM7IWm3pPrQaBRsw3XZ61fwzbbeFrY4r+j1iKs1HbwR4JxKR9N
   fLROXgg8OXiHZDgAy4uqs83Uxsoot53f0J0HVFuLPxERr1AacghQQHiR6
   quLJ/ak+eTHZBA1WoXP8P7hyc7NioXAx+VQEWBZoFwuIex8AtEKrr5Q07
   gd9JjndDrvv6vqOfHiyiqzWvfJRUZn+JLi+0WgZFh4rqihm/upcGFA9Vl
   yEHpX9YNkDpqmx0DGB6UsS2xFLYGELrZrCMU6ffpu21tfRAV77UMKUso9
   ioaivdVfuL8RrSjUpKoqpTGitTfVlhvSPFemP8vhP1L81Lge33YhfcPKj
   w==;
X-CSE-ConnectionGUID: sJG9NG0YTt6Msxk8nAjAJg==
X-CSE-MsgGUID: lV6ugIeOSoKddvXBdCjX3A==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="28910240"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:15:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:20482]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.137:2525] with esmtp (Farcaster)
 id bf4ca4c1-1aca-4897-b613-c1b1dfeed924; Wed, 16 Sep 2026 23:15:32 +0000 (UTC)
X-Farcaster-Flow-ID: bf4ca4c1-1aca-4897-b613-c1b1dfeed924
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 23:15:31 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.170.36) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 23:15:31 +0000
From: Nathan Gao <zcgao@amazon.com>
To: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nathan
 Gao" <zcgao@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] selftests/empty_mntns: fix unknown_flags_rejected using a valid clone3 flag
Date: Wed, 16 Sep 2026 16:15:17 -0700
Message-ID: <20260916231517.26147-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

unknown_flags_rejected passes a supposedly unknown flag to clone3() and
expects EINVAL.  The flag it uses, 0x800000000ULL, is bit 35, which is
CLONE_NNP.  CLONE_NNP was added in commit 24baca56fafc ("clone: add
CLONE_NNP"), which got merged about the same time as this test, so the
bit was still unused when the test was written.  The clone3() call now
succeeds and the test fails.

Use bit 63 instead.  The topmost bit is the last one that can be
allocated, unlike any low unused bit which can more easily become valid
silently.

Fixes: 5b8ffd63fbd9 ("selftests/filesystems: add clone3 tests for empty mount namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
 .../selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
index 6370086f886df..72c20130a627f 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
+++ b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
@@ -869,7 +869,7 @@ TEST(unknown_flags_rejected)
 
 	if (pid == 0) {
 		struct __clone_args args = {
-			.flags		= 0x800000000ULL,
+			.flags		= (1ULL << 63),
 			.exit_signal	= SIGCHLD,
 		};
 		pid_t ret;

base-commit: 9b87fdc9af2fbfcdb5c24a64139685ef80f6573f
-- 
2.50.1

