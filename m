Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776A403B1E
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042347; cv=none; b=bkT5p3E3RhEx4/YZsZzhgPXSMIM5QB2PEs8X7QOzo8nT+dnanRUo3LkrqMsXKecL5puhZw4/nWhW7cWrsNFI+tlVOI6fnkFlSct59Np4Op42hCEmvg7OTuRea71PNrUDYaLIDRIb+jGJgC4zQYCVRWas27qmDbXEVywO35zYTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042347; c=relaxed/simple;
	bh=eFSvU/ePFL1qszgpJvxpUkKC7kFse+8pNxPpiZngZJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUOteJD7Bx0hOUWfhyZa5hhfaIaBo0yDJs44AiS0aC1VY8SYf/jHyfGYXGgkP2wFrMM22CD680FeFugE1ekQ55bpyANKrgjJwzuY80m2inePx0txlkbM/49Rw9SI6vK44jmXuPnoAuAfCyNH3YNanoaX3kANU/djq1kYJnu9Xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIGW38mZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIGW38mZ"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659KBld1082250;
	Tue, 9 Jun 2026 21:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=0dpCCn9mcTkGjTYBcnWgTdxab+zrJ
	LAL9dzaq5dBZ78=; b=HIGW38mZGM5/DlKptDzfbSd/pnf1l7135rWnkg/IP9zed
	eKJn2bh0utuDjmx7gbP34f8k0+uvaY5HcFZLytK+VKKANKkXKYUMRqoy8xvxUUwr
	zTan1Qc5gJAOPe/YKJ7RxYHcsXdgM4v8/nlYpwNQjVt0EWtu8hOM/KS9BsCJ9hoy
	poZOq6lz9azzR0bovz3lnOFxqt5EBZoNES4M+fEfZ/As59vesB178x+fJW+3V41K
	VcHeoLe4tnquyo9Jg7LKpUhC+PogBex5btvN+PQlHopKCbd73J6bxxHQ0UKItnEP
	T8/qrdIzkoIOtH72Ude8s5Ajdy0k4gl76xFnc5ncw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5swdhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 21:58:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 659LriEh027679;
	Tue, 9 Jun 2026 21:58:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0qqgjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 21:58:46 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659LrtLG029331;
	Tue, 9 Jun 2026 21:58:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ema0qqghu-1;
	Tue, 09 Jun 2026 21:58:46 +0000 (GMT)
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, chenste@linux.microsoft.com, sherry.yang@oracle.com,
        ebiederm@xmission.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com
Subject: [PATCH 6.12.y 0/2] ima: kexec: fix kexec_file_load panic with IMA_KEXEC
Date: Tue,  9 Jun 2026 14:58:42 -0700
Message-ID: <20260609215844.1835378-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606090206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNiBTYWx0ZWRfXx5lPL+ClYmXm
 lbn+NZ7up7B2ADl0agbREyqWpkk0dCDGckr5zFqxSrkDpMGdp/rHng0JIrhshtiOQI0MUU/WnRt
 Lijx9xb+rhofiOQF+8srLc6Mdk/5mGZeType/hOgeoIxostHR3vwWfVzzsv180f9Orib0/JiUl5
 7cerZ2tXf7eQpGuo2L/329h33Hh8gHulLP/P7WntKsenSbbSr8AkhhbYnN5LogEb+0HTzg5UF6H
 Wbn7Oj+Cf+Ts8llCXvo1ySyxYJkiLhMb3sAkmMejuq7wRswN0vLT9986QRaOEAf9OadPmVg9n8j
 GFIEinQ/Xn+HVeSBsgCpWbwahlv4DCzM92lWs18IHX6K6AN4d6Hk7hfDxqRg9rMPi4yE3yptH8S
 Toaf6q513dv/Ro73psmxivigm4mnP0xcpbHJlLMgcdpMapbzLkc8QbIXTqWGGhNstQFhwd1dcRF
 FxBwtrB06ZNPl8hgtCmpjdy9NNzZzDX7+XRNk+kw=
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a288c97 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=Z3cD_0Fe9WOAt5BZow0A:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-ORIG-GUID: tI_pKZzXXNXa56nMAmjYzwTnpdFhSJyU
X-Proofpoint-GUID: tI_pKZzXXNXa56nMAmjYzwTnpdFhSJyU

