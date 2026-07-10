Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05743801A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700090; cv=none; b=thA1n8H0nJ13uPZddXLvesOSxK9ySMzWwZlJk7fdOXJF/XHdnU+CIgv2eP6sa2lgjUifWtuvLsOhlcGzPNsB2ipz2ojvTrVwuYrAzkfH+Lv0NT/FG6Oq0ATBwuy+edTH+CK9zT9WKaNlz4Zv4YfALbCO4iBfyqM70W/eB/uT6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700090; c=relaxed/simple;
	bh=+T5M86XLLVkzu4gUwDiiitrwAZBuEcwZ8H2RDpTQIQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoYaDTLcVpH8cHwpOEg5yHr3znHRgUnfO+JvWE8Aht6RLL19f9aivkg2cwtPeAyNE5CMR//af93cf4pZafqTHFRQJtZAFGngKcpm5TPNVSedhJ+ugu+E2JY3iNg94ZRyFbqBeB71YMC18mUccfmHxAFBUKZF+4CNxU9DOhiNbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi4l9BpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi4l9BpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA921F00A3F;
	Fri, 10 Jul 2026 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700086;
	bh=EDB1mFFFdN1GyDLiqN4AUUMVYQA/5zE51b5wEkk5Is8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gi4l9BpEscCHMp/dA2fHQMgb6YzZJKYjHBI+lnwDi5mez2rlWLL66gx5GSloE+gp7
	 FNSwBgP98KIl6rMsQLzUOlOjdfR5UTGWdU8EANibxDn/3Y2FFIorVqBBM13kDgaYIV
	 JIHTMzoeqp59hz/vGtim5MWV9botLZr6gwmKxNpjnMRI0Va2UHeA7gyMVapW4Ud2SX
	 GVTWF/HQm9qI5t5b+cOwODu+h3Le67IvP34hhTfE2VghnviEBtEkmrp5tDVqbkkm1e
	 6qKRMTISg1LpiIrYkLfc07quSoue85Dm8ZTpYRkXBpUQqJizJLjVgF2ClsxK8WL+2S
	 V/T8J2ELuE6mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
Date: Fri, 10 Jul 2026 12:14:41 -0400
Message-ID: <20260710161442.293558-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710161442.293558-1-sashal@kernel.org>
References: <2026070931-shakily-implicit-64be@gregkh>
 <20260710161442.293558-1-sashal@kernel.org>
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
index c00cb8661b0b52..dd7cd4b2152a57 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3061,6 +3061,8 @@ static void acpi_nfit_unregister(void *data)
 	struct acpi_nfit_desc *acpi_desc = data;
 
 	nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
+	/* The nvdimm_bus object may have been freed, so clear the pointer. */
+	acpi_desc->nvdimm_bus = NULL;
 }
 
 int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
@@ -3293,7 +3295,10 @@ static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
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
@@ -3308,6 +3313,7 @@ void acpi_nfit_shutdown(void *data)
 	mutex_unlock(&acpi_desc->init_mutex);
 	cancel_delayed_work_sync(&acpi_desc->dwork);
 
+	bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
 	/*
 	 * Bounce the nvdimm bus lock to make sure any in-flight
 	 * acpi_nfit_ars_rescan() submissions have had a chance to
@@ -3380,9 +3386,14 @@ static int acpi_nfit_add(struct acpi_device *adev)
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
@@ -3466,6 +3477,7 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ids = acpi_nfit_ids,
 	.ops = {
 		.add = acpi_nfit_add,
+		.remove = acpi_nfit_remove,
 	},
 };
 
-- 
2.53.0

