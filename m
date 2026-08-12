Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032D450911
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569851; cv=none; b=RbVn9qT0sK1n51JwHL+Wr6C5Ju5FbOYKhC58ZycvhXf01V/HhLxZK6+iHaFNpbCGnLdBSIbYqLwGNDcO1fciQfHsyzeuLJ6UgE8kvPcFxNyeB0VGmfl2xnXxEjOBo2DUjCrv7rlppv/NP0omZarxvTsH9KZGwoSBzyoD2WfvPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569851; c=relaxed/simple;
	bh=EebRkCSj4VO+ZYz0kCJgD8nazIpzkvb7Mv3Hpz02rHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcwleA10mbr78ubtC84bDngsWSaO5ChZQvjyeI2WqzWtqSzG0ayM1Wp/ZvkiTUzYiECFR82iB742dmRYmbOMjlF83kEhRbp1zM1QSDCZ5BcwPo2+zme1Gimo94Jekqf9+BJxxCFlOGtHGFdiyxRNOFKBSu0c0SlDqXIv9Pe3rfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G/UyAmCX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G/UyAmCX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2bVQ2612912;
	Wed, 12 Aug 2026 21:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v/dYldjJD/pPVWpW8
	hYSU0TX+izIejXmjJRKZ/0XQP4=; b=G/UyAmCXX54IMZ1eVIq71cXcwOEmpht0A
	iR+xEO9qYMjPFZBOVMK3kxG4Aj9wIUECiuddq0tiNGeZntmJ337c/jygBH8SDFxA
	7MycL84X3zklGM4Y4X19Q3bAn30+0OLxBDrh1zfTyRA6nqhH4UZ2qqf09PuwwN3j
	vhkXMX53+kmMNbIUnajfUhPIO3pWOnedt5h9qib074gN+tiOd47OFhIJa957KzxB
	XWy0muFAvBklabKA9Nr6rUo0i9HowpsgTgV3XsQsYkgrBEKUr4yFnR8ErUbikKhn
	XVQ58E/AuD9qslqkLGjynMAqYdFhCRR5bDKkxpw0QdfeERjlp0B9w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk04tvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CLBFVZ004944;
	Wed, 12 Aug 2026 21:24:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy7xcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CLO4YN65601970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 21:24:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D44358055;
	Wed, 12 Aug 2026 21:24:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AE7C58043;
	Wed, 12 Aug 2026 21:24:04 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 21:24:03 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 1/4] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Wed, 12 Aug 2026 14:24:00 -0700
Message-ID: <20260812212403.3143-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812212403.3143-1-alifm@linux.ibm.com>
References: <20260812212403.3143-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX7wQsUUuIiZpJ
 6WPqoXywiBMzfIibhieq8xi63HO94OG3SJnSt4Leemwmim7JqRaH1+J6IhNZGISNPwm0mOTnv/L
 xcd8iiYjflhRxJvHoNWUerMMyTIQUBUKQu/H2hfNoGu2CJHejdqM8yHfjQxTtzlgUigCBFMmnAk
 OCGjNV6HlMp7dDPQvjI1dnqESANWx2wRHN9KvvtIEr/DdnjbDzrf/2S3WT7hmoPWXHOAALSil7z
 y5iZM9Dp4zXfX9DeUwsX53IB4ZcP2x5kljiC+IUezVLy/bN56W4nulgZvnAgSz/HqaCk7lAVwdY
 tkRoTzAq3iWT3nSUdCeL4rQkNjcTWylxJlUs1Y/Vi91L5WcHllaTzYjdCgxVoxW+K6XudtK07Yb
 q03i8OeiUP5agYkey9sdwB29inDkxUgkTSAnvoLbb/Z9ljjfCHc6BLB0IbbWR1B5eJw3j916xV8
 sdi/NP3HYny+cwOG/gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX/TqKnSnwweyc
 aXo9QeazlXcI3FcEWmlrQ1Ztv25aCWNKrDIeUbR0CC/12g8sWMdVEoITFQ2bLssETSk9f9Th8f6
 s0cjtJQzmObixU7UL8GcUNWIskzG/z8=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7ce477 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=axipAET6x17LYUbcMfoA:9
X-Proofpoint-GUID: Mtif7PZEq4m9moiRRgTex413_s_0Z_cg
X-Proofpoint-ORIG-GUID: Mtif7PZEq4m9moiRRgTex413_s_0Z_cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120169

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
[alifm@linux.ibm.com: Resolve merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 48 ++++++++++++++++++++++++++++++++-------------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 17fedfc7bb99..f887e11b0f1e 100644
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
index ff0972dd5e71..fdf8c7bf4ed0 100644
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

