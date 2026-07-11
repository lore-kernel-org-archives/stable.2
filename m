Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353F2F363F;
	Sat, 11 Jul 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749180; cv=none; b=LRNHG4BhuK7x2szUrQPM4k70SACnaN2q0BlOTvNPtL2KahOM4h8NCKk/CVSyLRLlEFQ7yiMuUWXjmNlNaP01ZegBHBalLeTZxuFs1oX3BY/3uJIbrZa2sen3KbGQ76FQOv1FL5C9DK9bbOYjM9gAaNleIz/Cv4nBBkYLWqUk8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749180; c=relaxed/simple;
	bh=ttaalMz1FTfGmakTWRqtkTEzjB66sXfIOsfhZO7DEhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpViW2wGRankXJ7ydfIFJY6zU8GGYtsut9ZTJiHaX//ndc8m9RTplB+VXcVRhmQ9i+JDmd5DyQTkPk/4qYJqq4JvJtk8LJ2jVARa7f04e519Jvfsenkaz4+t7J9N5I/2s9fYlyPHKbyK51UACbjIiG3vVubLzuacxGCBe71Bqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=3OMVBgMW; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="3OMVBgMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783749099;
	bh=1nEroFCMNEQ1OarzSc1k6vxdkFBpH9AU9gvIdeqHk+Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=3OMVBgMW7lHVXQyiNSy3EPndE/WA4m+gsmC93HkPCXd5UgqU8cD3zOmHNHx3US3Ky
	 yJ2oCi/iuSuu+Wp2D+jQhl0NT45HOvjKisTAvKMetttK4NQmfgWyAoWEA4uLCO2j63
	 8GXAvfBE+MLvtSrTXmmRUudUBJWSbo33qecx7nOg=
X-QQ-mid: zesmtpsz7t1783749097t45495f21
X-QQ-Originating-IP: IIDSEp9RwtEdL52iwvqif0O5hnmgtOYnh3AsFkRNW40=
Received: from hepeiyang-vm.wu.lxd ( [153.3.21.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Jul 2026 13:51:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3112722422674839483
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	jgg@ziepe.ca,
	kanie@linux.alibaba.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] iommu: Fix dev_iommu memory leak when device_add fails in iommu_mock_device_add
Date: Sat, 11 Jul 2026 13:51:19 +0800
Message-ID: <76AC62D46B998556+20260711055119.1003477-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MACXe2l6e7j95nR9x1ySR86aE13w+ytrjMjbb1PHcZV8X37jHLDW0vwt
	UKMz4w4jkEFJKOtKxgCOuImV9XeHGFdXZZVdaUoHkEp4z51vPFeODds1tr+A9Tw0WqMUEdL
	ppeZ8e8ACAJPfJcLrFGSxgRUCbS/rmlgPHOxQWpryf56yNd9CYw2auTWVNaSOe/Z2UDA8ZS
	iFIJyjnca9flz+9zZrqMZwB+shruX7XRWMgLGaNZsUY9wwUEWMsDA/Ye4Y6DuXKmLPgjhph
	P6zmgV2zoLD+n6nfEVJd4h+VNy0XKSuQbugnXJUnQFVWiNV4vgyn2ZGKtw/uKJ4glCWgTAe
	D6Q2iRCHt0PENSBwUwm+Em/YpGTJrARf63bckWPVs/PimOHUOY/KfZZVlAcqLCpr7ii0j/0
	gwCNx7AwcnXJyBhrRajbSrLD9Jx/QyrbK3zf3R+eDRKSZR4ldm1ONQUM//sqmasuyz6Bj9H
	nK7zYWoMtHDvCrLfzO+M3u97u4T0cAPILKZUHw9QakznkZsJLjOpdM0xEY9KXojT7luaoj2
	m+i9zjKjxliwI8tDBnlKtyQOEOClKmeCqS50m5JKwp7wHSQsVbt9flvR3yfZSxvIhHeGMV+
	pa4HZ7wMp1XIBnuQVJw48pic69nTjvuisUwkyQp7kbrc4kqxowKu7hS61idOcG6wbatGeQH
	ZUowg8N58O9dF5OBHlkdmFhssdvklM3z5b1Wc6ir3qb0kO1oVzb1jzLbbqnLcoTr2ijkZzQ
	mCyKSfL6xPAoTTNnoH6nIOgdPsfmuo11yq1X6nuoHlL8XqMk/0ls37Fn80cxiMe3uK3oTD9
	Ubt8oBGzTl2rltYMVVOIr+Ipmuh3++4OklNJrP9pG5fI8R4hFTpsCKkQAR++u4USbwjTSjo
	wjZewJ/C7fmGN9rolXIym7Qxla+k6wUjHhx9/qie8kRhNQPzjsyZj6HgEXMh2L7H4LrqLgf
	0d5qcFqhNZJeAndl8Y1ZRIIItM5lSELfKQhlmuG5rShl9vKK6NkGt+s1U+3T+I3KgCph/0X
	4ZzCfOJWwfz1I1EQng+1aaDitDY0A=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

iommu_mock_device_add() first calls iommu_fwspec_init(), which on
success allocates both dev->iommu (via dev_iommu_get()) and
dev->iommu->fwspec. If the subsequent device_add(dev) call fails,
the error path only calls iommu_fwspec_free(dev), which frees
fwspec but leaves dev->iommu still allocated.

This triggers the following kmemleak report when fuzzing with Syzkaller:

BUG: memory leak
unreferenced object 0xffff888011e0a200 (size 192):
  comm "syz.1.1695", pid 24885, jiffies 4295222527
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
  backtrace (crc 25df5bb3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4575 [inline]
    slab_alloc_node mm/slub.c:4899 [inline]
    __kmalloc_cache_noprof+0x47a/0x710 mm/slub.c:5415
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    dev_iommu_get+0x10c/0x1a0 drivers/iommu/iommu.c:408
    iommu_fwspec_init+0x288/0x4d0 drivers/iommu/iommu.c:3087
    iommu_mock_device_add+0x46/0xb0 drivers/iommu/iommu.c:385
    mock_dev_create drivers/iommu/iommufd/selftest.c:1025 [inline]
    iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:1066 [inline]
    iommufd_test+0x2f8a/0x6190 drivers/iommu/iommufd/selftest.c:2072
    iommufd_fops_ioctl+0x367/0x540 drivers/iommu/iommufd/main.c:533
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix this by calling dev_iommu_free(dev) instead of iommu_fwspec_free(dev)
in the device_add() failure path. dev_iommu_free() frees both fwspec
and the outer dev_iommu struct and clears dev->iommu.

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Fixes: 2a918911ed3d ("iommufd: Register iommufd mock devices with fwspec")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..23a531595835 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -390,7 +390,7 @@ int iommu_mock_device_add(struct device *dev, struct iommu_device *iommu)
 
 	rc = device_add(dev);
 	if (rc)
-		iommu_fwspec_free(dev);
+		dev_iommu_free(dev);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(iommu_mock_device_add);

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