Hi Stable Maintainers,

This series backports two upstream IMA/kexec commits to linux-6.12.y:

  9ee8888a80fe ("ima: kexec: skip IMA segment validation after kexec soft reboot")
  9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")

linux-6.12.y already contains the surrounding IMA kexec backports, including
the buffer reuse change:

  d0a00ce470e3 ("ima: verify if the segment size has changed")

but it is missing the commit that moves the measurement list copy from
kexec load time to kexec execute time.  With CONFIG_IMA_KEXEC=y and
CONFIG_KEXEC_FILE=y, this leaves the static IMA seq_file buffer with the
old load-time ownership model.

With repeated file-based kexec loads, for example

  kexec -l /boot/vmlinuz-$(uname -r) \
    --initrd=/boot/initramfs-$(uname -r).img --reuse-cmdline

We hit kernel panic

[   64.411644] BUG: unable to handle page fault for address: ff5f3d77a44d9018
[   64.423320] Call Trace:
[   64.423516]  <TASK>
[   64.423684]  ima_measurements_show+0xb2/0x250
[   64.424015]  ima_dump_measurement_list.constprop.0.isra.0+0x81/0x15e
[   64.424475]  ima_add_kexec_buffer+0x160/0x1f2
[   64.424809]  kimage_file_alloc_init+0x1af/0x3df
[   64.425143]  __do_sys_kexec_file_load+0xc4/0x2bc
[   64.425483]  do_syscall_64+0x90/0x1c0
[   64.425768]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.426121]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.426473]  ? syscall_exit_work+0x103/0x130
[   64.426794]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.427142]  ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xf0
[   64.427562]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.427911]  ? syscall_exit_to_user_mode+0x36/0x190
[   64.428263]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.428616]  ? do_syscall_64+0xb6/0x1c0
[   64.428894]  ? inode_security+0x22/0x60
[   64.429179]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.429519]  ? mutex_lock+0x12/0x40
[   64.429783]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.430405]  ? seq_read_iter+0x1fc/0x433
[   64.430931]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.431513]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.432167]  ? vfs_read+0x252/0x370
[   64.432676]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.433249]  ? syscall_exit_work+0x103/0x130
[   64.433791]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.434362]  ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xf0
[   64.435010]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.435579]  ? syscall_exit_to_user_mode+0x36/0x190
[   64.436149]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.436718]  ? do_syscall_64+0xb6/0x1c0
[   64.437222]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.437801]  ? syscall_exit_work+0x103/0x130
[   64.438337]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.438899]  ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xf0
[   64.439545]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.440099]  ? syscall_exit_to_user_mode+0x36/0x190
[   64.440656]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.441202]  ? do_syscall_64+0xb6/0x1c0
[   64.441680]  ? srso_alias_return_thunk+0x5/0xfbef5
[   64.442221]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.442792] RIP: 0033:0x7f2cef50887d
[   64.443249] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 15 0f 00 f7 d8 64 89 01 48
[   64.444968] RSP: 002b:00007ffdb22657b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000140
[   64.445715] RAX: ffffffffffffffda RBX: 0000000000000080 RCX: 00007f2cef50887d
[   64.446432] RDX: 00000000000001de RSI: 0000000000000005 RDI: 0000000000000003
[   64.447153] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000005b2265b28
[   64.447870] R10: 0000561563d37dc0 R11: 0000000000000246 R12: 0000000000000000
[   64.448589] R13: 00007ffdb2265b28 R14: 00007f2cee241010 R15: 00007ffdb22662a7
[   64.449313]  </TASK>

After backporting these two patches and tested with CONFIG_IMA_KEXEC=y
and CONFIG_KEXEC_FILE=y, the panic is no longer reproducible.

Thanks,
Sherry

Steven Chen (2):
  ima: kexec: skip IMA segment validation after kexec soft reboot
  ima: kexec: move IMA log copy from kexec load to execute

 include/linux/kexec.h              |  3 ++
 kernel/kexec_file.c                | 33 ++++++++++++++++++++-
 security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++---------
 3 files changed, 67 insertions(+), 15 deletions(-)

-- 
2.50.1

