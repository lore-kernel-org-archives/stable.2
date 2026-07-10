Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6C392C24
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714001; cv=none; b=qaW7Q7cR1f3R2Obb0TTpfRI3PJLX33CA9mf4xGYN2ys+SLl498eBtswrttox22c77Hy8TjV5DYNvqwZVTufGA2LIyGVr0fcnR8oNybdsa/iDHPaTdhk5ZzbMT+ivKDM6lwjuRJV8te1khhXNkQHUPgBfCc0m09yNYlxv1LezDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714001; c=relaxed/simple;
	bh=cEgiLm2JpNPkVFEwLkSfbB0NphkhW+xmPJJR7ZBt89M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMeCv4iw1yB4GoRn3TKVaEPX7OTeQU/NIS7EsjIkRnXAfkmEH189WmYLng5Rtwr2VJtD5qBpBZ3x6X7HGCue/xxvjurw2I6kNAP4+w6SVD9RWP2JS2sQt5DqqYnPKqlHs5vkAIQDogDGeuUDLd94QTGI7cC0CS6wwVzfXH/JxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP09M30Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP09M30Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158521F00A3E;
	Fri, 10 Jul 2026 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783713999;
	bh=pREjtRrho7yA4rKyF5i/d3fhcB0ANCJYMbUK3Y6NNVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VP09M30YuWqJZOmjU6MTvnu2ggsQWMbbp+oYnqjs1MTs8VVh9bmnfLrdygIAObenW
	 n/FI8uGgVoDMrYtck8yIuzy59N2FIfSc0+ADzduhVk9JV5yTnHnLGxVDCJR2J/1lqQ
	 lA5Y3NycXvIhAbNJlc8GyZxZMyRrlFWn3ApEHBVGfPtBeQZuiWHzQWG2NRcvBrXQZw
	 8gVw89VO2AhXwG5m3hFCss12CWMyIiAcxbZ84JF6lFMWHYKy3s0zaFEczCbORfNSzQ
	 sxsgTy7LPXOprPO9xwTvUrnB5PCWREF0/x5ColpXYhG4rOmPK17c5WohZm6TRxg0hN
	 Wz49pCDDkWPAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
Date: Fri, 10 Jul 2026 16:06:34 -0400
Message-ID: <20260710200635.395836-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710200635.395836-1-sashal@kernel.org>
References: <2026070932-overdress-unsaved-5212@gregkh>
 <20260710200635.395836-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 38bf27511ef41bffebd157ec3eba41fc89ba59cd ]

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
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 562fee47cde32b..6255f535464e24 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3067,6 +3067,8 @@ static void acpi_nfit_unregister(void *data)
 	struct acpi_nfit_desc *acpi_desc = data;
 
 	nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
+	/* The nvdimm_bus object may have been freed, so clear the pointer. */
+	acpi_desc->nvdimm_bus = NULL;
 }
 
 int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
@@ -3299,7 +3301,10 @@ static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
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
@@ -3314,6 +3319,7 @@ void acpi_nfit_shutdown(void *data)
 	mutex_unlock(&acpi_desc->init_mutex);
 	cancel_delayed_work_sync(&acpi_desc->dwork);
 
+	bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
 	/*
 	 * Bounce the nvdimm bus lock to make sure any in-flight
 	 * acpi_nfit_ars_rescan() submissions have had a chance to
@@ -3386,9 +3392,14 @@ static int acpi_nfit_add(struct acpi_device *adev)
 				sz - sizeof(struct acpi_table_nfit));
 
 	if (rc)
-		return rc;
+		acpi_nfit_shutdown(acpi_desc);
 
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+	return rc;
+}
+
+static void acpi_nfit_remove(struct acpi_device *adev)
+{
+	acpi_nfit_shutdown(dev_get_drvdata(&adev->dev));
 }
 
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
@@ -3472,6 +3483,7 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ids = acpi_nfit_ids,
 	.ops = {
 		.add = acpi_nfit_add,
+		.remove = acpi_nfit_remove,
 	},
 };
 
-- 
2.53.0

