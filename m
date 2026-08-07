Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C81A9F91
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124758; cv=none; b=aS119761m0BWxFYMLNTrW08QPJuAZy0LS4AJ+3ILPPD8MTrKFwBVzMmCchRAlafm6uqlDwlhJrih3dKyE6uuHxBxQgcwnTGNLbEConJUb9zWAc67bLAh0FpAVmPDVsc2gW6jNHJ0DVfWcGSq2eanQmRcurSZeW9YCYc1RnXiZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124758; c=relaxed/simple;
	bh=7QS6O44zPa5mTY99Jyh4EDltlqbLnUOwYfbmvUbhnME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tr0ZD7Q8eIGnt7UfCXJ4nsSYVPTxHVnqhYc9Kz6I1YKBYe1hyzVkjJfW4O/Cmjdzs+svqVsAa5w4zDQiGYoCP7Msr1kC9NnFZJBVMgD0B8yT4+WbyT9xaYKE0q1bjJ2Gs9XGHJgSUlenpa0fMf9w8BkMqgIkq77VPrRQWfJFU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UZsfeCKU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UZsfeCKU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Glt9j1937448;
	Fri, 7 Aug 2026 17:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1I7pi7YTwQLsZYUg+
	053aNAcNxOcvLhKotKeQkFHtZ8=; b=UZsfeCKU+MjThNeWwhsv65Bz3Mg74qrbO
	yDp2vjnoXoqgiph5KbSyM4awy+FQtWHDHLpL+jtLc+0C2ffmrRO8F0nWY9IaJ2tW
	c8e+h34G11GqxRHYzYmV8H5LaWiCBPJ8vJgMOmEH80TjgBe5y9cY9EsKhk4JzOPv
	gXOWrey2nzkt5iIB15ByAe4zAZlWzdfaRM8l1aO2VBeYUl/XA3LAR7u3TYTJWfPa
	btMhHKAYrYqCkA9bG8QfN5Yq3SL16GAcGiEqDumxrRhIlkXUnmHBGRHJKHgWdtGR
	5sz9Z1QGZ1eL+nvyPJhffUgUOzldWzdVbK6+2LmbkSnq1rnJbcsUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02500m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:45:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HfKUY001308;
	Fri, 7 Aug 2026 17:45:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhrn6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:45:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Hjpl74981642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 17:45:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1DFE58056;
	Fri,  7 Aug 2026 17:45:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C3358052;
	Fri,  7 Aug 2026 17:45:51 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.14])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 17:45:51 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1 1/3] KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
Date: Fri,  7 Aug 2026 10:45:48 -0700
Message-ID: <20260807174551.2359-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807174551.2359-1-alifm@linux.ibm.com>
References: <20260807174551.2359-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PO4kF_T931as1y6mfjHB0zl7M1uNj7Kw
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a7619d1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=axipAET6x17LYUbcMfoA:9
X-Proofpoint-GUID: PO4kF_T931as1y6mfjHB0zl7M1uNj7Kw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX7+HSiBpZ++30
 tqNou7jHxN6Jq51vwQ8aiJ3H1N6hGl7bLYrMv6a5Rj4u+GjdXK+66a1qLWmq8g+73y6qanVHgVk
 FcJNM1x3QMvfELTWXJCNNPONpJQlJLc/fUw1z8mLlu+0hPNquLg+ULa1Q6r2UulCADiinNunasm
 M829za1qQ9LOiT4O4HTG7nV+QYGG+LJQXjWFVVeNxgk0uMvxsvcMzzHURfmi76UW4fI4o69iqx3
 22moIrrE4yv61v8bT8e6v/Ly3H0YoXLvFwSEbFi4BhtNefjuxLEDJfxodY512pcMxFcofP6Mtgk
 UE57iQfw1U0GnaBt2Qbipst5eqKe+uI37P3c35TUehvpKS98rqFPVqjSgnDtOkmHljofhBIcq+0
 D0Wdp9QC80CguQV/QXQDtv9Rcq5i+zI9ewtAdks4A1pYePERQE34kz025DV9hfCK/pZMOxGEG+h
 oNY4jecsWDc3LdeDaWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX+fHSHXPdR+Gt
 1JFqA6F0cCZi7p+sPqslOxJjK9Muae743jj3g02jkdvlhcFROvv+KrSMCtmzl3MYy3jGwEU6yEi
 EpjtPp5BLzCamWmxr8PHKM74n1vnCTA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070135

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
index 6e6726b2a441..73989825b49a 100644
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
@@ -277,7 +297,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(pcount))
+	if (account_mem(zdev->kzdev, pcount))
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
@@ -398,7 +418,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
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

