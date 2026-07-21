Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45213B19D9;
	Tue, 21 Jul 2026 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612404; cv=none; b=c9MUIDxRxg9Vq/jKsQuYkv/cUAJvBJG0mrM7eZIaUYUFP32yX6pH77tvM+smup/FmF24mXkuQ5qnEf83fkjhlzzA7qJVp5/MZCu/v8ZEeiqvkVla5eeD4xDfhj25+216K/WPHYRH2B8ff4bmCT6mJRgSOb61KwQtf9Bjqy7quA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612404; c=relaxed/simple;
	bh=c4M3jRlqtSx7k4Fs9CzNUbTBEh8/1wpB1NIh1fvqsnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miWF6gt3hGf4hqwehrHupRHscfWDTgZ6MbTzGLc5UrcvU/N/LflEC2w2ktpx2ddJXVsUC4P1t1qzAeOpZIj7OSPjbLBp11xSizVQU9gLt+Z3ohZmk+CGqgjNQrohY4MYjwoXiTxSKfzGttlPUsYvBEQHk1EU0howvGf6Bups298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCpBk2wW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCpBk2wW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3781F000E9;
	Tue, 21 Jul 2026 05:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784612402;
	bh=PuflvRpV0/G/rMKVpE40NhiuuK6VGHdPh4LWwMCVrYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OCpBk2wW3HItgx7By34nRekSmYcmte2f80VOSPeAlopjTxJN6bme18tUQyLvcIcRP
	 rvTt9w2h5iDRQBjdQRT3F6Jb6UJil+bFdiBCdHLQL2O1aADrLuEZi6PXvvlH0IQ4Z9
	 QflsWVgPikFhjWy0R6NVqKPM7/YZZ0V6fAKDp/L0e+Kg7T1wZPWWVLTG42AKAVBV+o
	 wp5qGevP/5eIJaZsE4Mcgn6Z4EsMcCtjdNJtXJpck3p//Y2IUsPQ6EvOUk/JzJO7a9
	 2Z6OYQ1OmwaYGOcRV9Ml+1ENA9n5UJLMrh2k9MrM9kE5EmXL7mxcw414wQOiK2+6Ll
	 nT4BWvR1rlemg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Zenghui Yu <yuzenghui@huawei.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.1.y] samples/damon/mtier: fail early if address range parameters are invalid
Date: Mon, 20 Jul 2026 22:39:53 -0700
Message-ID: <20260721053953.181336-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072007-eldercare-amusing-37b4@gregkh>
References: <2026072007-eldercare-amusing-37b4@gregkh>
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
node 0 or 1 is memoryless.  Fix it together by checking the validity of
parameters right before damon_new_region() and fail early if they're
invalid.

Link: https://lore.kernel.org/20260629144432.133962-1-sj@kernel.org
Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: SJ Park <sj@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7746d72c64054976887928d64d2caf25c5a6dcc0)
Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 775838a23d935..7f84367ad3e58 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 		addr.end = promote ? node1_end_addr : node0_end_addr;
 	}
 
+	if (addr.start >= addr.end)
+		goto free_out;
+
 	region = damon_new_region(addr.start, addr.end);
 	if (!region)
 		goto free_out;
-- 
2.47.3

