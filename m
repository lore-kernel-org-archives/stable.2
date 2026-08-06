Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CF377A92;
	Thu,  6 Aug 2026 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991963; cv=none; b=skxW6KAPvdLAusVf8YZaH1W3egPV2AlGfQShCyY6JPVwHPmRAkI66TkondMAuKZXM5kPYCET4PwiTTDpS4rfWbQ2Io8NW8j+jEHs9ToWATdV+0jESywP9nYQveAQhGjRTEtyKL6y0ylqsndiBWAzPA5JszyQVvCtglxlngYUZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991963; c=relaxed/simple;
	bh=TiJfNb66mP2MyjcByDXsllYoqfRCX/7hRV+xTd9aXfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uvp70+ShbYphD6maNZjfNG3qmruStL+I00bdsFfrFTEIIgOAqNv3X7JuOKmV50yH4et34ByZq1AiAIin22VQuh9Oz4RTiuDWlrT3PpMN/BaUsfgdSV1xM7DqJnXDCemMepj35NwGw5neMrVvOq9d4EK7qeoUBIAa/+e/5RkBKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=lNDcclMi; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="lNDcclMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1785991897;
	bh=pPf+IRtN+qJnqFd947Y1uPTqZ/TpQ1LSJUGm4TIevt0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lNDcclMiwdaWHTCS4znPKlqlZnynG976pKISN6UHK2hO2i07tTk/Me71xCzrzCnWl
	 GL4NXYGYu9cAjNK/qkbq4mYlMFITSZ8d31kEReSzhpWCRp+EXcAzwDMHX9CZ05dwdQ
	 oXkUwjnPL5HHVIJbGTLtaN8im0CHKprqA18ybPzI=
X-QQ-mid: esmtpgz15t1785991889tc3be0055
X-QQ-Originating-IP: gcAnknkBjeW/oTv++sm6mM2age806mXOFveq9vNK/a0=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.72])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 12:51:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7100674086777323356
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: kevin.tian@intel.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	steven.sistare@oracle.com,
	stable@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] iommu/iommufd: Fix NULL pointer deref in iommufd_ioas_change_process when racing with iopt_map_file_pages
Date: Thu,  6 Aug 2026 12:50:59 +0800
Message-ID: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MxQ7rY5OAZZvd9yc5E5OHCVkUPvYeIJsDcrtIRgZ9PU52gP53VTyqdXu
	deZyoDZRmQT59/FkbLX9L2l2xUU37bnc1X8MzQUeJvCADOehPMjuMtQj3hclxZv9W+yK7i2
	LgmwaN2j10s84JkaZK2zc9lyt5ye3kocP5Y6HIKKq9iv3VessYCCkQtOmX24DPoXb8LNM1x
	mznFso6uGmF18wCj9BlakA3WMK8qV/fcWHRfPFw5gGWokfLAF2pstJnIy8BHu9GCfGFOSBS
	jjkdFfL6tJLapQRsZdup4QfpKodwRZ96+1UqW/GTD9m7m6Sd6HE6AiOWf9BkhynGyox5/np
	ov1gD/gUOWuNaU+euy4Ro7ABk8WATvtT0u8JsT94rvo3EVHLtGxQngznQ1oeEbXQZeRMEUT
	KhBKHiTuD+XRaSSd3B4glggPXS2dzr4yD+uFGbK1Yua61v7dSQ9i/DgTwARcobSTXcN0zdc
	yFFPJ5k1DmFZXKDzEsM7z9H2JnxiAsf77Ip9VwJjBY+qtzsCIe/b8aLEYwftlgQ8ATTNvLC
	W+7cfQWDrW28A7LtIJyHwZObBIXrdEmoAjiD4NGb8JCBQXupLwhmrvTxEAJ61d4ITe9Cny8
	mnpJZYlw4n1cIx5gG2E9wrxhU9JU92ccNvZ9PcfCJvMKq5AKJZNgzrYmM69KgqVWnaBY1ok
	DD5Zx5w8vEeR86xN9VvwB0GZHeudFdjexcbO+wqsr2GuUyHNcEa1UFpJUSz0MNFjmggBZH4
	fJGSnH5Y1HEe5+iptfVpLmSBxqQqH8wF/U5EHFwYbz8k1Bcg3tElQ8Jhk0JMbK/lRcT8PXK
	TdNHzFL/fAd8YhjQvvq2zhuHVH0e5Ks6YjM2ah/cNIKcW4pBEjXpxTmwMzp88D8hU3iprli
	Z16KIrLyt5E6bDUs3ZSAh2xk1+Vs3qty/ky+wmEDB4XSmKu3DHLIgWCIvcTjfrZgmu1yqa5
	5+QUe1fAN9+5RjkguNr8VzHBlurZM8sERPtxlu5djXEH9c4yMjDAHaTF6V3AqLo/DcpjF1K
	nI/T20UYDZ1kspxO/1qYfjTPBhFgiydf1h16J9o9NYe83vxoVrRVJ8SiG1HvM=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

iommufd_ioas_change_process() iterates every IOAS area while only
holding every IOAS iova_rwsem, so it assumes every area has a non-NULL
pages pointer. That assumption can be false when it runs concurrently
with iopt_map_file_pages().

