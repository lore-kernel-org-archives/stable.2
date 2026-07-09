Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39130567C
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618545; cv=none; b=nxH/us5dhEhseo3JGImCQTdLfLlZJSzYHPjE3bGljNSVwscDyDzfzGaErxjHkvW1IEFeox3REug81SdSSw/y0LtpP/VFmWjS5OFiMU7vkIJjhLVxd6UrV2sYcXv/CwFdtIEgzjjuG2xvAR1t3JvEi11KR4MgqfKuW9TxXWENYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618545; c=relaxed/simple;
	bh=Veq1KMzs7NLYVyVYadYaQ9MkRzoDEBMFh3KQmbNWRNk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lUTAYT/d71jYswBJh1V+GzDJ50cshuvUuyP6tcMbnb85JbhvRaS14ZiRFmQupbowgjQrCnNM8tYdZEbmEOCO9F+NNa66yD64zjleddkL2eeaN+ADIwf9jMRy0lMbNmSIwZL5CgTnJclp9SuL4q/16asRH3ISjAh/857aZiVSpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eOBr2tom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eOBr2tom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9017A1F000E9;
	Thu,  9 Jul 2026 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783618544;
	bh=O77EHXhc+DL8jVE2ifQToa2dzf2shALW2LzrFQmefw0=;
	h=Subject:To:Cc:From:Date;
	b=eOBr2toma2oE/2vGcTxVQY4mmDeGyKFUcYwtVwMY8mEns08TLw0K53S7Wmg3rE71p
	 3NhCiffiqbiH1xGc+/PsJaBwmusEni/tRjR80swqdcX+SUcctP2EheGlJuur1n6DNl
	 7VKYJ/BeaUelffEtByyQUiNpWzKHJjc8eow/ySMI=
Subject: FAILED: patch "[PATCH] ACPI: NFIT: core: Fix possible deadlock and missing" failed to apply to 6.6-stable tree
To: rafael.j.wysocki@intel.com,dave.jiang@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 19:35:32 +0200
Message-ID: <2026070932-overdress-unsaved-5212@gregkh>
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
git cherry-pick -x 18a00ed0e718473f5c3fcfa49df46c944575e60c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070932-overdress-unsaved-5212@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18a00ed0e718473f5c3fcfa49df46c944575e60c Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 3 Jun 2026 19:58:23 +0200
Subject: [PATCH] ACPI: NFIT: core: Fix possible deadlock and missing
 notifications

