Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32143B95E7
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997778; cv=none; b=XTklpVP8Yy3SRrNzhh3gX9yrBO+g9e4CKF3JN+Vd73abGkcdIaSTXYz16ZzAYGtjVeK+IRzzfB09N1flly6nA1vSB0ppDJCPLNOoZNmk/P2UHfgQuJyOApdwTtgU9EjWtrOMbaFsTsb/PdC+1zmJJA8UWPDydSpLJd+TsAXoEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997778; c=relaxed/simple;
	bh=J7YIAXDPGFL5u9UhCc/Xea6uDU0U1A9mk4mE368U7qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYNrJHJAgiBq2wdLzGBdaDJpRhRw6iYypkEGgPnOkpZr4p/9FxUrmuiV30B+EPg3uXdmBIS9yjyr4aeEjxBghL6G/TZLOVOz4HYta8wCK5GLdo8Mhlw4CiZQyG16X7sWagvs8SoOh8b4x8ZtN9H/QUD4VRBC1BOk7SzL4/fYFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJi4LYR8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJi4LYR8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIVtCs1065681;
	Mon, 17 Aug 2026 20:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4V1VQWyhaXf8FOYiq
	2ksl5sk8gUap4+YnYcW30YDayQ=; b=BJi4LYR81mw5QtjZyh+LbQl9hWOv1D3Ol
	a6dESNkLsPpAt6muy2AOFkGKqABH8CcmUae/pNiH4g913I4JcCw4bGRe5qkKa7bs
	XHErAREXkfmJPOAWajLbk/5UrwYrVlcIcGW+bY0x6ZQXvfwFj/9yKeKEUUGFD0RJ
	omBuBYkz3xqHAgvX3tlCOmgKGcIxc6+rW178jVKL5rbpMi4CCTdGWJeCGQ5yuN0d
	wNGB8hcVBrW+Rg5iMvlprlAVMgVzW38dRwjVGZqQ+zZN3Av9MqjnYTAwXYwkVl2K
	W5cCVFJ/NQGa8+Gs5GTgJHNMYUFeQRTi6EpqFlHWe+2XfD5aC9vMA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe3whw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HKBguh005640;
	Mon, 17 Aug 2026 20:16:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xgyha6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HKGBq98192552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 20:16:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AE8A5805D;
	Mon, 17 Aug 2026 20:16:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E609F58056;
	Mon, 17 Aug 2026 20:16:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.120])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 20:16:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 2/5] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Mon, 17 Aug 2026 13:16:03 -0700
Message-ID: <20260817201606.3194-3-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfXzwfLrHaZ9v8I
 0rH7s53IcGgFvAW0kLMlpQZQPKDcdiHajWJXalaaMXRZSvDteyoP1G1l+O630Hl/E6bcfSia+Ix
 D398NMG0f8llcmeMb2K/g5iE1oOUCeZ8yBBKD6xklpLzs3UirzrO5P2GgzYdJTkiR1cNUzEJu23
 kaWVKlDdVIGpoEWSI64foYQvF0jRtlAuFLcqcDxJXeGFGvnKSZB9z0O1EAZALcg8d4KQ20fDAgH
 gipHaCKzz3cSbwt1xXV5blKXvcKzYXA/EKqiVw8JOgzcqxNRJKNL4Wb3OWjTn0AaMZIVU6xk5zH
 Mu1wH7bngpLgZNnhqBqDM2kZqfi4WKNKMnPRsn2NlYatGc9695IbWXj4oZ0ohptMfyH5tYqP0B3
 GXKLVChweuAtmAypMC4SDEPay1QQoH8lXxXzN9dEWqqfdS9FKe7FyRtUul0QZFARZsU6x0cZmUX
 VLYdafPo4xy9nvFBHlQ==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a836c0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=axipAET6x17LYUbcMfoA:9
