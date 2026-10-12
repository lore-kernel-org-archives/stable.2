Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D514B0E32
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823285; cv=none; b=Hp3/tpmPlk9RlEsdzD+A2xej7h7GBcpp+CIz2PHRZpNBXDKzbBRW5Di2tSxBndIHeAKbUy0zK0qBaJkTWxfj2l49idilvx/LiitqxBo2ITh+ifOvFY+uWiXcnhafgkoShgtWV6XLCHixw3DbiObUxdIpt8GxeqBsgyyZIOrdc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823285; c=relaxed/simple;
	bh=g46B5UrbX+R2/rP7EJF2vk68ckkCz2XKhcX7RHKTJJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NePL7Ur/aBd9Yrmew0uOVfk1PXgHkrHBREQw07AkfHU+tFkEuRO4IKNJmRq0hTlQcVnKJ7O4GqlnPOZGIqerb2TsFF7qNYBfokULZHusJJD6S8gESRv0WzkyEGQ2wdTNTQ06BEFoNmiRMK+SLCk8Od7FHDS/qyQ5YPqmVRFdWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qET8ttuG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qET8ttuG"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFRCfL1948328;
	Mon, 12 Oct 2026 16:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=nIeL8
	VbShV/Y1fAVv2anviQFL4puB77p/DeK03xnFaY=; b=qET8ttuGny2b5d3DduHrP
	PsbvgjdsUCFsH/nxgvojThfpM5a32mlkQ2CrxMQra8RbI/vuMONaYBujhyhFwHpd
	ZhsTBFvxGtZmAjLJUtH4Ca8RaP6qKmvIkJfBYC7UHoutR99NTALIXcLmXI0tNVwf
	WAOlK+47074ZsK1PtpyXOUoh9l8lJKhi6xxHk8Pug11eW3py97donSJMf3QqVHg+
	8VHDUxN26ysbg1oIh3B4dokQX7w0Ayc19SN4aw6ATZfB2kTZQaNJvIhBH4eMIA6J
	MYKK80H/mSHiCnbgG5Xn07rdly9zB8QUGviwu0buBBJji/b+B20Ys04X+9NrviJ5
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dwtak9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGbsHS033100;
	Mon, 12 Oct 2026 16:41:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf1v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:21 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1wc006762;
	Mon, 12 Oct 2026 16:41:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-7;
	Mon, 12 Oct 2026 16:41:19 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 6/8] smb3: fix for slab out of bounds on mount to ksmbd
Date: Mon, 12 Oct 2026 09:40:55 -0700
Message-ID: <20261012164057.709105-7-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
References: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfXzZx5LQ7t4MIh
 1j18oP0BuK4GnK5iNF+bfp0HSddAyBPPRrGHY1Q/ijIQNjkQ2YeT/XCisFQygS0nB7DyL/d0yfQ
 BtUeBwRbc51tXhPnIl6ISXb+aql27eSYDynZUDtnTbQC52loH/fIPCN7ufKOlRot9phh2EvkOEw
 YOQQuAyrYyByiqGifudfn7AS1223D10Xg1T50bHzTZ6XCmk1rUm9uvkh99qykn+pBZEialeP77M
 iyKx24vgjgkuW6+QquC+pDi6eIy+QVMwAIstVRJkWmg7YTeAiL+mZOJsiqjBooWlGV0qd/Hzi5/
 /SEefINpf8s5rgV4ASQci4NlnJvlIMv93L1HSPDPH8nsXhGFDhR33bLr8f7HrM3O3KF9YwEtydb
 bI4vy4B7cm1LMvrDE493cbX0u0aCIw7a0rN1dyEgpZzmHAroLldtVgh2kSWLWZdJdVAhGZ+VIZO
 yKo0Ohen6eGkET8dl0KxnQXdEf7wUA6xhJff7QhI=
X-Authority-Analysis: v=2.4 cv=Kp7YSmWN c=1 sm=1 tr=0 ts=6acd0db2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=haviVmOeOKvvJJ66XjkA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: 7OabkuMKBeP1cebyCxbJSF7xDWOg_5QC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfXxGvvTEytoi0B
 +jz5ztHVK+ESrWgfSBxn+rw7+gxAhWFmFyFZtViYUZUYtMFuUn5jqkd81t3iG3/LlQ2T/BsxGAH
 S6w67owTQwC/IzTl2YTVB1TBBppY8+Q/Ryg1nm5ahbrCV/6Z1oKI
