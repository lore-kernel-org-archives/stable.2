Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5968361979;
	Thu,  3 Sep 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474883; cv=none; b=qg+9o3Kl9biF5/ELiUc8v7Zvt6O7aHSAia+DPMuJUdNcRmyIaCEMsAXnMlI+bJTChfHBydOcCk+xZKVQgtOhHLUg+BTnlPZZ2aPHnM61ak1EHZk4sfOha4q4yWniisX6aKn947++HrDAnB/yom4Pgy8cG90TWWX2ajmS4CXwM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474883; c=relaxed/simple;
	bh=8LjHDQQElRP4E4Kj0EKSD4zlgW3GkePkRkvT6/d6dkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uYmOF2YOaB/zIBhBIG3GOoy7SLBiZopbtmxdZ7u/BnaIvIX8x27r5dyxN0n7WlIH1OR39D8PAVOwcDdWHf6K1iYmG2EhiTzKGrjGHFUU8qo7ggQ/2yGTcP4VjS7S410DKA/dB5anUDV7GS0JO+zFD30M0EkHZfOH9MK64wG6Alw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sYMuKSlD; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sYMuKSlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788474882; x=1820010882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wQHtafO+2PZp5fDHu8SdXIgV6dsbXhD0ZZCiMht7hug=;
  b=sYMuKSlD2hd6hvxlz+7UGCsmtOyuf8OZy559a5lS9uvp9IWQIBUCmhMT
   aam+VfOBeWh5TgVtC7yymR9D5DhWZ6sO+csqCtgUQYQkfgnNcquE/8Aoo
   h4Iaa48GrV0ub9u9MgI2oHyEL8PUMyuhf45XL7iEFS1qlVSNFKYcObOTa
   WSdtnqmRxHz3j+NaxA8zOXDmkp0+R7u3CUNzl2cs8FBzfGOgosezMjVOX
   60wUzPohf9JHUcPTRe6yi8xT5rtChzMDu+/jo8djViTLnGtdsgaXcLymj
   uJ32kJG/ZIkedmF53X/M+RAQ7BrFREwFYLfm+8jfAH1kUonehLu26+vdv
   Q==;
X-CSE-ConnectionGUID: Sj+fJK0DQRWNmduAlgzh2g==
X-CSE-MsgGUID: HOLHUP2QSQSSrVMfDj1iBA==
X-IronPort-AV: E=Sophos;i="6.25,260,1779148800"; 
   d="scan'208";a="27268212"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:34:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:31183]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.234:2525] with esmtp (Farcaster)
 id 024a6efd-d29a-4060-8432-ed8ca77689f0; Thu, 3 Sep 2026 22:34:42 +0000 (UTC)
X-Farcaster-Flow-ID: 024a6efd-d29a-4060-8432-ed8ca77689f0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 3 Sep 2026 22:34:41 +0000
Received: from dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com
 (10.189.247.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Thu, 3 Sep 2026
 22:34:41 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, Paulo Alcantara <pc@manguebit.org>, "Matthew
 Wilcox" <willy@infradead.org>
Subject: [PATCH 6.12.y] netfs: Fix netfs_read_folio() to wait on writeback
Date: Thu, 3 Sep 2026 22:34:38 +0000
Message-ID: <20260903223438.2312-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: David Howells <dhowells@redhat.com>

commit ded0c6f1606061148c202825f7e53d711f9f84cf upstream.

Fix netfs_read_folio() to wait for an ongoing writeback to complete so that
it can trust the dirty flag and whatever is attached to folio->private
(folio->private may get cleaned up by the collector before it clears the
writeback flag).

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-23-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 fs/netfs/buffered_read.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index d99284e35126..fd41e38aedb7 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -565,6 +565,8 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	int ret;
 
+	folio_wait_writeback(folio);
+
 	if (folio_test_dirty(folio)) {
 		trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
 		return netfs_read_gaps(file, folio);
-- 
2.47.3
