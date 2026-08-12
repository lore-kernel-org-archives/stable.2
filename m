Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C740FDAD
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572817; cv=none; b=oqO83lSFUnYeZUhxlW4A79pNXO/JO3hDeODx4Ta7nQzg9WbIlxA7MLDdhOf1BygzXXaXIPYhoNCYcfhCjN/24VQz66Jm1i0l8vBg3mUPE5f/eHpy+aVR+zXpmd49yNseZ3UdNxqA74sYdYHgxjxwFUDXhzO7eHgbVxafd3nURuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572817; c=relaxed/simple;
	bh=Xp7zhySrpJYsPCZb0uc5V9Kp2tOX8jCIPjtGpo5wmUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS0eUBOXDMRNnMFtptbVO4wn+H7J4Qke7tmWNDlRwiXIhDCRwdNpstZjcuyC5aLGL8S2NIsy63WHWus39aYOHWF9dclRYgM3eM9Ovc5Y7ReAQ0BwkR3JucJs3XkEAnQKoDUUnfffoUv5aF9PuNmsRgDto2NOEEyxpQMYGzDJ2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZXZKb2LD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZXZKb2LD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2rMF3381556;
	Wed, 12 Aug 2026 22:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vbI9WZpgKxAof83H5
	wv7GUkc5GwGamhkMTn9NeqgdG8=; b=ZXZKb2LDo/D1Zrv7OaH396cCoWXtSvMLL
	Jc8RakC18e4q1imjJe142gwH8NGftqH143AOZLp5sC6IK+jHRGFSnS0VDzpWC9zs
	Q8urwrRgCH9wGiXtamoyD06/1q4pwGrXeau9MxOWR6FdFKhqsWhUCGCMyxpW0TUe
	YlG+7+uEfW4cW/I869qYVXfgEoIHWcshOYTgQQ+C1zlg428IpGbhzUO6jOw3Fk8n
	2UbWSpBt+tu+0t9UuKKuOl2ynV/GBVOVTXNWvSvMPvYGizxeCfyhZLUM7VkjY7bs
	uiHuAOQXIoE6DXi1lWb6niN+/DRif8Zjl98LlcD4U5o5crIla3f9Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23wfs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBH8X004102;
	Wed, 12 Aug 2026 22:13:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h88k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMDOAa23593686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:13:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC7A758056;
	Wed, 12 Aug 2026 22:13:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3415803F;
	Wed, 12 Aug 2026 22:13:24 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:13:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Eric Auger <eric.auger@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 1/8] kernel/user: Allow user_struct::locked_vm to be usable for iommufd
Date: Wed, 12 Aug 2026 15:13:16 -0700
Message-ID: <20260812221323.3645-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812221323.3645-1-alifm@linux.ibm.com>
References: <20260812221323.3645-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7cf006 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=-gLlHuE2PaxnPGtbEqgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX/a1RVZz0VWcT
 Mf/oLRt5FL5a6WHdP66hkz68Bq3hZMSn9nhP5wpwT+juoQtFJhbX1ftL7mf5yIfLKk0UNjGSkFk
 /jvl1t2/3WfOABvFpS8XsRH7qWOhdHmhoYYXGAIdKIfzvV0kZBZi3l86T6RIKxWgkV6Rsw18Lf8
 13QGTZtzCSjyRee4mGaNShT8dO03H3z5NmmIMRd5s610+HyWvTdYyGxfbf6iN6p5WscA6XJ8YL6
 GhENMo7m9c6zNMb42gsN0mEpeYwgj0SbxBq/2iOpVNes/hnduCaII1xLSNVrItdwu1lAvRJBO0Y
 I+L1SsaxJUQSPmbVE0TThmvQybvkoHkPfjl1hihwqws9gBnVJ7jXsntPUq+gcxx02rhJq7YKqZb
 i/d/Kv5UeYisfOSsOrVB3QO+FOiWHe1Jpy1NvEocMDulwJTm1Y/IJjks9IeKTu/upENWJgoAwPa
 N+ITEx8AzwUjWfhcfyg==
X-Proofpoint-ORIG-GUID: OBeLRT-ebk3SAYRKfjeRCi-nCvSILjIL
X-Proofpoint-GUID: OBeLRT-ebk3SAYRKfjeRCi-nCvSILjIL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfXxGs+lTavZq8u
 i0wQ407WaYxRbvCbXIaic6I9jfFkY+hiGIVeHiGzTQrgZ2LqlGtanOkf5mpD0lhk7f8Tfg7KqVW
 aPjE/JHtzg5JjF/OI1HZYDT8TkWn+e0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120177

From: Jason Gunthorpe <jgg@nvidia.com>

Following the pattern of io_uring, perf, skb, and bpf, iommfd will use
user->locked_vm for accounting pinned pages. Ensure the value is included
in the struct and export free_uid() as iommufd is modular.

user->locked_vm is the good accounting to use for ulimit because it is
per-user, and the security sandboxing of locked pages is not supposed to
be per-process. Other places (vfio, vdpa and infiniband) have used
mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but this
is only per-process and inconsistent with the new FOLL_LONGTERM users in
the kernel.

Concurrent work is underway to try to put this in a cgroup, so everything
can be consistent and the kernel can provide a FOLL_LONGTERM limit that
actually provides security.

Link: https://lore.kernel.org/r/7-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
(cherry picked from commit ce5a23c835aa0f0a931b5bcde1e7811f951b0146)
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 include/linux/sched/user.h | 2 +-
 kernel/user.c              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index f054d0360a75..4cc52698e214 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -25,7 +25,7 @@ struct user_struct {
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
 	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
-	defined(CONFIG_VFIO_PCI_ZDEV_KVM)
+	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
 	atomic_long_t locked_vm;
 #endif
 #ifdef CONFIG_WATCH_QUEUE
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539..d667debeafd6 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -185,6 +185,7 @@ void free_uid(struct user_struct *up)
 	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
 		free_user(up, flags);
 }
+EXPORT_SYMBOL_GPL(free_uid);
 
 struct user_struct *alloc_uid(kuid_t uid)
 {
-- 
2.43.0

