Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1F367F36
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739055; cv=none; b=pHyvO/a0P02Xd4WQyGXCGQuQkFzqRGu29HywX7JDfQnUEHIBQs8Zkpi1I5RcqV739fsUXXYWtCs65IVcasZJ3eTm2NmXVCKk5qziaw0G2AzVwaP0MxaYSIV4eSsnWU9qFBYAKbKo7l71ut9YcFqSZRA5uJWdbY+pOYm849AHl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739055; c=relaxed/simple;
	bh=knNS6TUsvmO8F1hFvdqkky2BzyMUhIMLwbJ1rHYPZBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfHT/k0oAPl89Rx8BvNU+DsJCZ1WDpa0Tx+hSY0gZQ8zCwDiJc+1Ve1qU9X+hAiZGYDeoLPDNjf2BfvpXOaaKLLp3VhVvAp6eBoM57HS5LSLUEXfOVww0w8s6tgyGr9VIp0Z1v40gtEu19SqfDFVHgtmq/wogwVC/urM1pMzJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iRupgbVh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iRupgbVh"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EItkq33555494;
	Fri, 14 Aug 2026 20:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=rsjge+OuJjQ6AXUq
	Fjqvof4sxtuQehjmjlMcboOzaOc=; b=iRupgbVhpHHHzLhzLGgKxyq+J1ynkGhI
	ISSwste7EGp1aDQGd2O5pfXriwOD1I/qkv+83n43qT63au2rmQzMTW8ThBGwXt6k
	ecvfETPhgUZ7vPaBP4K8CY2i0McE5vLf+PWtloSgDDKk2wnHYmujXhHzpdacat++
	SKaYttDyjhnzbZ2HXMXPHfmdgTkWA3vBw8OgxD6ksGE94uBNcIFgiKPbWCqLqaWh
	JP5HndmhyKUH8hvkXCBAlrQBy0VXJQDJDMWJRZpnqA484SDgg7e7YD63JpRydKqQ
	xZDhLkpRh238EIJ/lVXJMVgL0yOGm4f0/5huhJ+oPSqs2VY7E+oH9A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvhe593g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 20:24:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67EKK705035030;
	Fri, 14 Aug 2026 20:24:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwj21x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 20:24:03 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67EKO2qA008863;
	Fri, 14 Aug 2026 20:24:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fwtwj21wk-1;
	Fri, 14 Aug 2026 20:24:02 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, nasm <n4sm@protonmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y,5.15.y,6.1.y] RDMA/rxe: Fix a use-after-free problem in rxe_mmap
Date: Fri, 14 Aug 2026 13:23:59 -0700
Message-ID: <20260814202359.654631-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608140156
X-Proofpoint-ORIG-GUID: sJM6PdH-y6bRt9q7_funFjPBjIDVRk2Z
X-Proofpoint-GUID: sJM6PdH-y6bRt9q7_funFjPBjIDVRk2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE1NiBTYWx0ZWRfX1EDc6OISGB34
 THeowOvhzK6A7J9+gTrOAsPePIvSYXEZsqHELGZ7JFQ5thsu0uFCkdxSlhM+OB3+xQOl0roDK8B
 E3/KBaY53P+vEc2SwW9TMoX29Fq6lflYx8u3u4E1lTWXEswRCqAW6HAt0JMKjk0Zm1zfy/jOLlY
 S2rY+ZrpMe0+Ykqk1ALxZyKqcJX7ocp2QtO0wprW/LwsCo9Xa5hDnUA0opOYT5weinw41BiMzuO
 uazoK+V2xqDob1WEjF9WnMvYga+By85OMgS0sy1iLgpUcCYB/sFd2Ra0yq0hm12gBFgYZn3dZCm
 gqyoqZoK5bEa4eDqOKMm5hKyTwNlwdWdG6R8whqrZwzuDdqABYL078pmfZ7FHpvKSghWwEqrbmj
 q4YIDU/xmNo9JwrfydEyVvdWS/svKQjnuvhzWZUhIx4Mee4r6n2whI++E8g8Kt8a6rGdpdcIE7m
 +VhQWUkJ94lb33ledNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE1NiBTYWx0ZWRfXwBer13dt0Wce
 IV04KmNF7vXQelLmmV/tKwcrOW8So/Vh63xFSo+2PhdJPj7kPNStwPXOHStnQaziKfUcTnKDw19
 q8VCRBs/52JInEiV6UWmZT9LATCMp4KwNHQHJkqcMZ4io2/u2/AR
X-Authority-Analysis: v=2.4 cv=L/YtheT8 c=1 sm=1 tr=0 ts=6a7f7964 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=bC-a23v3AAAA:8
 a=sfOm8-O8AAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=34xYKcO2MGuQJVGWwHYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=TvTJqdcANYtsRzA46cdi:22

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit 35744ab3d03c5fca8c1752f53fc8fc674e14c561 ]

rxe_mmap() removes a rxe_mmap_info struct from the pending_mmaps list
and releases pending_lock while the struct's kref is still at 1:

   list_del_init(&ip->pending_mmaps);
   spin_unlock_bh(&rxe->pending_lock);   /* ref == 1, no lock held */
   ret = remap_vmalloc_range(vma, ip->obj, 0);  /* walks PTEs */
   [...]
   rxe_vma_open(vma);                    /* kref_get, ref → 2 */
   remap_vmalloc_range_partial() walks PTEs without any lock.

A concurrent DESTROY_CQ ioctl on another CPU calls:

    kref_put(&q->ip->ref, rxe_mmap_release)   /* ref 1→0 */
    vfree(ip->obj)   /* clears vmalloc PTEs mid-walk */
    kfree(ip)        /* frees rxe_mmap_info */