X-Proofpoint-ORIG-GUID: 9mk4KGcCA6nTsMC1c0lmz58X_AEnnNMs
X-Proofpoint-GUID: 9mk4KGcCA6nTsMC1c0lmz58X_AEnnNMs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfXyLIZHS8lFU8c
 +oX3zONrynLVV3Zst5bi1dgYO+nz/arDwY5MdmHbZDYiuqmM5ZPBQkcOhreRqxf+7YhNR/ZHEiH
 SZedHgJWvhYxESle/VdBMn4G3ExP088=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170153

The account_mem() and unaccount_mem() functions call get_uid() which
increments the reference count of struct user_struct on every invocation.
But we don't decrement the count by calling free_uid(). It also
accounted/unaccounted the pages against the current->mm. But its possible
the unaccount_mem() can be called from a different process context than the
one that originally pinned the pages.

Let's fix this by storing the pinning process user_struct and mm_struct
when accounting for pinned pages, and subsequently free these resources
when the pages are unpinned.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
[borntraeger@linux.ibm.com: Fixed whitespace]
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 36f6999ecde3976731a8bfc0b8e667da6f593069)
[alifm@linux.ibm.com: Resolved merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 48 ++++++++++++++++++++++++++++++++-------------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 45fb77ada977..4b1ed363b1ef 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -191,34 +191,54 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
 	return cc ? -EIO : 0;
 }
 
-static inline void unaccount_mem(unsigned long nr_pages)
+static inline void unaccount_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
 {
-	struct user_struct *user = get_uid(current_user());
+	struct user_struct *user = kzdev->user_account;
+	struct mm_struct *mm_account = kzdev->mm_account;
 
-	if (user)
+	if (user) {
 		atomic_long_sub(nr_pages, &user->locked_vm);
-	if (current->mm)
-		atomic64_sub(nr_pages, &current->mm->pinned_vm);
+		free_uid(user);
+		kzdev->user_account = NULL;
+	}
+
+	if (mm_account) {
+		atomic64_sub(nr_pages, &mm_account->pinned_vm);
+		mmdrop(mm_account);
+		kzdev->mm_account = NULL;
+	}
 }
 
-static inline int account_mem(unsigned long nr_pages)
+static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_pages)
 {
 	struct user_struct *user = get_uid(current_user());
 	unsigned long page_limit, cur_pages, new_pages;
+	int rc = 0;
 
 	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
+	cur_pages = atomic_long_read(&user->locked_vm);
 	do {
-		cur_pages = atomic_long_read(&user->locked_vm);
 		new_pages = cur_pages + nr_pages;
-		if (new_pages > page_limit)
-			return -ENOMEM;
-	} while (atomic_long_cmpxchg(&user->locked_vm, cur_pages,
-					new_pages) != cur_pages);
+		if (new_pages > page_limit) {
+			rc = -ENOMEM;
+			goto out;
+		}
+	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pages));
+
+	if (current->mm) {
+		mmgrab(current->mm);
+		atomic64_add(nr_pages, &current->mm->pinned_vm);
+	}
 
-	atomic64_add(nr_pages, &current->mm->pinned_vm);
+	kzdev->user_account = user;
+	kzdev->mm_account = current->mm;
 
 	return 0;
+
+out:
+	free_uid(user);
+	return rc;
 }
 
 static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
@@ -295,7 +315,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(pcount))
+	if (account_mem(zdev->kzdev, pcount))
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
@@ -424,7 +444,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
 		pcount++;
 	}
 	if (pcount > 0)
-		unaccount_mem(pcount);
+		unaccount_mem(kzdev, pcount);
 out:
 	mutex_unlock(&aift->aift_lock);
 
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
index 486d06ef563f..6beea19cea45 100644
--- a/arch/s390/kvm/pci.h
+++ b/arch/s390/kvm/pci.h
@@ -22,6 +22,8 @@ struct kvm_zdev {
 	struct kvm *kvm;
 	struct zpci_fib fib;
 	struct list_head entry;
+	struct user_struct *user_account;
+	struct mm_struct *mm_account;
 };
 
 struct zpci_gaite {
-- 
2.43.0

