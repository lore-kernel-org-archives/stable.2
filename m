Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1835C6B9;
	Thu,  1 Oct 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855189; cv=none; b=miQvoYUg+A811hubouU7qLBZQUnp6B2wXXDg4Lniqj/HdWiOfTToeRWnA4jjtLNtJ5Q6HoLa3z4ov5YH4FwgLiI/7+MbykAjZLFVkNobNc5AcYfEpWa4IRz3Xc7BrKS7PFoER+h5QMKkCFSTsojGVJhRXjEiK7HCgS3GufSRUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855189; c=relaxed/simple;
	bh=4ZWZtMXN1aSjphYbCwNBjieNLlNhXb6CvZNvpdaaO0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfd2vQMiCcXfSAXX8n+wcABC9wNqozeElKcIdJdvAevJP5jUAVc4dYCRRnNTs4ESfbBaZdrHj0hLeUSnpamc9vtU50TOnmu80AnDPousFJzrAeCFQ6CKGYxkUTU/M8+1XHzPNKDlMy78B4eZxMJLkKDfkv1FoPwPs3ihzMdnkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=k1rDVWiN; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="k1rDVWiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1790855186; x=1822391186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Db9QrehIZz8X1781lunxC6KFaA0W95KmY5YeV3co03c=;
  b=k1rDVWiNczbJmm59pOayefj+QSkOrv2WF5iaZEWtkrLVLhTLfmV2w/EK
   +KCs7gcWDPZUDg6giDIY4PC4ooFARl86jbF+Zwb+UBqATUl/K/nFSQAzf
   h5Ry1LdDoezbljWVp5QZ7OO2dibhpjOVoQL8tlO86K69V6PptX4SzlP43
   cKdmtdUl+2vh/L0nbivCfSNcjYSK2kdtFgJIVh4MmD3eGjXT22w3QcEtw
   QTYdA4ku5pVZiMJRJfsetlmvQIAs0h8sfnnmLwwNUIvk95T1fUSgeP2uw
   ytobIqBE9FIaX1VFcFI1IBFxjyQ57V6+QZ9GHqlA9FDI1YH8eM8Vvn70u
   A==;
X-CSE-ConnectionGUID: QiFOslkhSZeCVRDOjZuUow==
X-CSE-MsgGUID: zprT0/xsT12VKvW4tewoGg==
X-IronPort-AV: E=Sophos;i="6.27,134,1787011200"; 
   d="scan'208";a="30159236"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:46:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:23414]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id 29d25138-0bb8-4c7e-9cc8-f00ee3ff6347; Thu, 1 Oct 2026 11:46:05 +0000 (UTC)
X-Farcaster-Flow-ID: 29d25138-0bb8-4c7e-9cc8-f00ee3ff6347
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 11:46:05 +0000
Received: from dev-dsk-nagornyi-2b-f14a9408.us-west-2.amazon.com
 (10.153.215.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Thu, 1 Oct 2026
 11:46:05 +0000
From: Nikita Nagornyi <nagornyi@amazon.de>
To: <stable@vger.kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	<syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com>
Subject: [PATCH 6.1.y 3/4] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
Date: Thu, 1 Oct 2026 11:45:48 +0000
Message-ID: <20261001114549.162469-4-nagornyi@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261001114549.162469-1-nagornyi@amazon.de>
References: <20261001114549.162469-1-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Nirbhay Sharma <nirbhay.lkd@gmail.com>

[ Upstream commit 5f33da04e6ceee849e76e6592cc283c72fef7af9 ]

The call to kmalloc() to allocate the attribute list buffer is given a
size of al_aligned(rs). This size can be larger than the data
subsequently copied into the buffer, leaving trailing bytes uninitialized.

This can trigger a KMSAN "uninit-value" warning if that memory is
later accessed.

Fix this by using kzalloc() instead, which ensures the entire
allocated buffer is zero-initialized, preventing the warning.

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Backport to 6.1.y: 6.1.y's ni_create_attr_list() uses a `goto out` cleanup
  convention rather than upstream's direct returns, so only kmalloc -> kzalloc
  was applied; the surrounding return/error path was left as is. ]

Signed-off-by: Nikita Nagornyi <nagornyi@amazon.de>
(cherry picked from commit 5f33da04e6ceee849e76e6592cc283c72fef7af9)
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 17559fca5984..c9d0947651c4 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -819,7 +819,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
 	if (!le) {
 		err = -ENOMEM;
 		goto out;
--
2.50.1

