Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA83E5EDA
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557758; cv=none; b=MPs+d369ZuwxMTSmWXLVO+qUZoW9y7/v6DZqCmJ27qS07UagRIknKD55dxxJJUtjQ99Xb/cgZckjruVxcJVX895OFlbV96BpqOpjgQvheTqdIBuEoH3DMdEZR6dMUfK5qOHviozsFOwrg/5z+BvK5xViM7oQKAU4E60K2rR49JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557758; c=relaxed/simple;
	bh=N5ohTd8stRtTfIKGXJFQODq9t9UthXZf0eHK8Hsj6xk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L7Gz/aYowrWKOgQ/0dcEq2JQi6rILKs2hEbGLXu16HET3+MuRyp1MWif1lZFdhqpyB68dFS1TXKDCWruG06n5P6utNx7LNT8CdaHX0TF/PBrLEDP+nVKyn8VYkvhLV/W64r4Xi0fOzXKf7QBC4DgGoENUf5MzviCwFGXNc2Ezac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGK+ZoKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGK+ZoKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3152D1F00A3E;
	Mon, 20 Jul 2026 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557756;
	bh=0BuCO1NPBU2KRe2DRoF9Xr6LLMXu+dWETXdfXH9ixsA=;
	h=Subject:To:Cc:From:Date;
	b=VGK+ZoKNDFjWbAmh8IvdXIXX7Ov2BWE0aReD0jCkMdpJq0rH7FRYwPPkMm77RCfV8
	 J9D2sFt8sgAa6uyfxK4jUG1deEa5AZXTWGcmIr+ZNYq5NsQnALzLfJCDWQlHnf7doC
	 F41pU/X+TOjoTfBtOVhjxm0s1tzpymVkYZUGsLQc=
Subject: FAILED: patch "[PATCH] samples/damon/mtier: fail early if address range parameters" failed to apply to 7.1-stable tree
To: yuzenghui@huawei.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:29:07 +0200
Message-ID: <2026072007-eldercare-amusing-37b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7746d72c64054976887928d64d2caf25c5a6dcc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072007-eldercare-amusing-37b4@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7746d72c64054976887928d64d2caf25c5a6dcc0 Mon Sep 17 00:00:00 2001
From: Zenghui Yu <yuzenghui@huawei.com>
Date: Mon, 29 Jun 2026 07:44:31 -0700
Subject: [PATCH] samples/damon/mtier: fail early if address range parameters
 are invalid

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

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index eb1143de8df1..3785b0c7ffb1 100644
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
 

