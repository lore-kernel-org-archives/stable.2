Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F0514751
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681832; cv=none; b=syBotwAWlL5IHjhCmPLtU24ajM1Wx/9YqmR/gVlBwzoG+i5xk68WnldxC8tfZoKWY4POoZq7cSC3BNRz1Mzxl2bDcxoL31JvdeDLzoLZwQ/M9mAvC+CthP9dsvNd4YHGXcjiWkGcYDyqyfixxPbNVlj6UuLz53UWLUhwPM6AfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681832; c=relaxed/simple;
	bh=/xwNjs3q1MPB64U+UzygToYIfgHblAmb+HY0RhL72NQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r3MLxTMmpmNiJ9fyQCNaHxFkUr/5ltFp9UMGD0fj2EsxmFX6aQT47e4WmU0gbF4LZ/i6WYHsOpvD8lKlCasrR8jPTUMIYGNporWJnDpJlNgnyhJ+sDOIf7J+Yefz8XWHGIzWzrElWR/BQfKAK+KDBV2fuUfRx0vhBEwaO8dMxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPoVbxJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPoVbxJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18441F00893;
	Tue, 29 Sep 2026 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681829;
	bh=zOSrjOQJMFx02YMgmJU6CbLAqx7uEIrXvMT/2VvBhNQ=;
	h=Subject:To:Cc:From:Date;
	b=dPoVbxJV1CVZy0HyB2XTvYb+BqUOScp+wLdtr7uIJsKUOf965FuO5oTPuYfP4rGL3
	 t311IVxAAnL8niKM7PMosQAr434Ms+cIbfWzUbArL/SFBnt7cYwvH7EBd+5kiXgqEg
	 31sTc8YJrQ95eSP4i949/Fc0D8UqHtuQXvNMT/sc=
Subject: FAILED: patch "[PATCH] s390/pci: Fix leak of struct pci_dev reference in" failed to apply to 6.12-stable tree
To: schnelle@linux.ibm.com,alifm@linux.ibm.com,bblock@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:37:03 +0200
Message-ID: <2026092903-caption-humbling-b2c8@gregkh>
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
git cherry-pick -x 09b7040a1b79f4f61cdad6d9af972e045bb7c498
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092903-caption-humbling-b2c8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 09b7040a1b79f4f61cdad6d9af972e045bb7c498 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 16 Sep 2026 17:14:10 +0200
Subject: [PATCH] s390/pci: Fix leak of struct pci_dev reference in
 zpci_report_status()

In zpci_report_status(), a reference to the pdev associated with the
zdev being reported about is acquired using pci_get_slot(). This
reference needs to be dropped with pci_dev_put(), but this call is
missing, thus leaking the reference. On subsequent hot unplug, this will
cause the struct pci_dev to not be released, leaking memory and
preventing reattach.

At the same time, the only existing caller already holds a pdev
reference. So instead of reacquiring and then dropping another reference,
simply pass the existing pdev pointer to zpci_report_status(). This gets
rid of the need for pci_get_slot() as well as the zdev->zbus check.

Cc: stable@vger.kernel.org
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index f317a1465dad..3b4941b65840 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -298,7 +298,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
 	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
 	device_unlock(&pdev->dev);
-	zpci_report_status(zdev, "recovery", status_str);
+	zpci_report_status(zdev, pdev, "recovery", status_str);
 
 	return ers_res;
 }
diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
index 7030f7052926..867419779219 100644
--- a/arch/s390/pci/pci_report.c
+++ b/arch/s390/pci/pci_report.c
@@ -89,7 +89,8 @@ static struct debug_view debug_log_view = {
 
 /**
  * zpci_report_status - Report the status of operations on a PCI device
- * @zdev:	The PCI device for which to report status
+ * @zdev:	The zPCI device for which to report status
+ * @pdev:	The PCI device associated with the zdev if any, NULL otherwise
  * @operation:	A string representing the operation reported
  * @status:	A string representing the status of the operation
  *
@@ -103,15 +104,15 @@ static struct debug_view debug_log_view = {
  *
  * Return: 0 on success an error code < 0 otherwise.
  */
-int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status)
+int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
+		       const char *operation, const char *status)
 {
 	struct zpci_report_error *report;
 	struct pci_driver *driver = NULL;
-	struct pci_dev *pdev = NULL;
 	char *buf, *end;
 	int ret;
 
-	if (!zdev || !zdev->zbus)
+	if (!zdev)
 		return -ENODEV;
 
 	/* Protected virtualization hosts get nothing from us */
@@ -121,8 +122,6 @@ int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char
 	report = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!report)
 		return -ENOMEM;
-	if (zdev->zbus->bus)
-		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
 	if (pdev)
 		driver = to_pci_driver(pdev->dev.driver);
 
diff --git a/arch/s390/pci/pci_report.h b/arch/s390/pci/pci_report.h
index e08003d51a97..dd7b0b05001c 100644
--- a/arch/s390/pci/pci_report.h
+++ b/arch/s390/pci/pci_report.h
@@ -8,9 +8,11 @@
  */
 #ifndef __S390_PCI_REPORT_H
 #define __S390_PCI_REPORT_H
+#include <linux/pci.h>
 
 struct zpci_dev;
 
-int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char *status);
+int zpci_report_status(struct zpci_dev *zdev, struct pci_dev *pdev,
+		       const char *operation, const char *status);
 
 #endif /* __S390_PCI_REPORT_H */

