Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B044D990F
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618534; cv=none; b=N/DKJ/LDapjBvvv5m8RPg+snHTlgn41qJoXacKxi4JvPQifPY0CanH2JPLrEaebQ6VofsJWVZK0Nc2te3FVlN6aFtZOq5EmPUGSYEwCz6P8KA9eFIcf6y6BkL3MHSzmoBmGbVJv1SMbJ3RzYiPDGu6jQm7jH6RShwO5l5GbM9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618534; c=relaxed/simple;
	bh=vPXv48c+nmQAB6+X0Yi/uRJEuInpinBBJ4C0JE4r6Cc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qi5pKT032dQcTpI4JEHn0q3+KKZDpUNB0h96lmxgKdXURUdMIHOutnALpLROEF1I2rEz08taslCxv8JTErVMRVhvq/6rpt4MlKm/ZssFcvUREDYRrSjGtbQlFhQVpO9hwD2ontdoIIcmVim2DRT8Kav4DKe2PcDI0au1bqnyues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/PbKbH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/PbKbH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531D71F00A3A;
	Thu,  9 Jul 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783618532;
	bh=CJD8T8kX6fRDutdxSTePZFsHQ9XkZr+r3+KwjGjpG+0=;
	h=Subject:To:Cc:From:Date;
	b=q/PbKbH3H1DNhFPjlfPKeq8A75eqSdHjo9ANoIBsFmU5JhLGzdM/OHJYqiR8YrNHI
	 aNEOXLKv/seD+Aj6LZDjpzk1ZbOaEtIut9KVaZaiaTQfENea97ftpmA1R1rT/BtEfA
	 npevl+xMrpcfQh91ulpBKxNwolhz9l3WIqhOMw6M=
Subject: FAILED: patch "[PATCH] ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup" failed to apply to 5.15-stable tree
To: rafael.j.wysocki@intel.com,dave.jiang@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 19:35:18 +0200
Message-ID: <2026070918-egotistic-sculptor-67ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 38bf27511ef41bffebd157ec3eba41fc89ba59cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070918-egotistic-sculptor-67ad@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38bf27511ef41bffebd157ec3eba41fc89ba59cd Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 3 Jun 2026 19:57:02 +0200
Subject: [PATCH] ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup

If acpi_nfit_init() fails after adding the acpi_desc object to the
acpi_descs list, that object is never removed from that list because
the acpi_nfit_shutdown() devm action is not added for the NFIT device
in that case.  Next, the acpi_nfit_init() failure causes
acpi_nfit_probe() to fail, the acpi_desc object is freed, and a
dangling pointer is left behind in the acpi_descs.  Any subsequent
ACPI Machine Check Exception will trigger nfit_handle_mce() which
iterates over acpi_descs and so a use-after-free will occur.

Moreover, if acpi_nfit_probe() returns 0 after installing a notify
handler for the NFIT device and without allocating the acpi_desc
object and setting the NFIT device's driver data pointer, the
acpi_desc object will be allocated by acpi_nfit_update_notify()
and acpi_nfit_init() will be called to initialize it.  Regardless
of whether or not acpi_nfit_init() fails in that case, the
acpi_nfit_shutdown() devm action is not added for the NFIT device
and acpi_desc is never removed from the acpi_descs list.  If the
acpi_desc object is freed subsequently on driver removal, any
subsequent ACPI MCE will lead to a use-after-free like in the
previous case.

To address the first issue mentioned above, make acpi_nfit_probe()
call acpi_nfit_shutdown() directly on acpi_nfit_init() failures and
to address the other one, add a remove callback to the driver and
make it call acpi_nfit_shutdown().  Also, since it is now possible to
pass NULL to acpi_nfit_shutdown() or the acpi_desc object passed to it
may not have been initialized, add checks against NULL for acpi_desc and
its nvdimm_bus field to that function and make acpi_nfit_unregister()
clear the latter after unregistering the NVDIMM bus.

Fixes: a61fe6f7902e ("nfit, tools/testing/nvdimm: unify common init for acpi_nfit_desc")
Fixes: fbabd829fe76 ("acpi, nfit: fix module unload vs workqueue shutdown race")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/1963615.tdWV9SEqCh@rafael.j.wysocki

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 8024cd3cad14..01c73be0bd00 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3069,6 +3069,8 @@ static void acpi_nfit_unregister(void *data)
 	struct acpi_nfit_desc *acpi_desc = data;
 
 	nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
+	/* The nvdimm_bus object may have been freed, so clear the pointer. */
+	acpi_desc->nvdimm_bus = NULL;
 }
 
 int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
@@ -3301,7 +3303,10 @@ static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 void acpi_nfit_shutdown(void *data)
 {
 	struct acpi_nfit_desc *acpi_desc = data;
-	struct device *bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
+	struct device *bus_dev;
+
+	if (!acpi_desc || !acpi_desc->nvdimm_bus)
+		return;
 
 	/*
 	 * Destruct under acpi_desc_lock so that nfit_handle_mce does not
@@ -3316,6 +3321,7 @@ void acpi_nfit_shutdown(void *data)
 	mutex_unlock(&acpi_desc->init_mutex);
 	cancel_delayed_work_sync(&acpi_desc->dwork);
 
+	bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
 	/*
 	 * Bounce the nvdimm bus lock to make sure any in-flight
 	 * acpi_nfit_ars_rescan() submissions have had a chance to
@@ -3388,9 +3394,14 @@ static int acpi_nfit_probe(struct platform_device *pdev)
 				sz - sizeof(struct acpi_table_nfit));
 
 	if (rc)
-		return rc;
+		acpi_nfit_shutdown(acpi_desc);
 
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+	return rc;
+}
+
+static void acpi_nfit_remove(struct platform_device *pdev)
+{
+	acpi_nfit_shutdown(platform_get_drvdata(pdev));
 }
 
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
@@ -3474,6 +3485,7 @@ MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 
 static struct platform_driver acpi_nfit_driver = {
 	.probe = acpi_nfit_probe,
+	.remove = acpi_nfit_remove,
 	.driver = {
 		.name = "acpi-nfit",
 		.acpi_match_table = acpi_nfit_ids,

