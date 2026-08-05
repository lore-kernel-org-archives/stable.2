Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388653F7886
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922537; cv=none; b=CtusI9+THUROKYbEY56qCj025UBmPCN+WRtivGAyz5jtmpd1Wy7r3SMxM+CDMXXZmWi5ams+NQ0YikOj4GYg4D/VeWACejIiaZ7nlswT9YfNHhE8C4ELR+DCAffZhL7QnXY2EZRQhPGWdRmX7SfldllsNKoecoh0G0nLNubc+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922537; c=relaxed/simple;
	bh=/TbkWnyztBN3dzt8AptdA1Bb8h5LZGuOjwLmzO5dfrA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YmwX7DUccpRuEXz1hu6i4zNyZv0VRO11HK3rnUdrcw6+E1XLp30uqFrZpFPUFQnLaEzyEl/FDKs1GeJqVAybzj/+YakR1mtDSS9XWl/PKqEqv9PczAh4kOwz8K+946W9rfYI+VG3Ke6J+hjPjItvzDD2/N04iWucI212kblGbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sRiDZjux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sRiDZjux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9881F000E9;
	Wed,  5 Aug 2026 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922535;
	bh=gsOjf9OmjGos5ao0/O8/NVc4i3B8HiPC+JpM0m/MHPQ=;
	h=Subject:To:Cc:From:Date;
	b=sRiDZjux2DugU/6Eqo9CC6AFOJGYpgE9rDJLh4+L7iLmbO+y3nvg0jEiHHsk3PTyZ
	 OgHVQ0MmPjAftYMYoqb6TZtnIx9AzmyTmVPHtIxopnplJ2sQhsHl7ohGr+FkWfA/1Z
	 R4YvDoycU/M6w1r6S/IinG7on3UUpnuXNstapHvU=
Subject: FAILED: patch "[PATCH] KVM: s390: pci: Fix memory accounting for pinned/unpinned" failed to apply to 6.6-stable tree
To: alifm@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:35:08 +0200
Message-ID: <2026080508-lard-selected-739d@gregkh>
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
git cherry-pick -x 36f6999ecde3976731a8bfc0b8e667da6f593069
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080508-lard-selected-739d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36f6999ecde3976731a8bfc0b8e667da6f593069 Mon Sep 17 00:00:00 2001
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 23 Jul 2026 15:14:05 -0700
Subject: [PATCH] KVM: s390: pci: Fix memory accounting for pinned/unpinned
 pages

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

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index d2a11cdf6941..0741aed442bc 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -190,33 +190,54 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zdev)
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
 
 	cur_pages = atomic_long_read(&user->locked_vm);
 	do {
 		new_pages = cur_pages + nr_pages;
-		if (new_pages > page_limit)
-			return -ENOMEM;
+		if (new_pages > page_limit) {
+			rc = -ENOMEM;
+			goto out;
+		}
 	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pages));
 
-	atomic64_add(nr_pages, &current->mm->pinned_vm);
+	if (current->mm) {
+		mmgrab(current->mm);
+		atomic64_add(nr_pages, &current->mm->pinned_vm);
+	}
+
+	kzdev->user_account = user;
+	kzdev->mm_account = current->mm;
 
 	return 0;
+
+out:
+	free_uid(user);
+	return rc;
 }
 
 static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
@@ -279,7 +300,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(pcount))
+	if (account_mem(zdev->kzdev, pcount))
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
@@ -400,7 +421,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
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

