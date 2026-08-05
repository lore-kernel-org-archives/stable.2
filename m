Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6A3FBED9
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922549; cv=none; b=o2Izb179AhFIcpy5cfT8EL05MlIOJOMKGFFyyA04TLDvpKcH9JoKQO1lQboRd9dCWPYl1qWp6IWooEklvb94iouC9F/u2s94TGNdznA6BjwYVH9j4G3CU3uPExljqQEwV+oPgOdqN14s2oNPrlkF64/RvC67fDp4xF9OMAjUfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922549; c=relaxed/simple;
	bh=szYpqm4bl/55gRX40zGk354yV0Pk09obU0AqyzIBXqo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eSpMXUi1/cfUGDZPNnhzk48/pgk7lgy+Q8HMSOjNJbN8I0A2KKfRzGP2DY6xvJmpSt1wS4GFdDTqcrGEpHz7IGrp15olapIzZyG0T52/oIWzD954d/GBYXXTH5pZeyYrGHBvA+LDcv+hbQenxWE+XPwup5sfnRh+RkTJg8H91Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AV9Lr/Dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AV9Lr/Dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9551F1F000E9;
	Wed,  5 Aug 2026 09:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922547;
	bh=XPdO5eAu2MQpcqjGExHHRTPApzcthl3z9QQ1jx3z4UM=;
	h=Subject:To:Cc:From:Date;
	b=AV9Lr/DpxCf/RKcOyBB2Q+WEAVp9HggrjjJYLrZ1R7fGRdtzKjhDLzSog3CQ9e7YE
	 SbQ11ATiI8mG91J1YsTZkRXnI8WsaGguT3YUlYMy6oR9BQfu3xQnUSIWT3pHxYwv7J
	 Q5u2I0w4QYMl3hdBIlibCjkzlofkeSvmnxSd8ryA=
Subject: FAILED: patch "[PATCH] KVM: s390: pci: Fix missing error codes and memory" failed to apply to 6.12-stable tree
To: alifm@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:35:18 +0200
Message-ID: <2026080518-tapestry-tartness-3f01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f86842e4d6c482300f4567f492d512c9ccf5bc4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080518-tapestry-tartness-3f01@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

