Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD63FBED9
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922555; cv=none; b=PWWf/URCp1qG+zOf5+Bcvd0E+FkPXFT84Z0cSFjlIrvnkFVBAKCNi41y5UeC63ApPNg1L6LeR4lQYtuALGdRATYN33IalhWAfD6VJHHQWounCs1osuWbDTHWSA6HrZMBp3/AgWKSAEajYFSpWZPKlGDFJlNfdCdS79y4lyWG5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922555; c=relaxed/simple;
	bh=vG3C/FlwCWZ9NsSn64tWZ4XBEoA1+goH5bNZiISXu5o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KZ1nwEDgo2izbX9Y0aar35JPjMacpMYUU/5KN/uozpeYxxCAG5IyAHUviW9a8iPCuMttYW4US2Hh9/6F3vKHW2uDHCJR0wnFEW3O4vdLFO3/kkzt71Xug5epqrtAOEXGz8n1AyLFSAEIlUkwqWBa16gAQKWrKdGaKYqn53X3X1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vzc7/hsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vzc7/hsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDE11F000E9;
	Wed,  5 Aug 2026 09:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922553;
	bh=P5XOtQeNB05vuBkzlrkZhlr5TNQhbvCuyolUrBx8fpA=;
	h=Subject:To:Cc:From:Date;
	b=vzc7/hsLRXUJkD9fqmnVCAHuNhZ8X8WItUCXGlnZSZ2gq+NS9A02rOK6jrRCOx6vR
	 iXnGMjE0S11u43T4IztZgc51SDcgpiJyuMZd13piqlap2aAneMDXRFyhcMdLL6dWMH
	 cHir7G+Wi4GG3dcJrXonD5yQX5KSWIFFxG7QLu7Q=
Subject: FAILED: patch "[PATCH] KVM: s390: pci: Fix resource leak on IRQ registration failure" failed to apply to 6.6-stable tree
To: alifm@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:35:29 +0200
Message-ID: <2026080529-pushpin-obscurity-6efc@gregkh>
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
git cherry-pick -x 5580c9858f1e00f60191eb09c3add359836d60b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080529-pushpin-obscurity-6efc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5580c9858f1e00f60191eb09c3add359836d60b6 Mon Sep 17 00:00:00 2001
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 23 Jul 2026 15:14:08 -0700
Subject: [PATCH] KVM: s390: pci: Fix resource leak on IRQ registration failure

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages. While at it, remove dead code that stored FIB
values that were never referenced.

As part of the cleanup, we are also holding the aift_lock a bit longer, as
we hold the lock while executing the MPCIFC instruction. Though this is not
strictly necessary, it means we don't have to drop and re-acquire in the
error case.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 1eb127fc9f89..50f495bc8303 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -344,19 +344,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	aift->kzdev[zdev->aisb] = zdev->kzdev;
 	spin_unlock_irq(&aift->gait_lock);
 
-	/* Update guest FIB for re-issue */
-	fib->fmt0.aisbo = zdev->aisb & 63;
-	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
-	fib->fmt0.isc = gisc;
-
 	/* Save some guest fib values in the host for later use */
-	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
+	zdev->kzdev->fib.fmt0.isc = gisc;
 	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
-	mutex_unlock(&aift->aift_lock);
 
 	/* Issue the clp to setup the irq now */
 	rc = kvm_zpci_set_airq(zdev);
-	return rc;
+	if (!rc) {
+		mutex_unlock(&aift->aift_lock);
+		return rc;
+	}
+
+	/* Start cleanup */
+	zdev->kzdev->fib.fmt0.isc = 0;
+	zdev->kzdev->fib.fmt0.aibv = 0;
+
+	spin_lock_irq(&aift->gait_lock);
+	gaite->count--;
+	gaite->aisb = 0;
+	gaite->gisc = 0;
+	gaite->aisbo = 0;
+	gaite->gisa = 0;
+	aift->kzdev[zdev->aisb] = NULL;
+	spin_unlock_irq(&aift->gait_lock);
+
+	airq_iv_release(zdev->aibv);
+	zdev->aibv = NULL;
 
 free_aisb:
 	airq_iv_free_bit(aift->sbv, zdev->aisb);

