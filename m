Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E833EC81D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362526; cv=none; b=QzfX29vZDE1pxbV/+rYAExyDPKDXDUkwNzUCRYwj1HzhUqRr790uzUt/rm8Rd5RcXqcPfxxb7wi7h6B40E8lJq+fmtw7cJi2X8MgAKaJ1oK9VwnI160pHNg6jPRVrb5oMrfptPN6zBMu23yWbwcod51ZgMZDS6oD0HX9kVv5G+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362526; c=relaxed/simple;
	bh=UJYV9jKzD6fq79j0FhXaUcFAQuMr/lNw+Sn7eMQ1VGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh0c5U21DIYNlAdpAViBaqkphdQjhJzTs3tf3eYM3bdehuXp3IlfWIjN4LwUFvTAJNtjTowCO6DZkMRBIFl6yTjIaaSNfBjXqgkp2aI1ukjPWRXz+pdpjn81bl2TcGXUXJ1SmgdyOGqyEMMZ0s51GXmTor50RR4+ccv4AuRxu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdoWUcLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdoWUcLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D398C1F0089E;
	Wed,  7 Oct 2026 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362522;
	bh=d26+SX7ebLdLlTbo/ba7C/ExaO14Pkjnx4HMD94zuEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdoWUcLH3VPaVCOUAvVT5OzSeQLix5XE+fgWgwZdsXlyy+lCksjRyPRc1hgbMzXl+
	 8lGkH3h1ReThBuTFup0lQS2/Jv9ErRf5GbkHNK2XNJZcwVi1VO5/5mY+2c3/lVEQYa
	 m9Zyw/uChYV8uHavQ/c+k0eyIUuZZnF5n/MumFz+zrd4nYvalLzxCMP/09T/YlEasU
	 58J2UDAkg33h+DwmYO8VW4EcWhiKO3IJH7hbF6e+C2ZVZtrrGJgJiM57pvza+dBlIs
	 u64njxHvIW91x4Zc3K5kh+Qh1CyEdya1P2K+8cTt77JdwAYSq7qVcUm4/BfUg+cWv9
	 6ofeE81y0sa7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] iio: core: Add iio_read_acpi_mount_matrix() helper function
Date: Wed,  7 Oct 2026 04:41:54 -0400
Message-ID: <20261007083721.1749559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100618-wooing-curve-b2f5@gregkh>
References: <2026100618-wooing-curve-b2f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 02eae0bb9538dc7dcb5a6bc2c3066bd6ca682969 ]

The ACPI "ROTM" rotation matrix parsing code atm is already duplicated
between bmc150-accel-core.c and kxcjk-1013.c and a third user of this
is coming.

Add an iio_read_acpi_mount_matrix() helper function for this.
The 2 existing copies of the code are identical, except that
the kxcjk-1013.c has slightly better error logging.

To new helper is a 1:1 copy of the kxcjk-1013.c version, the only change
is the addition of a "char *acpi_method" parameter since some bmc150
dual-accel setups (360° hinges with 1 accel in kbd/base + 1 in display)
declare both accels in a single ACPI device with 2 different method names
for the 2 matrices. This new acpi_method parameter is not "const char *"
because the pathname parameter to acpi_evaluate_object() is not const.

The 2 existing copies of this function will be removed in further patches
in this series.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240425125754.76010-2-hdegoede@redhat.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: f0ea4824deeb ("iio: health: max30102: fix NULL dereference in interrupt handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/Makefile            |  1 +
 drivers/iio/industrialio-acpi.c | 85 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         | 13 +++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/iio/industrialio-acpi.c

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 0ba0e1521ba4f..cb80ef837e84f 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+industrialio-$(CONFIG_ACPI) += industrialio-acpi.o
 
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
new file mode 100644
index 0000000000000..981b75d407802
--- /dev/null
+++ b/drivers/iio/industrialio-acpi.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* IIO ACPI helper functions */
+
+#include <linux/acpi.h>
+#include <linux/dev_printk.h>
+#include <linux/iio/iio.h>
+#include <linux/sprintf.h>
+
+/**
+ * iio_read_acpi_mount_matrix() - Read accelerometer mount matrix info from ACPI
+ * @dev:		Device structure
+ * @orientation:	iio_mount_matrix struct to fill
+ * @acpi_method:	ACPI method name to read the matrix from, usually "ROTM"
+ *
+ * Try to read the mount-matrix by calling the specified method on the device's
+ * ACPI firmware-node. If the device has no ACPI firmware-node; or the method
+ * does not exist then this will fail silently. This expects the method to
+ * return data in the ACPI "ROTM" format defined by Microsoft:
+ * https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
+ * This is a Microsoft extension and not part of the official ACPI spec.
+ * The method name is configurable because some dual-accel setups define 2 mount
+ * matrices in a single ACPI device using separate "ROMK" and "ROMS" methods.
+ *
+ * Returns: true if the matrix was successfully, false otherwise.
+ */
+bool iio_read_acpi_mount_matrix(struct device *dev,
+				struct iio_mount_matrix *orientation,
+				char *acpi_method)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	char *str;
+	union acpi_object *obj, *elements;
+	acpi_status status;
+	int i, j, val[3];
+	bool ret = false;
+
+	if (!adev || !acpi_has_method(adev->handle, acpi_method))
+		return false;
+
+	status = acpi_evaluate_object(adev->handle, acpi_method, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		return false;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
+		dev_err(dev, "Unknown ACPI mount matrix package format\n");
+		goto out_free_buffer;
+	}
+
+	elements = obj->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_STRING) {
+			dev_err(dev, "Unknown ACPI mount matrix element format\n");
+			goto out_free_buffer;
+		}
+
+		str = elements[i].string.pointer;
+		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
+			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
+			goto out_free_buffer;
+		}
+
+		for (j = 0; j < 3; j++) {
+			switch (val[j]) {
+			case -1: str = "-1"; break;
+			case 0:  str = "0";  break;
+			case 1:  str = "1";  break;
+			default:
+				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
+				goto out_free_buffer;
+			}
+			orientation->rotation[i * 3 + j] = str;
+		}
+	}
+
+	ret = true;
+
+out_free_buffer:
+	kfree(buffer.pointer);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_read_acpi_mount_matrix);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 202e55b0a28b2..2241a87c990ad 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -756,6 +756,19 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 }
 #endif
 
+#ifdef CONFIG_ACPI
+bool iio_read_acpi_mount_matrix(struct device *dev,
+				struct iio_mount_matrix *orientation,
+				char *acpi_method);
+#else
+static inline bool iio_read_acpi_mount_matrix(struct device *dev,
+					      struct iio_mount_matrix *orientation,
+					      char *acpi_method)
+{
+	return false;
+}
+#endif
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
-- 
2.53.0

