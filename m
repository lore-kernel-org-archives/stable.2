Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FF3290A5
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713999; cv=none; b=YEwSthQc8YKQU2332rsTXksfmSzoP+qqeuAkxu9q3rGxE/mWN+Smskw54UD+3P5a3uCrmp8lJL22oy2gRm+81+nZ5q3u2+TGoO8cqt7E9k455GNu8IwYqWHyg/wi2TZkrOODg93ipt7GoaxcFz3Xxt+/xv9yS+bYPhy3YOQvikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713999; c=relaxed/simple;
	bh=uIilu8s7l+OC2AWkE8qq97FOc5TRoYoW9JvOhf50va4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDu5f2C+dqarPS0nQ82/Zw41vvPh2Rot/X+GK0BCDQN56Kq1ZGAwm+0cTD7PKIBD33Q3c2/pmaQtn8XklFdIr9gAb5u0acxYCLEWIZ7aGL4ax31ImmI0XlVLAn8HoMuhA/UY1edNou7o3HwM4K91DQdGCLSZNoPQR7l/hSmEUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY9JxGzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY9JxGzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C7A1F000E9;
	Fri, 10 Jul 2026 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783713998;
	bh=gpxVVi1R6gzEi70uACPtZa/WzY70Fmvej/Lyyz29maU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fY9JxGzZmNU3KjBnNIPY/6hT7JGeYOmqnG4lJfuLCR8XuwVvMzAuMm6LxpkhOgTYv
	 yC2e7zinFkvYUE+90AEDIoBWMvK9pinvLdtGqFeLrMmVCSSfGrVkrNXIEz2289zSW8
	 X3AiWv7E2si7lfkgEI1Cl/z/uEcLlJ0raZDHMpqE66fHPwpK0cwQ7o1FMxcWNXKdpn
	 IGo0z0uAwjRLul/M40/dWv/SuqBblBxo9daooKlSIXFjlHcPt2vQJ5lgfagSdKxPfu
	 jRsQxt9FU6Nyfqm1wDm6ImS9s7+xyOK3IQfcpBb4mHUSE2bYwlwAzy/qUz2nn75fQW
	 Ckpsd8NIML37w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] ACPI: bus: Introduce devm_acpi_install_notify_handler()
Date: Fri, 10 Jul 2026 16:06:32 -0400
Message-ID: <20260710200635.395836-2-sashal@kernel.org>
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

[ Upstream commit ca70ce555a1eb8edf5fb1d5575f1fe19c9ae17f4 ]

Introduce devm_acpi_install_notify_handler() for installing an ACPI
notify handler managed by devres that will be removed automatically on
driver detach.

It installs the notify handler on the device object in the ACPI
namespace that corresponds to the owner device's ACPI companion, if
present (an error is returned if the owner device doesn't have an ACPI
companion).

Currently, there is no way to manually remove the notify handler
installed by it because none of its users brought on subsequently
will need to do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ rjw: Kerneldoc comment refinement ]
Link: https://patch.msgid.link/2268031.irdbgypaU6@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/bus.c      | 70 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  2 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 645464f02363f3..9d2301b75898a3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -578,6 +578,76 @@ void acpi_dev_remove_notify_handler(struct acpi_device *adev,
 }
 EXPORT_SYMBOL_GPL(acpi_dev_remove_notify_handler);
 
+struct acpi_notify_handler_devres {
+	acpi_notify_handler handler;
+	u32 handler_type;
+	struct acpi_device *adev;
+};
+
+static void devm_acpi_notify_handler_release(struct device *dev, void *res)
+{
+	struct acpi_notify_handler_devres *dr = res;
+
+	acpi_dev_remove_notify_handler(dr->adev, dr->handler_type,
+				       dr->handler);
+}
+
+/**
+ * devm_acpi_install_notify_handler - Install an ACPI notify handler for a
+ * 				      managed device
+ * @dev: Device to install a notify handler for
+ * @handler_type: Type of the notify handler
+ * @handler: Handler function to install
+ *
+ * This function performs the same function as acpi_dev_install_notify_handler()
+ * called for the ACPI companion of @dev with the same @handler_type and
+ * @handler arguments, but the ACPI notify handler installed by it will be
+ * automatically removed on driver detach.
+ *
+ * Callers should ensure that all resources used by @handler have been allocated
+ * prior to invoking this function, in which case those resources should be
+ * devres-managed so that they won't be released before the notify handler
+ * removal.  Otherwise, special synchronization between @handler and the
+ * management of those resources is required.
+ *
+ * When the request fails, an error message is printed.  Don't add extra error
+ * messages at the call sites.
+ *
+ * Return: 0 on success or a negative error number.
+ */
+int devm_acpi_install_notify_handler(struct device *dev, u32 handler_type,
+				     acpi_notify_handler handler)
+{
+	struct acpi_notify_handler_devres *dr;
+	struct acpi_device *adev;
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev && dev->bus == &acpi_bus_type)
+		adev = to_acpi_device(dev);
+
+	if (!adev)
+		return dev_err_probe(dev, -ENODEV, "No ACPI companion in %s()\n", __func__);
+
+	dr = devres_alloc(devm_acpi_notify_handler_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = acpi_dev_install_notify_handler(adev, handler_type, handler);
+	if (ret) {
+		devres_free(dr);
+		return dev_err_probe(dev, ret, "Failed to install an ACPI notify handler\n");
+	}
+
+	dr->handler = handler;
+	dr->handler_type = handler_type;
+	dr->adev = adev;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_acpi_install_notify_handler);
+
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
 
 #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d9c20ae23b6326..fea9ff235f074f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -521,6 +521,8 @@ int acpi_dev_install_notify_handler(struct acpi_device *adev,
 void acpi_dev_remove_notify_handler(struct acpi_device *adev,
 				    u32 handler_type,
 				    acpi_notify_handler handler);
+int devm_acpi_install_notify_handler(struct device *dev, u32 handler_type,
+				     acpi_notify_handler handler);
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
-- 
2.53.0