X-Proofpoint-GUID: 7OabkuMKBeP1cebyCxbJSF7xDWOg_5QC

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 7d34ec36abb84fdfb6632a0f2cbda90379ae21fc ]

With KASAN enabled, it is possible to get a slab out of bounds
during mount to ksmbd due to missing check in parse_server_interfaces()
(see below):

 BUG: KASAN: slab-out-of-bounds in
 parse_server_interfaces+0x14ee/0x1880 [cifs]
 Read of size 4 at addr ffff8881433dba98 by task mount/9827

 CPU: 5 UID: 0 PID: 9827 Comm: mount Tainted: G
 OE       6.16.0-rc2-kasan #2 PREEMPT(voluntary)
 Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: Dell Inc. Precision Tower 3620/0MWYPT,
 BIOS 2.13.1 06/14/2019
 Call Trace:
  <TASK>
 dump_stack_lvl+0x9f/0xf0
 print_report+0xd1/0x670
 __virt_addr_valid+0x22c/0x430
 ? parse_server_interfaces+0x14ee/0x1880 [cifs]
 ? kasan_complete_mode_report_info+0x2a/0x1f0
 ? parse_server_interfaces+0x14ee/0x1880 [cifs]
   kasan_report+0xd6/0x110
   parse_server_interfaces+0x14ee/0x1880 [cifs]
   __asan_report_load_n_noabort+0x13/0x20
   parse_server_interfaces+0x14ee/0x1880 [cifs]
 ? __pfx_parse_server_interfaces+0x10/0x10 [cifs]
 ? trace_hardirqs_on+0x51/0x60
 SMB3_request_interfaces+0x1ad/0x3f0 [cifs]
 ? __pfx_SMB3_request_interfaces+0x10/0x10 [cifs]
 ? SMB2_tcon+0x23c/0x15d0 [cifs]
 smb3_qfs_tcon+0x173/0x2b0 [cifs]
 ? __pfx_smb3_qfs_tcon+0x10/0x10 [cifs]
 ? cifs_get_tcon+0x105d/0x2120 [cifs]
 ? do_raw_spin_unlock+0x5d/0x200
 ? cifs_get_tcon+0x105d/0x2120 [cifs]
 ? __pfx_smb3_qfs_tcon+0x10/0x10 [cifs]
 cifs_mount_get_tcon+0x369/0xb90 [cifs]
 ? dfs_cache_find+0xe7/0x150 [cifs]
 dfs_mount_share+0x985/0x2970 [cifs]
 ? check_path.constprop.0+0x28/0x50
 ? save_trace+0x54/0x370
 ? __pfx_dfs_mount_share+0x10/0x10 [cifs]
 ? __lock_acquire+0xb82/0x2ba0
 ? __kasan_check_write+0x18/0x20
 cifs_mount+0xbc/0x9e0 [cifs]
 ? __pfx_cifs_mount+0x10/0x10 [cifs]
 ? do_raw_spin_unlock+0x5d/0x200
 ? cifs_setup_cifs_sb+0x29d/0x810 [cifs]
 cifs_smb3_do_mount+0x263/0x1990 [cifs]

Reported-by: Namjae Jeon <linkinjeon@kernel.org>
Tested-by: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
(cherry picked from commit 7d34ec36abb84fdfb6632a0f2cbda90379ae21fc)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/cifs/smb2ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c38309616e68..fbba71f6814e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -528,6 +528,13 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			bytes_left -= sizeof(*p);
 			break;
 		}
+		/* Validate that Next doesn't point beyond the buffer */
+		if (next > bytes_left) {
+			cifs_dbg(VFS, "%s: invalid Next pointer %zu > %zd\n",
+				 __func__, next, bytes_left);
+			rc = -EINVAL;
+			goto out;
+		}
 		p = (struct network_interface_info_ioctl_rsp *)((u8 *)p+next);
 		bytes_left -= next;
 	}
@@ -539,7 +546,9 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	}
 
 	/* Azure rounds the buffer size up 8, to a 16 byte boundary */
-	if ((bytes_left > 8) || p->Next)
+	if ((bytes_left > 8) ||
+	    (bytes_left >= offsetof(struct network_interface_info_ioctl_rsp, Next)
+	     + sizeof(p->Next) && p->Next))
 		cifs_dbg(VFS, "%s: incomplete interface info\n", __func__);
 
 
-- 
2.52.0

