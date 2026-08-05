Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A93FBB67
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922545; cv=none; b=Vew6O6D084xcbjGj6gozuZWCB+WZ3AovjZcnxxhse6nGagTo9RnJcL+KaYl5UTyNcf1khcKR19rFUbWV16SeUvLGGjpuF8ACr4Fkx5folU8XLobwk2SbigHwPP0TtDlvAX8xsFb+WQlswZCdZbUR9OVFrHukTkqhlns2Z5Z2duw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922545; c=relaxed/simple;
	bh=d2Z9JSbwToPQ8Z2cVekMY7CUKM1cQTva7n4TxKEHAnE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N54uEQ2EDA0m9Od/YvIA/ZrykRjjmK5GMiErpc7Qh5rEmCAjFylcA9nDso52BOkBEf6AmLMs++Qt8kJUdhAURYRj0Mk6TpBKblhbYVDZuhjxh1Rp4GBkkFY7x40lmY4rCbHLde2mlcXj3W5EWPCrhXy6HIkfxJ+e5/IgNsmiP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTkV8Trc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTkV8Trc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09EC1F000E9;
	Wed,  5 Aug 2026 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922544;
	bh=O/qE6fIq1/wgLPUsZ0RM2C5Qe3yo1UUpE/mXtwpUfyk=;
	h=Subject:To:Cc:From:Date;
	b=LTkV8TrcXZS4Hdnc1inr0ntT3TOIHPI2XLBJqPPFS9slQliOiNG7Wo1IvfaxpRTzf
	 nNmu0auPdic9/vJiG8N9+z89GeMckEsbu/PKN6BzsuPCVPqaifDSeLdDwd69tB9jzj
	 pDpMIPl4392FH9pW0IYi9Pj0y1vh0DCk/BrVxvjk=
Subject: FAILED: patch "[PATCH] KVM: s390: pci: Fix missing error codes and memory" failed to apply to 6.1-stable tree
To: alifm@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:35:18 +0200
Message-ID: <2026080518-quench-deafness-37ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f86842e4d6c482300f4567f492d512c9ccf5bc4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080518-quench-deafness-37ac@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f86842e4d6c482300f4567f492d512c9ccf5bc4f Mon Sep 17 00:00:00 2001
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 23 Jul 2026 15:14:06 -0700
Subject: [PATCH] KVM: s390: pci: Fix missing error codes and memory
 unaccounting

In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating an error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 0741aed442bc..36eb30953bb5 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -300,14 +300,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(zdev->kzdev, pcount))
+	rc = account_mem(zdev->kzdev, pcount);
+	if (rc)
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
 	mutex_lock(&aift->aift_lock);
 	bit = airq_iv_alloc_bit(aift->sbv);
-	if (bit == -1UL)
+	if (bit == -1UL) {
+		rc = -ENOMEM;
 		goto unlock;
+	}
 	zdev->aisb = bit; /* store the summary bit number */
 	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
 				    AIRQ_IV_BITLOCK |
@@ -351,6 +354,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)