iopt_map_pages() executes in two phases. It first creates the area and
inserts it into the interval tree under iova_rwsem, with area->pages
still NULL. It then drops iova_rwsem and later fills area->pages
under domains_rwsem. This leaves a window between area creation and
area->pages fill where a concurrent iommufd_ioas_change_process()
can observe the area and dereference a NULL area->pages pointer,
leading to a NULL pointer dereference:

BUG: kernel NULL pointer dereference, address: 00000000000000c0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 4b655067 P4D 4b655067 PUD 0 
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 11841 Comm: syz.1.628 Not tainted 7.1.0 #3 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:iommufd_ioas_change_process+0x419/0xd50 drivers/iommu/iommufd/ioas.c:538
Code: 48 89 c3 48 85 c0 0f 84 cc 00 00 00 e8 10 f5 cb fd 48 8d 7b 68 e8 a7 b5 eb fd 48 8b 6b 68 48 8d bd c0 00 00 00 e8 17 b2 eb fd <8b> ad c0 00 00 00 bf 01 00 00 00 89 ee e8 85 ef cb fd 83 fd 01 74
RSP: 0018:ffffc90015c17d28 EFLAGS: 00010246
RAX: ffff8880186d5328 RBX: ffff88801d25e240 RCX: 0000000080000000
RDX: 00000000000002d7 RSI: ffffffff83ba9e10 RDI: 00000000000000c0
RBP: 0000000000000000 R08: ffffffff8e781eb8 R09: 0000000000000000
R10: 00000000000000c0 R11: ffffffff83ba9e29 R12: ffff88802e216008
R13: ffff88802e216000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f4aea3f66c0(0000) GS:ffff8880b1fa1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c0 CR3: 000000004b75c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 iommufd_fops_ioctl+0x287/0x400 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x120/0x170 fs/ioctl.c:583
 x64_sys_call+0x1092/0x1fb0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10a/0x680 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4aec1a82bd
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4aea3f6018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4aec436090 RCX: 00007f4aec1a82bd
RDX: 0000200000000180 RSI: 0000000000003b92 RDI: 0000000000000003
RBP: 00007f4aec250295 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4aec436128 R14: 00007f4aec436090 R15: 00007ffd04ef23e0
 </TASK>
Modules linked in:
CR2: 00000000000000c0
---[ end trace 0000000000000000 ]---
RIP: 0010:iommufd_ioas_change_process+0x419/0xd50 drivers/iommu/iommufd/ioas.c:538
Code: 48 89 c3 48 85 c0 0f 84 cc 00 00 00 e8 10 f5 cb fd 48 8d 7b 68 e8 a7 b5 eb fd 48 8b 6b 68 48 8d bd c0 00 00 00 e8 17 b2 eb fd <8b> ad c0 00 00 00 bf 01 00 00 00 89 ee e8 85 ef cb fd 83 fd 01 74
RSP: 0018:ffffc90015c17d28 EFLAGS: 00010246
RAX: ffff8880186d5328 RBX: ffff88801d25e240 RCX: 0000000080000000
RDX: 00000000000002d7 RSI: ffffffff83ba9e10 RDI: 00000000000000c0
RBP: 0000000000000000 R08: ffffffff8e781eb8 R09: 0000000000000000
R10: 00000000000000c0 R11: ffffffff83ba9e29 R12: ffff88802e216008
R13: ffff88802e216000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f4aea3f66c0(0000) GS:ffff8880b1fa1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c0 CR3: 000000004b75c000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	48 89 c3             	mov    %rax,%rbx
   3:	48 85 c0             	test   %rax,%rax
   6:	0f 84 cc 00 00 00    	je     0xd8
   c:	e8 10 f5 cb fd       	call   0xfdcbf521
  11:	48 8d 7b 68          	lea    0x68(%rbx),%rdi
  15:	e8 a7 b5 eb fd       	call   0xfdebb5c1
  1a:	48 8b 6b 68          	mov    0x68(%rbx),%rbp
  1e:	48 8d bd c0 00 00 00 	lea    0xc0(%rbp),%rdi
  25:	e8 17 b2 eb fd       	call   0xfdebb241
* 2a:	8b ad c0 00 00 00    	mov    0xc0(%rbp),%ebp <-- trapping instruction
  30:	bf 01 00 00 00       	mov    $0x1,%edi
  35:	89 ee                	mov    %ebp,%esi
  37:	e8 85 ef cb fd       	call   0xfdcbefc1
  3c:	83 fd 01             	cmp    $0x1,%ebp
  3f:	74                   	.byte 0x74

Fix by mirroring the handling logic in iopt_unmap_iova_range(),
i.e. return -EBUSY if area->pages is NULL.

Fixes: 829ed626499c ("iommufd: Add IOMMU_IOAS_CHANGE_PROCESS")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
 drivers/iommu/iommufd/ioas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index fed06c2b728e..71bffece84b5 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 		return rc;
 
 	for_each_ioas_area(&ioas_list, index, ioas, area)  {
+		if (!area->pages) {
+			rc = -EBUSY;
+			goto out;
+		}
 		if (area->pages->type != IOPT_ADDRESS_FILE) {
 			rc = -EINVAL;
 			goto out;
-- 
2.43.0