After commit 9b311b7313d6 ("ACPI: NFIT: Install Notify() handler before
getting NFIT table"), ACPI NFIT driver removal may deadlock if an ACPI
notify on the NFIT device is triggered concurrently.  A similar deadlock
may occur if an ACPI notify on the NFIT device is triggered during a
failing driver probe.

The deadlock is possible because acpi_dev_remove_notify_handler() calls
acpi_os_wait_events_complete() after removing the notify handler and the
driver core invokes it under the NFIT platform device lock which is also
acquired by acpi_nfit_notify().  Thus acpi_os_wait_events_complete() may
be waiting for acpi_nfit_notify() to complete, but the latter may not be
able to acquire the device lock which is being held by the driver core
while the former is being executed.

Moreover, after commit 03667e146f81 ("ACPI: NFIT: core: Convert the
driver to a platform one"), there are no sysfs notifications regarding
NVDIMM devices because __acpi_nvdimm_notify() always bails out after
checking the driver data pointer of the device's parent.  That parent
is the ACPI companion of the platform device used for driver binding,
so its driver data pointer is always NULL after the commit in question
which was overlooked by it.

A remedy for the deadlock is to use a special separate lock for ACPI
notify synchronization with driver probe and removal instead of the
device lock of the NFIT device, while a remedy for the second issue
is to populate the driver data pointer of the NFIT device's ACPI
companion when the driver is ready to operate, so do both these things.
However, since the new lock is not held across the entire teardown and
acpi_nfit_notify() should do nothing when teardown is in progress, make
it check the driver data pointer of the NFIT device's ACPI companion, in
analogy with the existing check in __acpi_nvdimm_notify(), and bail out
if that pointer is NULL.

Fixes: 9b311b7313d6 ("ACPI: NFIT: Install Notify() handler before getting NFIT table")
Fixes: 03667e146f81 ("ACPI: NFIT: core: Convert the driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org> # 9995e4404ea4: ACPI: NFIT: core: Eliminate redundant local variable
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/3420096.aeNJFYEL58@rafael.j.wysocki

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index aaa84ae7a20e..cb771d9cadb2 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -56,6 +56,8 @@ MODULE_PARM_DESC(force_labels, "Opt-in to labels despite missing methods");
 LIST_HEAD(acpi_descs);
 DEFINE_MUTEX(acpi_desc_lock);
 
+DEFINE_MUTEX(acpi_notify_lock);
+
 static struct workqueue_struct *nfit_wq;
 
 struct nfit_table_prev {
@@ -1708,9 +1710,15 @@ static void acpi_nvdimm_notify(acpi_handle handle, u32 event, void *data)
 	struct acpi_device *adev = data;
 	struct device *dev = &adev->dev;
 
-	device_lock(dev->parent);
+	/*
+	 * Locking is needed here for synchronization with driver probe and
+	 * removal and the parent's driver data pointer is NULL when teardown
+	 * is in progress (while the parent here is expected to be the ACPI
+	 * companion of the platform device used for driver binding).
+	 */
+	guard(mutex)(&acpi_notify_lock);
+
 	__acpi_nvdimm_notify(dev, event);
-	device_unlock(dev->parent);
 }
 
 static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
@@ -3156,11 +3164,10 @@ EXPORT_SYMBOL_GPL(acpi_nfit_init);
 static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-	struct device *dev = acpi_desc->dev;
 
-	/* Bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
-	device_lock(dev);
-	device_unlock(dev);
+	/* Bounce the notify lock to flush acpi_nfit_probe / acpi_nfit_notify */
+	mutex_lock(&acpi_notify_lock);
+	mutex_unlock(&acpi_notify_lock);
 
 	/* Bounce the init_mutex to complete initial registration */
 	mutex_lock(&acpi_desc->init_mutex);
@@ -3292,10 +3299,17 @@ static void acpi_nfit_put_table(void *table)
 static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct device *dev = data;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 
-	device_lock(dev);
-	__acpi_nfit_notify(dev, handle, event);
-	device_unlock(dev);
+	/*
+	 * Locking is needed here for synchronization with driver probe and
+	 * removal and the ACPI companion's driver data pointer is NULL when
+	 * teardown is in progress.
+	 */
+	guard(mutex)(&acpi_notify_lock);
+
+	if (dev_get_drvdata(&adev->dev))
+		__acpi_nfit_notify(dev, handle, event);
 }
 
 void acpi_nfit_shutdown(void *data)
@@ -3337,11 +3351,18 @@ static int acpi_nfit_probe(struct platform_device *pdev)
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_nfit_desc *acpi_desc;
 	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_table_header *tbl;
 	acpi_status status = AE_OK;
 	acpi_size sz;
 	int rc = 0;
 
+	/*
+	 * Prevent acpi_nfit_notify() from progressing until the probe is
+	 * complete in case there is a concurrent event to process.
+	 */
+	guard(mutex)(&acpi_notify_lock);
+
 	rc = devm_acpi_install_notify_handler(dev, ACPI_DEVICE_NOTIFY,
 					      acpi_nfit_notify, dev);
 	if (rc)
@@ -3357,6 +3378,11 @@ static int acpi_nfit_probe(struct platform_device *pdev)
 		 * data in the format of a series of NFIT Structures.
 		 */
 		dev_dbg(dev, "failed to find NFIT at startup\n");
+		/*
+		 * Let acpi_nfit_update_notify() run in case it will need to
+		 * allocate the acpi_desc object.
+		 */
+		dev_set_drvdata(&adev->dev, dev);
 		return 0;
 	}
 
@@ -3374,7 +3400,7 @@ static int acpi_nfit_probe(struct platform_device *pdev)
 	acpi_desc->acpi_header = *tbl;
 
 	/* Evaluate _FIT and override with that if present */
-	status = acpi_evaluate_object(ACPI_HANDLE(dev), "_FIT", NULL, &buf);
+	status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
 	if (ACPI_SUCCESS(status) && buf.length > 0) {
 		union acpi_object *obj = buf.pointer;
 
@@ -3391,14 +3417,27 @@ static int acpi_nfit_probe(struct platform_device *pdev)
 				+ sizeof(struct acpi_table_nfit),
 				sz - sizeof(struct acpi_table_nfit));
 
-	if (rc)
+	if (rc) {
 		acpi_nfit_shutdown(acpi_desc);
+		return rc;
+	}
 
-	return rc;
+	/*
+	 * Let notify handlers operate (the actual value of the ACPI companion's
+	 * driver data pointer does not matter here so long as it is not NULL).
+	 */
+	dev_set_drvdata(&adev->dev, dev);
+	return 0;
 }
 
 static void acpi_nfit_remove(struct platform_device *pdev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+
+	guard(mutex)(&acpi_notify_lock);
+
+	/* Make notify handlers bail out early going forward. */
+	dev_set_drvdata(&adev->dev, NULL);
 	acpi_nfit_shutdown(platform_get_drvdata(pdev));
 }
 