This yields:

   1. Kernel crash, vmalloc_to_page() returns NULL when vfree wins the
   per-PTE race -> vm_insert_page(NULL) → GPF in validate_page_before_insert

   2. Page UAF, vmalloc_to_page() reads a stale PTE before vfree clears
   it. User VMA holds a PTE to a free'd page which might eventually get
   reallocated later by vmalloc which allows the attacker to get a clean
   page-level UAF.

   It is worth noting that even though a page-level UAF is possible given
   the strong primitive, it is statistically very difficult to achieve
   given the very short time window (after the last insert_page and before
   the kref_get).

The call trace are as below:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  CPU: 0 UID: 1000 PID: 413 Comm: poc Not tainted 7.0.0-rc5-dirty #28 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:validate_page_before_insert+0x32/0x300
  Code: e5 41 57 41 56 49 89 fe 41 55 41 54 53 48 89 f3 e8 93 b5 a3 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 7b 02 00 00 4c 8b 63 08 31 ff 4d 89 e5 41 83 e5
  RSP: 0018:ffff88811b15f2f0 EFLAGS: 00000202
  RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
  RBP: ffff88811b15f318 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881181eee00
  R13: 0000000000000000 R14: ffff8881181eee00 R15: ffff8881181eee20
  FS:  00007b1e000f76c0(0000) GS:ffff8884268e0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007b1e00a24ac0 CR3: 0000000116eb3000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   insert_page+0x8f/0x190
   ? __pfx_insert_page+0x10/0x10
   ? kasan_save_alloc_info+0x38/0x60
   vm_insert_page+0x2e7/0x400
   remap_vmalloc_range_partial+0x212/0x3e0
   remap_vmalloc_range+0x6e/0xb0
   ? __kasan_check_write+0x14/0x30
   rxe_mmap+0x2e9/0x5d0
   ib_uverbs_mmap+0x1ad/0x2c0
   __mmap_region+0x12c2/0x2ad0
   ? __pfx___mmap_region+0x10/0x10
   ? __sanitizer_cov_trace_switch+0x58/0xb0
   ? mas_prev_slot+0x360/0x39c0
   ? __sanitizer_cov_trace_switch+0x58/0xb0
   ? mas_next_slot+0x1e5b/0x2f40
   ? __sanitizer_cov_trace_cmp8+0x18/0x30
   ? unmapped_area_topdown+0x4dd/0x610
   ? kfree+0x1b1/0x440
   ? free_cpumask_var+0x16/0x30
   ? __kasan_slab_free+0x7d/0xa0
   ? __sanitizer_cov_trace_cmp8+0x18/0x30
   mmap_region+0x2e6/0x3c0
   do_mmap+0xa3e/0x12a0
   ? __pfx_do_mmap+0x10/0x10
   ? __kasan_check_write+0x14/0x30
   ? down_write_killable+0xba/0x160
   ? __pfx_down_write_killable+0x10/0x10
   ? __sanitizer_cov_trace_cmp4+0x16/0x30
   vm_mmap_pgoff+0x2d4/0x4a0
   ? __pfx_vm_mmap_pgoff+0x10/0x10
   ? fget+0x1bf/0x270
   ksys_mmap_pgoff+0x40c/0x690
   ? __sanitizer_cov_trace_const_cmp4+0x16/0x30
   ? __pfx_ksys_mmap_pgoff+0x10/0x10
   ? __kasan_check_write+0x14/0x30
   ? _raw_spin_trylock+0xbb/0x130
   ? __pfx__raw_spin_trylock+0x10/0x10
   __x64_sys_mmap+0x135/0x1e0
   x64_sys_call+0x1c14/0x2790
   do_syscall_64+0xd2/0x1050
   ? rcu_core+0x352/0x7d0
   ? rcu_core_si+0xe/0x20
   ? handle_softirqs+0x1aa/0x650
   ? __sanitizer_cov_trace_cmp4+0x16/0x30
   ? fpregs_assert_state_consistent+0xe1/0x160
   ? irqentry_exit+0xb1/0x670
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Link: https://patch.msgid.link/r/20260515002537.6209-1-yanjun.zhu@linux.dev
Reported-and-tested-by: nasm <n4sm@protonmail.com>
Suggested-by: nasm <n4sm@protonmail.com>
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
(cherry picked from commit 35744ab3d03c5fca8c1752f53fc8fc674e14c561)
[Harshit: Minor conflict resolution pr_err() vs rxe_dbg_dev() usage]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
testing: Only generic testing(boot and some LTP testing done)

 drivers/infiniband/sw/rxe/rxe_mmap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 9149b6095429..2749ed48b014 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -93,18 +93,31 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	goto done;
 
 found_it:
+	/*
+	 * Increment refcount and check whether it is being freed atm while
+	 * holding lock to prevent UAF
+	 */
+	if (!kref_get_unless_zero(&ip->ref)) {
+		spin_unlock_bh(&rxe->pending_lock);
+		ret = -ENXIO;
+		goto done;
+	}
+
 	list_del_init(&ip->pending_mmaps);
 	spin_unlock_bh(&rxe->pending_lock);
 
+	vma->vm_ops = &rxe_vm_ops;
+	vma->vm_private_data = ip;
+
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
 	if (ret) {
+		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+		kref_put(&ip->ref, rxe_mmap_release);
 		pr_err("err %d from remap_vmalloc_range\n", ret);
 		goto done;
 	}
 
-	vma->vm_ops = &rxe_vm_ops;
-	vma->vm_private_data = ip;
-	rxe_vma_open(vma);
 done:
 	return ret;
 }
-- 
2.52.0

