Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9746D2A4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654048; cv=none; b=o392PqZd7ZP/ht7/32Lj3EXj0jjD/gF6QogwtXerWh/nhWx6mmzUKhRjvB8jYVxrsKWJR26X3SDLP0DmUw+PvSAxuqOt4X7d1XGN8GkH4+cplpD9I+VYnOSEVrBdNIaKzTvdxbQg/LLBGrQEQ8euY/oOpO8E5MspanBBv57JUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654048; c=relaxed/simple;
	bh=Osx8FxH5DYlskEWSoEtYY0306/YzYYZQIZbcGDkctlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peMDY1Ui8FxOykgQjxxpc7MVLAyGlfiQH4o05Mh+PYqDzJZx8bUxTimoJz//edlP31E/EjphNvpnd1WAUSXPRgsn9D91UC5ycUs5EkKQawnCXjyWoycGOWFmWU3y5mpvqaogcNu0yxIKyDsAUG1sFGmSr91b0OwAxQOfBy4drSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUKr6K3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUKr6K3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7441F000E9;
	Tue, 21 Jul 2026 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784654046;
	bh=EUGErfrlULckj3qUzwCIPraUP1tkUCJKEiwP4BLz8zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUKr6K3P7TT62o4AKnU6NQdJtMvW4YqzYy1Q0gm/ULQzD680Ltddt/xwcx7JlD1tH
	 t1oBh0ldoK3i74KMwQDvmM2DH4Kj81GUi+2BW6IUkmrCglRXzlMulViuuKG8TsGMsC
	 8WDpiRNNiUdchFngDJ7WLOO3x4FfbQhDMJmPU3GoqRlwxHXE4v350xwhi+AhqTF8bg
	 aDkwnl4SUwx3C6eyj2lLIw1HvDjt/JbVcCstMy8utlkymFx0n2pXhh4xTBi720pfPY
	 C5+lsiOO4YNOogm9vV76yguFewqliDz7YyR9PtoblB4DuKKjTDdXcpSoZYIB/YXuLQ
	 dcV9G7KpxYM0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] iommufd: Avoid partial fault group delivery in iommufd_fault_fops_read()
Date: Tue, 21 Jul 2026 13:13:53 -0400
Message-ID: <20260721171353.111431-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721171353.111431-1-sashal@kernel.org>
References: <2026071619-canning-snowdrop-2a4d@gregkh>
 <20260721171353.111431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit 091ab6d70dc444f56ed14faedbcacfc979f4c613 ]

The cookie returned by xa_alloc() in iommufd_fault_fops_read() is per fault
group, but the inner copy_to_user() runs per fault inside the group. If a
copy fails mid-group, xa_erase clears the cookie and the group is restored
to the deliver list, yet done is not rolled back. The function returns the
partial byte count, with the successfully copied faults sitting at offsets
below done carrying the now-erased cookie. The next read() then re-fetches
the group, allocates a fresh cookie, and re-delivers every fault including
the ones already copied; userspace sees duplicates carrying the new cookie,
and a stale cookie that can never be responded to.

Use a local group_done variable that tracks the per-group progress inside
the inner loop, and only commit done = group_done after the inner loop has
finished successfully. On a copy_to_user failure the outer break skips the
commit, so done remains at its prior start-of-group baseline; the partial
bytes already written past done are undefined to userspace per the read(2)
contract, and the next read re-delivers the whole group atomically.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Link: https://patch.msgid.link/r/360cab4d4aeccb0bae275a970e2b3c340a71e0e0.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/fault.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index ff454494191352..74e3c93bce6eae 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -270,6 +270,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 	mutex_lock(&fault->mutex);
 	while ((group = iommufd_fault_deliver_fetch(fault))) {
+		size_t group_done = done;
+
 		if (done >= count ||
 		    group->fault_count * fault_size > count - done) {
 			iommufd_fault_deliver_restore(fault, group);
@@ -291,16 +293,17 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			iommufd_compose_fault_message(&iopf->fault,
 						      &data, idev,
 						      group->cookie);
-			if (copy_to_user(buf + done, &data, fault_size)) {
+			if (copy_to_user(buf + group_done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
 				iommufd_fault_deliver_restore(fault, group);
 				rc = -EFAULT;
 				break;
 			}
-			done += fault_size;
+			group_done += fault_size;
 		}
 		if (rc)
 			break;
+		done = group_done;
 	}
 	mutex_unlock(&fault->mutex);
 
-- 
2.53.0

