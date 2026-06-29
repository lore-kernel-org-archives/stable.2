Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563734218B8;
	Mon, 29 Jun 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744282; cv=none; b=eFgY8X+2MMvGDrldNGgrLpYGtfs9f76r/aIFrTe5rj4ei7DUh2jlwZQwASWI6wPI87nQ4eTeqRqzRGkPuqj/Agq1Erke1hISMSOUw2mmFq+VwpTe6tEGavOi11QSjBV3+oUT/VpJNRF945wISgLGWjAh+8YbMBtpr+tsNQkv8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744282; c=relaxed/simple;
	bh=P6RH3uPza7/i5npkvxetS0N9j86oYtT4K5gIPNjKzVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyZQ4YFVfgmvSvw+tO3BDoFjEKGEfCQR6/slVYZqFdk8qqHYKwyfDnxYEZu74tOraJ2H1aQwUToGFiRHSNJwNfHu+RCzrQs4D+nc5UdR7Rto790+yj3s1EBrAdqS4zpC5dfEjjj7ulzoxyu4QphUvvrFYw9IBI7pUjLBZakOQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTWtaIYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTWtaIYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B81F000E9;
	Mon, 29 Jun 2026 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744280;
	bh=Kd7LVRXhQqayNdQaCsVNZXfiEHFjU+l0jmqRhEGwXDg=;
	h=From:To:Cc:Subject:Date;
	b=UTWtaIYqyHgFCVTDkmRR45eFK42+RqOpV3re+1jd3KS79Sp3M4K+ZiuhLtRWwk4Qd
	 aKQQ4R64rEd1TknW7eV9p2gTLWNyu8HNDkFcmJBgd9GAswNC+k3Abvi/CT04uPMo3W
	 y9XPNuUtXgGJS1wAa21xEzVk74TnJF/xlocVKLgMmlJj0fPy92WQks7zyLoyi5rZKh
	 tEytiM2ItM1+2pDQ61EVDjhU2U9R2yYj3Raz06K99THaxdRX5q/1Nc2+CgLwNzodLF
	 09z9r9CEQledrfb5WAADN0HHUR58VtjRIe+kaXBhy91tA07FATCiBppXicTlXYg5dx
	 eLQGxjrn8AsOA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v3] samples/damon/mtier: fail early if address range parameters are invalid
Date: Mon, 29 Jun 2026 07:44:31 -0700
Message-ID: <20260629144432.133962-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zenghui Yu <yuzenghui@huawei.com>

The comment on top of `struct damon_region` clearly says that

    For any use case, @ar should be non-zero positive size.

which is now verified in damon_verify_new_region() if the kernel is built
with DAMON_DEBUG_SANITY.

The WARN_ONCE() can be triggered if the mtier sample module is enabled
before node{0,1}_{start,end}_addr have been properly initialized, which is
obviously not good.

 ------------[ cut here ]------------
 start 0 >= end 0
 WARNING: mm/damon/core.c:217 at damon_new_region+0xf4/0x118, CPU#59: bash/341468
 Call trace:
  damon_new_region+0xf4/0x118 (P)
  damon_set_regions+0xfc/0x3c0
  damon_sample_mtier_build_ctx+0xe8/0x3a8
  damon_sample_mtier_start+0x1c/0x90
  damon_sample_mtier_enable_store+0x98/0xb0
  param_attr_store+0xb4/0x128
  module_attr_store+0x2c/0x50
  sysfs_kf_write+0x58/0x90
  kernfs_fop_write_iter+0x16c/0x238
  vfs_write+0x2c0/0x370
  ksys_write+0x74/0x118
  __arm64_sys_write+0x24/0x38
  invoke_syscall+0xa8/0x118
  el0_svc_common.constprop.0+0x48/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x54/0x370
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x1ac/0x1b0
 ---[ end trace 0000000000000000 ]---

Note that the same issue can happen if detect_node_addresses is true, and
node 0 or 1 is memoryless. Fix it together by checking the validity of
parameters right before damon_new_region() and fail early if they're
invalid.

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20260609064653.1829-1-yuzenghui@huawei.com
- Collect R-b: from SJ.
- Add Fixes: and Cc: stable@.
- Rebase to latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/20260608111534.264-1-yuzenghui@huawei.com
- take into account the detect_node_addresses case (Sashiko)
- based on mm-new (SJ)

This is a fix Cc-ing stable@.  Nonetheless, because it is for a sample
module, not necessarily "super hot".  7.3 should also be a reasonable
target, like the other sample module fixes [1].

[1] https://lore.kernel.org/20260629132641.159851-1-sj@kernel.org

 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index faaaaa12e6206..e567f4edd80ea 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 		addr.end = promote ? node1_end_addr : node0_end_addr;
 	}
 
+	if (addr.start >= addr.end)
+		goto free_out;
+
 	range.start = addr.start;
 	range.end = addr.end;
 

base-commit: c1922f6a1a8b9a120b46051c3c5e3b81b4b75d92
-- 
2.47.3
