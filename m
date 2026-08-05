Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D6E3FBB50
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922542; cv=none; b=mRDZ+5xf3EnnKnnsCBcEdkpUmEfm8DwAU3PILYe1lRYxDZenGIc+lIozf+YON1ZOU307HAZwlyYri5nvH7BA2zNN9gEqv/8JqUUGJBItoAFcs4Kf0UxozHGGSGR0D5UortSKBNRzdgY0Xak34ZHHVzoAG6vOdfYkGIa2hP8o5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922542; c=relaxed/simple;
	bh=zZe2oDeiQlqsAtzjEyEswRcGE1BBHeDbqJ1rv3LjJ/w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=puqxBfm6Zzcizb/efNJ6BkqspWpAeO/6YT4AVypDKmyYVff4X14bSJEQke56HO75+MnK4Nx+vSt5NH4aj0nNujqygWFFz1HIrhgpZYua4VkK6VSg+uss4hr1xgHyZgMUJzwggri70R/y007s6ZRFakzLCpBAxyygpYsQOtwsd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgLF93G2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgLF93G2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B601F000E9;
	Wed,  5 Aug 2026 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922541;
	bh=buo+yWCtTy5ssh5reTa3yOqWOjpmbyW+X7JVbNoVbyk=;
	h=Subject:To:Cc:From:Date;
	b=XgLF93G2b8BzJZt8G7b/e92+XVwZssWrR1Xtm2UjpVE1XkVe5IDirVf9uXPRHkwNY
	 nECNl/DhgovZi+SKBS4zPZR62AfuMhClwZ98XCQ78B2Oq+pM+Av5ZyEq2sjZGx020j
	 5p177yksEnwzlmJtrovOT9yeJBiMehNlAfU6vEHE=
Subject: FAILED: patch "[PATCH] KVM: s390: pci: Fix missing error codes and memory" failed to apply to 6.6-stable tree
To: alifm@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:35:18 +0200
Message-ID: <2026080518-decimeter-stainless-2d0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f86842e4d6c482300f4567f492d512c9ccf5bc4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080518-decimeter-stainless-2d0d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

