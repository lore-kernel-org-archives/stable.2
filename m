Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F4233944
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997782; cv=none; b=S0uWo+1izoPrWsDJbHQfsugEzTXM1P8VcIaDyowwqUTwoqMjh4Q2tZZNPGB01boGyzYi9tIIdvdOqtmdh8czgkJfarpDxC5BdnRmA2NewNVcsES72qvw3wFXRh+EUnlKODq6eRykCnNQJI6ovwdBph7qJIMQnzrG/j6dUwAitSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997782; c=relaxed/simple;
	bh=Xp7zhySrpJYsPCZb0uc5V9Kp2tOX8jCIPjtGpo5wmUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrZdcPVbEhtG2m0a3uvyoJ5cr9iuX7J6dbI54g2ULrxmPh2afpN68TKebjrskxHpCp6PBJU7PlPhYSND374S6YSEnkgoTbQTfKsPy1qGNQQJQxoLWX7Bgv1qgtlIlYNj5Ve75B7joUpJC6gy8sxW22+JfGLCsra/SB2qoyeWquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pTLXrzxU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pTLXrzxU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIVkWr2174060;
	Mon, 17 Aug 2026 20:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vbI9WZpgKxAof83H5
	wv7GUkc5GwGamhkMTn9NeqgdG8=; b=pTLXrzxUNsGNGcovEn5gyBVHe5u4IktWG
	Y4kuWyLwO1jkiU4Bo3BJkWo6JXII+4MgNqjnf2UrBpvl5uNyRxdIiY6AOvl587+u
	9FM2zHZA7dqc4iwNlu90W/GpN31mkH/nFRI7pSSveqpB/8ucLldd2Wi+ugw9NLZf
	a/Kaekh6Sn8bJPzDtLhPE6UN1RFyaJO1cD3IbSmf2rntChikFS/f27QdvJe01cZo
	YePQCXJzaoCckiomNjbWC1t9+tb9hcJK06FqWTjaeQRWAD22oTleLuxWzCqR54sZ
	PkOAtH4CnNP365ELlQULOLDtsKVtF8JKBCSag2OqEcZeHPhSjwUCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4m6st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HKBNZi031018;
	Mon, 17 Aug 2026 20:16:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejyk17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HKGAqk26477076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 20:16:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB58558065;
	Mon, 17 Aug 2026 20:16:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 062925805D;
	Mon, 17 Aug 2026 20:16:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.120])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 20:16:09 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Eric Auger <eric.auger@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 1/5] kernel/user: Allow user_struct::locked_vm to be usable for iommufd
Date: Mon, 17 Aug 2026 13:16:02 -0700
Message-ID: <20260817201606.3194-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817201606.3194-1-alifm@linux.ibm.com>
References: <20260817201606.3194-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EOEI-p-U6oCuMe36_mtYQHvhBMdCUQUb
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a836c0d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=-gLlHuE2PaxnPGtbEqgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfXytl+k3ZAilYS
 Iix88umjPEDqv7aoR/llhujDLl+TAm6W/TrtRdp47wc0EywpLG4ZjyJlq+DR8w5hKOo46uJFway
 MKHigplhN4vvAKeb4blNeXyc4ITdwrk=
X-Proofpoint-ORIG-GUID: EOEI-p-U6oCuMe36_mtYQHvhBMdCUQUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX2NyOZAVCOZfs
 yJsRpXSjENEwIixFLATCReiiHyB4uJda2IPERo5dP0qs0X95tixO3surQF6AtB/5KkHkW4RQDeu
 b0ae2i/3JIg36klDMAfmPxT3Vi7Cg6qmIgf1V/rXPnHhniVIcTTVJKowk+QOTprOPyjTvui3Qm9
 RX3LSu/5ipiYnSQnh5Hp6ivGaiiskrySzNT040h70RuOzt1dFn5ZGUEF8s4rj9MCQ6l0sXoH3Ms
 xCpParMXjFNs6stAPXll/26L8E8uynvoKBVtRnlmaAU+cXt3Vx5RUfRvRxdaUYmMWilGtlcFbiI
 +60aYjkf1+5NYglO/KBlgkjc7sdsJJXJq7jHsaU/w5MrEUpNLUB8G9Ajj3JEZf2ouCB3WbFgSGd
 4Sf+HQEVoHkMuBS2rTaAOlIzRJZeTTy0l9BDem6x2gAjmAg2FLY1/pKC8U+mPPFktZ//jSK//3X
 yR8FAtPNpj/xIpRVhYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170153

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

