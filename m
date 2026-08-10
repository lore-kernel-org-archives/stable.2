Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049B3A383A;
	Mon, 10 Aug 2026 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350895; cv=none; b=BpqlB9UZujA49q7Bkg0OMO8lhdR48ETLvkSiqWPhdFEZFVxs0xdOdh6Z2K0Np3hmmpqvfdp8+NgUPRYu3dTpOoDNjBoEP7s6cGiQMmVtHr5QRM5JAMo6nZS9JHnJ9fh1yhB7XUDxr3fTjJgrXQn5g+rAutHg3KRG1Mf67X3LYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350895; c=relaxed/simple;
	bh=zIgBtvSpT57XQu3RWyx/moS3BxsJUDg8BdyVeprlafc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1D9P8yMwk9IO/b3jC7iQkyBLzML8+MRUE0pflShkJXYyX5FErJ2qyFOxFNFdaj+BxztQVDwIUK0WJmXTwzz1Xsf/imdaEc+IlJHVSva2vimzAtSzlFY/XZa/jk8PvPXZxe/B96eMdcWGQZV2mzx5h7Bhxc6WXa7boZIVfSXLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=qnXAND4o; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="qnXAND4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786350894; x=1817886894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dr5xpzRAq8ouKRSIuMtlx0P9FeaQGvwwcGLMSQxZbl0=;
  b=qnXAND4oir7sQkzAVMtxGE5C94HTi5RWdFbeGOfmC8XkuRcX/3T9wT23
   cmNWG2D/bM6kbqMjv1bZx0KRfe7t1M+ICgPUtLyj3G68U8r3wUfgHYLAm
   jDmbxalBbsn6/cTgKZybGIiVQ6OdmpmncmEAfClOuYzOVocm8prQ+dqjd
   ZuCqY1AiCpVgls4M61u7Uhg27FxT6iEmal+e11hacuH2ZZddV7oXfwWVL
   KfhesnryLwiLh1vyL7xTwAaLoxI+3YARVELE2pCwJXcQun44FUL7f3qA6
   En9vqWYpN4ACAEgR0E6Y5i0GY3vFQd8llhMmwWVVcg8Fkq+Hiwc6sgIvt
   A==;
X-CSE-ConnectionGUID: aEbRFXLgRG+YgQsRuClmPw==
X-CSE-MsgGUID: bpHcGCrIQN+uPC6nhwvY6A==
X-IronPort-AV: E=Sophos;i="6.25,215,1779148800"; 
   d="scan'208";a="25585877"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:34:51 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:28268]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.171:2525] with esmtp (Farcaster)
 id d5956c16-b231-48d3-b785-2c3f609134e4; Mon, 10 Aug 2026 08:34:51 +0000 (UTC)
X-Farcaster-Flow-ID: d5956c16-b231-48d3-b785-2c3f609134e4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 10 Aug 2026 08:34:51 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Mon, 10 Aug 2026
 08:34:49 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Eric Sandeen
	<sandeen@redhat.com>, Christian Brauner <brauner@kernel.org>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Simon Liebold <simonlie@amazon.de>, <stable@vger.kernel.org>
Subject: [PATCH] devtmpfs: restore mount option reconfiguration on get_tree
Date: Mon, 10 Aug 2026 08:34:38 +0000
Message-ID: <20260810083438.764684-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in
public instance") converted devtmpfs to the new mount API but dropped
the reconfigure_single() call that reapplied mount options.

This causes userspace-requested mount options to be silently ignored.

To reproduce, boot a system where systemd mounts /dev with a size
option (e.g. size=4m), then check the actual size:

    findmnt -n -o SIZE --bytes /dev

On an affected kernel this returns ~50% of RAM instead of the
requested size.

Fix by calling fc->ops->reconfigure() after obtaining the superblock
reference in devtmpfs_get_tree().

Fixes: cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in public instance")
Cc: stable@vger.kernel.org
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 drivers/base/devtmpfs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b1c4ceb65026e..44683dde04377 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -72,14 +72,25 @@ static struct file_system_type internal_fs_type = {
 	.kill_sb = kill_anon_super,
 };
 
-/* Simply take a ref on the existing mount */
+/* Take a ref on the existing mount and reconfigure to apply mount options. */
 static int devtmpfs_get_tree(struct fs_context *fc)
 {
 	struct super_block *sb = mnt->mnt_sb;
+	int err;
 
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
 	fc->root = dget(sb->s_root);
+
+	if (fc->ops->reconfigure) {
+		err = fc->ops->reconfigure(fc);
+		if (err) {
+			dput(fc->root);
+			fc->root = NULL;
+			deactivate_locked_super(sb);
+			return err;
+		}
+	}
 	return 0;
 }
 

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.50.1

